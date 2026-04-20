Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152723D4132
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691420; cv=none; b=tffpzkEGVTMUnO+04fvfZ5yBqCrnEDKtiyXAHvTvyfJai2IKcMrjJHwKZKIMqt8wBSeXmASRKpskCRZeVxgtOB/J0tD/VipEV9sDWBWBWZQUjNfHlYCkb9KyYTrJzrWJWOxQ//pXy6kt1O12O1gSdqoGt1jGUSC2BygT83O69yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691420; c=relaxed/simple;
	bh=fK/zENPSnVF2cK+TRMMrx7mAfOOVTpL/t2ABi2qgYk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW5vfURaBPmuqW5EWZn3m5ro+B+rWWXMW+jFyk961omGVZah/hdzOmU7KmYfEkFRscyZT0TezgPbhKbSLpH2Q0Dj72lEeEuqy3dXpSMRUz8m18n5l/9pSYMgW2gKCMr/TIrKZ3keH9U+vqeD6nr6RPd5+Y8zQue8Ksfw0Hov2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ug39R98O; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ug39R98O"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so3566409a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776691417; x=1777296217; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fK/zENPSnVF2cK+TRMMrx7mAfOOVTpL/t2ABi2qgYk4=;
        b=Ug39R98OwP8JTE8YBzUfKd/ma33E47bsjs3xR/wWgddinfaWGcGjk8cazYyjqjw4VK
         BY2XhupzLUay9mH8cc1EO+gnLkEQKyA/B90wEFgRJX7qG49UkupCw+MNLjbvb9rVhBsy
         t11pUUgLP2c5Db0Wl9DlNeA5zx13zx3gYOWXCJ1Gh4+LfolBHGLwNSd+B+q5nskiYYvR
         YxdlGIGwzCNRep85u4bvGBgE5T27JlcK4MYzw2AZzxXFx5SVhlfF9Iydkz5fpMbh/pof
         Tec9jiJQRyM2AItY/gxUbJRqzCViAlltPg54mFvrxHuQ95Dx4j3HarG0M2/JBHxkwG4/
         f4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691417; x=1777296217;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK/zENPSnVF2cK+TRMMrx7mAfOOVTpL/t2ABi2qgYk4=;
        b=k+QkwNziLGuewbRKVK9peiZ2sqoNxPIOc+KU/zjavyVcyhEtJvxtQda8uYs4xzpf8F
         ixgwAYKAXdKiNqGxB5jkCBKKRzZamkYcsYbajGt1SuHt535D2gZCiIYPag6aM4OC2urM
         +yXyZPVTzdWCb83XvShKX6UOyJzlakIcVRlpvPW8uD0+tBPVOB80aNN5iOBX3eCBQdUJ
         DZjXuWf0iMcRnU9UGBxwvwn3rpF3RhM7dgjsqGx4HK7Ezmiw7lZflq4qw7Tor+PXZ88h
         O7+Xn98Wsm+roCnSMBvp3GDW1NxO/lnt1fdGx1XjwUmpNWeSc2jk7pj4gP+X7kt1tlE3
         fOYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xN2EvlgTglGi+IPYWDVhU7+pWXVYmYs5CdQWaGPB7JhxJKGC7xbijLX6k1fxg/fS1qNQgWcitAzMNyUvdB9Ql@vger.kernel.org
X-Gm-Message-State: AOJu0YxihVSO3GGwuoEZ+ZVFE11tmF8CTBM8m595F72ieDQPl7KF6qXD
	C8IK71r5pczjTfpHq4Un7znu44nnSoPIku9wr6PrLBen1XCaq8uWZataNrsABCZ8aqU=
