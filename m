Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97762ECAAD4
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 04:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiH2EvA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2Eu7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 00:50:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2014.outbound.protection.outlook.com [40.92.46.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9341D21
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Aug 2022 21:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b73snvgLT5MUEAcI4jegIfEmhZ0Kmqc9AC+E2obE2gLSYMxrzEhKFlYqjd2+lsQKg18RX+neeNtmIkE8BtrlWGZU6+75iYfYMer8VulMVABieX7Syl33if10/BYt/TDGBtKwsAOCDyiRxvpD+/ZgRatdpo/McD3tF4Mc7ABbIz8fhs/J0WTaEyF845o40z8GzBrKdYCwwp0LzMKJ1AilSPQPp+y/NYehTRZhGi5HnEhLvEvOESozSSM5wzURVIfzI14KrrHtMY9ESVPu7A79yq3u8BZ8jeRsYy1omyMWw7VlG2Hkbf5977tslTQM1EwK4v1NXKHJYSKhiZIyVkP9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etLMpJWnJvKqlg5DlDAUI1lX6ophNcL/J+XQEHZGb+E=;
 b=It4OX5oKyEwm5PNfqBIGAxkGqw6VhPs1h+D/pHJ2vtMNOGplWw5VkkOa5TnftKuvS/GLGHU4VS861+QprOs3iBzFumPCgSvq6OpOD/pJNL4UKQj2fINGnI74XsMFDl6GODmuKluDTXF88ERh75zw8a7cXJjq4G/VyNOzuiBgMO5x88G6Hyo8VdH3AZnBzf+7kDt6Rm2/nqu/5/dqmqX/qS68WPXCkpFuIOrn6GPbqCeUChULt4UCiPga+W2tIM66QQNy+uo/i9JL7nb855zy6ds5recvbcLaerWuYtfvMO7UQI/vfGoe4uBW4w/eS6yCYzdzTQmgfw7FLPi7Yb98LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etLMpJWnJvKqlg5DlDAUI1lX6ophNcL/J+XQEHZGb+E=;
 b=VnRt+P/UchYjVK/VG+tiA/toXSw+JskhKRasPxrJYiWQ36Cn/8WfIXbCJxw9SLVkAdMaUlr2fDk/Zp0vk2Ry6Cyj2HAasBaT52I+R86AtMy6qCGd4CM2ldWObCljaq970jo9cph4E2L69kaNu0YIyWHcbU/g3r6XAFJTliH4wJEXBVtRHeu97sGtp+a2bvlZK9VKNwJs6abxhHpaeOfXq/5mGqYd11mqwjL64Mi62nCgxN8jKxwRR/TraoVWeg6pr1bSs6TpZ+ckkJxE2qsyPRxYl/QJKbSR3PIcDPCiwBMei+eV4UiC4Sf31ojHBjXST9qkI1wfPxtSxBWnZCoh0Q==
Received: from DM4PR18MB5026.namprd18.prod.outlook.com (2603:10b6:8:51::10) by
 CO6PR18MB4417.namprd18.prod.outlook.com (2603:10b6:5:354::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 04:50:57 +0000
Received: from DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::ec38:b8f9:7657:e7b0]) by DM4PR18MB5026.namprd18.prod.outlook.com
 ([fe80::ec38:b8f9:7657:e7b0%7]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 04:50:57 +0000
From:   Hongtao Yu <Hongtao.Yu@outlook.com>
To:     Ian Rogers <irogers@google.com>
CC:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Wenlei He <wenlei@fb.com>
Subject: Re: Cannot use address filtering with user register sampling
Thread-Topic: Cannot use address filtering with user register sampling
Thread-Index: AQHYuBefxk+4eY25oUqX67pJ/KC0qK3BP/4AgAB/AoSAAsfNgIAAzgy2
Date:   Mon, 29 Aug 2022 04:50:57 +0000
Message-ID: <DM4PR18MB50266BD0C6C71922541BAA1E8A769@DM4PR18MB5026.namprd18.prod.outlook.com>
References: <MW4PR18MB503443512239B3F40267004C8A729@MW4PR18MB5034.namprd18.prod.outlook.com>
 <9b3f785e-1370-cf23-2ba4-2b0163185b2e@linux.intel.com>
 <MW4PR18MB50341AD0A32C29137D3EEF178A759@MW4PR18MB5034.namprd18.prod.outlook.com>
 <CAP-5=fXbJ3naAWnq6U7h7jbn2_qv0zWXXaq=kJs+xO8BdJY4xA@mail.gmail.com>
In-Reply-To: <CAP-5=fXbJ3naAWnq6U7h7jbn2_qv0zWXXaq=kJs+xO8BdJY4xA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tl0K3IWpaB0kREqPhaFmdgN+3Slft/at3qy1hC0DD+TE5O5evxrfvQ==]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5d1b20-3353-494d-77b2-08da897a1004
x-ms-traffictypediagnostic: CO6PR18MB4417:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UOoyImZpwdOraqmRaF0YlwPJHXau3ylEfjZKsPYnL0wUYRDceUcMEXsZK+hg4Dq03synrfesxFIbeDGRVTmpbzMQSxQka88qnAGo5nnXdsa3aRXNdlNr5CA/9j47gJDNNo6Iw5l58QPuC6M1AweyHy/xxaAc6y6WjbMIp2g9WiKY9YCUwrQRwhXoaD33gvnCvXNdzsCXJtwuPDv5eUg3HK5JWnm7I7PwUVPCi3nLVArLl7G+V7hLkjrGJ04aBnWOpqb+nCYj2+Gr0Svj6w08MBZp7GgnHyamWtSiYZI1hqqAiXJaNxVmfDf+CasFR9ah1f5a+wMIS4dGqR9KIFhH5xTns6JxCRa0BjVJ9tPOfaINDvZ2yQqSXcmJeUpXVnJ1D/KKPFK/9kXBm76DzTsgJ/7l8l5CP87qYYtCwUyfj0b+7m5RgBUiYY68hXMyuXgyHTVMQJn78Xbl8g3p7AylpxG1IWc02PlUl0C9nfa1JNwFPmZqZUEncVTyC4JCJAz0IH/3CL/s3SB+YfUSMPTF955k33FmPvr6w+Y1T8QkB4TD02aUWOk5NcNtNndn7FR2eRUkqBtp4+OxgIB7OpiL0cnQ/s0CEqkMdXRrurazZSbXrCW/QaHCDRQxxhF9eSGLBbhJGdX+s4Zeb6C/QAS2XBqxAF5KWykyaSVRZhWMxGDH6LkDzYi9NSsWzoXQ1DA
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?LJLLgURS0bdzss41BwztUVV6kt7SHBpbCpiK0CLWdo3gSrnmM5w4uVJO?=
 =?Windows-1252?Q?nAZu77gzU8S7Uc2UkRam1qhyZMDhC+jQEDe5REYltw8j8OEth/7rvChH?=
 =?Windows-1252?Q?ZUoXrhgSSvbGxyfj+EahgNf+fw4sDTg0FLafUH+wmhMpXAfHDplM8Q/D?=
 =?Windows-1252?Q?cb/WLeAHI/wEABnAAJk2xNMnRX2UGnDKt5Wo4emmbH8LFYHgxCeweF33?=
 =?Windows-1252?Q?XOXan8jO7BgJaMnub+/ym8kSIxx00D/bqpPMyzmtsjNfcejSaXiYkeyt?=
 =?Windows-1252?Q?Z+JR16G5Lo4EYR8dxkwuiG+0t45HG5vSlAsmWveHoBQdrZCEpeTUf0D1?=
 =?Windows-1252?Q?Zi6C4/By+BBryiyeaCwYEVwyUqd4lxgRs66xVmyp9eLK2aexbw4t52yQ?=
 =?Windows-1252?Q?lzLftiMpyHRKxqN/YoboKexK2g9v2F0HN+Hhf5EBfd9Ur+80/VBqI+u3?=
 =?Windows-1252?Q?um1+0OC2c5Yv/KglcOMqW+EQeuBmXgCS+yO3R4cvz77XENpEAZ3rWx2a?=
 =?Windows-1252?Q?LQBq24ejkPztGhLP3k5AXdMPy2LmAbINeMv2hVeAhyyYAudMkHbJpFnh?=
 =?Windows-1252?Q?lR0g7/3Fpvtb7VdhMITE7YG0sfpBr1eWo/UAO+Ov1Hj8xiJAF7gD0ba6?=
 =?Windows-1252?Q?qrVlFV2rGfQXBW9U6SKPt5LoUpgjF55QLMysPYlIk1bL9LxRw2uUtZ1U?=
 =?Windows-1252?Q?c3BJgc2H7RDRpvS4cAvFYVfpZ9wtLreOFwYRwL7im62fCsey6MlPJH3X?=
 =?Windows-1252?Q?/nia9ZitHOu6fqM228zE36C5lVj56PPpwHfsmMhlLo/y8TJ9a9FjGO9j?=
 =?Windows-1252?Q?1On6DSgF1k42984a+KgTMU2x+hqtdxoVVFpy6MjFWHKlklR8wM3+9GhU?=
 =?Windows-1252?Q?YBoKC5BXAy/pa3F9IZMuf2OxyBAGenOj9Ma7Cou793TfQZTMP6gJQFJ5?=
 =?Windows-1252?Q?GoAxEMxByqV9c5lfuEkMTgVJALb+T/IWpRTCicyp8HAUwE3rYMowU7XB?=
 =?Windows-1252?Q?YXD5v2XVESBlglEaEERZvLXK0nZ2OgeW5VCa4ilwk9M0PA3adJ9OxlRJ?=
 =?Windows-1252?Q?LpapEEInIL8y9iKo6RCoa/wRkjartl9Q1Qp0BLQEtg5FaX4VgzaLYdV2?=
 =?Windows-1252?Q?tNCaNiunhuB5K2GsuUarJFUlfMtQA8Jvrvc6vbY/xm+1L/z2QVE4EOqf?=
 =?Windows-1252?Q?LJ0vB8Nln6EHblbbd1zJgAJBh35sJ+yn3swTSsXZndY6j9ni5GRFGVu6?=
 =?Windows-1252?Q?ok6MWdiom0fZWj091DsnFjeLO3lfIoM1ZkCKdFEJ1XO2fiLdvctdjuQm?=
 =?Windows-1252?Q?axDav+i7qcpMv9SyN1NVsYaI/3KbRdo+lQqxuwXDEMbisfJe65E/8SJS?=
 =?Windows-1252?Q?lT+CUifvl8fwoBmnTGfjSYACY09xzJa/t/U=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5026.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5d1b20-3353-494d-77b2-08da897a1004
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 04:50:57.3933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4417
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for the pointer. This is so cool! IIUC, perf can take in a piece of =
C code that can implement a filter of samples. I'm wondering if there's any=
 documentation about the specification of the C code.=0A=
