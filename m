Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4093CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 05:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A54061038
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 05:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhJSFJc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 01:09:32 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:64565 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233040AbhJSFJb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 01:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634620039; x=1666156039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vZ2Mr9IFN5On5vk9K4Scp6ebSW5nEUazgxqScHjvq0Y=;
  b=SBaHreqeZfN1a4eWcYuCANOsl/dn41wMS+PYCY6pRm9DMbdQ5CanAP1u
   YhOq0LnlYZu7WCUOC562YGUHq2HMe00tFrW8V2stpYcSrFLQmY8JZyGPG
   qV3ojCfA21hQVBD1cDh+yKa/icZ7ORnNWxcZN7j0ChwD+0KPWFm91wyGu
   yX8AevSmEiBLsAlnCRwZBz9EwEs6wf243xaNTuBS0MuXsNzEt5J2v/09A
   8iZHOn6Yn8JJjVmLCwA+qVNd4FzVZl0m0gzL14OHuchiIoPABulVUSxTx
   235ayUn7GEoJRDVIQf8ZBE+8t6hnVA2E72ZeW1iLYfdwHND1rfWzofr39
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="42469712"
X-IronPort-AV: E=Sophos;i="5.85,383,1624287600"; 
   d="scan'208";a="42469712"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 14:00:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKGsD4UE1t4Wr5vVOslxSV+ddQYlBnvujArOMPpFYicL1sZvjPFJ+/Y1dVfbViFr6Wbe3vTWiROFn4nov9amxJlGJMRsyhJLIC1E8HMSGlnBs696kmxsPLrRUjWG0HBSAJOnBVFLVbXfhWmRDs4c/eCHjxvgEJZh4wpJtyVzPQoZrFsu4hFVFpA/hIObgRQtN9lkhfqpBmH+7GDocpzXtno2yd3LXLWlcI08l1hUOMu0Vg9/LrwSTAVD9iORSv7oAeeNxdAG503tN4Q9aYHcc9+9xr+oyvecY+mdNwMSAMvvascc07PVT4SfrXWdlW+a57eH6WCBKvzntsdGbbf1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ2Mr9IFN5On5vk9K4Scp6ebSW5nEUazgxqScHjvq0Y=;
 b=DU7vdb3Q34Sr2xBnMs14cwdFEUs66WEwYhRNKWUyAkWovlF/dGVOelChcipFbjO1s8unnpLUy6USY0mcfj55uuxKhoVZYj4pjXS1k3+mbB8Hu/RUgonrQLatnrHF1bhp8R+CDqZTCtoUnXD/Be2n+mO915DqEr0ms9cDht9WieEjLJjUuA/ctI7DEB9zJQ5FTo0lyI5fjP/qhscpIg1alOLFA2CkXnr3aUrybAz5FMGpj5DAiOi95gfEhb3h91j02oTPjpANcpleumSYPP0YfPw0eo+Fb97Fil0ycmt706UgojGhDPhtyOFjP1tU8A7nYkvlSUCq6Oa/c1ZrR7BXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ2Mr9IFN5On5vk9K4Scp6ebSW5nEUazgxqScHjvq0Y=;
 b=ZPhjjb8T65uw/RXdlfXeFwhM9o17A3EpynEqa7Zz25N77Xq+ImNUq1GH5OYiqgCFsOP8mtQhlMERFoWpcT9fbr8CzdXUzSDsbJu1Nvh1oXhI5kNdT8r1TbD9X9goFHapL/mHQNgvnooYDYUAriAHPBNZSSsft00rcf7aPTwejMg=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSZPR01MB6845.jpnprd01.prod.outlook.com (2603:1096:604:137::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 05:00:03 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 05:00:03 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Rob Herring <robh@kernel.org>,
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
Thread-Index: AQHXr/my+5dH1blYnk6QsbLwDlVC2au5Oj0LgA6kMwCAEgxlYg==
Date:   Tue, 19 Oct 2021 05:00:02 +0000
Message-ID: <OSBPR01MB46000071426DEC8FFF04C4F6F7BD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com> <YUuhe7e0J0PSea+b@krava>
 <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YV8rpPWOgFa5ARlU@krava>
In-Reply-To: <YV8rpPWOgFa5ARlU@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-10-19T05:00:02.508Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: ffafe366-6684-c93e-abc5-7bdf57898432
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a28be2d9-21ec-4e79-b2b5-08d992bd4f8a
x-ms-traffictypediagnostic: OSZPR01MB6845:
x-microsoft-antispam-prvs: <OSZPR01MB684561A18C4DA48B2DB3809FF7BD9@OSZPR01MB6845.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8GXwbfohx3U24CVUyXAmHRUspqwsYjj44WWUxFIm1uCqgYLMIR4v+r3EDg5w5FkPD04/gfxtpLxeKExeN2t3fNaVO9mtbi7fMq5YqD49uRJRr++sOL7tEz4M85obwsVQ9SHJembVlMIYCR8S6ojmoFg52jUzuJxdsVfn4ESQAFa3Tkt9KSpkaWCMz/2sGzUZsTGihYHAFBL2EycCByr/EfrSqisPtxfoPBCIjypznce+aqQ3x42tvXSF3FiSe9CpbtbquyKL9j/9WbaX4PKJAG0xIzDN4DtiOyNTX4mVk97S1HGhAkV6zkIzPRdbFz4gvrVpMKacn37a725z8CHQzFtcsMDm0r9zWD48JwWZb+m1Gj31B96uxajowfVSC9a5K6KgX95NmZFIgW5FHiUpvbNis65h+x9tNtn8FoLOe8GEpSjYfoWGSXIz1PCKuV0LHodWKL133PT89Aq8Fmj23dDnBW94TPGvSWlQFvfA+DGLGs/pHw58pAlEHIBoqdD1XCHg3aEpKFfetz8LZU69aov472li2ClB4WQpRfzhS2mB5r4J3sLtYFTNBUotCW6CC+uaGIAtNbDdLPINWgJIagEwFshadkxXG/yVNVIzvV4ocPkxMNOdCHO1e2TBIT5zW1qqFGV6eSPWT1BhLObA54ZBojks1Xw4ScPi/nCV5RlTQlNAm+40uYbsVkLcao5aVfhTsRM3JFAnERfoloBPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(186003)(122000001)(26005)(6506007)(38100700002)(66446008)(66476007)(6916009)(8936002)(86362001)(55016002)(64756008)(9686003)(66556008)(7416002)(2906002)(4326008)(38070700005)(52536014)(7696005)(8676002)(5660300002)(316002)(66946007)(71200400001)(82960400001)(508600001)(85182001)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUFwTTI3N0daWCtsRndVNTNLUUM0MXhBZ0tsRlVsbzNyZlFMY091bnB5Y2FR?=
 =?utf-8?B?RE9LQ1RaVFNXV1Y4QnkzY05jb3FOY2FsTTF4UEZqYis0RFJBYjhzM1gwamRR?=
 =?utf-8?B?KzZFazBaS1ZJL3hMOXp0aHh0NWZWOFo3cThBcHY2YTV2SXFSUzMyc2w2cW41?=
 =?utf-8?B?dDF3ZWhFWjFIdkNEQTZxdWVlK21NdWRrY2NSRW01VkpVNUYyZ3ByY2tuTjdi?=
 =?utf-8?B?czEzRzc5a3JFZmNocTdhSmNZdXZ0TFZFODJlR3ppTENCTUxmZTdVWTF3cVZ1?=
 =?utf-8?B?T3FzSEVkaVFyd1dSZGVjcHlGUFloSUMxcmhOdUd2UFE4MlJUbmZHQ3NaZCtK?=
 =?utf-8?B?UzFNUk9ScHUwS3d4SjBKQkFYWThGOGdRYW1iZUdmaUZiREU3Z2d5WjlRL3o4?=
 =?utf-8?B?V2N0ZHNUOFg0b2UyZlJiREFmQmxYYzI1UGp3RWxFbWl0S2l2cnFBbC9JZkV1?=
 =?utf-8?B?d1pueE5OTDljaWZtNksxUlRFeFV3VnJNbUc4ZWNKSWtUUkQrck9UTlkxVmUy?=
 =?utf-8?B?WGpianBLSlU2TnBMTnVPaUVwbFk5cWY0L3haUmE1UEh2akd4dlZvcExnYU1o?=
 =?utf-8?B?MVBJRVpmVnYzS01UMmp5MHU3Nnl2U3hIMkdSbEpKUmE2VHVKU2svekhER0RD?=
 =?utf-8?B?RWwyUXMzRmhlWS9TN2VJUVFhYmhiTG5mTEZYZXpwbjI2a3hQR25Sa2hFYjJr?=
 =?utf-8?B?emlUTU5vbk5JMTZyR2dvbXM0TWtkV2xXbFhjdFBhdVBJTWxvbDV4WHlVQUVX?=
 =?utf-8?B?YUpGM05FM1M4R1poaHIvTmFWM21HYmNzTWxvSjdwNWNyVDVFdmdLMHZZZXhl?=
 =?utf-8?B?b1AzYjZKTi95N25vb0g0cXNXVmlPSVJ3bzFSRGJHWjUxODcvZ2xGdkhaeU42?=
 =?utf-8?B?VmVjRThIQ2F1Y2t6T0dnSGxSeXVJNGJ0VUVwb2c5SGp1SS90K3pvYmJDb0x5?=
 =?utf-8?B?ZnJScEJUYnhXZ2FzREwvWWlLNEw0NGNVUjF1YTRrd0VFTENoU0pFdHZSQTBJ?=
 =?utf-8?B?d3E4ckdNV2ZJSG1tR2tsRDZhamVjYUg2eGFMNEtrTm01TkRQc3Bwc0I4YzJN?=
 =?utf-8?B?bFUwUEVuWUNaYytvWEdEZWFjWUFaQ3J4VitGT3VQdVI4amRIOVRJWFp1TUc3?=
 =?utf-8?B?NEQ2TGZEaWRQWmdxSWJOZHRxa3pQZjJHUG9DNWFDbDFWVzF6MmVpNFpPcDV6?=
 =?utf-8?B?ODdvZ0pVSXpRc1I3RkZQb3VCczFjclBSaXo3QzBxOUVkSmJrbkN0eEV3dDV4?=
 =?utf-8?B?V2E2a3FCVVJmZjVRMEFJZjVGc3ltOEY0c0plZE5oTG5HcklIVXFycGUwM1pH?=
 =?utf-8?B?cmNyMmN2YlJRekNUT3hyWllMZXNhRUJlVTVnb2w0RG1LSC9wTmRKUlM2bXZu?=
 =?utf-8?B?V0JQS1VYMjBXUXVZcWs1K1NEaVNBRnRMNEV3V2Vsd0NtTTlzc1pJdVNFQ1dx?=
 =?utf-8?B?MWtZQ2FUTTA2SHc4ZS9WbXk3WmZLT1FNWTRxdVExSjl4S2MrYUFhdlJ0RzlO?=
 =?utf-8?B?c1JMQ0l6dGJHVnJwNzFZWWdXeWRvem1iQXBnZ3lBS0FFd1JoNjVTenBEMzg5?=
 =?utf-8?B?bTUvSWMvZFdhSkVmaHMxRzE2dGtKSlZqcEQvWEFIUE5OcVRTL2c1U0k0RHdt?=
 =?utf-8?B?Z05FbmUvaXJ5SW15MlY5TFpOeW5kR3cwQTJWSTRramZiZ29vQWVzRmFDRGdC?=
 =?utf-8?B?cmtqTUVyWGN4TGU3aHRtWVVUa05sMzN3MTY0ZldSUUFLUVZ4ajY1R0RKMUx4?=
 =?utf-8?Q?08h2Pe6kXKOuW8W8xQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28be2d9-21ec-4e79-b2b5-08d992bd4f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 05:00:02.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUkSbwu0GxKvYnXlcym7azgZserOhNFnZZAogTIsjtnOucv1brW4bxFJ3VJKVpZUThong01ISs7FdCKMYyEZhx3c4Np9w85crlUOYW3TdQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6845
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgSmlya2EKU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LgoKPiA+ID4gT24gV2VkLCBTZXAgMjIs
IDIwMjEgYXQgMDc6MTY6MjZQTSArMDkwMCwgU2h1bnN1a2UgTmFrYW11cmEgd3JvdGU6Cj4gPiA+
ID4gRnJvbTogbmFrYW11cmEgc2h1bnN1a2UgPG5ha2FtdXJhLnNodW5AZnVqaXRzdS5jb20+Cj4g
PiA+ID4gCj4gPiA+ID4gcGVyZl9ldnNlbF9fcmVhZCgpIHNjYWxlcyBjb3VudGVycyBvYnRhaW5l
ZCBieSBSRFBNQyBkdXJpbmcgbXVsdGlwbGV4aW5nLCBidXQKPiA+ID4gPiBkb2VzIG5vdCBzY2Fs
ZSBjb3VudGVycyBvYnRhaW5lZCBieSByZWFkKCkgc3lzdGVtIGNhbGwuCj4gPiA+ID4gCj4gPiA+
ID4gQWRkIHByb2Nlc3NpbmcgdG8gcGVyZl9ldnNlbF9fcmVhZCgpIHRvIHNjYWxlIHRoZSBjb3Vu
dGVycyBvYnRhaW5lZCBkdXJpbmcgdGhlCj4gPiA+ID4gcmVhZCgpIHN5c3RlbSBjYWxsIHdoZW4g
bXVsdGlwbGV4aW5nLgo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNo
dW5zdWtlIE5ha2FtdXJhIDxuYWthbXVyYS5zaHVuQGZ1aml0c3UuY29tPgo+ID4gPiA+IC0tLQo+
ID4gPiA+wqAgdG9vbHMvbGliL3BlcmYvZXZzZWwuYyB8IDYgKysrKysrCj4gPiA+ID7CoCAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMgYi90b29scy9saWIvcGVyZi9ldnNlbC5jCj4gPiA+ID4g
aW5kZXggODQ0MWUzZTFhYWFjLi4wZWJkMWQzNDQzNmYgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvdG9v
bHMvbGliL3BlcmYvZXZzZWwuYwo+ID4gPiArKysgYi90b29scy9saWIvcGVyZi9ldnNlbC5jCj4g
PiA+ID4gQEAgLTE4LDYgKzE4LDcgQEAKPiA+ID4gPsKgICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4K
PiA+ID4gPsKgICNpbmNsdWRlIDxzeXMvbW1hbi5oPgo+ID4gPiA+wqAgI2luY2x1ZGUgPGFzbS9i
dWcuaD4KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L21hdGg2NC5oPgo+ID4gPiA+wqAgCj4gPiA+
ID7CoCB2b2lkIHBlcmZfZXZzZWxfX2luaXQoc3RydWN0IHBlcmZfZXZzZWwgKmV2c2VsLCBzdHJ1
Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyLAo+ID4gPiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGludCBpZHgpCj4gPiA+ID4gQEAgLTMyMSw2ICszMjIsMTEgQEAg
aW50IHBlcmZfZXZzZWxfX3JlYWQoc3RydWN0IHBlcmZfZXZzZWwgKmV2c2VsLCBpbnQgY3B1LCBp
bnQgdGhyZWFkLAo+ID4gPiA+wqDCoMKgwqDCoMKgwqAgaWYgKHJlYWRuKCpmZCwgY291bnQtPnZh
bHVlcywgc2l6ZSkgPD0gMCkKPiA+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLWVycm5vOwo+ID4gPiA+wqAgCj4gPiA+ID4gK8KgwqDCoMKgIGlmIChjb3VudC0+ZW5h
ICE9IGNvdW50LT5ydW4pIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChj
b3VudC0+cnVuICE9IDApCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY291bnQtPnZhbCA9IG11bF91NjRfdTY0X2RpdjY0KGNvdW50LT52YWwsIGNvdW50
LT5lbmEsIGNvdW50LT5ydW4pOwo+ID4gPiA+ICvCoMKgwqDCoCB9Cj4gPiA+IAo+ID4gPiBzbyBJ
IHRoaW5rIHBlcmYgc3RhdCBleHBlY3QgcmF3IHZhbHVlcyBpbiB0aGVyZSBhbmQgZG9lcyB0aGUK
PiA+ID4gc2NhbGluZyBieSBpdHNlbGYsIHBsZWFzZSBjaGVjayBmb2xsb3dpbmcgY29kZToKPiA+
ID4gCj4gPiA+IHJlYWRfY291bnRlcnMKPiA+ID4gwqAgcmVhZF9hZmZpbml0eV9jb3VudGVycwo+
ID4gPiDCoMKgwqAgcmVhZF9jb3VudGVyX2NwdQo+ID4gPiDCoMKgwqDCoMKgIHJlYWRfc2luZ2xl
X2NvdW50ZXIKPiA+ID4gwqDCoMKgwqDCoMKgwqAgZXZzZWxfX3JlYWRfY291bnRlcgo+ID4gPiAK
PiA+ID4gwqAgcGVyZl9zdGF0X3Byb2Nlc3NfY291bnRlcgo+ID4gPiDCoMKgwqAgcHJvY2Vzc19j
b3VudGVyX21hcHMKPiA+ID4gwqDCoMKgwqDCoCBwcm9jZXNzX2NvdW50ZXJfdmFsdWVzCj4gPiA+
IMKgwqDCoMKgwqDCoMKgIHBlcmZfY291bnRzX3ZhbHVlc19fc2NhbGUKPiA+ID4gCj4gPiA+IAo+
ID4gPiBwZXJoYXBzIHdlIGNvdWxkIGV4cG9ydCBwZXJmX2NvdW50c192YWx1ZXNfX3NjYWxlIGlm
IGl0J2QgYmUgYW55IGhlbHAKPiA+IAo+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuCj4g
PiAKPiA+IFRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gdW5pZnkgdGhlIGNvdW50ZXJz
IG9idGFpbmVkIHdpdGggCj4gPiBwZXJmX2V2c2VsX19yZWFkKCkgdG8gc2NhbGVkIG9yIHVuc2Nh
bGVkIHZhbHVlcy4KPiA+IAo+ID4gcGVyZl9ldnNlbF9fcmVhZCgpIGdldHMgY291bnRlciBieSBw
ZXJmX21tYXBfX3JlYWRfc2VsZigpIGlmIFJEUE1DIGlzIAo+ID4gYXZhaWxhYmxlLCBlbHNlIGdl
dHMgYnkgcmVhZG4oKS4gSW4gY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgY2FsbGVyIAo+ID4gZ2V0
cyBzY2FsZWQgY291bnRlciBpZiBnb2VzIHRocm91Z2ggUkRQTUMgcGF0aCwgb3RoZXJ3aXNlIGdl
dHMgdW5zY2FsZWQgCj4gPiBjb3VudGVyIHZpYSByZWFkbigpIHBhdGguCj4gPiAKPiA+IEhvd2V2
ZXIgY2FsbGVyIGNhbm5ub3Qga25vdyB3aGljaCBwYXRoIHdlcmUgdGFrZW4uCj4gPiAKPiA+IElm
IGNhbGxlciBleHBlY3RzIGEgcmF3IHZhbHVlLCBJIHRoaW5rIHRoZSBSRFBNQyBwYXRoIHNob3Vs
ZCBhbHNvIAo+ID4gcmV0dXJuIGFuIHVuc2NhbGVkIGNvdW50ZXIuCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS90b29scy9saWIvcGVyZi9tbWFwLmMgYi90b29scy9saWIvcGVyZi9tbWFwLmMKPiA+IGlu
ZGV4IGM4OWRmYTUuLmFhYTQ1NzkgMTAwNjQ0Cj4gPiAtLS0gYS90b29scy9saWIvcGVyZi9tbWFw
LmMKPiA+ICsrKyBiL3Rvb2xzL2xpYi9wZXJmL21tYXAuYwo+ID4gQEAgLTM1Myw4ICszNTMsNiBA
QCBpbnQgcGVyZl9tbWFwX19yZWFkX3NlbGYoc3RydWN0IHBlcmZfbW1hcCAqbWFwLCBzdHJ1Y3Qg
cGVyZl9jb3VudHNfdmFsdWVzICpjb3VudAo+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb3VudC0+ZW5hICs9IGRlbHRhOwo+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoaWR4KQo+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY291bnQtPnJ1biArPSBkZWx0YTsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNudCA9IG11bF91NjRfdTY0X2RpdjY0KGNudCwgY291bnQtPmVuYSwgY291
bnQtPnJ1bik7Cj4gCj4gcGVyZiBzdGF0IGRvZXMgbm90IG1tYXAgY291bnRlcnMgc28gdGhpcyBz
aG91bGQgbm90IGJlIGludm9rZWQKPiB3aXRoaW4gcGVyZiBzdGF0Li4gYnV0IHdlIHNob3VsZCBi
ZSBjb25zaXN0ZW50IGFuZCBzY2FsZSBhZnRlcgo+IGNhbGxpbmcgcGVyZl9ldnNlbF9fcmVhZC4u
IGFuZCBnaXZlIHVzZXIgdGhlIHBvc3NpYmlsaXR5IHRvIGdldAo+IHVuLXNjYWxlZCBjb3VudHMK
PiAKPiB0aGF0IHBlcmhhcHMgYnJpbmdzIG5ldyBmZWF0dXJlLi4gbW1hcCBwZXJmIHN0YXQgY291
bnRlcnMgdG8gaW52b2tlCj4gdGhlIGZhc3QgcmVhZGluZyBwYXRoIGZvciBjb3VudGVycy4uIElJ
UkMgaXQgc2hvdWxkIGJlIG1hdHRlciBqdXN0Cj4gdG8gbW1hcCB0aGUgZmlyc3QgJ3VzZXInIHBh
Z2UKClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50LgpJIHRoaW5rIGl0IHdpbGwgYmUgZ29vZCB0
aGF0IHBlcmYgc3RhdCBzdXBwb3J0cyByZHBtYy4KCkkgd2lsbCBtb2RpZnkgdGhlIHBhdGNoLiAK
CkJlc3QgUmVnYXJkcwpTaHVuc3VrZQ==
