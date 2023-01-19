Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F7AC004D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 12:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjASMDk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 07:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjASMDE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 07:03:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F86F32E
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 04:02:56 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-xAOJsk7xO263fOVjhcvUfw-1; Thu, 19 Jan 2023 12:02:54 +0000
X-MC-Unique: xAOJsk7xO263fOVjhcvUfw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Jan
 2023 12:02:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 19 Jan 2023 12:02:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Athira Rajeev' <atrajeev@linux.vnet.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
CC:     "irogers@google.com" <irogers@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "rnsastry@linux.ibm.com" <rnsastry@linux.ibm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "disgoel@linux.ibm.com" <disgoel@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH V2] tools/perf/tests: Fix string substitutions in build id
 test
Thread-Topic: [PATCH V2] tools/perf/tests: Fix string substitutions in build
 id test
Thread-Index: AQHZK/ml5s18h1FtXky26yQzQ7zuR66lntwQ
Date:   Thu, 19 Jan 2023 12:02:53 +0000
Message-ID: <17bd5aca40164637bfbd47da34811a13@AcuMS.aculab.com>
References: <20230119113054.31742-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230119113054.31742-1-atrajeev@linux.vnet.ibm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RnJvbTogQXRoaXJhIFJhamVldg0KPiBTZW50OiAxOSBKYW51YXJ5IDIwMjMgMTE6MzENCi4uLg0K
PiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9idWlsZGlkLnNoIGIvdG9vbHMv
cGVyZi90ZXN0cy9zaGVsbC9idWlsZGlkLnNoDQo+IGluZGV4IGFhZjg1MTEwOGNhMy4uNDNlNDNl
MTMxYmU3IDEwMDc1NQ0KPiAtLS0gYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL2J1aWxkaWQuc2gN
Cj4gKysrIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9idWlsZGlkLnNoDQo+IEBAIC02Niw3ICs2
Niw3IEBAIGNoZWNrKCkNCj4gIAllc2FjDQo+ICAJZWNobyAiYnVpbGQgaWQ6ICR7aWR9Ig0KPiAN
Cj4gLQlsaW5rPSR7YnVpbGRfaWRfZGlyfS8uYnVpbGQtaWQvJHtpZDowOjJ9LyR7aWQ6Mn0NCj4g
KwlsaW5rPSR7YnVpbGRfaWRfZGlyfS8uYnVpbGQtaWQvJChlY2hvICR7aWR9fGN1dCAtYyAxLTIp
LyQoZWNobyAke2lkfXxjdXQgLWMgMy0pDQo+ICAJZWNobyAibGluazogJHtsaW5rfSINCg0KVGhh
dCBpcyBob3JyaWQsIHdoeSBub3QganVzdCB1c2UgdmFsaWQgc2hlbGwgc3Vic3RpdHV0aW9ucywg
ZWc6DQoJaWRfZmlsZT0ke2lkIz8/fQ0KCWlkX2Rpcj0ke2lkJSRpZF9maWxlfQ0KCWxpbms9JGJ1
aWxkX2lkX2Rpci8uYnVpbGQtaWQvJGlkX2Rpci8kaWRfZmlsZQ0KDQouLi4NCj4gLQljaGVjayAk
e0A6IC0xfQ0KPiArCWNoZWNrICRsYXN0DQoNClNpbmNlIHRoaXMgaXMgdGhlIGVuZCBvZiB0aGUg
c2hlbGwgZnVuY3Rpb24geW91IGNhbiBhdm9pZCB0aGUgZXZhbA0KYnkgZG9pbmc6DQoJc2hpZnQg
JCgoJCMgLSAxKSkNCgljaGVjayAkMQ0Kb3IgbWF5YmU6DQoJYXJncz0iJCoiDQoJY2hlY2sgJHth
cmdzIyMqIH0NCg0KVGhvc2Ugc2hvdWxkIGJlIG9rIGluIGFsbCBwb3NpeCBzaGVsbHMuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

