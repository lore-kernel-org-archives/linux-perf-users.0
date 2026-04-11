Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E439EAC7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937294; cv=none; b=OAIHzMPKRbafkNGrg6FEWgpWAsvmSWDEw9+nhVi3QSO/sGc5nMBw3eId7mHSWQx1hFoS2c4jfAi/iFHUyOYzAq9KjkOELGgLfmlI0WTIuihkMMwmdD+HLgwgvekVIKh2gnN/sKXh5morTyMqGSpa4krrjtRcbxkDXEAMHz5Atws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937294; c=relaxed/simple;
	bh=9ayfZrnh0QnjaA3O/G7QVj5zyjuVZsG4QuUodk0iQ3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tertvUJFulVqoInAbwFezaPZNGXviAaJDl5bC6tqCR2nwt3vr3gL3gtYvHnoMGr/Jt9oOM+zC7gF3Nfi6c2EotdiTijLe89spBVkausRM1yiKCtQK+uao+bJ7DVeBdwHTuiwf9JNW8tQnvmesgcJgy0xpCUpFD/1HFnxKwJ3aKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNQnBnv0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNQnBnv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131C8C2BCAF;
	Sat, 11 Apr 2026 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775937294;
	bh=9ayfZrnh0QnjaA3O/G7QVj5zyjuVZsG4QuUodk0iQ3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jNQnBnv0GhSXzr6+k8jM/I9UK3sHCxgtIbk+PvMN44VB0YeXP2IBTQEPoIoXmMl5D
	 lZ7Nxy7W6Fyhn6MJ38QwYu2q9de+kqbcIS4lH7C39aOj1YFCxwOt/VZj4MAt+6rCJH
	 GOoPPpN1/ZQzzuT0sVkMD4N1eg0sC0WvAm/WpZk2iF8xdltUbTsftXjkE4eSMFW/YB
	 xae8dGHZQOQUHc5eXCclDNkYyFe9eEmonC3Ue44dnRc53xtNcnRMVr3PE9BwXzgq3q
	 pt+Exp09L0iZc+1CdHJCQkNpeIIOO7c9fKZ8JpiiybF3aWE3pIvrrUEVzMYh2rLVwa
	 ZVnt8TfB5p4tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 26/29] perf timechart: Bounds check CPU
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411191710.524998-27-irogers@google.com>
References: <20260411191710.524998-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 19:54:53 +0000
Message-Id: <20260411195454.131C8C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Off-by-one heap out-of-bounds read in `end_sample_processing`.
- [High] Unbounded loop in `write_svg_file()` leading to arbitrary heap out=
-of-bounds read on `topology_map`.
--

commit aa15bc3e9dfa3ca847f7ab86a34ae36cf6bde9b1
Author: Ian Rogers <irogers@google.com>

perf timechart: Bounds check CPU

This commit adds bounds checking for CPU IDs during sample processing.
It limits the maximum CPU index to MAX_CPUS to prevent out-of-bounds
memory accesses in the arrays tracking CPU states.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 64f69bd67c6b7..64ff998c597a7 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
[ ... ]
> @@ -697,7 +725,7 @@ static void end_sample_processing(struct timechart *t=
chart)
>  	u64 cpu;
>  	struct power_event *pwr;
> =20
> -	for (cpu =3D 0; cpu <=3D tchart->numcpus; cpu++) {
> +	for (cpu =3D 0; cpu <=3D min_t(unsigned int, tchart->numcpus, MAX_CPUS)=
; cpu++) {

Does this loop have an off-by-one regression?

If tchart->numcpus is greater than or equal to MAX_CPUS, min_t() returns
MAX_CPUS. Because the loop uses the <=3D operator, it will execute a final
iteration with cpu =3D=3D MAX_CPUS.

Inside the loop, p_state_end() is called, which executes
pwr->state =3D cpus_pstate_state[cpu].

Since cpus_pstate_state is allocated with exactly MAX_CPUS elements,
accessing index MAX_CPUS performs a heap out-of-bounds read. This
uninitialized memory could then be leaked into the generated SVG output.

Could the upper bound be adjusted to MAX_CPUS - 1?

Is there an unbounded loop regression in write_svg_file() that can cause an
out-of-bounds access?

tchart->numcpus is initialized directly from the perf.data file header
without validation. In write_svg_file(), the code iterates up to
tchart->numcpus and calls svg_cpu_box(i):

tools/perf/builtin-timechart.c:write_svg_file() {
    ...
		for (i =3D 0; i < tchart->numcpus; i++)
			svg_cpu_box(i, tchart->max_freq, tchart->turbo_frequency);
    ...
}

The svg_cpu_box() function accesses the heap-allocated topology_map array,
which is sized based on env->nr_cpus_online (capped at MAX_NR_CPUS).
If a perf.data file sets nr_cpus_online to 1 but nr_cpus_avail to a very
large number, could this loop read past the end of the topology_map
allocation and cause a segmentation fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411191710.5249=
98-1-irogers@google.com?part=3D26
