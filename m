Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB063352009
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195807; cv=none; b=KPB3mZ0KuWI8X7d/lv3tk+0/lknemD+B9WfayMDf2vDXTlAAP/b8H7B8BZu3PqdL79fPUpbJ0FgGkorJyI6pGu+zaX2Izl0YEWPFtWwsIiRSFgmwHKeMO1qHTHV1kI8tXESiwVBByMb98vZ0QcbFp/BBGO8zMsw44IN1fySm4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195807; c=relaxed/simple;
	bh=sCdpZe2i/QHdtW679jX9SdR4a7+kZzZrKxfkIQPem7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjlorKV1xvF9z/TzmZ0fTkFFOo/bI7R3DfB7nd5hY0FfXB4+3xzuH6MrS3gfeDEZUQ/pXwHeOIGtjPcsv8g/jqq3xbFL3QNMN/xXXj7UYuK9sUNgcE/eNCP/orkiqWQWLKqIdp546tR9K8xMrSTQ9OkpfkQBRjbQlvZNjp1YylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bssf86yg; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bssf86yg"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so124652166b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 23:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789195804; x=1789800604; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sCdpZe2i/QHdtW679jX9SdR4a7+kZzZrKxfkIQPem7s=;
        b=Bssf86ygnNcIOdpsdU4WXEa1ReCtbz3TI1Wl3uGEaUZtS7UPlvJQrdmweV/MNyXtEl
         yGbLEIYe+cLmLKuv+fwPCHwsvj40VRZWz9OC2opd2HS2aJf5O8QRupaW4mP3h9l0kgiB
         qwuThS3MR1F28jCuJ6i/q/7Ao0ozfRzUGV6h5Tg7P76wGtS37F0fzm1PxjbHCcuBxR1y
         ug094VTjCBsXaH8STSHhVxJLtrKA1saOnfhOfI5M+mIWlfzt2Gd0Qsb3oXu39qLrQiCs
         7RD+fZP6KLagHedMyx1Y9LtmElGDv0phG8KeQiztLO3T5sHAkprIzEpewBrtsiG/HtUz
         s61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789195804; x=1789800604;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCdpZe2i/QHdtW679jX9SdR4a7+kZzZrKxfkIQPem7s=;
        b=Juf6dRSR37EEidBITaXeIia339qffkZ3pcMzg0F19kVRpwzYjGOQskeSrFefQ6txIi
         kG22FGydG9DIwKue2prnzuWJiR4WedI1/Z9kjtwG/duwTqNZyThgm9tb/1RKXWNa76zc
         M2mujaH8YCK3bpirZq74tz32C+0UxT1pJNKY+Ou+/v56PEbKeeUrHYJbNk93tdZvvNXw
         dQRoo1/tpczQxrbgvLP44egCjlq/LrUqkJJ9gcUj7T/mkgOPxFl7H/YH3wyFxRSBZ6Cn
         t/esyd+ySgI+RgLvK42VB/nPKIRQp8CgT6+WAnG8aeXPtL4JuVgqXusSuD1ixuJF3hf/
         0pHw==
X-Forwarded-Encrypted: i=1; AKwUvBytYg8GQwIKr1C95T0BpH6zpJrEpYlpGX2S7mHluaw8q6+gEW5uiDmEye6aN5EdE8+DsjEljSo5VjrscDROSdrM@vger.kernel.org
X-Gm-Message-State: AFuF++llx/Q6s53zpLhWB5oiIv89iqwGITwcG6MP0xAr3MdY94QkwKxp
	KZZL0kXLHn8L3l5HU4rIBMa51Z1dLgpooFcEV6f8cq64gVB0JpOnig4xkQYOWV1gwro=
