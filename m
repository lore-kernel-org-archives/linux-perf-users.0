Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFFD3A0E97
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153478; cv=none; b=CKDEHL80ngnFNNfIRej+yNzvIC11XYLDb8ln+qdj498tmcVO/xAJR6NoLnaUjeQlTVBTDx756qK0MSuNOwGFm6URTFFr2xVjsTz3lQBelODr36SCKcT3fl6RchpBHFPeXThxtJMZdYsv1qLjM+1QmtAKW0VTsQDqKOeo8IFnAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153478; c=relaxed/simple;
	bh=q62OT2FhajK+cgTj+r+VdDhfkQVeyYdh7wCJUdQ5gX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aG2ncOp/MZ91zRHQ/Oawki5hSpqLAzMd5loVv+IIwYpOyEd109TSIggx1Ua6ZCD6+2usTlWJyv1O90cwxyFBmu5PV/WvoJX04mLzEASic8a89fNGxUo7tlT/XWXiBp6JIv3PFD3fix7csFfII+0hZxw/TyRCCaVU1IT5zNhfwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gOghoZVY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gOghoZVY"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fe377a217so702085f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787153475; x=1787758275; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q62OT2FhajK+cgTj+r+VdDhfkQVeyYdh7wCJUdQ5gX0=;
        b=gOghoZVYcpS9dBLfVr5AZvdBMsh4fyWKBEhcu9E26vpQZAaJTIfey+y8WpeR3LlJnE
         0K54mKCaXaikRVpgpvXokLhJKr1ynLQEIeS3ElQjtQcx6JezpSUHXqJ5H2Ys1F9JTLyR
         nNc1BqSviLhjTilHxKqguuTu7On/Lb/iBofZuQjwHx7VzndygB0qiLcYFRY8Ncm//VJt
         DH4IoEAmADwZ+DsTqXVivL7+gZPH3HgJwA6pSHJ+5zxSc8uqzbpIHzWNOXK2F7cs1WNS
         j4eyWGtUWTZDoXTJlfdwWhDmtxYOpJPJpYibdEq9uO6ai3e2pjtuMJ/XP8T00cNsVXil
         2w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153475; x=1787758275;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q62OT2FhajK+cgTj+r+VdDhfkQVeyYdh7wCJUdQ5gX0=;
        b=BYUl8hBmzFktHmdGGcyhYbczxAUVHBmPhsuZvzl5+O6rw34lT/uoJ+wsuFas+rI704
         2meVtUonk1fzvZ79xoAiP6Gq07mz4PGPbbGwA71cJkL8woqcTsubD0Zc18WqGEzPjQpS
         ETWRBhnkLIeN0Ct3bN0ArS+22zoU+7zsm1AZuITUbR74cScALpNlJgn0vzVowtSpRthf
         wJFU41sVF8nxNWP6pRkzZ9eoMZVFjtr02xJlv9zluvUN46l1Ke+noTRTSsCu6Ca72g9m
         BZTaZc5QeuSvm3BovW5RqL2e86RmXlX8F+1rahofE3fRI3U8wkHz1ktt+zvwqGu5tugu
         0vKQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRCGNV9+OBS0dobg21lMMAPUVUc6siSC4ATLzZmXH/Rp3Vg9KUQeVkOw7TynsvmA62/I5hdiAgbMHHF9WSzXbf@vger.kernel.org
X-Gm-Message-State: AFuF++mV+ioUOCiBcTNZnA9C8SUaznCKRO7L1EUTsJyWmRa2H2jURx7Q
	nptmmMThQ4hbxKrAuLIvpE42vAR9698UC9FF9fC+35JELTb2EjhMkU3Mejm3mtYE8JM=
X-Gm-Gg: AR+sD131YdcSptQ28IqytfT7KWPTl1O19wav6/TxT39HY8pBL6XPQbvvimlCD1/PhmW
	hI0l9mVi7AuSHgWa4HvziD+LhsGJpXC4oonsuimOrJos3aj0ZijYGRl40ynLF5sBLsPck9N2Odn
	wchNhiFaQu88fjYqo1sm/1fXhNJ1Zxfd4fEGgcFVrvEmIKQjy3Zc+BupGQN62fDxphJZEIL3cfH
	MvSX3wcfxpKDB9irD3Ce1g+3AqtiuJhGqB3+0YFubK9mcjG/+ALlLW+ek6npO74330DVOV93Oe9
	z+Ek7DEieonaXSWmkZAgS7a5Jm2SHSBLs4DnoEmAdfFWe1bpRTkFWg6X2+X8X4wteL33F0IzlRl
	PkJnzrzbxg15sPVd9EJKL71qAANpKFbDNaHp7ynq4/NGyWZXvLGU4WDL7bHVug7Rv7bJg86coPp
	wzB1lNnatMvsPstpms0YSSLBEEkwyKIjpKzyyp1JnDsC3zNbSj+nGIKrVaxZsazhERQGgM77nLB
	3S0iY40RTJXQ+nN2nHJqKtFaVvX8GAspV0fy5Al96xlwOdrdqtqma7AC7sZMow41GNCVbs4P9sV
	xElJIbmY5cgjngDfqt81NjHG
