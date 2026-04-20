Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B43128B8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685746; cv=none; b=HLxGkTPoOpA3FbslFoFiOBTrKZlptvWF6BFf/ki8mP0ZXcI2+Q+xspgw7l6vQ3nC+Po9OqdYi9i15PywpuUnJmMmD7s/cOfhm+skLOWY5zK498M9mJlUdBpzuFvwOCzpLzfSWfdeig+3FDnkElwu5gHXSYkM2N+TVIhywCKSovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685746; c=relaxed/simple;
	bh=ihEThMgTphocxPRILlgZlE9ZRDSmuo0KKaIVgIeXpjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIu+tyzQys3soy7WA8MLVb8hFiAaS3F9xlJNL7dK7D4LAbNRaq9rzbhz/tcSyWPRv5RtTHkyLXDg52vX6XhUOd3gv18RA3Tpn7s5j3+c0urVYo+r1X8JIizDCY0La4v2LqxACQhCY+a8pGz3peUjoSMQIAs/FNNXWfqjxrjLBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QC3lojjW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QC3lojjW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba7fd666666so83877366b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776685744; x=1777290544; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ihEThMgTphocxPRILlgZlE9ZRDSmuo0KKaIVgIeXpjY=;
        b=QC3lojjWi9n4OrCp6H/EgYJYAP4HB8nsQ0b1c2JrUomesacKSbYETWCuHJmZr6lUr1
         EmaultF2c4NXTBt5f4d14FaFku1Z5ucX1fc3UnXJEqnTi3ejYn7nUD9JHwrfxB8G3gmf
         YoZKjq9aKxR0RQzmQA9djRdHt5BijhRLzOrkI/KOAWfeiUAR4+XgRchYuaBIDG0uUK79
         OWy0mU+hTwXZskr06rmir5Zw+rLtdks3mKcc3W2fxjjliRWDwl4tIYhEOvMXNs9Vu0WB
         IjRmc5CIuMNi1XYxuE4/2f7vOmLD2z9y9t4o9x57EImSco1cilsUM44RAupgeLtufe7+
         UHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685744; x=1777290544;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihEThMgTphocxPRILlgZlE9ZRDSmuo0KKaIVgIeXpjY=;
        b=IzrACHX1qlX4RIVImqE02Jm3eRbjTf5rByce2y8kHORMyhK985etVDhe4/BcHW99AA
         pODKThhvx3RQG9g7G47nItPWW4R3w1dT7nPv64lWdR13MoOZXY1RlL+OLmeD3P1sYuG+
         9rFvqH961bYzXiouZlr76CQjrueIsnkYksWMNx5RZPBJujcVnvYv82FPrc6oa8wvSXcR
         NLEOU94/j/osxvWzy9G4SuihbAlBDRgIUE5n6iZSJmo3fLcNE++4H7pVKmvRRpxf34lN
         aFdZcn9EHyGlRUwFqMAMcnRmlXUSSd/5Z3+dfdALet2qxyY0piydS7KIBjneZYJKqJ/Z
         LYqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DFep+SXFuPHp0FDzYL00gM5kVbCKR3i+PyjG+63hWZM6MVZ4+8IrRgOEEX9/J9yKBbB4K2/gWmIjrg+MJyWkD@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEFN8ngvhbEf0oS52RKcg4M3prWi22+g9Z7erID5Lq3QiV68n
	u625bdqcQYjSWP6lxjiHeqQ3I9P6cHzDPctbEo2aK3wNWCbb1H4sCNcqBN0FFUB4pK8c4uH7ppF
	vqNV3aOE=