=0A=
Thanks,=0A=
Hongtao=0A=
=0A=
=0A=
From: Ian Rogers <irogers@google.com>=0A=
Sent: Sunday, August 28, 2022 9:30 AM=0A=
To: Hongtao Yu <Hongtao.Yu@outlook.com>=0A=
Cc: Liang, Kan <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.or=
g <linux-perf-users@vger.kernel.org>; Wenlei He <wenlei@fb.com>=0A=
Subject: Re: Cannot use address filtering with user register sampling =0A=
=A0=0A=
On Fri, Aug 26, 2022 at 3:03 PM Hongtao Yu <Hongtao.Yu@outlook.com> wrote:=
=0A=
>=0A=
> Thanks for the information and suggestions!=0A=
>=0A=
> We=92ve already been using the -c options to adjust our sampling scale. T=
he new need we are having is that we=92d like to sample a particular part o=
f the program instead of the whole program. Since the hardware address filt=
er doesn=92t apply here, I=92m wondering if it is practical to achieve the =
selective sampling on software level when processing hardware interrupts, t=
o avoid generating tons of useless trace data. For example, perf could do s=
uch filtering based on a section in the binary image that specifies the int=
eresting part of program to sample.=0A=
=0A=
It is possible to write BPF programs that will drop samples. There is=0A=
an example in the tests:=0A=
https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.ker=
nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Facme%2Flinux.git%2Ftree%2Ftool=
s%2Fperf%2Ftests%2Fbpf-script-example.c&amp;data=3D05%7C01%7C%7Cf9c51874388=
f436c2e7308da8912aa36%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C63797301=
0500861646%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dyw5nGV7e3W3haHSpi4dh=
id0UfaEcNFIRxMUCZWuWQVQ%3D&amp;reserved=3D0=0A=
=0A=
Thanks,=0A=
Ian=0A=
=0A=
> Thanks,=0A=
> Hongtao=0A=
>=0A=
>=0A=
> From: Liang, Kan <kan.liang@linux.intel.com>=0A=
> Sent: Friday, August 26, 2022 7:28 AM=0A=
> To: Hongtao Yu <Hongtao.Yu@outlook.com>; linux-perf-users@vger.kernel.org=
 <linux-perf-users@vger.kernel.org>=0A=
