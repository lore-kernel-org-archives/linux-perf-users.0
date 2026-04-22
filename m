Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B836B071
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841885; cv=none; b=C+CpswAw98ZLf6cNvS2vRIW9MqqE+XBC01Yk31ailKn6TK3wh/MiYD8P0bWFoyEEsyn120Wiq5902K5Z+15JDirnDZwSXQ9ucPSxc4LIYMPhD1I76YPwru/ttUUHPzKfIT1Q1aCZUNb3E7avpCbe8OIjsqz5F446dadAJZypp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841885; c=relaxed/simple;
	bh=D9mzBLLfRDXSM+6lC2N843ikZ9n5C+QkmsowzXTZFXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSr2NwtMwIIlxHj6Ay08yWBE6rWeAvl2QAEW1EHT6paLYKjHuV8qjTi3mZB8UqPv82SfDW96U2B1343l2nliC4Qq+W3l2FJ/WhZvqhmJSLURLUpV6Nwyc177tZTlFid8e3rxvDKilbOkFgREr2kNk36v6G/N/9rn9jvCBMZ8qVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bU7IWsOE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bU7IWsOE"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b886fc047d5so922593466b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776841883; x=1777446683; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D9mzBLLfRDXSM+6lC2N843ikZ9n5C+QkmsowzXTZFXM=;
        b=bU7IWsOEw0cmADJSMtlM4sVRDiOdcKREvfdZbsnixSxqQwH0RH9ZdpF0zw+nRozavD
         RH18UWnpbHEplmpWPIWfwz0CPr1LQ4jMw9ELvMzlU0X+OYwrmYR3zcmhG0RwFRzaTKuF
         XJdEoFiDvS9z9R7Mn46AIcVZIYBVgtc+fDBLN0j7w7fyepRVBInK/3x73pGodcJSHals
         aGOHNxwzjqKDfLA96z1hweJfBgCA0hg32t/MXrzFwr9WKvhcQFedQOM/gMNoFi+T7ILy
         TGzjQuLeeNRK6FPkQ4PSviMmUBiA/ek7qg0J6lIsEx9TG21O62R98SrradB9XxChY0La
         w79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776841883; x=1777446683;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9mzBLLfRDXSM+6lC2N843ikZ9n5C+QkmsowzXTZFXM=;
        b=s1tWVicmvGs3+G3EO7Zu5shmD/xV+k2Yxect2U2bHmw6tO9K6Nwh408mL2G1RLi7LU
         /4ejiiNEJHNMZOCqwCFGkFd5f75YOQMLFEbcJttqtMayYDhj0PKKxO9vlpdcKHgI4uqj
         ruPikk68TVGY5K+PSzZE5jwtoM6vw04oi9p8L3OPYAGMlCifqexXp+3Zyc0EsY259LnO
         +I72Elw/hv4WNevQ9ClD2sUcstDPjvNkkPE/GkpX6HH6TPKouD4RsZVloQk9qbDkzbPJ
         2NGXzVrJUvfiCNsXBmna3YW1RgVMHii8wax8BjPGptajXwuQ9Bbs7OnOgQT4nBf2TcTX
         TAXw==
X-Forwarded-Encrypted: i=1; AFNElJ+0UeIMiU6SASDs8T2JmTwhiRm+GjbfiPD6I4R4PVQ63b57FfPMsbU5XEgvbKkfOIzW0EYy9SdRR0LiM2a8XrJv@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQYVan/+X36b711/90jHrYFpC4yatXJylD7wd7pgWTQmdg3yK
	1RuZ7dbuaVGCXcsy7WqoYbHUewIQq8tH7H3QZIF0zfa2h01p0tL1ZBqN0g94SwRqxD8=
X-Gm-Gg: AeBDievh3P5HqgcqBAeelagAMQtJle1Pyzgk/IkNC+TEyHO+SkMR4Uyae33P757hPqL
	YwRcM6XIlCbhskDdMI9YbHWzp3RXEQJXqehO3z4hNP+y6XSZqYTOvQmZuIpW+UHH31w8vDxqXe3
	SfR5tmdycrJA2hGA3ip77/orGhuVeUNHSVF8ffJ0KnT3uzS0PYAxssp3iaeCJGbza/F09p78Jjq
	bWZT9u69zWZceWbaCTgN9qOZbSE2hE13PaYmEzU0am2dy04jupXyfuTCLULuM7dIUdL+B748wE/
	Ll7wR74c+GlAqt/VLmX4HDiqJm1wqzcf0bLcRdN7xvB/ySTjQRMGvQ86xxZ/hOTl+uCDJfho4ub
	ud1DUJsE8c5OI5hLmS1Ull1eNoi9sdWUYw2Cc9CK0KT56owaER2awkxUJ36x6NwgCji0h4jn3v5
	jdpUkC627yI/kB5i1xi1mFcwr+tlQD0sGJbSRw+NT6v7pvzSvdfuu40xDbHERME5nrUNngFbyUM
	o3+n74+ug1e8SGzL0BWvUYx7Yb12IBml7nYbP97VAIgIYJh2Ut0KNHz1Wxzhjih
