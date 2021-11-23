Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D546C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 07:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhKWHtn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:49:43 -0500
Received: from mail-am6eur05on2077.outbound.protection.outlook.com ([40.107.22.77]:15393
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234136AbhKWHtm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 02:49:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsJCspPLPpWgMbp63nJXhptaCL6c8wPAbxmPpp25buGy5SbeAKricmmyrKpJDJ0vllIZb6XlxeR8Z342DG7rMTtSCDCGXHruQ1OpVuxPGbtTqDVZhazfyqAiMZIrcr3nYwvjj/n1VXHApge+E62ICTJn3Puo7Jw1hfJALWMEtzgUT6u3ioGPFUC8JUA1RQCBjBZHgUccV1klQRShFz0SMY8cTxGSBd0jjn76UR87rEmAVpFWeH+gj5FKsbyCf5B67n8Ak36aW65gu5m3tK+3h4Q9jazC5zqvr/3K7e0wZ9w5/kqQGLrGLiCXMbONCiN5bCvHPCCfErCbf09+uYQWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clBo8+v7DU1lrdsobMaEI3t47qLJH05FudWKdIRtFRA=;
 b=gV05lNo5lqQGRgLl+sKjE3L8i1OHR0iKoA4u+k/TILuoYRCxxRwcV2x4hUI43Jz0Q27fEwuXSMQxf96S56DkkElJHWT3zPJt71drV0A56RfoTlQmgIEDQbvDzgvd/cztIEZPb40ZO3K9WlAUFhWF8p0NCm+AA/sJcfd0VGnltaArp6t4QzHc0F6k7aesrs5YA8e6h64auF0awDF3ys41O29at2+F1YDd3ViJ9I8oj87nyzgr0l0Rj/qkn1NDl3U7dEtOQBkKqQNXejg9nOWUm9lnv6e6d9vHbrYq4EGOGIUyVx0r3F//sgBHm+tAoZM1x0oeM7Us6AJGYGZ4yIVh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clBo8+v7DU1lrdsobMaEI3t47qLJH05FudWKdIRtFRA=;
 b=jmdtKb8WnHrOvhYp6UTGkL6ULW8iy/7gJ+JUl5CNSd7JtyDs/wgvEmSWrJErBEUmgcKcaT/tMcO/L8HNAK5BSDgOmsL1pPlU2zRwuuWJdCBkY3OMQ9ZaRwzQN6CKQ2mPOOEvZ3s0QK+7Qw7g2r7RFUCSzrDQrVuLrEKC3awHS3xZ42dYJMIl+MRCSI+C9ew89yL8FF/Ko8bvs8KWY/zqiv8QJVh+QAhSJzd0yb9pwGFC01uDCdZovEOQt0R8MCALMmRkuUTGQ8kDKT38iVuzwPav9uHv+yGEhDJFXUQkluflKLPA6xMW3nOKVQUqSEkFYnDnkwRKBe9GMvZUpLVLmg==
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:418::19)
 by AM0PR10MB2195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 07:46:31 +0000
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb]) by AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb%9]) with mapi id 15.20.4713.022; Tue, 23 Nov 2021
 07:46:31 +0000
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     Ian Rogers <irogers@google.com>
CC:     "debian-kernel@lists.debian.org" <debian-kernel@lists.debian.org>,
        "waldi@debian.org" <waldi@debian.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>,
        "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
Subject: RE: Getting the latest and greatest Linux perf features on every
 Debian kernel
Thread-Topic: Getting the latest and greatest Linux perf features on every
 Debian kernel
Thread-Index: AQHX149y2KafCifzNka8ZEqO5o/ybKv/9vaAgA7oRACAAKomQIAAS44AgAD01vA=
Content-Class: 
Date:   Tue, 23 Nov 2021 07:46:31 +0000
Message-ID: <AM9PR10MB486907ABFB7F82351A7D101589609@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
 <YY58idSor+lJ84KF@kernel.org>
 <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
 <AM9PR10MB4869A06EB83A4AC6DCA955EE899F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <CAP-5=fW-L8YS7gsNAjRkzUtBOCw2md+YWuOCbjVZHd7r=PLH_g@mail.gmail.com>
