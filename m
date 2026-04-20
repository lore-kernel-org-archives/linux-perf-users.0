Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DE39FCA0
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690098; cv=none; b=gvgs2epzhgGxXlRULlOKPy9n17gZo/F7PHXbckJJwPz3bc34DeNe2CFpCXS87V73B+UKC4kwfgQWvyXIzLHhxlY/g1x1QOudBaCTfmOtcruHnh+TAI4b2Zf7xp9tupfmrNUAIvBH3G5QMzC8AhcaYJ4daH5FDRi9tvzwuxYiV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690098; c=relaxed/simple;
	bh=vmkv62D6oTGBXrvR3rCa1yguYNXHbMmwhqsX7yO1xbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9Tc+Woy7xBXkaOTlUQ0TUaJ3cFO5t6vod1t1wRxQ8riV73BeZ8eeEImVffUEczYX9pzqVXNGQVCBWLzcrhF/0Dk+z76lQh/DLA/umKEVXrbdAhh1lqcN2q4RvfVPIu7jYjRtt6q1inGQ5WMTHUIvucn/v7iLO35HYwcRVboBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NQ1+HHbR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NQ1+HHbR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so5298662a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776690095; x=1777294895; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vmkv62D6oTGBXrvR3rCa1yguYNXHbMmwhqsX7yO1xbI=;
        b=NQ1+HHbRYtBFbykYrSa1ESnKU/89iluE8AJgvd4U9emxxQJ7hk6Lzm1oxG/MtDmsRG
         DWc9fpogQPVAz5h6HyvSs5UiUq7UPLeIrJXaU3dGyLh3ljODwHEV237R1f5dIL1y7woi
         mucwO42FLxRViCBLt2qjNFE4WZl6LM+JZMdmZpicnXmhlT3brNGJX8GV7GWI4oKle71B
         HValFoObyIQ5moNShUb/Wlr+XOsMFcw2P7UX7ZsC9/mQda60Sk71l2kb1SFhBkgaNIHV
         64beUVLUQsLZPOHb7WOTQmKLF/Ulgln8T1IqgDEIJ5qrOqxnHh/ncnCaieDMOeEpw25d
         aD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690095; x=1777294895;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmkv62D6oTGBXrvR3rCa1yguYNXHbMmwhqsX7yO1xbI=;
        b=BT36BhKs26PkJ4rus7762PyEv7rrb4GRZnimT+dCE2lCcTTiv4akHORVnBn2jBiZpZ
         FFru8HI/MUaVaUQt3uU1KIC5l691IWyp0Qy0H0iDc9feUr5GM1TbFuP0BVl+2+k1LeGW
         DbM3E2hkzx0JaOGqY9VS9F5/Bpa0BXe44qzwLN3uRP+j/S63g+z8rRL2DQ6CMAkUjwqw
         95xZRDPKfQAtnown2EBFap3bj7x5OlD09hfXT3cA2X6kYuNYbXvofq/En9BL5f0LEYlR
         stVK0Ej1DQAl+PbJTdFZScWhT22lb5h9fTF5NO7ZmJxbLOCm+x8S3JzPqeC9DKMTpXmb
         w3rg==
X-Forwarded-Encrypted: i=1; AFNElJ8BE3Qax4IcCRkpkrwSkJqCMp0mU3v0uxs6s2mt08CfkoUPBzktQkDiKhSiuyiW52h1nsWaij4G2GaibAyWVAkI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Wc4MgoelLICxd1n7TFdx/PPCpEEcJ9/L5r9BRj5I0/mdTxTv
	0K8M4Kue48PjHMBMgxVGeOu8eV8qYBrjtzXAEKFNko2DKBP59WmyAXzBanuAyhFG57I=
X-Gm-Gg: AeBDieu8uzDV+twAAuQ8EPvNYpkB+x/VEpE+yqD6nqCL+ZW4+207/OZCT+HONWA9e4m
	aymWewMdsmja/y3e7bxsAyMTYwIathQvJ6q0pvDtH/BpxOA6qNkFZZPHzihjKptSuvjQMyT5xbS
	bLwXoSLSvMSGlLDj4ApfK0/uXX27aILZPEnNca/vd1z101f0UY+cEYCFLHJZKeTV0V1jtfVwl9y
	eAIUr289OomAwun9fB5ZYit9ZZ/z7XwjbxI2xVgCMAUOchWB0/ndqXQ2v+vPMoKRmHNkH6N9ZdV
	lyAU4qua4nsN4cAQwdZ311s0Czv83VwSJCoQbSZGMhGJsgMZurC/KtwseRg/7ynb5g9cYYcpUKP
	qTKRGlYM7E3A8bngTpPfe04pXnfiZRsJD5zkTNmnSFU7ZzBNqS7VyChkV1ZdWB3E2Mg+zWdgcsE
	Hh09oLVXv1cBvrQOkhURf2hPQK31njQUxieVGiiSnJi8fBgRm4uhRhVIJLyPidWiPVfo6AJtIOD
	usaYtWVm3SKtvUN50W6UghlEWshdztxaiEMFjq7ZO13L1lopO6oyKb4uf+8kz4vqJEek8TVUkg=