X-Gm-Gg: AeBDietmoEcsUJhyrvcNppZvfAiB3gb3yc9AOlZkLgrzFbib2Lpil6P0gEPaUfLQ0hI
	oRAEHeeBjueE4xe10MlNRV2i5IooPcqRwtlm3NatW/SpbjWfCpOx7FH4khnD4aKIsl2l2+WMqGa
	Pj/XePUcK+h6OLJyEYOc6zT7ybF0nwum7aSOceMjUGJZlVh3rajJaLcBt6o8LRDfQEuDl2fWBf9
	V9WxFgrqSlZepBQwiIaedIEr0UC1FhOEKb+PdLtzcYC+mezbpW4QwM7JoEgTNllduLalt2eBxcd
	XjJC7g1t1OG+IIBvIvsg5ZJ9aRM8aNMPcKqwgyZjtkeNdlnMdMZRBiDXLmhOs7cVO5sZ4sWdaoF
	s/MDSJyqFy1RRgUa4UHTrcZbehoCE7A4Z0db9KjRSyZBmZdST9Ms0ZsYeLJmZMv92SiiiggQ/4K
	OIjQj3T6AdYD1k+Z0mY8ycQg2JOFnMC1wcqjcrV3t+bgrCnNlAvLyQ9qGaClP1lZDqcS0k7Iti0
	6fbd2FGADw+sVFHgw7BMcCtkPg6x0gwG59qkH4bZWrf7RKOCSgCrP1oxUVvWlIw
X-Received: by 2002:a17:907:969e:b0:ba6:8a6c:f916 with SMTP id a640c23a62f3a-ba68a6d02ddmr308623266b.48.1776685743493;
        Mon, 20 Apr 2026 04:49:03 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45121109csm343096166b.6.2026.04.20.04.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:49:03 -0700 (PDT)
Message-ID: <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
Date: Mon, 20 Apr 2026 13:49:02 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Tony Luck <tony.luck@intel.com>
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fvo4R6Zr7xHo0bz6TBRPvfz5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fvo4R6Zr7xHo0bz6TBRPvfz5
Content-Type: multipart/mixed; boundary="------------UVHpC1BS0RWh0p1SIUxrLziS";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420113512.GG3102624@noisy.programming.kicks-ass.net>

--------------UVHpC1BS0RWh0p1SIUxrLziS
Content-Type: multipart/mixed; boundary="------------5gB0KbiQx3tTliQcrcC9l6Yx"

