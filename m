Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1D2D73B8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928999; cv=none; b=Asl6yRLwhsh0GwOptIJ6vlz54govIvmGDYU7TabLtIlqCHgBer4Ny1tck37hONIXVqCL6fZqPgsgBLn/BDNTeMB+X0fVvnQvuAGqi2+3H3LHtYCOuiQ0rTmS4ueyW2VoIIFrTAVC8YQ0Aaly2lF3PCC/WSbyzZnIjA4BERSwCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928999; c=relaxed/simple;
	bh=5iDYgsEI6x9K0CQwOkSD976CSBDVrVOPevs8SQj5l94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EafiV94L0pex7omVOSV8P0fnHR5LIOWDWgxIbuqp/GOkGvcZw39eIjVNtLStXqz22m5e6T1lMPt72PimJx2dcMwcApr1mAIGEe3/rCVbh2SvVD5uEQjnZjaclp9nNKzuBlMVmEKrt+02f3uLxrzpgXXW91Vm4AYdPLM3U6tC5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fjbb9dNJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fjbb9dNJ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b941762394aso868474166b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776928996; x=1777533796; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5iDYgsEI6x9K0CQwOkSD976CSBDVrVOPevs8SQj5l94=;
        b=Fjbb9dNJd1wHe3dwhJKSE9uexPWuzd40C9PclAj5NBpBZUlWFQ4uTIyhImgAU9CKjV
         JPqmRZ63NF5JHoH6mufidmgR47Jbb1W4mNgRR0SowMcNJKjDVgn+7/HV6VSjaaCI3Z8r
         WMyNbuoeQgfgQmYnNZ1uHf89NvxMF7DBPcgAFkvf1S/90jZtETQzdOAFMQhaYwqnOY9O
         HP8mmxGrDAnemAAE9HMAAqmKPgDV48hqE52SwQZoc7ZKkFH7bIoTDixCpAgYgVoMqFV/
         XMDjwfa0cbJO9HcuyRDNrwSeuPiuyQv1vKXcUBtCh8d4u5fbDPQQsnMCkQSnlANUfgDO
         hWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928996; x=1777533796;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iDYgsEI6x9K0CQwOkSD976CSBDVrVOPevs8SQj5l94=;
        b=ca1EZv3nfST/EaPH9YBkF+53ADJs7uh/iN6FDyyuFRqY+vPyqlhSUl0A8smDwhJolG
         KFjJ4+vjYzKnVCFVHKWKFkzjCgMCcLMnPa0xa0IYSRuxwIQycduxwQrZjmH7gCKYBL3V
         Y9jup3RNvj2LocqPAz59dKDJ+PcJcz/8JP3JFQRNmWIws2ORvEH6GBFSs0AGtSlwBr17
         i7EyzKMpevOFTqUW1iAUhdZ8MxGQFAjirYn4fkdXagYemMlGejvS3C4jtN40iX7OFs5P
         DX0d0vo6oA1SLAJ9COL0ayYbUWHBRY7zJk1aavgdS1W05lEmDpBNMrk9TD/Ekdu144Ye
         GnQw==
X-Forwarded-Encrypted: i=1; AFNElJ+87v6DL5HulY7enXR/WEqjk9vT2ni+NQzMPSxEGwDIaNi6/SPxGa/r35DxI9Ql1yMVK5UHxroF18FwDEIv9YJw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvn3eAHrwLvrMYZASwyD3JuS/jBNUR7wTNdtlOF/x93agU3vmp
	Ry/sGSItkFM8zILnRpJOvrziFLqs4gXNvRaN1pO/9WQPHLhuZYPh3P5YRGr9Hp14Uhw=
X-Gm-Gg: AeBDietfUvGBM15Ifh4B1NW9ema+f7WraD+7ucwb+K7v2EOvn3AsTjOc3ys5nmFwhSf
	5qMVGkedjAWvSeYAsFJWyQPtaYyboVjE1KKsnIMESJIttkCq6y7vAxTXTtuWI02ZOzfBTvyKLDK
	jPscmtY5sOugXQV70lVMC27V0sxbUceojGgwtQfeCOlmzOT6Ly5hRr7FniqMxEHs9jUjizfKixj
	Hqi6u3odtUzIYOfO+pCxVBfUJ3Yu7mWUK6OO3PpUxEB7NlAnJe7Z4lf9sdNzuksxfpgxPgfk2c5
	NTXOslEhuAcBvSRHcIdYMDSskI0b5SS91m2MAy2C9CHcxS0pRANVQI4Kc7ucjIPc+nAjWGIO7IF
	kaIB1GUFxRpb42azHNcgfsw+Pq12NqVNLQfIyWKNgy7gJteRvomifqXYptiqFelSQfvCLf6a9qP
	edIYqCWlBLjcTgwMYFA+cCT4xwRdhR29ft3dYUzd3RY3LtXrGOjh9864TnR5r00efj363oH7uWP
	DrjMPVacPs60mSeCxxijIxkpPmSHfCcrvUby5WpuY0LjEv4lttoR2z0St0g0DlbrFyIJSYMz1k=