In-Reply-To: <CAP-5=fW-L8YS7gsNAjRkzUtBOCw2md+YWuOCbjVZHd7r=PLH_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-11-23T07:46:29Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=910c7143-b224-4de2-a79b-17add06ec82d;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6d26bef-12f1-4a27-0c0e-08d9ae555d9d
x-ms-traffictypediagnostic: AM0PR10MB2195:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: <AM0PR10MB219522BF25D6F51CBDC0BC4389609@AM0PR10MB2195.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXA+XPjKJMSPeprKirLa/1GE9zT7x5It1L2EZd1F6cc0GepWCOHelTRID0pPQHOIB9cKICIuLe6oaNRlOR5LkFectekCznt72vfKK2FwT81zci/l/K3U2xEDNzMKjcWtJ8l61mSyOP/cq7tnwF9COsYqn6QpHy9xx0f4UkKX1JDMZ3u2dUcIDM3t31ZJa+kn36SsdyT7nbj1wMl0hZfAl1N2oANydUbcaegL7RJLq1WGS2LpOp9L5uz9Z41hJija7IBudNRTkQjEnc+sl/hX4PtBUUWfrApvgaLtDkz8/ItufIMQpL/lckcChDkh2kEQi+jLRj2LmzcP9pTZuVfBMCDLtH1Rv5SJgrw0HDZfjs12nZY1qifUnK3tuRN7yfcltm1GG3+wM6OeBZuleuPxvOe/Ccu4wdXJlE4foDvM24Dlf20G3E6RE//cXF2KYUrLRU7dUAr9EJFPRVjRA0Y9sJJrZiQZlBotxIW/cOjGJVZqXNPzNezMHiCJ0NlfqFa1psp2qYG5SiDlxbbLexSpQq84jiMepFAGZtA+OSp5apYb1YhR5xYk1bvLOTxm6wyDxUTrrv8yFfUmC1OtMkr/ohvIEoZw1CdZ9MJv5vsnSKTtojxcR6Dy/fXAnk3K4kPClFjFzRvk1KAdT1gEX5cQqqinMPWc3ih+lhJqdUyZjl7/rEz4WtJbIbzyGa4wfenj1xc3feOnrO+ihMvYaFVjaROMSDo2BsBeV4l43iYvndJqdyqrEaQSYfacB89Zto0fs8O2JAA3vHzU8DypSKm6UOsowuqb9KCgxZu/GwogBD+jEYvI2pmSWD33vWJ6rBjomtCkMMWoR4kXw/x6wKqEjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(38100700002)(54906003)(122000001)(5660300002)(6506007)(45080400002)(38070700005)(53546011)(316002)(52536014)(4326008)(7696005)(6916009)(30864003)(82960400001)(83380400001)(33656002)(966005)(66556008)(508600001)(86362001)(2906002)(76116006)(186003)(66946007)(64756008)(26005)(66446008)(66476007)(8676002)(9686003)(8936002)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EMZvUun8gQm8XM1dD/KIQF94o1+hGY2P1vOEe4ofOFvNujWFfxbVSNHAZZUx?=
 =?us-ascii?Q?U7LTu1PdH0M2cEOSnb8Qlo5opu/eXMiboKY6FHy4TzSJtFdMj+7nmgsMAgYO?=
 =?us-ascii?Q?BeRLt71sSALMJZp5AXt7jNWK8BuvfCVe7aPvsWXsEQpQX2T4KxxbfxHFdTxm?=
 =?us-ascii?Q?sDTwDCpACJEZu1ZjmHWimZIq7nkZO/oeN+5A+cCw8Rx2Uq3wdkFbd4T2lrFo?=
 =?us-ascii?Q?pRsTf3kqxQwZZME8hKzLtqTlRidbg5ExNKi/v95em/1llnR/kQK7iW0uEfH4?=
 =?us-ascii?Q?vUBKCZRG2sdxI8xik7XX5eX3qZ1CWmTiDWZ/ec8a8O6iResENYAKaJ2ZKKkG?=
 =?us-ascii?Q?rRrzUoc200tEvjKOTsEJEHoVVrw4lNhm/Fv4h/izYwBPrd9txC/6F/0IxGnO?=
 =?us-ascii?Q?yFhgdppNCXwK8LRE5rQNr1VhuSo3jhwUQhR+0T5KNnG+IAh6UGmEgpzdfmZa?=
 =?us-ascii?Q?V3SfiTFpcXzTzdCBJYKP/3RbYD0/cEmCh919MuAKhxL3mpmTjYS7pm0J9VYl?=
 =?us-ascii?Q?LVHsYHAItpeH8APrcLHJsQkSWFHoGPnhoJ2JELZ5DhP9Yp3bVf6uRNUPGOml?=
 =?us-ascii?Q?duXEEmwWLunjpT4J0HHXHyRj7TOfVYf22jJVVX7Meq0unn8c5cQ/DS5Ztfjy?=
 =?us-ascii?Q?d9o1D9J7FxaJ4sW3vHj/rXmhiKNJL96y0VBZ/eyYozqUdvykkT89VKU0N0NY?=
 =?us-ascii?Q?q7ToZQCyykeJtAB92dRf2BcgPLQHH2cbPVpgNwtPbR7zxlV8mtGHSYS+hV5A?=
 =?us-ascii?Q?4wvrDfmnO4EX60NyObtLWZIfs4klJDfjLpVH8BgxavUtcWRrAR414UohvlF6?=
 =?us-ascii?Q?svzJoCDN2lbAGmVaGP7SycFXDtFp7kHPI/D/iS3n9MPjwXiY1r4YrirvhFJZ?=
 =?us-ascii?Q?dnzkHO2viRJSRKBuooqlm4KFvEpGBL2xv9N6JNC4NLqMWngpUAU+qRMPF2eb?=
 =?us-ascii?Q?H5lOI5iIavYOi0Zh34gA9pxnAPx5HsCYE48KfGvHw/zcX+J1nZnWPOOGGYmA?=
 =?us-ascii?Q?vmkoCC6vLd/D3kv337n1PlkLGoCiUQs0uIjxAMnlkRByy7EIx/MlD+l812B2?=
 =?us-ascii?Q?qWGitoMachBGNHlkAcR5YXIpo0VL0f047WEtXlxeMZfDI0DVS5oFpG9IW7sL?=
 =?us-ascii?Q?aOX6toTkJXbNtWO0BrlIvZ0lNpyN37RbPtshEjt7WTwkcWGWk6fOBTPio79A?=
 =?us-ascii?Q?AWl6zyuJZZpFu4zupcredn0JXGj0aWJV54NVLSYy4w02h340n0GO/1DkYB4n?=
 =?us-ascii?Q?pGc9h8ikdn+x0l89gOci6dvRUoMorXFt8oteESdSBMSMRcuw3BdZ7gasiTV7?=
 =?us-ascii?Q?4yVJevoOQ8xUOlk6CLpo0StXBtauGERBKkRd5vnJlg2JPxEgqOzVSeqfI2Yq?=
 =?us-ascii?Q?XX0Tc6LK9KWU8Xc5YufgMQ1G2c1TtUjq29a5yNJLAHS/RpWEOm+UzvnMa1YH?=
 =?us-ascii?Q?5Pwh1YWYfczBusvunnF3mA5Nm+2kJ+jBdLId9i2wNQ3Njpnz/plddWv27IQT?=
 =?us-ascii?Q?4nrGZ1vg45o1wxtpcPQyLWKWxTG2XEkAEDuxT4zu0LVtZ3JNWI/aledkX8Ts?=
 =?us-ascii?Q?71pATB7dQs4Li+yxEXR3wH6VRD9IgdnqIOA2dG8Z10biy0nxl7t0G86/mWCM?=
 =?us-ascii?Q?v8q7hDqsIL/WGT/k8AOBLVn7AUIiJnvlNNZWcmh1rY/EcCA4PrrW/ilXiwPS?=
 =?us-ascii?Q?uL8sog=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d26bef-12f1-4a27-0c0e-08d9ae555d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 07:46:31.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gs0lPwnW0EUVNhm1qoESnnI9V1iVTZS4JqovcDhId1YaohyeUjkd9TsbSd9MBJo8oyAX9aqOs9bUTLJhOFlcF6uVcLN9R76D0pyzfJUSVT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2195
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> -----Original Message-----
> From: Ian Rogers <irogers@google.com>
> Sent: Monday, November 22, 2021 5:57 PM
> To: Moessbauer, Felix (T RDA IOT SES-DE) <felix.moessbauer@siemens.com>
> Cc: debian-kernel@lists.debian.org; waldi@debian.org; linux-perf-users <l=
inux-
> perf-users@vger.kernel.org>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> ben@decadent.org.uk; Jiri Olsa <jolsa@kernel.org>; Namhyung Kim
> <namhyung@kernel.org>; Kiszka, Jan (T RDA IOT) <jan.kiszka@siemens.com>;
> Schild, Henning (T RDA IOT SES-DE) <henning.schild@siemens.com>; Schmidt,
> Adriaan (T RDA IOT SES-DE) <adriaan.schmidt@siemens.com>
> Subject: Re: Getting the latest and greatest Linux perf features on every=
 Debian
