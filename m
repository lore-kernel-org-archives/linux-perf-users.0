Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E7ECE79A8
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Sep 2023 20:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjISUvQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Sep 2023 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjISUvP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Sep 2023 16:51:15 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ACEBD
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Sep 2023 13:51:10 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.17.1.22/8.17.1.22) with ESMTP id 38JJX6Xh009966;
        Tue, 19 Sep 2023 21:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        jan2016.eng; bh=EmakctTcFJzRyrVI7MY9fzWDnVt2HEVzCL+wBR7rvbQ=; b=
        CKKc4tbxkjvJ7R4X03CLYDKK8hCyWGNNTebJ6eu4Kx390LRyHDy/IH/4gn+8lSqr
        sjT8hyi33QadhJkalIODCfH88BH7WZsWWVSdTPHA5Cpv+X3u+4Wmsl5ZOjCAmGLh
        4y2x3MWcrdBINGMD+6a1z9wjelTFRZXSkYG6aeziS8s3AyBBDwyrN3C5lk6+dCMb
        cqszekBRlzwMITsZ1s/Ek7BeYLoqUc6aYi9Slwsg16qunXmWOoOnlh6c6piMq90W
        fc5jl9d87KKJ9VwzqKQMLf4NKx6S8LKYvlaq4euh3tbilMpfq44mr6YbBjpw6U9K
        Z7Qh5ORbmFWLVbUZSQn91A==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 3t51eh6wwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 21:51:08 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 38JIx4FQ006930;
        Tue, 19 Sep 2023 13:51:07 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.25])
        by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 3t5aba33t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 13:51:07 -0700
Received: from usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) by
 usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Tue, 19 Sep 2023 16:51:06 -0400
Received: from usma1ex-dag4mb8.msg.corp.akamai.com ([172.27.91.27]) by
 usma1ex-dag4mb8.msg.corp.akamai.com ([172.27.91.27]) with mapi id
 15.02.1258.025; Tue, 19 Sep 2023 16:51:06 -0400
