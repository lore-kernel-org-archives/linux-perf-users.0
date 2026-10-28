Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211683;
	b=La/wJA9SQnKZqs+7fKOtO12CJBiysfxRspkv7CIS7F4hHIzVmTT71e4mhkYwwq4M6MCs
	 MT9gT34csIOY5DoZz8lh5UFutbMQXW9mGciOW+YczexGySSPh+WNWfLWzaGriU++laFdI
	 r9gtQQQV6QGmUOIWtFuvICZ3PoBS7LDqGAACPwShln+YxmKtEoTLIOzjTURnEsUbikk9C
	 xa2oDzQd0/hoKOkCtfQjOaDkWOTNo2sJeP928qkURaR6KQ+gihCJOIgQ5fftU6umrY/Em
	 Sba3phmxz43ZJyXlRtH2pXlFwpYaSa3ubeEU9E5A/5iTtMF2uChO/tHTJTNaeOgwGlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tJQmsU0KEa5Bfrnn7vrGKNTvFXZ1wwArOS1pYLYM5CY=;
	b=gfS3ANDaP+8OOjKVf7RuIjlvfq2OdotXgeMeZ/0dsD5wBWLkZq0wvLXmnSLw6ItB0kVw
	 zzKDrIkkwGZ8WHxAl18NKxBcs0yR0kACLPgTKftkEqo1sWJdwW+1BFbuy6mPGG08xhQIF
	 UsRZGrlMJu+Y/7lRy+MGlVe3tTipfZAhFOIlELXC40ULkYwcUFZtv3QhH020kvQK0s8qg
	 824oJ3FtmpNZAlzwCVnk+ZM+FOeuQhiVU+pxjZ9XPpcyulxk+itc2xK77Wbdbs1yXRNjb
	 0eJw0lVzJjy0pQzZ5qZJUd2Nyp5Nyt9hlRwi7wkU6nIE03fBQ+FRZd4djptNHJSntfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5EVDS39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B978606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5EVDS39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2641F01825;
	Wed, 28 Oct 2026 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211682;
	bh=tJQmsU0KEa5Bfrnn7vrGKNTvFXZ1wwArOS1pYLYM5CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5EVDS39ws3jiawJhi2yYjy0al156hwc8Djs9B/pUdnHKtUBSwoGM3Z+X1q/BA6YT
	 sfQzr0psbCz35QJqrQ6vrGhtG9o6iHdpBxp6DcvbDSsQ2Ad4B3+66M3Ad3BSrIVZLd
	 oNOSvxzdiWjlXS5/ku19oRapPsO2IgIgMvZq6KvyS515Lc6pQTfiDmIlnV4u6aEn97
	 Fpa37YHDbRX6hN+ndX2f1T+ObudlPR97nvUgJqWClivb1UO3eHaDrL3/zHDoJT65Ha
	 2rfVGS6BlTL280UndT3c6cSRXffZX4kaDT4dLn+6hx5ErfSV+UNrWtfXULubHgSF2b
	 LRUDfm8wIJBtw==
Message-ID: <sashiko-outbox-188275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] alpha/perf: optionally randomize the ProfileMe
 sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-alpha-profileme-v1-5-d44b52bf2500@gmail.com>
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261028-alpha-profileme-v1-5-d44b52bf2500@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:21:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] alpha/perf: 64-bit overflow in alpha_perf_event_set_period() jit=
ter math
--

commit f5fe32a707f112845a6641dd8d8b1fcd7a1ddb70
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: optionally randomize the ProfileMe sampling interval

This commit adds a randomize configuration bit for Alpha ProfileMe raw
perf events to vary each sampling interval by up to 1/16 of the period in
either direction using a per-CPU prandom state.

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 06c9afeb7c05e..da8262c74d043 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c

[ ... ]

> @@ -360,6 +368,20 @@ static int alpha_perf_event_set_period(struct perf_e=
vent *event,
>  		ret =3D 1;
>  	}
> =20
> +	/*
> +	 * Vary each new interval by up to 1/16 of the period either way, so
> +	 * the samples cannot phase-lock with a loop whose length divides the
> +	 * period. The count stays exact because prev_count records the value
> +	 * actually written.
> +	 */
> +	if (ret && (hwc->flags & ALPHA_PERF_FLAG_RANDOMIZE) && period >=3D 8) {
> +		long jitter =3D period / 8;
> +		u32 r =3D prandom_u32_state(this_cpu_ptr(&alpha_perf_rnd));
> +
> +		left +=3D (long)((u64)r * jitter >> 32) - jitter / 2;
> +		local64_set(&hwc->period_left, left);
> +	}

[Severity: Medium]
Can the multiplication (u64)r * jitter overflow 64 bits in
alpha_perf_event_set_period() in arch/alpha/kernel/perf_event.c when a user
specifies a large 64-bit sample_period?

In __perf_event_open() in kernel/events/core.c, userspace can supply any
63-bit attr.sample_period:

	if (attr.freq) {
		if (attr.sample_freq > sysctl_perf_event_sample_rate)
			return -EINVAL;
	} else {
		if (attr.sample_period & (1ULL << 63))
			return -EINVAL;
	}

When hwc->sample_period is at least 1UL << 35, jitter (period / 8) is at
least 1UL << 32, so (u64)r * jitter overflows 64-bit arithmetic and wraps.
Because the 64-bit product is then shifted right by 32, the positive term
is bounded to U32_MAX while jitter / 2 remains a full 64-bit value, causing
every interval to be systematically shortened by roughly period / 16 rather
than varying symmetrically within [-period / 16, +period / 16). In addition,
if sample_period is near LONG_MAX, adding a positive 1/16 offset to left can
overflow signed long into a negative period_left.

Would using mul_u64_u32_shr(jitter, r, 32) avoid the multiplication overflo=
w?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-alpha-prof=
ileme-v1-0-d44b52bf2500@gmail.com?part=3D5
