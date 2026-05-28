Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CC23394D
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006048; cv=pass; b=tnqGLwqfPK3bY0MyrSqkwwclIxrORojShl79OAxpX7wv1z9MqWueitV6wxTvOd8GOz1oRXbf8+0M7gZ4bO8QBJR1LnhrSjey8QdjtJ+k+y4820foHTzI/lU4inAfTFngBve3/UG2tjk92ZUWJS3c4NMdAj8Z3Wpbzb+6qRJlknc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006048; c=relaxed/simple;
	bh=R3GG45xfauTW6UIOchS4UYcv0mzR2Hvp6nI5vJShEhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HubF+vPzHe8uh9d5RvlIvg1VPodS7GHSXNk2yx3gXes/WYAFVpXakmjA8rv41WrFu6dS7BLsGB3V402xugAvHX/+ytUkeeBXc3utLFGUrLcXtOACDbVpILnUsFaERVbE8ZXxepItKe5Er4bm4eKYvRB4Ntt1A1zz1ujgIGJHxZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUasNhin; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUasNhin"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b46da8c48eso155ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 15:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780006046; cv=none;
        d=google.com; s=arc-20240605;
        b=WVdct2LiHaXV/w1Y3J+zoR6Tc/DotLDEaiW13EXYwWYapZDmJAQKlloCTwFS9yZF6u
         5Ci1KYQIskDEM+/zsMg6T+wSQZHFZUNaiBllK7XTSGIX3yWyzg6Y7+u2jrjZb8Yro0Wx
         LfAWeDdS4tHEn5NtgVRmA7vsUvZaI65w8tdF3HkVNrTUtizrXyKczyXc8m99FBYfVaVW
         Up+l8odiLuzGRDD6PMSByzWEWPnrq5a9gCBftPDX/0kn5OQswsm8gwEUOO6xWHG4ozrR
         LRgCw72+ug1P1glqe/ym0SYXZ3Yk/rCKefLzkgOjE1n4wtsSpXnHVNdeP2H6leLmwyeU
         lwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R3GG45xfauTW6UIOchS4UYcv0mzR2Hvp6nI5vJShEhM=;
        fh=a7+aXdUBW8/syyUecSS+TVp5poA2+0yiVHIz6DIUCOE=;
        b=KVSK8a2s8uac49BInjF111tuqOXsyxrJDrbAq0sS2S2QzMEeeE2XhHp1r9CGWM9mq9
         /YNgaTtadcENSW+UXMy4vsmLkmwSEoeSiCrlZjp2Mcz+iSut9GrC9AXH1dnDnBFCTz2/
         utuFCXsGQdrTUgU6cdTevD5nLCOw2VjsInBdkwin7VSX6xkm9UQsv24rgunO2O9PKuih
         eOaO86g32VT954PMhpsY4FevJA3nEjxFYBt0uzM0u8cmU01aseTQMA/VpgDHC9DXvA81
         KQDSWQ0ZnmmbkccUX6Crpzagd/Na45YC2435oz74losHHu5qdmfFhNRJN7VeUkhk/4IG
         DS5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780006046; x=1780610846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3GG45xfauTW6UIOchS4UYcv0mzR2Hvp6nI5vJShEhM=;
        b=qUasNhinKji8KYG8OOviQMaA1Gh8I+kCc4CNoj6hmK/3ZUnCapQYfEiA+j5XGZrXz2
         n2JQ7y0kTfmhL0IFDyacANEdBHZmQCq7EBfEy5uF/eSHPC1A7d4Mt8Xaih4F8UIBTlVi
         gHlyHquXzrL2nHSMEVjWp5fnPz1BEZ7zoSqHBFdtJEeXy3yibdcxwIQdsFpxAhCdJwbe
         RxRztyFYq3VS3rdvQastdwqUBsIpvxQAxDt/8d75jL329SI4eWgDkQVk4IT4qsihOu5z
         V/NtlNIfWy7mMT+22AzxKrK5On8EJn8vPz1SAAmWQNWOPcWKIpSokkpOKuS/eYsPWR/q
         fZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780006046; x=1780610846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R3GG45xfauTW6UIOchS4UYcv0mzR2Hvp6nI5vJShEhM=;
        b=Hg209jbBwWHiVIttSx1FsgF6v4Hq7pFPIhQZ+5GxpuYNtn9LP2xTBFqTGkFNhJAAi7
         XXGBidRG4vCUGzIBN5Miw2vxQGHrbsmlWaLvorxadiRXSmqPGc1g1f0HHrD/564Mny6G
         Xo78BKQG0gUZkzqQAuxpvliHve2YyguaQVbnl7D1cbKewaVNTxWvvEn1r4w8wdsuQDJf
         46CtvDbSnrtJV20udkQtis9Kv+ISNN2BUTKP5hyUlu0QA9qARbOdisYV7lxJdb+lMoUM
         tHJELZxYvUdohNMolEbJukh9A/1hiiTCBGGGxjDjxy87i4twI93uUSNw9G6H3Qt7Oio1
         7wOg==
