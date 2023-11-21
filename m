Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="XevxNjxc"
Received: from m13134.mail.163.com (m13134.mail.163.com [220.181.13.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A746AA0;
	Mon, 20 Nov 2023 21:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2NitR18A+vWxuiDpuLVtoiDeai6ma9yuIj9A/5fN3Kg=; b=X
	evxNjxcljsb4NEenaR8R2ZFFMgiUMRtSfGGa4LHGgp1zo+SmC5d8zW+RsnB4mCcT
	agDAR22ylV02bHLY1KcxFLy4DAfmaUpgg69cRwrmfBGLumy6+Uq/ABCqxUPjLHvF
	1ugps0BRCY+VebYo+gT1+ZwRvurAz4m9JceWFy0USE=
Received: from 00107082$163.com ( [111.35.185.43] ) by ajax-webmail-wmsvr134
 (Coremail) ; Tue, 21 Nov 2023 13:51:11 +0800 (CST)
X-Originating-IP: [111.35.185.43]
Date: Tue, 21 Nov 2023 13:51:11 +0800 (CST)
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
In-Reply-To: <CAM9d7chFQ1L0h0av7ziXU4ja_j1FMRgwd-CHULnOB5YuH9yo2w@mail.gmail.com>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
 <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
 <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
 <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com>
 <CAM9d7cgjCKynoTC0L53pEXnCWHF7AZ8Gr2a0xQnes7L24KVNsA@mail.gmail.com>
 <489ecb9e.28cc.18bd650affa.Coremail.00107082@163.com>
 <CAM9d7cg-tudzG4iPMHs5L-zYMe-WhyzZXN9eOtkoapS1n7t8AA@mail.gmail.com>
 <1da1b7f.564.18be01bd6ce.Coremail.00107082@163.com>
 <CAM9d7chFQ1L0h0av7ziXU4ja_j1FMRgwd-CHULnOB5YuH9yo2w@mail.gmail.com>
X-NTES-SC: AL_Qu2bAvmfukAs5yKdYOkZnEYQheY4XMKyuPkg1YJXOp80iivx0yEfQFFuOHDN/8eXOi6qnja3aSBw1eR0UYdzcaP8V0/TtCdaxQihuzpMWW/m
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b5426dd.4bb8.18bf06ebd99.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hsGowADnL7JQRVxlOgkKAA--.9382W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiFgAvql44X66aqgALs-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjMtMTEtMjEgMDY6NTk6MTgsICJOYW1oeXVuZyBLaW0iIDxuYW1oeXVuZ0BrZXJuZWwu
b3JnPiB3cm90ZToKPk9uIEZyaSwgTm92IDE3LCAyMDIzIGF0IDU6NDjigK9QTSBEYXZpZCBXYW5n
IDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPj4KCj4+ID5BbmQgaXMgdGhlcmUgYW55IGNoYW5j
ZSBpZiBpdCdzIGltcHJvdmVkIGJlY2F1c2Ugb2YgdGhlIGNoYW5nZT8KPj4gPkFyZSB0aGUgbnVt
YmVycyBpbiA2LjcgYmV0dGVyIG9yIHdvcnNlPwo+PiA+Cj4+IEkgaGF2ZSBubyBpZGVhIHdoZXRo
ZXIgdGhlIGNoYW5nZSBvZiBleHBlY3RlZCB0b3RhbCBzYW1wbGUgY291bnQgYSBidWcgb3IgYSBm
aXgsICBidXQsICB0aGUgb2JzZXJ2ZWQgcmVzdWx0IHRoYXQgdG90YWwgc2FtcGxlIGNvdW50IGRy
aWZ0IGEgbG90IChiaWdnZXIgc3RhbmRhcmQgZGV2aWF0aW9uKSwgSSB0aGluayAsICBpcyBhIGJh
ZCB0aGluZy4KPgo+UmlnaHQuICBDYW4geW91IHJ1biBwZXJmIHN0YXQgdG8gbWVhc3VyZSB0aGUg
bnVtYmVyIG9mIGNvbnRleHQKPnN3aXRjaGVzIGFuZCBjZ3JvdXAgc3dpdGNoZXMsIHRoZW4/Cj4K
PiAgc3VkbyBwZXJmIHN0YXQgLWEgLWUgY29udGV4dC1zd2l0Y2hlcyxjZ3JvdXAtc3dpdGNoZXMg
LS0gc2xlZXAgMTAKPgoKSSB1cGdyYWRlZCB0byA2LjctcmMyLCAgbm93IEkgYW0gdGVzdGluZyB2
Ni43LXJjMiBhZ2FpbnN0IHY2LjctcmMyIHdpdGggZjA2Y2M2NiByZXZlcnRlZCB3aXRoIGZvbGxv
d2luZyBjb21tYW5kOgokIGZvciBpIGluIHsxLi42fTsgZG8gc3VkbyAuL3BlcmYgc3RhdCAtYSAt
ZSBjb250ZXh0LXN3aXRjaGVzLGNncm91cC1zd2l0Y2hlcyAtRyBteXRlc3QgLS0gc2xlZXAgMTA7
IHNsZWVwIDE7IGRvbmUKd2hpbGUgYGZpbyAtLXJhbmRyZXBlYXQ9MSAtLWlvZW5naW5lPWxpYmFp
byAtLWRpcmVjdD0xIC0tbmFtZT10ZXN0ICAtLWJzPTRrIC0taW9kZXB0aD02NCAtLXNpemU9MUcg
LS1yZWFkd3JpdGU9cmFuZHJ3ICAtLXJ1bnRpbWU9MzAwIC0tbnVtam9icz00IC0tdGltZV9iYXNl
ZD0xYCB3YXMgcnVubmluZyBpbiBjZ3JvdXAgbXl0ZXN0LgogCnY2LjctcmMyCistLS0tKy0tLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tKwp8ICAgIHwgY29udGV4
dC1zd2l0Y2hlcyB8IGNncm91cC1zd2l0Y2hlcyB8ICByYXRpbyAgIHwKKy0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0rCnwgIzEgfCAgICAgIDUwNTE2
OCAgICAgIHwgICAgICA1MDM0OTQgICAgIHwgMTowLjk5NjcgfAp8ICMyIHwgICAgICA1MDM2Mjcg
ICAgICB8ICAgICAgNTAxOTMyICAgICB8IDE6MC45OTY2IHwKfCAjMyB8ICAgICAgNTA5MzUyICAg
ICAgfCAgICAgIDUwNzM5NyAgICAgfCAxOjAuOTk2MiB8CnwgIzQgfCAgICAgIDUxMDI3NCAgICAg
IHwgICAgICA1MDgzNTcgICAgIHwgMTowLjk5NjIgfAp8ICM1IHwgICAgICA1MDg4NzIgICAgICB8
ICAgICAgNTA3MDYzICAgICB8IDE6MC45OTY0IHwKfCAjNiB8ICAgICAgNTA2MTM4ICAgICAgfCAg
ICAgIDUwNDIwNSAgICAgfCAxOjAuOTk2MiB8CistLS0tKy0tLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tKwoKdjYuNy1yYzIgd2l0aCBmMDZjYzY2IHJldmVydGVk
OgorLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSsK
fCAgICB8IGNvbnRleHQtc3dpdGNoZXMgfCBjZ3JvdXAtc3dpdGNoZXMgfCAgcmF0aW8gICB8Cist
LS0tKy0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tKwp8ICMx
IHwgICAgICA0NjI1MDQgICAgICB8ICAgICAgNDYwNzMzICAgICB8IDE6MC45OTYyIHwKfCAjMiB8
ICAgICAgNDY0NzE3ICAgICAgfCAgICAgIDQ2MzAzNiAgICAgfCAxOjAuOTk2NCB8CnwgIzMgfCAg
ICAgIDQ2MjI0NSAgICAgIHwgICAgICA0NjAzNjEgICAgIHwgMTowLjk5NTkgfAp8ICM0IHwgICAg
ICA0NjM1MjIgICAgICB8ICAgICAgNDYxNzgzICAgICB8IDE6MC45OTYyIHwKfCAjNSB8ICAgICAg
NDU5NzYwICAgICAgfCAgICAgIDQ1ODAwNSAgICAgfCAxOjAuOTk2MiB8CnwgIzYgfCAgICAgIDQ1
Nzg2MyAgICAgIHwgICAgICA0NTYwMjQgICAgIHwgMTowLjk5NjAgfAorLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSsKCiBUaGUgZGlmZmVyZW50IG1l
YW4gdmFsdWUgaXMgYXBwYXJlbnQsIGJ1dCBubyB3aWRlciBkZXZpYXRpb24gb2JzZXJ2ZWQsIG1h
eWJlIHRoZSBsYXJnZXIgc3RhbmRhcmQgZGV2aWF0aW9uIG9ic2VydmVkIGluIG15IGxhc3QgbWFp
bCBpcyBjYXVzZWQgYnkgb3RoZXIgZmFjdG9ycyBkdXJpbmcgZmlvIHNlc3Npb24uIAoKClRoYW5r
cwpEYXZpZCBXYW5nCgoKCg==
