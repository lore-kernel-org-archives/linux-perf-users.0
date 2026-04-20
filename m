Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D6361DDE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693861; cv=none; b=CrRmHEzVni1/yIQkS0aFhRzHqNs0FusXH7LBCwrM9JpFNmD+dLhvI0Bf3UUe0heNwkcGI4FjP1paLMC0/OqUnJfZsWmsjVUaANbRrVa8gjpyHSJ7nbiKZb/KUgU4i5zeW1iK38nmKJW8SLBO6q+AKqHjT4dkk8kyJVJg8gwFhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693861; c=relaxed/simple;
	bh=nx93VBSmO63jrbhqeW2F5Utts4WnkXE+oOajyanvcuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdLqPZmB4hHPtdZkDR5njVK827NIkUJq3eaPfMC+80Y0j7sK6SwM66eZMwpYKbp7qNWes0UlhJSA1Gn4yl72owIiA/V+LEB0lTsyqy5ev+sbA00IMbo9hC/xT0rilsg528oilAQ0c8Dt5odSEwT3kqwUYXRjmn6jfUrDNgpxfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aXAgij4x; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aXAgij4x"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso3356537a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776693858; x=1777298658; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nx93VBSmO63jrbhqeW2F5Utts4WnkXE+oOajyanvcuI=;
        b=aXAgij4xUQmmP9eP/Fdbqj1HDVnctZuBpK5AsK+CtNSP8976ytxbblyCPMP0e9Vgug
         qL7IdiHWMSSfm7dwAAdsIVdz/DFFmiUvBCe+7TLC/BpoAjtH3/G7ciYuiS1LHNbgWhIn
         oHw0ElTY0UbVx1LhMUva++wgZrGQ7nnaQwplSiozaZ8k6kjzSb9UXKRafFpvyL3LxSzS
         51ThQLDHlt8FqYW+T209yHLJLSTYw/bBIp8Hwj8ptLINHK50z0Jc0quMlbed1679WHGV
         okVqP86EpizlFEDKkGEmPPx9MT/vkxRCP/SSkrnXX8fikoQJ5gDmxY3jkYDTF/9yvtYf
         z+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693858; x=1777298658;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nx93VBSmO63jrbhqeW2F5Utts4WnkXE+oOajyanvcuI=;
        b=q56nyik66BvvOp7rC+/h9m7zVy00pLkqiJmHYbBHqDpkkFWgYyRPKnyrRjpVvApBta
         /DWuLKgxgy9pFZke/EHOaA/7ziYZYoqjEs8cn1xw3D7PfBh1kPnruTI26HlmtlDVz2cw
         TUwlF36z/Tv4Yhr50QMKT77mRXqWk9Xqwdf/OM57g6QeyQC8cS56To7ay6VxG8izhpHV
         Smj03KPXHhg0m5MokPRRdl0Sbe/YlUcTw9537uJIee/KUJ4k57DJFzZ7B6UArqH2ZWmv
         Qi/AcrdR9oCCPoPAc4TOfoL7V+wPwOnq7irtgSQYORi589P2iv7jB1JmRfr0E/HwWTOI
         y/3g==
X-Forwarded-Encrypted: i=1; AFNElJ83zpYti23KitlutcIBKmq1HKFmdGCrW8yWZjEudfi/DBWPdwWcUgOEaKCMMOAMyGFi4r7JaNiVgGpgceq/SIwj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvz7TpeubuKNmBSLj/uFlHUB/pqCNjXstPpyMsYXvo1E/Jc5d9
	eKzxtFRIYdTmsd1FkE4OBCLt7DtDqQwET/m2phOVAoOc/SF3I7mxC5YgUhjCSMtBw7U=
X-Gm-Gg: AeBDieugT4doddROUEaA0qq8CUHN9v5TIh3uUsUuD9U/72jS9ybsK1v8PzQc2jVhLzS
	sNaLtSbgB+siOEHjZZ0CJBEJSIHIq4zM9sWuDKyIoqRcQr56Konv9Z0CzG5UliTNlYU+IJ8TCjy
	3UPL7xsk1jMxmJzU+rjdco7lBC4Qphv23GO6pcxgBa3EyOpRRe9Y7ZVU9CEhvJBI3wGqRd252Ji
	49pNvmxh8Gt4mSsNcNHYP4i+OHF7W5N7T2GdLBzx6fiptvwHnMEGLexVLilzL+tIrOK6Hcd072l
	rsHWo7W3IPrSkpeZDu7v/ZRBs2Dn6+45V0Qiqb8uhJddA+PRoGLuD7BjpHFRMRmuKx53uX0tq5X
	Z97LHVHSdxVXMc4kUzufA51YFa0IgKKSs08Wix43QA2UVtqPsvukTjKohCZor/4klLaBXJW0Txf
	2VYvIx8lrTmAP/KfRrTDqOjpwTZ5iN4Bn7gh6DgJpQLvirCcvHHDzvaHE2CAK3SIQLhcl9ByFfZ
	A3/EgAEu7RNIDxylWDT27AuHaFQ9HLz88XEtWuHkUj6SCMvWGozotOVjkJqOvDN
X-Received: by 2002:a05:6402:13cf:b0:672:29e1:94b0 with SMTP id 4fb4d7f45d1cf-672bfdda697mr5808622a12.23.1776693857346;
        Mon, 20 Apr 2026 07:04:17 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe836sm2161959a12.3.2026.04.20.07.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:04:16 -0700 (PDT)