> kernel
>=20
> On Mon, Nov 22, 2021 at 4:54 AM Moessbauer, Felix
> <felix.moessbauer@siemens.com> wrote:
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Ian Rogers <irogers@google.com>
> > > Sent: Monday, November 22, 2021 3:18 AM
> > > To: debian-kernel@lists.debian.org; waldi@debian.org
> > > Cc: linux-perf-users <linux-perf-users@vger.kernel.org>; Arnaldo
> > > Carvalho de Melo <acme@kernel.org>; ben@decadent.org.uk; Jiri Olsa
> > > <jolsa@kernel.org>; Namhyung Kim <namhyung@kernel.org>
> > > Subject: Re: Getting the latest and greatest Linux perf features on
> > > every Debian kernel
> > >
> > > Hi,
> > >
> > > I'd love to package Linux perf as per Arnaldo's prepared tarball for
> > > Debian. If I could get help on the Debian side it would be great!
> > > The actions that are needed
> > > are:
> > >
> > > 1) package Arnaldo's tarball for Debian, presumably the build in the
> > > sources for
> > > linux-perf-5.10 will be a good starting point. The package will be
> > > linux-perf and replace the current metapackage of the same name.
> >
> > The current packaging in Debian does not include the perf python bindin=
gs.
> > Today these bindings are used by more and more tools (e.g. tuned).
> > For that, we packaged both a versioned module (linux-perf-<...>) and a =
python
> wrapper to load it using 'import perf' (linux-base).
> > These patches are currently under review at Debian salsa [1].
> >
> > All this would be way simpler if perf bindings do not have to be versio=
ned
> anymore.
> > But please also consider that still a lot of people are using 4.19er ke=
rnels (don't
> know since when versioning is no longer required).
>=20
> Thanks Felix! Is there a specific bug I can look at which describes what =
is broken
> with later versions of perf an 4.19? Perhaps we can add a workaround for =
this
> age of kernel in the command. It is certainly nobody's intent to have som=
e users
> without a workable tool. Fwiw, I do a lot of testing with an older 4.15 b=
ased
> kernel and I'm not aware of issues.

