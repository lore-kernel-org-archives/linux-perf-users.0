Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA22C07E99
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 08:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F9C613CA
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 08:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhGIIfk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 04:35:40 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:25481 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhGIIfk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jul 2021 04:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1625819578; x=1657355578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hn4fpWYIv14ajTz0ApsVQZi36hD9I/MbN9CenVZgnQc=;
  b=lbeA9IOao0vjleriLM9AIAkkTszqWrOleKc7dtIjmKf5OLzaG0q5m3e3
   ahcyTwGoJAlL+rsU+uH6ILkzMiaWcXthnYlhE7GHthYu5qpKXgC4ZjLkH
   oXxMM01EaJJtTaMTU/bEN0/HG8BsCjGlEdeb4/h1ujoZ2Z+a8dXnP7Dka
   c31TqVY25sWed1O4u5wqhsVNYyeO3gKphQWTNpF9RXtzSiIs9RQ5HhtUE
   iOCQWpg984fFAZTnb8SE44tdPyuLo45RryqizMEcyGWGGK9ebHr6fSJN4
   96Px/ypqnjyYTds6lsbVdeQngg0CKDff8s+nYcuUyoSduXzEwUQ9L2cZx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="42844543"
X-IronPort-AV: E=Sophos;i="5.84,226,1620658800"; 
   d="scan'208";a="42844543"
Received: from mail-ty1jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 17:32:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUE7qaoGj/DbKrXesojepI2aWsAbEPS44v/KXSeLM4UhjIsYd39IJqHYmQCPa8VxahYONWl6kBshl3wIKT//Fj4emwyoSOSl5SqYhQvG95hN51sI3k/SG/++u1tz7A1lrZHwFZ7BG0LKrAtpZQqm+UXtd2sWO8cM9ROaLuRfCiDs/58Xhgn9+3x1r8OgINSpae5Itm7SZC4IoJVvPvGRKBxALqsEdjwuS7uj1jzU/xz9970tGYfqYsZSZABsH8tg2ZlwefFtxxt1hFTcCl/myytQstRrXS9FRNUukIZJPMXFFsB8AtoUeEadxQwwnTUeH/wOF5OnQVAS//fBJBLm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn4fpWYIv14ajTz0ApsVQZi36hD9I/MbN9CenVZgnQc=;
 b=OXFI34vr9Z28+dMPbehH9bRLeAvsEwz06Pdk9jT2IJh2yeVcRlESaqCQuZR/Pj1lvinYMY4/5GH3+r+XBtYM+yW9JombOENuPVXUyL7yk4XUJk+sqqEng/pWl08c1ARxVGdsLD0tsR0Q/D0Pss5no1p0CchPZbrlpuJTD69WPxl989XlDWrFmsFXU0PbC5v6tgOcr3pnvsiGkG/Kniyn6tH9AFdFhMpJT5beA4Zhg4FfjsYT4ZKzuLEUn6eLb1vxqXCCHqnJst6lI33uede6i9wEI3tJaQj1yi8tZxrNzuOSQOAk/IhO+h0mh8H2sPUCfKvVthhkv4UDIIA7X8fV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn4fpWYIv14ajTz0ApsVQZi36hD9I/MbN9CenVZgnQc=;
 b=R4W4MQ7VehR6TMM/jX6mydK/TZSf1v6QjqY6+kiGsnh6f3+d3r61arMq3oqWMkRofKWTkbRFEdjBi6v5gCzcDjYNX111DI/hg3zH8refRporuxn4ZyrPrAgZghKdSjUaVlD/Q460sBSdK53J/liwFk00EYsJ/xBDlsrvyRxH5UY=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.30; Fri, 9 Jul
 2021 08:32:50 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284%6]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 08:32:50 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [RFCv2 0/7] libperf: Add leader/group info to perf_evsel
Thread-Topic: [RFCv2 0/7] libperf: Add leader/group info to perf_evsel
Thread-Index: AQHXcnn/wz5qoT5DfU6ga3rhnp0lbqs3mQmAgAA7bACAAATkAIACeqw9
Date:   Fri, 9 Jul 2021 08:32:50 +0000
Message-ID: <OSBPR01MB4600BC30D85403D3130B0C9AF7189@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <YOW+eyxYtPhc2hSf@kernel.org>
 <YOXwVPS6zIyw0C/k@krava>,<YOX0bpjlr/Xqlbk0@kernel.org>
