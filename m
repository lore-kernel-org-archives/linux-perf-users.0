Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE1C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhKVM5v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:57:51 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:56388
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229983AbhKVM5v (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 07:57:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pli7QLk5mH349utN6v+RuZxNQ6Sj/ia/z36rXpMM8/eD5fDXagwgS2a4xmCUOB61kH+0KH+gcMfo7Il1WIF2quCKs+ilXPp3tGNGgmhhDQSa5h7hX35np7ZVLegHc1wUp0iaUiygWDbsfkN750oXKuXrxjrcnkOhFOE92V84r1DsB39DWBwD9CI/yhn3iijabrCVqYnYOcZYw/7qfaLeWo5336ShRqT0AhAYsyJy2uCG7Hmq3puY7RXkKyQBrtt7p2OnefUxYeYVYtzMvz1nfoIKNall5huNo30UFEzljtBMAyMJ4vvDbEZfkzMaq3WWcXoU7k/pmKY1hX75HtxPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETznf9FpujQH0CE6fwaXT1HNXpFLrqY0DZS0IKbbwCI=;
 b=NLF1BLqLoxyWR03B2JwvWA07r3LNCxC9JwzcBM8ekwoOHeVgTxthXZwhtQ1CYtiJATeJVoSPbCiBBmGHo8BCDwro/gnJUap9RsWExrzDewp87jdB5PeCq+UWG0eNHBA3+99rwCbYmyaryeFOaZDaEsrRjDEd9lbhd9Vh4WLnNn5F1QtyNjHVGf1eunLK/bfngnNUQdGR+S6mcxTLFxb+IU3dRlbGvtbTUpMddeUFZkQEdFHDaQMywip4+FRMcJcW2l8Omk70uNxix7xmg2wOhoI27bTCnNC62fmcEtKsVvQuGG5gTi3Ft5pJRjK/jYMgMVBCOMpISsOMMq+3KpOvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETznf9FpujQH0CE6fwaXT1HNXpFLrqY0DZS0IKbbwCI=;
 b=dymuKrElMYWGY4vM6WgG6RfRaLN/q3rg4UqNdEIq75SoPMlG+r3SlB/0yrp+F4sy2mh23zsMmMGNQdQEGyE5k8IaEIggMUscGSv7G5yquIYu9pA2noHmmo1FHSc18b0lJneLqA3iqsj1CD21vwOYTFJgClFAoTHEVUBWf1HNbm1O4muhlhdzGdkFI/JAwO/g3MCeA8XvFU/iZOQLJhbICz9al5CPz/edXR/AblRQP7Mx9J+ZdwHyrEbhqwQJ2UALuY0DMZkRM9l6IVLzuLCMOfNTthuEujDAw1RbBG7ELqL3/iw/Wrs1BOTwTK7ADYrwmp4OKP1pjN19W0wKbw20Zg==
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:418::19)
 by AM8PR10MB4017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 12:54:42 +0000
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb]) by AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb%9]) with mapi id 15.20.4713.022; Mon, 22 Nov 2021
 12:54:42 +0000
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     Ian Rogers <irogers@google.com>,
        "debian-kernel@lists.debian.org" <debian-kernel@lists.debian.org>,
        "waldi@debian.org" <waldi@debian.org>
CC:     linux-perf-users <linux-perf-users@vger.kernel.org>,
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
Thread-Index: AQHX149y2KafCifzNka8ZEqO5o/ybKv/9vaAgA7oRACAAKomQA==
Content-Class: 
Date:   Mon, 22 Nov 2021 12:54:42 +0000
Message-ID: <AM9PR10MB4869A06EB83A4AC6DCA955EE899F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
 <YY58idSor+lJ84KF@kernel.org>
 <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
