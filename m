Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529913;
	b=ZW4TY7rCfW2hWnkvBfsYMStV8e8CZBrpqUGBc0uU86mKzyB7BTwlMX+7Ly4JB9/M38cy
	 FNE2zCT/5GefPs/zGSoXhfrrt9kyWxfq+0/oe//epVenKwma51f9GKvIQxbBhGZRVHshK
	 k/Xkhqq7Arzl0JR4eO/gC4rkFQFRR9AcjXTK86G3SQ/TtB7gg4hkCGzpOaJuUhAnWIE2j
	 K0EVH3YTUGidyQ9LyMdwq4f7qCxtvWmQBDEq7C3B1wCsb2oTTf2anot6X9xqB2tOr9Xk4
	 Nu24l0ba1zMb5QedhC5ZAxsN1s1re40Djfh6dZML6A43nwsXiSsjobrRHraePvUBEIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=510J0I5bQ4Ys+O9O1CoZgxe/K+2mMJNgaylUrP7d6lg=;
	b=limYmoqjZctkv06kYmqylQ55NDS9R01BCNcSLXHPI3EV7fvzSp4e8sLXYCWAeOOR8A5h
	 rdzAEW+XBVes0CNlM7nxxKzt+LWTNu09gJ1Dq23TGRJ95snMaecDkedIAb+NA0bBKqAz3
	 qTYlz4e7UJvEjpzRsqsj7AWX6TBQrMM2uGEJuYzwHTdZSA98roWEmjs/v8Rc4peI08xZQ
	 3suegRwub+O2notBczcpxNb5XAoNeYAlsBX63u5uAe32epyjyZ33pI/EQeecAMJn42HtR
	 D7S6f52O/Ygscw9d5Z9Mal8Y4K+l8SFuJJi7SXQcWo7VR5aoJ6OfNDgyqg+dAe+YSxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTuFBqZn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B76606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTuFBqZn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03F91F000C4;
	Tue, 24 Nov 2026 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529913;
	bh=510J0I5bQ4Ys+O9O1CoZgxe/K+2mMJNgaylUrP7d6lg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UTuFBqZnZksLemkjcAl5DdaEFjsHLBX/YS4Ll04iKE0MxM6m3JKUoHCY+z8w1Zczh
	 XX9YnFDyD8/KGZsFbTwL+5pZbJU+fHWiQHmwaOe2eUUEbfxo4UGgKwhDwdwlHAfy9+
	 Wf8GpEqvBM1HkHvM9K1Zq1IMNWNLiid92m66NjHcTK5KRVPhEW/QAzg65eZrztdRsF
	 ISnWIrezVf9bb5cP9kuz7bYj1vMYSC7itUlnAv4UmuK99mSS6tZPJ6ItgCtzUtw1YF
	 LvlFBmwSDPQeg2ocC4wdXMs/jDMCjynyzVvI0RPrMLbZet1BQ1k2owc7ugGsNu27ir
	 zSZGVL08ajlnA==
Message-ID: <sashiko-outbox-231330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] perf stat: Refuse a group mixing tool and kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261124135630.1027716-1-takano32@gmail.com>
References: <20261122085947.3107661-1-takano32@gmail.com>
 <20261124135630.1027716-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 14:18:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf evsel: incomplete tool leader check in get_group_fd()
  causes NULL deref
- [Low] perf test: stat+tool_group.sh fails when cycles falls back to
  task-clock
--

commit f76f32ae784a4246dd84b47459aafaeb67d2fd59
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf stat: Refuse a group mixing tool and kernel events

This commit refuses event groups in perf stat that mix tool events and
kernel events, while leaving weak groups led by a tool event to be split
when member events fail to open.

Link: https://lore.kernel.org/all/sashiko-outbox-227849@kernel.org/
Link: https://lore.kernel.org/all/20261111-tool-pmu-leader-v2-1-3faa0fb98c5=
1@gmail.com/
Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
Link: https://lore.kernel.org/all/20261111101625.2204836-1-takano32@gmail.c=
om/
Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/

> diff --git a/tools/perf/tests/shell/stat+tool_group.sh b/tools/perf/tests=
/shell/stat+tool_group.sh
> new file mode 100755
> index 0000000000000..0d630a70f1b58
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+tool_group.sh
> @@ -0,0 +1,212 @@