X-Received: by 2002:aa7:d388:0:b0:670:7c64:c24d with SMTP id 4fb4d7f45d1cf-672bfd86d7bmr4206125a12.6.1776690092926;
        Mon, 20 Apr 2026 06:01:32 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d51820sm2202238a12.22.2026.04.20.06.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 06:01:32 -0700 (PDT)
Message-ID: <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com>
Date: Mon, 20 Apr 2026 15:01:31 +0200
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
In-Reply-To: <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------p6FNQmMGTKmiOwjc5EcYkjIL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------p6FNQmMGTKmiOwjc5EcYkjIL
Content-Type: multipart/mixed; boundary="------------XT6l56bKS0sbfyLTnZqTkS43";
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
Message-ID: <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
 <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420123352.GH3102624@noisy.programming.kicks-ass.net>

--------------XT6l56bKS0sbfyLTnZqTkS43
Content-Type: multipart/mixed; boundary="------------8ENikmvLPhpK7xOWPzJy4bHi"

--------------8ENikmvLPhpK7xOWPzJy4bHi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjYgMTQ6MzMsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIEFw
ciAyMCwgMjAyNiBhdCAwMTo0OTowMlBNICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
Pj4gT24gMjAuMDQuMjYgMTM6MzUsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+IE9uIE1v
biwgQXByIDIwLCAyMDI2IGF0IDExOjE2OjI4QU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3Jv
dGU6DQo+Pj4NCj4+Pj4gLSBVc2UgZnVuY3Rpb25zIGluc3RlYWQgb2YgbWFjcm9zIGZvciBh
Y2Nlc3NpbmcgTVNScywgd2hpY2ggd2lsbCBkcm9wDQo+Pj4+ICAgICBtb2RpZnlpbmcgdmFy
aWFibGVzIHBhc3NlZCBhcyBhIHBhcmFtZXRlci4NCj4+Pj4NCj4+Pj4gLSBFbGltaW5hdGUg
bXVsdGlwbGUgYWNjZXNzb3JzIGRvaW5nIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgKGUuZy4N
Cj4+Pj4gICAgIHJkbXNybCgpIGFuZCByZG1zcnEoKSkuDQo+Pj4NCj4+PiBTbyBmYXIgc28g
c2FuZS4NCj4+Pg0KPj4+PiAtIEluc3RlYWQgb2YgaGF2aW5nIGZ1bmN0aW9uIG5hbWVzIGJh
c2VkIG9uIHRoZSB1bmRlcmx5aW5nIGluc3RydWN0aW9uDQo+Pj4+ICAgICBtbmVtb25pY3Ms
IGhhdmUgZnVuY3Rpb25zIG9mIGEgY29tbW9uIG5hbWUgc3BhY2UgKG1zcl8qKCkpLg0KPj4+
DQo+Pj4gTm90IHN1cmUgb24gdGhpcyBvbmUuIFRoZSB3aG9sZSBtc3Jfe3JlYWQsd3JpdGV9
X3tzYWZlLG5vc2VyfSgpIHRoaW5nIGlzDQo+Pj4gYSByb3lhbCBwYWluLiBBbHNvICdub3Nl
cicgcmVhZHMgdG8gbWUgYXMgdGhlIG5vdW4gdGhhdCBnb2VzIHdpdGggJ3RvDQo+Pj4gbm9z
ZScgW2hlIHRoYXQgbm9zZXMgKGFyb3VuZCksIGxpa2UgYmFrZXI6IGhlIHRoYXQgYmFrZXNd
Lg0KPj4NCj4+IE5hbWluZyBpcyBoYXJkLiA6LSkNCj4+DQo+PiBXaGF0IGFib3V0IHMvc2Vy
L3N5bmMvIHRoZW4/DQo+Pg0KPj4+IEkgd291bGQgbXVjaCByYXRoZXIgd2UganVzdCBzdGlj
ayB0byB0aGUgbW5lbW9uaWNzIGhlcmUuIEFsbCBvZiB0aGlzDQo+Pj4gcmVhbGx5IGlzIGFi
b3V0IHdyYXBwaW5nIHNpbmdsZSBpbnN0cnVjdGlvbnMsIG5vIG5lZWQgdG8gbWFrZSBpdCBh
bg0KPj4+IHVucmVhZGFibGUgbWVzcy4NCj4+DQo+PiBJJ20gcHJldHR5IHN1cmUgbW9zdCBv
ZiB0aGUgd3Jtc3IqKCkgdXNlIGNhc2VzIGNvdWxkIHN3aXRjaCB0byB0aGUgbm9uDQo+PiBz
ZXJpYWxpemluZyB2YXJpYW50cy4gVGhlIHByb2JsZW0gbm90IG1ha2luZyB0aGUgc2VyaWFs
aXppbmcgYXNwZWN0IHZpc2libGUNCj4+IGluIHRoZSBmdW5jdGlvbiBuYW1lIHdpbGwgcHJv
YmFibHkgcmVzdWx0IGluIG1vc3QgbmV3IGluc3RhbmNlcyBzdGlsbCB1c2luZw0KPj4gdGhl
IHNlcmlhbGl6aW5nIHZhcmlhbnQgaW5zdGVhZCBvZiB0aGUgcHJvYmFibHkgcG9zc2libGUg
bm9uIHNlcmlhbGl6aW5nIG9uZS4NCj4+DQo+PiBNYW55IG9mIHRob3NlIHVzZSBjYXNlcyB3
aWxsIGV2ZW4gc3VmZmVyIG1vcmUsIGFzIHRoZXkgd29uJ3QgdXNlIHRoZQ0KPj4gaW1tZWRp
YXRlIGZvcm0gb2YgV1JNU1JOUyB0aGVuLCB3aGljaCB3b3VsZCB3YXN0ZSB0aGUgYWRkaXRp
b25hbCBiZW5lZml0cyBvZg0KPj4gdGhhdCBpbnN0cnVjdGlvbi4NCj4gDQo+IEknbSBjb25m
dXNlZCwgaWYgd2UgaGF2ZSBhIHdybXNybnMoKSBmdW5jdGlvbiwgdGhhdCBjb3VsZCBzZWUg
aWYgdGhlIG1zcg0KPiBhcmd1bWVudCB3YXMgYSBjb25zdGFudCBhbmQgdXNlIHRoZSBpbW1l
ZGlhdGUgZm9ybSwgbm8/DQo+IA0KPiBUaGF0IGlzLCB3ZSBoYXZlIHRoZSBmb2xsb3dpbmcg
aW5zdHJ1Y3Rpb25zOiBSRE1TUiwgV1JNU1IsIFdSTVNSTlMNCj4gQW5kIHdlIHNob3VsZCBo
YXZlIHRoZSBleGFjdCBzYW1lIGZ1bmN0aW9uczoNCj4gDQo+IAl2YWwgPSByZG1zcihtc3Ip
Ow0KPiAJd3Jtc3IobXNyLCB2YWwpOw0KPiAJd3Jtc3Jucyhtc3IsIHZhbCk7DQoNClBlb3Bs
ZSB0ZW5kIHRvIGNvcHkgc2ltaWxhciBjb2RlLCBtYXliZSB1c2luZyBvbGRlciBrZXJuZWxz
IGFzIHRoZSBzb3VyY2UuDQoNClNvIGV2ZW4gaWYgd3Jtc3JucygpIHdvdWxkIGJlIGZpbmUg
KGFuZCwgcmVzdWx0aW5nIGZyb20gdGhhdCwgYmV0dGVyKSwgdGhleQ0Kd2lsbCBtb3JlIGxp
a2VseSBlbmQgdXAgdXNpbmcgd3Jtc3IoKSBpbnN0ZWFkLg0KDQpVc2luZyBuZXcgZnVuY3Rp
b24gbmFtZXMgaW1wbHlpbmcgdGhlIGV4YWN0IHNlbWFudGljcyAoc2VyaWFsaXppbmcgdnMu
DQpub24tc2VyaWFsaXppbmcpIHdpbGwgbWFrZSBpdCBtb3JlIGxpa2VseSB0aGUgY29ycmVj
dCBvbmUgaXMgYmVpbmcgdXNlZC4NCg0KPiBUaGUgb25seSBpbnRlcmVzdGluZyBxdWVzdGlv
biBpcyB3aGF0IHRvIGRvIHdpdGggdGhlICdzYWZlJyBhc3BlY3QuIFRoZQ0KPiBpbnN0cnVj
dGlvbiB0YWtlcyBhIGZhdWx0LCB3ZSBkbyB0aGUgZXh0YWJsZSwgYnV0IHJkbXNyKCkgYWJv
dmUgYWxyZWFkeQ0KPiBoYXMgYSByZXR1cm4gdmFsdWUsIHNvIHRoYXQgY2FuJ3QgYmUgdXNl
ZC4NCj4gDQo+IE9uZSBvcHRpb24gaXMgdG8sIGxpa2UgdWFjY2VzcyBhbmQgdGhlIHByb3Bv
c2VkIG92ZXJmbG93LCBpcyB0byB1c2UNCj4gbGFiZWxzIGxpa2U6DQo+IA0KPiAJdmFsID0g
cmRtc3IobXNyLCBsYWJlbCk7DQo+IA0KPiBBbmQgdGhlbiwgZXZlbiB0aG91Z2ggdGhlIHdy
bXNyKigpIGZ1bmN0aW9ucyBoYXZlIHRoZSByZXR1cm4gYXZhaWxhYmxlLA0KPiBkbyB3ZSB3
YW50IHRvIGJlIGNvbnNpc3RlbnQgYW5kIGRvOg0KPiANCj4gCXdybXNyKG1zciwgdmFsLCBs
YWJlbCk7DQo+IAl3cm1zcm5zKG1zciwgdmFsLCBsYWJlbCk7DQo+IA0KPiByYXRoZXIgdGhh
biBiZSBpbmNvbnNpc3RlbnQgYW5kIGhhdmUgdGhlbSBoYXZlIGEgYm9vbGVhbiByZXR1cm4g
Zm9yDQo+IHN1Y2Nlc3MuDQo+IA0KPiBXaGF0IGFtIEkgbWlzc2luZz8NCg0KSSBsaWtlIHRo
ZSBpZGVhIHRvIHVzZSBhIGxhYmVsLCBidXQgdGhpcyB3b3VsZCByZXN1bHQgaW4gdGhlIG5l
ZWQgdG8gdXNlDQptYWNyb3MgaW5zdGVhZCBvZiBmdW5jdGlvbnMuIFNvIHRoaXMgaXMgdHJh
ZGluZyBvbmUgYXNwZWN0IGFnYWluc3QgYW5vdGhlci4NCkknbSBub3Qgc3VyZSB3aGljaCBp
cyB0aGUgYmV0dGVyIG9uZSBoZXJlLg0KDQpBbiBhbHRlcm5hdGl2ZSBtaWdodCBiZSB0byBz
d2l0Y2ggcmRtc3IoKSB0byB0aGUgaW50ZXJmYWNlIHVzZWQgYnkgcmRtc3Jfc2FmZSgpLA0K
aS5lLiBsZXQgYWxsIHRoZSBhY2Nlc3NvcnMgcmV0dXJuIGEgYm9vbCBmb3Igc3VjY2Vzcy9m
YWlsdXJlIGFuZCB1c2UgYSBwb2ludGVyDQpmb3IgdGhlIE1TUiB2YWx1ZSBpbiByZG1zcigp
Lg0KDQoNCkp1ZXJnZW4NCg==
--------------8ENikmvLPhpK7xOWPzJy4bHi
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------8ENikmvLPhpK7xOWPzJy4bHi--

--------------XT6l56bKS0sbfyLTnZqTkS43--

--------------p6FNQmMGTKmiOwjc5EcYkjIL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnmI6wFAwAAAAAACgkQsN6d1ii/Ey/S
Cwf/RDrGzF5kwRO/edl8zyH+ZfJmZROG3c6JHRCO2wZKZC1rEemeWNjJ+By+UdHrW1GhOFhf1F9X
8WRAA8gNi5LzlxZ4BzuClpa4wDovDbqDzhNLzuSLbIvpSQt+OHwWn1T833HRvlUlf0eXNlnlmZCp
MrB50BywMahztDHTsQrh0loIedbnTnhgsTuIjz3NSnDwy8rHcZ/AsOS1Vwii6q9SZ5Vf8J9J4+dU
OzTI4YupZ1O0eD5VHZNWmr18r4ltx7wgKKKtLzhKyGZT1pgU3LuLkME/Cduf1XdTpLQw5Qy4e5he
Tx/bvb8fv5NIMIL3j2QhjropGE8DKEQCLJwxFspkKg==
=j2Gq
-----END PGP SIGNATURE-----

--------------p6FNQmMGTKmiOwjc5EcYkjIL--