In-Reply-To: <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-11-22T12:54:40Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=37d3f83a-38f7-4e3d-b6fd-12a8fee8a28c;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5187fd8-0cfe-41b6-024e-08d9adb74099
x-ms-traffictypediagnostic: AM8PR10MB4017:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: <AM8PR10MB40177C0292B93F8C1B7F9F10899F9@AM8PR10MB4017.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HlpZCL3e8l+XKX5u4ysNAtQACX9SA1Cx/zhqlKg3v/S82w+zMbAFCSwm9RYYs/YDnPcv/svC7w0jj3BMNi1vanjqNOLFMNEoR+n++ueD1fcO6yH5FcEOjcG6XHzDZvGjlmZzvsKm4HbqHvgmcq643UCyYBMoGjCnN7nY8N6gmS0KHUgiT43VievlViHEXDbr2jp07KD+pfh3cCpSnuABxl26B6JeudTSGoIirsXb3TVPUjLnyIVizam3sdXYHmyV6a7BcL0X4Ramh1kupL0k/WFM9y5buaKDjUZj8PIwxa9ApnzNsEw6mEqbRZW7JPpTn4aDGa9z4FIEdbWrnwmjAIbYPJvnEgmWyXrXxU+6BCxXGGSHpOFO4Uy4Wpztthlo2PAElcfslI3XSNsrHwddPMszXe7AE6/hqgkGxywKnpcVHd7pQqDvCoMrhHut/ReNFVCbr33VCXmRdiLUuLJpMYPVLwXLtIjSD9lK5Is1xsS1o9r1XvS0yYbJYLEibzinSKZHRUMf4nHjxFoqNhnTGDuwtjDCK7oXQ+cIFjWq64Frw3Y8r2aVkSh09xZ/1JtOmW2ifoI+ODJ+uZmPA58OjtTjI6xZDuBztNhNnA2P+gesmy5sqcdT2xsKjDjs8Y59MIx8jPkkriH71mTUcsIKhr3aPJzvD+nE9vEpdmaAIVqh+BNwIi27Ye867f6J7McUaPc5wrNRt1W3TIE+vYcjA/sW1m4EszWvI6Nmr2yOteokNiUCl8JHdcUs/41kE+gcsv8eaTmsYUQBu5fmbzWLN/re+TddKA5DLoYjLqsbVmL1zjffEE39LJAAkqwXnF4slmhbku/BkMml6m2XDKWGpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(33656002)(966005)(316002)(4326008)(38100700002)(7696005)(45080400002)(6506007)(53546011)(83380400001)(38070700005)(9686003)(52536014)(86362001)(186003)(110136005)(55016002)(76116006)(107886003)(2906002)(26005)(8676002)(54906003)(8936002)(5660300002)(122000001)(82960400001)(66446008)(64756008)(66476007)(71200400001)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?StTB7LkUPUDjaFfFRA7Hr5sSod1LAveKYpIYU5udLvtY5KVtvU2tDuOKyn8L?=
 =?us-ascii?Q?G/8x3S1a69PBf8HG5B2W5M4kjmhguo9mVHBjLPnd6gXjqIKjZvj2nFkAppwb?=
 =?us-ascii?Q?JlT6Q2Sq4C7JqdhcEeIUz2PgiRgr043yTHrkhR0byrUeiQWk3kJlfCBSEnCM?=
 =?us-ascii?Q?4Kd68hXswyA77g+9K96UN1Txv/X+UZk620QxtEx1aDSLz7qKvuCIEJhgcvJS?=
 =?us-ascii?Q?0LXJkrAry6wcwf++g8pzTtbqQrXzTJSVbSpuDTc+jvJ2h2AMPvHK5YJ5ytAW?=
 =?us-ascii?Q?4NWruQ5MFCIuecQtPS5hpOmyPlQAsqEbt387YlKqWqRFFHpNmAk8khgDFzpH?=
 =?us-ascii?Q?F308JbtQqSBd2FfelDkGvRQM21ePMKSoKMXYlQJAT6Q2bt5HrMjquIsiCNug?=
 =?us-ascii?Q?t9WvTWSF1Kcu5iDRmZHMG6HOyH+NXGewLhsEkROrAuemtbC+s7OJ2U/QckvM?=
 =?us-ascii?Q?6/IJTzJKq49CB1HKkQMNjqyjYshFdDUVxGpJGOhbLhDz8ykeVM4qwaBHp+z1?=
 =?us-ascii?Q?3kha41xASrkWXTruQ4Hgv8vPNDg23AdAF/gyeT47EMV7pJZwtyT6dig8qvM3?=
 =?us-ascii?Q?al2g+rUHk8CxWDuLS/eQKSzFrkIv1KYAKYsxgPKM9QyizQNZABV7cCy8yD35?=
 =?us-ascii?Q?dR6oKVfmHMRl6FjUNxy4TE0oEKUwqC67VFGbAHz9Z3s+5a1Q7g5CUirE++hw?=
 =?us-ascii?Q?pY0uLuvyT4kTlRlm6y9DwtKxonXOUCs22RGUkyymfO0z+9fBUwL3pZ5pvAtG?=
 =?us-ascii?Q?s1PejMuyREAFsfLLRfBBrvbenGLQplEh/+PKDkN/18fsBkU1wVnKhWJ/rAg6?=
 =?us-ascii?Q?sgKPW6hPSjN+RjjJKUdP2dCOnU0N+pVIN46Bmnpvr3CNoI7g51tlgUoqX1an?=
 =?us-ascii?Q?TeTTUTqHNLtZ+SjJ5abGqItHc7m1vLCKZqIyRDMiX3PXJRWjSOVrE2pnzkCN?=
 =?us-ascii?Q?Hy29Pf4WkOujMbZwLo7EAuxYlZLAb6lOEwUflO3j87vnhaTT/N8ZmxV0y9Zk?=
 =?us-ascii?Q?AcmrPKCUhPe8ssWFUWkiBwi7GwvOFPlJ9eEL7Agzr/YpRWEjk28BieMP0qIM?=
 =?us-ascii?Q?pMW6n7xUg7bcUK7RytF7Ip8+ty3GT9uEszhJoCx7/B1Oa7l0hLKDXlpNDda4?=
 =?us-ascii?Q?wcWhT0f0P+wdsDx1cXbWHi6MBJEsnd1+yd2fzYsc+D3aJWAOSS3NZkQvqrT/?=
 =?us-ascii?Q?ej5wXx/N/OZ7BIHtqvctMZ8RWvSbHx1TJ7XVo9QPsUn+2OaJZxzgGduJi6y2?=
 =?us-ascii?Q?l+U8cLyMrc+AQcm0ROLEvHk6YcvJlG9zuy2V/s26vBxrluGckthnNWSveM9x?=
 =?us-ascii?Q?pvBFSDkTNern5q89ilJl0mJHXEKzxuSRET7cklAo+SQnkaL3V4hpuH3Tq+Bo?=
 =?us-ascii?Q?aPsXtfRS7G5X1Y/lv4XHBRY0cCTKBkpqgdcC7biWYCGX2ev0rPwZjLARuPYH?=
 =?us-ascii?Q?DcSTOzwymb6PEQxMbL30fYw6X3vGMj4Zyz8xlj7v357LiN4uMZsj/4NMpnFR?=
 =?us-ascii?Q?ZqhG8gVA2Cze0x7xYEVGwZxaf2iIpI2Q8FWaRhhjCczSYvVRlmHEGDQSMgXK?=
 =?us-ascii?Q?jiNbArCZra6UvP+UzrFb/ClaNOhc2G+jxAM3tPkub3U/9779zmEvW5RrfITh?=
 =?us-ascii?Q?wmOg5V3OUTgSRQNlyXCZnWpt3hDLsmWM7Bva/VWkzyFksmgB/VPJTPIh18Z5?=
 =?us-ascii?Q?nYDNIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5187fd8-0cfe-41b6-024e-08d9adb74099
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 12:54:42.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7a0vvIQjo2WLyc2kLXq+JSKsiVPBGmeDPBM2VqRD7TOcwzwwRYH3Q+vlsVAcPiPV++Tmld8Y4rwZ51V92fkZWoIjeHb0P4BdmX+6sjVL28U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4017
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