In-Reply-To: <YOX0bpjlr/Xqlbk0@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-07-09T08:32:48.985Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa0cd37-235a-4b5c-dc18-08d942b4235f
x-ms-traffictypediagnostic: OSBPR01MB4773:
x-microsoft-antispam-prvs: <OSBPR01MB47730FFCE80404FA77BF08B3F7189@OSBPR01MB4773.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJmNaqrNMLoP0ZKoQm2pwH6E9PAf33ZZvPvn1QWpZ4JLKfR6PuOADHOlYeDK5uOLktkldIxx6mHu9se6XYWPhXz8TwLLgie+QEMxTZpDP/xyTlYPKJBWhEVtNdW+4dvBQypgweoamUsCmSIjAMGZs75/KSlu6OTZakYPARVDrjYwIQ5jrNXqSf3J55LFPiu9j6KKOq96uL1OCR+e685vlRC5lmZdb9nlSHnylvAW6hvIWg41bvK/n6JRp39mQmy+/05MURht9OF4mk46gndNLwA3nyNgIdEsqUnRbcANXAx+ZW/9WBQj6+0RvRDQiqfnqStfmBENiH5BEjYypDaGrA4OgOHi/oP6RDxeZdtoHTBPrERELfepC2lajeIkCyFBsZw+GuDYH8YkAoWmbpVKDpXGKWYpM4JYAfVfbiTbBlnLl6qw+Q2RXu1Xlopy8Be6z7uN+u8DS3K+nFbdi1Swk23oWPp8j5Kuocf2OkuHFfQg8GIhjKe6F2cYP6eAHK7Snq6Wte3UQINqfOTHhr8jMN7cOi32uu2uL74D6AzXdOuygM8UcZXuPemjAi64ksBGpaBYO50xoBsILJJ3LsSgOc2sOqHaP5a+QWPL2USjFUMUdOAufbSNdn/h/0cIPtDOXvFpJEqB/BC5OyJYVXIaDBxlueSs8fjuEwJgbUzZ0j6mMnB26z1Q61kFUckgC2cGJ4SOJpmsi/DfglvXfBNTbcMQOoPTp9oT/sOtijJ3Tp4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(5660300002)(8676002)(4744005)(7416002)(122000001)(9686003)(52536014)(38100700002)(55016002)(478600001)(86362001)(83380400001)(85182001)(6506007)(66946007)(71200400001)(7696005)(33656002)(186003)(76116006)(66556008)(64756008)(26005)(66476007)(54906003)(2906002)(66446008)(8936002)(4326008)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?U2ljTDVEcFBTdjlaVVFmZkYvbXhRRjYwWGpWbXVXTUV1TTd6TnpoMm5m?=
 =?iso-2022-jp?B?MVJ4YTdkWVp3K0RWaExzcDR2bFRtUXgvVW44MzM5WkUxSGhOQTlLSUNS?=
 =?iso-2022-jp?B?OTdMZ2FoaW45Q3ZxYWtGYUpUZVRGL05SNWhrOUhTYmVESFRQY0tXQTBl?=
 =?iso-2022-jp?B?NFVMSDZwcE95cHRTV3dvdy9sVjY3UmM5cXRqYWFrOWlVT1VLQ2VwRVIr?=
 =?iso-2022-jp?B?L244UTd5ZEVSVkx3MjVHWFJOeDF4SHpxUnE2V3JKRjBMYXFFeGl4V2JX?=
 =?iso-2022-jp?B?NkZueFZJSHhkVG4yR2FzT2JGL2hBK2M4alYxRWNTQnBScWJWa2h2UWh1?=
 =?iso-2022-jp?B?SzJ5MHNmZ3BVM25XcmlsM1dRQ3VGS295OFNNak5uN1hjckVhZXpZSUhU?=
 =?iso-2022-jp?B?dndhVGRmM2lLWjVENmwvcXRWdGhxcWY2eEZISlV0cTVIeHNoVVQyb014?=
 =?iso-2022-jp?B?VlhJQVFmMmkzcWxPZkRuT1RhbkdHQktQMTA5TTZJdENLWDRaNTJZZGdY?=
 =?iso-2022-jp?B?T1k0VUxkdElhSm9oQTBQYmRZL0FYM0ZYTDFneWtvZmVOYkNwNjkveFNT?=
 =?iso-2022-jp?B?U0tOUXAxeWhtOWd0ZlJnUGU4OTlYR0J3di9NWVlpK3FiSFI5WXZMc1Q5?=
 =?iso-2022-jp?B?bDErckVhZFlMY2tPR0xQc2RleE5Edi9FWFRNTi9wakRselNvMW53V0ZW?=
 =?iso-2022-jp?B?d0lLTFRZYU9laFZ2U1ZYS3NZVG4rQ1FpMG1Md0VvaldBanpLZnhwc1Bl?=
 =?iso-2022-jp?B?UDlEWWxlNktsS1BpZ2p3c3hDbVBRS3lLZHlHaFB6L1cvY1BxTzErL25p?=
 =?iso-2022-jp?B?TkFBSWV6TFRqWDRNT1VmemdGelNkQ1RPY2N6YVlyZFUwTVZpZElOTERi?=
 =?iso-2022-jp?B?OVlTb3ZKMnFINnFxTEtLL2tUeUJ5L21wMEY0cjhFdWRXZGUyT1dleSti?=
 =?iso-2022-jp?B?TWRCRG9VcDl5ckNpK1VpUk1lTkV0ZVZSNENBU1cvc252aC9FMHlvb2Js?=
 =?iso-2022-jp?B?bWhRRGwrZHJ4UlJwNVlWUjY1YU4wNTlJL1NXZXRsbVhhWldRR0JRTUdX?=
 =?iso-2022-jp?B?Nmp5cEdNb2w0cFBJTnNmb2pWZzNIQVpVMGo3RVRDZ0ZSb3k5QUowMlhN?=
 =?iso-2022-jp?B?Qnc3d3prcW1qLzFzTEJGdzBBVERVU1NldERFVkcwQWdkTkFLZE5tMm1w?=
 =?iso-2022-jp?B?dXdobHduMDVtS1RSK09vSkxFUWtJRnB4d1FCelNOMkwvQWQzbmhvL2Ux?=
 =?iso-2022-jp?B?dzIxazZOdHdiekNSSkFmNTBGZjRVN0JQZlVPd25adkkxUW1XdFVjR0xk?=
 =?iso-2022-jp?B?TDhqTnNKVkpZZzE5Y2VEN1FJM3ZLRzhGVlVHSU10MEVlUnZMUFlZU3Vz?=
 =?iso-2022-jp?B?dmh2ZUZYYlNWZzkxOXRnbTJDbU5FRUw3NndDL0dqMW4xYzBiSXpXQlhX?=
 =?iso-2022-jp?B?d0RaMjZNYlBJdm9TdDBlRE0xRWd2OFhmT2JBNWkzUnBVMjZLNTB0aGtr?=
 =?iso-2022-jp?B?MFJQYnZOY3FOcTZ2M1hoaE9uM0diT2N2U3RIZkJaajVpYkJ1VTZnUWYx?=
 =?iso-2022-jp?B?LzFsL0tPL1VVVTJ1bGVhZS9Nd0VjOHN5b0NmNDM0d3ZqeFZ6WGRZYzli?=
 =?iso-2022-jp?B?YWg5bFJ6UU1LMGt5blNrOGhqeEVJVUkwUGF3Y3ovMU8wT0sxNDFqRWU0?=
 =?iso-2022-jp?B?b2svUllCWlc2L0lEZzdkaGg2SVh1SXU4UUx4K2NkZW1GbUQ5Yi91K1pP?=
 =?iso-2022-jp?B?MFRoU3ZmS1lXQkN0TVkzNm4wNGdjZERrWHk5V3RYSWxZakdTODNNakpT?=
 =?iso-2022-jp?B?Y1RzV1BMWVJLWjhmbUJ4U2NLU3F0ZGtjRld1VW11VGI0Y3IyTjRkQ0tt?=
 =?iso-2022-jp?B?OVRIS1RhVVV0OWc1ZVhVMy9vRS9ZPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0cd37-235a-4b5c-dc18-08d942b4235f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:32:50.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alIWKooMasVNIDpsvRmETRCzRa5l9tahejbm9fEGQ140VCLRWaCXe36AGkSPQUcpHDhtNCDzqp68kNZdaWK9AGHrZXrYqUp6ycwCMij6DWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4773
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jiri, Arnaldo=0A=
=0A=
Thank you for posting a patch.=0A=
=0A=
> Its all in tmp.perf/core, but from what I saw, yeah, he requested being=
=0A=
> able to have a group leader.=0A=
> =0A=
> Nakamura-san, isn't that the case?=0A=
=0A=
Yes, that's right.=0A=
=0A=
With these patches, I think we can use event group to register multiple =0A=
perf events, just like PAPI.=0A=
If I find any problems, I will point them out.=0A=
=0A=
Best Regards=0A=
Shunsuke=
