Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9B3845A2
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685873; cv=none; b=IGTtFnq21rUrMLu/1tolv2ZvWAuhcgSkORsJ8ob2r4DQ52fRSYJsrnY+s0gW48XKpRcwaZidlTt3wEZwgaMKq7s+NbZ+7iDcbsY6gZicjosC7hJ6QniDy0SwPgseSv6NCzV2A3wkMpYbiawwq7ivmnTtnS8ihhqg11ihLmOslYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685873; c=relaxed/simple;
	bh=ehlzk6l3AihvvZOpumwV1XdU4NF2KhDxOY7IqQUex10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTHjPX/B+UvQRrTqUIWkyNL05m9KjmVzdiSPYIotwagWtbg7v3MYtOZE7wr/hBUOKER2lyZYXCKmjr7bTrXW3s/hoagv90czdKfQFRpRF8tbwVu5rLnAn/3D3RWy2z3ZX9D++J32YoBOqGg08RS7uW1ofJWvFOt1ReHnkI9DDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BdBbvLra; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BdBbvLra"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso4013168a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776685870; x=1777290670; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehlzk6l3AihvvZOpumwV1XdU4NF2KhDxOY7IqQUex10=;
        b=BdBbvLraqACH3iVXQPyO+m6lkGaTb/fFCYQQ7v6Zsl1vlXN9S2jLub2wHVsPc9VEzG
         xDUsqIhJOmabZCH9IJkTYQREAVeHqXgeNOcvaYaL6GV4X0FOPsW0ivI8jQ3waA1h4yqu
         KCDOXL75pYFdnp8T9NFayazHGOinT5H7NPV6mruuDO8+YDWJ+to0lTRuBWLilptu7/sv
         vHv2ZD+uM4z6et1PsMqW0bIZLeo3FkUrxQZXaJj0dKBJ3CcrDBlfBfEjaMXBCwsTZPqi
         W7E5ZyphM0rOUVqc8PepRwYB+OEzwP+mPMfLhJmkKwj9Y4xvsBxuO/WBviRcUUQ0RszE
         Utpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685870; x=1777290670;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehlzk6l3AihvvZOpumwV1XdU4NF2KhDxOY7IqQUex10=;
        b=PaEKtiBpbW4MFo3Xvt2K5adECs91I27/fJ2OEAA+jm7RHWOrcP4V7B3F+OhNujFftl
         Gxlh2+ZlYjxxgNv3nkFM9GZ8ewFX8rjUrqA1kCUB+JG7Iu2EEpGwMsz0XEXNUhhqByrD
         9GWCUHRiGIlkJcjLZ2qJFyD3DZeahkYpdsURTqmctV5n6GHKPkHAUVOEnwmtzUnlOcQ2
         IeZI8OKei26QZho00v7iRZl3OVfyMVrhxalZB4qSgSyFOCEYBVf875UmskrlR71lu7K8
         eZqQ2lq77b5+HRnecFe9smav5ZBJEcdowLhGM/R56ba6i7ZHYEA4Y84e42reTYx0RJAz
         hICw==
X-Forwarded-Encrypted: i=1; AFNElJ+bEebAUtdKyi0fVJMzzSi20favkdqIhhE5MSOWkcQJTz2xiiG5EJYXiAqbIaX1TLbbC2zLl6dY0MGQfRDJeMWp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65BYBIoTwZJh6ZZbAeGwT9sovDzfLmchqSjJbxLXGMQvcRH3n
	fWMXlagzqfYlew4v5JwuhK1pvHSvG4enWAl5WBjwp6C2zCrAGUYyxbzt58UmOkfu/zU=
X-Gm-Gg: AeBDievL0VKBUivpz95LjT/AyLneGWYyE0dKZDwTX6ukX7Q9gTgpNDpsKbZOoKWzjd2
	7SHU57jhUBqRAkjSUQ+EBFne4aYMStfk12LXhspmlr9gSsoE8MjY4xzXeId0cigNpSVfVSGdXpn
	mha8Zk0wfW8lPw+axfJqnXFiJtiQ9PkJz5/SWf4cukyVN7bUjRkquCak0BrFMrgaaR4zV4Yq56l
	NrRW1ha7fIJuMs4DXJz3a/9oYHfQHv11qg1TQi7s13KGDltRTcWD6vXR/sM2yDJb7CUrz1u6FZM
	KO3CKOiFi6RIXtl9fJxESBNd+r4AX+bfghDYZ2lGl3NzDVQXab0RkkkIE5kznpsgFgsvhcxIMdW
	IyRYGXJhsDstKtwpmq0VqsnHUbFQmP9GfHelfApEegIK4UqqVRUDvhcrf0EV0hvLg9np22+JHYd
	NaKKc/LgQTqDbT8lwt63vfXPXgtWIHwbeyf9zg8YqB0NZhwK8ao2i7EzOkQmHDVZr36f8d0FHZA
	EMUlLMBYOBvofPRgkiOFn4lXaBTbesziG+a4qyzPCDzjfs/5JH8/0M1GvW6zkHs
X-Received: by 2002:a17:907:3e9e:b0:ba0:fb42:c254 with SMTP id a640c23a62f3a-ba41e4fc17fmr646840166b.33.1776685869997;
        Mon, 20 Apr 2026 04:51:09 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455539817sm333790866b.56.2026.04.20.04.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:51:09 -0700 (PDT)