X-Received: by 2002:a17:907:980d:b0:ba3:4d21:92 with SMTP id a640c23a62f3a-ba41dd394abmr1022936366b.32.1776841882452;
        Wed, 22 Apr 2026 00:11:22 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba44e5749d9sm514889666b.0.2026.04.22.00.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:11:22 -0700 (PDT)
Message-ID: <0f0e5ba5-e6af-45ca-98b8-ea3bcbcede59@suse.com>
Date: Wed, 22 Apr 2026 09:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-edac@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Tony Luck <tony.luck@intel.com>
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
 <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com> <aeYty5kU8Rp44USr@google.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <aeYty5kU8Rp44USr@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------J83Y9428D0DH5wJ8j09EuqT0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------J83Y9428D0DH5wJ8j09EuqT0
Content-Type: multipart/mixed; boundary="------------OHBgd90ulbwSQkSjRh0sy2Jj";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-edac@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <0f0e5ba5-e6af-45ca-98b8-ea3bcbcede59@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
 <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com> <aeYty5kU8Rp44USr@google.com>
In-Reply-To: <aeYty5kU8Rp44USr@google.com>

--------------OHBgd90ulbwSQkSjRh0sy2Jj
Content-Type: multipart/mixed; boundary="------------YKOcetYwmQ2xWu5IqYMt10bv"