> -----Original Message-----
> From: Ian Rogers <irogers@google.com>
> Sent: Monday, November 22, 2021 3:18 AM
> To: debian-kernel@lists.debian.org; waldi@debian.org
> Cc: linux-perf-users <linux-perf-users@vger.kernel.org>; Arnaldo Carvalho=
 de
> Melo <acme@kernel.org>; ben@decadent.org.uk; Jiri Olsa <jolsa@kernel.org>=
;
> Namhyung Kim <namhyung@kernel.org>
> Subject: Re: Getting the latest and greatest Linux perf features on every=
 Debian
> kernel
>=20
> Hi,
>=20
> I'd love to package Linux perf as per Arnaldo's prepared tarball for Debi=
an. If I
> could get help on the Debian side it would be great! The actions that are=
 needed
> are:
>=20
> 1) package Arnaldo's tarball for Debian, presumably the build in the sour=
ces for
> linux-perf-5.10 will be a good starting point. The package will be linux-=
perf and
> replace the current metapackage of the same name.

The current packaging in Debian does not include the perf python bindings.
Today these bindings are used by more and more tools (e.g. tuned).
For that, we packaged both a versioned module (linux-perf-<...>) and a pyth=
on wrapper to load it using 'import perf' (linux-base).
These patches are currently under review at Debian salsa [1].

