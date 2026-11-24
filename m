Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546690;
	b=W1kasXvhTrbAZCQtuphn+UAr7wMVgt7CkDa8qfZK3S+BQ+7JEm2uWwX//4EVS1+8XV1Y
	 Un/cciGy54lTN+WqkVfiXFKFqk08ffAnYFepb4vgGclE6wurTsbbpvmjKDN8AuPbXs/Xt
	 qG4ePK36EhI8GSkyLas03LilkqFPqVQFnT6/dPKI5UJrBxV0a3lNb74xfyMi11XC2Ut3C
	 zcJjYh74recWcuj3/5sT+Vxe7zjNyGGhZ1EnYXsyCQPK9Ls/HqsrEbZlpHhy4bw63CK/j
	 Q2rRwxCsnzSUmcwOEMQ4m5Ev30kZI8+ZzZg8fkVALDjO6DxnacHqpI9tcpa85kF9Pcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d8EfmNC8N8QTMr/l6Z7PxmkZtTqqicYk90unsokDooo=;
	b=aU4DVkF/1gRetA3pqYcaXFkvhrMzZQqshge7ZWJlOMY9psezODGm+6v/8Ckuk7PDiSwg
	 a3iYvfjkB2QKI+J3n8RGNXTAZ8HoPnrE2/BTh/YEA1ZJz7964So5zoxBSvC4hqHRkfRLS
	 ucojrF2qQTZl99YOqLnIdcSeh/SUZf4Lx/GfVOg8REhPY8rYxgpF4uXydcygZ40k/t08Z
	 lp2jbJl3QUiYAjD9wo/b13FwiHFDu3PjkWvolv2SY/Igaava6TVGAEZ5BMbHGcsmRxS//
	 X9I4HZXGRql+xoZbn66hPa/yDWbWZIdTJL09CMA6vIUmH4MeNNyNfLoNy1pjWU9lkMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hx50KSSO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81C606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hx50KSSO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D928F1F000C6;
	Tue, 24 Nov 2026 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546689;
	bh=d8EfmNC8N8QTMr/l6Z7PxmkZtTqqicYk90unsokDooo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hx50KSSOEeYaSdy8uRp6vKNAfGhOO+XlGHsGvsTSUYODrq1AzxHs3Vn9Bn6RyNjpb
	 K2/tInmdUqeH7Gcc/DZXrLQqey1fpaS2c94+i72DAXG4H8SVLPoTDUrjS8W34ElUXt
	 IrKt0LGhpzz6ALfYy9W2jeJRUcsCajy3CSGP8S8LuTA0WggRZG8qUbY/zyfsSMVgaT
	 IyiDTl6fme8OtxuIqXUqksKKH5F7Ubc+K+E0ihAkV4IM7TZHr1iX62W++yj5u4e9VW
	 c3ZTaL8JglJuTlTja1qPgesO8sGeyU+9o1yQGUQlwNP/tQw5LZZWf5fHeYegGcJ2sP
	 mUeNbENIOyUrw==
Message-ID: <sashiko-outbox-231868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/17] perf tests sched: Exercise the sched views and
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-3-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:58:08 +0000
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
- [Medium] perf tests sched: untriggered migration check in
  test_sched_timehist_options()
- [Medium] perf tests sched: missing /proc/schedstat check before
  running stats tests
--

commit f3373bb8ae42cb050e4a69b6377d03f44916ae77
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests sched: Exercise the sched views and options

This commit captures perf sched output to a temporary file before
checking it with grep, drops --no-inherit from perf sched record, and
adds test cases for latency, map, timehist, and schedstat options.

> diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sch=
ed.sh
> index 113df962a51c8..e1aa8570b21f4 100755
> --- a/tools/perf/tests/shell/sched.sh
> +++ b/tools/perf/tests/shell/sched.sh

[ ... ]

