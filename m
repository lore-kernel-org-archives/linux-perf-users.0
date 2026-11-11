Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414152;
	b=19lfMruWKsQ0hvUUN96o5JCX7vU96YdfSocarwpErgIkQaiPo8TGUnHdpIkyGv5dFpl7
	 lJmOCWIB/kYzjmWBSbvipAjAhfKPEff7PE8O4Le6eX8IVuyMBw3rzewuNumNQi0JfHfIZ
	 g5neFsvUI7zueM9WUddoD7jLG3FFnLI4qbwc7x31nuf3hdIZ3llVg/G2eet3+60X6JZ7S
	 Oj07rRZVIHg0R2E6znifb7fvqwSgXBBickUgDgu9Im3wnEn/YIvntrP1dxpu/Z/gX2kdV
	 VY3qYAM33HJBIsxX5kdIjnahUTMvUN3XOC2yjJZu22Qje2hvYww0KjMCYMGX+oKQ8SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414152;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vh3kTB4Kmga6SPtQMfjXKGaAG5R6gZqW1rL1ZlChmIE=;
	b=Z/IDDObAfsIMOHQtY1OJEN7BaqodhTBVDojpvG6RagtlqdsDMURlppZ5VdAxYKWhICGN
	 1LuBYAe5cdZ4jxUtsruuloVH4+aDh+6q7SF6IAtQ8gdkNnIXmf1I5GYBdB32HJRX4vUlK
	 qlfmNtzGLc1CobTeR8FJA3/lmwnYguyJJ7/37RCuNpV38B4HK2BnJO68HLO+LvwopmkO4
	 iPFykThIMKAvOx4/b8rI8VHmNn5rkOPlsMG5joNoTj3Rm57i6z8gE+wM6D+Jq5WRneLdz
	 reZUvWNdJsL2pxdwpInUeGLs4PBPtCQv2fWNkaF6EW3FHZeNfTLQqJthTUAnB4kI4AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SsHPd/gj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC5606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsHPd/gj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943541F00A05;
	Wed, 11 Nov 2026 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414151;
	bh=vh3kTB4Kmga6SPtQMfjXKGaAG5R6gZqW1rL1ZlChmIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SsHPd/gji1d+5A/Jzb2QBzs0XNeVwkstumUtXANTAJdcJSMc+hx9MiNSFypJ5oaLo
	 VgiK1jttDM+aulhpDehWc0B02shdP0ooyqUx5agpHkfKnZsB6b4eC8tj5MoXi2B0iw
	 WsRtqtx4DFGuiWYt5YxbExbGm91hKjPdfphqeFLc9QAcsySZ6K8T5QbwMqtg0oF90B
	 bOqkp/hLf7WsB4qXk3tKDuVfUCZzpRiL+PwaCymZ/Byy1JIkiN1ZKkgbRGezUNGsMT
	 DkNBjHV5yELi/nezkM3m2LvbOqkBU5YkA3u3p4+FEG8Qwenulbxwaisgo4B4/FFY40
	 +uZJjiLBwmOVA==
Message-ID: <sashiko-outbox-209276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] perf/x86/rapl: Fix a bug caused by overflow timer
 being calculated using a 200W Max TDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dhruv Gupta" <dhruv.gupta@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111151050.329724-1-dhruv.gupta@amd.com>
References: <20261111151050.329724-1-dhruv.gupta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:22:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] perf/x86/rapl: 64-bit division in rapl_check_hw_unit() breaks
  32-bit builds
--

commit 64815f3ce3036f1ab83ef82a1cc4dd1237aac3f9
Author: Dhruv Gupta <dhruv.gupta@amd.com>

perf/x86/rapl: Fix a bug caused by overflow timer being calculated using a =
200W Max TDP

This commit raises the reference power used to compute the RAPL energy coun=
ter
overflow timer interval from 200W to 1000W and simplifies the interval
calculation in rapl_check_hw_unit().

> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 8ed03c32f5605..43ac9e1c98b45 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -106,6 +106,7 @@ static const char *const rapl_core_domain_name __init=
const =3D "core";
>   */
>  #define RAPL_EVENT_MASK	0xFFULL
>  #define RAPL_CNTR_WIDTH 32
> +#define RAPL_TIMER_REF_WATTS 1000
> =20
>  #define RAPL_EVENT_ATTR_STR(_name, v, str)					\
>  static struct perf_pmu_events_attr event_attr_##v =3D {				\
> @@ -639,16 +640,12 @@ static int rapl_check_hw_unit(void)
> =20
>  	/*
>  	 * Calculate the timer rate:
> -	 * Use reference of 200W for scaling the timeout to avoid counter
> -	 * overflows. 200W =3D 200 Joules/sec
> -	 * Divide interval by 2 to avoid lockstep (2 * 100)
> -	 * if hw unit is 32, then we use 2 ms 1/200/2
> +	 * Use reference of 1000W for scaling the timeout to avoid counter
> +	 * overflows. 1000W =3D 1000 Joules/sec
> +	 * Divide interval by 2 to avoid lockstep (2 * RAPL_TIMER_REF_WATTS)
>  	 */
> -	rapl_timer_ms =3D 2;
> -	if (rapl_pkg_hw_unit[0] < 32) {
> -		rapl_timer_ms =3D (1000 / (2 * 100));
> -		rapl_timer_ms *=3D (1ULL << (32 - rapl_pkg_hw_unit[0] - 1));
> -	}
> +	rapl_timer_ms =3D (1000ULL << (32 - rapl_core_hw_unit)) /
> +		(2 * RAPL_TIMER_REF_WATTS);

[Severity: High]
Does this 64-bit division break 32-bit x86 builds?  Dividing the runtime
64-bit value (1000ULL << (32 - rapl_core_hw_unit)) by 2000 with the plain
/ operator emits a call to __udivdi3 on CONFIG_X86_32, causing a link
failure when CONFIG_PERF_EVENTS_INTEL_RAPL is enabled.  Using div_u64()
would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111151050.3297=
24-1-dhruv.gupta@amd.com?part=3D1
