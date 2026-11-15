Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750993;
	b=TaUiFtKgXvcXLFiKrAbl9Ok31ause/5zea81/DGHMSBteMhSCCjAE8jzt063LIP3n8T3
	 riOyoDvSDhAb5ZYBpeLm6n21Vz58X4TMCOdxUcEEMQgjCTR+m4Hy5fN0eo8JBVQolyTEn
	 cC6YIzU3+W5WVAL3E7ZR4vGZSEHYwGCigZ50UeWD7qQtdxYaH0yNA7mWgWtBbgdTYz8W8
	 +0TltHvnsFjXK7dJ2XdwphOf5nXzFyXDUgplXFgMkrygd6wXJBTvU9pCDpIeG4AyEOfzJ
	 v6rI+pRiNXuny478tX7a6zq10xpd8sxG0h1eHwLF6a8c059k+Ss7EATH+bIctdU/hdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Br8shReHdrwTVdaU5J0ZGmcxc0Imja0To5Fx4V58dic=;
	b=EC/72uYZ6lU4mdHmPHZBoi//EQU9dftHLxOFq0DRuqEEzEZUNs7I17ReVhJ3t4hoox8X
	 bcX8y5AZL8uhb45LyWwy9X81dqLl1g5593qM1TDFd5TMDD40o3foCkHatD3pRrI0AxyJ/
	 JBW1yY68EyHLDmnIEs3slPstl+eG13c8+d2agvIIsa6K9WZRWR0GlhvoHl+K2nyg3JOfw
	 NcGViFVLDuCcoQocyJgCm3SlLf5TEnbsGBpGJdIzBgfLTjhuAeJC1/h6e8tr6de0UbS7Y
	 xXYaqYqSiz5BfEMylqBovW2rVW9Hvx8yFkXV/2Q3MGm0kTez29a3xPCCc5YaMVKQGAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXZZlZeP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F989606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXZZlZeP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE051F000C4;
	Sun, 15 Nov 2026 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794750993;
	bh=Br8shReHdrwTVdaU5J0ZGmcxc0Imja0To5Fx4V58dic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXZZlZePusP+LuY8Gb5SFxPWcRvuwEs9B2opUyq5/vvRcZW13RrQZyyS7Lr5DyM4+
	 XTjeTiC7acx5yd8+0J8deXE5Dw70ZT09H+4mUdDiq0y9Smv5IGU9Rd9A0eWmtEzowp
	 qfc6DQuspvkCeKpA5qj+m91/zdvWsf3eACncvS5GTg5w5BLgOvvWu+EPamzJN9qESE
	 eNsesYCL5R5DFMhYRq1KLmYxAZglh4hEzYgeE0oSt6WvmWmcfogdkAdKliEKdUZvuh
	 nPgihju4wEPMV0xxDT1vRMLYxtlZXiSD22/wRbDrgnPTpztyhM5xnPI2rylmTnrCcz
	 TdngkgkyIwphA==
Message-ID: <sashiko-outbox-215548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf: Assemble split thread maps in script and stat
 report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115-perf_fix_large_threads-v1-2-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
 <20261115-perf_fix_large_threads-v1-2-69c9b86b9ae5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 13:56:32 +0000
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
- [Medium] perf: NULL dereference on incomplete thread map when
  set_maps() is deferred
- [Low] perf stat: leak of perf_stat.threads and perf_stat.cpus in
  __cmd_report()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] perf stat: memory leaks of session, evlist, and maps in
  __cmd_report() [1]
--

commit 296ec71892d6fd09202f3090775a27df449bf978
Author: Leo Yan <leo.yan@arm.com>

perf: Assemble split thread maps in script and stat report

This commit adds thread_map__append_event() to assemble split
PERF_RECORD_THREAD_MAP records in perf script and perf stat report before
publishing the completed thread map to the evlist and allocating stats.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b6691ebb1b4ef..e41925fb86b8d 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c

[ ... ]