X-Gm-Gg: AYBFou2AV9KSQVGXLo5l/THDSj3WctfI5k6GfcFVKRJ3C1PkpykwFQqlp/SVT+THRfh
	cJtyt4vyAA78cuprXxayJUg0779KeLwTiZOicv5a8OavFoHP5H/zWd6kqPEmlmlUNE2JlGbWg01
	Vs65OnWPGW/dUo2ciYyHeZC2ytpK3ebBF8SzHu5mkaQ0E7JbfIzKVwKFMZzLKjgHFk2W6K65Ir0
	ockSI9hqF5x+cqTork7qnM5TTTlKnoutsEf45GO1tEErAjVqimGVBG6FMe54D8tefELL1pXICVn
	bYMv9xOJUg35Oq8AMzElL/nOXXUeSJOmW2xf9ezm32m/7C90gcMh93iJTjBTIHwbw1tkAEiFcO0
	s6lNcdPmMtMgdotFrwgInzHg9piIRG9+1F5b0B5e3zLGho4blOjJUB0fOcDPU1ykvnhCJf1qsRe
	f3qcJRrNG5qqahq1y2zxIwSLyYe1vhpLLcNbfvHlFdWV7O6xUO5q4AiJlPqFwn2aVeZ1jIEVhUu
	OKT8Va0xC2eR5Y2wupcHzjSQBVQrDhP2joy+8W9ZShhkaz2LMQPEKRabbOuY1hVolcABZz8Hylk
	KXOG7ckSXseUMCfKFTZtlhXE
X-Received: by 2002:a17:906:f591:b0:c29:462b:f917 with SMTP id a640c23a62f3a-c29666f739cmr698707866b.14.1789195804064;
        Fri, 11 Sep 2026 23:50:04 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e1ffsm159761166b.7.2026.09.11.23.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 23:50:03 -0700 (PDT)
Message-ID: <1e2adc53-87f4-42f3-8eda-cce828009e88@suse.com>
Date: Sat, 12 Sep 2026 08:50:02 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] x86/msr: Simplify some rdmsrq() use cases
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
 kas@kernel.org, kys@microsoft.com, longli@microsoft.com,
 mark.rutland@arm.com, mhklinux@outlook.com, mingo@redhat.com,
 namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
 rick.p.edgecombe@intel.com, seanjc@google.com, tglx@kernel.org,
 wei.liu@kernel.org
References: <20260821105709.1671132-1-jgross@suse.com>
 <20260911213310.381839-1-shreshth.srivastava@intel.com>
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
In-Reply-To: <20260911213310.381839-1-shreshth.srivastava@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------faqU8D6UM6LZgyWtdNphe2F6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------faqU8D6UM6LZgyWtdNphe2F6
Content-Type: multipart/mixed; boundary="------------dL8jxm9dVU7kKr5WHApU9RgD";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
 kas@kernel.org, kys@microsoft.com, longli@microsoft.com,
 mark.rutland@arm.com, mhklinux@outlook.com, mingo@redhat.com,
 namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
 rick.p.edgecombe@intel.com, seanjc@google.com, tglx@kernel.org,
 wei.liu@kernel.org
Message-ID: <1e2adc53-87f4-42f3-8eda-cce828009e88@suse.com>
Subject: Re: [PATCH v3 13/13] x86/msr: Simplify some rdmsrq() use cases
References: <20260821105709.1671132-1-jgross@suse.com>
 <20260911213310.381839-1-shreshth.srivastava@intel.com>
In-Reply-To: <20260911213310.381839-1-shreshth.srivastava@intel.com>

--------------dL8jxm9dVU7kKr5WHApU9RgD
Content-Type: multipart/mixed; boundary="------------VU1m0sOTKOmOlXUOKddZrxGl"