X-Gm-Gg: AeBDieuAJ3uuBasna6ugRo3tR+MTGqVbr6ajKZNPH0HeJGo6C5L2VhVqbYYSo5ZmkjM
	i5IfVVu/tsF9GlaWucTMU67Y4WL0vWn2Q6o5G1S26Olxjd8OSfuOgrEs4buOMDsBi3dq78kRDZt
	zPYwQRHwNbdW6lmS/SHVGotPBrfCOHTuLw58zgix57fa3ZljXjwu2DvJ+sdF8X5627kC2qgiszu
	92ZFxVt7UPdOrXMD9sZikxOha7MGWAvAiFFva+VvRxN+JucjZkcFks76YyWxkUIrbRzRuz6sIgt
	wXnXS07JCxTlHyvJf6EJxXF5X1s+Jj14WtzKt8NV7GK9ZDh7r+1WDNAJ6/HmwVuOmcR6uTP9VpL
	B6zFoZwNYbAVlGyx9xu6/RFavBJkIaoIg+Ah6JSFg7CvfAmVuV+WzuoPpjjXm9R33mMwe475+q2
	LttEl6sGFjfchj8NChfMHuKO03fMT3nazZN+V3pOT7IZoB8Y4ktjSs9v2fiXoQPhiz+iR7PBE1K
	3dr2ACIzu9p3AQrLceA7uguZx4llTyLsFzZGnNJoUydJkKBLJ4rnC5DXnCVMHHq0OqAiO/+heI=
X-Received: by 2002:a17:907:6d15:b0:b98:411a:116f with SMTP id a640c23a62f3a-ba419076c8emr691220466b.2.1776691417073;
        Mon, 20 Apr 2026 06:23:37 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455045652sm348965366b.51.2026.04.20.06.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 06:23:36 -0700 (PDT)
Message-ID: <a49e3a07-1154-4c6a-8763-0bd565cd3179@suse.com>
Date: Mon, 20 Apr 2026 15:23:36 +0200
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
 <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
 <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
 <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com>
 <20260420131020.GI3102624@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260420131020.GI3102624@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0VbizIsoaPic0Srt4Z20cgX7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0VbizIsoaPic0Srt4Z20cgX7
Content-Type: multipart/mixed; boundary="------------MkMxazCF9eScsL1LcWp4rGxE";
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
Message-ID: <a49e3a07-1154-4c6a-8763-0bd565cd3179@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
 <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
 <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com>
 <20260420131020.GI3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420131020.GI3102624@noisy.programming.kicks-ass.net>

--------------MkMxazCF9eScsL1LcWp4rGxE
Content-Type: multipart/mixed; boundary="------------xqV4SofOq8n9i0M2OANdlkJj"

