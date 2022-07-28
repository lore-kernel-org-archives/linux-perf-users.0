Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF075C04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 22:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiG1Wil (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 18:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiG1Wil (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 18:38:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4A31921
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 15:38:36 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIAm2t032376
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 15:38:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sDE5izN9/yp/xIYryQkVhQvZwqgFIiHBtBdTSymiWfc=;
 b=WiqHFzJk2TXq19d+lU5oyadtkWQygNOVl4iF9A4y632UfjrE1WxoGojDpD8CM3I4nOtI
 3R7CUTMPk3tObj/p6c2NHA7tK1rR7MwOXSGnyLFyrzBYNxU4CYL3/WjixKE8YA+aozWw
 6uHUVtAd2kDnfYyh/yQnZtORluQRDGwvX+8= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkst14m81-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 15:38:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeMenEsy+Wlc5ThAbWCAiZeZwSD09bVdZUIyPT2Ijk7vfnd29h1SzBQn9T2lf1x8RD7rMe94cHN1C4iFuS4lI7sFK6Tw9kvWcV7XgUmNcme9JPwUpOZ3UEY1ko6Am8GJC4uiBwiIXbHU2Npn3GiaE2rWdKlQq9rp2srVmio7Bqu0b47I63Q7seiV3jlGSzsxEvy+VRl5Rxl7dB6Ly4oZBbr6rM7oc5FRKRf6ZEI2wLmFfZaoy5RIBLMlex21eYRZdKqXfAD8qQvpwg2ye6yjjm0slgu0hP7yOKevD1Xm4uiKpmWGa78jWcB6wG6UtdkT9BGYjKLjbsNhu9xsQI6Ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDE5izN9/yp/xIYryQkVhQvZwqgFIiHBtBdTSymiWfc=;
 b=LZ4gar8fuYiufIwNU1kC9kesnUa2DGFAfg4ZWv9LfDBPkTjYU23OzpHJZFF5t8GqbU1qbFuFKcDX9NlhHElNmKDHwF+N3Xr1lix4BPjOalKV0WMWn1zdTFfFEkWMbi9pP2Kv5oUmyhzQoGVIeyUnSvuo8ZmWfyziZWomPaTCG+qOlYhuCBKMooL2io6/hpkBIHn1Up1EdOhfNFHNJu1fl2Q8n3IdZr7AJXdIzh2xKLbfmnnpHtBC6iMMitANp+XRDsC0bUp39Xlf1NHo5S0JTJ3YFJn1SK8ZczrX22ghailDqs+ZmFqIoPzcyurb90YpH+qss62tzsTJ453uLYoqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by MN2PR15MB3086.namprd15.prod.outlook.com (2603:10b6:208:f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 22:38:29 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::30c6:e0a8:a568:6bf2]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::30c6:e0a8:a568:6bf2%7]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 22:38:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Leo Yan <leo.yan@linaro.org>
CC:     =?utf-8?B?QWRyacOhbiBIZXJyZXJhIEFyY2lsYQ==?= 
        <adrian.herrera@arm.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "James.Clark@arm.com" <James.Clark@arm.com>,
        "nd@arm.com" <nd@arm.com>
Subject: Re: perf tools: software regression in
 d0a0a511493d269514fcbd852481cdca32c95350
Thread-Topic: perf tools: software regression in
 d0a0a511493d269514fcbd852481cdca32c95350
Thread-Index: AQHYon/pLvs81e78AkKYyML6ZvRcBK2T0bWAgACOzIA=
Date:   Thu, 28 Jul 2022 22:38:28 +0000
Message-ID: <7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com>
References: <f15afd38-3628-c57a-0735-1342f379b83c@arm.com>
 <20220714124638.GB155077@leoy-ThinkPad-X240s>
 <ee574459-f2e3-ff9a-5da5-a634952a726f@arm.com>
 <20220728140721.GA52489@leoy-ThinkPad-X240s>
In-Reply-To: <20220728140721.GA52489@leoy-ThinkPad-X240s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72ec8e42-74bf-4944-dcad-08da70e9e474
x-ms-traffictypediagnostic: MN2PR15MB3086:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KO8FL1kxmNOLDN6Zt5WhAju3w3+pUFAEgINpUO0JAf1gW8ZTNby4dTg/BcjhttOow0SsnKQSEJcKSE5Kp0uEEMdz01CKrn7lcpAox+s2b8DLZJoie93gE5Nfft7tI3w1JPB2xGBvYKBPcOLoRGlFVaKHMox+jKl3ZPTQX2hnfqsq6wJWrQuvsSU8lCcXQbQ6ON98Msvt/JpzxHb53iImip04dqCEjnunVUmzpeYctH2ira+d3GmMqoqABAUek0Q7ajAoYCEEuZV7S2DU50iozYaM87argxhXbxii9J1Gl0lXug0nIgXbd7mMD4ns172K/4tEx01uPDFvIbnfJzB1Nh3l7y5CmU7kTCPeNZEchjQJHgSANj+6lVvioZmUZxtpl4dDeu6pOe+wji+JSl6NDD3R1SwuwZ3BOugLzG/EuCAIihPnaR4gO1WmYQq2Mi0zgoEsPw2lU7tIFZQi9cwHpqe64YNNQK9GiFp5CGylgA+nvWMoaXG+rz7CvW3EZXFk0bR++VfSQH4Y+HyCjO7mSLyV+Xyhfyt4rtV/POstHfYadoEU0ixm56II0oDFXpr+dcVpsXlE9xDe7KWVlQXqUdvEEUwPzzj5moyGBSZ72yn8cBz2YkXqCOozjbwJYSIaNQHhGuaJ8So7KD5F1+jEk7DTU1RT4QPxB2omeJcVQ4Fe9L+YMXu426kWmuevpFhHLwv23bJ5rJMwO/dcBcGAoHARYMumPy1lvnyC/H00PgBExLVVtjOccQC2gFcGyhwNnklKMzdPgbqHaIlaQLLg/esh0uuoVWaNCd12IgrmgHQBUwvwFmsmbPQeYyJ/EEkYDMIeW7/H0YW/GAqC/eXoXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(86362001)(33656002)(36756003)(8676002)(38100700002)(122000001)(66946007)(66476007)(38070700005)(66556008)(66446008)(316002)(478600001)(6486002)(53546011)(4326008)(5660300002)(71200400001)(8936002)(83380400001)(66574015)(76116006)(64756008)(186003)(2616005)(91956017)(6512007)(6916009)(41300700001)(6506007)(54906003)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXZoMWJueU9qbnFpN3A4Q1czVFloTUorVStCWUt2MzZDdTREL0Ftdm9rQkhX?=
 =?utf-8?B?Q3g4ZThYaFBXQUl6QmFZVEVReFRQZkZyVWtvUzh3Mm83c1VUb3Y2bUtPekhP?=
 =?utf-8?B?czMvaDcvQm9DMXpkcHBFN090YWJvQTZ3eWU1SCtreG43NFNpT1kyS2I4dzE5?=
 =?utf-8?B?RkJhdFBoazRuZ2JISUd6bVZ3OVJZRUpCQmtDN2lQcDVvek8wRDEweU9Oem5i?=
 =?utf-8?B?bGJCS2NyMk1oY0pvaUVNNmpwd2MwZDRjcmxjaFhzNUxrVlRDMzJ6WU9SRi93?=
 =?utf-8?B?VWQ1RUZ4TzFIVkR6ZHlvVjlhV2tqaGxTMFJ6TWM1bE1ab2NMM2ZMVExRTndl?=
 =?utf-8?B?cEdzQmJxRGdyZkpwYlZHbXhPQ25lcUtvZWFDZmdySm00ZUdoQUJKRjJhZURn?=
 =?utf-8?B?YnVlcHhnU2VxUS9iNWNZeGpHSGZJd3JQbCtIdml2RTRGd0xNTHh6MzE1YWls?=
 =?utf-8?B?a2lEWHpNR2lwU1dBZ29WTVhHaDZjMTBEVXBFUHVVaUJVZzZqdS9IdVIxbHZo?=
 =?utf-8?B?d0h4dkFmdW81eEx1SlVuYkR2a3ErbmFQRm1sRUd1eU1NY3RHMEd1cEMrQWUr?=
 =?utf-8?B?eGFIOTZnM2pjMFJBT09iT2NVS0d4c1JiM0Vlcm5NY29rVVNrMmJpLzdJU3Bk?=
 =?utf-8?B?QVBMT3Rtd0oyTDVmVURvUnFpRy9NNW9KMVZqL3R4UGo1dDJFOGRPa0dER3ll?=
 =?utf-8?B?cUgzUkxabklNN0tscEJBbDhMdHdLaEd2VmZqVDdrWFNvV2hINTFQRGZTY1lY?=
 =?utf-8?B?bm03eU85SzhzaVlRcE93d016SzRxUTJ4dUxVSVNDY2dHcHZUWHVPNnJCUFZT?=
 =?utf-8?B?ZVlYSjN3aTV2ay9YMUFWVjRFd1o2NFpaVmY5d2QwczNmYUNDajY1RXljWjRx?=
 =?utf-8?B?eGxtZ1NPWDdTc2FQYm9NN2lCN2dvYW5RSGVFVjIrUXVkOGJaVzVJb25SSVhO?=
 =?utf-8?B?TFV6QXljWW82TlN4ZnQ4YndaUzZDRmxqckFpUWZwLzFHT1d2VFVvbk9SWFJU?=
 =?utf-8?B?eUxGYlYvZXorU2hoK1czakhKL3duMm93WlhzWFBHSWY2L3UySG8zcG9XUkRz?=
 =?utf-8?B?SnhmZVE4QnFHcG9HYlgrNEdPTXBjdm9MemdLNW1ycWVOWEx2bUxWMGcreEJw?=
 =?utf-8?B?cnZER0MzdGg2c2hYbHYrZ05oM21QUE9pK3dtYlg2TkJBbXlqSS82Ny91U2FR?=
 =?utf-8?B?Q0tqdmFUek9EV3MwZW4rNGFYMUpCaWVpUWEwem4vK2pQN0lDYjh6aEJmdTA2?=
 =?utf-8?B?Z0IxckZjRDJ0RzROV216VGpCZDRLMFY3MzZaWjhVQ1hDVDhzVGJVWVNWV0Vu?=
 =?utf-8?B?d3pSMjhlbW9XeDFXSWtZS01Dak9HTnp2cG95QWlZbnBTTG56SjFQV28ydXMz?=
 =?utf-8?B?WWJ0b0NxS0ROeVBNM2FnT0orNkRwdnZwNjUwOXNZck9KK3d3eU5TZHBQTC9l?=
 =?utf-8?B?SkhrbTJUVU04QkV5bWw5T2ZSZHFkRnRpRVI2eUhzd1FKdzRCbjdmWVlWa0I2?=
 =?utf-8?B?cXFrTENYZVhrRHE2d0FEMk9SVkdITGY2eFBJak1xaXl0OGkrN2ZFMkpRa3ZO?=
 =?utf-8?B?U3NTcTZnOHNtWThQVTM5VHcxWWkwb2lPMFJqa0xSZHhOOFhDL0N4SXlzQnlG?=
 =?utf-8?B?WmJkcXBDRXpwYUxRdGpMQWE2MlV6VXA2RFd6TG9xazVmaWRVc1owT2tmeCtK?=
 =?utf-8?B?Q0xLdXpUNEw2ZHdzeERjQzY5Rm9qSDNYdlY1MTFnYTUybmZDbUU2ZjhNVVFx?=
 =?utf-8?B?SFdEN0UyZXVpcG1MWE1COWRDZ2ZHQTBZWnhJSDhBS0ZJWEpQOUJKTzl2WHd2?=
 =?utf-8?B?MmdOTU1aMUowL1puVnp3NzRMQjFGVlpjdmR0bFpmK1cvMlRTVTNvV3dvNUIx?=
 =?utf-8?B?ZHlVSTJ1ZmwwLzRiai9uUjQvMTBXTTJON1VqNk95enc2ZDRmTDZCSWkyV1RW?=
 =?utf-8?B?dHlGeVFlTk1hQm1WQU4xOVZ6cmJTZUliMmpQMCs4eC93bnQ0bTQxbmxRbmxL?=
 =?utf-8?B?cnduQVk2ZlRUMlBodmVrQzZyZWpOTk1mSlVCT2l0U09iRjBhVmYwRldNVHU0?=
 =?utf-8?B?VnV0UmlBT0FJZ1dXN2hmMTk2QmxRZWdpczNqcnhDY0ZIZ0ErYm1xM21nbU40?=
 =?utf-8?B?Q0cyaDF5bnhGbW1JQi9FaDVVeUxHUkVvVCs0bGRkOTNHb2RQT1FpeE9MV1hK?=
 =?utf-8?Q?2lsqxosDZrrci7Bt3jEiWz8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23E1DF132BFBCA428EA7CF7869A55CAB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ec8e42-74bf-4944-dcad-08da70e9e474
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 22:38:28.8745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dzn3capgE1fVKRpMMOIfgdNu8rOAScQvrwWpI6pzFcyBweZpXNx1cCdhkrsnIDeVvDXf2dxgHwDe3D06IsPY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3086
X-Proofpoint-GUID: WJfDOO5Vi51w5OQa-pdIzuGe_fPcDCVI
X-Proofpoint-ORIG-GUID: WJfDOO5Vi51w5OQa-pdIzuGe_fPcDCVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgQWRyacOhbiBhbmQgTGVvLA0KDQpUaGFua3MgZm9yIHRoZSBDQy4gDQoNCj4gT24gSnVsIDI4
LCAyMDIyLCBhdCA3OjA3IEFNLCBMZW8gWWFuIDxsZW8ueWFuQGxpbmFyby5vcmc+IHdyb3RlOg0K
PiANCj4gSGkgQWRyacOhbiwNCj4gDQo+IE9uIFRodSwgSnVsIDI4LCAyMDIyIGF0IDAxOjQ0OjU3
UE0gKzAxMDAsIEFkcmnDoW4gSGVycmVyYSBBcmNpbGEgd3JvdGU6DQo+PiBUaGFuayB5b3UgTGVv
Lg0KPiANCj4gV2VsY29tZSwgSSByZWNvZ25pemVkIHRoYXQgSSBhbSBub3QgdGhlIGJlc3QgcGVy
c29uIHRvIGFuc3dlcg0KPiB5b3VyIHF1ZXN0aW9uIDopDQo+IA0KPj4gSSB0aGluayB0aGUgc291
cmNlIGNvZGUgZnJhZ21lbnQgaW4gcGVyZi1yZWNvcmQgaXMgbW9yZSByZWFkYWJsZSAobG9naWNh
bCkNCj4+IHRoYW4gaW4gcGVyZi1zdGF0LCBzbyByZXBsaWNhdGluZyBpdCB3b3VsZCBiZSBiZXR0
ZXIsIGFsc28gZm9yIGNvbnNpc3RlbmN5Lg0KPiANCj4gTWFrZXMgc2Vuc2UgZm9yIG1lLg0KPiAN
Cj4+IEkgaGF2ZSBwcmVwYXJlZCBhIHBhdGNoIGZvciB0aGF0IHdoaWNoIEkgd2lsbCBzZW5kIGZv
ciByZXZpZXcuDQo+IA0KPiBWZXJ5IGdvb2QhICBJIHdpbGwgcmV2aWV3IGFuZCB0ZXN0IHlvdXIg
cGF0Y2guDQo+IA0KPj4gcGVyZi1zdGF0IGRpZmZlcnMgZnJvbSBwZXJmLXJlY29yZCBpbiB0aGUg
cHJlc2VuY2Ugb2YgQlBGIGNvdW50ZXJzOyB0aGVzZQ0KPj4gYXJlIGVuYWJsZWQgaW5zaWRlIGVu
YWJsZV9jb3VudGVycyBpbW1lZGlhdGVseSwgaW5kZXBlbmRlbnQgb2YgdGhlIGRlbGF5OyBJDQo+
PiByZXNwZWN0ZWQgdGhhdCBiZWhhdmlvdXIsIGJ1dCBpZiBpdCBpcyBub3QgYSBwcm9ibGVtIHRv
IGRlbGF5IHRoZWlyDQo+PiBlbmFibGVtZW50IGFzIHdlbGwsIHRoZSBjb2RlIHdvdWxkIGJlIHNs
aWdodGx5IHNpbXBsaWZpZWQuIEkgaGF2ZSBhZGRlZCBTb25nDQo+PiBMaXUgKGF1dGhvciBvZiBC
UEYgY291bnRlcnMpLCBpbiBjYXNlIG9mIGFueSBjb21tZW50cyBvbiB0aGlzLg0KPiANCj4gWWVh
aCwgSSBhbHNvIG5vdGljZWQgdGhhdCBCUEYgY291bnRlciBlbmFibGluZyBpbiBwZXJmLXN0YXQu
DQo+IA0KPiBUbyBiZSBob25lc3QsIEkgYW0gYWxzbyB3YW5kZXJpbmcgd2h5IEJQRiBjb3VudGVy
IGNhbm5vdCBiZSBlbmFibGVkIGF0DQo+IHRoZSBzYW1lIHBvaW50IHdpdGggb3RoZXIgZXZlbnRz
LiAgV291bGQgbGVhdmUgdGhpcyBxdWVzdGlvbiBpZiBTb25nDQo+IGhhcyBjaGFuY2UgdG8gY29u
ZmlybSBmb3IgdGhpcy4NCg0KSSBkb24ndCByZWNhbGwgdmVyeSBnb29kIHJlYXNvbiB3aHkgYnBm
IGNvdW50ZXJzIGFyZSBlbmFibGVkIGluIA0KZW5hYmxlX2NvdW50ZXJzLCBzbyBJIHRoaW5rIGl0
IGlzIE9LIHRvIG1ha2UgaXQgYXdhcmUgb2YgaW5pdGlhbF9kZWxheS4gDQoNClRoYW5rcywNClNv
bmcNCg0K
