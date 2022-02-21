Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B7AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Feb 2022 00:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiBVAHs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:07:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiBVAHr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 19:07:47 -0500
X-Greylist: delayed 1497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 16:07:22 PST
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B013F24585
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 16:07:22 -0800 (PST)
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LNFXst005622
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 23:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=cpTkWocqHAqnIr3m3Z6jIii5Am4de9vf8gGigwzIpik=;
 b=pe+9GOUcwcD6ItZmlhqzSSxqYiqlYmONZcTnsnv4fXtOIi6eRcGRcNO850SsBiYEHk8T
 E2GjLDiyCcILuHJqOlUuKanuX6CpyKOI/+lg+muVhCCvdDmcEd0BWxHMgMJWIk5ShCBB
 7cuoJ2nVje+OM9iwZhHwVw8umHeoViICdaEN9gd+thugGQJC/bnBUJnLD2plfOFRG5wg
 LONUy5UvxDPIrJAc/vs9es/cLYLi790k5mx0KPeAW8qF0mK9KnweCcQGh3MHdQldhwc4
 2VAAUIo/pfZq61weOfKl9vpRRynkBx5BDI7l6azEBmDZox45iSZouLZQfxcJXdG0m6QC vQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3ech54t04k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 23:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/Y/Tdnane/yYlv0a/oNBJMsz+MEBNRy6JaiIWBbarvRKAwY/Uk7+v5P2Z+mDJboIrdImVbwcGLzxcytaXB2Sbkxgeg14yAyeqgPfKOC7EREjqMp9I89LnaLoMc6MOe7VlQ31xhNh3Py0BiqA3E2U7B1h4jomVQ7A2Y0zfzww1VF1MgKoar3DHhqm160HbZWKxgEC9lVAfQHzROLfKfEmYSduLDbclIZyobZoAwIIb2DEJuk5Ls8eSDK/JIjuk0T6gGP77BFVLjooxhU0KTNHsYOKbAGCms6bRq1NCUxeNDqD1l2eR2Ru6dBZ3FULLZX7xOBglH0VwCzBel3Z1L1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpTkWocqHAqnIr3m3Z6jIii5Am4de9vf8gGigwzIpik=;
 b=W0Bm2Z7+s/hlMwknXYTlVJNT7rWDUkbq5W6wU/vhOzNu5yeZFWc8+fU/ELq/EiTc+NgFtzHnWhksEgMd7ef51EMGzcBC7O4B1om+AxXOSQO35No3AAxO+uqlCEO4byyUxSXYEUr/UOdScB3cHMaugPd03LlxPYtPvjhy9sPOGPcisYhSfC7UOK1tBUezJPTssFonOFPIsCa7u33iqOKOvdkHhuJHEwUb/iJsExZ0NokwLfq9LbsDJj58wv3myND6qm7gBpKP6/E0urEp/WAqiI1owSET47d+iWEQsR5bbdiEPSkhzr1jiaLvEh9Im5v2ZOg5N75lihhgt1ZubK7MVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DM5PR11MB1962.namprd11.prod.outlook.com (2603:10b6:3:10c::15)
 by CY4PR1101MB2087.namprd11.prod.outlook.com (2603:10b6:910:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 23:42:22 +0000
Received: from DM5PR11MB1962.namprd11.prod.outlook.com
 ([fe80::3cc0:1867:7b93:5ef7]) by DM5PR11MB1962.namprd11.prod.outlook.com
 ([fe80::3cc0:1867:7b93:5ef7%12]) with mapi id 15.20.4995.027; Mon, 21 Feb
 2022 23:42:22 +0000
From:   "Mor, Omri" <omrimor2@illinois.edu>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: AMD Zen2 l3_misses event
Thread-Topic: AMD Zen2 l3_misses event
Thread-Index: AQHYJ3ysRvst67i6L0KWqOlcUISS3Q==
Date:   Mon, 21 Feb 2022 23:42:22 +0000
Message-ID: <CDD3A5B9-9B64-44DD-8705-6382913C8A10@illinois.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5174b862-2daa-4dc0-935c-08d9f593ceba
x-ms-traffictypediagnostic: CY4PR1101MB2087:EE_
x-microsoft-antispam-prvs: <CY4PR1101MB208707D12BA985E75B2E9566E03A9@CY4PR1101MB2087.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0fb09n8u+4CJJUmKH6Vjg+DwHUxu6q+DD0hJi1IwJwHp/+kDnYeOrwJVNs4y6iInoQmWOWw16ck5en743m6jlMMHZtoOKYOG8aik90gZIMPTzsEK8sGK9BcJyl/4y4Qee0CVKT3379VJ28MlLZc3UwyG1S8PfWlV0LBbunaoqcJDTQwzAQt7QiQa+7MqQp/NWlhVfzsG6lqqfefKThllHNh7XPilCfBoxQBn477OwVjzq/Ko3cVRXgIkrhfd5/kWALpDtleXz9cl/Rx9+zOnJmF7xyo/9sMGkvqbaifn+sHPaOKdYwGfRldi4mWHOz4i6tWn6w2QiVphHydc3ByO86VKzd3sxJzuIh3qno2Lv4fSEfrQjKPLFbGbwKvYI/j1XlgTX4iPgylc9WEnrutRpYou7CIbDhnU1Ui6acwH3qyNC/1K4VKeh7+cOCN31VyvXy4NJ4KWtgNG8wamIhho3+9gfLF9wB+i93tK25+XgrKlColuNeZLK+ifwfG3hR14BVdKVGF8TzwdRfytk6RRaATGG3QRuMdWKToYwT5EAe1ExPVAEJq4XT3Ayw99ejUI65WF1Byj+PFgjVAlGTzsTRR9vA/0PdmelkphbfHQlLsf8GFRmZA7cwEQVjbiYo/keI8wwGsq1cf0paYi5Gb1omhWXUVrTVJfRdpevbCpUVuiTOIN5E7yo93X8+OUHWO3zi96Nrz3k/LoQtbiezCAcxs+LCUjEp+nua2oRSSRUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(83380400001)(36756003)(5660300002)(2906002)(8936002)(33656002)(6506007)(6486002)(91956017)(66476007)(186003)(26005)(76116006)(2616005)(66556008)(66946007)(6512007)(122000001)(6916009)(508600001)(786003)(71200400001)(86362001)(316002)(8676002)(66446008)(75432002)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXJITDBGZGE2dHdFRDhOeHpHU3ZLL3JGTFVQaDRhV2dOOXhXbWw3cUVERzB4?=
 =?utf-8?B?azJwb1ZwZ1VtaTZDZjJFb2N1MWMzVDArZDAzNm50d1VMREgwdFV0eXNyUzJK?=
 =?utf-8?B?aEdsTTJUa1R0NGU5UXV2OERYaDQ5Ym9VdlRIMU9CSlR6MGZMMEJhWHNGL0dl?=
 =?utf-8?B?NHBQeGJGYzJSaFBCdDJSZXlGeFAxazZrTUpBNHArajVaUzVUanMwOUJibWFh?=
 =?utf-8?B?eWU5TjgzRFlaREpqVzZlazRuaTVKUnNyQ1NoQTB3UmpSS25XdklyUVVUbEhv?=
 =?utf-8?B?QU94eW14ZGpIYWVpK2tZQ1VxeFZEelBacTJNSFJMM1NWRmx4cU5GMTlsbTFH?=
 =?utf-8?B?bnMvZXlBODRCT3lRQVdFVGNuVVN0ZzFrSUU0OGR6REJZZUF6bFk3NkJCZkt4?=
 =?utf-8?B?dmZXaFRtZVUyNTZRNEQ3ekFpbkU5dndYTnp5eElaZnp1cldsWjhYUGplbWt4?=
 =?utf-8?B?MjdValB4RzRVUFJ0a0RZOHN1OFdJRFN4bHl5VDdtNFAyYzlHU0lwaEVKY3NI?=
 =?utf-8?B?TzB4ODBlekRzazdRNU5ONnhHKzJSYUpBU1hXYmo3c2F5bDFzcktPZWJRMzVi?=
 =?utf-8?B?cDhwcVdLdkVJNUFiQmMyNTdubVRxQTFxVWtwSUl4Rjh4TTRkc0NQMy9udlBN?=
 =?utf-8?B?T3MwazJTWnd5SXNkZzVSUUhyWGQ2S0F4RlFWU0srOWJITW5EK3NZcEpJTVd3?=
 =?utf-8?B?WHcxZVcrNUg0aHpzaWdIelVvd0I3bnlSRW82bFdlWXlXdFVxWjh1MXcxZU9D?=
 =?utf-8?B?TWErYVNqNkFLM0ZWV3J1L01CVVZndUxYTTM4MWpqZzhGZVJYOXc4K2xtOVhW?=
 =?utf-8?B?TXJ5U2NHc3J3L21KTVArQU44OVNoVkgwVmJma2NGcUxOQk1rY3VvT1pOY2Ux?=
 =?utf-8?B?RFdZc1RGYkt4QzdZNFFFTXkzWGFOL3pHZlM2ZTlGVktEVUxwbUZmeHZsM1dQ?=
 =?utf-8?B?bWdNM0lTWVdaNnVxSngvQkFyYTRDeFd0b0d0WDQ5TEFJTXo0Zll5QzNmM3c2?=
 =?utf-8?B?MVQ4VEZsN0Vqc1RkSDBjcmFTZmJ5d2RZSTNZaTA1VVM2YXFXOWdlZ1FHZk9l?=
 =?utf-8?B?QmlQN2pOdHB4QXk0ak4xOStwWGl5aHZrMEdqZFhqZTAwbmlrQkRZS2F3RGZv?=
 =?utf-8?B?MkpOczFLZExaOTFUSkZqM05iVjlmRkNzMUdSQWVRZDNpRWRUMzV2a1ZYWWVF?=
 =?utf-8?B?MUprQUJ0UW1qWXpydVpBNnBwWmU5T2hrOS9SSlBtcmRnYVB4YXFpMlVKS3hV?=
 =?utf-8?B?bHRhcUtwRHJlMDVoZmtPekFramtreXdzTVJpclkzckNBcVFubHF6NHRRNGNX?=
 =?utf-8?B?SlZHZ2xDTVJIVStTSC9mNi9QU0JPK1RybzhaREMxU1cwV0RQYWE1YWFVVnEy?=
 =?utf-8?B?OXNqUExqRFZoQVdrU0hYMVV2ZGhNQlBYSGhHUGxJeHJkL3RreVdjVlFrRUF6?=
 =?utf-8?B?NFBobE5hUW5LUzlaRi84Rk1JWndPdWFRMHlpaXZEekxJZjFRbnNXdkIxWHNO?=
 =?utf-8?B?dTlaQ3dHR2U5MUMrQzJvK3JpMkJVQVRhMHpld2YrOEtFOHdnY2hCdXpwWk0y?=
 =?utf-8?B?NG1YUlV3YVdtRjBYb2VKOXE1S2xXQjMrdzRqdkoyS2hpcjVhRldHOFd6ZTBV?=
 =?utf-8?B?VzJRLzFZQmw2cVRjcUZTUFVrajJxY01YOVBwL1lyaEFxb3p4bm1qUmFrY0VQ?=
 =?utf-8?B?NGxEUDJHbXpBU1JrVDk3eXFBcjZzeStEUXhWTUtuL0svZnlNQVVMSEc0WlE5?=
 =?utf-8?B?V3BTWVphTVU3ZkF3ZWtRcE9iYlJTUEg5N0tmckhQVjhhZDlTYTY1OWtMbVps?=
 =?utf-8?B?QzBhQitrdFp6eEZCMUhsV0tpaisxTGlPbWFkb2ZaNUhJMVJBRTN3ak41VXlw?=
 =?utf-8?B?UDZBKytRVk1DMnN6cGJIdWxkeGFvOFArT2MxVGdYb3hVK3NBWUo3VStjTkFZ?=
 =?utf-8?B?TjFFbFdxb1dmRjJQMXF2OG9Cd0NOSFQvdjU1WjdETHVHT3NyWXBjUkxFQWJB?=
 =?utf-8?B?dGFkdWExdGVGVGpER3I2RTBjdHFuc0dxQzN0VEdHRFcxbnZReGdPRnBKQXJQ?=
 =?utf-8?B?Tzk4TFVPTWJIeVFsNkx0K1FKTC9lanR1Y3lTdHpVRXBscjM2SnQ2R3FsdjJ6?=
 =?utf-8?B?N2xBR2JwbTRYRXhiSHRkT2pleGkvcGRYdUNqWHBoTEtjam11cW1zQlowazNP?=
 =?utf-8?Q?jGD+aNtUb0BRxwPd8Owzmus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E759A90FC108E9489F0CE16EA979E63E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5174b862-2daa-4dc0-935c-08d9f593ceba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 23:42:22.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJXkQa64tTe+lrzO2ZkC0bOcS51ESMjXc5JgViGqzYAaPi/CKYnq0sNmPwh6hrS9rp2naqFiiD1EpybLqHSgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2087
X-Proofpoint-GUID: LfgpN6lnyHasqDpeoCEe22Wo4rarAlTU
X-Proofpoint-ORIG-GUID: LfgpN6lnyHasqDpeoCEe22Wo4rarAlTU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGVsbG8sDQoNCkkgYW0gcHJvZmlsaW5nIHNvbWUgY29kZSBvbiBBTUQgUm9tZSAoZmFtaWx5IDE3
aCwgbW9kZWwgMzFoKSB3aXRoIGFuIG9sZGVyIExpbnV4IGtlcm5lbC9wZXJmIHZlcnNpb24sIHBy
aW9yIHRvIHRoZSBhZGRpdGlvbiBvZiBaZW4vWmVuMiBldmVudHMsIGFuZCBzbyBoYXZlIGJlZW4g
bG9va2luZyBhdCB0aGUgZXZlbnQgY29kZXMgYW5kIHVtYXNrcyBpbiB1cGRhdGVkIHBlcmYgY29k
ZSBhcyB3ZWxsIGFzIEFNRCBQUFIuIENvbXBhcmluZyB0aGUgTDMtcmVsYXRlZCBldmVudHMgaW4g
Y2FjaGUuanNvbiBhbmQgdGhvc2UgaW4gcmVjb21tZW5kZWQuanNvbiwgSeKAmXZlIG5vdGljZWQg
c29tZSBpbmNvbmdydWl0aWVzIGFuZCB3YW50IHRvIGNvbmZpcm0gd2hhdCBhcmUgdGhlIGNvcnJl
Y3QgdmFsdWVzLg0KVGhlIFBQUiBhbmQgY2FjaGUuanNvbiBpbmRpY2F0ZSB0aGF0IEwzIGFjY2Vz
c2VzIHVzZSBldmVudD0weDAxLHVtYXNrPTB4ODAsIHdoaWxlIEwzIG1pc3NlcyB1c2UgZXZlbnQ9
MHgwNix1bWFzaz0weDAxOyBtZWFud2hpbGUsIHJlY29tbWVuZGVkLmpzb24gdXNlcyBldmVudD0w
eDA0LHVtYXNrPTB4ZmYgZm9yIEwzIGFjY2Vzc2VzIGFuZCBldmVudD0weDA0LHVtYXNrPTB4MDEg
Zm9yIEwzIG1pc3Nlcy4gVGhlIFBQUiBpbmRpY2F0ZXMgdGhhdCAweDA0IGlzICJBbGwgTDMgQ2Fj
aGUgUmVxdWVzdHPigJ0gYW5kIHJlcXVpcmVzIDB4ZmYgZm9yICJBbGwgTDMgUmVxdWVzdCBUeXBl
c+KAnSwgbm90IGNsYXJpZnlpbmcgdGhlIG1lYW5pbmdzIG9mIGluZGl2aWR1YWwgYml0c+KAlG9y
IHdoZXRoZXIgc3VjaCB1c2UgY2FzZSBpcyB2YWxpZCBvciBoYXMgYW55IG1lYW5pbmcgYXQgYWxs
LiBBZGRpdGlvbmFsbHksIGNhY2hlLmpzb24gY29udGFpbnMgdGhlIGwzX2NvbWJfY2xzdHJfc3Rh
dGUub3RoZXJfbDNfbWlzc190eXBzIGV2ZW50LCB3aXRoIGV2ZW50PTB4MDYsdW1hc2s9MHhmZTsg
dGhlIFBQUiBzdGF0ZXMgdGhhdCB0aGUgYml0cyBmb3IgdGhhdCBldmVudCBhcmUgcmVzZXJ2ZWQu
DQpEdWUgdG8gYWxsIHRoaXMsIEnigJltIHN0cnVnZ2xpbmcgdG8gZGV0ZXJtaW5lIHdoaWNoIGV2
ZW50IGFuZCB1bWFzayBpcyBjb3JyZWN0IGZvciBjb3VudGluZyBMMyBjYWNoZSBhY2Nlc3Nlcy9o
aXRzL21pc3NlcyBvbiBaZW4yLCBhbmQgd291bGQgYXBwcmVjaWF0ZSBhbnkgaGVscCBpbiB0aGUg
bWF0dGVyLg0KDQpNYW55IHRoYW5rcywNCk9tcmkgTW9y