Actually I don't know of any bugs, but just wanted to point out that this k=
ernel should still be supported.
If that works with a modern perf out of the box, that would be even better.

> > >
> > >
> > > 2) create an updated linux-base that removes /usr/bin/perf
> > >
> > > 3) upload the updated linux-base and linux-perf packages for
> > > maintainer approval to
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmento=
rs.
> > >
> debian.net%2F&amp;data=3D04%7C01%7Cfelix.moessbauer%40siemens.com%7C
> > >
> 4dbf17b41e4542b4c2de08d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d5
> > >
> 5a%7C1%7C0%7C637731443001828013%7CUnknown%7CTWFpbGZsb3d8eyJWI
> > >
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> > >
> 0&amp;sdata=3D80jfnANxTuGYzw0vErMUQOlpdUWFrDNP5n9ktaVTBaQ%3D&amp
> > > ;reserved=3D0
> > >
> > > 4) some how get the previous Debian linux-perf-[45].* packages
> > > removed
> >
> > This can easily be achieved using the Conflicts field with a linux-base=
 version
> that is older than your patched one.
>=20
> Can I use Conflicts to say that the linux-perf package, that will provide
> /usr/bin/perf, will conflict with earlier linux-base releases?
> I'm concerned that if linux-base conflicts with linux-perf and linux-perf=
 conflicts
