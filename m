Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8802940B;
	Tue,  3 Jun 2025 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929538; cv=none; b=n0O309DqPi7XCzSCubVJ2t2ippOKpUnF3vlkFPNgymKlYLU8AK4PBhBlAhWToa0lhKd6+DWDBaFDYGPV3UIp7UekCGi2MyLYEJFr5mUDFvQ9P6COLzJrDfTfsFO55vbQoW+GZ3sAihWrctGsP/GtYlzib7yZU9trEFpmWSf0DDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929538; c=relaxed/simple;
	bh=CYCGRuhTa4KtUmbE3vts5S7yHCuIAzDmAh5o9A12UcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hBTii6Ov8kgL7UbxhRd6UqW698ck/qKOWKroalbIIGlk1CBc5QjB6xt86+UzAm1iXOJxpNso+vsvwQ6seutRJPu78c5YxqRBGp9TWa7i5DVB1dNPeI1P9dS9Z7rN8ac8wBWWu1XWTrTW1IsnrfPVx+DwfKQryEvEyATSoR2S2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=g5WSTILh reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="g5WSTILh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hZ4OI3h5BZOm9FiTMfdV+zwC2HXeHr1OnNLrmtNoTUA=; b=g
	5WSTILhNW95yNBr08TjNEaYIMpd9igvvL2xhtVRsqBSge8I19eRpXu0vVlbCLFEU
	Ks7btgWV7N4+0sxRRPDygeeUWgF+nJpqBuVVXiga+It6SG/2fg4X0zxmfFR4yE32
	OzxQZqG9gCpjp8BbThOoE7tyKl5FYN8zNxf5zhYuPU=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Tue, 3 Jun 2025 13:44:47 +0800 (CST)
