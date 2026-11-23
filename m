Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419319;
	b=duYGCsGCnTek1tgNOWMD38m0FMeRDKsPEdYT97NqrC1xOoLAg39iKVz74HSQVl+J+bA7
	 DF928jsek7XPoSf+5ItSGUweOmfj7fXiUI6wxDifpqrBuCoUBA8SQshfyJFUwFs/QBgr/
	 6y3IwoZOUxP0Mp0n73WpZNuat2mf73V8e7Z+sUQazQU1twf5jupMuRQxjcGgAsgld4k3y
	 a6eE9h0GJRYUk1kFMT0LXiBOsvvEyRBX9fVSp2y/u01mQ1uI1b75ad1+lNKV2vSrkZaR+
	 9xMY5yx+NRuUttXDVcTe4uHAjv/k6GC7CIQ30wzQyZRgRnyPmf61NL453EprmHro+EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lnqlM+2lLB/zxs3mer1+Dx87I9PZ4o5FLB+H2EvUsRI=;
	b=OIZDNOk+VYaFAOQeVWoYrQOlpKwJvbdP8IXff7tryXu9AW6DQJ5gSLamg5EsRAS2M/VN
	 gp5/F83oSQMXUDuIRJk4Uqb9yf12xFz/634RdMFjFdbovRpq+nrvuxEr57lZ/YZbG3l12
	 76Zs0oB9Tt2i/AwXUxb2cWyGk9hRxa2VQ2cM9pnlHIfPdBJgKLYKmER85ScjgKO47yapm
	 VxIaYXtgcw2TVOQyuHxu/JkXG6b7/87TFGXEXLGEryZyX02ZXgMUqDruP59eHEgQVG7uI
	 7XVsXSu6gEaJ5sTC32+gy0bNX5fywsEqRxjnKjMmJJNWzxa8lh0M07KorOo4lhznWCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlTg9Q7F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B8606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlTg9Q7F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99B81F000CA;
	Mon, 23 Nov 2026 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795419318;
	bh=lnqlM+2lLB/zxs3mer1+Dx87I9PZ4o5FLB+H2EvUsRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JlTg9Q7FFVABMWG02jmEbKTFu51zx4QX/+d7QvZbsXU7W95raWwzyis5MNQKWUIx7
	 ifWOr4qpZM/CQL0rA3oYwVYhrzsHMWv4se6yBYcc9kzszhd55SBKNL+UBrgg5y8NCT
	 pKLTOlcao56esLuFDavvnvRyxfxfjOvwVNHsa2+j6/9yiC+s3GGEeYEHEGYUWb7V0l
	 KfdgoRKpcPRf8OTMjtecXeREUsUPDlfnPbm6x5YqKaFcYrzmFaPwwQZcion6D5lfaO
	 JxWA9xfmklueKOLdlksGlPUBIkY04+NjVv+d52bjFSwIrxTQo5viprU112UoqXuInB
	 4m5xFfnxsXXlw==
Message-ID: <sashiko-outbox-228821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/13] perf stat: Preserve per-evsel CPU maps across
 stat record and report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123071913.653315-6-irogers@google.com>
References: <20261123071913.653315-1-irogers@google.com>
 <20261123071913.653315-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:35:18 +0000
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
- [Medium] perf test: false-positive grep match on error output in
  stat.sh
- [Low] perf stat: NULL counter->counts dereference in
  perf_event__process_stat_event()
--

commit d4e30cf2ee96dddd1f10329db7c3af1b94429be0
Author: Ian Rogers <irogers@google.com>

perf stat: Preserve per-evsel CPU maps across stat record and report

This commit serializes and restores per-evsel CPU maps in
PERF_EVENT_UPDATE__CPUS events so that per-evsel CPU restrictions are
preserved across perf stat record and report, with a fallback to the "any
CPU" map for older perf.data files.

> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index ac9e031831dac..43a158ee36098 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -77,6 +77,14 @@ test_stat_record_report() {
>      err=3D1
>      return
>    fi
> +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
> +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o - tr=
ue | \
> +    perf stat report -i - 2>&1 | grep -E -q "task-clock/cpu=3D${cpu}/"
> +  then
> +    echo "stat record and report test [Failed per-evsel CPU]"
> +    err=3D1
> +    return
> +  fi
>    echo "stat record and report test [Success]"
>  }
> =20
> @@ -89,6 +97,14 @@ test_stat_record_script() {
>      err=3D1
>      return
>    fi
> +  cpu=3D$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
> +  if ! perf stat record -e "task-clock/cpu=3D${cpu}/,task-clock" -o - tr=
ue | \
> +    perf script -i - 2>&1 | grep -E -q "task-clock/cpu=3D${cpu}/"
> +  then
> +    echo "stat record and script test [Failed per-evsel CPU]"
> +    err=3D1
> +    return
> +  fi
>    echo "stat record and script test [Success]"
>  }

[Severity: Medium]
Do these two pipelines pass even when perf stat report or perf script fails
with the bug this commit fixes?

When perf_event__process_stat_event() rejects the CPU, it prints "Invalid
CPU 0 for event task-clock/cpu=3D0/." to stderr.  Because stat.sh does not
enable pipefail and 2>&1 merges stderr into the pipe, grep matches
"task-clock/cpu=3D${cpu}/" inside the error message itself and returns 0.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9eec6deee190f..e9af99b8c0f8d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -5962,6 +5962,11 @@ int perf_event__process_event_update(const struct =
perf_tool *tool __maybe_unused
>  		if (map) {
>  			perf_cpu_map__put(evsel->core.pmu_cpus);
>  			evsel->core.pmu_cpus =3D map;
> +			if (!evsel->counts) {
> +				perf_cpu_map__put(evsel->core.cpus);
> +				evsel->core.cpus =3D perf_cpu_map__get(map);
> +				evsel->core.requires_cpu =3D !perf_cpu_map__has_any_cpu(map);
> +			}
>  		} else
>  			pr_err("failed to get event_update cpus\n");
>  		break;
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 25f31a1743682..0b139b93c5565 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
[ ... ]
> @@ -670,6 +671,23 @@ int perf_event__process_stat_event(const struct perf=
_tool *tool __maybe_unused,
>  		return -EINVAL;
>  	}
>  	cpu_map_idx =3D perf_cpu_map__idx(evsel__cpus(counter), (struct perf_cp=
u){.cpu =3D st->cpu});
> +	if (cpu_map_idx =3D=3D -1 && (s32)st->cpu =3D=3D -1 && counter->counts =
&&
> +	    evsel__nr_cpus(counter) > 0) {
> +		/*
> +		 * Older perf tools wrote pmu_cpus instead of cpus in
> +		 * PERF_EVENT_UPDATE__CPUS, leaving per-task counters with a
> +		 * CPU list instead of the "any CPU" (-1) map used by their
> +		 * PERF_RECORD_STAT events.
> +		 */
> +		struct perf_cpu_map *any_cpu =3D perf_cpu_map__new_any_cpu();
> +
> +		if (any_cpu) {
> +			perf_cpu_map__put(counter->core.cpus);
> +			counter->core.cpus =3D any_cpu;
> +			counter->core.requires_cpu =3D false;
> +			cpu_map_idx =3D 0;
> +		}
> +	}
>  	if (cpu_map_idx =3D=3D -1) {
>  		pr_err("Invalid CPU %d for event %s.\n", st->cpu, evsel__name(counter)=
);
>  		return -EINVAL;

[Severity: Low]
Can perf_event__process_stat_event() dereference a NULL counter->counts
pointer in perf_counts()?

Previously, evsel->core.cpus remained NULL until both the thread map and
CPU map events were processed and set_maps() allocated counter->counts, so
perf_cpu_map__idx() returned -1 whenever counter->counts was NULL.  Now
that perf_event__process_event_update() populates evsel->core.cpus before
counter->counts is allocated, a PERF_RECORD_STAT event arriving before
set_maps() runs can match a valid cpu_map_idx and reach
perf_counts(counter->counts, cpu_map_idx, st->thread) while counter->counts
is still NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123071913.6533=
15-1-irogers@google.com?part=3D5