All this would be way simpler if perf bindings do not have to be versioned =
anymore.
But please also consider that still a lot of people are using 4.19er kernel=
s (don't know since when versioning is no longer required).

[1] https://salsa.debian.org/kernel-team/linux/-/merge_requests/425

>=20
> 2) create an updated linux-base that removes /usr/bin/perf
>=20
> 3) upload the updated linux-base and linux-perf packages for maintainer
> approval to
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmento=
rs.
> debian.net%2F&amp;data=3D04%7C01%7Cfelix.moessbauer%40siemens.com%7C
> 4dbf17b41e4542b4c2de08d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d5
> 5a%7C1%7C0%7C637731443001828013%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0&amp;sdata=3D80jfnANxTuGYzw0vErMUQOlpdUWFrDNP5n9ktaVTBaQ%3D&amp
> ;reserved=3D0
>=20
> 4) some how get the previous Debian linux-perf-[45].* packages removed

This can easily be achieved using the Conflicts field with a linux-base ver=
sion that is older than your patched one.

>=20
> After this, when Arnaldo sends out a new tarball we can update the linux-=
perf
> package. libbpf and libtraceevent are currently part of linux/tools, but =
it would
> be better to depend on the distribution versions, which can be a future u=
pdate to
> the packaging.
>=20
> I'd love some feedback on this plan, whether linux-base/linux-perf have a=
 special
> process, etc. Documentation wise I've seen there is a lot, but:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmento=
rs.
> debian.net%2Fintro-
> maintainers%2F&amp;data=3D04%7C01%7Cfelix.moessbauer%40siemens.com%7
> C4dbf17b41e4542b4c2de08d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d
> 55a%7C1%7C0%7C637731443001828013%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000&amp;sdata=3DY0L%2Bn%2B0yJqGVnp%2FhCfBVD9V3bZ%2Bffb48vy85jg92M
> oU%3D&amp;reserved=3D0
> looks fairly to the point.

I really like the plan and I'm also willing to support here.
But please also note that I'm not a Debian sponsor or maintainer of the men=
tioned packages.

Felix