X-Received: by 2002:a05:6000:4b0e:b0:47f:90a4:ff42 with SMTP id ffacd0b85a97d-482b1e8685cmr10441546f8f.5.1787153474730;
        Wed, 19 Aug 2026 08:31:14 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441753sm7081922f8f.5.2026.08.19.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 08:31:14 -0700 (PDT)
Message-ID: <21929230-91a9-4b35-8f66-50c33cf8c2fe@suse.com>
Date: Wed, 19 Aug 2026 17:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] x86/msr: Simplify some rdmsrq() use cases
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-14-jgross@suse.com> <aoXLmJE8ZmQngou8@google.com>
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
In-Reply-To: <aoXLmJE8ZmQngou8@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YCjZWd1BCvvRYa4R3zkNcu0Y"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YCjZWd1BCvvRYa4R3zkNcu0Y
Content-Type: multipart/mixed; boundary="------------02R2NyeMxuffeuFpFogs00uZ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21929230-91a9-4b35-8f66-50c33cf8c2fe@suse.com>
Subject: Re: [PATCH v2 13/13] x86/msr: Simplify some rdmsrq() use cases
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-14-jgross@suse.com> <aoXLmJE8ZmQngou8@google.com>
In-Reply-To: <aoXLmJE8ZmQngou8@google.com>

--------------02R2NyeMxuffeuFpFogs00uZ
Content-Type: multipart/mixed; boundary="------------mBSaqzcxLXXFoe0keeBSpzsC"

--------------mBSaqzcxLXXFoe0keeBSpzsC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDguMjYgMTc6MjgsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIFdl
ZCwgQXVnIDE5LCAyMDI2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gQWZ0ZXIgdGhlIGNv
bnZlcnNpb24gb2YgcmRtc3JxKCkgdG8gYW4gaW5saW5lIGZ1bmN0aW9uIHNvbWUgdXNlIGNh
c2VzDQo+PiBjYW4gYmUgc2ltcGxpZmllZCBieSBkcm9wcGluZyBhbiBpbnRlcm1lZGlhdGUg
dmFyaWFibGUuDQo+IA0KPiAuLi4NCj4gDQo+PiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB1cGRh
dGVfZGVidWdjdGxtc3IodW5zaWduZWQgbG9uZyBkZWJ1Z2N0bG1zcikNCj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20va3ZtX2hvc3QuaA0KPj4gaW5kZXggMjA5NzYwMmEwMGEwLi4yYTY4ZjkzN2MwODAg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+PiAr
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+PiBAQCAtMjQxNSwxMCAr
MjQxNSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrdm1fbG9hZF9sZHQodTE2IHNlbCkNCj4+
ICAgI2lmZGVmIENPTkZJR19YODZfNjQNCj4+ICAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBs
b25nIHJlYWRfbXNyKHVuc2lnbmVkIGxvbmcgbXNyKQ0KPiANCj4gTkFLLCBwbGVhc2UgZm9s
ZCBpbiAiS1ZNOiB4ODY6IFJlbW92ZSB0aGUgS1ZNIHByaXZhdGUgcmVhZF9tc3IoKSBmdW5j
dGlvbiJbKl0uDQo+IEkgdmVyeSBkZWxpYmVyYXRlbHkgd2VudCBvdXQgb2YgbXkgd2F5IHRv
IGxlYXZlIHJlYWRfbXNyKCkgYXMtaXMgd2hlbiBtb3ZpbmcgY29kZQ0KPiBvdXQga3ZtX2hv
c3QuaCwgYXMgSSB3YXMgZXhwZWN0aW5nIHRoZSBNU1IgY2xlYW51cHMgdG8gZWxpbWluYXRl
IGl0IGVudGlyZWx5Lg0KPiANCj4gWypdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI2MDIxODA4MjEzMy40MDA2MDItNS1qZ3Jvc3NAc3VzZS5jb20NCg0KT2theSwgSSdsbCBz
ZW5kIFYzIG9mIHRoaXMgcGF0Y2ggb25seSBhcyBhIHJlcGx5IHRvIFYyIG9mIHRoZSBwYXRj
aC4NCg0KDQpKdWVyZ2VuDQo=
--------------mBSaqzcxLXXFoe0keeBSpzsC
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------mBSaqzcxLXXFoe0keeBSpzsC--

--------------02R2NyeMxuffeuFpFogs00uZ--

--------------YCjZWd1BCvvRYa4R3zkNcu0Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmqFzEEFAwAAAAAACgkQsN6d1ii/Ey9M
nggAiObWt2GpJeRfoQUnbwev7d8ljtUva5lhayTj8VRlMJqARYEqS14k9XqMeeZGP0UZ6wVCXAs8
RDja1Amxmn1eq+QTQCYzlxN2FbyNNDUkBbpuwKNBsAqu5d44ohMDq21hKf8P56gzPZ2n69TdP2VA
04MM4moJFpqCBq1zP2JBRa4ngRwhrZJaqc4l4i2HEaMMKrnO6nQbNtlUuYONHT7AkYWl22jMXaiY
WGovPPC1xv0lR0QQKzuwCaiuRylb/vymjsuqiJg6fdiq1pC3T4jETTWnhlj+2cxp4t6rmVASWvF5
Nuusf/kJ1mjLQxlwP/vCxwvCf0qzPqWVFBuP6yS5fQ==
=Qppd
-----END PGP SIGNATURE-----

--------------YCjZWd1BCvvRYa4R3zkNcu0Y--
