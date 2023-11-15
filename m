Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028C39FCE
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="lzlNilzD"
Received: from m13115.mail.163.com (m13115.mail.163.com [220.181.13.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 419338E;
	Wed, 15 Nov 2023 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1os97UaCpOYOB9voGOdOWIInSJhg/hWwpVqahgHpJrc=; b=l
	zlNilzD/ZWq4ump3+UDtCMl0CJF1qcBK4kMAckflEaDG9Gmqa5x8Fr8senHK7JM2
	nVa3SJJ8ZddRzL97zEmHXV3bQblEyD1P/f+JKZvn5XXUsNnwHQnWDzvCiOX41AG0
	MJ9YGPKu7hQBFTTiP+NOHlyvr7baTJJwfiFrdwf+AE=
Received: from 00107082$163.com ( [111.35.186.243] ) by
 ajax-webmail-wmsvr115 (Coremail) ; Thu, 16 Nov 2023 00:24:32 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date: Thu, 16 Nov 2023 00:24:32 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed
 for aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <CAM9d7cjY_NzPZKtQbSUzhLwrH+zAPB701PAiCHSmnvjcHnhLTQ@mail.gmail.com>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
 <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <CAM9d7cjY_NzPZKtQbSUzhLwrH+zAPB701PAiCHSmnvjcHnhLTQ@mail.gmail.com>
X-NTES-SC: AL_Qu2bAvydukws5CafY+kZnEYQheY4XMKyuPkg1YJXOp80qSvR3Ac+Qm1GJF3b/P+fAQWUogqGWwBf7vl6YbVUVpxoOxWtQo5qpgvvywBwS/CG
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15854406.6b75.18bd3cc70a9.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:c8GowADnD4nA8FRle8QHAA--.64142W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBnAEpqlghlW-3-AAJsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDIzLTExLTE1IDIzOjQ1OjM4LCAiTmFtaHl1bmcgS2ltIiA8bmFtaHl1bmdAa2VybmVs
Lm9yZz4gd3JvdGU6Cj5IZWxsbywKPgoKPj4KPj4gT24gVHVlLCBOb3YgMTQsIDIwMjMgYXQgMTE6
MjA6MzJQTSArMDgwMCwgRGF2aWQgV2FuZyB3cm90ZToKPj4gPgo+PiA+Cj4+ID4gQXQgMjAyMy0x
MS0xNCAxMjozMToxMiwgIkRhdmlkIFdhbmciIDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPj4g
PiA+SGksCj4+ID4gPgo+PiA+ID5JIHdhcyBtYWtpbmcga2VybmVsIHByb2ZpbGluZyB0byBpZGVu
dGlmeSBrZXJuZWwgY2hhbmdlcyBiZXR3ZWVuIHJldmlzaW9ucyB1bmRlciB0aGUgbG9hZCBvZiBm
aW8gYmVuY2htYXJrLAo+PiA+Cj4+ID4gPkJ1dCBJIGRpZCBub3Qgbm90aWNlIGEgc2lnbmlmaWNh
bnQgY2hhbmdlIGluIHRoZSBvdmVyaGVhZCBvZiBwZXJmIHRyYWNpbmcgYmFzZWQgb24gdGhlIGZp
byByZXBvcnQsCj4+ID4gPnRoYXQgaXMgd2h5IEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGlzIGlz
IGEgcmVncmVzc2lvbiBvciBhbiBpbXByb3ZlbWVudC4uLi4KPj4gPiA+SnVzdCByZXBvcnQgdGhl
IGNoYW5nZS4KPgo+RG8geW91IG1lYW4gZjA2Y2M2NjdmNzkgKCJwZXJmOiBPcHRpbWl6ZSBwZXJm
X2Nncm91cF9zd2l0Y2giKT8KClllcwoKPkRpZCB5b3UgaGF2ZSBjZ3JvdXAgZXZlbnRzIHdoZW4g
eW91IHJhbiB0aGUgYmVuY2htYXJrPwo+T3RoZXJ3aXNlIGl0IHNob3VsZCBub3QgbWFrZSBhbnkg
ZGlmZmVyZW5jZXMuCj4KCk15IHRlc3QgaGFwcGVuZWQgdG8gdHJpZ2dlciBmcmVxdWVudCBjb250
ZXh0IHN3aXRjaCAoSU8gYmVuY2gpLCBhbmQgbXkgcHJvZmlsaW5nIHdhcyB0YXJnZXRpbmcgYSBj
Z3JvdXAgKHYyKSB3aGVyZSBmaW8gcnVucy4gICwgeWVzLCBjZ3JvdXAgYW5kIGNvbnRleHQgc3dp
dGNoICA6KQoKPgo+PiA+IEkgdGhpbmsgdGhlcmUgYXJlIHNvbWUgY2FzZXMgd2hlcmUgcG11X2N0
eC0+bnJfY2dyb3VwcyBpcyB6ZXJvIGJ1dCB0aGVyZSBpcyBzdGlsbCBjZ3JvdXAgZXZlbnQgd2l0
aGluLCBhbmQgc29tZSBzYW1wbGVzIGFyZSBtaXNzZWQsIGNhdXNpbmcgdGhlIHN0YXRzIGNoYW5n
ZXMsIGp1c3QgYSBndWVzcy4KPgo+SSBkb24ndCBrbm93IHdoYXQgbWFrZXMgeW91IHRoaW5rIHNv
LiAgRG8geW91IHNlZQo+ZGlmZmVyZW5jZXMgaW4gdGhlIHBlcmYgb3V0cHV0PyAgQW55IGNncm91
cCBldmVudHMgaGF2aW5nCj5zbWFsbGVyIG51bWJlciBvZiBzYW1wbGVzIG9yIGNvdW50cz8KCkkg
b2J2ZXJzZSB0b3RhbCBzYW1wbGUgY291bnQgZGVjcmVhc2VkIDEwJX4yMCUsICBvbmUgcmVwb3J0
IHNob3cgc2FtcGxlIGNvdW50IGluY3JlYXNlIGZyb20gMjY2NTIxIHRvIDMxNzY0OSBhZnRlciBy
ZXZlcnRpbmcgdGhlIGNvbW1pdC4KQnV0IEkgZGlkIG5vdCB1c2UgcGVyZi10b29sLCBJIHdpbGwg
dHJ5IGl0LiAKCj4KPk9yIHdhcyB0aGUgZmlvIGJlbmNobWFyayBkZWdyYWRlZCBzZXJpb3VzbHk/
Cj4KCk5vb3AsIGJlbmNobWFyayBkaWQgZGVncmFkZSB3aGVuIHByb2ZpbGluZyBpcyBydW5uaW5n
LCBidXQgbm8gc2lnbmlmaWNhbnQgY2hhbmdlcyBvYnNlcnZlZCAgdy9vIHRoZSBjb21taXQuCgoK
CkRhdmlkIFdhbmc=
