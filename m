Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CADC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 06:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4827D60041
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 06:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhJVGTm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:19:42 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:34622 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230086AbhJVGTl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Oct 2021 02:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634883445; x=1666419445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CMAXjuUg9oById508KrFRpa57zOAT/EJkBaMoK8wpQs=;
  b=ECrZZnMLM7tLIzTBoNUi5kGxvqVUEG5+pYpnZHJRFiQ2PzjB7RYs0n5S
   QPfSAi2bu6/prjFnUswf1x51xZdMNQUn8a8bPZvmp4bh1HbsJK+U+T6rm
   f4HCVSCsaPKaqy2VP0NBWLDLG9QKx+2Q62e+7Fd5QCdAQTcErV70+Izwf
   0R3w09jChepfUEMsIXvEfEJz9g3W4osMo9VCHgFXSk0xE1gEqPb3qlzGH
   8UVhtznGo0ZBXNEfZBF5fM2hmh3C37BJsmhZCbJeDJOvGcFMusd7x1HMw
   1ecSqN6+95Es0AQc4RbeUAgmHfjzYl7+x3hFrfdoXTGw4B//dA/Tuxv05
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="42081815"
X-IronPort-AV: E=Sophos;i="5.87,171,1631545200"; 
   d="scan'208";a="42081815"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 15:17:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB1ylcRhuISyy7JaaEVsTaD4PzBE1ntb4AgFFZXPK6GWbdcgI9JnoBK7q7PkfBV/fmUV/bNTg+HiFlChOkFcwAXb/u8GDFP9gwRmJjlOgm4fp5wNxXYpGplSxPuQtm8jTuh1Q2TChKKspylLniiUnKrvIf7UCRKKsNr/0hd+uAcj7WSEUWTQQzTApgzPUOrZaGTQXlAmv98qsitzUFkziAA8Hd3Gx+QdpnKLv1ENoKLI/UAiWfG4/KQTBbMmFODOlaVZ9iccvFfy9ZSNHN1EJHwgidirV9h5kUxfoZ5xH5dWcZxtMDsaFVYSzZJkf9mV1IqTp27rl0onONImRlqjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMAXjuUg9oById508KrFRpa57zOAT/EJkBaMoK8wpQs=;
 b=CJ+lbKA7JDiYL5Q4moZwN5iKT3irSM47KzhtYrdVdh0CunsOuw1xF1BPpizKQNFUTgyr2vtuUw1ng+Mockx17+Q2/SiQf1hqfi9lh7w6lssM6jsE9JTOQ+QWGowzZz3d6sxCyhLqvwaDREyjHbNCWhhFIAN1wZXE6ZK9Rl0+efq4IPbqkxAvKvZv1Rpyznd/0FtQpKpVJYub+bI8reLCX/YtuMyJxTU7LIDkHA+T+RzuR7p5O9VOcDnyZf3k+f0anaBY+mDIhQJGf4FEw/XPlTp+RaJt78Ke84/B5QGynNIPypA7xvvGHZafyZbKptL4cMQUnwZUzYjgynj0GM27hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMAXjuUg9oById508KrFRpa57zOAT/EJkBaMoK8wpQs=;
 b=Kqn3h7sp68PkBoegPDfiyd4jv0w7bUzVvU9NlETEe5PSm8FARVEW6F3lPcvaRMt5VIc1gnLsA/+vdWPUfcQQQ+WU+1Pkn6xJMln+YSVgnPlBsp+04Lg9XuKm2uHwo1X1/7nD3wQ6a6pI6GRBgNHeEDYeqWT8V0iZAkLs5Pplrg4=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS3PR01MB6674.jpnprd01.prod.outlook.com (2603:1096:604:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 06:17:17 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 06:17:17 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Thread-Topic: libperf: lack of interface
Thread-Index: AQHXnxU1v7C7yDhEy0Gzl7rxTcNZhquPLp8AgAE//ACAHexCH4AqXPW2gANjt4CAArnVug==
Date:   Fri, 22 Oct 2021 06:17:17 +0000
Message-ID: <OSBPR01MB460067F4CE80D8EF6B707D4CF7809@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org> <YTCOVGyffe+VwL6G@krava>
 <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YXAJhTC9aqOS/GWy@krava>
In-Reply-To: <YXAJhTC9aqOS/GWy@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-10-22T06:17:17.038Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 54df77d4-2106-dfbb-e1b5-91d23a0b2425
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b9c0b41-7f39-40b2-a06f-08d995239927
x-ms-traffictypediagnostic: OS3PR01MB6674:
x-microsoft-antispam-prvs: <OS3PR01MB66742F96256EFE9ECD610767F7809@OS3PR01MB6674.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSIpGwIjZcAU6z3X2LBRisQOKE7VzTso1+H/nf0KYUPdOkmNUn5YrCCZA71O7a4kUTIAUbgIZmaeLKc+ZJcI/DzYLzV+0mgRMRjDTsWxTLs64VbOavGI3zvfRvejsM9Svj6KwUqU36CqIQrf1Jw5EWiA+yrWZmJqxuibvz46yybK6dt8lcEC6zsO+bUJMAuIhEBTIdlVsuI0KOVCoey4cfIZhtNZ1o3yfZn+GTUSL8hOMsY6v+iFM2teumbjT+cA9OcEUR8ODjrFwOkzmCj+FJUP0fbEPcJHxa8a4zyRRWdvmWkTIjGCKpIbWftGzEZ3g5o3pEtennQlFXEkQZhBpGx5Wo0ZdpmDplwZWAIHl03iOEtWkcd6sXlY0b3LFHRoCcTBQyvQF5V/7d60cuUywayn2bWoDkvP0R6g/xz4INauKVimovLcAZWzkgUrionUEFu1ie11CuiRnWzcY/+rfShQ/vcrBkSh+Vp+hw/a9QndNyvCxCbHDW7HlaoBr3+z26fx58li57pbAOsUMmzuzeVXU7uaoHxfzajjkpOuwz//jAKfpNEAej9hKiYd6QGH81VcbzldRUQ07/ZfgC/lmA1AVMcwTMuH+HqspixZrNvAE15t7Ymq5YMPCgKoAFFcJ6ACr62X4Pqf1zlcvxX0xiJ0GUul36AX54co3VcB1aFJ2Hiu6heHF3vl5wkFSN3HWtjiVeYu3E0v5bNn5DgSJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(26005)(122000001)(66446008)(6506007)(66556008)(76116006)(85182001)(86362001)(64756008)(186003)(55016002)(66946007)(38070700005)(82960400001)(316002)(33656002)(8676002)(6916009)(4326008)(2906002)(7416002)(8936002)(52536014)(54906003)(9686003)(7696005)(508600001)(66476007)(5660300002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0t4TzY5cDNGR1htU3pOaCtJaE1zRUpkZlZDcG9mS2NyWmYvNnFaaFg1bGRq?=
 =?utf-8?B?bUMxbEE5RzhtQXhXNXlPZjRLRWprdEs3YWg0aHlWREpldExoYVNGTVpzYjNG?=
 =?utf-8?B?QzhsbGIwY3hGRVg3T2l4elRKUFZTNkE0eFhjQ0tHREhPbDFQeUcyQ05STWdL?=
 =?utf-8?B?elFZamgrT2F0aVZQdE81dDcySEhzdVpjMzZnMTlxMlA1M1ppbldSYjV5VlZO?=
 =?utf-8?B?U2NEeUdWbGJvc0Nzc2NJVzJjM1VCN1VMUlE1a21kdFlZRm0rOGRwSkZSRk80?=
 =?utf-8?B?NXN4YVhhdEZTZWx2WENtbDRQQlFOZk1CZE0wanVWQkhsdEtwbmVMV01id2Vh?=
 =?utf-8?B?MmtGbjVKU1N4WDFaWEVockV0UTUwNTNtVnUyTlhLVGN2b3VTVGh4Z0hTUEVB?=
 =?utf-8?B?MTVnZVFHdFp1TlMrQkpIUU1YSHBEZVJMbTVCbS92WXVYN3U4K2o5ZCt2WkxB?=
 =?utf-8?B?OTB5aWRGRkJ5MjNUZDV0YXVFaktjSXVQNXNyVjB0c0NZR2RpQzFESkRxN1I4?=
 =?utf-8?B?NGE5dm4xc05qZ2ZUdFVBS21lalIzbG1wVm9aeHVOWW44UjdBNjk3bkp4ODBm?=
 =?utf-8?B?OE8rSnJhYVFVQjIvRVRlVFlNVmp4WnlwN1dDSUFnM3FSbEY2RjRCUzhMT2VH?=
 =?utf-8?B?MkNITzEyNzRqMmhNMEpiRVFIbXRRZHg5Zm9zNVVCaWpXU3ZZTW5weHcyb1NR?=
 =?utf-8?B?eUFtVURNY0VYeDhDMGdyMEpQZEtlVVpMRlo4cHZpckdoN0UwR2lSdVY0N2NR?=
 =?utf-8?B?RkxvTmRBSVVOS25RaGJlT0s2SDhWQnFzMjlWckdSdkVSS2pMbTJkNUVGeVB4?=
 =?utf-8?B?aEpRSytGYWpVSWllU2J4bmRIOWFJcjl6d2hWMUtRU2RGenBvTkd3WGNQS2NC?=
 =?utf-8?B?ZDhwcDg3emFWQnlTNUNxOUxmd0FReDlwYTRFQkZLSEdsbGJOWFhRRjQ1Ulp2?=
 =?utf-8?B?cGNOek1WZElpcFAvRmpzSjhDd25hQ1VsVlZGVXNseHpuQ1pEVEI0RW4wVDRY?=
 =?utf-8?B?dUpwV0lWNmJEN0tkeWtUaHhVcDRVYXl0azY3NDJBb2RyeUtKMGVKNUh6OUc4?=
 =?utf-8?B?WHlGY0xIeUFOVW5RWjBHR1M1R0k2eVpwemVSSTdpaVROVGVxSTJVeDJVeFFQ?=
 =?utf-8?B?c2RVMnl6RFB6Mk9BRTZZWjRaN1Z4Z2ROV3lIQ2pNaGZPU0ltd1pJdC9qZGlj?=
 =?utf-8?B?T1NJRll0WE82Ly9iUkRQWUk4RUNyN1U0L2VMSCs5NUpaUHVoQXlNZGZCcUcr?=
 =?utf-8?B?K2krVjhtRjdOUlA5SVdJbHZ4bDVSSzE3YmdUSjZiYldDMlBVUnVlZGtVNXZZ?=
 =?utf-8?B?Z2lVc1l6OTFVYnBQK21ubS9PNFoxMGUybHVwcC9CK2VRT2FHT2p4NEpIbjJP?=
 =?utf-8?B?eXdzZCtXOU1PbUY1a1VycWs5NHovQUtyNm93VXV6Tm96M1g4UHZNTmZ4Nldp?=
 =?utf-8?B?S0I3RGRZbytscUNjN1B6c1AvSlk5c0pZNUNWOXJKUXlteE56WnArWkRwNDBa?=
 =?utf-8?B?dHYyNFNzZVJDU2NuMU5zSExKVkRNYUI5VVNNRlVPTTAzNGxFMG9QZnRuYUE3?=
 =?utf-8?B?NFVjQ1FvcjJtaDkwd1BYUWNwSU1TVGhCZVMxLzQwSTZpVFRhQjR6RnhmZjdu?=
 =?utf-8?B?QnF5YzJTS0pPSUE0Ti9LYWFMWWdLak1VL2M0QTBqd3o2K3hXb1M5MjNxT3o3?=
 =?utf-8?B?V0NTODA2MTZ4cnlYcTQ4Zk01TnkyMlZVUmwwSGJQQlROUkU0RVV1M2NKbG52?=
 =?utf-8?B?VVVGYnhwR2pSK1NGVllrNXllWTY2eVp4Z083Q01mRC96bmNaVEtXWHdOcEFx?=
 =?utf-8?B?a2xIRnZuU3lvTlFhdzdTWXBSa3FYQkNVNEdpZGJEWkM1cHNlS293c2VVS0ZP?=
 =?utf-8?B?YkFjcmJBQk5KUkJvZGNNUnFpSU9Oak5NWTBOZERZaGJrdmJ4d3IyU092eDBy?=
 =?utf-8?Q?LCaLXxbjcNqQfPqnZSENakfvlmKg/Qt4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9c0b41-7f39-40b2-a06f-08d995239927
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 06:17:17.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nakamura.shun@jp.fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6674
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgamlya2EKCj4gT24gTW9uLCBPY3QgMTgsIDIwMjEgYXQgMDg6NTc6MjBBTSArMDAwMCwgbmFr
YW11cmEuc2h1bkBmdWppdHN1LmNvbSB3cm90ZToKPiA+IEhpCj4gPiAKPiA+ID7CoD4gT24gV2Vk
LCBTZXAgMDEsIDIwMjEgYXQgMTA6MzY6NDBBTSAtMDMwMCwgQXJuYWxkbyBDYXJ2YWxobyBkZSBN
ZWxvIHdyb3RlOgo+ID4gPsKgPiA+IEVtIFdlZCwgU2VwIDAxLCAyMDIxIGF0IDA5OjQ1OjEwQU0g
KzAwMDAsIG5ha2FtdXJhLnNodW5AZnVqaXRzdS5jb20gZXNjcmV2ZXU6Cj4gPiA+wqA+ID4gPiBI
ZWxsby4KPiA+ID7CoD4gPiA+Cj4gPiA+wqA+ID4gPiBJJ20gdHJ5aW5nIHRvIGNoYW5nZSByZHBt
YyB0ZXN0IGluIHBlcmZfZXZlbnRfdGVzdHNbMV0gdG8gdXNlIGxpYnBlcmYsIGJ1dCBsaWJwZXJm
IGRvZXNuJ3QgaGF2ZSBlbm91Z2ggaW50ZXJmYWNlcy4KPiA+ID7CoD4gPiA+IERvZXMgYW55b25l
IHBsYW4gdG8gaW1wbGVtZW50IGFueSBvZiB0aGVzZSBsaWJwZXJmIGZlYXR1cmVzPwo+ID4gPsKg
PiA+ID4KPiA+ID7CoD4gPiA+IC0gSW50ZXJmYWNlcyB0aGF0IGNhbiBydW4gaW9jdGwgKFBFUkZf
RVZFTlRfSU9DX1JFU0VUKSBmcm9tIHVzZXJsYW5kCj4gPiA+wqA+ID4gPiAtIEludGVyZmFjZXMg
dGhhdCBjYW4gcnVuIGZjbnRsIChTSUdJTykgZnJvbSB1c2VybGFuZAo+ID4gPsKgPgo+ID4gPsKg
PiBoaSwKPiA+ID7CoD4gd2UgY291bGQgYWRkIHBlcmZfZXZzZWxfX2ZkIGxpa2UgYmVsb3csIHdv
dWxkIGl0IGhlbHAgeW91ciB1c2VjYXNlPwo+ID4gPsKgPgo+ID4gPsKgPiBpZiB5b3UgZGVzY3Jp
YmVkIHlvdXIgdXNlY2FzZXMgaW4gbW9yZSBkZXRhaWxzIHdlIGNvdWxkCj4gPiA+wqA+IHNlZSBp
ZiB3ZSBjb3VsZCBhZGQvbW92ZSBzb21ldGhpbmcgdG8gbGlicGVyZiBmb3IgdGhhdAo+ID4gPsKg
Pgo+ID4gPsKgPiBhcyBBcm5hbGRvIHNhaWQgYmVsb3cgaXQgY291bGQgYmUgYWxyZWFkeSBpbiB0
b29scy9wZXJmL3V0aWwvKi5jCj4gPiA+wqA+IHNvbWV3aGVyZSA7LSkKPiA+ID7CoAo+ID4gPsKg
QXMgUGV0ZXIgc2F5cywgSSB1bmRlcnN0b29kIHRoYXQgZm9yIHJkcG1jLCBubyByZXNldCBpcyBu
ZWVkZWQuCj4gPiA+wqAKPiA+ID7CoEhvd2V2ZXIsIFBBUEkgcmVzZXRzIGl0IGV4cGxpY2l0bHks
IGZvciBleGFtcGxlLCBhdCBQQVBJX3Jlc2V0Lgo+ID4gPsKgSW4gb3RoZXIsIFBBUEkgYWxzbyBo
YXMgdGhlIGFiaWxpdHkgdG8gY2FsbCBQRVJGX0VWRU5UX0lPQ19SRUZMRVNIIG9uIG92ZXJmbG93
IHRvIGNhbGwgYSB1c2VyLXJlZ2lzdGVyZWQgaGFuZGxlciwgdXNpbmcgU0lHSU8uCj4gPiA+wqAK
PiA+ID7CoEkgdGhpbmsgaXQgaXMgZGVzaXJhYmxlIHRvIGJlIGFibGUgdG8gYWNoaWV2ZSBzaW1p
bGFyIGZ1bmN0aW9uYWxpdHkuCj4gPiAKPiA+IERvZXMgYW55b25lIGhhdmUgYW55IGNvbW1lbnRz
Pwo+IAo+IEknbGwgdHJ5IHRvIGFkZCB0aGF0IGZ1bmN0aW9uYWxpdHkgc29vbiwKPiBJJ2xsIGNj
IHlvdSBvbiBwYXRjaAoKVGhhbmsgeW91LgpJIGxvb2sgZm9yd2FyZCB0byB5b3VyIHBhdGNoLgoK
QmVzdCBSZWdhcmRzClNodW5zdWtl