Date: Tue, 3 Jun 2025 13:44:47 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aD5+C41dsjvu9ZNP@e129823.arm.com>
References: <aD5+C41dsjvu9ZNP@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvWZtkwj4SacbOkZnEYQheY4XMKyuPkg1YJXOp80iCXQ3wodeXBxJkTkwcOOJiWSvxe8aSZS7+RTe4BFYbAa3IrUHJfyeLXrOMPPSboW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <19514ed5.5692.19734522326.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgDXX9DQiz5oJ5gSAA--.25089W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkAhhqmg+fYgVoAAHsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDMgMTI6NDY6MDMsICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+SGkgRGF2aWEsCj4KPj4gSSB0aGluayB0aGlzIHBhdGNoIGlzIG5vIGJldHRl
ciB0aGFuIG15IHBhdGNoIGluIHRoZSBvcmlnaW5hbCByZXBvcnQKPj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjUwNjAxMTczNjAzLjM5MjAtMS0wMDEwNzA4MkAxNjMuY29tLwo+Pgo+
PiBUaGlzIHBhdGNoIGlzIG1vcmUgYWdncmVzc2l2ZSwgIGl0IGFkZCBtb3JlIGNoYW5nZXMgdG8g
b3JpZ2luYWwgbG9naWMsIHNhbWUgcHJhY3RpY2UKPj4gYXMgaW4gdGhlIG9mZmVuZGluZyBjb21t
aXQuICB3b3VsZCByYWlzZSBtb3JlIGNvbmNlcm5zIGFib3V0IGhpZGRlbiBzaWRlLWVmZmVjdC4K
Pj4KPj4gRm9yIGV4YW1wbGUsIHRoaXMgY29kZSAgaW4gbGlzdF9kZWxfZXZlbnQgc2hvdWxkIHJh
aXNlIGNvbmNlcm4gYWJvdXQgdGhpcyBwYXRjaAo+PiAyMDk5ICAgICAgICAgICogV2UgY2FuIGhh
dmUgZG91YmxlIGRldGFjaCBkdWUgdG8gZXhpdC9ob3QtdW5wbHVnICsgY2xvc2UuCj4+ICAyMTAw
ICAgICAgICAgICovCj4+ICAyMTAxICAgICAgICAgaWYgKCEoZXZlbnQtPmF0dGFjaF9zdGF0ZSAm
IFBFUkZfQVRUQUNIX0NPTlRFWFQpKQo+PiAgMjEwMiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+
Cj5hdHRhY2hfc3RhdGUgZG9lc24ndCByZWxhdGVkIGZvciBldmVudC0+c3RhdGUgY2hhbmdlLgo+
aWYgb25lIGV2ZW50IGFscmVhZHkgY2xlYXJlZCBQRVJGX0FUVEFDSF9DT05URVhULCB0aGF0IGV2
ZW50IGlzIGNhbGxlZAo+dmlhIGxpc3RfZGVsX2V2ZW50KCkKCk1heWJlIHRoaXMgY29uY2VybiBj
b3VsZCBiZSBjbGFyaWZpZWQsIHdoYXQgYWJvdXQgb3RoZXIgc3VidGxlIGltcGFjdHMuClRoZSBj
aGFuZ2Ugc2hvdWxkIGJlIHRob3JvdWdoIHJldmlld2VkLCBpZiB5b3Ugd2FudCB0byBwdXNoIGl0
IGZ1cnRoZXIuCgpJdCB0YWtlcyBtZSBtb3JlIHRoYW4gYSBtb250aCB0byBmaWd1cmUgb3V0IGEg
cHJvY2VkdXJlIHRvIHJlcHJvZHVjZSB0aGUga2VybmVsIHBhbmljIGJ1ZywKSXQgaXMgIGp1c3Qg
dmVyeSBoYXJkIHRvIGNhcHR1cmUgYSBidWcgaGFwcGVucyBpbiByYXJlIHNpdHVhdGlvbi4KCkFu
ZCB5b3VyIHBhdGNoIGhhcyBhIGdsb2JhbCBpbXBhY3QsIGl0IGNoYW5nZXMgYmVoYXZpb3IgdW5u
ZWNlc3NhcmlseS4KCj4KPkFsc28sIHlvdXIgcGF0Y2ggY291bGRuJ3Qgc29sdmUgYSBwcm9ibGVt
IGRlc2NyaWJlIGluCj5jb21taXQgYTNjM2M2NjY3KCJwZXJmL2NvcmU6IEZpeCBjaGlsZF90b3Rh
bF90aW1lX2VuYWJsZWQgYWNjb3VudGluZyBidWcgYXQgdGFzayBleGl0IikKPmZvciBJTkNBVElW
RSBldmVudCdzIHRvdGFsX2VuYWJsZV90aW1lLgoKSSBkbyBub3QgdGhpbmsgc28uCkNvcnJlY3Qg
bWUgaWYgSSBhbSBtYWtpbmcgc2lsbHkgIG1pc3Rha2VzLApUaGUgcGF0Y2gsIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyNTA2MDMwMzI2NTEuMzk4OC0xLTAwMTA3MDgyQDE2My5jb20v
CmNhbGxzIHBlcmZfZXZlbnRfc2V0X3N0YXRlKCkgYmFzZWQgb24gREVUQUNIX0VYSVQgZmxhZywg
d2hpY2ggY292ZXIgdGhlIElOQUNUSVZFIHN0YXRlLCByaWdodD8KSWYgREVUQUNIX0VYSVQgaXMg
bm90IHVzZWQgZm9yIHRoaXMgcHVycG9zZT8gVGhlbiB3aHkgc2hvdWxkIGl0IGV4aXN0IGF0IHRo
ZSBmaXJzdCBwbGFjZT8KSSB0aGluayBJIGRvZXMgbm90IHJldmVydCB0aGUgcHVycG9zZSBvZiBj
b21taXQgYTNjM2M2NjY3Li4uLi5CdXQgSSBjb3VsZCBiZSB3cm9uZwpXb3VsZCB5b3Ugc2hvdyBh
IGNhbGwgcGF0aCB3aGVyZSBERVRBQ0hfRVhJVCBpcyBub3Qgc2V0LCBidXQgdGhlIGNoYW5nZXMg
aW4gY29tbWl0IGEzYzNjNjY2NyBpcyBzdGlsbCBuZWVkZWQ/CgoKRGF2aWQKCgo+Cj5UaGFua3Mu
Cj4KPi0tCj5TaW5jZXJlbHksCj5ZZW9yZXVtIFl1bgo=
