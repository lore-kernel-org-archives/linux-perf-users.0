Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E783921FB;
	Mon, 28 Sep 2026 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574391; cv=none; b=TyDqJ6ivly8YKA0O3bDP9AN6oRX5Y+/uwW8eVRUptTQE4Zot3hLS5KaIQfUnXMa0eztREsMW8SB2K7nA9apY8gbKRJx7hbzfndcXUfLunbdoN0p3rtPyTTxtHFNKuG5HlQcb8rAyjtidPZ4p9egb7OMEhk1Ipz+PSBVac364Ksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574391; c=relaxed/simple;
	bh=ftFZ2HnEv4SL/A0+ikOrSM2KcTXY+Wyg5ROgkIxtHkY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID; b=HB8pVfNScwmLYDp3wZ2nGLS5AqEtOHdiQZdqGzXXEVNv/O78v+4mxpwxDA5jcFQ4/fEA0HLmZUYrttxMWyGq7rG6gAfFrrqVfycYNSWPZtrORED9dharOG9MD0Izg6L9syY6LYpAkm5onQy8z9jl0EZqVacVR+C57rJf00XOBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IBijV9y7; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IBijV9y7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790574373; h=Content-Type:MIME-Version:From:To:Subject:Date:Message-ID;
	bh=ftFZ2HnEv4SL/A0+ikOrSM2KcTXY+Wyg5ROgkIxtHkY=;
	b=IBijV9y7rmUpXicbdAy87370TQRn5zcEGoenbyIzudyS/wSnAEWr3nqZTA1w7Z43lSpHfDZXqHDunoBs0naSPtZnGZnWIjOv4RSBwHS0AduCkxqrkOZI3H3QkXquVBw0eBH3hl6GFKhtF7LAultOO2vZTFwHBhz8XJXm5GPmbdc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fuwenxin@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XBiHlhz_1790574372;
