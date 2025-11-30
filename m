Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B12773F0
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Nov 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764503028; cv=none; b=cnyLOrh8A/tZ2SbsWtQ0KbsdVv/roSJ0GauqeqH2JlZy79A6s6qPEdHiawpeXd8HDkvpSVJRxcn+tWEe/mf72S9y0z5jtI/8QQ15oNNYLqfU0iP82nfeJuXBdLh1d/JNoW67UyioMeQ7ovV0cX5ZChhJwOYJzLHhffJHcm2ITzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764503028; c=relaxed/simple;
	bh=jlkwVzOX4lz5SnG4r7UvKPXL7RbcYVso5mLgneTlzbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gv//LsSpAUdlCqZEaCHyc7G9GDIxdnbw4HyjaH3ehB65ZSj/j+GTWUvbsrNtuM6nEjQaskPedMEmdsgbZk8b3HYXhgHNDWkwtbT2/fWJmC8koat+SbdXXG3CkiabXH3fZ49afwmYU/7H8p6AXGP1sD96NkqyqznadsvP8Ks0Q18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/wHsBHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/wHsBHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED02C4CEF8;
	Sun, 30 Nov 2025 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764503028;
	bh=jlkwVzOX4lz5SnG4r7UvKPXL7RbcYVso5mLgneTlzbs=;
	h=Date:From:To:Cc:Subject:From;
	b=j/wHsBHvCLnb1R7nXaliOtA06fFnG+9R6amcN0Z5KOjQmSflFaBQcCCxnfKl8vWVK
	 FVEvfYpwXEcCA27jhd8qEgipshI0ksgHLSPWGaMNB2g0yg6zRNOMUUmyOmfaaqsUph
	 Oz8t/7Y7FtM0oQJIixqsbbZMUTrpluBRA2hAyToSsDnC1Fddi1qB6aA9emoRDjaqkM
	 u0Kb0ZwcyWDlxn3uASkL5E/zZBtZAPOoIP9gaqXdqJxIZtCHEwMssGzw2qQw0en1FB
	 /5eBiDls4l/9yd0k2JxSUIKf7E5FNZHDhCYUwiyKljkVCZB3U74WoK8l3rmx36YtPt
	 EkGrYoiE0Ec4g==
Date: Sun, 30 Nov 2025 12:43:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: [PATCH] Fix (well, work around) perf stat --null segfault
Message-ID: <aSwt7yzFjVJCEmVp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

JFYI:

  starship:~> perf stat --null ls
  Segmentation fault (core dumped)


  Program received signal SIGSEGV, Segmentation fault.
  0x000055555563596e in __perf_cpu_map__nr (cpus=<error reading variable: Cannot access memory at address 0x0>) at cpumap.c:257
  257		return RC_CHK_ACCESS(cpus)->nr;
  (gdb) bt
  #0  0x000055555563596e in __perf_cpu_map__nr (cpus=<error reading variable: Cannot access memory at address 0x0>) at cpumap.c:257
  #1  perf_cpu_map__max (map=0x0) at cpumap.c:372
  #2  0x00005555555cc249 in perf_stat_init_aggr_mode ()
  #3  0x00005555555d1963 in cmd_stat ()
  #4  0x0000555555631bb2 in run_builtin ()
  #5  0x0000555555631e9e in handle_internal_command ()
  #6  0x00005555555ab183 in main ()
  (gdb) 

  (gdb) print cpus
  Cannot access memory at address 0x0
  (gdb) bt
  #0  0x000055555563596e in __perf_cpu_map__nr (cpus=<error reading variable: Cannot access memory at address 0x0>) at cpumap.c:257
  #1  perf_cpu_map__max (map=0x0) at cpumap.c:372
  #2  0x00005555555cc249 in perf_stat_init_aggr_mode ()
  #3  0x00005555555d1963 in cmd_stat ()
  #4  0x0000555555631bb2 in run_builtin ()
  #5  0x0000555555631e9e in handle_internal_command ()
  #6  0x00005555555ab183 in main ()
  (gdb) 

For some build(?) reason I cannot set breakpoints 
inside builtin-stat.c:

  (gdb) b builtin-stat.c:1545
  No source file named builtin-stat.c.

