Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73437E2E2;
	Wed,  7 Oct 2026 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331229; cv=none; b=TVtxBaGPEfewGJHxTmNF2QT62GZ/FSqqFkjcIRisAj+zyVpI+WXYLTfrU2zq5HpaAYIltCJ1/HZS836pDFrJZBAWih1c5piXL8wuoOrp0JKhGqNN/xSFh8A0S4Q5nO5IS4mWDRkGTJqyL0hsBNWKqy+iqTo42LG16+kbjlg+uZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331229; c=relaxed/simple;
	bh=O8cjTq4VeULJjq0zHalstFo9Np73snipNdj7AQn6teE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOEQ1goSyWfrSI5vODFp/vCt0RUMYgBVA2DXqwmWX69ib74otcCUaIqtD53Fb77Kpl77DWLeQ1fhSAaZt0uYA/My92GrzQ9dEM0K8t5DHBT/AEJdXskcjXjLEllxPy3OqVTQpxOH+hOP53V0qQWZpFOGDl92YszB8Y2oRD1g5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSduVHKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSduVHKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61FF1F0089B;
	Wed,  7 Oct 2026 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791331228;
	bh=DJ5e6p3gSH3PMxt48dwVWIWVlP69WqN7ftz9vaqSN9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WSduVHKqC+5HP0TI2IaWUo+Ok8wHRpr63cvmfWVIEuMz/eUpUPxgg/8pVIt/sdBqQ
	 k+whirIH+ghKH+ld5UMYgtYKXjFHkn0yfXnRc/sIKyGyMZQW9OB9ZbROMhv4d+kmLu
	 4ilSkqFitCeZGszKGXZIj9cXDMsUBI9QcIa8OWgkRkbLQrvXzQQM7k0p/1bn1FSv9s
	 21xg0R8WcqFZ4htRoFZ46RHv9pTizctg5FOhHyL66JN/LefQoqb33CM9/51xg/Hbcm
	 m3lozTjkcEKJbxHa7rY+elieXKOFkSMrh/xUiCN7eAyosVHzbt9XOg47oaH1Ue+9kP
	 MQ9byiyE24dkQ==
Date: Tue, 6 Oct 2026 17:00:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/6 v1] perf test attr: Fix the re-enabled test
Message-ID: <asWLmvF-3YtoKJ7j@google.com>
References: <20261006161309.3078488-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006161309.3078488-1-acme@kernel.org>

On Tue, Oct 06, 2026 at 06:13:03PM +0200, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hello all,
> 
> This series fixes the "Perf attribute expectations test" (perf test 82,
> formerly "Setup struct perf_event_attr").
> 
> Patches 1-2 are Michael Petlan's prerequisite fixes that make the shell
> wrapper propagate attr.py's return value and correct the
> perf_event_attr size expectation after struct config4 was added.  They
> are included at the start of the series so that it applies cleanly on
> the current perf-tools-next (and for the review bots to verify the new
> patches); the new fixes are patches 3-6.
> 
> With the test reporting failures again, several stale expectations
> surfaced and are addressed here:
> 
> - test-record-graph-dwarf still expected PERF_SAMPLE_ADDR and
>   PERF_SAMPLE_DATA_SRC for --call-graph dwarf.  Those were dropped by
>   bdd051e249141c79 ("perf record: Split --data-mmap option"), which
>   decoupled data MMAP recording from the sample address bits.
> 
> - The record and stat group tests expected cache-misses and
>   instructions to be the legacy PERF_TYPE_HARDWARE events, but since
>   b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy
>   hardware and cache parsing") they resolve to the core PMU sysfs/JSON
>   events, so request the legacy encodings explicitly with the
>   legacy-hardware-config term.
> 
> - The perf stat default metrics open their events in groups and the
>   raw encodings of instructions, branch-misses, cpu-cycles and
>   stalled-cycles-frontend/backend differ between Intel and AMD, so
>   base-stat now accepts the standalone and group variants and
>   test-stat-default/detailed-{1,2,3} gained the per-vendor raw
>   encodings.
> 
> - attr.py no longer requires a recorded event to be in a group when
>   the matching expectation does not declare one, allowing the stat
>   tests to verify event attributes without encoding the metric
>   grouping.  Expectations that declare a group are still verified in
>   both directions.
> 
> The test passes with 'perf test -vv attribute' on x86_64.  The AMD
> encodings come from the amd_pmu_event_map tables in
> arch/x86/events/amd/core.c.

On my machine, the current tmp.perf-tools-next which contains these
changes fails like this.

  $ tools/perf/perf test -v 82
  ---- start ----
  test child forked, pid 931585
  /home/namhyung/project/linux/tools/perf/tests/shell/attr.sh: line 20: python: command not found
  ---- end(-1) ----
   82: Perf attribute expectations test                                                 : FAILED!
  
  === Test Summary ===
  Passed main tests : 0
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 1
  List of failed tests:
     82: Perf attribute expectations test

The below patch fixes the problem.

Thanks,
Namhyung


diff --git a/tools/perf/tests/shell/attr.sh b/tools/perf/tests/shell/attr.sh
index 307e1535795a34dc..ca3ca4a193971ec1 100755
--- a/tools/perf/tests/shell/attr.sh
+++ b/tools/perf/tests/shell/attr.sh
@@ -4,6 +4,10 @@
 
 err=0
 
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
 cleanup() {
   trap - EXIT TERM INT
 }
@@ -17,7 +21,7 @@ trap trap_cleanup EXIT TERM INT
 
 shelldir=$(dirname "$0")
 perf_path=$(which perf)
-python "${shelldir}"/lib/attr.py -d "${shelldir}"/attr -v -p "$perf_path"
+$PYTHON "${shelldir}"/lib/attr.py -d "${shelldir}"/attr -v -p "$perf_path"
 err=$?
 cleanup
 exit $err