> with linux-base, it is quite easy to make something that becomes wedged :=
-)

For details, have a look here: https://www.debian.org/doc/debian-policy/ch-=
relationships.html#s-replaces
You could start with the packaging (as part of the Debian Linux source pack=
age) and create a MR at Salsa [1].
Then I can have a look over it and implement the transition / replacement.

[1] https://salsa.debian.org/kernel-team/linux

Felix
=20
>=20
> > >
> > > After this, when Arnaldo sends out a new tarball we can update the
> > > linux-perf package. libbpf and libtraceevent are currently part of
> > > linux/tools, but it would be better to depend on the distribution
> > > versions, which can be a future update to the packaging.
> > >
> > > I'd love some feedback on this plan, whether linux-base/linux-perf
> > > have a special process, etc. Documentation wise I've seen there is a =
lot, but:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmento=
rs.
> > > debian.net%2Fintro-
> > >
> maintainers%2F&amp;data=3D04%7C01%7Cfelix.moessbauer%40siemens.com%7
> > >
> C4dbf17b41e4542b4c2de08d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d
> > >
> 55a%7C1%7C0%7C637731443001828013%7CUnknown%7CTWFpbGZsb3d8eyJ
> > >
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> > >
> 3000&amp;sdata=3DY0L%2Bn%2B0yJqGVnp%2FhCfBVD9V3bZ%2Bffb48vy85jg92M
> > > oU%3D&amp;reserved=3D0
> > > looks fairly to the point.
> >
> > I really like the plan and I'm also willing to support here.
> > But please also note that I'm not a Debian sponsor or maintainer of the
> mentioned packages.
>=20
> Thanks!
> Ian
>=20
> > Felix
> >
> > >
> > > Thanks,
> > > Ian
> > >
> > >
> > >
> > > On Fri, Nov 12, 2021 at 6:39 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org>
> > > wrote:
> > > >
> > > > Em Thu, Nov 11, 2021 at 10:34:33PM -0800, Ian Rogers escreveu:
> > > > > Hi,
> > > >
> > > > > Debian currently tries to match the Linux perf tool to the
> > > > > version of the kernel that it is being run upon. Reaching out to
> > > > > Ben Hutchings, he explained to me that this was done back in
> > > > > 2010 due to kernel and Linux perf incompatibilities. This was
> > > > > likely the case, but it was a bug in the Linux perf tool that sho=
uld have
> been fixed.
> > > > > It is the goal of the tool to be backward compatible. A problem
> > > > > with matching the tool to the kernel version is that users miss
> > > > > out on new features and fixes (this topic came up in a recent
> > > > > interview of the maintainer Arnaldo Carvalho de Melo [1]).
> > > >
> > > > > Ben Hutchings informs me that making it so that Debian ships the
> > > > > latest Linux perf tool requires updates both to the linux-base
> > > > > and linux source packages. The Linux perf tool also has many
> > > > > other often optional dependencies, like libunwind, libbpf,
> > > > > libpfm4, libtraceevent, etc. In general, having the dependency
> > > > > will unlock more
> > > features.
> > > > > Linux tools has its own copies of libbpf and libtraceevent, and
> > > > > so these may pose some versioning issues.
> > > >
> > > > We can use LIBBPF_DYNAMIC=3D1 to use the distro libbpf-dev package,
> > > > which currently is going thru some growing pains as libbpf is 0.x,
> > > > with several APIs being deprecated, others renamed, and that has
> > > > been a source of friction, but should be past us with v1.0. Till
> > > > then the perf codebase is being adjusted to allow it to be
> > > > seamlessly built with the in-kernel version and with whatever libbp=
f-devel
> the distro has.
> > > >
> > > > > I think it'd be great to get Debian shipping the latest version
> > > > > of Linux perf for its users. Hopefully we can agree to change
> > > > > how Debian packages perf currently and then work out the best
> > > > > way to package and keep it up-to-date. I look forward to everyone=
's help
> and input.
> > > >
> > > > I also keep the tarballs available at:
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > mirr
> > > >
> > >
> ors.edge.kernel.org%2Fpub%2Flinux%2Fkernel%2Ftools%2Fperf%2F&amp;dat
> > > a=3D
> > > >
> > >
> 04%7C01%7Cfelix.moessbauer%40siemens.com%7C4dbf17b41e4542b4c2de08d
> > > 9ad5
> > > >
> > >
> e58c3%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637731443001
> > > 828013%
> > > >
> > >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > > I6Ik
> > > >
> > >
> 1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DA2TTg%2BElfRv9bslXw6YmEA1
> > > R8Iu08Z
> > > > hFyv6juVhRj24%3D&amp;reserved=3D0
> > > >
> > > > Where there are instructions on how to build this detached tarball.
> > > >
> > > > I regularly build perf on lots of distros, including:
> > > >
> > > >   debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1)=
 6.3.0 20170516 ,
