Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377788;
	b=smHLIP735UVSkYxuw5UUy93QgMQU0LEQpFDgH2Hxw9hYZ2QJJOhobu4dXqYBczmqmDup
	 RCo3euu5SQSO0YMOOYDdqA0+DGge+qK7qC9nZmjP4jHpODQmmrMpKK1sl64f3a/0YnpUx
	 2nAmjG7CafAKPyWnCyW8DIMZyYbtheniDnLe4L0ZnFI/nPB4oQ6s9V97S4KyPGfNAthg9
	 KMjMwVql+xmyaVoWyiyQ2Avyylq0unT5VVwMwoH68XXmj0/flxX/5WlVHRTB0SYU1sksp
	 +lBifzKvvz9GceDWl8Lz/5GABLCKXboOVk++JkDi7JqrdC2ujjR3xBHr1mKlN0Na5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377788;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i2yNkvg6wqy5tJ8GEPa/PBHlsWaaWITkd8Svbx3Iy1Y=;
	b=s88cMNGQR9aEdPkv43dHwe6u8CswFWygOIen1mXMhQtH9hys3sBYCJf6VKWTLJPgFerU
	 DH54FLsZlWO9SpOsKqbxxyk7M9ab8YqlEXgsLqPKi7elsFa9IGvbeqv+Ghy2djW1k2PwT
	 whfD3G1uPsWjnn2RNa/HFQ7EKKl8aFgOEgnhQNSwVBUpq6O//T8byDQCET+VRftMm1aTR
	 Y5ZqwdqVDz3uFtIZmHWcIdwS+8IVbADpMt49Xr3t5r5/xyWWvA/Fy8JOB8KprTWX+TCGm
	 Tw6uUDqzCMqYSsZsZcuF0pqt7UeD9Zlw0oDeO46y7PjEoorAyG46qzq08kS9KHgcETg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0MZf9lW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DB606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0MZf9lW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF4C1F00A06;
	Wed, 11 Nov 2026 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377788;
	bh=i2yNkvg6wqy5tJ8GEPa/PBHlsWaaWITkd8Svbx3Iy1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0MZf9lW/sqa1JzHy2d3YDs14AGU0F3hOSWAy8QLEoz2lgzBq/WEqypceZujr5PET
	 BXffW9PcDoLnJc6e59kcyhq7JoP5nekSlFwKC7YTRkBNMdyQTvBWws3XTII1FOZR6H
	 bpmzhI2r1y7TGWVs+YspxvzCVkOURlyJGzP4k5+tElrEr1AvF09x90dJWBjSjp31sQ
	 MGjLjsYIcpqQVnVIEpR3zVTDalFSY5KbNZuXQfeiYPiwM0qbz28M56Wx+AMQA3f57j
	 xnhgCKHh3J8ElLeu1nb+dGt9zfVuX4PeJN3PKWyEnfxhMyJYOU1B5wvZp+1/O4ikkL
	 LCkZRoNtlLnyw==
Date: Tue, 10 Nov 2026 22:16:26 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf evsel: Skip group members without fds when walking
 a group
Message-ID: <avQIOtt7Y67oXQem@z2>
References: <20261023085629.1694941-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023085629.1694941-1-takano32@gmail.com>

Hello,

On Fri, Oct 23, 2026 at 08:56:29AM +0000, TAKANO Mitsuhiro wrote:
> A group led by a userspace PMU event and containing kernel events is
> opened with group_fd = -1 for the members, because the kernel cannot
> group a userspace PMU with a kernel one.  The members are therefore
> enabled from userspace when the leader is enabled, but their fd array is
> not set up in that case, so perf_evsel__enable_cpu() dereferences a NULL
> pointer:
> 
>   $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
>   Segmentation fault
> 
>   $ perf stat -a -e '{system_time,cycles}' -- sleep 0.05
>   Segmentation fault
> 
> Only the leaders of such a group are opened with an fd in this path.
> Skip the members that have no fd, the same way __evlist__enable() skips
> leaders without one, in the four loops that walk the members of a group.
> 
> Verified on an Ampere Altra (arm64, Neoverse-N1) with a perf built from
> this tree: the two commands above segfault before the change and print
> user_time/system_time after it, while plain groups such as
> '{cycles,instructions}', 'perf stat' with no event and '-r 2' are
> unchanged.
> 
> Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
> Assisted-by: LLM
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---

Sorry for the delay, but it seems easier to fix the fd handling in
libperf like this (not tested).

Thanks,
Namhyung


diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index f747c0bc692d8a61..43ea1dfcebf421e5 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -57,7 +57,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 }

 #define FD(_evsel, _cpu_map_idx, _thread)                              \
-       ((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread))
+       (_evsel->fd ? (int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread) : NULL)
 #define MMAP(_evsel, _cpu_map_idx, _thread)                            \
        (_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evsel->mmap, _cpu_map_idx, _thread)) \
                      : NULL)
