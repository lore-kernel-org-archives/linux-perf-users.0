Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08ABC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 00:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B4460C4D
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 00:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKHAxh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 19:53:37 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:10645 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237093AbhKHAwS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 19:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636332575; x=1667868575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hg2jjPIm+yMw/r+23aWMFqvllWGexW/3mgBkv6+rsDg=;
  b=hlOGu4SHb04naA6a8Lbgmo1As43SD694D12VfrSBYL8l4IAZsDlHq1F1
   gY4Om9fp9Zgh+EUHWbtYwgBtAQk8I+3uQbGlhN6zxJrz2b6CDFvnqUUz6
   Ixv3d0YX3V0TRdYhwUdEySLnPm2uYmDa//MRiVKd7CCXHhpWE4LP+Hb3w
   MiCigRC1/bd3ebWH/1Nv9R3eFYQAV0W63SOEPvo1jOMABgu2eKXwBc1z/
   1cgnea0XmGWtg/5zrjEavJlpvtCGOpx1wIy/GpEhQ11exqqXHQzUu7a30
   maLNrYu7IDKU7CPrY9t64mLUnafXP+0rUiec0v92km7OyzKBrNhPloNfa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="42952707"
X-IronPort-AV: E=Sophos;i="5.87,217,1631545200"; 
   d="scan'208";a="42952707"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 09:49:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYWccnmKNX8+1RiirD9wJyQ1AFuYXBSBijVhcod/VvlBYxkAeIruT2YOvl6PmR8ZiXV3V2mFgpz8sWZBwd3Dz1o9+WkrO7johicHK0T8Sdzebxfw8Abi2UBSPugklei4GTKXBB/39pwCWbQ/1gHOrbDIi8gb0BSxN8W1tSjJfwBc6hltU3VO/qfdoiw+QTP2B5f1e7xOwbCXgB/LSg6v1Rx7HZVBVYILI2KSuh5xW7L4Vhw2kN7PuCYlECk74RBXQh6uwDFT4OiLDoIEyh/IzVGu4sn4xV+KFeZQSqkAlH3hXwQfzUCU+/pgCBHf7QeDJCzfmZjbJjXvJ5L8EnZvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg2jjPIm+yMw/r+23aWMFqvllWGexW/3mgBkv6+rsDg=;
 b=FsybuJBr8Gwrc9mS3Ij3rhS39Dcram/bpeaUp/GV4yoyQOXt8cQMh8mivRp8rlmEL5m2cvpQgxlqNZXnGeqQVifrl3ZiN9VYFgxO0RmJdY4ST38SgO1iOfJpK+jhoa1bDuKtSvbsmcwdkZbsFyqEkQXlKHtK0XlnvRB5c4xAb/Mh1CSMHmM3FZg/YUQQYThkaz6BZ+nNXRS64hp3qyUwX3O81v1iv6oLIk0IbcH8Ozp7zEd0Lqg10PT+cah4d6Rh1IeGGCcdqBSL95CpAyclv5vpwN1LKaaZs9+x2P0YqTbbIQS9MJhTXCgrzgw8sk31/kggh+rugwUYoqLumjPtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg2jjPIm+yMw/r+23aWMFqvllWGexW/3mgBkv6+rsDg=;
 b=IEi/EO3rq5BwaQnAVcce1XN/mHwWUUw+9skr2zyPGJ+cigYRxsbltwXFTR2aVYEtZj0iufeiVajrxPc5Bp2bE4gg9o/2Tc2x3g4T5sbJLSqEv/PLyHmVa7L3LJ2VzU620Muw9wPOPnSVtQktrlhocrAjFt4Xy9rTjs2DIAD+uv0=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSZPR01MB6679.jpnprd01.prod.outlook.com (2603:1096:604:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 00:49:24 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 00:49:24 +0000
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
Thread-Index: AQHXr/my+5dH1blYnk6QsbLwDlVC2au5Oj0LgA6kMwCAEgxlYoAfJmqL
Date:   Mon, 8 Nov 2021 00:49:24 +0000
Message-ID: <OSBPR01MB4600CC928A1D4BB0703EFAE3F7919@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com> <YUuhe7e0J0PSea+b@krava>
 <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YV8rpPWOgFa5ARlU@krava>
 <OSBPR01MB46000071426DEC8FFF04C4F6F7BD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB46000071426DEC8FFF04C4F6F7BD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-11-08T00:49:24.221Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: d06d2a7a-d642-f6f6-7480-d3c1ff41e653
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 817ef199-9f1f-4432-5c31-08d9a2519c39
x-ms-traffictypediagnostic: OSZPR01MB6679:
x-microsoft-antispam-prvs: <OSZPR01MB6679820C27F3D670A6085558F7919@OSZPR01MB6679.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +odqZ+RLErpfQpsEG5WzqBHYGIE8+hsYFDMRQ2PUhRciB4Fh177F7V18rL40/rGMLEEFgF889R/iseK4c5OR25Br3EvekYP4xbILMkF7vU5UQuPqXGL76M4qSJ8woQ9mvNT66AHJ2Be0xTT8i6CzAkuMBoMky6W6PkKI7IrvutWGIVb0Wa8H8WCKduzvcW/ucWgBQdmQQVXg5S1i21rWvS2bwflyII+UO21jUbAemySXZUoleIYhvURYoNB4pVfC6lUxbHjbJ+juDAONHrn6GLZGGW+ec841vJVYHOcNXZI+d/zJppwtziJEcaKrSIjKuFIarGFybCTzH0bwMrkThjcvibfpWzGbltDibsVeJt7sYzejtVAk/fkH63WtumLGfE3OUls0sm8MpbSISK1w9OVVCVLeV6PMtd2SEgLnxBfeK7UhDitfs9Sg3srAq9vzUcEjBlagL8y9spumJ8Kha4hF978CHwC67UzCBphLMx/ZvSQAp7MjevNsffkEHl7FCP8/ns7E8Ks5/atJr5j1GI6v27qliYvoJjXIvOLbDKbqFrJBAqemVvF7JWGFTI3yf1HWqWW+pw7LzoQOwHVtQOZnDc/nnzqzPXQ9xlQlyeT7D0uuoT2vXf+z3rtqHZLgPCyBOROIGPNJZNBDzfTNGB71bquyXRbaSDZiDs3luTWO1L4uW9dM6tq1nLIB2LMdvKT+bKdKJsG4fHPNRyD0xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(8676002)(9686003)(8936002)(508600001)(33656002)(38100700002)(52536014)(6916009)(122000001)(5660300002)(26005)(7416002)(186003)(6506007)(86362001)(316002)(82960400001)(38070700005)(66946007)(66556008)(66446008)(76116006)(85182001)(66476007)(64756008)(54906003)(2906002)(71200400001)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVRbmViR0pZeDl0NHpybkE4Yi9yeHVkUXZEQ3dBSk55UnFuZXFTaWg1T1BX?=
 =?utf-8?B?OTVBdE9JNlphSllRelh2S3EvaHpWeTdIbC9DQ0VJOW5zWjNiNm9UcG0xYzRx?=
 =?utf-8?B?NGFiVUJIcWljMXNZUWRLK256UWVIZVJSWkRQaUNYak1zR21UM2l3L3hvRGFL?=
 =?utf-8?B?cC9JK1BxZWxoQWVoQ0orYXZqR2ZsbHViVzhGSW5aTGhDbW4wWmRGdStVRmsy?=
 =?utf-8?B?WVdCVkdJb1JMRHFxeVhCeTI3amRBQ0UwOFRVZEEwaFJnQzRoTG4zaXJBK3JG?=
 =?utf-8?B?QktzZ0p4L21PU0NxZno2ckFqakNadFFqM09VeGljMTBqdVIrTklleERuY2hm?=
 =?utf-8?B?SXRncjFIaWhYcWtreW9LTE9JQW1QVDhuL1ROT3NPYXk5cm9xVDQ5MjNGVmV6?=
 =?utf-8?B?R1hDOVU3RjFMdW5zNEp1R3FoQ1I1NGhCa210cjN2d05qSSt1a1o5NW5mUkRT?=
 =?utf-8?B?UGhicDNZamNjRk02a3dIUnJJd1FCUlBKWU50S0FMdTNReTZsMlo5YjhpNzFS?=
 =?utf-8?B?bU1KV1hXMDRiYytUbjNXTlRCTktxQTJDTEpYRUUxM3VqZ0EydjZna2VIQ004?=
 =?utf-8?B?MTdaNi84OFdlS3UwcmJ3UHppdWl0bis1N3VSWEFQL1RIeWI0bERCdytHNWRT?=
 =?utf-8?B?NVVDVkRSS2hwMUVoZmZkZTF4N2tCb0lsWXdqTkpGVW1mSngwdlI4TjU5MVN4?=
 =?utf-8?B?Q1VCVHZ3bHJuSUFwRkdMdE1xY0NsbnJOZ0NWZzhRUjQvK08vOUQ0YXJhZXhE?=
 =?utf-8?B?dittYitxaytGRzhMVytSeFovZUxYbFhRdWZUVlZ3V041ZUxrRGovQzFDR2xy?=
 =?utf-8?B?a3VvZm5ENEl2Y29Rdzk3V1p3Rk53aXM5Vkl5Tk9FNE5NaEpUR0Nsd2xmS3pn?=
 =?utf-8?B?K1NzSDRDS2I4WlJUSC9HSHNlcXVuc0RySlB2dit5TnhYeExrNjBwWmdqZ3J0?=
 =?utf-8?B?UjBlN0xNZnVnakpFWS90alo5ZiswTHFybno0UXBmTzNoaVo1Ri9MN1pNZk85?=
 =?utf-8?B?NVdwUkpJSW9QTUFWY0wvaE9ORlc1RG9zQ0d4OTZOZUVjZG10c3dtSVVQRWVJ?=
 =?utf-8?B?QVZTeTlsQTIxRnJGZFkvY3NpMUorQXhrZEJETVBFaXFuNHJJMVdkMnM2Zmo5?=
 =?utf-8?B?dUdtUVQ1eUVFdEtDdzBxbzY5by80NkZPSGlTbXVoYmZQVGJuUzRNU3FRR1lK?=
 =?utf-8?B?eTl5a0U1TnpJeDFrRzNtUy8zMUtFdzhad0VpVE5BS2dtMDlsYTVMWkhFMnBN?=
 =?utf-8?B?ME51SXIzSS9MV3VrYWNsQ1l3V1gzN08wT01DTWtWdXpCWjZCcXJkTVdzaWwr?=
 =?utf-8?B?cE52ZzRSem42azBFZFhZamdlKzdRS2I2TUJVVnUwU1R0WWJEOGFoV0dobVFW?=
 =?utf-8?B?YzRGM3pPT1BMclpMaHI4Q0xSSzVuT0VLN0NkOUVpbEFQcnl6YjdNSEF2TCti?=
 =?utf-8?B?ZDZQMjBjZ2xJTVpsaVFRTHBPZ0FvMjVRN2dsV21zUDhjQzUxVXNSVm8rb1Bj?=
 =?utf-8?B?NUl0dTEyZWFpUnE1WGhZaW1DM05wb2w4MTUwUkZHd3BDUjBLR2FqRzNacEMy?=
 =?utf-8?B?UHJvZW0wbC9vZ0wvUGM4dWhycXhOenRBMVpTL3dGcGpyRm9TZ2hoek41VnBJ?=
 =?utf-8?B?b2dvbEhjdWRKbktWRUhNUVhhTEFWUzg2UkFjVjMwMVpvcEZ1ekFHUm5vL2ZS?=
 =?utf-8?B?RWJJc084UXFjSFZXMWF0c2c0UWMzeFNRNmk1blZDTFdYSi9BVnpCWVlSeFRs?=
 =?utf-8?B?d0NSYU5Gc3N5cjV6RmJFYVFBK1VUcWNON05BSVdWcDFheUpNZ1ROUlB6S0Ir?=
 =?utf-8?B?NEFpM2lGdzZrYzlpdGZNWHVWMVFvazkwR0VoWnZvUnU4d1FCMkhjRU9vT2Rh?=
 =?utf-8?B?NjNKMStjaVpxNHBuK3VlV0lwdEtDbXEyeGJ6WEVHOHo3WWNyS25ZYjJDRU5w?=
 =?utf-8?B?Mk9EUmI4S2xwTDd6c0h1ZE4zN3hqNURwekRGN3FMQzVVaWJiV2M3ODRpd2JY?=
 =?utf-8?B?VlpwNnZEcXZ3MktDb3ZZRmdtbFFSVG5MNUkrZ0w4RjBNelpGb21mUml1eGZC?=
 =?utf-8?B?NGdUcG1vQ3VTa3A2NHJyL1hkQ2hiMEdUTFFMSHhsQ2pVb1dOdmtTK3ZNbk5J?=
 =?utf-8?B?eFZrTHJWMy9Wb1ZUSzVNQWdLTWt1T3pJeTVUVmtBUTFlckNPZVFYMlZkdWVQ?=
 =?utf-8?B?QzJ1S1lNNyt4cENaY0dScmlCMTV5RFlRM3pCOU0wRndoWWlvYm5GdE1zZGZp?=
 =?utf-8?B?ai9pSnQyYmpVRG1LNWJNQVprVU5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817ef199-9f1f-4432-5c31-08d9a2519c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 00:49:24.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R6N2xUjoo8wd/g0GbtsgqK3QzhN1ilnvSioZvKo6TtWokQcHszcuTBsfuWOgeQ1w8np9nzAKhTLPX57rz9A2oA63D67y0D60JGO1nNr4pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6679
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgSmlya2EKCj4gPiA+ID4gT24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgMDc6MTY6MjZQTSArMDkw
MCwgU2h1bnN1a2UgTmFrYW11cmEgd3JvdGU6Cj4gPiA+ID4gPiBGcm9tOiBuYWthbXVyYSBzaHVu
c3VrZSA8bmFrYW11cmEuc2h1bkBmdWppdHN1LmNvbT4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gcGVy
Zl9ldnNlbF9fcmVhZCgpIHNjYWxlcyBjb3VudGVycyBvYnRhaW5lZCBieSBSRFBNQyBkdXJpbmcg
bXVsdGlwbGV4aW5nLCBidXQKPiA+ID4gPiA+IGRvZXMgbm90IHNjYWxlIGNvdW50ZXJzIG9idGFp
bmVkIGJ5IHJlYWQoKSBzeXN0ZW0gY2FsbC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gQWRkIHByb2Nl
c3NpbmcgdG8gcGVyZl9ldnNlbF9fcmVhZCgpIHRvIHNjYWxlIHRoZSBjb3VudGVycyBvYnRhaW5l
ZCBkdXJpbmcgdGhlCj4gPiA+ID4gPiByZWFkKCkgc3lzdGVtIGNhbGwgd2hlbiBtdWx0aXBsZXhp
bmcuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2h1bnN1
a2UgTmFrYW11cmEgPG5ha2FtdXJhLnNodW5AZnVqaXRzdS5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+
ID4gPiA+wqAgdG9vbHMvbGliL3BlcmYvZXZzZWwuYyB8IDYgKysrKysrCj4gPiA+ID4gPsKgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiA+ID4gPiA+IAo+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMgYi90b29scy9saWIvcGVyZi9ldnNlbC5jCj4g
PiA+ID4gPiBpbmRleCA4NDQxZTNlMWFhYWMuLjBlYmQxZDM0NDM2ZiAxMDA2NDQKPiA+ID4gPiA+
IC0tLSBhL3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMKPiA+ID4gPiArKysgYi90b29scy9saWIvcGVy
Zi9ldnNlbC5jCj4gPiA+ID4gPiBAQCAtMTgsNiArMTgsNyBAQAo+ID4gPiA+ID7CoCAjaW5jbHVk
ZSA8c3lzL2lvY3RsLmg+Cj4gPiA+ID4gPsKgICNpbmNsdWRlIDxzeXMvbW1hbi5oPgo+ID4gPiA+
ID7CoCAjaW5jbHVkZSA8YXNtL2J1Zy5oPgo+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9tYXRo
NjQuaD4KPiA+ID4gPiA+wqAgCj4gPiA+ID4gPsKgIHZvaWQgcGVyZl9ldnNlbF9faW5pdChzdHJ1
Y3QgcGVyZl9ldnNlbCAqZXZzZWwsIHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKmF0dHIsCj4gPiA+
ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgaWR4KQo+
ID4gPiA+ID4gQEAgLTMyMSw2ICszMjIsMTEgQEAgaW50IHBlcmZfZXZzZWxfX3JlYWQoc3RydWN0
IHBlcmZfZXZzZWwgKmV2c2VsLCBpbnQgY3B1LCBpbnQgdGhyZWFkLAo+ID4gPiA+ID7CoMKgwqDC
oMKgwqDCoCBpZiAocmVhZG4oKmZkLCBjb3VudC0+dmFsdWVzLCBzaXplKSA8PSAwKQo+ID4gPiA+
ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1lcnJubzsKPiA+ID4gPiA+
wqAgCj4gPiA+ID4gPiArwqDCoMKgwqAgaWYgKGNvdW50LT5lbmEgIT0gY291bnQtPnJ1bikgewo+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY291bnQtPnJ1biAhPSAwKQo+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY291bnQt
PnZhbCA9IG11bF91NjRfdTY0X2RpdjY0KGNvdW50LT52YWwsIGNvdW50LT5lbmEsIGNvdW50LT5y
dW4pOwo+ID4gPiA+ID4gK8KgwqDCoMKgIH0KPiA+ID4gPiAKPiA+ID4gPiBzbyBJIHRoaW5rIHBl
cmYgc3RhdCBleHBlY3QgcmF3IHZhbHVlcyBpbiB0aGVyZSBhbmQgZG9lcyB0aGUKPiA+ID4gPiBz
Y2FsaW5nIGJ5IGl0c2VsZiwgcGxlYXNlIGNoZWNrIGZvbGxvd2luZyBjb2RlOgo+ID4gPiA+IAo+
ID4gPiA+IHJlYWRfY291bnRlcnMKPiA+ID4gPiDCoCByZWFkX2FmZmluaXR5X2NvdW50ZXJzCj4g
PiA+ID4gwqDCoMKgIHJlYWRfY291bnRlcl9jcHUKPiA+ID4gPiDCoMKgwqDCoMKgIHJlYWRfc2lu
Z2xlX2NvdW50ZXIKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBldnNlbF9fcmVhZF9jb3VudGVyCj4g
PiA+ID4gCj4gPiA+ID4gwqAgcGVyZl9zdGF0X3Byb2Nlc3NfY291bnRlcgo+ID4gPiA+IMKgwqDC
oCBwcm9jZXNzX2NvdW50ZXJfbWFwcwo+ID4gPiA+IMKgwqDCoMKgwqAgcHJvY2Vzc19jb3VudGVy
X3ZhbHVlcwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHBlcmZfY291bnRzX3ZhbHVlc19fc2NhbGUK
PiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiBwZXJoYXBzIHdlIGNvdWxkIGV4cG9ydCBwZXJmX2Nv
dW50c192YWx1ZXNfX3NjYWxlIGlmIGl0J2QgYmUgYW55IGhlbHAKPiA+ID4gCj4gPiA+IFRoYW5r
IHlvdSBmb3IgeW91ciBjb21tZW50Lgo+ID4gPiAKPiA+ID4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBw
YXRjaCBpcyB0byB1bmlmeSB0aGUgY291bnRlcnMgb2J0YWluZWQgd2l0aCAKPiA+ID4gcGVyZl9l
dnNlbF9fcmVhZCgpIHRvIHNjYWxlZCBvciB1bnNjYWxlZCB2YWx1ZXMuCj4gPiA+IAo+ID4gPiBw
ZXJmX2V2c2VsX19yZWFkKCkgZ2V0cyBjb3VudGVyIGJ5IHBlcmZfbW1hcF9fcmVhZF9zZWxmKCkg
aWYgUkRQTUMgaXMgCj4gPiA+IGF2YWlsYWJsZSwgZWxzZSBnZXRzIGJ5IHJlYWRuKCkuIEluIGN1
cnJlbnQgaW1wbGVtZW50YXRpb24sIGNhbGxlciAKPiA+ID4gZ2V0cyBzY2FsZWQgY291bnRlciBp
ZiBnb2VzIHRocm91Z2ggUkRQTUMgcGF0aCwgb3RoZXJ3aXNlIGdldHMgdW5zY2FsZWQgCj4gPiA+
IGNvdW50ZXIgdmlhIHJlYWRuKCkgcGF0aC4KPiA+ID4gCj4gPiA+IEhvd2V2ZXIgY2FsbGVyIGNh
bm5ub3Qga25vdyB3aGljaCBwYXRoIHdlcmUgdGFrZW4uCj4gPiA+IAo+ID4gPiBJZiBjYWxsZXIg
ZXhwZWN0cyBhIHJhdyB2YWx1ZSwgSSB0aGluayB0aGUgUkRQTUMgcGF0aCBzaG91bGQgYWxzbyAK
PiA+ID4gcmV0dXJuIGFuIHVuc2NhbGVkIGNvdW50ZXIuCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvbGliL3BlcmYvbW1hcC5jIGIvdG9vbHMvbGliL3BlcmYvbW1hcC5jCj4gPiA+IGlu
ZGV4IGM4OWRmYTUuLmFhYTQ1NzkgMTAwNjQ0Cj4gPiA+IC0tLSBhL3Rvb2xzL2xpYi9wZXJmL21t
YXAuYwo+ID4gPiArKysgYi90b29scy9saWIvcGVyZi9tbWFwLmMKPiA+ID4gQEAgLTM1Myw4ICsz
NTMsNiBAQCBpbnQgcGVyZl9tbWFwX19yZWFkX3NlbGYoc3RydWN0IHBlcmZfbW1hcCAqbWFwLCBz
dHJ1Y3QgcGVyZl9jb3VudHNfdmFsdWVzICpjb3VudAo+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvdW50LT5lbmEgKz0gZGVsdGE7Cj4gPiA+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKGlkeCkKPiA+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY291bnQtPnJ1biArPSBkZWx0YTsKPiA+ID4gLQo+ID4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbnQgPSBtdWxfdTY0X3U2NF9kaXY2NChjbnQs
IGNvdW50LT5lbmEsIGNvdW50LT5ydW4pOwo+ID4gCj4gPiBwZXJmIHN0YXQgZG9lcyBub3QgbW1h
cCBjb3VudGVycyBzbyB0aGlzIHNob3VsZCBub3QgYmUgaW52b2tlZAo+ID4gd2l0aGluIHBlcmYg
c3RhdC4uIGJ1dCB3ZSBzaG91bGQgYmUgY29uc2lzdGVudCBhbmQgc2NhbGUgYWZ0ZXIKPiA+IGNh
bGxpbmcgcGVyZl9ldnNlbF9fcmVhZC4uIGFuZCBnaXZlIHVzZXIgdGhlIHBvc3NpYmlsaXR5IHRv
IGdldAo+ID4gdW4tc2NhbGVkIGNvdW50cwo+ID4gCj4gPiB0aGF0IHBlcmhhcHMgYnJpbmdzIG5l
dyBmZWF0dXJlLi4gbW1hcCBwZXJmIHN0YXQgY291bnRlcnMgdG8gaW52b2tlCj4gPiB0aGUgZmFz
dCByZWFkaW5nIHBhdGggZm9yIGNvdW50ZXJzLi4gSUlSQyBpdCBzaG91bGQgYmUgbWF0dGVyIGp1
c3QKPiA+IHRvIG1tYXAgdGhlIGZpcnN0ICd1c2VyJyBwYWdlCj4gCj4gVGhhbmsgeW91IGZvciB5
b3VyIGNvbW1lbnQuCj4gSSB0aGluayBpdCB3aWxsIGJlIGdvb2QgdGhhdCBwZXJmIHN0YXQgc3Vw
cG9ydHMgcmRwbWMuCj4gCj4gSSB3aWxsIG1vZGlmeSB0aGUgcGF0Y2guIAoKSSB0aGluayByZHBt
YyBjYW5ub3QgbWVhc3VyZSB0aGUgY29tbWFuZC9wcm9ncmFtIHNwZWNpZmllZCBpbiBwZXJmIHN0
YXQgCmJlY2F1c2UgaXQgbWVhc3VyZXMgdGhlIGNhbGxpbmcgdGhyZWFkIG9mIHBlcmZfZXZlbnRf
b3Blbi4KSWYgbXkgdW5kZXJzdGFuZGluZyBpcyB3cm9uZywgcGxlYXNlIHBvaW50IGl0IG91dCB0
byBtZS4KCkJlc3QgUmVnYXJkcwpTaHVuc3VrZQ==