From:   "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
To:     Ian Rogers <irogers@google.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Symbol resolution when text in hugepages
Thread-Topic: Symbol resolution when text in hugepages
Thread-Index: AQHZ5ptoJXbmX9KFXk+orVacilbbkrAbO7kAgAde2dSAAA2kfA==
Date:   Tue, 19 Sep 2023 20:51:06 +0000
Message-ID: <0915ceb147174fc4a09a2a0b774c01bb@akamai.com>
References: <2fb5c263fce545b0a5b745e6122fa88e@akamai.com>,<CAP-5=fX-wPy11iVZyc7HRXr_rK3GVwU_7gRtLKFsZH5=i=jWTA@mail.gmail.com>,<e4473389303b43f1aa063d3dcf72ad57@akamai.com>
In-Reply-To: <e4473389303b43f1aa063d3dcf72ad57@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.97.87]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_11,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190178
X-Proofpoint-ORIG-GUID: KsBGasWKkBWo9h8AfN4Sy2mfL83beGzp
X-Proofpoint-GUID: KsBGasWKkBWo9h8AfN4Sy2mfL83beGzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_11,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309190179
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RnJvbTogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KU2VudDogVGh1cnNkYXksIFNl
cHRlbWJlciAxNCwgMjAyMyA0OjI2IFBNDQpUbzogSmF5YXJhbWFwcGEsIFNyaWxha3NobWkNCkNj
OiBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFN5bWJvbCBy
ZXNvbHV0aW9uIHdoZW4gdGV4dCBpbiBodWdlcGFnZXMNCsKgICAgDQpPbiBXZWQsIFNlcCAxMywg
MjAyMyBhdCA1OjIx4oCvUE0gSmF5YXJhbWFwcGEsIFNyaWxha3NobWkNCjxzamF5YXJhbUBha2Ft
YWkuY29tPiB3cm90ZToNCj4NCj4gSGkgYWxsLA0KPg0KPiBXZSBoYXZlIGFuIGFwcGxpY2F0aW9u
IHRoYXQgaGFzIGl0cyB0ZXh0IHNlY3Rpb24gYmFja2VkIGJ5IGh1Z2VwYWdlcy4gSW4gb3VyIG5l
dyBidWlsZCBlbnZpcm9ubWVudCB0aGUgdGV4dCBzZWN0aW9uIG9mIHRoZSBiaW5hcnkgaXMgc3Bs
aXQgdXAgaW50byByZWFkIGFuZCByZWFkL2V4ZWN1dGUgc2VjdGlvbnMgd2l0aCBvZmZzZXRzIGlu
dG8gdGhlIHNlZ21lbnQuIFRoaXMgaXMgYnJlYWtpbmcgdGhlIHBlcmYgc3ltYm9sIHJlc29sdXRp
b24uIFByZXZpb3VzbHksICBldmVyeXRoaW5nIHdhcyBpbiBvbmUgc2VnbWVudCBhbmQgdGhlcmUg
d2FzIG5vIG9mZnNldCwgc28gcGVyZiBmdW5jdGlvbmVkIGZpbmUuIEkga25vdyB3ZSBjYW4gZHVt
cCB0aGUgc3ltYm9scyBmcm9tIHJlYWRlbGYgaW50byAvdG1wL3BlcmYtUElELm1hcCBmaWxlLiBJ
IHdhcyB3b25kZXJpbmcgaWYgYW55b25lIGhhcyBhIGNsZWFuZXIgc29sdXRpb24/IEknZCBhcHBy
ZWNpYXRlIGFueSBwb2ludGVycyB5b3UgaGF2ZS4NCg0KSGkgU3JpLA0KDQpTaW5jZSBMaW51eCA1
LjQgeW91IGNhbiB1c2UgTUFEVl9IVUdFUEFHRSB3aXRoIG1hZHZpc2UgZm9yIGZpbGUgYmFja2Vk
DQpwYWdlcy4gSXQgY2FuIHN0aWxsIGJlIHByb2ZpdGFibGUgdG8gdXNlIG90aGVyIHNvdXJjZXMg
b2YgaHVnZSBwYWdlcw0Kc28gdGhhdCB5b3UgZG9uJ3Qgd2FpdCBmb3IgdGhlIGh1Z2VwYWdlIHRv
IGJlIGZvcm1lZCwgaW4gdGhhdCBjYXNlIGlmDQp0aGVyZSBpcyBhIGZpbGUvbWVtZmRfY3JlYXRl
IHlvdSBjYW4gZW1iZWQgdGhlIGluZm9ybWF0aW9uIGluIHRoZQ0KZmlsZW5hbWUuIEZvciBhbm9u
eW1vdXMgcGFnZXMgeW91IGNhbiBtZXJnZSB0aGVtIHdoZW4gc2Nhbm5pbmcgdGhlDQpleGVjdXRh
YmxlIGluIHBlcmZfZXZlbnRfX3N5bnRoZXNpemVfbW1hcF9ldmVudHMsIGJ1dCBpdCBjYW4gYmUN
CnByb2JsZW1hdGljIGlmIHRoZSBwcm9ncmFtIGhlYWRlciBpcyBvbiBhbiBhbm9ueW1vdXMgcGFn
ZS4NCg0KVGhhbmtzLA0KSWFuDQoNCj4gVGhhbmtzDQo+IFNyaQ0KDQoNCg0KW3Jlc2VuZGluZyBz
aW5jZSBteSBtZXNzYWdlIGJvdW5jZWQgZnJvbSB0aGUgbWFpbGluZyBsaXN0LiBBcG9sb2dpZXMg
Zm9yIHRoZSBzcGFtLCBJYW5dDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJlc3BvbnNlLCBJYW4sIGFw
cHJlY2lhdGUgaXQuIFRoZSBwb2ludGVyIHRvwqBwZXJmX2V2ZW50X19zeW50aGVzaXplX21tYXBf
ZXZlbnRzICBpcyBzdXBlciB1c2VmdWwsIHdlIHdpbGwgbmVlZCB0byBkbyBzb21ldGhpbmfCoGxp
a2UgdGhhdCB0byBmaW5kIGlmIHRoZSBhZGRyZXNzIHJhbmdlIGlzIGJhY2tlZCBieSBodWdlcGFn
ZXMgYW5kIGlmIHNvIGdyYWIgdGhlIG9mZnNldCBmcm9tIHRoZSBleGVjdXRhYmxlLsKgDQoNCg0K
Rm9yIG1vcmUgY29udGV4dCAtIG91ciBhcHBsaWNhdGlvbiBmaXJzdCBsb2FkcyBhbmQgdGhlbiB3
ZSByZW1hcCBpdHMgdGV4dCBzZWdtZW50IHRvIGh1Z2VwYWdlcyB2aWEgdGhlIGxpYmh1Z2V0bGJm
cy4gV2hlbiB0aGF0IGhhcHBlbnMgdGhlIG1lbW9yeSBtYXAgZG9lc24ndCBuZWVkIGFueSBvZmZz
ZXQuIEJ1dCBwZXJmIGlzIGdyYWJiaW5nIHRoZSBtYXBzIGZyb20gdGhlIC9wcm9jL3BpZC9tYXBz
IGFuZCB0cnlpbmcgIHRvIGxvb2t1cCB0aGUgYWRkcmVzcyBpbiB0aGUgYmluYXJ5LCBzbyBpdCBs
b29rcyBhdCB0aGUgd3JvbmcgcGxhY2Ugd2l0aG91dCB0aGUgb2Zmc2V0IGludG8gdGhlIGZpbGUu
wqANCg0KDQpUaGFua3MhDQpTcmkgICAgICA=