X-Forwarded-Encrypted: i=1; AFNElJ8N5W3fmNpaHsxnNHG64gC9lLzi84DBXx46BAv3jHmwN6T3AvKhG3sgXptboTcO48MMWuwx5UlMOwl1mT3dpHKL@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsiCUoVQwVCErIFBP970XdlYqK2h2mf78mMe4Z2aL3VlxUBRd
	ox3VYV4oD+HrOZKY2BYcsLDEA1QBB4AQbg6n8XiunRjNO/h08NT4MOWqXa6vHO5G+uQ8P/wb6pQ
	oVNUuXBi8GeYUP8uQArMItzAlZl4BJN9NsTBQkquo
X-Gm-Gg: Acq92OHsdjDrBgps8RoDY+9zrj+H6fPv86W9XIPeHpx8zv9C3iIoftFYgJn//PXBIJ/
	kz4N3cy47C65k72ggVqAsSNvBam5k/zTQKDA4jDik8HEAVM2fAbCPkgsN6/TMQrNztq74zo8xA4
	jc9atOn6LPW6NANzU98IK/K6hL5cFbgauDrv+h7nv7xInlpfs45lBQtRzLdAbC3R0WL6QY01iGS
	O6B8L8b8kepldhQJLg3VMUPAeyVgQGPhUvO52a2ZpFfHKj3eutDifb6Tqbud1ykW3npfTnfhHov
	S+oSBpXzZkW+T7QPRlQ=
X-Received: by 2002:a17:903:1a0d:b0:2b4:58ad:e987 with SMTP id
 d9443c01a7336-2bf20d9b5eemr235555ad.17.1780006045562; Thu, 28 May 2026
 15:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526211806.1193848-1-acme@kernel.org> <ahZDggzXoHvbnhog@x1>
In-Reply-To: <ahZDggzXoHvbnhog@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 May 2026 15:07:13 -0700
X-Gm-Features: AVHnY4LIg_FG4DK4fTjELMaHJTkCUXKNnczJ2vtI3dLZyvafGau4lMGcD4BI8d0
Message-ID: <CAP-5=fU=rrU3qP6Uzvhs90DRMtDNGzXk-dkYqvpX8J_sPRc1-g@mail.gmail.com>
Subject: Re: [PATCHES v4 00/29] perf: Harden perf.data parsing against
 crafted/corrupted files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBNYXkgMjYsIDIwMjYgYXQgNjowNuKAr1BNIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVs
bw0KPGFjbWVAa2VybmVsLm9yZz4gd3JvdGU6DQo+DQo+IE9uIFR1ZSwgTWF5IDI2LCAyMDI2IGF0
IDA2OjE3OjM2UE0gLTAzMDAsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyB3cm90ZToNCj4gPiBw
ZXJmLmRhdGEgdmFsaWRhdGlvbiBhbmQgaGFyZGVuaW5nICgyOSBwYXRjaGVzKQ0KPiA+DQo+ID4g
QSBjcmFmdGVkIG9yIGNvcnJ1cHRlZCBwZXJmLmRhdGEgZmlsZSBjYW4gY2F1c2Ugb3V0LW9mLWJv
dW5kcw0KPiA+IHJlYWRzL3dyaXRlcywgaW5maW5pdGUgbG9vcHMsIGhlYXAgb3ZlcmZsb3dzLCBh
bmQgc2VnZmF1bHRzIGluIHBlcmYNCj4gPiByZXBvcnQsIHBlcmYgc2NyaXB0LCBwZXJmIGluamVj
dCwgcGVyZiB0aW1lY2hhcnQsIGFuZCBwZXJmIGt3b3JrLg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMg
ZGVmZW5zZS1pbi1kZXB0aCB2YWxpZGF0aW9uIGZvciBmaWxlIHBhcnNpbmc6DQo+DQo+IFRoZSBh
bmFseXNpcyBhYm91dCBTYXNoaWtvJ3MgcmVtYWluaW5nIGNvbW1lbnRzIGlzIGJlbG93LCB1bmxl
c3Mgc29tZW9uZQ0KPiBoYXMgc29tZXRoaW5nIG5vdCByZWxhdGVkIGJ5IFNhc2hpa28sIEknbGwg
bWVyZ2UgdGhpcyB0b21vcnJvdyBhbmQNCj4gY29udGludWUgcHJvY2Vzc2luZyB0aGUgb3RoZXIg
b3V0c3RhbmRpbmcgcGF0Y2hlcy4NCj4NCj4g4pePIEhlcmUncyB0aGUgdjQgc2FzaGlrby5kZXYg
cmV2aWV3IHRyaWFnZSDigJQgMTMgb2YgMjkgcGF0Y2hlcyBnb3QgcmV2aWV3czoNCj4NCj4gICBQ
YXRjaGVzIHdpdGggZmluZGluZ3M6DQo+DQo+ICAgUGF0Y2g6IDAyIChwZWVrX2V2ZW50IGJvdW5k
cykNCj4gICBGaW5kaW5nczogMSBIaWdoOiBtbWFwX3NpemUgLSBwYWdlX29mZnNldCB1bmRlcmZs
b3cNCj4gICBWZXJkaWN0OiBQcmUtZXhpc3Rpbmcg4oCUIHJlYWRlcl9faW5pdCgpIHZhbGlkYXRl
cyBkYXRhX3NpemUsIHBhZ2Vfb2Zmc2V0IGNhbid0IGV4Y2VlZCBtbWFwX3NpemUNCj4gICDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIANCj4gICBQYXRjaDogMDQgKHpzdGQgY29tcHJlc3MpDQo+ICAgRmluZGluZ3M6IDEgQ3JpdGlj
YWwgKyAzIEhpZ2g6IG11bHRpLXJlY29yZCBoZWFkZXIgb3ZlcmZsb3csIEFJTyBkYXRhX3NpemUs
IGZsdXNoIHJldHVybiwgZGVjb21wcmVzcyBwb3MNCj4gICBWZXJkaWN0OiBBbGwgcHJlLWV4aXN0
aW5nIOKAlCB0aGUgQ3JpdGljYWwgaXMgYWJvdXQgcHJvY2Vzc19oZWFkZXIoKSBhZ2dyZWdhdGUg
c2l6ZSwgYW5kIHRoZSBkZWNvbXByZXNzIGlzc3VlIGlzIGZpeGVkIGxhdGVyIGluIHBhdGNoIDA1
DQo+ICAg4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSADQo+ICAgUGF0Y2g6IDA1ICh6c3RkIGRlY29tcHJlc3MpDQo+ICAgRmluZGlu
Z3M6IDEgSGlnaDogT19OT05CTE9DSyBtaXNzaW5nIG9uIGZpbGUgb3BlbnMNCj4gICBWZXJkaWN0
OiBQcmUtZXhpc3Rpbmcg4oCUIG5vdCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIHVucmVsYXRl
ZCB0byB6c3RkDQo+DQo+IFRoaXMgb25lIElJUkMgSWFuIHNlbnQgYSBwYXRjaCBmb3IgcmV2aWV3
LXByb21wdHMsIG1lcmdlZCByZWNlbnRseSB0aGF0DQo+IHdpbGwgbWFrZSBpdHMgd2F5IHRvIFNh
c2hpa28gYW5kIHdpbGwgc3RvcCBiZWluZyBmbGFnZ2VkIGFzIGEgcHJvYmxlbToNCj4NCj4gICAi
a2VybmVsL3N1YnN5c3RlbS9wZXJmLm1kOiBSZW1vdmUgc2VjdGlvbiBkZXNjcmliaW5nIG5vbi1i
bG9ja2luZyBJTyINCj4gICBodHRwczovL2dpdGh1Yi5jb20vbWFzb25jbC9yZXZpZXctcHJvbXB0
cy9jb21taXQvMjYxZDczMjYxZGJiMTFmMzhmZjljNjUzZGEzNjA4YjE2Mjc0MWUwMw0KPg0KPiAg
IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgA0KPiAgIFBhdGNoOiAwOCAoc3dhcCBpbmZyYSkNCj4gICBGaW5kaW5nczogMiBIaWdo
OiBtbWFwMiBwcm90L2ZsYWdzIG5vdCBzd2FwcGVkLCBldmVudF91cGRhdGUgdW5pb24gbm90IHN3
YXBwZWQNCj4gICBWZXJkaWN0OiBCb3RoIHByZS1leGlzdGluZyDigJQgY29ycmVjdCBvYnNlcnZh
dGlvbnMgZm9yIGZvbGxvdy11cCBzZXJpZXMNCj4gICDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIANCj4gICBQYXRjaDogMTAgKEhF
QURFUl9BVFRSKQ0KPiAgIEZpbmRpbmdzOiBzYW1lIGFzIHYzIOKAlCBhbHJlYWR5IHRyaWFnZWQN
Cj4gICBWZXJkaWN0Og0KPiAgIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KPiAgIFBhdGNoOiAxMSAobnIgdmFsaWRhdGlvbikN
Cj4gICBGaW5kaW5nczogMSBNZWRpdW06IG5hdGl2ZSBwYXRoIGFib3J0cyB2cyBzd2FwIHBhdGgg
c2tpcHMgb24gYmFkIFRIUkVBRF9NQVANCj4gICBWZXJkaWN0OiBWYWxpZCBvYnNlcnZhdGlvbiDi
gJQgYnV0IGludGVudGlvbmFsOiBuYXRpdmUgcGF0aCByZXR1cm5zIC1FSU5WQUwgdG8gY2F0Y2gg
Y29ycnVwdGlvbiwgc3dhcCBwYXRoIHNraXBzIHRvIGtlZXAgc2Vzc2lvbiBhbGl2ZS4NCj4gICDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIANCj4gICBQYXRjaDogMTIgKGJ1aWxkX2lkX3N3YXApDQo+ICAgRmluZGluZ3M6IHNhbWUg
YXMgdjMg4oCUIGFscmVhZHkgZml4ZWQgaW4gdjQNCj4gICBWZXJkaWN0Og0KPiAgIOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0K
PiAgIFBhdGNoOiAxNSAoQlBGX01FVEFEQVRBKQ0KPiAgIEZpbmRpbmdzOiAxIEhpZ2ggbmV3OiBk
b3VibGUtZmV0Y2ggb2YgaGVhZGVyLnNpemUgaW4gc3dhcCBwYXRoOyAyIEhpZ2ggcHJlLWV4aXN0
aW5nOiBUT0NUT1Ugb24gbmF0aXZlIHBhdGgNCj4gICBWZXJkaWN0OiBUaGUgZG91YmxlLWZldGNo
IGlzIHZhbGlkIGZvciBzd2FwIGJ1dCBzd2FwIHJ1bnMgb24gTUFQX1BSSVZBVEUgKHdyaXRhYmxl
IGNvcHkpLCBzbyBubyBjb25jdXJyZW50IG1vZGlmaWNhdGlvbiBwb3NzaWJsZS4NCj4gICDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIANCj4gICBQYXRjaDogMjQgKGNvbXByZXNzZWQgaGFyZGVuaW5nKQ0KPiAgIEZpbmRpbmdzOiAx
IE1lZGl1bTogZG91YmxlLWZldGNoIG9mIGV2ZW50LT5oZWFkZXIuc2l6ZSBpbiB0b29sLmMNCj4g
ICBWZXJkaWN0OiBTYW1lIFRPQ1RPVSBwYXR0ZXJuDQo+ICAg4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSADQo+ICAgUGF0Y2g6IDI2
IChDUFUgYm91bmRzKQ0KPiAgIEZpbmRpbmdzOiAxIEhpZ2g6IGdsb2JhbCBjbGFtcCBjb3JydXB0
cyBkYXRhIGZvciA+NDA5NiBDUFVzDQo+ICAgVmVyZGljdDogS25vd24gbGltaXRhdGlvbiDigJQg
bWVtb3J5IFtbTUFYX05SX0NQVVMgZHluYW1pYyBhbGxvY2F0aW9uXV0gVE9ETw0KPiAgIOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gA0KPiAgIFBhdGNoOiAyOCAoUkVBRF9PTkNFIHNuYXBzaG90KQ0KPiAgIEZpbmRpbmdzOiA0IEhp
Z2g6IGluY29tcGxldGUgVE9DVE9VIGZpeCwgdHlwZSBjb25mdXNpb24sIGFycmF5IGNvdW50IHJl
LXJlYWRzDQo+ICAgVmVyZGljdDogQWxsIHByZS1leGlzdGluZyBNQVBfU0hBUkVEIFRPQ1RPVS4g
VGhlIGZ1bGwgZml4IHdvdWxkIGJlIE1BUF9QUklWQVRFLCBub3RlZCBhcyBmb2xsb3ctdXANCj4g
ICDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIANCj4gICBQYXRjaDogMjkgKHNoZWxsIHRlc3QpDQo+DQo+ICAgRml4ZWQgYW5kIHNl
bnQgdGhlIGRpZmYgaW4gcmVzcG9uc2UgdG8gU2FzaGlrbydzIHJldmlldyBlLW1haWwuDQo+DQo+
ICAgU3VtbWFyeTogMSBuZXcgYWN0aW9uYWJsZSBpc3N1ZSBpbiB2NC4gQWxsIHRoZSBvdGhlciBm
aW5kaW5ncyBhcmUNCj4gICBlaXRoZXIgcHJlLWV4aXN0aW5nIChkb2N1bWVudGVkIGluIHRoZSBj
b3ZlciBsZXR0ZXIpLCBhbHJlYWR5IGZpeGVkIGluDQo+ICAgdGhpcyB2ZXJzaW9uLCBvciBpbnRl
bnRpb25hbCBkZXNpZ24gZGVjaXNpb25zLiBUaGUgbW1hcDIgcHJvdC9mbGFncw0KPiAgIGFuZCBl
dmVudF91cGRhdGUgdW5pb24gc3dhcCBnYXBzIChwYXRjaCAwOCkgYXJlIHZhbGlkIHByZS1leGlz
dGluZw0KPiAgIGJ1Z3MgZm9yIGEgZm9sbG93LXVwIHNlcmllcy4NCj4NCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KDQpJJ20gbW9yZSB0aGFuIGhhcHB5IHdpdGggdGhpcyBtZXJnZSwgZ29vZCBub3QgYmVp
bmcgdGhlIGVuZW15IG9mDQpwZXJmZWN0IGFuZCB0aGluZ3MgbGlrZSB0aGF0Lg0KDQpSZXZpZXdl
ZC1ieTogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KDQpUaGFua3MsDQpJYW4NCg==
