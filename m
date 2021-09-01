Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE91C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 05:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374566101A
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 05:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbhIAF3m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:29:42 -0400
Received: from cssvr7.cse.ust.hk ([143.89.41.157]:58163 "EHLO cse.ust.hk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229731AbhIAF3l (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 01:29:41 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2021 01:29:40 EDT
Received: from CSMS17.win2k.cs.ust.hk (exchange.cse.ust.hk [143.89.41.15])
        by cse.ust.hk (8.15.2/8.12.5) with ESMTPS id 1815JwKl020776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Sep 2021 13:19:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
        s=cseusthk; t=1630473596;
        bh=xzbOG+zSQKKCfq1Y5s+iC0muh1WV8iKSb2cN7D4Imu8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=2rJFDdvCflBoagzbsI9yfno0Q9C6lm52FeRQOQr2vNEE+iIaX5qcWBUfcJ0PT1AR+
         3wCGDIDLHW/kAXAoFDe0agfjjbN5BIgQzBftUqdJ1PsY5IErNh1Ti8QoeIl1i9UkL4
         e+xDHxVjkHp/48Ifq/rpqOlL8GnncB3v/+ySJigg=
Received: from CSMS17.win2k.cs.ust.hk (143.89.41.15) by CSMS17.win2k.cs.ust.hk
 (143.89.41.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 1 Sep
 2021 13:19:54 +0800
Received: from CSMS17.win2k.cs.ust.hk ([fe80::bcea:9f27:68b4:12e2]) by
 CSMS17.win2k.cs.ust.hk ([fe80::bcea:9f27:68b4:12e2%5]) with mapi id
 15.01.2242.012; Wed, 1 Sep 2021 13:19:54 +0800
From:   CAI Yuandao <ycaibb@cse.ust.hk>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?5Y+25r6E6ZSL?= <dg573847474@gmail.com>
Subject: Re: Possible deadlock errors in tools/perf/builtin-sched.c
Thread-Topic: Possible deadlock errors in tools/perf/builtin-sched.c
Thread-Index: AQHXm+JgYeEgx7zQaE+v9QVhCno4J6uNcywAgAE3AoA=
Date:   Wed, 1 Sep 2021 05:19:53 +0000
Message-ID: <6E40E066-3652-423E-BEC5-12F4AADB3DE2@cse.ust.hk>
References: <CAAo+4rXNLdgvAiT2-B8cWtLNPnWoGo9RWMW=8SPchzRgxJ4BhA@mail.gmail.com>
 <YS5uAwp8dGn4CK1V@krava>
In-Reply-To: <YS5uAwp8dGn4CK1V@krava>
Accept-Language: en-HK, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [34.221.119.148]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9652A146C485044C8A3369A82C25D52C@cse.ust.hk>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Env-From: ycaibb
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgSmlya2EsDQoNCiAgICAgICAgVGhleSB3ZXJlIGZvdW5kIGJ5IG91ciBzdGF0aWMgY29kZSBh
bmFseXplciBhbmQgbWFudWFsbHkgY2hlY2tlZCBhcyB0cnVlIHBvc2l0aXZlcyBieSB1cy4gQXJl
IHRoZXkgcmVhbCBidWdzPw0KDQpCZXN0LA0KUnlhbg0KDQrvu79PbiAxLzkvMjAyMSwgMjo0NiBB
TSwgIkppcmkgT2xzYSIgPGpvbHNhQHJlZGhhdC5jb20+IHdyb3RlOg0KDQogICAgT24gU2F0LCBB
dWcgMjgsIDIwMjEgYXQgMDM6NTc6MTdQTSArMDgwMCwg5Y+25r6E6ZSLIHdyb3RlOg0KICAgID4g
RGVhciBkZXZlbG9wZXJzOg0KICAgID4gDQogICAgPiBUaGFuayB5b3UgZm9yIHlvdXIgY2hlY2tp
bmcuDQogICAgPiANCiAgICA+IEl0IHNlZW1zIHRoZXJlIGFyZSB0d28gZGVhZGxvY2sgZXJyb3Jz
IG9uIHRoZSBsb2NrDQogICAgPiAqc2NoZWQtPndvcmtfZG9uZV93YWl0X211dGV4KmFuZCpzY2hl
ZC0+c3RhcnRfd29ya19tdXRleC4qDQogICAgPiANCiAgICA+IFRoZXkgYXJlIHRyaWdnZXJlZCBk
dWUgdG8gb25lIHRocmVhZChBKSBydW5zIGZ1bmN0aW9uICpydW5fb25lX3Rlc3QqIGxvY2F0aW5n
DQogICAgPiBpbiBhIGxvb3AgYW5kIHVucmVsZWFzaW5nIHRoZSB0d28gbG9ja3MgaW4gdGhlKndh
aXRfZm9yX3Rhc2tzKmZ1bmN0aW9uLCBhbmQNCiAgICA+IGFub3RoZXIgdGhyZWFkKEIpIHJ1bnMg
ZnVuY3Rpb24gKnRocmVhZF9mdW5jICphY3F1aXJpbmcgdGhlIHR3byBsb2Nrcy4NCiAgICA+IA0K
ICAgID4gQmVjYXVzZSB0aGUgdHdvIGxvY2tzIGFyZSBub3QgcHJvcGVybHkgcmVsZWFzZWQgaW4g
dGhyZWFkIEEsIHRoZXJlIHdpbGwgYmUNCiAgICA+IGEgIGRlYWRsb2NrIHByb2JsZW0gaWYgdGhy
ZWFkIEIgYWNxdWlyZXMgdGhlIHR3byBsb2Nrcy4NCg0KICAgIGhpLA0KICAgIGRvIHlvdSBoYXZl
IGEgd2F5IHRvIHJlcHJvZHVjZSB0aGlzPw0KDQogICAgdGhhbmtzLA0KICAgIGppcmthDQoNCiAg
ICA+IA0KICAgID4gVGhlIHJlbGF0ZWQgY29kZXMgYXJlIGJlbG93Og0KICAgID4gDQogICAgPiBU
aHJlYWQgQToNCiAgICA+IA0KICAgID4gc3RhdGljIHZvaWQgY3JlYXRlX3Rhc2tzKHN0cnVjdCBw
ZXJmX3NjaGVkICpzY2hlZCkNCiAgICA+IHsNCiAgICA+ICAgICAgLi4uOw0KICAgID4gICBlcnIg
PSBwdGhyZWFkX211dGV4X2xvY2soJnNjaGVkLT5zdGFydF93b3JrX211dGV4KTsNCiAgICA+ICAg
ICAuLi47DQogICAgPiAgZXJyID0gcHRocmVhZF9tdXRleF9sb2NrKCZzY2hlZC0+d29ya19kb25l
X3dhaXRfbXV0ZXgpOw0KICAgID4gICAgICAgIC4uLjsNCiAgICA+IH0NCiAgICA+IHN0YXRpYyBp
bnQgcGVyZl9zY2hlZF9fcmVwbGF5KHN0cnVjdCBwZXJmX3NjaGVkICpzY2hlZCkNCiAgICA+IHsN
CiAgICA+ICAgIC4uLjsNCiAgICA+IA0KICAgID4gICAgICAgICBjcmVhdGVfdGFza3Moc2NoZWQp
Ow0KICAgID4gICAgICBwcmludGYoIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxuIik7DQogICAgPiAgICAgIGZvciAoaSA9IDA7IGkg
PCBzY2hlZC0+cmVwbGF5X3JlcGVhdDsgaSsrKQ0KICAgID4gICAgICAgICAgIHJ1bl9vbmVfdGVz
dChzY2hlZCk7ICAgLy8gbXVsdGlwbGUgcmVhY3F1aXNpdGlvbiBvbiB0aGUgbG9jaw0KICAgID4g
c2NoZWQtPndvcmtfZG9uZV93YWl0X211dGV4IGFuZCBzY2hlZC0+c3RhcnRfd29ya19tdXRleA0K
ICAgID4gDQogICAgPiAgICByZXR1cm4gMDsNCiAgICA+IH0NCiAgICA+IA0KICAgID4gc3RhdGlj
IHZvaWQgcnVuX29uZV90ZXN0KHN0cnVjdCBwZXJmX3NjaGVkICpzY2hlZCkNCiAgICA+IHsNCiAg
ICA+ICAuLi47DQogICAgPiAgICAgICB3YWl0X2Zvcl90YXNrcyhzY2hlZCk7DQogICAgPiAgICAg
ICAgIC4uLjsNCiAgICA+IH0NCiAgICA+IHN0YXRpYyB2b2lkIHdhaXRfZm9yX3Rhc2tzKHN0cnVj
dCBwZXJmX3NjaGVkICpzY2hlZCkNCiAgICA+IHsNCiAgICA+ICAgICAgICAuLi47DQogICAgPiAg
ICAgcHRocmVhZF9tdXRleF91bmxvY2soJnNjaGVkLT53b3JrX2RvbmVfd2FpdF9tdXRleCk7DQog
ICAgPiANCiAgICA+ICAgLi4uOw0KICAgID4gICAgICAgIHJldCA9IHB0aHJlYWRfbXV0ZXhfbG9j
aygmc2NoZWQtPndvcmtfZG9uZV93YWl0X211dGV4KTsNCiAgICA+ICAgICAgLi4uOw0KICAgID4g
ICBwdGhyZWFkX211dGV4X3VubG9jaygmc2NoZWQtPnN0YXJ0X3dvcmtfbXV0ZXgpOw0KICAgID4g
DQogICAgPiAgICAgLi4uOw0KICAgID4gDQogICAgPiAgcmV0ID0gcHRocmVhZF9tdXRleF9sb2Nr
KCZzY2hlZC0+c3RhcnRfd29ya19tdXRleCk7DQogICAgPiAgICAuLi4uOw0KICAgID4gfQ0KICAg
ID4gDQogICAgPiBUaHJlYWQgQjoNCiAgICA+IA0KICAgID4gc3RhdGljIHZvaWQgKnRocmVhZF9m
dW5jKHZvaWQgKmN0eCkNCiAgICA+IHsNCiAgICA+IA0KICAgID4gLi4uOw0KICAgID4gcmV0ID0g
cHRocmVhZF9tdXRleF9sb2NrKCZzY2hlZC0+c3RhcnRfd29ya19tdXRleCk7DQogICAgPiAuLi47
DQogICAgPiByZXQgPSBwdGhyZWFkX211dGV4X3VubG9jaygmc2NoZWQtPnN0YXJ0X3dvcmtfbXV0
ZXgpOw0KICAgID4gDQogICAgPiAuLi47DQogICAgPiANCiAgICA+IHJldCA9IHB0aHJlYWRfbXV0
ZXhfbG9jaygmc2NoZWQtPndvcmtfZG9uZV93YWl0X211dGV4KTsNCiAgICA+IC4uLjsNCiAgICA+
IHJldCA9IHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZzY2hlZC0+d29ya19kb25lX3dhaXRfbXV0ZXgp
Ow0KICAgID4gLi47DQogICAgPiANCiAgICA+IH0NCiAgICA+IA0KICAgID4gDQogICAgPiBUaGFu
a3MsDQoNCg0K
