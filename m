Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48664A1E;
	Mon,  2 Jun 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878403; cv=none; b=EEwTBDiZFGs00T+LNLeHBUFFCYtRyy5XX0P3ldA6voDA9dT5QOfAcT0+eweOO6jOXASNU5Cbm8A7QMj6A6ZPvQCb9eEAo9bhxabMN/LN0y41tpImOmVWsp7QfoNpRbEBrxZ6FRDskJSP0plmw1GqEMAfVr1REZxHsAxNavk9C/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878403; c=relaxed/simple;
	bh=re4PGiECHNFx9WXp4WOS/YuuBDf5tAzxxZHGBPAurCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JVRC/i1XbePwVyoYijjL44YIcX1QO3UuBJt6o2f8YdeJqcUOzhw0auWb+t4wVe13dg4GeF2MBzwU5QXi/LI/APIqVWwYFZPF66EiwmNbzrkawu6dtMPLXtx5rmqNm9od2WRz7uQqbuRWTQGH6srf8VekFxWwbFLD9kgExUA6yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=hgSdaRNf reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="hgSdaRNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=oCeTEqONNQP62D+997YrgUyRDKBWkf3brV1BiFNF0RM=; b=h
	gSdaRNfR7GSuzbQUb2TQHDAQy0jnnqUYgssYsOQWmt+IVrQOxBR3PWLpQzvILHGX
	wipQCsI0+vZDahfhE/ufj1DV/u65GEcfHHwCFffhm1v61PZDRnRASy+o6++TYPt4
	JNlQgpd/JDhnqu+eMCcrzwOQC2dMKuPuRxvDgxfVrE=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Mon, 2 Jun 2025 23:32:51 +0800 (CST)
Date: Mon, 2 Jun 2025 23:32:51 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mingo@kernel.org, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG][6.15][perf] Kernel panic not syncing: Fatal exception in
 interrupt
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aD2/hoB+KhLITSu3@e129823.arm.com>
References: <aD2TspKH/7yvfYoO@e129823.arm.com>
 <aD2kz52p5NHpuXk3@e129823.arm.com> <aD2/hoB+KhLITSu3@e129823.arm.com>