X-Received: by 2002:a17:907:7247:b0:baa:1db1:ef9b with SMTP id a640c23a62f3a-baa1db1efb4mr510295166b.18.1776928995806;
        Thu, 23 Apr 2026 00:23:15 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba5498b3ddesm556616566b.22.2026.04.23.00.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:23:15 -0700 (PDT)
Message-ID: <80d7c8c7-d61f-42c5-827a-9f52b91c473e@suse.com>
Date: Thu, 23 Apr 2026 09:23:14 +0200
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
 <0f0e5ba5-e6af-45ca-98b8-ea3bcbcede59@suse.com> <aekfoxmXbsvYn5eB@google.com>
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
In-Reply-To: <aekfoxmXbsvYn5eB@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9DGmktNXJ0o2SoQi6hR6TVrc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9DGmktNXJ0o2SoQi6hR6TVrc
Content-Type: multipart/mixed; boundary="------------rdEp0i3MuRhLdtqw14JgG0bJ";
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
Message-ID: <80d7c8c7-d61f-42c5-827a-9f52b91c473e@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <20260420114117.GC3102924@noisy.programming.kicks-ass.net>
 <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com> <aeYty5kU8Rp44USr@google.com>
 <0f0e5ba5-e6af-45ca-98b8-ea3bcbcede59@suse.com> <aekfoxmXbsvYn5eB@google.com>
In-Reply-To: <aekfoxmXbsvYn5eB@google.com>

--------------rdEp0i3MuRhLdtqw14JgG0bJ
Content-Type: multipart/mixed; boundary="------------yfQNayR85MOEyy3V0qwq6OuG"

