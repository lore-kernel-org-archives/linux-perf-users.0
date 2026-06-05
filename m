Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A5392C4F
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662910; cv=none; b=aQ6DcrVPqjVI8NIOhdl6fvjD5wXvog9kTJbdJjFUYlF5RxkRYtB5lIgoVamZjjQN6ZLcbXZPz31n4MFG3L4GPEgojlP1EUmRlndrgRGPvqhH8m8+hq5pqvazJfY7YCc5d9m4wuGE7b3tk4CYqKAXWkT6XrRT5Jw6Jn0ehyckKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662910; c=relaxed/simple;
	bh=picODiYvBZFlawWkPzGYhK5ssQgb4mnQkxLzNipHEeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fXaaBkqyypans9pE4EZjDrzfgVgJ8pcGCRhpM+vf+HtBLIs/f9ZglGiJr+nUS4SLyaZym4knNZBqWgghQpWg6YLIf4+t9tTGMRBdZuLRStVwMhwi6i7q6P4lHQU7R4a5XWEWElnfO/OwsS8reFp5+9CBYPcF1IS3VxL5jQ1VpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDM9NpaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDM9NpaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66671F00893;
	Fri,  5 Jun 2026 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662906;
	bh=MWT6B9WA5gbwzWg1Y4z7I04RZ1RDNGkmV7q9W0weg0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDM9NpaG/VLO6QNK7PqPytuP5U1y+STERsJTvE2woJisTTzbZNqZuB8VDm9RZvpYq
	 1df8Yxa52QhXlXWX/o/SoZwbAD7HMBfk24yKPOsumiO4mqRDXuKC3UGRIbmFEJjPZL
	 uUcG9DsNDf6etL02qkow0RTN6aHWdQ74JI14a8bTOPNJXoozJ8IZS4Wy+bqV7PQ9XU
	 TX4d78Mw+rtefdUxZIzVoLhmSRMqdiZ7AdcEFAL0WDcMGAGuV4gNU2ylmGJ6Cjgb6D
	 wa4/fXUEjsuUxl9XWRBm5spNjvHW5dXDtGz92ZKHldCbMgtBQavhLVUKXYdw/7jSMw
	 STEdCcHYZk77w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf sched: Fix thread reference leaks in
 timehist_get_thread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605121515.1725549-4-acme@kernel.org>
References: <20260605121515.1725549-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:35:05 +0000
Message-Id: <20260605123505.D66671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded reference leak of struct thread in timehist_sched_change=
_event
- [High] Missing .attr and .feature callbacks break perf sched in pipe mode
--

commit ff77c452c7d2cf0ab5fbb15792dac9ff2587a7cd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Fix thread reference leaks in timehist_get_thread()

timehist_get_thread() acquires a thread reference via
machine__findnew_thread() and an idle thread reference via
get_idle_thread() (which calls thread__get()).  Two error paths in
the idle_hist block return NULL without releasing these references.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 4aa7833cae6e3..7bd61028327b3 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2546,12 +2546,16 @@ static struct thread *timehist_get_thread(struct =
perf_sched *sched,
>  			idle =3D get_idle_thread(sample->cpu);
>  			if (idle =3D=3D NULL) {
>  				pr_err("Failed to get idle thread for cpu %d.\n", sample->cpu);
> +				thread__put(thread);
>  				return NULL;
>  			}
> =20
>  			itr =3D thread__priv(idle);
> -			if (itr =3D=3D NULL)
> +			if (itr =3D=3D NULL) {
> +				thread__put(idle);
> +				thread__put(thread);
>  				return NULL;
> +			}
> =20
>  			thread__put(itr->last_thread);
>  			itr->last_thread =3D thread__get(thread);

[Severity: High]
This isn't a bug introduced by this patch, but since itr->last_thread is now
properly reference counted here, I noticed it is being cleared in
timehist_sched_change_event() without a thread__put():

tools/perf/builtin-sched.c:timehist_sched_change_event() {
    ...
            if (itr->cursor.nr)
                callchain_append(&itr->callchain, &itr->cursor, t - tprev);

            itr->last_thread =3D NULL;
        }

        if (!sched->summary_only)
            timehist_print_sample(sched, sample, &al, thread, t, state);
    ...
}

Does this permanently leak the thread reference on every idle-to-busy
transition when --idle-hist is active?


[Severity: High]
This is a pre-existing issue, but while reviewing the sched tool
initialization, I noticed that the .feature callback is omitted for both
perf_sched__timehist and cmd_sched, and .attr is additionally omitted for
cmd_sched:

tools/perf/builtin-sched.c:cmd_sched() {
    ...
    perf_tool__init(&sched.tool, /*ordered_events=3D*/true);
    sched.tool.sample    =3D perf_sched__process_tracepoint_sample;
    sched.tool.comm      =3D perf_sched__process_comm;
    sched.tool.namespaces =3D perf_event__process_namespaces;
    sched.tool.lost      =3D perf_event__process_lost;
    sched.tool.fork      =3D perf_sched__process_fork_event;
    ...
}

tools/perf/builtin-sched.c:perf_sched__timehist() {
    ...
    sched->tool.sample   =3D perf_timehist__process_sample;
    sched->tool.mmap     =3D perf_event__process_mmap;
    sched->tool.mmap2    =3D perf_event__process_mmap2;
    ...
    sched->tool.attr     =3D perf_event__process_attr;
    ...
}

In pipe mode, does dropping .attr prevent the creation of evlists entirely,
and does dropping .feature prevent proper initialization of perf_env,
breaking the event processing pipeline?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121515.1725=
549-1-acme@kernel.org?part=3D3