--------------5gB0KbiQx3tTliQcrcC9l6Yx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjYgMTM6MzUsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIEFw
ciAyMCwgMjAyNiBhdCAxMToxNjoyOEFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4+IC0gVXNlIGZ1bmN0aW9ucyBpbnN0ZWFkIG9mIG1hY3JvcyBmb3IgYWNjZXNzaW5n
IE1TUnMsIHdoaWNoIHdpbGwgZHJvcA0KPj4gICAgbW9kaWZ5aW5nIHZhcmlhYmxlcyBwYXNz
ZWQgYXMgYSBwYXJhbWV0ZXIuDQo+Pg0KPj4gLSBFbGltaW5hdGUgbXVsdGlwbGUgYWNjZXNz
b3JzIGRvaW5nIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgKGUuZy4NCj4+ICAgIHJkbXNybCgp
IGFuZCByZG1zcnEoKSkuDQo+IA0KPiBTbyBmYXIgc28gc2FuZS4NCj4gDQo+PiAtIEluc3Rl
YWQgb2YgaGF2aW5nIGZ1bmN0aW9uIG5hbWVzIGJhc2VkIG9uIHRoZSB1bmRlcmx5aW5nIGlu
c3RydWN0aW9uDQo+PiAgICBtbmVtb25pY3MsIGhhdmUgZnVuY3Rpb25zIG9mIGEgY29tbW9u
IG5hbWUgc3BhY2UgKG1zcl8qKCkpLg0KPiANCj4gTm90IHN1cmUgb24gdGhpcyBvbmUuIFRo
ZSB3aG9sZSBtc3Jfe3JlYWQsd3JpdGV9X3tzYWZlLG5vc2VyfSgpIHRoaW5nIGlzDQo+IGEg
cm95YWwgcGFpbi4gQWxzbyAnbm9zZXInIHJlYWRzIHRvIG1lIGFzIHRoZSBub3VuIHRoYXQg
Z29lcyB3aXRoICd0bw0KPiBub3NlJyBbaGUgdGhhdCBub3NlcyAoYXJvdW5kKSwgbGlrZSBi
YWtlcjogaGUgdGhhdCBiYWtlc10uDQoNCk5hbWluZyBpcyBoYXJkLiA6LSkNCg0KV2hhdCBh
Ym91dCBzL3Nlci9zeW5jLyB0aGVuPw0KDQo+IEkgd291bGQgbXVjaCByYXRoZXIgd2UganVz
dCBzdGljayB0byB0aGUgbW5lbW9uaWNzIGhlcmUuIEFsbCBvZiB0aGlzDQo+IHJlYWxseSBp
cyBhYm91dCB3cmFwcGluZyBzaW5nbGUgaW5zdHJ1Y3Rpb25zLCBubyBuZWVkIHRvIG1ha2Ug
aXQgYW4NCj4gdW5yZWFkYWJsZSBtZXNzLg0KDQpJJ20gcHJldHR5IHN1cmUgbW9zdCBvZiB0
aGUgd3Jtc3IqKCkgdXNlIGNhc2VzIGNvdWxkIHN3aXRjaCB0byB0aGUgbm9uDQpzZXJpYWxp
emluZyB2YXJpYW50cy4gVGhlIHByb2JsZW0gbm90IG1ha2luZyB0aGUgc2VyaWFsaXppbmcg
YXNwZWN0IHZpc2libGUNCmluIHRoZSBmdW5jdGlvbiBuYW1lIHdpbGwgcHJvYmFibHkgcmVz
dWx0IGluIG1vc3QgbmV3IGluc3RhbmNlcyBzdGlsbCB1c2luZw0KdGhlIHNlcmlhbGl6aW5n
IHZhcmlhbnQgaW5zdGVhZCBvZiB0aGUgcHJvYmFibHkgcG9zc2libGUgbm9uIHNlcmlhbGl6
aW5nIG9uZS4NCg0KTWFueSBvZiB0aG9zZSB1c2UgY2FzZXMgd2lsbCBldmVuIHN1ZmZlciBt
b3JlLCBhcyB0aGV5IHdvbid0IHVzZSB0aGUNCmltbWVkaWF0ZSBmb3JtIG9mIFdSTVNSTlMg
dGhlbiwgd2hpY2ggd291bGQgd2FzdGUgdGhlIGFkZGl0aW9uYWwgYmVuZWZpdHMgb2YNCnRo
YXQgaW5zdHJ1Y3Rpb24uDQoNCg0KSnVlcmdlbg0K
--------------5gB0KbiQx3tTliQcrcC9l6Yx
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------5gB0KbiQx3tTliQcrcC9l6Yx--

--------------UVHpC1BS0RWh0p1SIUxrLziS--

--------------fvo4R6Zr7xHo0bz6TBRPvfz5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnmEq4FAwAAAAAACgkQsN6d1ii/Ey+8
IQgAgu8UZ0PScC93CIFUtvT1TUolaFbtN24YRJPzrARMyY2Y2n3d2oMORHooMk+hPdoFhsnv71YH
0Z5abeyBOVwjnUcvG6RR4BO+TJqJzymc4zf+WD6V3dPeB464TlrhPHVRf6u9LBEvYdmlRhX6aeca
zSKggVG94JlhLVSCvcl4ohf/pWQOhY5fQVnNFH+iGFJMePgIh9T93AMaIuTmYlYIofU2IXloDGHW
kJ5z+QT+rWBm/cw3K1sNXE8Np0wagGBu7pyqTdLCojv/TS4HbvPhDyALtk0W37tFV1GJ/7EcN71k
51htEeOfi8ci97xpLqmCcgWdsIsq0QF84EoxzXyexQ==
=3EeD
-----END PGP SIGNATURE-----

--------------fvo4R6Zr7xHo0bz6TBRPvfz5--
