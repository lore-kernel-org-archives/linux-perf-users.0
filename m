Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29338C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 05:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A75D60EE2
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 05:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhJSFJV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 01:09:21 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:64554 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhJSFJU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 01:09:20 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 01:09:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634620028; x=1666156028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sBd9ENDSistdOAFohylINuO9Y4HDVtEtXP3fziLEP94=;
  b=Z9M1YN1PaOxM/cJkrAbdFpHMULwh4Q5prq3zYic/u9ThXH/WaHoP2CxT
   YrJLimb0c2lBxS4TJgxDDjDpwr7SBNp8gHKAVMedvqbvQnnDOrMDXDFCU
   1tojj+zvcvR0UYtq1YId26/47ukb70FvE1YCiyiuANuAsg5B204Gv1XdJ
   9UlRG+WQF8pqvNaRij2yBVOMEQQIN2s+EViunVeFIghdHm+JepxgoicFE
   bcuGm+9UerTov7o0pzwJuHG5Xq2kSwX6Kaacbmb6LZmZ2DlvbEdsX7wD+
   +T8TxmsEd7azGuF8NlxZn3F+6embeasMYgeK4Jly15wxqWGVeRRalf9Gz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="42469690"
X-IronPort-AV: E=Sophos;i="5.85,383,1624287600"; 
   d="scan'208";a="42469690"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 13:59:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkRcghkBPqeaWx9zpSHbCvh+fJnuTBMmYeN7T4GjoDoLL3Msp75t1PG3qLkHENs+0QlL4gHwLiZ/6dUbFLvYCj6x5GDTBPWD8kaP39SPXokGyNUo4D1pxfPxGW2FcHoRlA4BnYAjBOc7XZ7SjIJdP0zTw1VmnnnH1i3XGUj/h/rzx2AyDE4Iyz7dopDc9Nr8VyKj4tVBrhgygpjZsUTXkeRMmhMlpLrzAtmXH3b2cC+JvdythB52KZVsLtHSQj1T4HZfTtcBMPsiwxoKRf8Vtj8ZOnzcxomKZ0cp+2bfQFnYk8HLZlxUDVmdDh1N6khmVpkNNJzqRCVJYb0CCgDOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBd9ENDSistdOAFohylINuO9Y4HDVtEtXP3fziLEP94=;
 b=V3Zl4jI1HG5/nQjY5K44ZtYw50wAGbxSNpbLLBYEHo5b5Y+2jgoq1As9BYDzw+Fs98aFIZlb9whX0XmhlNkpIgzjT7GLNdGWlLQwgLvT1Nhexmw/nszGpZbwLSrgj+B1/FdW6jtjRrQQ9Kt+8prxJxJiIzYw28M0ZuelMYUZVFM4zY3jnhmz3hV1jBxAd6wE3b2cTQTuHeL9r8HvHgNNeZgv89NdHyUzGJswJ2l/X4k57t5Jz5jRPpTDkPD2/EEEbE3VelmrqZzPPlQKyTEEgf73wRrY574VUN3ZuXKG6DHtWUrg26TPwWCM+RqbUwXPwiIc0s1vDAaLT4ONg+y2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBd9ENDSistdOAFohylINuO9Y4HDVtEtXP3fziLEP94=;
 b=ZbslecrlspGKeFM6gG24Q8F+yi4Kzvzevwut91PHfMd49TKc4gTtEWHmIFvOd4WBvPOIXzPjflZLBX8oUCEHkpdeNs4B17GF1UN7oSlqLr4y7KjmJI32SfF3XEo70DUBHxtX9ZQILyTpjWnFQR0NDpih/e8IO7/e/tsME1EuEdo=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSZPR01MB6845.jpnprd01.prod.outlook.com (2603:1096:604:137::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 04:59:52 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 04:59:52 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Topic: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Index: AQHXr/my+5dH1blYnk6QsbLwDlVC2au5Oj0LgAt0DQCAFTqT4g==
Date:   Tue, 19 Oct 2021 04:59:52 +0000
Message-ID: <OSBPR01MB46009B2C54D32B836B73CF9BF7BD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com> <YUuhe7e0J0PSea+b@krava>
 <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <CAL_JsqLrHLmEM06mxJ8V304VTmKHYU8Pca5h=jMJQe1beoXbDw@mail.gmail.com>
In-Reply-To: <CAL_JsqLrHLmEM06mxJ8V304VTmKHYU8Pca5h=jMJQe1beoXbDw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-10-19T04:59:51.601Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 8279637f-2397-1c68-d455-2a4a5f1af33b
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7530a28e-f3fd-44a6-9931-08d992bd490c
x-ms-traffictypediagnostic: OSZPR01MB6845:
x-microsoft-antispam-prvs: <OSZPR01MB684571FF93DE8D2882FA9DD5F7BD9@OSZPR01MB6845.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAsZV7iDiB4JJCkkY6xHzm2TWr3fgYim7UyfZ1XT+4z5Qgk/oYQ2/jkwDdQgJJAjN2Y/PqDwngXaF5SkvMszoodbmJ0pFQ7SXI4d5hJLwqkNEVk/YL7FqVpXHm3Oaf94q+YUgt0UT8odQmUEEDbzvaBfx2GcCCLi/umKH/Rnj947qFjgnTBO6gyXPzOHApE1fftJ5nIiIffQsWP8M4oPxSxxNsLQQaBI1N8QeD5Icaz9SZ2kXDDwGIoxLMwcs1xTMGfHvEMGW1FDE6ln/9RVnTCyhAgz1AAvqg6626W30sVk74EL3K/Jh7cV6U+xXXSQBoq9UoHiXqXZcsIF6DMrdMsvyCT0VnY+zqmVjhXphckNPeqH8bjFttq7UGsnr7zFMrtRJ3YA5K7DWVY8yfPN4pyWJpzwGTz21j0Vr4FhMLGsk2Rzf3aeIIAeXE/gSq+oUJoF5i3A+5W3jAe+caPgHQhrDQ+usUdjRA1IfWZYdH7JAA3sjfVKLFXAWNgdQlA/hKFOGt87RqlmtmIC0PUJqmzHIWFar9TM5wue9B9g8PmbQG1fimwGSx06WQ7GzUTwB7YDCh8rb+iymYrjzXaDV+fiewKULA1sCzPBt/VHGKBO16v9UcDjcqEIIufVNp1DuHjxiylkhD9PA/irleCqSjivye6mc0bU1jS+MuWa8qoxvFvRGVNOV1aUa5qGCHgmOlK9dzVuYdc1JrPMqQeuIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(186003)(122000001)(26005)(6506007)(38100700002)(66446008)(66476007)(6916009)(8936002)(86362001)(55016002)(64756008)(9686003)(66556008)(7416002)(2906002)(4326008)(38070700005)(52536014)(7696005)(8676002)(5660300002)(316002)(66946007)(83380400001)(71200400001)(82960400001)(508600001)(85182001)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXkxSGRKeVBCSmZOOFZoVXlXQ3h5OTRjZm1MQ0ZyeHNIaHBnSjVZYzRzOWVV?=
 =?utf-8?B?ZUVsV2cyU3VLejZha2E4SW1URElZU1c3YmxjNEx3Ykt3Uzc2dzAxaWFrcnZS?=
 =?utf-8?B?aGxvUEhYT3c1cGF0dHVSc2xXR2piSGxXSzlJVWRLUExMZUxpbEJDSnpKRjBp?=
 =?utf-8?B?S2V5Y0VOaUp1T2ZsVmxSdlg5RzRYQm9leXVmU0RVTlJEZlpjdlV3cDFFaFM0?=
 =?utf-8?B?bDVYbFoveTRDd2xLT0ZROEVDbUtlWWFtcGxpNEJENXFLY1NpVlZBVmZRVjBs?=
 =?utf-8?B?QTM4SXN5S2F3QmtFQlczYXMvakg2a3FyZ05lb1JXUWIzUkx0RE9ESmNEdFZt?=
 =?utf-8?B?MWVvd2R5ak5WSkU0U1c0MWtGSFdQUG56MjRtdEltdzVYSFVneHhNSG9UTVlU?=
 =?utf-8?B?aTAwcXU2b01YZy9Sa0VYenFjVm8wL3o3L3lGeVFmN0NLN0Zuc05IR2R1dXV6?=
 =?utf-8?B?TjlNQlR1c05FMUc5TzZMMzFBdG05VWxwUWxhOGEzYXpBUzJ0VmJ0SEJrQkxn?=
 =?utf-8?B?OUxaalcrK0g4SlNTVm1sdlN4QjRsSE93UnUxdm9zQ01QdWVzT2tZQkJmcFkz?=
 =?utf-8?B?cVZVRWtwWnliR2VCYzQ2ZlkxZHRBZEtZd2QycGxESlpLQUViWC90TURwc2to?=
 =?utf-8?B?cUNod0VNUkRmcSt1amxEcEswQjFLTE1VY3lvNWl2SEQyWndJbUwyNWJVbmwz?=
 =?utf-8?B?S0Y2UXVFTVpLUlpmNW02SmhBOGEwRzB5d1o5eExvTUdLOThHMGRoaE9ibmFu?=
 =?utf-8?B?TW9YQ1Z4QTgwNWVsVXNCbEQvZGUwalRmQkpJWU45QlhnS1NndXFUSnc5WUlk?=
 =?utf-8?B?eWd1SDRDbHZXU1dkVld4UU5GYkh2Sm5nWFdybDMrWFVmbWFWQ21vbkU1ZXcw?=
 =?utf-8?B?S2tnbG9QNFNRVGFYOTBsUEJSNEE1NDdsVVB0dnBwOHNBanFKWTVkNms0UHE4?=
 =?utf-8?B?QmpudHpwbGdmZGdTQmk2NWVHVXY4TkpnREJIZUZIV3M5YkxOY1I0VDJlc2F3?=
 =?utf-8?B?MHgyVGoxSmRoUlVqek1qS3RyWTVqSm1Tb3h1S1FMZnpiQzdXUlJUbk5GbGNK?=
 =?utf-8?B?SWtrSTZHWFlPUGpscVg2bThDMjFHTWJFQWY4bnVFRC95eGltcnVnNFNpc0Ez?=
 =?utf-8?B?ZnJHUElWMTYyZWNNQzFGN3pkcEJtcklDNForbXVBcnF0Ry9BbXdlVmdpUHFI?=
 =?utf-8?B?Y3N5YmJmWnJveWtyN0VqNGViTVZJQkZ5Q3ZkRWV1ak1YaTRpZ3Mrbml5SXVv?=
 =?utf-8?B?OGdCc3RWengvekdHdHFnZXZhYXd4NGJyUWRiU2M0U0tNRHlrbmdseGl2T0lO?=
 =?utf-8?B?TnpxYWxyS1o5NENmaWp1MjRtOUExK1JxNGU0cW5qd21kZVFsbW9zUm5RdFVo?=
 =?utf-8?B?Ky91WW52aFJUTjNlQjBqRUkvU0FrSllFdzZOeDJrQldQTGs2TmhYaGdwM0J2?=
 =?utf-8?B?ZzdOR210aHRUa2F6YWFXV2FCZXV4eHdsSFc4K1VZOHVQMDYvbmZzbnJac2x2?=
 =?utf-8?B?WFpCR3VBWEkyaHorMGRWWGg0dzI3VEhzWXhTSDZqSFpTTkJIbzY5Yk9WLzhZ?=
 =?utf-8?B?VWhtWVpwOGdTcENPSEJFY28yTGg2aDBraWhJSTVCOWh1K1Q1NFVaNHA1UXFn?=
 =?utf-8?B?d3AybzB0c1FFVUp1MjN4Ri9ZOEVxUWUybkF4anNlaml0TFZ3WVVwRE11YWMr?=
 =?utf-8?B?VHA0WS93ckVYZC9PbE14eHBPeW1maXp4ZkxJOTVIUmZZVEhqZVMwZ3M5VE1v?=
 =?utf-8?Q?zlqUklqOv/Kz8LFN1E=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7530a28e-f3fd-44a6-9931-08d992bd490c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 04:59:52.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4s8zCtcWtpWjyvq8Gq5FKrK/GMHyNeCukJJ+xPdXzlyJeBqbX9WoZwQs3CUw/1uCJeTWsCiP93YNyv02vsokuwIrYlzqHRYwUB6ZdQOIHAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6845
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgUm9iClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4KCj4gPiA+IE9uIFdlZCwgU2VwIDIyLCAy
MDIxIGF0IDA3OjE2OjI2UE0gKzA5MDAsIFNodW5zdWtlIE5ha2FtdXJhIHdyb3RlOgo+ID4gPiA+
IEZyb206IG5ha2FtdXJhIHNodW5zdWtlIDxuYWthbXVyYS5zaHVuQGZ1aml0c3UuY29tPgo+ID4g
PiA+Cj4gPiA+ID4gcGVyZl9ldnNlbF9fcmVhZCgpIHNjYWxlcyBjb3VudGVycyBvYnRhaW5lZCBi
eSBSRFBNQyBkdXJpbmcgbXVsdGlwbGV4aW5nLCBidXQKPiA+ID4gPiBkb2VzIG5vdCBzY2FsZSBj
b3VudGVycyBvYnRhaW5lZCBieSByZWFkKCkgc3lzdGVtIGNhbGwuCj4gPiA+ID4KPiA+ID4gPiBB
ZGQgcHJvY2Vzc2luZyB0byBwZXJmX2V2c2VsX19yZWFkKCkgdG8gc2NhbGUgdGhlIGNvdW50ZXJz
IG9idGFpbmVkIGR1cmluZyB0aGUKPiA+ID4gPiByZWFkKCkgc3lzdGVtIGNhbGwgd2hlbiBtdWx0
aXBsZXhpbmcuCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNodW5zdWtl
IE5ha2FtdXJhIDxuYWthbXVyYS5zaHVuQGZ1aml0c3UuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+
wqAgdG9vbHMvbGliL3BlcmYvZXZzZWwuYyB8IDYgKysrKysrCj4gPiA+ID7CoCAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
bGliL3BlcmYvZXZzZWwuYyBiL3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMKPiA+ID4gPiBpbmRleCA4
NDQxZTNlMWFhYWMuLjBlYmQxZDM0NDM2ZiAxMDA2NDQKPiA+ID4gPiAtLS0gYS90b29scy9saWIv
cGVyZi9ldnNlbC5jCj4gPiA+ICsrKyBiL3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMKPiA+ID4gPiBA
QCAtMTgsNiArMTgsNyBAQAo+ID4gPiA+wqAgI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgo+ID4gPiA+
wqAgI2luY2x1ZGUgPHN5cy9tbWFuLmg+Cj4gPiA+ID7CoCAjaW5jbHVkZSA8YXNtL2J1Zy5oPgo+
ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvbWF0aDY0Lmg+Cj4gPiA+ID4KPiA+ID4gPsKgIHZvaWQg
cGVyZl9ldnNlbF9faW5pdChzdHJ1Y3QgcGVyZl9ldnNlbCAqZXZzZWwsIHN0cnVjdCBwZXJmX2V2
ZW50X2F0dHIgKmF0dHIsCj4gPiA+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW50IGlkeCkKPiA+ID4gPiBAQCAtMzIxLDYgKzMyMiwxMSBAQCBpbnQgcGVyZl9l
dnNlbF9fcmVhZChzdHJ1Y3QgcGVyZl9ldnNlbCAqZXZzZWwsIGludCBjcHUsIGludCB0aHJlYWQs
Cj4gPiA+ID7CoMKgwqDCoMKgwqDCoCBpZiAocmVhZG4oKmZkLCBjb3VudC0+dmFsdWVzLCBzaXpl
KSA8PSAwKQo+ID4gPiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtZXJy
bm87Cj4gPiA+ID4KPiA+ID4gPiArwqDCoMKgwqAgaWYgKGNvdW50LT5lbmEgIT0gY291bnQtPnJ1
bikgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNvdW50LT5ydW4gIT0g
MCkKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3Vu
dC0+dmFsID0gbXVsX3U2NF91NjRfZGl2NjQoY291bnQtPnZhbCwgY291bnQtPmVuYSwgY291bnQt
PnJ1bik7Cj4gPiA+ID4gK8KgwqDCoMKgIH0KPiA+ID4KPiA+ID4gc28gSSB0aGluayBwZXJmIHN0
YXQgZXhwZWN0IHJhdyB2YWx1ZXMgaW4gdGhlcmUgYW5kIGRvZXMgdGhlCj4gPiA+IHNjYWxpbmcg
YnkgaXRzZWxmLCBwbGVhc2UgY2hlY2sgZm9sbG93aW5nIGNvZGU6Cj4gPiA+Cj4gPiA+IHJlYWRf
Y291bnRlcnMKPiA+ID7CoMKgIHJlYWRfYWZmaW5pdHlfY291bnRlcnMKPiA+ID7CoMKgwqDCoCBy
ZWFkX2NvdW50ZXJfY3B1Cj4gPiA+wqDCoMKgwqDCoMKgIHJlYWRfc2luZ2xlX2NvdW50ZXIKPiA+
ID7CoMKgwqDCoMKgwqDCoMKgIGV2c2VsX19yZWFkX2NvdW50ZXIKPiA+ID4KPiA+ID7CoMKgIHBl
cmZfc3RhdF9wcm9jZXNzX2NvdW50ZXIKPiA+ID7CoMKgwqDCoCBwcm9jZXNzX2NvdW50ZXJfbWFw
cwo+ID4gPsKgwqDCoMKgwqDCoCBwcm9jZXNzX2NvdW50ZXJfdmFsdWVzCj4gPiA+wqDCoMKgwqDC
oMKgwqDCoCBwZXJmX2NvdW50c192YWx1ZXNfX3NjYWxlCj4gPiA+Cj4gPiA+Cj4gPiA+IHBlcmhh
cHMgd2UgY291bGQgZXhwb3J0IHBlcmZfY291bnRzX3ZhbHVlc19fc2NhbGUgaWYgaXQnZCBiZSBh
bnkgaGVscAo+ID4KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50Lgo+ID4KPiA+IFRoZSBw
dXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gdW5pZnkgdGhlIGNvdW50ZXJzIG9idGFpbmVkIHdp
dGgKPiA+IHBlcmZfZXZzZWxfX3JlYWQoKSB0byBzY2FsZWQgb3IgdW5zY2FsZWQgdmFsdWVzLgo+
ID4KPiA+IHBlcmZfZXZzZWxfX3JlYWQoKSBnZXRzIGNvdW50ZXIgYnkgcGVyZl9tbWFwX19yZWFk
X3NlbGYoKSBpZiBSRFBNQyBpcwo+ID4gYXZhaWxhYmxlLCBlbHNlIGdldHMgYnkgcmVhZG4oKS4g
SW4gY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgY2FsbGVyCj4gPiBnZXRzIHNjYWxlZCBjb3VudGVy
IGlmIGdvZXMgdGhyb3VnaCBSRFBNQyBwYXRoLCBvdGhlcndpc2UgZ2V0cyB1bnNjYWxlZAo+ID4g
Y291bnRlciB2aWEgcmVhZG4oKSBwYXRoLgo+ID4KPiA+IEhvd2V2ZXIgY2FsbGVyIGNhbm5ub3Qg
a25vdyB3aGljaCBwYXRoIHdlcmUgdGFrZW4uCj4gPgo+ID4gSWYgY2FsbGVyIGV4cGVjdHMgYSBy
YXcgdmFsdWUsIEkgdGhpbmsgdGhlIFJEUE1DIHBhdGggc2hvdWxkIGFsc28KPiA+IHJldHVybiBh
biB1bnNjYWxlZCBjb3VudGVyLgo+ID4KPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvcGVyZi9t
bWFwLmMgYi90b29scy9saWIvcGVyZi9tbWFwLmMKPiA+IGluZGV4IGM4OWRmYTUuLmFhYTQ1Nzkg
MTAwNjQ0Cj4gPiAtLS0gYS90b29scy9saWIvcGVyZi9tbWFwLmMKPiA+ICsrKyBiL3Rvb2xzL2xp
Yi9wZXJmL21tYXAuYwo+ID4gQEAgLTM1Myw4ICszNTMsNiBAQCBpbnQgcGVyZl9tbWFwX19yZWFk
X3NlbGYoc3RydWN0IHBlcmZfbW1hcCAqbWFwLCBzdHJ1Y3QgcGVyZl9jb3VudHNfdmFsdWVzICpj
b3VudAo+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3VudC0+ZW5hICs9IGRl
bHRhOwo+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaWR4KQo+ID7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY291bnQtPnJ1biAr
PSBkZWx0YTsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNudCA9IG11
bF91NjRfdTY0X2RpdjY0KGNudCwgY291bnQtPmVuYSwgY291bnQtPnJ1bik7Cj4gPsKgwqDCoMKg
wqDCoMKgwqAgfQo+ID4KPiA+wqDCoMKgwqDCoMKgwqDCoCBjb3VudC0+dmFsID0gY250Owo+ID4K
PiA+IFJvYiwgZG8geW91IGhhdmUgYW55IGNvbW1lbnRzPwo+IAo+IFN1Ym1pdCBhIHByb3BlciBw
YXRjaCB3aXRoIHRoZSBhYm92ZS4KClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50LgpJIHdpbGwg
c2VuZCB0aGUgdjMgcGF0Y2guCgpCZXN0IFJlZ2FyZHMKU2h1bnN1a2U=
