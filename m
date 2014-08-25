From: John Spencer <maillist-linux@barfooze.de>
Subject: [PATCH 1/2] perf Makefile: fix GNU-only grep usage
Date: Mon, 25 Aug 2014 21:36:32 +0200
Message-ID: <53FB9040.8060802@barfooze.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030906030507000106070307"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from hindenburg.barfooze.de ([195.154.9.123]:62125 "EHLO
	hindenburg.barfooze.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbaHYUBU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 25 Aug 2014 16:01:20 -0400
Received: from [127.0.0.1] (bl8-60-237.dsl.telepac.pt [85.241.60.237])
	(authenticated bits=0)
	by hindenburg.barfooze.de (8.14.7/8.14.7) with ESMTP id s7PJbch6066761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2014 21:37:39 +0200 (CEST)
	(envelope-from maillist-linux@barfooze.de)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906030507000106070307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


--------------030906030507000106070307
Content-Type: text/plain;
 name="0001-perf-Makefile-fix-GNU-only-grep-usage.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="0001-perf-Makefile-fix-GNU-only-grep-usage.patch"

RnJvbSBlZmE3OWQ1YjdiYzc1MDM2OTMzMmEzYTM0NDQyNTczYWY3YjFiMzVjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIFNwZW5jZXIgPG1haWxsaXN0LWxpbnV4QGJh
cmZvb3plLmRlPgpEYXRlOiBNb24sIDI1IEF1ZyAyMDE0IDIxOjI0OjMwICswMjAwClN1Ympl
Y3Q6IFtQQVRDSCAxLzJdIHBlcmYgTWFrZWZpbGU6IGZpeCBHTlUtb25seSBncmVwIHVzYWdl
Cgp0aGlzIG1ha2VzIGl0IHdvcmsgd2l0aCBub24tR05VIGdyZXAncyBhcyB3ZWxsLgoKU2ln
bmVkLW9mZi1ieTogSm9obiBTcGVuY2VyIDxtYWlsbGlzdC1saW51eEBiYXJmb296ZS5kZT4K
Ci0tLQogdG9vbHMvcGVyZi9jb25maWcvdXRpbGl0aWVzLm1hayB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rv
b2xzL3BlcmYvY29uZmlnL3V0aWxpdGllcy5tYWsgYi90b29scy9wZXJmL2NvbmZpZy91dGls
aXRpZXMubWFrCmluZGV4IDRkOTg1ZTAuLjcwNzZhNjIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bl
cmYvY29uZmlnL3V0aWxpdGllcy5tYWsKKysrIGIvdG9vbHMvcGVyZi9jb25maWcvdXRpbGl0
aWVzLm1hawpAQCAtMTMyLDcgKzEzMiw3IEBAIGVuZGVmCiAjCiAjIFVzYWdlOiBib29sLXZh
bHVlID0gJChjYWxsIGlzLWFic29sdXRlLHBhdGgpCiAjCi1pcy1hYnNvbHV0ZSA9ICQoc2hl
bGwgZWNobyAkKHNoZWxsLXNxKSB8IGdyZXAgXi8gLXEgJiYgZWNobyB5KQoraXMtYWJzb2x1
dGUgPSAkKHNoZWxsIGVjaG8gJChzaGVsbC1zcSkgfCBncmVwIC1xIF4vICYmIGVjaG8geSkK
IAogIyBsb29rdXAKICMKLS0gCjEuOC40Cgo=
--------------030906030507000106070307--
