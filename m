Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035EA33E346
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693463; cv=none; b=lZzBOjHdt09qQlxRrT4YIe5U72+q1x0qS2Du9krtFrkLwF/J9/2Tlx1JUeoTQ5TCo/bIMualPdFiF0mbQh5zAaz+eqjgSUfez16RKwNexHHcoUPHJ2IGdTpV6hT+B/RvNh39brqZp6njFvqzZ7U1oP7hVuE6/TKAWim7nKY9OPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693463; c=relaxed/simple;
	bh=es9kwOOy8zXVFc3qHPPkwwWVdfhBVlN+tdnG7cvOxRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RY3OlTmqeBS6TRLyuaERu2hYfa6fKlreOpjg688WCzr6bODE4o20pIzrVx6PUjIXpfGOGfLyN/cZWt3XAoFujE02snMzsTpxIo3WklH7VgqgXM6s3N9E+DY5I/KGqrDX6YgCbnGy3AAz7zm4ZcLB7yqoKZLcuQHUW2renRNBvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TfOPgijx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TfOPgijx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso4124684a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776693460; x=1777298260; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=es9kwOOy8zXVFc3qHPPkwwWVdfhBVlN+tdnG7cvOxRg=;
        b=TfOPgijxiZrue4BtZvGQaMyWV8SYQatCLxFFAveqd0MNqvpv0+pPgFGVa0UGbHW8Tu
         vLGgSkhQCF8bpaiNyOBUiSBiF4fgIIZklHzTIG7sZkz1Sn8kQCf+TGdOWrx/rPCod0y1
         f30I120T1sNGTvK/9obyDxVVdzti5cx1F3LtEtgXhOlTMhQ59rIw3fR9heXy/sc9fwx7
         EqjHk1uYT1e+nx8u/8PlTIQjaiq29etmLIDvKCAQ1XQ43YIGGQF9ehl+D8VW6hbXxRNR
         L0FvNgMHkoMTvACbKlSENprxRSJaipv4ivUiA0kOdl2n/QAfPkmuEpBkTqX9FMKJzMD4
         OzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693460; x=1777298260;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=es9kwOOy8zXVFc3qHPPkwwWVdfhBVlN+tdnG7cvOxRg=;
        b=JrZBVbvx3MzcmfSy5Er+aOFS1RwPAxMrpmFTLjBjnmcbPJ/u1ORMBb1XLNgYARCW5Z
         ab354iV/cUODCEeJ7+e1BGay3Eb7pX+j3ZJ9blFh9xgzgfrKXFQMni0vR6ZnOWMSkyBi
         d1toR1BN9jvR2vqnULsLJA15/EQ/KQcM9E+mVhXjKCahj2zkdbUTfa1rXXr0pyMXGB+x
         8lhxYkgpJQTLvxRnAbBXMI3dM9CKrrl4R91oBTK/I3eZqgLrzFXKQxK7WpUkxw6hD78z
         7iqe1joGSwyWx0nlKX93nIbnA5wTIY7MXzJLMsFMpWB5A6MYgRz2cE328vrWqNyHYR4d
         WAtw==
X-Forwarded-Encrypted: i=1; AFNElJ92ZX0PD38+rfJUwKKGDhj/jKmsK92ASLlOthmrjmFYgDa/BvVnAQKZxoutTcNwYH6gje8aPsl/+Jhukiz2XDN0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2U6algxoy4rAaag7OPDJPGVFSvEF2Yoqo+pOaZqXx42HkyHqy
	mtKU5chvGp2sdvGfYkOl6IB/jsBWVUrAHwdBXJbP2XB/DFXo/4bcZz3NN5VQAt99N6E=
