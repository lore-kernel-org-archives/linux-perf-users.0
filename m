From: Omar Awile <omar.awile@cern.ch>
Subject: reading PMU counts with perf leader sampling and perf script
Date: Fri, 9 Sep 2016 14:48:53 +0000
Message-ID: <etPan.57d2cbe0.548515bd.6188@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:12128
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751014AbcIJBwM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Sep 2016 21:52:12 -0400
Content-Language: en-US
Content-ID: <71CFA7FDACBC284CBC307CF90AD4E927@cern.ch>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

SGVsbG8sDQoNCknigJl2ZSBiZWVuIHRyeWluZyB0byBnZXQgcGVyaW9kaWMgcmVhZG91dHMgb2Yg
UE1VIGV2ZW50IGNvdW50cyB1c2luZyBwZXJmIHJlY29yZCAoc2ltaWxhciB0byB3aGF0IHBlcmYg
c3RhdCAtSSBkb2VzIGJ1dCB3aXRoIGEgaGlnaGVyIHByZWNpc2lvbiB0aGFuIDEwbXMpLg0KDQpG
b3IgdGhpcyBJIHRob3VnaHQgSSBjb3VsZCB1c2UgbGVhZGVyIHNhbXBsaW5nIHdpdGggcmVmX2N5
Y2xlcyBhbmQgdGhlIGV2ZW50cyBJIGFtIHRhcmdldGluZy4NCg0KRm9yIGV4YW1wbGUgc29tZXRo
aW5nIGxpa2UgdGhpczoNCg0KJCBwZXJmIHJlY29yZCAtUCAtYyAyMDAwMDAwIC1lICd7Y3ljbGVz
LGluc3RydWN0aW9ucyxicmFuY2gtbWlzc2VzfTpTJyDigJQgLi93b3JrbG9hZA0KDQpUaGlzIHNl
ZW1zIHRvIHJlYWQgb3V0IHRoZSBzYW1wbGUgdmFsdWVzIGZvciB0aGUgb3RoZXIgZXZlbnRzIHdo
ZW5ldmVyIHRoZSBjeWNsZSBldmVudCBpcyBzYW1wbGVkLg0KDQpUaGUgbmV4dCBzdGVwIHdvdWxk
IGJlIGZvciBtZSB0byB1c2UgcGVyZiBzY3JpcHQgYW5kIGEgbGl0dGxlIHB5dGhvbiBzY3JpcHQg
dG8gZ2V0IHRoZSBldmVudCBjb3VudHMgYnV0IEkgY2Fu4oCZdCBzZWVtIHRvIGZpbmQgYSB3YXkg
dG8gZG8gdGhpcy4gQ2FuIHNvbWVvbmUgcG9pbnQgbWUgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbj8N
Cg0KcGVyZiByZXBvcnQgc2VlbXMgdG8gYmUgYWJsZSB0byByZWFkIHRoZXNlIHNhbXBsZXMgYnV0
IHRoZXkgYXJlIHNob3duIG9ubHkgYXMgYWdncmVnYXRlcy4gQWxzbywgcGVyZiBzY3JpcHQgd291
bGQgYWxsb3cgbWUgdG8gcHJvY2Vzcy9hbmFseXplIHRoZSBkYXRhIG15c2VsZi4gSWYgdGhpcyBp
cyBjdXJyZW50bHkgbm90IHBvc3NpYmxlLCBob3cgd291bGQgSSBnbyBhYm91dCBhZGRpbmcgdGhl
IG1pc3NpbmcgZnVuY3Rpb25hbGl0eSBpbiBwZXJmIHNjcmlwdD8NCg0KVGhhbmsgeW91LA0KDQpP
bWFyIEF3aWxlDQoNCi0tICANCk9tYXIgQXdpbGUsIFBoLkQuDQpTeXN0ZW1zIFBlcmZvcm1hbmNl
IEVuZ2luZWVyDQpDRVJOIC0gNTEzL1ItMDQ2DQoNCg0K