Message-ID: <febe1272-60a6-4f38-95ea-eb7d86c3d34b@suse.com>
Date: Mon, 20 Apr 2026 16:04:16 +0200
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
In-Reply-To: <aeYty5kU8Rp44USr@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wQX4Uaasxnft5XHRjyfGrNC0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wQX4Uaasxnft5XHRjyfGrNC0
Content-Type: multipart/mixed; boundary="------------syaDIDwbliQDDd75HpKDwnof";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
Message-ID: <febe1272-60a6-4f38-95ea-eb7d86c3d34b@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
 <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com> <aeYty5kU8Rp44USr@google.com>
In-Reply-To: <aeYty5kU8Rp44USr@google.com>

--------------syaDIDwbliQDDd75HpKDwnof
Content-Type: multipart/mixed; boundary="------------Xt82n1kD9UPOxKXH1NakIqcL"

--------------Xt82n1kD9UPOxKXH1NakIqcL
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
IHRoZQ0KPiBhY2Nlc3MgZG9lcyAjR1AuDQoNClRoaXMgY291bGQgYmUgaGFuZGxlZCBieSBq
dXN0IHN3aXRjaGluZyBwYXJhbWV0ZXJzOg0KDQpMZXQgcmRtc3IoKSByZXR1cm4gYSB1NjQg
YW5kIHVzZSBhIHBvaW50ZXIgcGFyYW1ldGVyIGZvciAwLy1lcnJuby4gSWYgdGhhdA0KcGFy
YW1ldGVyIGlzIE5VTEwgd2UgY2FuIGRvIHRoZSBXQVJOKCkgb24gZXJyb3IuDQoNCj4gSWYg
d2UgbWFrZSByZG1zcigpIHJldHVybiBhIHU2NCwgdGhlbiB3ZSBjYW4gdmFjYXRlIF9fcmRt
c3IoKSBhbmQgdXNlIHRoYXQgZm9yDQo+IHRoZSB2ZXJzaW9uIHdpdGggYSBsYWJlbC4NCj4g
DQo+IEUuZy4gc29tZXRoaW5nIGxpa2UgdGhpcyBpZiB3ZSBwcm92aWRlIGJvdGggdGhlIG91
dC1wYXJhbSBhbmQgbGFiZWwgdmFyaWFudHM6DQo+IA0KPiBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIHU2NCByZG1zcih1MzIgbXNyKQ0KPiB7DQo+IAk8dGhpcyB2ZXJzaW9uIFdBUk5zIG9u
IGZhdWx0Pg0KPiB9DQo+IA0KPiAjZGVmaW5lIF9fcmRtc3IobXNyLCBsYWJlbCkNCj4gKHsN
Cj4gCXU2NCBfX3ZhbDsNCj4gDQo+IAk8dGhpcyB2ZXJzaW9uIGp1bXBzIHRvIEBsYWJlbCBv
biBmYXVsdD4NCj4gCV9fdmFsOw0KPiB9KQ0KPiANCj4gc3RhdGljIF9fYWx3YXlzX2lubGlu
ZSBpbnQgcmRtc3JfcCh1MzIgbXNyLCB1NjQgKnZhbCkNCj4gew0KPiAJPHRoaXMgdmVyc2lv
biB6ZXJvcyAqdmFsIG9uIGZhdWx0IGFuZCByZXR1cm5zIDAvLWVycm5vPg0KPiB9DQoNClRo
aW5raW5nIG9mIHBhcmF2aXJ0IHN1cHBvcnQgSSdtIG5vdCByZWFsbHkgc3VyZSB0aGUgbGFi
ZWwgdmFyaWFudCBpcw0Kc29tZXRoaW5nIEknZCBsaWtlIHRvIGRvLiBJdCBpcyBwb3NzaWJs
ZSwgYnV0IGl0IHdvdWxkIGNlcnRhaW5seSBub3QgYmUNCm1vcmUgcmVhZGFibGUuIDotKQ0K
DQoNCkp1ZXJnZW4NCg==
--------------Xt82n1kD9UPOxKXH1NakIqcL
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------Xt82n1kD9UPOxKXH1NakIqcL--

--------------syaDIDwbliQDDd75HpKDwnof--

--------------wQX4Uaasxnft5XHRjyfGrNC0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnmMmAFAwAAAAAACgkQsN6d1ii/Ey8R
Xwf8CxVkse4Mkow45IC5150obMPsp98Nx73LMe92lJjJ82VdSuvWwazsEVpNmt2A60NkeGwUQolK
srLTEiX03+hKTb93JVaEQM9FjfWu1aAbqUJC6HuUh2LDu+G2EffclsqtUfeiG7RaHSkF59E+aDOd
9z2YGBPzYUXSAMLHLjpYRl5zILjSJBgRGdEzb59fsRrfw17H3a5R6IKGS2X0yGHD2GPoW4KZ8idr
cugMavWGKMygCu37cyPT14fswHXthqkWCdAncBTQVGFHPRtppmiY1IxMHISgWE8INVVG9xPzCvv0
f7aioAn0RQXbd6dsstUyoHzo9k/Ccemmh39r7PAwPA==
=mOav
-----END PGP SIGNATURE-----

--------------wQX4Uaasxnft5XHRjyfGrNC0--