> > > clang version 3.8.1-24 (tags/RELEASE_381/final)
> > > >   debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 ,=
 clang version 7.0.1-
> > > 8+deb10u2 (tags/RELEASE_701/final)
> > > >   debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1=
 20210110 ,
> Debian
> > > clang version 11.0.1-2
> > > >   debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.=
0 , Debian
> clang
> > > version 11.1.0-4
> > > >   debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debia=
n
> 11.2.0-9)
> > > 11.2.0
> > > >   debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 1=
0.2.1-6)
> > > 10.2.1 20210110
> > > >   debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (D=
ebian
> > > 10.2.1-6) 10.2.1 20210110
> > > >   debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian=
 11.2.0-
> 9)
> > > 11.2.0
> > > >
> > > > Ditto for ubuntu.
> > > >
> > > > A complete list can be found in each pull request I send to Linus,
> > > > see in the last one:
> > > >
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > lore
> > > > .kernel.org%2Fall%2F20211107204947.1394255-1-
> > > acme%40kernel.org%2F&amp;
> > > >
> > >
> data=3D04%7C01%7Cfelix.moessbauer%40siemens.com%7C4dbf17b41e4542b4c2
> > > de08
> > > >
> > >
> d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6377314
> > > 4300182
> > > >
> > >
> 8013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> > > iLCJBT
> > > >
> > >
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DfoKAv3e5lm5du1yoLqhzIVf
> > > vfc7
> > > > RkZqRAxmfTFkID9U%3D&amp;reserved=3D0
> > > >
> > > > Search for BUILD_TARBALL.
> > > >
> > > > There is also the output for 'make -C tools/perf build-test' that
> > > > tests building with lots of combinations of optional libraries,
> > > > for instance, with LIBBPF_DYNAMIC=3D1, etc.
> > > >
> > > > - Arnaldo