X-Gm-Gg: AeBDiesuF8bkH6ZvnIqNMKr788Q4/1UgX2/NjvIhPqrjW6Eu61wwyi7OqjB0Cx/8uMh
	yWGBSbmEzNqPUbbmik33lga3tU6igAD+L3Ya8eK8a2OOnCz7b1pJT2Ic1qY8cFLtXJhfMhblVVU
	j0a5FeOLAGKXfFnMehOd5pw5G9JmU5hgKutDFYs/ZL3M330e+O7FwHlRohRfJvXDsmRXx48Oxxh
	J3dF3UM9/ac3kTi+Glc7VruUmEgWLlS5AZ9P3QMrxpx7cFRlW+FkZ6Keqt+1431pypYloABC1Zw
	1TFDpYDE+ZhnJsG+/KM7NJbJ2V4Nvd0LK1fFgdql5VZa/5W7DDZhTYZQMnQZN8GETNOJ1CEQjqQ
	xnsBprwIYnkQTnw3PxiwDC3JcyPEpWwOJO8tRUf/oypbv0SdmZXC7X843LKqHap1viJoKf62HKj
	LUtkVELacQ4fE7fNKB7wuF2ojdd4scKyH/jvXx28E3HzSS1/Ifx2usNzfVN87fv6V59GjSdsyie
	LqpXQ/7A7+vrQTvX13s5YjYNoHl9AE5GmLDB/8qNw60CoX62ODCgCWdjWMdZJSDxnYv/oY96JQ=
X-Received: by 2002:a05:6402:239c:b0:674:25d1:7258 with SMTP id 4fb4d7f45d1cf-67425d174famr2988112a12.28.1776693460278;
        Mon, 20 Apr 2026 06:57:40 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d69708sm2110989a12.28.2026.04.20.06.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 06:57:39 -0700 (PDT)
Message-ID: <a8d14e6d-547b-47f5-bfdf-aa607bfe1b38@suse.com>
Date: Mon, 20 Apr 2026 15:57:39 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>
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
 <aeYr0dMxDs7-2VzO@google.com>
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
In-Reply-To: <aeYr0dMxDs7-2VzO@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qkRgYGuMU9s6dSA0mC8OagZz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qkRgYGuMU9s6dSA0mC8OagZz
Content-Type: multipart/mixed; boundary="------------qNLpsYUzTC9fAahIaFxQHirx";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <a8d14e6d-547b-47f5-bfdf-aa607bfe1b38@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
 <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
 <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com>
 <20260420131020.GI3102624@noisy.programming.kicks-ass.net>
 <aeYr0dMxDs7-2VzO@google.com>
In-Reply-To: <aeYr0dMxDs7-2VzO@google.com>

--------------qNLpsYUzTC9fAahIaFxQHirx
Content-Type: multipart/mixed; boundary="------------iit8cTwJhh9OGfv37zZnsYec"

