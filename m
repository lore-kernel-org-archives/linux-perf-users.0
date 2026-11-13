Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567784;
	b=n90SF4Yz9gP6XE176yIuRDt5w2/oYeW7bB2MArRXc5JiZxiNoFEQjWzltf0OvtaNau6i
	 p+OlXlALWJydZLSH2ae3pbGAVV8xaXqrPn26up2tcJASJLb0uCiNqd6zOwBfYKNlb7o9T
	 b2tyhG7O8pA993w3ivViJ5mJQi77IAmqeCpxoNgvcG4R685t2Yyo8rQ9o4f7BknjMa2tt
	 v9ZrEi+IVcrUtk/FMjMgICXVeDmDH5z22UwjaJ2UIkOYLyB4pDzSVjiRRur4gSKwKMumD
	 A0T1WDIy5qjLPO25cN6/rKB3u3J6gEpJi9JHBhvqp6qa/OYvh1tCFs9KKZ4fTZFAoTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9IptoJxWUtVoRCIsmVIg18SpPiDWJ8DcZbWZnR1nL5g=;
	b=CTSFegaHB2ddIj/PBjnRgLkGEzl3/teSiQRCF+Mjl2bsIdi0DOeM4emwata8l8b4KSZx
	 g2/fq4s5MgdcwM1V4LSAUaL7kkVQEBYBQl5HyMx6orIMUJTmgVKsdyhICzLf5cnK4YSrI
	 TwOxxFEiGYFm53o9pv5jQCcrt9TLQgqRq5nZs3nuYMjZkelojVfb4tTr0ua8uOvtoeZ99
	 cX25rR8cjDLnDfUe65HHT+8Snhn/Cg31FFCxKtVDnMlOoPp+H+7jQ+U5cu5IrhiH2UyIa
	 JBppYRgonOXuIokZtrXSB/qbzw01t9oGaG/6Kj8h5nwckakS2UUULVG7G5HGTDdME/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ds4A+mqA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2E606B265
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ds4A+mqA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542071F000C4;
	Fri, 13 Nov 2026 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567783;
	bh=9IptoJxWUtVoRCIsmVIg18SpPiDWJ8DcZbWZnR1nL5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ds4A+mqA7Hb3OC2bd3xOzLieYnAT2dt2NYz6WIIV8x0EOmOoAyIjZc/nTLd1lcuN8
	 PTvEIhsbI7MEazzVrCa0ahskBP2Qjk5OywdeeZ+Cgep1wlchF05wgV5kkO7rkE8Hsw
	 QOqR/69mLFqg4K01VoSCO4ufnp37d3U2PVeihHMrKoMdvgZnMFRzGN98irH9kZ28cH
	 VYkAZA/3GnUYifKaKOWzYfv1fbbqntON3/ASCZendmyRBk+oiKHDfFEveaKU/QQmTe
	 PZw4mGOPkQ48nNfTHn826e9xFQ5Z9/6cUp26j9eVEbS34NJ5VANZxREwHpEIjjQjhF
	 yM1dBqdMDM4MQ==
Message-ID: <sashiko-outbox-212661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf cs-etm: Check frontend instruction reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-3-eae592c5ff64@arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
 <20261113-perf_fix_gcc15_failure-v1-3-eae592c5ff64@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:03:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Medium] perf cs-etm: missing perf_sample__exit() in sample synthesis
  error paths [1]
- [Medium] perf cs-etm: infinite loop in cs_etm__sample() when period is
  0 [2]
--

commit 1c4da6763b4506cd44f0609ef42fba0e4bd574ea
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Check frontend instruction reads

This commit updates cs_etm__frontend_mem_access() to return 0 on a complete
read and -EIO otherwise, propagating read errors through instruction size,
address calculation, instruction copying, and SVC detection.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 312d4a734e84f..303e16a54445b 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -2011,11 +2021,13 @@ static int cs_etm__sample(struct cs_etm_queue *et=
mq,
>  			 */
>  			addr =3D cs_etm__instr_addr(etmq, tidq, tidq->packet,
>  						  offset - 1);
> -			ret =3D cs_etm__synth_instruction_sample(
> -				etmq, tidq, tidq->packet, addr,
> -				etm->instructions_sample_period);
> -			if (ret)
> -				return ret;
> +			if (addr !=3D CS_ETM_INVAL_ADDR) {
> +				ret =3D cs_etm__synth_instruction_sample(
> +					etmq, tidq, tidq->packet, addr,
> +					etm->instructions_sample_period);
> +				if (ret)
> +					return ret;
> +			}

[Severity: Medium]
This problem wasn't introduced by this patch, but can
cs_etm__synth_instruction_sample() and cs_etm__synth_branch_sample() leak
sample resources when event injection fails [1]?

Both functions initialize sample with perf_sample__init(&sample, true),
which allocates sub-structures, and then return early before
perf_sample__exit(&sample) if cs_etm__inject_event() returns an error:

tools/perf/util/cs-etm.c:cs_etm__synth_instruction_sample() {
	...
	perf_sample__init(&sample, /*all=3D*/true);
	...
	if (etm->synth_opts.inject) {
		ret =3D cs_etm__inject_event(etm, event, &sample,
					   etm->instructions_sample_type);
		if (ret)
			return ret;
	}
	...
	perf_sample__exit(&sample);
	return ret;
}

> =20
>  			offset +=3D etm->instructions_sample_period;
>  			tidq->period_instructions -=3D

[Severity: Medium]
This problem wasn't introduced by this patch, but can cs_etm__sample() spin
forever when the user specifies an instruction sample period of 0 (for
example, --itrace=3Di0i) [2]?

The loop condition is:

tools/perf/util/cs-etm.c:cs_etm__sample() {
	...
		while (tidq->period_instructions >=3D
				etm->instructions_sample_period) {
			...
			offset +=3D etm->instructions_sample_period;
			tidq->period_instructions -=3D
				etm->instructions_sample_period;
		}
}

Because both operands are unsigned, tidq->period_instructions >=3D 0 is
always true and subtracting 0 never reduces tidq->period_instructions.

[1] https://sashiko.dev/#/bug/linux-313ce3d0-12d6-4671-8007-6e3925af60fc
[2] https://sashiko.dev/#/bug/linux-88c200a9-e322-487b-904a-28d581ccee8b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-perf_fix_g=
cc15_failure-v1-0-eae592c5ff64@arm.com?part=3D3
