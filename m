Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440B3DBD70
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604766; cv=none; b=bHoWzEM5LkhKCDwLydGZIEvZYWEH4Klmb5az3Rzq/R5eY9p3zaOhYzPu7Yvpky0JAziVQ4ne9gq2zu3CDW2LVlVCF+PsOFflAhhdtRs2Kc53/6aF+sU8JMlGPnZJvXBkWi/I9R5ZqAmVu95pUwEBZHszVIhMCvawMBCg1cyLgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604766; c=relaxed/simple;
	bh=DQExfhXNMmiwFsQA6dDJveilbNg1mupHBfLtXijgwDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYXpEFyRGMh67jwbDCf7DokcF6UISAEK2JDdoXed6vxjFvBZIcE0QVIkwA0FlqeC1hEiy07ZqQBXcQ3fujVBw1M9p/DUq/Rq8QbHtRJUE/elkpbhjXtOX0wuvZz54D2uGlVy9J2f9b5tcqLS5I40FugGzwwTquNRE5bDvvvqACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3CF0y6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3CF0y6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EFC1F00898;
	Thu,  4 Jun 2026 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604765;
	bh=DFasy/zkqfRMq5pEr2aLzRpb4tWIkRkBlBqMV+0tKOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H3CF0y6nVI3kqU7XKUO1aNXl4joDHBcUXzYCv+WNfpokVcO/PzLxBhP2li9CjF2uN
	 cBi6N7GWowazql2SFNxqzV67lOjpImyr+gczgmArvqMPqluFg2PrM1oDVv5VjGgFb6
	 mN/hHwBAfDlA2COgZ3QSloAVNF8+G4bvj5wDOETFBBDDIxLvYjxRa/XwrSAPUp7BLs
	 oFpjZJV2WDbYzHBP2sdqEC68gaWJRH4kYIk5DIhKk+kJLef7koXuM3//mAJTNH1b9U
	 nI9oyW0KvSy/CaQLN848bPbTyWe+tSdbdzFNaVgxZZpHSmQYWbYfOOtPyIwVrBr2hp
	 EYwjlsaKJOvsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf sched: Fix comp_cpus heap overflow with
 cross-machine recordings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604201119.1702338-5-acme@kernel.org>
References: <20260604201119.1702338-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:26:05 +0000
Message-Id: <20260604202605.99EFC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the `sched->max_cpu.cpu` initialization introduces a se=
vere off-by-one error, causing `perf sched map` to truncate the highest CPU=
 from its output and print nothing for single-CPU traces.
--

commit 4c1487bde6fa91cfb4bca7de01bfd611065c7c9a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Fix comp_cpus heap overflow with cross-machine recordings

This commit fixes a heap buffer overflow by allocating comp_cpus with
MAX_CPUS and the correct element size. It also removes the initial assignme=
nt
of max_cpu from the host's CPU count.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 36da451447b5e..80e42536400a9 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3573,10 +3573,8 @@ static int perf_sched__lat(struct perf_sched *sche=
d)
> =20
>  static int setup_map_cpus(struct perf_sched *sched)
>  {
> -	sched->max_cpu.cpu  =3D sysconf(_SC_NPROCESSORS_CONF);
> -

[Severity: Medium]
Does removing this initialization cause an off-by-one error when rendering
the schedule map?

Without this initialization, sched->max_cpu.cpu tracks the maximum 0-based
CPU index seen in the trace. However, when compact mode is disabled,
map_switch_event() assigns this 0-based index directly to cpus_nr:

tools/perf/builtin-sched.c:map_switch_event() {
        ...
        } else
                cpus_nr =3D sched->max_cpu.cpu;
        ...
}

Then print_sched_map() iterates strictly less than cpus_nr:

tools/perf/builtin-sched.c:print_sched_map() {
        ...
        for (int i =3D 0; i < cpus_nr; i++) {
        ...
}

Will this skip the highest CPU column entirely, and print nothing for=20
single-CPU traces where cpus_nr becomes 0?

>  	if (sched->map.comp) {
> -		sched->map.comp_cpus =3D calloc(sched->max_cpu.cpu, sizeof(int));
> +		sched->map.comp_cpus =3D calloc(MAX_CPUS, sizeof(*sched->map.comp_cpus=
));
>  		if (!sched->map.comp_cpus)
>  			return -1;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604201119.1702=
338-1-acme@kernel.org?part=3D4