> @@ -3416,6 +3417,10 @@ static int __cmd_script(struct perf_script *script)
>  	}
> =20
>  	ret =3D perf_session__process_events(script->session);
> +	if (!ret && !session_done() && script->threads_is_appending) {
> +		pr_err("Incomplete thread map: missing final record.\n");
> +		ret =3D -EINVAL;
> +	}
> =20
>  	if (script->per_event_dump)
>  		perf_script__exit_per_event_dump_stats(script);
> @@ -3975,6 +3980,10 @@ static int set_maps(struct perf_script *script)
>  {
>  	struct evlist *evlist =3D script->session->evlist;
> =20
> +	/* Appending can move the map, so share it only after the final record.=
 */
> +	if (script->threads_is_appending)
> +		return 0;
> +
>  	if (!script->cpus || !script->threads)
>  		return 0;

[Severity: Medium]
Can deferring set_maps() while threads_is_appending is true cause a NULL
pointer dereference in perf_counts() when the final PERF_RECORD_THREAD_MAP
record is missing?

If a PERF_RECORD_THREAD_MAP record with PERF_RECORD_MISC_THREAD_MAP_MORE set
is followed by PERF_RECORD_CPU_MAP and stat events without the final thread
map record, set_maps() returns early and skips perf_evlist__set_maps() and
evlist__alloc_stats(), leaving counter->counts NULL on each evsel.  Because
threads_is_appending is only checked after perf_session__process_events()
returns, subsequent PERF_RECORD_STAT_ROUND or PERF_RECORD_STAT events are
processed first: process_stat_round_event() -> perf_stat_process_counter() =
->
process_counter_maps() calls perf_counts(counter->counts, idx, thread) and
dereferences NULL, or perf_event__process_stat_event() fails earlier with an
"Invalid CPU -1" error that masks the incomplete thread map message.  The
same regression affects set_maps() and __cmd_report() in
tools/perf/builtin-stat.c.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 37752d6bfef45..19d120b647065 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c

[ ... ]

> @@ -2301,15 +2306,19 @@ int process_thread_map_event(const struct perf_to=
ol *tool,
>  			     union perf_event *event)
>  {
>  	struct perf_stat *st =3D container_of(tool, struct perf_stat, tool);
> +	int ret;
> =20
> -	if (st->threads) {
> +	if (st->threads && !st->threads_is_appending) {
>  		pr_warning("Extra thread map event, ignoring.\n");
>  		return 0;
>  	}
> =20
> -	st->threads =3D thread_map__new_event(&event->thread_map);
> -	if (!st->threads)
> -		return -ENOMEM;
> +	ret =3D thread_map__append_event(&st->threads, &event->thread_map);
> +	if (ret)
> +		return ret;
> +
> +	st->threads_is_appending =3D
> +		event->header.misc & PERF_RECORD_MISC_THREAD_MAP_MORE;
> =20
>  	return set_maps(st);
>  }

[Severity: Low]
Does this leak st->threads when thread_map__append_event() fails partway
through or when the final thread map record is missing?

thread_map__append_event() stores the allocated map in st->threads before
duplicating the comm strings, and set_maps() keeps st->threads private while
st->threads_is_appending is true.  Unlike cmd_script(), which calls
perf_script__exit() to release script->threads and script->cpus,
__cmd_report() only calls perf_session__delete(session) and never calls
perf_thread_map__put(perf_stat.threads).

> @@ -2405,11 +2414,13 @@ static int __cmd_report(int argc, const char **ar=
gv)
>  	evsel_list         =3D session->evlist;
> =20
>  	ret =3D perf_session__process_events(session);
> -	if (ret)
> -		return ret;
> +	if (!ret && !session_done() && perf_stat.threads_is_appending) {
> +		pr_err("Incomplete thread map: missing final record.\n");
> +		ret =3D -EINVAL;
> +	}
> =20
>  	perf_session__delete(session);
> -	return 0;
> +	return ret;
>  }

[Severity: Medium]
This problem wasn't introduced by this patch, but does __cmd_report() leak
perf_stat.threads, perf_stat.cpus, evsel_list, and the aggregation maps
[1]?

cmd_stat() allocates evsel_list with evlist__new() and returns directly from
__cmd_report(), bypassing the cleanup at the end of cmd_stat().  If
perf_session__new() fails in __cmd_report(), returning early before
evlist__put(evsel_list) leaks the initial evsel_list.  During event
processing, set_maps() passes perf_stat.cpus and perf_stat.threads to
perf_evlist__set_maps(), which takes an extra reference on each map, and
process_stat_config_event() allocates aggregation maps;perf_session__delete=
()
only drops session->evlist's references and __cmd_report() never drops
perf_stat.threads, perf_stat.cpus, or the aggregation maps via
perf_stat__exit_aggr_mode().

[1] https://sashiko.dev/#/bug/linux-b77574e3-cc57-4338-8810-73a0cfa6fff7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-perf_fix_l=
arge_threads-v1-0-69c9b86b9ae5@arm.com?part=3D2
