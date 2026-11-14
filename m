Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614710;
	b=Wc/jzzG3FYlZw/0UA69zuXcROGw711ErKv8pFLB7namoc8cCc/LdptGX5PRT2+BfAooJ
	 uKe3YBKajPh8xJtxu2U8e87+sg0FWPHItlTdCY7N3MhOUMOyS7d6udZh7LCuNWGRaU9Nm
	 bPGV1qCzuBaclQAqQj3PEmG3mQHC25l7lR5ceh28IJsfNem4Co39H869dtYkV1+/d8FZs
	 pUx7Nv5TvEuAqssPiILQ4PU6Ofxv9gSAF06ZO/w5dp3jDWt7oQn1UpH+DqLaWrIvlCnUT
	 xiTMNLh0Na4zSDbXXvcX7IHvJOJXE/Mn4Q4t5/FHnq9+BuiL+k7JH8OpYq5U/OuS1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=himQSrEXLrLHoaYmKrxWlHbc2Ijhbv8u3QdrqyCw+hI=;
	b=YL8uPe+74urlKA7EfD0OVfY6N2pWU9f0zg2bkdK8I9DWnAEjTtuwHX9lrmgt9cE9tyLV
	 vn2rGnRGxTGjfnev2RfNsR7QitKZEuEkWjU7ffo9VCg25mqRbgzys4DJfHJrLXg3Houda
	 iTNII+hoS1pdQ36eohqDozIK+6aGjRLyujEaZT6PYS65saOamTJWs6cDQpeGhrbZDDqke
	 LvE+m4NUSusaRS4o1jr3qcEd1W2goLbHgEkZIhpvZMEidfvvq36x/8Hdu5SGM0TGouSH7
	 3ECNTP60USDmc2VKO98yxnlqsp7UobrjxtpWVYXebSwQ0xPATZssqp6hpVbHQgGmW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgrV8PFc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9366606A334
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgrV8PFc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E1A1F000C4;
	Sat, 14 Nov 2026 00:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614710;
	bh=himQSrEXLrLHoaYmKrxWlHbc2Ijhbv8u3QdrqyCw+hI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZgrV8PFcOlhkTkwgfy4DUog0S1CrqtIwkSiJ6FRMf3tiBV/oBPFDm08Hxp5EB4iR9
	 fmUrpC2Fcz4h6mb2N0hxDyETJCxRIeTSYjOZ4/sM+8rM2z1lFKLw2Jz8Vr1YvA8248
	 Gm+MWGZR8tUbHZTSt0PzMFxVJRJ3Wq8zR4B+sld3IlK3oNIrxpiZt+Qr3IktsYiUG6
	 dT8FNwBwomXsbWwLe6gOyve76rM4BO82naE9OK/CyciH2GCO13RunKD135Lra5mjkT
	 t4BBdb6RwuQf92lVANgFo4Y9urFQStQGkfG3Jjf7w2RPMVj01SX/SU8i4EjPhiAbTG
	 gEYMk9FJ/5zHw==
Message-ID: <sashiko-outbox-213891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf tool_pmu: Add memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113233739.3626499-2-irogers@google.com>
References: <20261113233739.3626499-1-irogers@google.com>
 <20261113233739.3626499-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:05:09 +0000
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
- [Medium] perf stat: wrong rusage fallback on exited target in
  read_single_counter()
- [Medium] perf tool_pmu: -ENOENT/-EINVAL on exiting thread in
  open_memory_pid_dir()
--

commit 8ab23533dd054a2605a53d9e5d6408d9b222edde
Author: Ian Rogers <irogers@google.com>

perf tool_pmu: Add memory events