Message-ID: <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com>
Date: Mon, 20 Apr 2026 13:51:09 +0200
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
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qg5e8IHkxxAEfOTmiiQswmgk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qg5e8IHkxxAEfOTmiiQswmgk
Content-Type: multipart/mixed; boundary="------------DSdFRA29CAp32E5LhvVnLAsa";
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
Message-ID: <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420114117.GC3102924@noisy.programming.kicks-ass.net>

--------------DSdFRA29CAp32E5LhvVnLAsa
Content-Type: multipart/mixed; boundary="------------bWEOyPVC0sLiJkcTi8ZrJsVA"

--------------bWEOyPVC0sLiJkcTi8ZrJsVA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjYgMTM6NDEsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIEFw
ciAyMCwgMjAyNiBhdCAwMTozNToxMlBNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4+IE9uIE1vbiwgQXByIDIwLCAyMDI2IGF0IDExOjE2OjI4QU0gKzAyMDAsIEp1ZXJnZW4g
R3Jvc3Mgd3JvdGU6DQo+Pg0KPj4+IC0gVXNlIGZ1bmN0aW9ucyBpbnN0ZWFkIG9mIG1hY3Jv
cyBmb3IgYWNjZXNzaW5nIE1TUnMsIHdoaWNoIHdpbGwgZHJvcA0KPj4+ICAgIG1vZGlmeWlu
ZyB2YXJpYWJsZXMgcGFzc2VkIGFzIGEgcGFyYW1ldGVyLg0KPj4+DQo+Pj4gLSBFbGltaW5h
dGUgbXVsdGlwbGUgYWNjZXNzb3JzIGRvaW5nIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgKGUu
Zy4NCj4+PiAgICByZG1zcmwoKSBhbmQgcmRtc3JxKCkpLg0KPj4NCj4+IFNvIGZhciBzbyBz
YW5lLg0KPj4NCj4+PiAtIEluc3RlYWQgb2YgaGF2aW5nIGZ1bmN0aW9uIG5hbWVzIGJhc2Vk
IG9uIHRoZSB1bmRlcmx5aW5nIGluc3RydWN0aW9uDQo+Pj4gICAgbW5lbW9uaWNzLCBoYXZl
IGZ1bmN0aW9ucyBvZiBhIGNvbW1vbiBuYW1lIHNwYWNlIChtc3JfKigpKS4NCj4+DQo+PiBO
b3Qgc3VyZSBvbiB0aGlzIG9uZS4gVGhlIHdob2xlIG1zcl97cmVhZCx3cml0ZX1fe3NhZmUs
bm9zZXJ9KCkgdGhpbmcgaXMNCj4+IGEgcm95YWwgcGFpbi4gQWxzbyAnbm9zZXInIHJlYWRz
IHRvIG1lIGFzIHRoZSBub3VuIHRoYXQgZ29lcyB3aXRoICd0bw0KPj4gbm9zZScgW2hlIHRo
YXQgbm9zZXMgKGFyb3VuZCksIGxpa2UgYmFrZXI6IGhlIHRoYXQgYmFrZXNdLg0KPj4NCj4+
IEkgd291bGQgbXVjaCByYXRoZXIgd2UganVzdCBzdGljayB0byB0aGUgbW5lbW9uaWNzIGhl
cmUuIEFsbCBvZiB0aGlzDQo+PiByZWFsbHkgaXMgYWJvdXQgd3JhcHBpbmcgc2luZ2xlIGlu
c3RydWN0aW9ucywgbm8gbmVlZCB0byBtYWtlIGl0IGFuDQo+PiB1bnJlYWRhYmxlIG1lc3Mu
DQo+IA0KPiBBbHNvLCB0aGUgX3NhZmUgc3VmZml4IHNob3VsZCBqdXN0IGdvIGF3YXkuIEFs
bCBNU1IgYWNjZXNzb3JzIHNob3VsZCBiZQ0KPiAnc2FmZScuDQoNClRoYXQgd291bGQgYmUg
ZmluZSBieSBtZSwgYnV0IEknZCBsaWtlIHRvIGhhdmUgc29tZSBjb25maXJtYXRpb24gdGhp
cyBpcw0KcmVhbGx5IHRoZSByb3V0ZSB0byBnby4NCg0KDQpKdWVyZ2VuDQo=
--------------bWEOyPVC0sLiJkcTi8ZrJsVA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------bWEOyPVC0sLiJkcTi8ZrJsVA--

--------------DSdFRA29CAp32E5LhvVnLAsa--

--------------qg5e8IHkxxAEfOTmiiQswmgk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnmEy0FAwAAAAAACgkQsN6d1ii/Ey8u
SAf/TXFMRQi5W8XxtBl3yg3++GnXlOu+0JK2F8bN5Qm6pf1yZoaDGUuDJHQOl/76XP3kL3mgExfU
T2xX3FUGl4ZDDkDVn8plxa79D4Rpxq2rA8IdLq/QcWupLUq/Um/aPsuA9E2+r8EDPmp6IOtu6m8s
hlzXbMWyRPw7BH0J/1k2svafHq3r0Wfc3ZsZM+WiSwQsoRF68ukTgGsjmqIBDO+9T0nmqvGmsRyl
sQzjYi+kIoUB99G0irSsrtBpa9FhshaixTZG2UU1Zosz7ihtGwPDjQEJ57ZTF9jpiApl0yoCJCay
hYmi8dZ3uDvsZvuz1ooZqx6QvdUVqUwuXz5uQrSxpQ==
=0q+A
-----END PGP SIGNATURE-----

--------------qg5e8IHkxxAEfOTmiiQswmgk--