[ ... ]

> +# The events named after the group have to show up in the output.
> +accepted() {
> +  local group=3D"$1" name rc=3D0
> +
> +  shift
> +  echo "Testing that perf stat accepts ${group}"
> +  perf stat -e "${group}" -o "${out}" -- true 2> "${stderr}" || rc=3D$?
> +
> +  if [ "${rc}" !=3D 0 ]; then
> +    cat "${stderr}"
> +    echo "perf stat failed for ${group} (${rc})  [Failed]"
> +    err=3D1
> +    return
> +  fi
> +  if grep -q "cannot be grouped with kernel events" "${stderr}"; then
> +    cat "${stderr}"
> +    echo "perf stat refused ${group}  [Failed]"
> +    err=3D1
> +    return
> +  fi
> +  for name in "$@"; do
> +    if ! grep -q -- "${name}" "${out}"; then
> +      echo "perf stat did not print ${name}  [Failed]"
> +      cat "${out}"
> +      err=3D1
> +    fi
> +  done

[ ... ]

> +# A group of tool events only is read by perf itself, a single event in
> +# braces is not a group, a tool event outside the braces is not a member,
> +# and a weak group led by a tool event is split by the weak group
> +# handling.
> +accepted '{user_time,system_time}' user_time system_time
> +accepted '{duration_time,user_time}' duration_time user_time
> +accepted '{user_time}' user_time
> +accepted '{cycles,instructions},duration_time' duration_time
> +accepted '{user_time,cycles}:W' user_time cycles
> +accepted '{system_time,cycles}:W' system_time cycles
> +accepted '{duration_time,cycles}:W' duration_time cycles

[Severity: Low]
Will these three weak-group cases fail on machines or virtual machines
without a hardware cycles PMU?

When opening hardware cycles fails with ENODEV, ENOENT, or ENXIO after the
weak group splits, evsel__fallback() falls back to task-clock and renames
the evsel to task-clock.  The initial probe sets kernel_events=3D0 when
cycles does not appear in the output, but accepted() still requires every
name passed in "$@" (including cycles) to match "${out}".

[ ... ]

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d060fca8090f6..ef811b1f1e6af 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2381,6 +2381,15 @@ static int get_group_fd(struct evsel *evsel, int c=
pu_map_idx, int thread)
>  		return -1;
> =20
>  	fd =3D FD(leader, cpu_map_idx, thread);
> +	if (fd =3D=3D -1 && evsel__is_tool(leader)) {
> +		/*
> +		 * A tool event has no perf_event_open() descriptor, so -1 is
> +		 * normal for it and the members cannot be in the kernel group.
> +		 * builtin-stat.c decides on the weak group split from errno.
> +		 */
> +		errno =3D EINVAL;
> +		return -2;
> +	}
>  	BUG_ON(fd =3D=3D -1 && leader->supported);

[Severity: Medium]
Should get_group_fd() check evsel__is_tool(leader) regardless of whether
fd =3D=3D -1?

While duration_time leaves fd =3D=3D -1, user_time and system_time store an
open procfs descriptor (/proc/stat or /proc/<pid>/stat) in FD(leader, ...),
so get_group_fd() still returns that procfs fd as group_fd for weak groups
such as -e '{user_time,cycles:k}:W' that check_tool_groups() lets through.

In the kernel's perf_event_open syscall, permission checks such as
perf_allow_kernel() run before group_fd is validated with is_perf_file().
Under the default kernel.perf_event_paranoid=3D2, opening cycles:k in
perf stat -a -e '{user_time,cycles:k}:W' fails with EACCES instead of
EBADF or EINVAL.  Because __run_perf_stat() only splits a weak group on
EINVAL or EBADF, the failed member remains attached to the user_time
leader while perf_evsel__free_fd(&counter->core) frees its fd array to
NULL, and enabling or disabling the leader then triggers a NULL pointer
dereference in evsel__enable_cpu() -> perf_evsel__enable_cpu() ->
perf_evsel__run_ioctl().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124135630.1027=
716-1-takano32@gmail.com?part=3D1
