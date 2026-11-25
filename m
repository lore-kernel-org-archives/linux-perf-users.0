Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795583643;
	b=DqEPsxTYdxdgsAUuN9PEppmNtmoxpp9e1w5uH/1bX8y5ZDwSu909fc536l90L5oxXJmx
	 4BtSQ9t3bU7wncc+IbJ726a47Ibix4DT8EyalmGwfF0qzhSDz+sEzKNOn+JKmjaxB/eNg
	 QQkqORFy0er7dNxPf9y7VYCxKYND2zUi1SERR2+c+KMNLtQk7LEsNA0mCSnIhXwEOEoiU
	 mmyslYuMauhy0nMkJGzKx+RiLEeWVBoKTot8hHrPJUtP/u/BIz32mVV6d4+19dgUDgRrX
	 cNEMLjEsEEodTvANANs3kz08t0s+R4XhT1Myu5lPwTeAAnYOJQCNqBiiA9Hsl6MQl+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583643;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a0ke4/yCSekayQ9aFSftUzOA7Z2UTXxkzb0Rxz5BVnc=;
	b=r2tD43Jsr/NXf4rXP+0PGPwdyonEGJY3y4Zm9P6bv7n3edWXYA2lAG+BVoIUX1bTsJ7I
	 3OtXWAShfkuoI0wE+SZm2XX6QKDAEhJacyoQBndwGiCZHIwKWcideP82FWCfFwUmGm+XA
	 DiLuJOALnbuJhdn+SP4mWGWo3K68C21VEx67Ey/OazvGPsMm1ChElyKq8x17I59jbvkIG
	 WM/SkL0GnQay49duQdJMGFbYxOb2e0ZP8AQN+CzclR/vbCasNg+3eQcXhhjPqGksE9ZdX
	 bEdb7jc8ktToN3cHZXCLhjMV1KEqmfY1DbcCJ6xKn6qnX8HHosMRs9ZO1Ae9FfmJ4kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4YX0ufU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9F606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4YX0ufU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA8B1F000CF;
	Wed, 25 Nov 2026 05:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795583642;
	bh=a0ke4/yCSekayQ9aFSftUzOA7Z2UTXxkzb0Rxz5BVnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4YX0ufUuVgDfYxPxxkA3bLj666xhPc73qkr68CmSt7gtuFvf4GPvizi74gjID66g
	 l/aa147nLychw1MaspxNQvCpg72VFUPhzg9aNoARMtaaM2VYIEicoYH4k0jY8PiH/e
	 fcY3sNORDBqu6cK09GtUYTdCG27y1Af1ZAXTMn87ZvhxP45j/vKVBmsB39kGn2Zy73
	 /S5oaELTbDX53i4JHjMgM+knhND35f7CfHDa9inZRs0QxbG1Fk+XaSQMa9pMdBgGga
	 xp+szvUDx1ThJ1XQ71q1CkrB9H7Ezrgn/Fw+5MJVIvCIJJQtW7dWi/5i2jU/9mtq+J
	 grH7Nfb+OjhKg==
Message-ID: <sashiko-outbox-232604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Add filtered event enabled time tests
 to event-times
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c41f98313862f6545863598dcde871cfb80aba59.1795582691.git.irogers@google.com>
References: <80d983c5713537f5743b69e9b35ced1177e4732e.1795582691.git.irogers@google.com>
 <c41f98313862f6545863598dcde871cfb80aba59.1795582691.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 05:14:01 +0000
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
- [Low] perf test: open_core_pmu_event() skips PERF_TYPE_HARDWARE on
  non-hybrid PMUs
--

commit fe121646fb71356672075f12505ef2224215b814
Author: Ian Rogers <irogers@google.com>

perf test: Add filtered event enabled time tests to event-times

This commit extends the event-times perf test suite with subtests for task
and CPU filtered events, hybrid PMU filtered events, and multiplexed or
grouped filtered events, while updating the CPU affinity helpers.

> diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-time=
s.c
> index 56dd37ca760ec..4c265f7918525 100644
> --- a/tools/perf/tests/event-times.c
> +++ b/tools/perf/tests/event-times.c
[ ... ]
> @@ -239,4 +251,475 @@ static int test__event_times(struct test_suite *tes=
t __maybe_unused, int subtest
>  	return ret;
>  }
> =20
> -DEFINE_SUITE("Event times", event_times);
[ ... ]
> +static int open_core_pmu_event(const struct perf_pmu *pmu, pid_t pid, in=
t cpu,
> +			       int group_fd, bool disabled)
> +{
> +	struct perf_event_attr attr =3D {
> +		.size =3D sizeof(attr),
> +		.read_format =3D PERF_FORMAT_TOTAL_TIME_ENABLED |
> +			       PERF_FORMAT_TOTAL_TIME_RUNNING,
> +		.disabled =3D disabled ? 1 : 0,
> +		.exclude_kernel =3D 1,
> +		.exclude_hv =3D 1,
> +	};
> +	unsigned long flags =3D perf_event_open_cloexec_flag();
> +	int fd;
> +
> +	if (!pmu) {
> +		attr.type =3D PERF_TYPE_HARDWARE;
> +		attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> +		return sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
> +	}
> +
> +	if (perf_pmus__supports_extended_type()) {
> +		attr.type =3D PERF_TYPE_HARDWARE;
> +		attr.config =3D ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT) |
> +			      PERF_COUNT_HW_CPU_CYCLES;
> +		fd =3D sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
> +		if (fd >=3D 0)
> +			return fd;
> +	}
> +
> +	attr.type =3D pmu->type;
> +	attr.config =3D 0x3c;
> +	fd =3D sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
> +	if (fd >=3D 0)
> +		return fd;
> +
> +	attr.config =3D 0;
> +	return sys_perf_event_open(&attr, pid, cpu, group_fd, flags);
> +}

[Severity: Low]
Does open_core_pmu_event() ever try PERF_TYPE_HARDWARE on non-hybrid
systems?

Both callers check that pmu is non-NULL before calling
open_core_pmu_event(), and perf_pmus__supports_extended_type() returns
false when perf_pmus__num_core_pmus() <=3D 1.  As a result, non-hybrid
systems skip PERF_TYPE_HARDWARE and fall through to attr.type =3D pmu->type
(PERF_TYPE_RAW) with raw configs 0x3c and 0.  On architectures where those
raw events are unsupported or rejected (for example, s390 rejects
PERF_TYPE_RAW when exclude_kernel or exclude_hv is set),
test__event_times_mux_migration() skips even though standard
PERF_COUNT_HW_CPU_CYCLES is available.

Trying PERF_TYPE_HARDWARE with PERF_COUNT_HW_CPU_CYCLES unconditionally
(and only ORing in pmu->type << PERF_PMU_TYPE_SHIFT when
perf_pmus__supports_extended_type() is true) would allow non-hybrid
systems to use the generic hardware cycles event before falling back to
raw configs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/80d983c5713537f5743=
b69e9b35ced1177e4732e.1795582691.git.irogers@google.com?part=3D2