... and didn't investigate any further.

System has 128 CPUs.

It's been broken for some time:

  starship:~/tip> git bisect bad
  ced4c249569ab25c32b0d36e2ebdb19c74394bdf is the first bad commit
  commit ced4c249569ab25c32b0d36e2ebdb19c74394bdf (HEAD)
  Author: Ian Rogers <irogers@google.com>
  Date:   Fri Jul 18 20:05:05 2025 -0700

    perf stat: Don't size aggregation ids from user_requested_cpus
    
    As evsels may have additional CPU terms, the user_requested_cpus may
    not reflect all the CPUs requested. Use evlist->all_cpus to size the
    array as that reflects all the CPUs potentially needed by the evlist.
    
    Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
    Signed-off-by: Ian Rogers <irogers@google.com>
    Tested-by: James Clark <james.clark@linaro.org>
    Link: https://lore.kernel.org/r/20250719030517.1990983-4-irogers@google.com
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>


The bug is the assumption that 
evsel_list->core.all_cpus exists at this stage.

The attached patch works this around like the old 
version, but there's more things wrong with this code:

BTW., I couldn't even find where all_cpus pointer gets 
allocated. It gets zalloc()-ed to NULL, and cleared 
back to NULL in two places:

  lib/perf/evlist.c:	evlist->all_cpus = NULL;
  lib/perf/evlist.c:	evlist->all_cpus = NULL;

But where does it get allocated? perf_cpu_map__nr() 
hides it in most cases that ->cpus_all is always NULL:

  int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
  {
        return cpus ? __perf_cpu_map__nr(cpus) : 1;
  }

Which in general is a code robustness red flag, for 
something this fundamental I doubt there should be any 
conditionality to this pointer. Allowing cpus pointers 
to be NULL and hiding it in the helpers hid a real bug 
for months.

So this code looks like a bit of a trainwreck. ;-)

In addition to fixing the bug, it might also make sense 
to add a testcase for 'perf stat --null'? (which is a 
better, more accurate 'time' utility)

As an additional report and side note, I still get this 
bogus message during a build on standard Ubuntu:

 Makefile.config:1151: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-latest-openjdk-devel

The suggested "e.g. openjdk-8-jdk" package *is* 
installed:

 starship:~/tip> dpkg -l | grep openjdk
 ii  openjdk-11-jre:amd64                                        11.0.29+7-1ubuntu1~25.10                            amd64        OpenJDK Java runtime, using Hotspot JIT
 ii  openjdk-11-jre-headless:amd64                               11.0.29+7-1ubuntu1~25.10                            amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
 ii  openjdk-17-jre:amd64                                        17.0.17+10-1~25.10                                  amd64        OpenJDK Java runtime, using Hotspot JIT
 ii  openjdk-17-jre-headless:amd64                               17.0.17+10-1~25.10                                  amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
 ii  openjdk-21-jre:amd64                                        21.0.9+10-1~25.10                                   amd64        OpenJDK Java runtime, using Hotspot JIT
 ii  openjdk-21-jre-headless:amd64                               21.0.9+10-1~25.10                                   amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
 ii  openjdk-8-jdk:amd64                                         8u472-ga-1~25.10                                    amd64        OpenJDK Development Kit (JDK)
 ii  openjdk-8-jdk-headless:amd64                                8u472-ga-1~25.10                                    amd64        OpenJDK Development Kit (JDK) (headless)
 ii  openjdk-8-jre:amd64                                         8u472-ga-1~25.10                                    amd64        OpenJDK Java runtime, using Hotspot JIT
 ii  openjdk-8-jre-headless:amd64                                8u472-ga-1~25.10                                    amd64        OpenJDK Java runtime, using Hotspot JIT (headless)

Thanks,

	Ingo

====================>

Signed-off-by: Ingo Molnar <mingo@kernel.org>

 tools/perf/builtin-stat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7006f848f87a..973b72218df7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1542,7 +1542,10 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
+	if (evsel_list->core.all_cpus)
+		nr = perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
+	else
+		nr = 0;
 	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