--------------xqV4SofOq8n9i0M2OANdlkJj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjYgMTU6MTAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIEFw
ciAyMCwgMjAyNiBhdCAwMzowMTozMVBNICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
Pj4gT24gMjAuMDQuMjYgMTQ6MzMsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiANCj4+PiBU
aGF0IGlzLCB3ZSBoYXZlIHRoZSBmb2xsb3dpbmcgaW5zdHJ1Y3Rpb25zOiBSRE1TUiwgV1JN
U1IsIFdSTVNSTlMNCj4+PiBBbmQgd2Ugc2hvdWxkIGhhdmUgdGhlIGV4YWN0IHNhbWUgZnVu
Y3Rpb25zOg0KPj4+DQo+Pj4gCXZhbCA9IHJkbXNyKG1zcik7DQo+Pj4gCXdybXNyKG1zciwg
dmFsKTsNCj4+PiAJd3Jtc3Jucyhtc3IsIHZhbCk7DQo+Pg0KPj4gUGVvcGxlIHRlbmQgdG8g
Y29weSBzaW1pbGFyIGNvZGUsIG1heWJlIHVzaW5nIG9sZGVyIGtlcm5lbHMgYXMgdGhlIHNv
dXJjZS4NCj4+DQo+PiBTbyBldmVuIGlmIHdybXNybnMoKSB3b3VsZCBiZSBmaW5lIChhbmQs
IHJlc3VsdGluZyBmcm9tIHRoYXQsIGJldHRlciksIHRoZXkNCj4+IHdpbGwgbW9yZSBsaWtl
bHkgZW5kIHVwIHVzaW5nIHdybXNyKCkgaW5zdGVhZC4NCj4+DQo+PiBVc2luZyBuZXcgZnVu
Y3Rpb24gbmFtZXMgaW1wbHlpbmcgdGhlIGV4YWN0IHNlbWFudGljcyAoc2VyaWFsaXppbmcg
dnMuDQo+PiBub24tc2VyaWFsaXppbmcpIHdpbGwgbWFrZSBpdCBtb3JlIGxpa2VseSB0aGUg
Y29ycmVjdCBvbmUgaXMgYmVpbmcgdXNlZC4NCj4gDQo+IFlvdSBjYW5ub3QgZml4IHN0dXBp
ZC4gSWYgeW91IHdhbnQgZnJpY3Rpb24sIHRoZSBsYWJlbCB0aGluZyB3aWxsDQo+IGVuc3Vy
ZSAnb2xkJyBjb2RlIGRvZXNuJ3QgY29tcGlsZSBhbmQgd2lsbCBuZWVkIGZpeGluZy4NCj4g
DQo+IEFsc28sIGlmIHdybXNybnMoKSByZWFsbHkgaXMgZmFzdGVyLCB0aGUgcGVyZm9ybWFu
Y2UgZm9sa3Mgd2lsbCBmaW5nZXINCj4gJ2luY29ycmVjdCcgd3Jtc3IoKSB1c2FnZSBzb29u
ZXIgb3IgbGF0ZXIuDQoNCkZpbmUgd2l0aCBtZS4gOi0pDQoNCj4gDQo+Pj4gVGhlIG9ubHkg
aW50ZXJlc3RpbmcgcXVlc3Rpb24gaXMgd2hhdCB0byBkbyB3aXRoIHRoZSAnc2FmZScgYXNw
ZWN0LiBUaGUNCj4+PiBpbnN0cnVjdGlvbiB0YWtlcyBhIGZhdWx0LCB3ZSBkbyB0aGUgZXh0
YWJsZSwgYnV0IHJkbXNyKCkgYWJvdmUgYWxyZWFkeQ0KPj4+IGhhcyBhIHJldHVybiB2YWx1
ZSwgc28gdGhhdCBjYW4ndCBiZSB1c2VkLg0KPj4+DQo+Pj4gT25lIG9wdGlvbiBpcyB0bywg
bGlrZSB1YWNjZXNzIGFuZCB0aGUgcHJvcG9zZWQgb3ZlcmZsb3csIGlzIHRvIHVzZQ0KPj4+
IGxhYmVscyBsaWtlOg0KPj4+DQo+Pj4gCXZhbCA9IHJkbXNyKG1zciwgbGFiZWwpOw0KPj4+
DQo+Pj4gQW5kIHRoZW4sIGV2ZW4gdGhvdWdoIHRoZSB3cm1zciooKSBmdW5jdGlvbnMgaGF2
ZSB0aGUgcmV0dXJuIGF2YWlsYWJsZSwNCj4+PiBkbyB3ZSB3YW50IHRvIGJlIGNvbnNpc3Rl
bnQgYW5kIGRvOg0KPj4+DQo+Pj4gCXdybXNyKG1zciwgdmFsLCBsYWJlbCk7DQo+Pj4gCXdy
bXNybnMobXNyLCB2YWwsIGxhYmVsKTsNCj4+Pg0KPj4+IHJhdGhlciB0aGFuIGJlIGluY29u
c2lzdGVudCBhbmQgaGF2ZSB0aGVtIGhhdmUgYSBib29sZWFuIHJldHVybiBmb3INCj4+PiBz
dWNjZXNzLg0KPj4+DQo+Pj4gV2hhdCBhbSBJIG1pc3Npbmc/DQo+Pg0KPj4gSSBsaWtlIHRo
ZSBpZGVhIHRvIHVzZSBhIGxhYmVsLCBidXQgdGhpcyB3b3VsZCByZXN1bHQgaW4gdGhlIG5l
ZWQgdG8gdXNlDQo+PiBtYWNyb3MgaW5zdGVhZCBvZiBmdW5jdGlvbnMuIFNvIHRoaXMgaXMg
dHJhZGluZyBvbmUgYXNwZWN0IGFnYWluc3QgYW5vdGhlci4NCj4+IEknbSBub3Qgc3VyZSB3
aGljaCBpcyB0aGUgYmV0dGVyIG9uZSBoZXJlLg0KPj4NCj4+IEFuIGFsdGVybmF0aXZlIG1p
Z2h0IGJlIHRvIHN3aXRjaCByZG1zcigpIHRvIHRoZSBpbnRlcmZhY2UgdXNlZCBieSByZG1z
cl9zYWZlKCksDQo+PiBpLmUuIGxldCBhbGwgdGhlIGFjY2Vzc29ycyByZXR1cm4gYSBib29s
IGZvciBzdWNjZXNzL2ZhaWx1cmUgYW5kIHVzZSBhIHBvaW50ZXINCj4+IGZvciB0aGUgTVNS
IHZhbHVlIGluIHJkbXNyKCkuDQo+IA0KPiBZZXMsIGVpdGhlciB3YXkgYXJvdW5kIHdvcmtz
LiBQZXJoYXBzIHRoYXQgaXMgJ2JldHRlcicgYmVjYXVzZSBtb3N0bHkgd2UNCj4gZG9uJ3Qg
Y2FyZSBhYm91dCB0aGUgZmF1bHRzIHNpbmNlIHdlJ3ZlIGNoZWNrZWQgdGhlICdmZWF0dXJl
JyBlYXJsaWVyLg0KPiANCj4gSXRzIGp1c3QgaW5jb252ZW5pZW50IHRvIGhhdmUgcmV0dXJu
IGluIGFyZ3VtZW50IGNydWQsIGJ1dCB3aGF0ZXZlciA7LSkNCg0KT2theSwgc28gd291bGQg
eW91IGJlIGZpbmUgd2l0aCB0aGUgZm9sbG93aW5nIHBsYW4/DQoNCi0gZHJvcCAqX3NhZmUo
KSB2YXJpYW50cywgc3dpdGNoIHRoZSAibm9ybWFsIiBvbmVzIHRvICJzYWZlIiBzZW1hbnRp
Y3MuDQotIG1ha2UgYWxsIGludGVyZmFjZXMgcmV0dXJuIGEgYm9vbCAodHJ1ZSA9PSBzdWNj
ZXNzLCBmYWxzZSA9PSBmYWlsdXJlKQ0KLSBzd2l0Y2ggYWxsIGludGVyZmFjZXMgdG8gdXNl
IDY0LWJpdCB2YWx1ZXMsIGRyb3AgdGhlIDMyLWJpdCBsb3cvaGlnaA0KICAgc3BsaXQgdmFy
aWFudHMNCi0gdXNlIGFsd2F5c19pbmxpbmUgZnVuY3Rpb25zIGZvciBhbGwgbG9jYWwgTVNS
IGFjY2Vzc29ycw0KDQpUaGlzIHdpbGwgcmVzdWx0IGluIHJkbXNyKCksIHdybXNyKCkgYW5k
IHdybXNybnMoKSBhcyB0aGUgb25seSBhdmFpbGFibGUNCk1TUiBhY2Nlc3MgZnVuY3Rpb25z
IChwbHVzIHRoZSByZWxhdGVkICpfb25fY3B1W3NdKCkgb25lcykuDQoNCg0KSnVlcmdlbg0K

