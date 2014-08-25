From: John Spencer <maillist-linux@barfooze.de>
Subject: [PATCH 2/2] perf Makefile: default WERROR to off.
Date: Mon, 25 Aug 2014 21:37:08 +0200
Message-ID: <53FB9064.1050000@barfooze.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000203080305000307050505"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from hindenburg.barfooze.de ([195.154.9.123]:62125 "EHLO
	hindenburg.barfooze.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbaHYUBW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 25 Aug 2014 16:01:22 -0400
Received: from [127.0.0.1] (bl8-60-237.dsl.telepac.pt [85.241.60.237])
	(authenticated bits=0)
	by hindenburg.barfooze.de (8.14.7/8.14.7) with ESMTP id s7PJcGbV066777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2014 21:38:36 +0200 (CEST)
	(envelope-from maillist-linux@barfooze.de)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------000203080305000307050505
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


--------------000203080305000307050505
Content-Type: text/plain;
 name="0002-perf-Makefile-default-WERROR-to-off.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="0002-perf-Makefile-default-WERROR-to-off.patch"

RnJvbSA0YTcyMDMyODI4YTY3ODRkOTNmNGJlY2Y3MjMzMDNhMTdkNzIzNTQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIFNwZW5jZXIgPG1haWxsaXN0LWxpbnV4QGJh
cmZvb3plLmRlPgpEYXRlOiBNb24sIDI1IEF1ZyAyMDE0IDIxOjI1OjQzICswMjAwClN1Ympl
Y3Q6IFtQQVRDSCAyLzJdIHBlcmYgTWFrZWZpbGU6IGRlZmF1bHQgV0VSUk9SIHRvIG9mZi4K
CkhhdmluZyBXRVJST1Igb24gYnkgZGVmYXVsdCBicmVha3MgYnVpbGQgZXZlcnl3aGVyZSB0
aGUgYXV0aG9yIGhhc24ndAp0ZXN0ZWQgc28gZmFyOyBpbmNsdWRpbmcgbXVzbCBsaWJjIHdo
aWNoIHdhcm5zIGFib3V0IHdyb25nIGluY2x1ZGVzLgoKVGhlIHVuc3VzcGVjdGluZyB1c2Vy
IHdpbGwgdGhpbmsgdGhlcmUncyBzb21ldGhpbmcgYnJva2VuIGFuZCBvbmx5CmlmIGhlJ3Mg
Y291cmVhZ2V1b3VzIGVub3VnaCB0byBncmVwIHRoZSBNYWtlZmlsZSBpbmZyYXN0cnVjdHVy
ZSBmaW5kCm91dCB0aGF0IGhlIG1heSBiZSBhYmxlIHRvIGdldCB0aGUgYnVpbGQgd29ya2lu
ZyB3aXRoIFdFUlJPUj0wLgoKT1RPSCB3aXRoIFdFUlJPUiBkZWZhdWx0aW5nIHRvIG9mZiwg
YW55dGhpbmcgd2lsbCB3b3JrIGZvciB0aGUgdXNlcgphbmQgdGhlIG1haW50YWluZXIgY2Fu
IGtub3dpbmdseSB1c2UgV0VSUk9SPTEgdG8gZG8gaGlzIHRlc3QgYnVpbGRzLgoKU2lnbmVk
LW9mZi1ieTogSm9obiBTcGVuY2VyIDxtYWlsbGlzdC1saW51eEBiYXJmb296ZS5kZT4KCi0t
LQogdG9vbHMvcGVyZi9jb25maWcvTWFrZWZpbGUgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90b29scy9wZXJm
L2NvbmZpZy9NYWtlZmlsZSBiL3Rvb2xzL3BlcmYvY29uZmlnL01ha2VmaWxlCmluZGV4IDFm
NjdhYTAuLmIxZDYzOWEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3BlcmYvY29uZmlnL01ha2VmaWxl
CisrKyBiL3Rvb2xzL3BlcmYvY29uZmlnL01ha2VmaWxlCkBAIC0xMDIsNyArMTAyLDcgQEAg
aWZlcSAoJChjYWxsIGdldC1leGVjdXRhYmxlLCQoQklTT04pKSwpCiBlbmRpZgogCiAjIFRy
ZWF0IHdhcm5pbmdzIGFzIGVycm9ycyB1bmxlc3MgZGlyZWN0ZWQgbm90IHRvCi1pZm5lcSAo
JChXRVJST1IpLDApCitpZmVxICgkKFdFUlJPUiksMSkKICAgQ0ZMQUdTICs9IC1XZXJyb3IK
IGVuZGlmCiAKLS0gCjEuOC40Cgo=
--------------000203080305000307050505--
