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
            [ fontFamilies
                [ "JetBrains Mono, monospace", .value monospace ]
            , Css.color <| hex "ed143d"
            , backgroundColor <| hex "f0f0f0"
            , padding2 (px 1) (px 2)
            , lineHeight <| Css.em 1.4
            ]
    in
    global
        [ body
            [ padding <| px 0
            , margin <| px 0
            , backgroundColor <| hex mdBgColor
            , Css.color <| hex dBgColor
            , fontFamilies [ "Libre Baskerville", "Georgia", "Cambria", "Times New Roman", "Times", .value serif ]
            , fontSize <| Css.em 2
            , lineHeight <| Css.em 1.6
            , wideScreen 
                [ fontSize <| Css.em 1
                , lineHeight <| Css.em 1.8
                ]
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
            [ fontFamilies [ "Libre Baskerville", "Georgia", "Cambria", "Times New Roman", "Times", .value serif ]
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
            , margin2  (rem 4) (rem 0)
            , descendants
                [ p [ descendants 
                        [
                            a [ fontWeight <| (int 600)
                            , textDecoration underline
                            ]
                        ]
                    ]
                , li [ descendants 
                        [
                            a [ fontWeight <| (int 600)
                            , textDecoration underline
                            , overflowWrap breakWord
                            ]
                        ]
                    ]
                ]
            ]
        , class "footer"
            [ displayFlex
            , alignSelf flexEnd
            , textAlign center
            , justifyContent center
            , padding <| px 12
            , borderTop3 (px 2) solid (hex dBgColor)
            , backgroundColor <| hex ldBgColor
            , Css.color <| hex dBgColor
            , descendants
                [ a [ Css.color <| hex dBgColor, textDecoration none ]
                , svg [ paddingRight <| px 5, verticalAlign baseline ]
                ]
            , wideScreen
                [ lineHeight <| px 80
                , display inlineBlock
                , textAlign center
                , padding <| px 0
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
            , fontFamilies
                [ "JetBrains Mono, monospace", .value monospace ]
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