--------------VU1m0sOTKOmOlXUOKddZrxGl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDkuMjYgMjM6MzMsIFNocmVzaHRoIFNyaXZhc3RhdmEgd3JvdGU6DQo+IEhpIEp1
ZXJnZW4sDQo+IA0KPiBJJ20gd29ya2luZyBvbiBhIHYzIG9mIERhdmUncyAieDg2L21zcjog
Q29uc29saWRhdGUgbmF0aXZlL3BhcmF2aXJ0IE1TUg0KPiBmdW5jdGlvbnMiIHNlcmllcyBv
biB0b3Agb2YgeW91cnMsIHNvIEkgdHJpZWQgdGVzdGluZyB0aGlzIHBhdGNoLg0KDQpZb3Ug
c2hvdWxkIGxvb2sgYXQgWzFdIGFuZCBbMl0gYXMgd2VsbC4NCg0KPiANCj4gV2hpbGUgSSdt
IGhlcmU6IHlvdSBtZW50aW9uZWQgeW91J2Qgc2VuZCBhIFYzIGFmdGVyIHJjMSBpZiBjb25m
bGljdHMNCj4gdHVybmVkIHVwLiBJcyB0aGF0IHN0aWxsIHRoZSBwbGFuPyBJIHdhc24ndCBz
dXJlIHdoZXRoZXIgdG8gYmFzZSBvbiB2Mg0KPiBwbHVzIHRoZSByZXNwaW5zIG9mIDQgYW5k
IDEzLCBvciB3YWl0Lg0KDQpJIGRpZCBzZW5kIG91dCBWMyB5ZXN0ZXJkYXkgWzNdLg0KDQo+
IA0KPiBNb3N0IG9mIHRoZSBjb2RlIHRoaXMgdG91Y2hlcyBjYW4ndCBydW4gb24gbXkgYm94
LCBzbyBJIGNvbXBhcmVkIGNvbXBpbGVkDQo+IG91dHB1dCBpbnN0ZWFkLiBCdWlsdCBwYXRj
aGVzIDEtMTIsIHRoZW4gMS0xMywgd2l0aCB0aGUgc2FtZSAuY29uZmlnIGFuZA0KPiBjb21w
aWxlciwgYW5kIGRpZmZlZCAib2JqZHVtcCAtZCIgb3V0cHV0IGZvciBldmVyeSAubyBpbiBi
b3RoIHRyZWVzLiBBbGwNCj4gOTM5NiBvYmplY3RzIGNhbWUgb3V0IGlkZW50aWNhbC4gVGhl
IDEtMTMga2VybmVsIGJvb3RzIGZpbmUgdW5kZXIgS1ZNLg0KPiANCj4gT25seSB0cmllZCB0
aGUgb25lIGNvbmZpZzogeDg2XzY0LCBnY2MgMTEuNS4wLA0KPiBDUFVfU1VQX3tJTlRFTCxB
TUQsWkhBT1hJTn09eSwgSFlQRVJWPXksIEtWTV9JTlRFTD15LCBLVk1fSU5URUxfVERYPXku
DQo+IA0KPiBUZXN0ZWQtYnk6IFNocmVzaHRoIFNyaXZhc3RhdmEgPHNocmVzaHRoLnNyaXZh
c3RhdmFAaW50ZWwuY29tPg0KDQpUaGFua3MuDQoNCg0KSnVlcmdlbg0KDQpbMV06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA5MTEwNzUyMTYuMzE0MjMwOS0xLWpncm9z
c0BzdXNlLmNvbS9ULyN0DQpbMl06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
NjA5MTEwODQyMTEuMzE0OTk1Ny0xLWpncm9zc0BzdXNlLmNvbS9ULyN0DQpbM106IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA5MTEwNzQ1MzAuMzE0MDgzMC0xLWpncm9z
c0BzdXNlLmNvbS9ULyN0DQo=
--------------VU1m0sOTKOmOlXUOKddZrxGl
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------VU1m0sOTKOmOlXUOKddZrxGl--

--------------dL8jxm9dVU7kKr5WHApU9RgD--

--------------faqU8D6UM6LZgyWtdNphe2F6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmqk9hsFAwAAAAAACgkQsN6d1ii/Ey/S
1wf/QTQ5woUenjuZ7QkJEXIuWDT7pJrQQt4dQPrJUah9M9GRZ1uIegM3263zRi5Yv09bbadrYuM3
oLSnH3FWqDCembBNmlwXTlL+fkoRnIoAZZUApZHUyVZDqQZmyfjPpogjHlUhDfwnKZMJYRX5P/rH
AilfznPtW63O4zPeeCDF/q803mUv3UBxtP9PA4+Bhta4b9zcRpSHouBFVgOj/Eq6uj4bs9YPdYvE
jUpqgPbVXQzL6HUq79PPAUxs/Is+2tusB7d/OwA4UzeY0VN8Ky6zeJNAOv7xMxiFZeVh8RZ5Dk5w
ak4YEaJmufWhu4w8Bgx3uV5J/SvArlMv2MnItpdDew==
=kgkG
-----END PGP SIGNATURE-----

--------------faqU8D6UM6LZgyWtdNphe2F6--