--------------iit8cTwJhh9OGfv37zZnsYec
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjYgMTU6MzYsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIE1v
biwgQXByIDIwLCAyMDI2LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+IE9uIE1vbiwgQXBy
IDIwLCAyMDI2IGF0IDAzOjAxOjMxUE0gKzAyMDAsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+
Pj4gT24gMjAuMDQuMjYgMTQ6MzMsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+PiBUaGUg
b25seSBpbnRlcmVzdGluZyBxdWVzdGlvbiBpcyB3aGF0IHRvIGRvIHdpdGggdGhlICdzYWZl
JyBhc3BlY3QuIFRoZQ0KPj4+PiBpbnN0cnVjdGlvbiB0YWtlcyBhIGZhdWx0LCB3ZSBkbyB0
aGUgZXh0YWJsZSwgYnV0IHJkbXNyKCkgYWJvdmUgYWxyZWFkeQ0KPj4+PiBoYXMgYSByZXR1
cm4gdmFsdWUsIHNvIHRoYXQgY2FuJ3QgYmUgdXNlZC4NCj4+Pj4NCj4+Pj4gT25lIG9wdGlv
biBpcyB0bywgbGlrZSB1YWNjZXNzIGFuZCB0aGUgcHJvcG9zZWQgb3ZlcmZsb3csIGlzIHRv
IHVzZQ0KPj4+PiBsYWJlbHMgbGlrZToNCj4+Pj4NCj4+Pj4gCXZhbCA9IHJkbXNyKG1zciwg
bGFiZWwpOw0KPj4+Pg0KPj4+PiBBbmQgdGhlbiwgZXZlbiB0aG91Z2ggdGhlIHdybXNyKigp
IGZ1bmN0aW9ucyBoYXZlIHRoZSByZXR1cm4gYXZhaWxhYmxlLA0KPj4+PiBkbyB3ZSB3YW50
IHRvIGJlIGNvbnNpc3RlbnQgYW5kIGRvOg0KPj4+Pg0KPj4+PiAJd3Jtc3IobXNyLCB2YWws
IGxhYmVsKTsNCj4+Pj4gCXdybXNybnMobXNyLCB2YWwsIGxhYmVsKTsNCj4+Pj4NCj4+Pj4g
cmF0aGVyIHRoYW4gYmUgaW5jb25zaXN0ZW50IGFuZCBoYXZlIHRoZW0gaGF2ZSBhIGJvb2xl
YW4gcmV0dXJuIGZvcg0KPj4+PiBzdWNjZXNzLg0KPj4+Pg0KPj4+PiBXaGF0IGFtIEkgbWlz
c2luZz8NCj4+Pg0KPj4+IEkgbGlrZSB0aGUgaWRlYSB0byB1c2UgYSBsYWJlbCwgYnV0IHRo
aXMgd291bGQgcmVzdWx0IGluIHRoZSBuZWVkIHRvIHVzZQ0KPj4+IG1hY3JvcyBpbnN0ZWFk
IG9mIGZ1bmN0aW9ucy4gU28gdGhpcyBpcyB0cmFkaW5nIG9uZSBhc3BlY3QgYWdhaW5zdCBh
bm90aGVyLg0KPj4+IEknbSBub3Qgc3VyZSB3aGljaCBpcyB0aGUgYmV0dGVyIG9uZSBoZXJl
Lg0KPj4+DQo+Pj4gQW4gYWx0ZXJuYXRpdmUgbWlnaHQgYmUgdG8gc3dpdGNoIHJkbXNyKCkg
dG8gdGhlIGludGVyZmFjZSB1c2VkIGJ5IHJkbXNyX3NhZmUoKSwNCj4+PiBpLmUuIGxldCBh
bGwgdGhlIGFjY2Vzc29ycyByZXR1cm4gYSBib29sIGZvciBzdWNjZXNzL2ZhaWx1cmUgYW5k
IHVzZSBhIHBvaW50ZXINCj4+PiBmb3IgdGhlIE1TUiB2YWx1ZSBpbiByZG1zcigpLg0KPj4N
Cj4+IFllcywgZWl0aGVyIHdheSBhcm91bmQgd29ya3MuIFBlcmhhcHMgdGhhdCBpcyAnYmV0
dGVyJyBiZWNhdXNlIG1vc3RseSB3ZQ0KPj4gZG9uJ3QgY2FyZSBhYm91dCB0aGUgZmF1bHRz
IHNpbmNlIHdlJ3ZlIGNoZWNrZWQgdGhlICdmZWF0dXJlJyBlYXJsaWVyLg0KPj4NCj4+IEl0
cyBqdXN0IGluY29udmVuaWVudCB0byBoYXZlIHJldHVybiBpbiBhcmd1bWVudCBjcnVkLCBi
dXQgd2hhdGV2ZXIgOy0pDQo+IA0KPiBXaHkgbm90IGRvIGJvdGg/ICBUaGVyZSBhcmUgZGVm
aW5pdGVseSBmbG93cyB3aGVyZSBvbmUgaXMgb2J2aW91c2x5IG1vcmUgcmVhZGFibGUNCj4g
dGhhbiB0aGUgdGhlIG90aGVyLiAgRS5nLiBpZiB0aGUgUkRNU1IgaXMgYmVpbmcgZmVkIHJp
Z2h0IGJhY2sgaW50byBhIFdSTVNSLCB0aGUNCj4gb3V0LXBhcmFtIHZlcnNpb24gcmVxdWly
ZXMgYSBsb2NhbCB2YXJpYWJsZS4gIEFuZCBpdCBjYW4gYmUgdmlzdWFsbHkgamFycmluZyBp
Zg0KPiB0aGUgc3Vycm91bmRpbmcgY29kZSBpcyBhIGJ1bmNoIG9mICJ2YWwgPSB4eXoiIGV4
cHJlc3Npb25zLg0KDQpJIGxvb2tlZCB0aHJvdWdoIG15IHNlYXJjaCByZXN1bHRzIHJlZ2Fy
ZGluZyB3cm1zcnEoKSBhbmQgcmRtc3JxKCkgdXNlIGNhc2VzIGFuZA0KSSBjb3VsZG4ndCBm
aW5kIHN1Y2ggYW4gaW5zdGFuY2UuIEJ1dCBtYXliZSBJIGhhdmUgb3Zlcmxvb2tlZCBpdCBv
ciB5b3UgaGF2ZQ0Kc29tZSBwYXRjaCBwZW5kaW5nIHVzaW5nIHRoaXMgcGF0dGVybj8NCg0K
PiBPbiB0aGUgb3RoZXIgaGFuZCwgdGhlIG91dHBhcmFtIHdpdGggYSAwLy1lcnJubyByZXR1
cm4gY2FuIGJlIHZlcnkgdXNlZnVsIHRvbywNCj4gZS5nLiB3aGVuIHdyYXBwaW5nIHRoZSBS
RE1TUiBpbiBhIG11bHRpLWV4cHJlc3Npb24gaWYtc3RhdGVtZW50Og0KPiANCj4gCWlmIChy
ZG1zcnFfc2FmZShNU1JfSUEzMl9DUl9QQVQsICZob3N0X3BhdCkgfHwNCj4gCSAgICAoaG9z
dF9wYXQgJiBHRU5NQVNLKDIsIDApKSAhPSA2KSB7DQo+IA0KPiBBcyBpdCBhdm9pZHMgaGF2
aW5nIHRvIGFzc2lnbiB3aXRoICc9JyBpbiB0aGUgaWYtc3RhdGVtZW50LCBhbmQgYXZvaWRz
IGhhdmluZyB0bw0KPiBkZWZpbmUgYSBsYWJlbC4NCj4gDQo+IEl0IHdvdWxkIGJlIHRyaXZp
YWwgdG8gYWRkIGEgd3JhcHBlciBhcm91bmQgdGhlIGxhYmVsIHZlcnNpb24sIHRoZSBoYXJk
IHBhcnQgaXMNCj4ganVzdCB0aGUgbmFtaW5nIDotKQ0KDQpJbmRlZWQsIG5hbWluZyBpcyBo
YXJkLg0KDQoNCkp1ZXJnZW4NCg==
--------------iit8cTwJhh9OGfv37zZnsYec
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------iit8cTwJhh9OGfv37zZnsYec--

--------------qNLpsYUzTC9fAahIaFxQHirx--

--------------qkRgYGuMU9s6dSA0mC8OagZz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnmMNMFAwAAAAAACgkQsN6d1ii/Ey/z
gggAn9QvUqxLiWKJf+030iuDaYeiTzActlSIw3CrW4d84Qpf9PrAACbO65Yza0/m26XIGRjtqUrJ
puMQgK9ldUBniMk6JzUGYLvJ8zoEtVaPlIj1+XpzDiHgVB3LDe2WAJc5wwPUH1g8/X47ExsyQog1
mr2MojMZUqAPBBuCx/TJ0qf6Zyl80ImVNA6QSXjX7DR56v6jVeIA6Cits3nFVOiFKX9dqzHHK/Uu
9i2cDIbVY1xK9mbPY5OfQ6Xh3e6BR1Tppq5FGWSa7m2XFR2G4i1abVelWGU1YJ3BtFfptc8AnM03
hYuUf0l/Yl5k2FtcIYu5Zao84IOZk1HtlQ0PN56BXg==
=pH5W
-----END PGP SIGNATURE-----

--------------qkRgYGuMU9s6dSA0mC8OagZz--