--------------YKOcetYwmQ2xWu5IqYMt10bv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjYgMTU6NDQsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIE1v
biwgQXByIDIwLCAyMDI2LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4gT24gMjAuMDQuMjYg
MTM6NDEsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+IE9uIE1vbiwgQXByIDIwLCAyMDI2
IGF0IDAxOjM1OjEyUE0gKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+PiBPbiBN
b24sIEFwciAyMCwgMjAyNiBhdCAxMToxNjoyOEFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdy
b3RlOg0KPj4+Pg0KPj4+Pj4gLSBVc2UgZnVuY3Rpb25zIGluc3RlYWQgb2YgbWFjcm9zIGZv
ciBhY2Nlc3NpbmcgTVNScywgd2hpY2ggd2lsbCBkcm9wDQo+Pj4+PiAgICAgbW9kaWZ5aW5n
IHZhcmlhYmxlcyBwYXNzZWQgYXMgYSBwYXJhbWV0ZXIuDQo+Pj4+Pg0KPj4+Pj4gLSBFbGlt
aW5hdGUgbXVsdGlwbGUgYWNjZXNzb3JzIGRvaW5nIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcg
KGUuZy4NCj4+Pj4+ICAgICByZG1zcmwoKSBhbmQgcmRtc3JxKCkpLg0KPj4+Pg0KPj4+PiBT
byBmYXIgc28gc2FuZS4NCj4+Pj4NCj4+Pj4+IC0gSW5zdGVhZCBvZiBoYXZpbmcgZnVuY3Rp
b24gbmFtZXMgYmFzZWQgb24gdGhlIHVuZGVybHlpbmcgaW5zdHJ1Y3Rpb24NCj4+Pj4+ICAg
ICBtbmVtb25pY3MsIGhhdmUgZnVuY3Rpb25zIG9mIGEgY29tbW9uIG5hbWUgc3BhY2UgKG1z
cl8qKCkpLg0KPj4+Pg0KPj4+PiBOb3Qgc3VyZSBvbiB0aGlzIG9uZS4gVGhlIHdob2xlIG1z
cl97cmVhZCx3cml0ZX1fe3NhZmUsbm9zZXJ9KCkgdGhpbmcgaXMNCj4+Pj4gYSByb3lhbCBw
YWluLiBBbHNvICdub3NlcicgcmVhZHMgdG8gbWUgYXMgdGhlIG5vdW4gdGhhdCBnb2VzIHdp
dGggJ3RvDQo+Pj4+IG5vc2UnIFtoZSB0aGF0IG5vc2VzIChhcm91bmQpLCBsaWtlIGJha2Vy
OiBoZSB0aGF0IGJha2VzXS4NCj4+Pj4NCj4+Pj4gSSB3b3VsZCBtdWNoIHJhdGhlciB3ZSBq
dXN0IHN0aWNrIHRvIHRoZSBtbmVtb25pY3MgaGVyZS4gQWxsIG9mIHRoaXMNCj4+Pj4gcmVh
bGx5IGlzIGFib3V0IHdyYXBwaW5nIHNpbmdsZSBpbnN0cnVjdGlvbnMsIG5vIG5lZWQgdG8g
bWFrZSBpdCBhbg0KPj4+PiB1bnJlYWRhYmxlIG1lc3MuDQo+Pj4NCj4+PiBBbHNvLCB0aGUg
X3NhZmUgc3VmZml4IHNob3VsZCBqdXN0IGdvIGF3YXkuIEFsbCBNU1IgYWNjZXNzb3JzIHNo
b3VsZCBiZQ0KPj4+ICdzYWZlJy4NCj4+DQo+PiBUaGF0IHdvdWxkIGJlIGZpbmUgYnkgbWUs
IGJ1dCBJJ2QgbGlrZSB0byBoYXZlIHNvbWUgY29uZmlybWF0aW9uIHRoaXMgaXMNCj4+IHJl
YWxseSB0aGUgcm91dGUgdG8gZ28uDQo+IA0KPiBJIGRvbid0IGNhcmUgd2hhdCB0aGUgc3Vm
Zml4IGlzIGNhbGxlZCwgb3IgaWYgdGhlcmUgaXMgZXZlbiBhIHN1ZmZpeCwgYnV0IHRoZXJl
DQo+IG5lZWRzIHRvIGJlIGEgd2F5IGZvciB0aGUgY2FsbGVyIHRvIGNvbW11bmljYXRlIHRo
YXQgaXQgd2FudHMgdG8gaGFuZGxlIGZhdWx0cywNCj4gc28gdGhhdCB0aGUgImNhbGxlciBp
c24ndCBnb2luZyB0byBoYW5kbGUgYSBmYXVsdCIgY2FzZSBnZW5lcmF0ZXMgYSBXQVJOIGlm
IHRoZQ0KPiBhY2Nlc3MgZG9lcyAjR1AuDQoNClNvIHRoaXMgY2FsbHMgZm9yIGtlZXBpbmcg
dGhlICpfc2FmZSgpIHZhcmlhbnRzIChrZWVwaW5nIHRoZSBuYW1lIG9yIG5vdCkuDQoNClVz
aW5nIHRoZSBsYWJlbCBiYXNlZCBlcnJvciBoYW5kbGluZyBmb3IgdGhvc2UgaXMgYSBuby1n
byBJTUhPLCBhcyB3ZSBhcmUNCnRyeWluZyB0byBpbmxpbmUgYWxsIE1TUiBhY2Nlc3NlcyBh
cyBtdWNoIGFzIHBvc3NpYmxlIGluIG9yZGVyIHRvIGF2b2lkDQpjYWxscyBhbmQgdGhlIGFz
c29jaWF0ZWQgcG9zc2libGUgcmV0cG9saW5lIHN0dWZmIChyZXF1ZXN0IGJ5IFRob21hcyBH
bGVpeG5lcg0KSUlSQykuIERvaW5nIHRoZSBXQVJOIGlubGluZSB3aWxsIGJsb2F0IGNvZGUg
bW9yZSB0aGFuIG5lY2Vzc2FyeSwgZXNwZWNpYWxseQ0KYXMgd2UgYWxyZWFkeSBoYXZlIHRo
ZSBjZW50cmFsIFdBUk4gdG9kYXkgd2hlbiBmaXhpbmcgdXAgdGhlICNHUC4NCg0KSW4gb3Jk
ZXIgbm90IGhhdmluZyB0byBtb2RpZnkgdGhlIGxvZ2ljIGZvciBjdXJyZW50IHVzZSBjYXNl
cyBpdCB3b3VsZCBiZQ0KYmVzdCB0byBrZWVwIHRoZSBtYWluIGludGVyZmFjZSBvZiB0aGUg
Kl9zYWZlKCkgZnVuY3Rpb25zIChsZXQgdGhlbSByZXR1cm4NCjAvLWVycm5vLCB1c2UgYSBw
b2ludGVyIGZvciB0aGUgdmFsdWUgcmV0dXJuZWQgYnkgcmRtc3Jfc2FmZSgpKS4NCg0KV2Ug
Y2FuIGFkZCBsYWJlbCB2YXJpYW50cyBvbiB0b3AgdXNpbmcgbWFjcm9zLg0KDQoNCkp1ZXJn
ZW4NCg==
--------------YKOcetYwmQ2xWu5IqYMt10bv
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------YKOcetYwmQ2xWu5IqYMt10bv--

--------------OHBgd90ulbwSQkSjRh0sy2Jj--

--------------J83Y9428D0DH5wJ8j09EuqT0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnodJkFAwAAAAAACgkQsN6d1ii/Ey+q
FAf/fho962CPa+wSVWG90hTM6iyeVdkEMqZd4l3pGuL9s4o1DKQWYSfpNSI2ujmvPuBo/fQzad+U
ql01kofIWwV9JRctcf/FcFhsrT1iUlw74vVfYCKI23BUz8V6MQqfIlinqcqPpJ93Sdv6E2tiykeI
QegQeMXyZRI2MWD/JKe6xc7/3YZHL5szUcUUBcC9NsLoujhlTjJA8MZnEixcC6PM1+cIrJbFk/yY
WE14t7RpkGGIG/ryJ9zOTVHDh3XudY/LMY1PGpPSThqk8pSyORxJiiCttO0lfPLrlm0W6yutVTFo
lrmjBZfQJktEnlWpnEfkzIIRF9vN14HHGah7v2hylw==
=J6dB
-----END PGP SIGNATURE-----

--------------J83Y9428D0DH5wJ8j09EuqT0--
