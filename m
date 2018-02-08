From: "Christian Hansen (chansen3)" <chansen3@cisco.com>
Subject: Recording memory addresses on ARM
Date: Thu, 8 Feb 2018 15:17:33 +0000
Message-ID: <42BDBD72-87FE-4DFA-8A5D-6CEB2DAF1262@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from alln-iport-1.cisco.com ([173.37.142.88]:59987 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHP1A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Feb 2018 10:27:00 -0500
Received: from XCH-ALN-011.cisco.com (xch-aln-011.cisco.com [173.36.7.21])
        by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id w18FHXWA014668
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <linux-perf-users@vger.kernel.org>; Thu, 8 Feb 2018 15:17:33 GMT
Content-Language: en-US
Content-ID: <B64F51C3E4FD7C4798DF958CF09C5B68@emea.cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

SXMgaXMgcG9zc2libGUgdG8gY2FwdHVyZSB0aGUgYWRkcmVzcyBvZiBtZW1vcnkgYWNjZXNzZXMg
dXNpbmcgcGVyZiBvbiBBUk0/ICBJbml0aWFsbHksIEkgdGhvdWdodCBwZXJmLW1lbSB3b3VsZCBk
byB0aGUgdHJpY2ssIGJ1dCBhcHBhcmVudGx5IGl0cyBmdW5jdGlvbmFsaXR5IGlzIGVudGlyZWx5
IGRlcGVuZGVudCBvbiBJbnRlbCBDUFVzIHdpdGggUEVCUy4gIFRoZW4gSSBub3RpY2VkIHRoYXQg
cGVyZi1yZWNvcmQgdGFrZXMgYSAtZCBmbGFnICh1c2VkIGJ5IHBlcmYtbWVtKS4gIEFsdGhvdWdo
IHRoZSBkZXNjcmlwdGlvbiBvZiB0aGF0IGZsYWcgaXMgdmFndWUgKGNhcHR1cmUgd2hhdCBhZGRy
ZXNzZXM/KSwgd2hlbiB1c2VkIGFzIHN1Y2ggInBlcmYgcmVjb3JkIC1lIGFybXY4X2NvcnRleF9h
NzIvbWVtX2FjY2Vzcy91IC1kIC1wIDE2OTYzIHNsZWVwIDXigJ0gYW5kIHRoZW4gZHVtcGluZyB0
aGUgdHJhY2UgdmlhIOKAnHBlcmYgcmVwb3J0IOKAlG1lbS1tb2Rl4oCdIEkgZ2V0IDBzIGluIHRo
ZSBkYXRhIHN5bWJvbCBjb2x1bW4uICBTbyB0aGlzIGFsc28gYXBwZWFycyB0byBoYXZlIG5vIGVm
ZmVjdCBvbiBteSBoYXJkd2FyZS4gIEFzIHRoZSBjb21tYW5kIHVzZWQgcmV2ZWFscywgSeKAmW0g
dXNpbmcgcGVyZiBvbiBhIENvcnRleCBBNzIgYW5kIG9uIExpbnV4IDQuNC4NCg0KSeKAmW0gYXdh
cmUgdGhhdCBmb3IgQVJNIHRoZXJl4oCZcyBhIFN0YXRpc3RpY2FsIFByb2ZpbGluZyBFeHRlbnNp
b24gZm9yIHdoaWNoIHN1cHBvcnQgd2VudCBpbnRvIHRoZSBrZXJuZWwgcmVjZW50bHkgYW5kIHdo
aWNoIGNvdWxkIHBvdGVudGlhbGx5IHN1cHBvcnQgdGhpcyBpbmZvcm1hdGlvbiwgYnV0IHRoYXQg
cmVxdWlyZXMgQVJNdjguMi4gIFRoZXJl4oCZcyBhbiBFbWJlZGRlZCBUcmFjZSBNYWNyb2NlbGwg
b24gbXkgQ1BVIGFuZCBwZXJmIHN1cHBvcnQgaXMgYWxzbyBpbiB0aGUga2VybmVsLCBidXQgbXkg
dW5kZXJzdGFuZGluZyBpcyB0aGF0IGNhcHR1cmluZyBhIGRhdGEgdHJhY2UgaXMgbm90IGF2YWls
YWJsZSBmb3IgQSBwcm9maWxlIENQVXMsIHdoaWNoIGlzIHdoYXQgSSBoYXZlLg0KDQpBbSBJIG92
ZXJsb29raW5nIHNvbWUgc29mdHdhcmUgc3VwcG9ydCBmb3IgdGhpcyBpbiBwZXJmIG9yIGFtIEkg
c2ltcGx5IGFza2luZyB0aGUgaW1wb3NzaWJsZT8NCg0KVGhhbmsgeW91LA0KQ2hyaXN0aWFuIEhh
bnNlbg==