> Subject: Re: Cannot use address filtering with user register sampling=0A=
>=0A=
>=0A=
>=0A=
> On 2022-08-24 8:14 p.m., Hongtao Yu wrote:=0A=
> > Hi,=0A=
> >=0A=
> > I was exploring address filtering together with user reg sampling on In=
tel Skylake hardware. The idea behind it is to make reg sampling more selec=
tively. Unfortunately, I hit ` This CPU does not support address filtering`=
 error. The command I ran is:=0A=
> >=0A=
> >=A0=A0=A0 perf record -e br_inst_retired.all_branches:uppp --user-regs=
=3DDI --filter 'filter * @/bin/ls'=A0 ls=0A=
> >=0A=
> >=A0=A0=A0 This CPU does not support address filtering=0A=
> >=0A=
> > IIUC, the br_inst_retired event is also hardware-based, similarly with =
the intel_pt event. But the latter works with address filtering while the f=
ormer doesn=92t. What is rational behind this?=0A=
>=0A=
> The --filter only supports the tracepoint event(s) or or a hardware=0A=
> trace, e.g., Intel PT. They trace and dump each single instruction. You=
=0A=
> can use the --filter option to choose and only retrieve the=0A=
> data/instructions you are interested.=0A=
>=0A=
> Perf record -e br_inst_retired.all_branches event does sampling. I would=
=0A=
> recommend you to use "-c" option to control the event period.(The number=
=0A=
> of events that triggers a single sample.) For example, -c1000 means 1000=
=0A=
> events occur then the HW dumps a sample (only for the 1000th event).=0A=
> e.g.,=0A=
>=A0=A0=A0=A0 perf record -e br_inst_retired.all_branches:uppp --user-regs=
=3DDI=0A=
> -c1000 ls=0A=
>=0A=
> Then you can use the post-processing tools, e.g., perf report or perf=0A=
> script, to filter and output the results.=0A=
> e.g.,=0A=
>=A0=A0=A0 perf script --dsos ls -F+uregs=0A=
>=0A=
>=0A=
> Thanks,=0A=
> Kan=