--------------xqV4SofOq8n9i0M2OANdlkJj
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------xqV4SofOq8n9i0M2OANdlkJj--

--------------MkMxazCF9eScsL1LcWp4rGxE--

--------------0VbizIsoaPic0Srt4Z20cgX7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnmKNgFAwAAAAAACgkQsN6d1ii/Ey9W
nQf/a8KCCCnhL59crmzgb9E3zj7DudGcc4GmDui6Rx3AJ7o8Gy/7WyHGvFccmZJmyxsqGWaw843/
AeploPO7UpLkhrn05bh7jmPhsvEJ5UgNJQ2olAyBQsQUwCuGjmLdpMN5ToEXWFquvT7olB2a14NF
XN+cStYh/rYCxlhPipnrQFjvmVeMeoQ5IIrnnC0ekxa4zvs4iBYVhcEeykHGUhGJD2w8mIVn73Z8
GOREY0UyH0taMIDwf7hk+Dqc+YTREqOxjE2Fa0vgeLmNbdgK2vwyfp22VQsS9dTQO9qxmeTMo+W5
CJu0KpUG/duVoJIIF3GVfQ6/1JDODJaE4RXb7TU9sA==
=1QUQ
-----END PGP SIGNATURE-----

--------------0VbizIsoaPic0Srt4Z20cgX7--
