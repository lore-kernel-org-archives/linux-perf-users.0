Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B284C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E555C61279
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 09:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJRJG5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:06:57 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:4368 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231382AbhJRJG4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Oct 2021 05:06:56 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 05:06:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634547885; x=1666083885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AhHCK7bwtQIFk4LZrmHBpjXubIWbbAmrtHVVLBZTcJg=;
  b=QLJb66uVStESTaWRtisTcM4g0ftevSIBRRJFCcyYP3uaGtRpzV6XDYcx
   99EIvYagxXWPCFS1nY5OWXe8Mh8O7apsUIHKMfosmGmU4tQeX622pimvn
   7kaDg/4zmnswLTVyVAhkA+VCP7UqNo/xvHi2O3bdNlZeo9ZvSyMfg0s+O
   3HepWbFDw9Bsxzac5m8lX8O5Hk9EeFpHrs6cp1P2bkgGe3DIHnIFFP0pv
   2nuIq1Q1Zn3LmlzClBPJ/KN+88LJvArI0tP+IttiJjEyn01rbwvyJlDbl
   H6NJDsjiVcG0mjDj2B8nHPXp2Sd2rGmkn6U4Nq2p/rQQX1baprlBQbYw9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="41671706"
X-IronPort-AV: E=Sophos;i="5.85,381,1624287600"; 
   d="scan'208";a="41671706"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 17:57:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXo22UGnvIjWH31Fgd7hbECZ/k18Llj2VsghEcWP2/IKtW5blnoN1LggJyIvBPpmsjUyruvnWN9mGosat5hSjhVsSpuZQkr3vHClte8vbe4jcuf6j8AKXYezfOeQioZOpW5CU9csHrr5Lh9+CvsN0YRDgsX61syA/jpCgs2DSdsG8jxdAi163Ga7cXlahguTqxU6/p6Lgd7Iu2nXcyQi2PW+uIJv/epnY3M3MOxs+ih8vkWIZnJZLgcRG8eosG25+9glBbZvXS3BdOREH8c83GGxEikkvCYqrY4EwcRhPWtm/Xeasrb5ODG8L1XuM+R8Xue2iKGyc7iuNq1XzdGqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhHCK7bwtQIFk4LZrmHBpjXubIWbbAmrtHVVLBZTcJg=;
 b=inrRVq8I9+1FvZ9eps41sUwcsmX6+pQWZjNr+39MDRw0RDjPTT9MZXk2//vEa8uySXKxRTxGsnsg0Tn2+CPb6Dpmy/secAekzuKmkkdQwEUDCa04EvQnIp8GGa+/q1qo5gI8DLFV4JZX0cX+mGMg5SwSkaFQ7MKOqEzFx0VQglaYN748UrvsQBp14jGz4TnFyKewwhKjKaXeGQbtxEWufbtu1kULOFPcSW9nQjXF9OMAq06Ek1WbomxGHcTMesIzpNQM4Fsv9xUxeRNmOnkY7iDwZMZa2BP5uwDLZ+Mq5PEfbQsCayobQNR/ccJmk4T7eq+a6sT5ophl/flHkIqNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhHCK7bwtQIFk4LZrmHBpjXubIWbbAmrtHVVLBZTcJg=;
 b=q+nI57e2V5kj+Dwiqo+v82GSqTMAuVhjbHWJOM9DyKJnxhdJ95XQ8T+y5/Fi5wUj7NOEsgfUjG2RgWQ9wRWwBA1SIGpO0dV2wA8cAcJoBxlQMlSGKSUp2JDa/vPatN7cIH2w/VQeW0M2VOXJaQ6S7EG05r7fWUMe5si3FKHM1ys=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB3315.jpnprd01.prod.outlook.com (2603:1096:604:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 08:57:20 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 08:57:20 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Thread-Topic: libperf: lack of interface
Thread-Index: AQHXnxU1v7C7yDhEy0Gzl7rxTcNZhquPLp8AgAE//ACAHexCH4AqXPW2
Date:   Mon, 18 Oct 2021 08:57:20 +0000
Message-ID: <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org> <YTCOVGyffe+VwL6G@krava>
 <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-10-18T08:57:19.647Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 98a84bd8-895d-047e-27b8-c687dd1accd3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 973cea96-cf8d-4c21-25ec-08d992154b48
x-ms-traffictypediagnostic: OSAPR01MB3315:
x-microsoft-antispam-prvs: <OSAPR01MB33155FD004CF26A80FFAFC65F7BC9@OSAPR01MB3315.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRyo2T1bmbpIe8ulsoE9bx2myx4YsEkdTvtldPybu77oKm9KVPXz+/VwKh+Byant8Q6E+GjVCshFVRG/+8liADBigaHsCt+BDVzdnGQRlCHosB/q7Xcg4yQx4G6zdPT+aySVPHSQBSC+qJTy8FoCRV8wnkhxZZeoYT/zDd+/V5xr1S5jyabw2qYJHTu/Mv2/BOYjuTI6Ig8Vc2DCW8WVlxpScBk8g+CzkNx6AtGdTxWA2GNi65wdz0FSgFuHLUy4q9dFHf98k7EG4DfwCYGJRFWAbuk0ZHGKd/j9zKTkAPx3GxNYxheD4ThjONIUhE+s5CmmX71sCWpRZnP2aGMR6Xd2dusqMdscXmpJMfrc8FXLwRiRw91uZ/k3c0HHOZwR0GtRXM86c4lN5QC+c8KJaOMrtMDfC7xmvXeuEj0ipA1wqMAEHVLY01SImBnI+kZvegpezMipQXuRl5YOMufcS/VsQ4zX2rysmySVZmvpM7TjV+o9HDlZTj3P50olzPfyQ6Hy5XbXK/dsT4pfAVwekB1bbtYw/OPxFCqI09rgin8dkMeb3updAlpO7fPrwPchdvwYeJyazVh9uFogUX7jDl9Xb/mzEjVZaQI9cws++gIMBbeJTNvOxwFUV2DsBNlvCY3y163bDCvT3w6tIuLxgrWqUwEdGZlZMl6mCsEtUBFEgy/eK5IzHxHCsjeOHdkdOeDV3XiDZHrvkak8w1pT+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(316002)(5660300002)(66446008)(2906002)(85182001)(8676002)(38070700005)(55016002)(9686003)(508600001)(7696005)(4326008)(26005)(186003)(38100700002)(71200400001)(7416002)(52536014)(122000001)(86362001)(6506007)(76116006)(66556008)(64756008)(54906003)(82960400001)(8936002)(66476007)(110136005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3JvRThoNlJkRUNXYll3K3FHRkRvRnNWaEdwTjlGdmF1WmRCaHJ2a3VkN3pr?=
 =?utf-8?B?cnFXeHdwTlA0R1BXbmsrQ0FNN0pSc1JNMzhGbEN1V2VSeHlpMGpyS3J0OUU5?=
 =?utf-8?B?OFlkRjg3Q1RWaDk2RzNHNE9QM3ZaQU9mUTY3Myt5YjJHcFM5NUZteUluV2VP?=
 =?utf-8?B?OXNCT25JYWkra0ZDWjliK1FVK21na3ZaYmg1c2c3WVZMYWtpZ28wVzZ4VU92?=
 =?utf-8?B?NDYraUlVaEQ3WEs0UVMrSTRBMU1DR2wrNEphUE1LZkwvdGdQNkNmT3VZcjEx?=
 =?utf-8?B?NHhIbHU0Y1BvVFV6dlp0WFluSjBRc0RJMUkvYllocHpRa292S2RjWEVjL3RK?=
 =?utf-8?B?UkI1bUNybVdQSUZlVGJMZCsyNVdKcGhlNWlaWXh2YjV4ZWdnMzFOZ2hnRktE?=
 =?utf-8?B?dDVQb3ZNcysyRlltSlVXK1FiSmFLTS80alNScjZvVDF0T0xyZDRSMEQ0c2Rr?=
 =?utf-8?B?VW9SOXNIMVA0cENpWCtRd0cyK2JQWEVwbjMzTWJneWZKZFM0M1MzS3MvUTlH?=
 =?utf-8?B?cjY0RzY4OXVMSmQvV1lGamQrS2pPTWhmU2d4VTNNazhiK1pTbXl3RXdGMGRp?=
 =?utf-8?B?LzVSZUV5RUNaSDdNRmFuMlhiUHBTY2NsTE04cjNYZExGN3FkWExHa293OW9u?=
 =?utf-8?B?TngrTFVjaW80TmNwc3YyRFRRVFNlRXFESEVkWFZEUW53SWF0aU5IMmovUmFS?=
 =?utf-8?B?N0Fld0NqTERNNVFIdUg4VCs1MWlhazVvM0orenpDMEc3eTJ4dUNQcDdsUWdX?=
 =?utf-8?B?UlpiSU9jWDlCdHpnTDJWY1NBc1pkVklESHBNNjIxaGVVdVNseFcweUF4RlYx?=
 =?utf-8?B?RDNZSWk2b0x6VU9TMHU5SWVDRHlYblcxV1ZmMVJNVnNzcjVnMVE3QmhXVXZm?=
 =?utf-8?B?OW1yaXEralRFRTRjR2JXTDFqS2R4NGJRRW92UEphcG8xNFE0YWUvYStZbndL?=
 =?utf-8?B?TE9qZGxWT29OVGdEanBDRXV2VU56Y2xpaVZpNlNlSXRtRSt3cmhiR3NKV2NH?=
 =?utf-8?B?V2ErbXhLNXd0ellXYVhSVGJsb1ErQzd2RzdMT3AxSFJtUWVNNm5YR0xSMzVG?=
 =?utf-8?B?Z29Na21jUjZrR1BGQWJ1cWFlTksxdkRNaC9FcHFpdTM0MmFFbmxadW9GMVhW?=
 =?utf-8?B?VWFOTkUvWlJlbGNELzN5MkQ0bUZGb1NQYVBCNklZMEFPVVNTeVJraWU2YThW?=
 =?utf-8?B?aTJoZ0J5L2RXTlZuam5EZGppTlhncW1OYWY4M3k4Z09EYmpNb2VkSTlMK09p?=
 =?utf-8?B?bnZRVlJQUVRicjRNZEFjZ3VXTGlxVmNnL1B4YXdMbitIUlNQN2dOM3RMZjJy?=
 =?utf-8?B?UVpxaUxsUXRya3I2S1ROZTZZUnlrSDBZNGE0RmdMRlRMcTAzZ1BBRkNuSkJM?=
 =?utf-8?B?a3pleEo5TE5xd1lCeS95aTRvWkNXRVRKMDQ0ZlRJQVNKWWx2TWU2OFFVYzRn?=
 =?utf-8?B?YWxxWVU5NXArYVg2aFM3azQ1SFI0SzlEQW9nbk9EdnlydCt3UHQwTlhKZGlm?=
 =?utf-8?B?QlZlQnA2OWlsQks5ZHl3ZGZ3dUo2SnVjbERxQUtuR3NZMWc1dlEzTDcxRDhl?=
 =?utf-8?B?ek5pWHFIcG1DV2hSdGk2R2tCc0RpeS9vQWlYSHRtVUtSa2FTNk55UnpDQ09w?=
 =?utf-8?B?QldNOEo0bCtSeHB2dWtIcXNHRHd6NVdnazZVWUJiWGI2R2FwcmROeFdNR0JD?=
 =?utf-8?B?M1JtV3ozS3lQVFFML3hxOXpvOW8rY1JQWk9aNno1bnArV0d6TExPNkd5RUUr?=
 =?utf-8?Q?hTtBbQvUm6ZG6dw4lI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973cea96-cf8d-4c21-25ec-08d992154b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 08:57:20.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rv+u2ijoRSw3K0zsLfaoslZzdEcHI+VLQnWO1M5vz8accD1He1Fd6New/tJda6Kp4RQgd9HVmQLxi6rTwB5ZlMq5xzRCcR8okyrJ5YN2i9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3315
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkKCj7CoD4gT24gV2VkLCBTZXAgMDEsIDIwMjEgYXQgMTA6MzY6NDBBTSAtMDMwMCwgQXJuYWxk
byBDYXJ2YWxobyBkZSBNZWxvIHdyb3RlOgo+wqA+ID4gRW0gV2VkLCBTZXAgMDEsIDIwMjEgYXQg
MDk6NDU6MTBBTSArMDAwMCwgbmFrYW11cmEuc2h1bkBmdWppdHN1LmNvbSBlc2NyZXZldToKPsKg
PiA+ID4gSGVsbG8uCj7CoD4gPiA+Cj7CoD4gPiA+IEknbSB0cnlpbmcgdG8gY2hhbmdlIHJkcG1j
IHRlc3QgaW4gcGVyZl9ldmVudF90ZXN0c1sxXSB0byB1c2UgbGlicGVyZiwgYnV0IGxpYnBlcmYg
ZG9lc24ndCBoYXZlIGVub3VnaCBpbnRlcmZhY2VzLgo+wqA+ID4gPiBEb2VzIGFueW9uZSBwbGFu
IHRvIGltcGxlbWVudCBhbnkgb2YgdGhlc2UgbGlicGVyZiBmZWF0dXJlcz8KPsKgPiA+ID4KPsKg
PiA+ID4gLSBJbnRlcmZhY2VzIHRoYXQgY2FuIHJ1biBpb2N0bCAoUEVSRl9FVkVOVF9JT0NfUkVT
RVQpIGZyb20gdXNlcmxhbmQKPsKgPiA+ID4gLSBJbnRlcmZhY2VzIHRoYXQgY2FuIHJ1biBmY250
bCAoU0lHSU8pIGZyb20gdXNlcmxhbmQKPsKgPgo+wqA+IGhpLAo+wqA+IHdlIGNvdWxkIGFkZCBw
ZXJmX2V2c2VsX19mZCBsaWtlIGJlbG93LCB3b3VsZCBpdCBoZWxwIHlvdXIgdXNlY2FzZT8KPsKg
Pgo+wqA+IGlmIHlvdSBkZXNjcmliZWQgeW91ciB1c2VjYXNlcyBpbiBtb3JlIGRldGFpbHMgd2Ug
Y291bGQKPsKgPiBzZWUgaWYgd2UgY291bGQgYWRkL21vdmUgc29tZXRoaW5nIHRvIGxpYnBlcmYg
Zm9yIHRoYXQKPsKgPgo+wqA+IGFzIEFybmFsZG8gc2FpZCBiZWxvdyBpdCBjb3VsZCBiZSBhbHJl
YWR5IGluIHRvb2xzL3BlcmYvdXRpbC8qLmMKPsKgPiBzb21ld2hlcmUgOy0pCj7CoAo+wqBBcyBQ
ZXRlciBzYXlzLCBJIHVuZGVyc3Rvb2QgdGhhdCBmb3IgcmRwbWMsIG5vIHJlc2V0IGlzIG5lZWRl
ZC4KPsKgCj7CoEhvd2V2ZXIsIFBBUEkgcmVzZXRzIGl0IGV4cGxpY2l0bHksIGZvciBleGFtcGxl
LCBhdCBQQVBJX3Jlc2V0Lgo+wqBJbiBvdGhlciwgUEFQSSBhbHNvIGhhcyB0aGUgYWJpbGl0eSB0
byBjYWxsIFBFUkZfRVZFTlRfSU9DX1JFRkxFU0ggb24gb3ZlcmZsb3cgdG8gY2FsbCBhIHVzZXIt
cmVnaXN0ZXJlZCBoYW5kbGVyLCB1c2luZyBTSUdJTy4KPsKgCj7CoEkgdGhpbmsgaXQgaXMgZGVz
aXJhYmxlIHRvIGJlIGFibGUgdG8gYWNoaWV2ZSBzaW1pbGFyIGZ1bmN0aW9uYWxpdHkuCgpEb2Vz
IGFueW9uZSBoYXZlIGFueSBjb21tZW50cz8KCkJlc3QgUmVnYXJkcwpTaHVuc3VrZQo=
