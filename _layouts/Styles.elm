module Styles exposing (styles, lBgColor, mdBgColor, dBgColor)

import Css exposing (..)
import Css.Global exposing (..)
import Css.Media as Media exposing (..)
import Html exposing (Html)
import Html.Styled


styles : Html msg
styles =
    let
        wideScreen =
            withMedia [ only screen [ Media.minWidth <| Css.px 1024 ] ]

        codeStyle =
            [ fontFamilies [ "JetBrains Mono, monospace", .value monospace ]
            ]
    in
    global
        [ body
            [ padding <| px 0
            , margin <| px 0
            , backgroundColor <| hex mdBgColor
            , Css.color <| hex dBgColor
            , fontFamilies [ "JetBrains Mono, monospace", "Open Sans", "Arial", .value sansSerif ]
            , fontSize <| Css.em 2
            , lineHeight <| Css.em 1.4
            , wideScreen [ fontSize <| Css.em 1 ]
            ]
        , a
            [ Css.color <| hex dBgColor
            , textDecoration none
            ]
        , code codeStyle
        , Css.Global.pre
            [ descendants
                [ code [ important <| overflowX Css.scroll ] ]
            ]
        , each [ h1, h2, h3, h4, h5, h6 ]
            -- [ fontFamilies [ "Proza Libre", "Helvetica", .value sansSerif ]
            [ fontFamilies [ "JetBrains Mono, monospace", "Proza Libre", "Helvetica", .value sansSerif ]
            , lineHeight <| Css.em 1.1
            , Css.color <| hex dBgColor
            ]
        , h1 [ fontSize <| Css.em 2.66667, marginBottom <| rem 2.0202 ]
        , h2 [ fontSize <| Css.em 2.0, marginBottom <| rem 1.61616 ]
        , h3 [ fontSize <| Css.em 1.33333, marginBottom <| rem 1.21212 ]
        , h4 [ fontSize <| Css.em 1.2, marginBottom <| rem 0.80808 ]
        , each [ h5, h6 ] [ fontSize <| Css.em 1.0, marginBottom <| rem 0.60606 ]
        , p [ margin3 auto auto (rem 1.5) ]
        , Css.Global.small [ fontSize <| pct 65 ]
        , class "header-logo"
            [ paddingTop <| px 6
            , textAlign center
            , backgroundColor <| hex ldBgColor
            , borderBottom3 (px 2) solid (hex dBgColor)
            , wideScreen [ textAlign left ]
            ]
        , class "navigation"
            [ textAlign right
            , borderBottom3 (px 2) solid (hex dBgColor)
            , backgroundColor <| hex ldBgColor
            , padding <| px 10
            , marginTop <| px -20
            , descendants
                [ ul
                    [ margin <| px 0
                    , padding <| px 0
                    , wideScreen [ lineHeight <| px 100 ]
                    ]
                , li
                    [ display inlineBlock
                    , marginRight <| px 20
                    ]
                , a [ Css.color <| hex dBgColor
                    , fontWeight <| (int 600)
                    ]
                ]
            , marginTop <| px 0, padding <| px 30
            , wideScreen [ marginTop <| px 0, padding <| px 0 ]
            ]
        , class "content"
            [ Css.maxWidth <| vw 100
            , descendants
                [ p [ descendants 
                        [
                            a [ fontWeight <| (int 600)
                            , textDecoration underline
                            , fontStyle italic
                            ]
                        ]
                    ]
                ]
            ]
        , class "footer"
            [ textAlign center
            , borderTop3 (px 2) solid (hex dBgColor)
            , backgroundColor <| hex ldBgColor
            , Css.color <| hex dBgColor
            , descendants
                [ a [ Css.color <| hex dBgColor, textDecoration none ]
                , svg [ paddingRight <| px 5, verticalAlign baseline ]
                ]
            , wideScreen
                [ lineHeight <| px 80
                , textAlign center
                , descendants
                    [ class "link"
                        [ display inlineBlock
                        , marginRight <| px 20
                        ]
                    ]
                ]
            ]
        , class "post-metadata"
            [ marginTop <| Css.em -0.5
            , marginBottom <| Css.em 2.0
            , descendants
                [ each [ a, span ]
                    [ display inlineBlock
                    , marginRight <| px 5
                    ]
                , a
                    [ border3 (px 1) solid (hex dBgColor)
                    , borderRadius <| px 3
                    , backgroundColor <| hex lBgColor
                    , Css.color <| hex dBgColor
                    , paddingLeft <| px 5
                    , paddingRight <| px 5
                    ]
                ]
            ]
        ]
        |> Html.Styled.toUnstyled

lBgColor : String
lBgColor = "F7F6E7"

mdBgColor : String
mdBgColor = "E7E6E1"

ldBgColor : String
ldBgColor = "FFCE45"

dBgColor : String
dBgColor = "1A374D"