Received: from t50b09067.sqa.eu95(mailfrom:fuwenxin@linux.alibaba.com fp:SMTPD_---0XBiHlhz_1790574372 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 13:46:13 +0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Wenxin Fu <fuwenxin@linux.alibaba.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 irogers@google.com, weilin.wang@intel.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com
Subject: [PATCH] perf intel-tpebs: Stop record process before deleting the
 last entry
Date: Mon, 28 Sep 2026 13:46:12 +0800
Message-ID: <179057437287.652774.7332965203936908557@t50b09067.sqa.eu95>

ZXZzZWxfX3RwZWJzX2Nsb3NlKCkgZGVsZXRlcyB0aGUgcmV0aXJlLWxhdGVuY3kgZW50cnkgZnJv
bQp0cGVic19yZXN1bHRzIGJlZm9yZSBjYWxsaW5nIHRwZWJzX3N0b3AoKS4gU2VuZGluZyB0aGUg
U1RPUCBjb21tYW5kCnRlbXBvcmFyaWx5IGRyb3BzIHRwZWJzX210eCBpbnNpZGUgdHBlYnNfc2Vu
ZF9yZWNvcmRfY21kKCksIGFuZCBpbgp0aGF0IHdpbmRvdyB0aGUgc2FtcGxlIHJlYWRlciB0aHJl
YWQgbWF5IHN0aWxsIGJlIGRyYWluaW5nIHNhbXBsZXMKZmx1c2hlZCBieSBwZXJmIHJlY29yZCBh
ZnRlciBTVE9QLiBXaXRoIHRoZSBlbnRyeSBhbHJlYWR5IGdvbmUsCnRwZWJzX3JldGlyZV9sYXRf
X2ZpbmQoKSBmYWlscywgcHJvY2Vzc19zYW1wbGVfZXZlbnQoKSByZXR1cm5zCi1FSU5WQUwsIHRo
ZSBzZXNzaW9uIGFib3J0cyBhbmQgcGVyZl9zZXNzaW9uX19kZWxldGUoKSBjbG9zZXMgdGhlCnBp
cGUgcmVhZCBlbmQgZWFybHkuIHBlcmYgcmVjb3JkIHRoZW4gZ2V0cyBFUElQRSBvbiBpdHMgZmlu
YWwgc3Rkb3V0CndyaXRlcyBhbmQgaXMga2lsbGVkIGJ5IFNJR1BJUEUgYmVmb3JlIHByaW50aW5n
IGl0cyBzdW1tYXJ5IGxpbmVzLAptYWtpbmcgcGVyZiB0ZXN0ICJJbnRlbCBUUEVCUyBjb3VudGlu
ZyBtb2RlIiBmbGFreSAofjMwJSBmYWlsdXJlCnJhdGUgd2l0aCAncGVyZiBzdGF0IC1lIGNhY2hl
LW1pc3NlczpSIC0tcmVjb3JkLXRwZWJzIC1hIHNsZWVwIDAuMDEnCmluIGEgbG9vcCBvbiBhIDE5
Mi1jb3JlIFhlb24gUGxhdGludW0gODQ3NUIpLgoKU3RvcCB0aGUgcmVjb3JkIHByb2Nlc3Mgd2hp
bGUgdGhlIGxhc3QgZW50cnkgaXMgc3RpbGwgb24gdGhlIGxpc3Qgc28KdGhlIHJlYWRlciBjYW4g
bWF0Y2ggYW5kIGRyYWluIHRoZSByZW1haW5pbmcgc2FtcGxlcywgYW5kIG9ubHkgZGVsZXRlCnRo
ZSBlbnRyeSBhZnRlcndhcmRzLgoKRml4ZXM6IDhkYjVjYWJjZjFiNiAoInBlcmYgc3RhdDogRm9y
ayBhbmQgbGF1bmNoICdwZXJmIHJlY29yZCcgd2hlbiAncGVyZiBzdGF0JyBuZWVkcyB0byBnZXQg
cmV0aXJlIGxhdGVuY3kgdmFsdWUgZm9yIGEgbWV0cmljLiIpClNpZ25lZC1vZmYtYnk6IFdlbnhp
biBGdSA8ZnV3ZW54aW5AbGludXguYWxpYmFiYS5jb20+Ci0tLQogdG9vbHMvcGVyZi91dGlsL2lu
dGVsLXRwZWJzLmMgfCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10
cGVicy5jIGIvdG9vbHMvcGVyZi91dGlsL2ludGVsLXRwZWJzLmMKaW5kZXggYjQxMTcxYjVkZjc3
Li5lN2EwMTE4YmM1ZTQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10cGVicy5j
CisrKyBiL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10cGVicy5jCkBAIC03MTEsMTEgKzcxMSwxNSBA
QCB2b2lkIGV2c2VsX190cGVic19jbG9zZShzdHJ1Y3QgZXZzZWwgKmV2c2VsKQogCW11dGV4X2xv
Y2sodHBlYnNfbXR4X2dldCgpKTsKIAl0ID0gdHBlYnNfcmV0aXJlX2xhdF9fZmluZChldnNlbCk7
CiAJaWYgKHQpIHsKKwkJLyoKKwkJICogU3RvcCB3aGlsZSB0aGUgZW50cnkgaXMgc3RpbGwgdmlz
aWJsZSBzbyB0aGUgcmVhZGVyIHRocmVhZCBjYW4KKwkJICogZHJhaW4gc2FtcGxlcyBmbHVzaGVk
IGFmdGVyIFNUT1A7IG90aGVyd2lzZSBpdCBhYm9ydHMgdGhlCisJCSAqIHNlc3Npb24gYW5kIGNs
b3NlcyB0aGUgcGlwZSwga2lsbGluZyBwZXJmIHJlY29yZCB3aXRoIFNJR1BJUEUuCisJCSAqLwor
CQlpZiAobGlzdF9pc19sYXN0KCZ0LT5uZCwgJnRwZWJzX3Jlc3VsdHMpKQorCQkJdHBlYnNfc3Rv
cCgpOwogCQlsaXN0X2RlbF9pbml0KCZ0LT5uZCk7CiAJCXRwZWJzX3JldGlyZV9sYXRfX2RlbGV0
ZSh0KTsKLQotCQlpZiAobGlzdF9lbXB0eSgmdHBlYnNfcmVzdWx0cykpCi0JCQl0cGVic19zdG9w
KCk7CiAJfQogCW11dGV4X3VubG9jayh0cGVic19tdHhfZ2V0KCkpOwogfQotLSAKMi40My43Cgo=