> @@ -56,90 +61,153 @@ cleanup_noploops() {

[ ... ]

> +test_sched_timehist_options() {
> +  run_sched "timehist summary" "Runtime summary" timehist --summary -i "=
${perfdata}"
> +  run_sched "timehist wakeups" "awakened:" timehist -w -i "${perfdata}"
> +  run_sched "timehist migrations" "migrated:" timehist -M -i "${perfdata=
}"

[Severity: Medium]
Can this test fail when no task migration occurs during the 1-second
recording window?

start_noploops() pins both perf-noploop workload processes to CPU 0 with
taskset -pc 0 before perf sched record runs, so neither workload task can
migrate across CPUs.  timehist_print_migration_event() only prints
"migrated:" when a sched:sched_migrate_task event is present in
perf.data, so on single-CPU systems or quiet multi-CPU systems where no
unrelated task migrates during sleep 1, this check fails with missing
'migrated:'.

> +  run_sched "timehist idle" "Idle-time summary" timehist -I --summary -i=
 "${perfdata}"
> +  run_sched "timehist state" "sch delay" \
> +    timehist --state --show-prio -V -P -i "${perfdata}"
> +  run_sched "timehist call graph" "" timehist -g --max-stack 3 -i "${per=
fdata}"
> +  run_sched "timehist pid filter" "" timehist -p "${PID1}" -i "${perfdat=
a}"
> +  run_sched "timehist prio filter" "" timehist --show-prio --prio 0 -i "=
${perfdata}"
> +  run_sched "timehist with summary" "perf-noploop" timehist -S -i "${per=
fdata}"
> +}
> +
> +test_sched_stats_live() {
> +  echo "Sched stats live"
> =20
> -  if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
> +  ret=3D0
> +  timeout -s INT -k 5 3 perf sched stats > "${schedout}" 2>&1 || ret=3D$?
> +  if [ "${ret}" !=3D 0 ] && [ "${ret}" !=3D 124 ]
>    then
> -    echo "Sched script [Failed missing output]"
> +    echo "Sched stats live [Failed: perf sched stats failed]"
> +    cat "${schedout}"
>      err=3D1
> +    return
>    fi
> -}
> =20
> -test_sched_map() {
> -  echo "Sched map"
> -
> -  if ! perf sched map -i "${perfdata}" | grep -q perf-noploop
> +  if ! grep -q "Description" "${schedout}"
>    then
> -    echo "Sched map [Failed missing output]"
> +    echo "Sched stats live [Failed missing output]"
>      err=3D1
> +    return
>    fi
> +  echo "Sched stats live [Success]"
>  }
> =20
> -test_sched_timehist() {
> -  echo "Sched timehist"
> -
> -  if ! perf sched timehist -i "${perfdata}" | grep -q perf-noploop
> +test_sched_stats_record() {
> +  if ! perf sched stats record -o "${statsdata}" sleep 1
>    then
> -    echo "Sched timehist [Failed missing output]"
> +    echo "Sched stats record [Failed: perf sched stats record failed]"
>      err=3D1
> +    return
>    fi
> +  if [ ! -s "${statsdata}" ]
>    then
> +    echo "Sched stats record [Failed: no data file]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Sched stats record [Success]"
> +}
> +
> +test_sched_stats_report() {
> +  run_sched "stats report" "Description" stats report -i "${statsdata}" =
-C 0 -v
> +}
> +
> +test_sched_stats_diff() {
> +  run_sched "stats diff" "" stats diff "${statsdata}" "${statsdata}"
>  }

[Severity: Medium]
Should the stats subtests be skipped when /proc/schedstat is absent?

Unlike perf sched record, which checks schedstat_events_exposed() before
adding sched_stat tracepoints, perf sched stats live and record call
perf_event__synthesize_schedstat() and enable_sched_schedstats(), which
require /proc/schedstat and /proc/sys/kernel/sched_schedstats.  On
kernels built with CONFIG_SCHEDSTATS=3Dn (the default in
lib/Kconfig.debug), these stats tests fail the suite.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D2