>=20
> Thanks,
> Ian
>=20
>=20
>=20
> On Fri, Nov 12, 2021 at 6:39 AM Arnaldo Carvalho de Melo <acme@kernel.org=
>
> wrote:
> >
> > Em Thu, Nov 11, 2021 at 10:34:33PM -0800, Ian Rogers escreveu:
> > > Hi,
> >
> > > Debian currently tries to match the Linux perf tool to the version
> > > of the kernel that it is being run upon. Reaching out to Ben
> > > Hutchings, he explained to me that this was done back in 2010 due to
> > > kernel and Linux perf incompatibilities. This was likely the case,
> > > but it was a bug in the Linux perf tool that should have been fixed.
> > > It is the goal of the tool to be backward compatible. A problem with
> > > matching the tool to the kernel version is that users miss out on
> > > new features and fixes (this topic came up in a recent interview of
> > > the maintainer Arnaldo Carvalho de Melo [1]).
> >
> > > Ben Hutchings informs me that making it so that Debian ships the
> > > latest Linux perf tool requires updates both to the linux-base and
> > > linux source packages. The Linux perf tool also has many other often
> > > optional dependencies, like libunwind, libbpf, libpfm4,
> > > libtraceevent, etc. In general, having the dependency will unlock mor=
e
> features.
> > > Linux tools has its own copies of libbpf and libtraceevent, and so
> > > these may pose some versioning issues.
> >
> > We can use LIBBPF_DYNAMIC=3D1 to use the distro libbpf-dev package,
> > which currently is going thru some growing pains as libbpf is 0.x,
> > with several APIs being deprecated, others renamed, and that has been
> > a source of friction, but should be past us with v1.0. Till then the
> > perf codebase is being adjusted to allow it to be seamlessly built
> > with the in-kernel version and with whatever libbpf-devel the distro ha=
s.
> >
> > > I think it'd be great to get Debian shipping the latest version of
> > > Linux perf for its users. Hopefully we can agree to change how
> > > Debian packages perf currently and then work out the best way to
> > > package and keep it up-to-date. I look forward to everyone's help and=
 input.
> >
> > I also keep the tarballs available at:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmir=
r
> >
> ors.edge.kernel.org%2Fpub%2Flinux%2Fkernel%2Ftools%2Fperf%2F&amp;data=3D
> >
> 04%7C01%7Cfelix.moessbauer%40siemens.com%7C4dbf17b41e4542b4c2de08d
> 9ad5
> >
> e58c3%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637731443001
> 828013%
> >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> I6Ik
> >
> 1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DA2TTg%2BElfRv9bslXw6YmEA1
> R8Iu08Z
> > hFyv6juVhRj24%3D&amp;reserved=3D0
> >
> > Where there are instructions on how to build this detached tarball.
> >
> > I regularly build perf on lots of distros, including:
> >
> >   debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3=
.0 20170516 ,
> clang version 3.8.1-24 (tags/RELEASE_381/final)
> >   debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , cla=
ng version 7.0.1-
> 8+deb10u2 (tags/RELEASE_701/final)
> >   debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 202=
10110 , Debian
> clang version 11.0.1-2
> >   debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , =
Debian clang
> version 11.1.0-4
> >   debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11=
.2.0-9)
> 11.2.0
> >   debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.=
1-6)
> 10.2.1 20210110
> >   debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debia=
n
> 10.2.1-6) 10.2.1 20210110
> >   debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.=
2.0-9)
> 11.2.0
> >
> > Ditto for ubuntu.
> >
> > A complete list can be found in each pull request I send to Linus, see
> > in the last one:
> >
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2F20211107204947.1394255-1-
> acme%40kernel.org%2F&amp;
> >
> data=3D04%7C01%7Cfelix.moessbauer%40siemens.com%7C4dbf17b41e4542b4c2
> de08
> >
> d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6377314
> 4300182
> >
> 8013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJBT
> >
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DfoKAv3e5lm5du1yoLqhzIVf
> vfc7
> > RkZqRAxmfTFkID9U%3D&amp;reserved=3D0
> >
> > Search for BUILD_TARBALL.
> >
> > There is also the output for 'make -C tools/perf build-test' that
> > tests building with lots of combinations of optional libraries, for
> > instance, with LIBBPF_DYNAMIC=3D1, etc.
> >
> > - Arnaldo