This commit adds tool PMU events exposing process and system-wide memory
usage metrics from /proc/<pid>/smaps_rollup and /proc/<pid>/statm, with a
wait4() rusage fallback for memory_rss when a forked workload exits.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 37752d6bfef45..d2c8c0ccea495 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -139,6 +139,7 @@ static const char		*output_name;
>  static int			output_fd;
>  static char			*metrics;
>  static struct rusage_stats	ru_stats;
> +static bool			ru_stats_valid;
> =20
>  struct perf_stat {
>  	bool			 record;
> @@ -283,12 +284,13 @@ static int read_single_counter(struct evsel *counte=
r, int cpu_map_idx, int threa
>  	int err =3D evsel__read_counter(counter, cpu_map_idx, thread);
> =20
>  	/*
> -	 * Reading user and system time will fail when the process
> -	 * terminates. Use the wait4 values in that case.
> +	 * Reading user, system time and memory_rss will fail when a forked
> +	 * workload terminates. Use the wait4 values in that case.
>  	 */
> -	if (err && cpu_map_idx =3D=3D 0 &&
> +	if (err && cpu_map_idx =3D=3D 0 && thread =3D=3D 0 && ru_stats_valid &&
>  	    (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_USER_TIME ||
> -	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)) {
> +	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME ||
> +	     evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_MEMORY_RSS)) {
>  		struct perf_counts_values *count =3D
>  			perf_counts(counter->counts, cpu_map_idx, thread);
>  		struct perf_counts_values *old_count =3D NULL;
> @@ -299,10 +301,15 @@ static int read_single_counter(struct evsel *counte=
r, int cpu_map_idx, int threa
> =20
>  		if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_USER_TIME)
>  			val =3D ru_stats.ru_utime_usec_stat.mean;
> -		else
> +		else if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)
>  			val =3D ru_stats.ru_stime_usec_stat.mean;
> +		else
> +			val =3D (u64)stat_config.ru_data.ru_maxrss * 1024ULL;
> =20
> -		count->val =3D val;
> +		if (evsel__tool_event(counter) =3D=3D TOOL_PMU__EVENT_MEMORY_RSS && ol=
d_count)
> +			count->val =3D old_count->val + val;
> +		else
> +			count->val =3D val;

[Severity: Medium]
Can read_single_counter() substitute the forked command's wait4() rusage
for an exited -p or -t target?

When profiling an explicit target while a child command bounds the
measurement (for example, perf stat -e memory_rss -p <pid> -- sleep 0.1),
reap_workload() -> update_rusage_stats() sets ru_stats_valid =3D true from
the child command without checking target__none(&target).  If the
monitored target exits before read_counters() runs, evsel__read_counter()
fails on thread =3D=3D 0 and read_single_counter() reports the child comman=
d's
ru_maxrss (or user/system time) as the target's counter value instead of
not counted.  On multi-threaded -p targets, sibling threads have dir_fd =3D=
=3D
-1 after Tgid deduplication and return 0 from evsel__tool_pmu_read(), so
the fallback value succeeds for the whole target.

> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index d2f7591747d94..0ae08cd910bc4 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
[ ... ]
> @@ -203,6 +236,205 @@ static int read_pid_stat_field(int fd, int field, _=
_u64 *val)
[ ... ]
> +static int read_pid_tgid(int dir_fd, int *tgid)
> +{
> +	char buf[1024];
> +	struct io io;
> +	u64 val;
> +	int fd, ret;
> +
> +	fd =3D openat(dir_fd, "status", O_RDONLY);
> +	if (fd < 0)
> +		return -errno;
> +
> +	io__init(&io, fd, buf, sizeof(buf));
> +	ret =3D read_proc_status_u64(&io, "Tgid:", &val);
> +	close(fd);
> +	if (!ret)
> +		*tgid =3D (int)val;
> +	return ret;
> +}
[ ... ]
> @@ -258,19 +490,138 @@ static int tool_pmu__read_stat(struct evsel *evsel=
, int cpu_map_idx, int thread,
>  	return err;
>  }
> =20
> +static int open_memory_pid_dir(enum tool_pmu_event ev, int pid,
> +			       int *seen_tgids, int *nr_seen_tgids, int *out_fd)
> +{
> +	const char *file =3D "smaps_rollup";
> +	int dir_fd, test_fd, tgid =3D -1;
> +	char buf[PATH_MAX];
> +
> +	*out_fd =3D -1;
> +	snprintf(buf, sizeof(buf), "%s/%d", procfs__mountpoint(), pid);
> +	dir_fd =3D open(buf, O_RDONLY | O_DIRECTORY);
> +	if (dir_fd < 0)
> +		return -errno;
> +
> +	if (seen_tgids) {
> +		int err =3D read_pid_tgid(dir_fd, &tgid);
> +
> +		if (err) {
> +			close(dir_fd);
> +			return err;
> +		}
> +		for (int i =3D 0; i < *nr_seen_tgids; i++) {
> +			if (seen_tgids[i] =3D=3D tgid) {
> +				close(dir_fd);
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	if (ev =3D=3D TOOL_PMU__EVENT_MEMORY_SIZE ||
> +	    ev =3D=3D TOOL_PMU__EVENT_MEMORY_DATA ||
> +	    ev =3D=3D TOOL_PMU__EVENT_MEMORY_TEXT)
> +		file =3D "statm";
> +
> +	test_fd =3D openat(dir_fd, file, O_RDONLY);
> +	if (test_fd < 0) {
> +		int err =3D -errno;
> +
> +		close(dir_fd);
> +		return err;
> +	}

[Severity: Medium]
Does open_memory_pid_dir() returning -ENOENT or -EINVAL when a thread exits
during counter setup cause stat_handle_error() to skip the memory event as
unsupported?

When a thread in the thread map terminates between enumeration and
open_memory_pid_dir(), open() or openat() fails with ENOENT, or read() on
status fails with ESRCH and makes read_proc_status_u64() return -EINVAL.
In builtin-stat.c, stat_handle_error() treats both ENOENT and EINVAL as
COUNTER_SKIP ("event is not supported by the kernel") before reaching the
vanished-thread retry path:

tools/perf/builtin-stat.c:stat_handle_error() {
	if (err =3D=3D EINVAL || err =3D=3D ENOSYS || err =3D=3D ENOENT || err =3D=
=3D ENXIO) {
		...
		return COUNTER_SKIP;
	}
	...
	if (target__has_per_thread(&target) &&
	    evlist__core(evsel_list)->threads &&
	    evlist__core(evsel_list)->threads->err_thread !=3D -1) {

Instead of ignoring the exited thread in --per-thread or multi-threaded -p
mode, perf stat skips the memory counter for the entire run.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113233739.3626=
499-1-irogers@google.com?part=3D1
