Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB6C004D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjASPu2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 10:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjASPuH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 10:50:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45378103B
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 07:49:19 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-16-nL5EHvjbPXi_4VgMazjDCw-1; Thu, 19 Jan 2023 15:49:17 +0000
X-MC-Unique: nL5EHvjbPXi_4VgMazjDCw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Jan
 2023 15:49:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 19 Jan 2023 15:49:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Athira Rajeev' <atrajeev@linux.vnet.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "rnsastry@linux.ibm.com" <rnsastry@linux.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "disgoel@linux.ibm.com" <disgoel@linux.ibm.com>
Subject: RE: [PATCH V3] tools/perf/tests: Fix string substitutions in build id
 test
Thread-Topic: [PATCH V3] tools/perf/tests: Fix string substitutions in build
 id test
Thread-Index: AQHZLBIrp7uRxIXInkOHsORdTF5RZK6l4s+w
Date:   Thu, 19 Jan 2023 15:49:15 +0000
Message-ID: <1a2f988593a4403db2a043ff42886ced@AcuMS.aculab.com>
References: <20230119142719.32628-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230119142719.32628-1-atrajeev@linux.vnet.ibm.com>
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

RnJvbTogQXRoaXJhIFJhamVldg0KPiBTZW50OiAxOSBKYW51YXJ5IDIwMjMgMTQ6MjcNCi4uLg0K
PiBUaGUgdGVzdCBzY3JpcHQgInRlc3RzL3NoZWxsL2J1aWxkaWQuc2giIHVzZXMgc29tZSBvZiB0
aGUNCj4gc3RyaW5nIHN1YnN0aXR1dGlvbiB3YXlzIHdoaWNoIGFyZSBzdXBwb3J0ZWQgaW4gYmFz
aCwgYnV0IG5vdCBpbg0KPiAic2giIG9yIG90aGVyIHNoZWxscy4gQWJvdmUgZXJyb3Igb24gbGlu
ZSBudW1iZXIgNjkgdGhhdCByZXBvcnRzDQo+ICJCYWQgc3Vic3RpdHV0aW9uIiBpczoNCg0KTG9v
a3MgYmV0dGVyIC0gYXNzdW1pbmcgaXQgd29ya3MgOi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

