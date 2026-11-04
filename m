Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819085;
	b=1uda6wcE5VOfCguHLZa61/POKhBliFQjtGWXLiufDXJt5b7qQV8jfqwFWsCJQVOOPNWU
	 eELxiym9JqxpNqh4C81ry/FRxzMrLRetG9junFgRKfxYOD+ApASAJP4hoQl1xeeE0kCPj
	 4FX5ZGSB9Ip2AnhlMogJI6Uw3Ym5f608MWI04Q8+orT7l0pl8AUHS4yq2HsDphMFCZNRK
	 NLOhUbwci2SV7zGIaKBj67Ndmw6t0P7zw1ANDhbXaFB0JpcGiEc77JCoEU3zH23ZGe/wC
	 CcCFFy9eWdS1bRuMESinF/zRAzUwhcSEPOLXf5yjOcidPNPUWoUYgJLREkJhL7hkEwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c5QVoU04O7TgV4pbEEAFRUkhl/HFKJVrLhXgJxcJ7SQ=;
	b=Wfe8PKSpVp2/myBRN5AX9EiGJkh98tU9VHPV8WCfcaG5aR4lKITwd30uwgMWekDCr9VW
	 yreQLcVTMjg2ni98yVauTzjXLQVM6ywWOjr6Jq6S6ioVZytLyhgygAsqXfKTc9nPCm6il
	 JRQf8msvKA0fVAF3IGwhwMVdLkLkful9D4/0VKzUuVF4p9EqfeGVneAqGcwLLjRtpYQI4
	 jDZHmXukgipdZnJxtRJuKUvcgpyU4y1vgzy/PugQ5qk3z7RNmafEkQkpnhScZc6iM2KH8
	 7v5gDZb5HoOLAa74O4Tlgv5Og7KsdKrjEQstxzur98ri4WqEKoDRnv1Os81Q5INqaYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYRFCYnz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518D606D807
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYRFCYnz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4191F0093A;
	Wed,  4 Nov 2026 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819085;
	bh=c5QVoU04O7TgV4pbEEAFRUkhl/HFKJVrLhXgJxcJ7SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYRFCYnz3GD+vxMeb4GUf64dajp8d9Ke7modb9JIFc2G0rwQ+UkhheFqTHBY7nMCO
	 /rRIzBFJdWsiS+DVJo2AvXZkeSoeIc9WepUPFyQc7GYYNb+8a1N8GaiZ8SniOQpFq2
	 Bqmqa5bmoMKBJEVayBaV58ogMI1VUBiNmWpCYP7KGEZgrPn/IRSBUpb+Wzld94NU9b
	 CHEd9QgTcCKrSMJE6Z9fagtxN+6+6Qh7lHvFpK/50Wluf1J9CU9belST+6ui4+wYiE
	 zQb8Gv0FQvvSgPp1xbWLMKpgWBtgbzVG2oohZznSahDhVyJxH12/4sU0/phedc3C/K
	 KsbdXZ0Ec5TTg==
Message-ID: <sashiko-outbox-197913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf alpha: Decode ProfileMe raw samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-perf-alpha-profileme-v4-1-1771ea02950e@gmail.com>
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
 <20261104-perf-alpha-profileme-v4-1-1771ea02950e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:04:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha cpu PMU attaches struct alpha_profileme_sample to each
> ProfileMe sample as PERF_SAMPLE_RAW data: the profiled instruction's
> PMPC along with the I_STAT and PCTR_CTL status that says what happened
> to it.
>=20
> Decode it in perf report -D and perf script -D the way AMD IBS raw data
> is decoded, naming the trap from TRAP_TYPE when TRP is set and from the
> PALcode entry offset in PMPC for redirect traps, which TRAP_TYPE does
> not report. TRP is ignored for an instruction killed before it was
> mapped, as an EV7 leaves it stale there. The payload is copied out of
> the sample and converted from little endian, so that it decodes on
> strict-alignment and big-endian hosts too.
>=20
> Copy the uapi header that defines the struct into tools/arch and add it
> to check-headers.sh.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-perf-alpha=
-profileme-v4-0-1771ea02950e@gmail.com?part=3D1