X-NTES-SC: AL_Qu2fCvSct0ss5yaRZukXn0oTju85XMCzuv8j3YJeN500iCXpxj8deXBJB3bmwcO1DSGtvxe+WQdfzMBlfLtgcYs26ctt3AgL4okYbvsMTE/U
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <72c1852.372d.19731462b73.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgDXv9okxD1oJRoSAA--.22340W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkBRgqmg9v1wKGAACso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMDIgMjM6MTM6MTAsICJZZW9yZXVtIFl1biIgPHllb3JldW0ueXVuQGFybS5j
b20+IHdyb3RlOgo+SGkgRGF2aWQsCj4KPj4gPiA+IEJlZm9yZSBJIHN0YXJ0IHRlc3RpbmcsIEkg
ZmVlbCBjb25jZXJuZWQgYWJvdXQgZm9sbG93aW5nIGNoYWluOgo+PiA+ID4KPj4gPiA+IC4va2Vy
bmVsL2ZvcmsuYzoKPj4gPiA+IGJhZF9mb3JrX2NsZWFudXBfcGVyZjoKPj4gPiA+ICAgICBwZXJm
X2V2ZW50X2ZyZWVfdGFzaygpCj4+ID4gPiAgICAgICAgIHBlcmZfZnJlZV9ldmVudCgpCj4+ID4g
PiAgICAgICAgICAgICBsaXN0X2RlbF9ldmVudCgpCj4+ID4gPgo+PiA+ID4gVGhpcyBwYXRjaCBz
ZWVtcyBjaGFuZ2VzIHRoZSBiZWhhdmlvciBpbiB0aGlzIGNhbGxjaGFpbi4KPj4gPiA+IFdvdWxk
IHRoaXMgaGF2ZSBvdGhlciBzaWRlLWVmZmVjdD8KPj4gPgo+PiA+IFdoYXQgYmVoYXZpb3IgaXMg
Y2hhbmdlZCB5b3UncmUgd29ycnkgYWJvdXQ/Cj4+ID4gYm90aCBlcnJvciBwYXRjaCBpcyBoYW5k
bGVkIGJ5IF9fcGVyZl9yZW1vdmVfZnJvbV9jb250ZXh0KCksCj4+ID4gVGhlcmUgd291bGRuJ3Qg
YmUgbm8gcHJvYmxlbSBzaW5jZSB0aGlzIHBhdGNoIGp1c3QgbW92ZSB0aGUKPj4gPiB0aW1lIG9m
IGRpc2FibGluZyBjZ3JvdXAgYmVmb3JlIGNoYW5naW5nIGV2ZW50IHN0YXRlLgo+PiA+Cj4+ID4g
YWxzbywgdGhlIGNncm91cCBldmVudCBpcyBmb3Igb25seSBjcHVjdHggbm90IGFkZGVkIGluIHRh
c2tjdHguCj4+ID4gU28sIHRoZXJlJ3Mgbm8gZWZmZWN0IGZvciBldmVudCBhdHRhY2hlZCBpbiB0
YXNrY3R4Lgo+PiA+Cj4+ID4gVGhhbmtzLgo+Pgo+PiBBbSBJIHJlYWRpbmcgaXQgd3Jvbmc/Cj4+
IFRoZSBjYWxsIGNoYWluIEkgbWVudGlvbmVkIGFib3ZlIGRvc2Ugbm90IHdhbGsgdGhyb3VnaCBf
X3BlcmZfcmVtb3ZlX2Zyb21fY29udGV4dCwKPj4gSXQgaXMgYSBmYWlsIHBhdGggaW4gZm9yaywg
d2hpY2ggaGFwcGVucyByYXJlbHksIGJ1dCBzdGlsbCBwb3NzaWJsZS4gSSBndWVzcy4uLgo+Cj5T
aW5jZSBjb21taXQgOTA2NjEzNjUwMjFhCj4oInBlcmYgVW5pZnkgcGVyZl9ldmVudF9mcmVlX3Rh
c2soKSAvIHBlcmZfZXZlbmV0X2V4aXRfdGFza19jb250ZXh0KCkiKQo+Cj5wZXJmX2V2ZW50X2Zy
ZWVfdGFzaygpIGlzIGludGVncmF0ZWQgd2l0aCBwZXJmX2V2ZW50X2V4aXRfdGFza19jb250ZXh0
KCkKPlNvLCBpdCBjYWxscyBfX3BlcmZfcmVtb3ZlX2Zyb21fY29udGV4dCgpLgoKCkdvb2QgdG8g
a25vd34KCj4KPkluIHY2LjE1LCBJIHRoaW5rIHlvdSBjYW4gdGVzdCB3aXRoIGJlbG93IGNoYW5n
ZSBvbmx5Ogo+QEAgLTI0NzEsNiArMjQ1OSwxNiBAQCBfX3BlcmZfcmVtb3ZlX2Zyb21fY29udGV4
dChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsCj4KPiAgICAgICAgY3R4X3RpbWVfdXBkYXRlKGNw
dWN0eCwgY3R4KTsKPgo+KyAgICAgICAvKgo+KyAgICAgICAgKiBJZiBldmVudCB3YXMgaW4gZXJy
b3Igc3RhdGUsIHRoZW4ga2VlcCBpdAo+KyAgICAgICAgKiB0aGF0IHdheSwgb3RoZXJ3aXNlIGJv
Z3VzIGNvdW50cyB3aWxsIGJlCj4rICAgICAgICAqIHJldHVybmVkIG9uIHJlYWQoKS4gVGhlIG9u
bHkgd2F5IHRvIGdldCBvdXQKPisgICAgICAgICogb2YgZXJyb3Igc3RhdGUgaXMgYnkgZXhwbGlj
aXQgcmUtZW5hYmxpbmcKPisgICAgICAgICogb2YgdGhlIGV2ZW50Cj4rICAgICAgICAqLwo+KyAg
ICAgICBpZiAoZXZlbnQtPnN0YXRlID4gUEVSRl9FVkVOVF9TVEFURV9PRkYpCj4rICAgICAgICAg
ICAgICAgcGVyZl9jZ3JvdXBfZXZlbnRfZGlzYWJsZShldmVudCwgY3R4KTsKPisKPiAgICAgICAg
LyoKPiAgICAgICAgICogRW5zdXJlIGV2ZW50X3NjaGVkX291dCgpIHN3aXRjaGVzIHRvIE9GRiwg
YXQgdGhlIHZlcnkgbGVhc3QKPiAgICAgICAgICogdGhpcyBhdm9pZHMgcmFpc2luZyBwZXJmX3Bl
bmRpbmdfdGFzaygpIGF0IHRoaXMgdGltZS4KPgo+bm90IHdpdGggbW9kaWZpY2F0aW9uIHdpdGgg
Imxpc3RfZGVsX2V2ZW50KCkiLgoKLi4uIEkgYXBwbHkgeW91ciBvcmlnaW5hbCBwYXRjaCBvbiA2
LjE1LCB1cCB0byBub3csIDcgcm91bmRzIG9mIHRlc3Qgc2hvdyBubyBzaWduIG9mIGtlcm5lbCBw
YW5pYy4KSSB0aGluaywgdGhlIHBhdGNoIGRvZXMgZml4IGl0LgoKVGVzdGVkLWJ5OiBEYXZpZCBX
YW5nIDwwMDEwNzA4MkAxNjMuY29tPgoKClRoYW5rcwpEYXZpZAoK
