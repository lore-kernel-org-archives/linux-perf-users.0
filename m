Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095EB1CEAC2
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662691; cv=none; b=cBlfIuVwxHu1CMKo/g2rgPYpykvQnOXwdpg7cUcUP2L+n6CJdISgNuEsIT5hZGjieZk8Op+Iqd/PkW2ZhWbQ1COzOx9zcG49Iu38UDZ07gNODP/I+mDYnPupEUr6zPe8twK87zzAp/+n7optty/p6azCyBgfz1AsuDHXiHotY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662691; c=relaxed/simple;
	bh=oLuLpVLT3g50+ooghjWtYkzDTbk8TBjpo0KJwBxOYIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p70EznYpvr6xBb8//Ir/PIE+YurJxdytw1dxpRFyL/q265AMEKeNMNSbKKP63lpWRkb/53+A/OuZ6Alz9Lf1nBoVnb/jcEj2p30Gguj+lXmFcFE9G5Ot6t7wOLtmKRMZiBaQFN47TyC1FyP+MgPSqBuDDdu6rPtr31R3k1FFmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZwFJ6gG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZwFJ6gG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8135D1F00898;
	Fri,  5 Jun 2026 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662689;
	bh=UiYsP+J50AH4fkfb6b91Ot0vXK8imrXVT11mEL6AocM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZwFJ6gGQzy0xuYys6wXBRvRyYmr/V1upJsgWW839/UHFD33PT0hhCYtE5WG7/Acm
	 5WZVEeXcwEALHQmI1MUb0v2i+U1OFQfklpcQXpCZ3PbO4ZArq8SYz4F5jDsTe9j67l
	 Oq03diItnrdHl2C6KCfYLsGfcDb9pSCRJw/EIcv4u89kWzIVg5kzBfcreWkYPVGtW8
	 NjPE6YW6HX3SyTpFAhZyAff6Z9DpYh11BZl0/xoNkvMcrErcSiQ83BBZYBPEZ8VG93
	 zxoc4JBcF5IG/Lo7x2qkypGkIv5dSKiymUHhD7dIe/f0N3v2SX+uQ5e1pFRhe5AUnH
	 3rGYAPZ5yM2pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf tools: Guard remaining test_bit calls from OOB
 sample CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605121515.1725549-2-acme@kernel.org>
References: <20260605121515.1725549-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:31:28 +0000
Message-Id: <20260605123129.8135D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Logic error in CPU filtering bounds checks allows out-of-bounds =
CPU IDs to bypass the filter.
--

commit c7a6257406af3fb4587a3e6f3454c67efbc1b249
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Guard remaining test_bit calls from OOB sample CPU

This commit adds bounds checking to filter_cpu in auxtrace.c and
builtin-script.c to prevent out-of-bounds reads in test_bit when
the CPU value is corrupt or absent.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index f4aa255fc3297..9ac29bdc3cd54 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2646,7 +2646,7 @@ static int cleanup_scripting(void)
> =20
>  static bool filter_cpu(struct perf_sample *sample)
>  {
> -	if (cpu_list && sample->cpu !=3D (u32)-1)
> +	if (cpu_list && sample->cpu !=3D (u32)-1 && sample->cpu < MAX_NR_CPUS)
>  		return !test_bit(sample->cpu, cpu_bitmap);
>  	return false;
>  }

[Severity: Medium]
When sample->cpu is greater than or equal to MAX_NR_CPUS, the condition fai=
ls
and the function returns false. Does returning false here mean the out-of-b=
ounds
sample is kept rather than dropped?

> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 5f4aa1701aef6..4cd2caf540152 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -372,7 +372,8 @@ static bool filter_cpu(struct perf_session *session, =
struct perf_cpu cpu)
>  {
>  	unsigned long *cpu_bitmap =3D session->itrace_synth_opts->cpu_bitmap;
> =20
> -	return cpu_bitmap && cpu.cpu !=3D -1 && !test_bit(cpu.cpu, cpu_bitmap);
> +	return cpu_bitmap && cpu.cpu >=3D 0 && cpu.cpu < MAX_NR_CPUS &&
> +	       !test_bit(cpu.cpu, cpu_bitmap);
>  }

[Severity: Medium]
Similarly in auxtrace.c, if cpu.cpu is greater than or equal to MAX_NR_CPUS,
this boolean expression evaluates to false.

In auxtrace_queues__add_buffer, if filter_cpu returns false, the buffer is =
kept
and queued:

	if (filter_cpu(session, buffer->cpu))
		return 0;

	buffer =3D memdup(buffer, sizeof(*buffer));

Could this cause corrupted events to bypass the filter and be processed
downstream?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121515.1725=
549-1-acme@kernel.org?part=3D1
