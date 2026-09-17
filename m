Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCB4446F5
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628178; cv=none; b=oowpsKmYxr6UufNNeOJy9zG4nJOY0SZw8vBnQL9BgdVn9AriEgjj9Ox2nRonyI5qIuV7f09pBEs4qtePnfn746pnS3dLUVlk0I/vfJCotuXQVnn6uSS6gIYNXhuN4NnF+avf537Dl+Me2pOi5GD7ZOihJ8OYr86OWLo5G7dXyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628178; c=relaxed/simple;
	bh=HEoWbOGj5Hl0FXAeV4iffI6Lq4k/n79ODmeeRIraf7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=azKstBxjXg5DgOsHOnUYsMkLRX8wLZr39WNCUVH3EZ/64Dn8V2lxom19Jd2B4L+Iz+hBqcYkOJkku3vKKncBQfbn+cMbo0er0E6lPOfm3ajorQnlT8zgIkoCOk8643+WCf/z3Du7WD9EyF8bJA/8M9sQx/mzPOw4sUI6Pr076lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVaDfAM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVaDfAM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EFA1F00893;
	Thu, 17 Sep 2026 06:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789628176;
	bh=QmF+GCCVs8kSVVHE8dsZ4yWLL/IZReT94d9BVTDCVg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVaDfAM+EyI1/7K6esWeqWn77c33RPyZ6WyMo+OKhvKTTCPmyrZwuLUYevYNjMdMz
	 Rp/h9I6Ze9j674fDQnTyDOCi8b53LLIQzw/WWw7MC+d7PNO+9Yvsv5SNr1roA3HN3R
	 4C1LAgeR3uIENYjtSzFJOUMN44yk2qUbHS5/MzMFnE4s74twvpiFVGlTjvo3W5TLpH
	 Gnpqjm+F4xg0GnV8u1CAGk1piIM4prDJ37TSQVQ4ULwjoO/9C6aR50LNa1N/cTv7Gb
	 T+QSoy3FXPG6IXfVF5BcEsnGryuo2QKtxzaNKR8yWgKi8d5GdyL2WsJoKUqRsHzcd7
	 S7tkZM5sN2tmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/13] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <36cdb33f86d7c1d349fb0554f6ee6c3bc621b051.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <36cdb33f86d7c1d349fb0554f6ee6c3bc621b051.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:56:16 +0000
Message-Id: <20260917065616.A4EFA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf trace: filter string allocation failure is silently ignored
--

commit b8bbff6d8561525fa9959a8a378bdbe134e7f00b
Author: Ian Rogers <irogers@google.com>

perf trace: Filter events in BPF and avoid tracepoint vetoes

The BPF augmented_raw_syscalls sys_enter and sys_exit programs returned
0 for syscalls that were not of interest. Returning 0 from a tracepoint
BPF program vetoes the event for the whole system, so an unrelated
concurrent perf trace, perf record or ftrace session listening to
raw_syscalls would silently lose events.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a68d342569963..e21b2b4a87943 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -4043,7 +4061,7 @@ static int trace__add_syscall_newtp(struct trace *t=
race)
> =20
>  static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
>  {
> -	int err =3D -1;
> +	int err =3D 0;
>  	struct evsel *sys_exit;
>  	char *filter =3D asprintf_expr_inout_ints("id", !trace->not_ev_qualifie=
r,
>  						trace->ev_qualifier_ids.nr,
> @@ -4052,10 +4070,17 @@ static int trace__set_ev_qualifier_tp_filter(stru=
ct trace *trace)
>  	if (filter =3D=3D NULL)
>  		goto out_enomem;

[Severity: Medium]
Does this change from err =3D -1 to err =3D 0 silently ignore the filter st=
ring
allocation failure?

If asprintf_expr_inout_ints() returns NULL due to ENOMEM in=20
trace__set_ev_qualifier_tp_filter(), the code jumps to out_enomem:

out_enomem:
        errno =3D ENOMEM;
        goto out;

The out block then returns err. Since err is now 0, it returns success
instead of a negative error code. Could this result in missing tracepoint
filters and incorrectly collected events?

> diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_tr=
ace_augment.c
> index a9cf2a77ded17..b9d1208e50f2a 100644
> --- a/tools/perf/util/bpf_trace_augment.c
> +++ b/tools/perf/util/bpf_trace_augment.c
> @@ -1,4 +1,5 @@
>  #include <bpf/libbpf.h>
> +#include <errno.h>
>  #include <internal/xyarray.h>

[Severity: Low]
This is a pre-existing issue, but does this file fail to compile under musl
libc due to missing explicit POSIX header inclusions?

The codebase uses strcmp() in augmented_syscalls__find_by_title(), but=20
string.h is not explicitly included. Musl libc does not guarantee implicit
header inclusions.

> diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augm=
ent.h
> index 4f729bc677530..56f4dbab7d4bb 100644
> --- a/tools/perf/util/trace_augment.h
> +++ b/tools/perf/util/trace_augment.h
> @@ -12,6 +12,11 @@ int augmented_syscalls__prepare(void);
>  int augmented_syscalls__create_bpf_output(struct evlist *evlist);
>  void augmented_syscalls__setup_bpf_output(void);
>  int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
> +int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids);
> +int augmented_syscalls__add_target_pid(pid_t pid);

[Severity: Low]
This isn't a bug introduced by this patch, but the POSIX type pid_t is used
in function prototypes here without explicitly including sys/types.h.

Can this omission break compilation on systems using musl libc where types
like pid_t are strictly separated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D4
