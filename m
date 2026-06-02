Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64E2EAD1B
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382523; cv=none; b=EQ2bmwfhMtkDXYBexT5a2K/4g75T4pP8GM4WzWAeg3dM6LZ8CwejLOMVx9EV9JZM2yNBVvHS2alXMWevskKn60yQfQ/eI/A+K0qvzNHpLNx8Fz5G5fI5vv10a3YAq1DgnAtx6S2WTdSPKQq31H9dkeWrAIk4Mm418VT8nvGAOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382523; c=relaxed/simple;
	bh=KhULMNitX3rNVglGHUl5fUJz08Qa4+tAGzgBCaEzH7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rStpc8oPd4v/W5JF5mV4/1jGbKM7EKDnWyNauAQk9FshPqKwgBoeU9N27wE1sEZpE+p5j0XGtClqPK/6sdZi+Pp/am2MG5eIeYh2/A0EMm/jz3/DfsJwtQDCdDINdVWPy9aKkwOpZHJ2FsE3JAAVnIUFIGwaw5oVLq5dU+yGSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JganR64i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JganR64i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612AE1F00893;
	Tue,  2 Jun 2026 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382522;
	bh=0zR3yTmk5LMuRait2GXENVnV2H9wpiKrrLYi2i2Rs7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JganR64ibd9m0zPBpg0XV9N0P3ND+HUCcvWEsmIpGtO6jOysL1ae9bhphM2V+Oubn
	 20ifLpm+cJCBrZqmCa/tvZS2vrz2LCCB5PVVu7PNSlPKFYpaFIzy14uxnwW4zdjQDa
	 T4TKxOk/H8oUEYcoAhJ4YbyYxj/xEuEs99MhRV+GbtxSxkEm786OvjHO3oPuR2Tlq0
	 RlvFcW5cQK8q5bU0PWYy5njdAIJWvzJzsj6aTBZkrpwgc2k27SQd4MLbvpnIygqRCn
	 4MfZ58++L8RhtkHeDMEUsuS3R5o6MEXYpuZ4tZsZEMf9hxUOQMC2bVALz+hPf4pZ/+
	 TZT08hCpctTaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/19] perf lock-contention: Use perf_env e_machine
 rather than arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-14-irogers@google.com>
References: <20260602062452.2583619-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:42:01 +0000
Message-Id: <20260602064202.612AE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `.feature` callback in perf_tool initialization for pipe m=
ode cross-platform analysis
--

commit 6123af68f287b03d324e8ede7eac36aa4cd98913
Author: Ian Rogers <irogers@google.com>

perf lock-contention: Use perf_env e_machine rather than arch

Use the e_machine rather than arch string matching for powerpc.

> diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-con=
tention.c
> index 92e7b7b572a22..119a7206f3cd2 100644
> --- a/tools/perf/util/lock-contention.c
> +++ b/tools/perf/util/lock-contention.c
> @@ -104,7 +104,8 @@ bool match_callstack_filter(struct machine *machine, =
u64 *callstack, int max_sta
>  	struct map *kmap;
>  	struct symbol *sym;
>  	u64 ip;
> -	const char *arch =3D perf_env__arch(machine->env);
> +	uint16_t e_machine =3D perf_env__e_machine(machine->env, /*e_flags=3D*/=
NULL);

[Severity: High]
This isn't a bug introduced by this patch, but won't this cross-platform=20
analysis fail when running in pipe mode?

Looking at tools/perf/builtin-lock.c, the perf_tool initialization in both=
=20
__cmd_contention() and __cmd_report() omits the feature callback:

	perf_tool__init(&eops, /*ordered_events=3D*/true);
	eops.attr		 =3D perf_event__process_attr;
	eops.event_update	 =3D process_event_update;
	eops.sample		 =3D process_sample_event;
	eops.comm		 =3D perf_event__process_comm;
	eops.mmap		 =3D perf_event__process_mmap;
	eops.mmap2		 =3D perf_event__process_mmap2;
	eops.tracing_data	 =3D perf_event__process_tracing_data;
	/* missing eops.feature =3D perf_event__process_feature; */

When reading a perf.data stream from a pipe, dropping the feature callback=
=20
causes feature events (like HEADER_ARCH) to be silently dropped. This=20
prevents machine->env from being properly populated.=20

Could this cause perf_env__e_machine() to incorrectly fall back to querying=
=20
the host architecture via uname(), breaking cross-platform analysis=20
entirely during pipe mode?

> +	bool is_powerpc =3D e_machine =3D=3D EM_PPC64 || e_machine =3D=3D EM_PP=
C;
> =20
>  	if (list_empty(&callstack_filters))
>  		return true;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D13