--------------yfQNayR85MOEyy3V0qwq6OuG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDQuMjYgMjE6MjEsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIFdl
ZCwgQXByIDIyLCAyMDI2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMjAuMDQuMjYg
MTU6NDQsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+Pj4gT24gTW9uLCBBcHIgMjAs
IDIwMjYsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+Pj4+IE9uIDIwLjA0LjI2IDEzOjQxLCBQ
ZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgQXByIDIwLCAyMDI2IGF0IDAx
OjM1OjEyUE0gKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+Pj4+IE9uIE1vbiwg
QXByIDIwLCAyMDI2IGF0IDExOjE2OjI4QU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6
DQo+Pj4+Pj4NCj4+Pj4+Pj4gLSBVc2UgZnVuY3Rpb25zIGluc3RlYWQgb2YgbWFjcm9zIGZv
ciBhY2Nlc3NpbmcgTVNScywgd2hpY2ggd2lsbCBkcm9wDQo+Pj4+Pj4+ICAgICAgbW9kaWZ5
aW5nIHZhcmlhYmxlcyBwYXNzZWQgYXMgYSBwYXJhbWV0ZXIuDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IC0gRWxpbWluYXRlIG11bHRpcGxlIGFjY2Vzc29ycyBkb2luZyBleGFjdGx5IHRoZSBzYW1l
IHRoaW5nIChlLmcuDQo+Pj4+Pj4+ICAgICAgcmRtc3JsKCkgYW5kIHJkbXNycSgpKS4NCj4+
Pj4+Pg0KPj4+Pj4+IFNvIGZhciBzbyBzYW5lLg0KPj4+Pj4+DQo+Pj4+Pj4+IC0gSW5zdGVh
ZCBvZiBoYXZpbmcgZnVuY3Rpb24gbmFtZXMgYmFzZWQgb24gdGhlIHVuZGVybHlpbmcgaW5z
dHJ1Y3Rpb24NCj4+Pj4+Pj4gICAgICBtbmVtb25pY3MsIGhhdmUgZnVuY3Rpb25zIG9mIGEg
Y29tbW9uIG5hbWUgc3BhY2UgKG1zcl8qKCkpLg0KPj4+Pj4+DQo+Pj4+Pj4gTm90IHN1cmUg
b24gdGhpcyBvbmUuIFRoZSB3aG9sZSBtc3Jfe3JlYWQsd3JpdGV9X3tzYWZlLG5vc2VyfSgp
IHRoaW5nIGlzDQo+Pj4+Pj4gYSByb3lhbCBwYWluLiBBbHNvICdub3NlcicgcmVhZHMgdG8g
bWUgYXMgdGhlIG5vdW4gdGhhdCBnb2VzIHdpdGggJ3RvDQo+Pj4+Pj4gbm9zZScgW2hlIHRo
YXQgbm9zZXMgKGFyb3VuZCksIGxpa2UgYmFrZXI6IGhlIHRoYXQgYmFrZXNdLg0KPj4+Pj4+
DQo+Pj4+Pj4gSSB3b3VsZCBtdWNoIHJhdGhlciB3ZSBqdXN0IHN0aWNrIHRvIHRoZSBtbmVt
b25pY3MgaGVyZS4gQWxsIG9mIHRoaXMNCj4+Pj4+PiByZWFsbHkgaXMgYWJvdXQgd3JhcHBp
bmcgc2luZ2xlIGluc3RydWN0aW9ucywgbm8gbmVlZCB0byBtYWtlIGl0IGFuDQo+Pj4+Pj4g
dW5yZWFkYWJsZSBtZXNzLg0KPj4+Pj4NCj4+Pj4+IEFsc28sIHRoZSBfc2FmZSBzdWZmaXgg
c2hvdWxkIGp1c3QgZ28gYXdheS4gQWxsIE1TUiBhY2Nlc3NvcnMgc2hvdWxkIGJlDQo+Pj4+
PiAnc2FmZScuDQo+Pj4+DQo+Pj4+IFRoYXQgd291bGQgYmUgZmluZSBieSBtZSwgYnV0IEkn
ZCBsaWtlIHRvIGhhdmUgc29tZSBjb25maXJtYXRpb24gdGhpcyBpcw0KPj4+PiByZWFsbHkg
dGhlIHJvdXRlIHRvIGdvLg0KPj4+DQo+Pj4gSSBkb24ndCBjYXJlIHdoYXQgdGhlIHN1ZmZp
eCBpcyBjYWxsZWQsIG9yIGlmIHRoZXJlIGlzIGV2ZW4gYSBzdWZmaXgsIGJ1dCB0aGVyZQ0K
Pj4+IG5lZWRzIHRvIGJlIGEgd2F5IGZvciB0aGUgY2FsbGVyIHRvIGNvbW11bmljYXRlIHRo
YXQgaXQgd2FudHMgdG8gaGFuZGxlIGZhdWx0cywNCj4+PiBzbyB0aGF0IHRoZSAiY2FsbGVy
IGlzbid0IGdvaW5nIHRvIGhhbmRsZSBhIGZhdWx0IiBjYXNlIGdlbmVyYXRlcyBhIFdBUk4g
aWYgdGhlDQo+Pj4gYWNjZXNzIGRvZXMgI0dQLg0KPj4NCj4+IFNvIHRoaXMgY2FsbHMgZm9y
IGtlZXBpbmcgdGhlICpfc2FmZSgpIHZhcmlhbnRzIChrZWVwaW5nIHRoZSBuYW1lIG9yIG5v
dCkuDQo+Pg0KPj4gVXNpbmcgdGhlIGxhYmVsIGJhc2VkIGVycm9yIGhhbmRsaW5nIGZvciB0
aG9zZSBpcyBhIG5vLWdvIElNSE8sIGFzIHdlIGFyZQ0KPj4gdHJ5aW5nIHRvIGlubGluZSBh
bGwgTVNSIGFjY2Vzc2VzIGFzIG11Y2ggYXMgcG9zc2libGUgaW4gb3JkZXIgdG8gYXZvaWQN
Cj4+IGNhbGxzIGFuZCB0aGUgYXNzb2NpYXRlZCBwb3NzaWJsZSByZXRwb2xpbmUgc3R1ZmYg
KHJlcXVlc3QgYnkgVGhvbWFzIEdsZWl4bmVyDQo+PiBJSVJDKS4gRG9pbmcgdGhlIFdBUk4g
aW5saW5lIHdpbGwgYmxvYXQgY29kZSBtb3JlIHRoYW4gbmVjZXNzYXJ5LCBlc3BlY2lhbGx5
DQo+PiBhcyB3ZSBhbHJlYWR5IGhhdmUgdGhlIGNlbnRyYWwgV0FSTiB0b2RheSB3aGVuIGZp
eGluZyB1cCB0aGUgI0dQLg0KPiANCj4gSSBkb24ndCBzZWUgd2h5IHRob3NlIHR3byBhcmUg
bXV0dWFsbHkgZXhjbHVzaXZlLiAgS2VlcCB0aGUgV0FSTiBpbiB0aGUgZXhjZXB0aW9uDQo+
IGZpeHVwIGNvZGUsIGFuZCBsZXQgdGhlIGNhbGxlciB1c2UgYSBsYWJlbCAob3Igbm90KS4g
IExhYmVsLWJhc2VkIGVycm9yIGhhbmRsaW5nDQo+IHNob3VsZCBhbGxvdyBmb3IgdGhlIGJl
c3Qgb2YgYm90aCB3b3JsZHMsIGFzIHRoZSBSRE1TUi9XUk1TUiBjYW4gYmUgaW5saW5lZCwg
d2l0aA0KPiB0aGUgKHByZXN1bWFibHkpIHVubGlrZWx5IGVycm9yIHBhdGggYmVpbmcgc2hv
dmVkIGludG8gYW4gb3V0LW9mLWxpbmUsIGNvbGQgcGF0aC4NCg0KSG1tLCB0cnVlLg0KDQo+
IA0KPj4gSW4gb3JkZXIgbm90IGhhdmluZyB0byBtb2RpZnkgdGhlIGxvZ2ljIGZvciBjdXJy
ZW50IHVzZSBjYXNlcyBpdCB3b3VsZCBiZQ0KPj4gYmVzdCB0byBrZWVwIHRoZSBtYWluIGlu
dGVyZmFjZSBvZiB0aGUgKl9zYWZlKCkgZnVuY3Rpb25zIChsZXQgdGhlbSByZXR1cm4NCj4+
IDAvLWVycm5vLCB1c2UgYSBwb2ludGVyIGZvciB0aGUgdmFsdWUgcmV0dXJuZWQgYnkgcmRt
c3Jfc2FmZSgpKS4NCj4+DQo+PiBXZSBjYW4gYWRkIGxhYmVsIHZhcmlhbnRzIG9uIHRvcCB1
c2luZyBtYWNyb3MuDQo+IA0KPiBCdXQgdGhhdCdzIGxpa2VseSBnb2luZyB0byBkZWZlYXQg
dGhlIHZhbHVlIG9mIHVzaW5nIGxhYmVscy4gIE9yIGF0IGxlYXN0IG1ha2UNCj4gaXQgbW9y
ZSBkaWZmaWN1bHQgdG8gZ2VuZXJhdGUgb3B0aW1hbCBjb2RlLg0KDQpPa2F5LCB0aGlzIHdv
dWxkIG1lYW4gdG8gaGF2ZSBhZGRpdGlvbmFsIGlubGluZSBmdW5jdGlvbnMgZm9yIHRoZSAq
X3NhZmUoKQ0KdmFyaWFudHMgYnVpbGRpbmcgb24gdG9wIG9mIHRoZSBsYWJlbCBiYXNlZCBv
bmVzIHdpdGggYSBzaW1pbGFyIGludGVyZmFjZSBhcw0KdG9kYXkuIFRoaXMgd291bGQgYmUg
Zm9yIHRoZSB1c2UgY2FzZXMgd2hlcmUgZWl0aGVyIHRoZSBlcnJvciBpcyBiZWluZyBpZ25v
cmVkLA0Kb3IgdGhlICpfc2FmZSgpIGNhbGwgaXMgdXNlZCBhcyBwYXJ0IG9mIGEgbGFyZ2Vy
IGlmIHN0YXRlbWVudC4NCg0KV291bGQgcHJvYmFibHkgd29yayBmb3IgbWUsIGFzc3VtaW5n
IHRoZSBsYWJlbCBiYXNlZCB2YXJpYW50IHdpdGggcGFyYXZpcnQNCmRvZXNuJ3QgZW5kIHVw
IHRvbyB1Z2x5Lg0KDQoNCkp1ZXJnZW4NCg==
--------------yfQNayR85MOEyy3V0qwq6OuG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------yfQNayR85MOEyy3V0qwq6OuG--

--------------rdEp0i3MuRhLdtqw14JgG0bJ--

--------------9DGmktNXJ0o2SoQi6hR6TVrc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnpyOIFAwAAAAAACgkQsN6d1ii/Ey/I
aAf+JLX0Wvlfw3gpFCRLPmGeVA7LoE/fZYEAQcdWyyzuAvivyUh85C4Gcl8vzWCvt/sEEqAlS6bj
SJebkafPJJyhgqQRCIQBWeNoXpoxgucBQuL+8y0/tt48gLTEVyQH5nP5lM8Hhd6bsEeFe78GZMZA
AjEEV/b2FFnfRrPcgwcicUoCR5ZC1OFhu3gZBlab7+21+u7yISd2YDujCfdy5VIINRN/+j5JLJbJ
qz/yelHGsfyCHNEhZaPyjoWippXH+jOSUd2/dxy1O0hYRjaGSzJsEKaMUTmfZecElAIc7ROcyFdw
nKDtrCIY/TCAloe/2KFrkQY79bmdPeeKGQEOstM72w==
=8bYI
-----END PGP SIGNATURE-----

--------------9DGmktNXJ0o2SoQi6hR6TVrc--
