Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF3364B2
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/BIu5Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD1DC433C7;
	Wed,  6 Dec 2023 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701885270;
	bh=2tDbHUTnzhDqadtqq25zkKFvVdsHBy1BabMsSbHH1NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/BIu5AhIWQu8lordRw4GUGC6QE/Qmhc85FS1bDfJXIZzFp3Ael8yQcVmw6B7nruV
	 7XgMQnmAiQdcNGHUldQ+Ao9W5GIgS956FnPuvgbFfc3BvxQxTFqYqmiKZAXl/8JyQJ
	 y2mz3ncsM0x/c42uxQXZ+p9chQEacmRpt3EEq3aN5b1i8vpsbZklVB9ZPd8x8tvulK
	 qXa3L0CymewN1R4Zv71fKHhSYT3Ar8f5P93mCaPwFP3CF9kfWpfZESWIUqXVnzwEum
	 FN6ViiLpeDgURjoEdfYZZBU01GuPnIOZA7oo626plAnjCvnoodMupBbK9ORoVRRRbc
	 b34ZbL86mkZ6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A81E8403EF; Wed,  6 Dec 2023 14:54:27 -0300 (-03)
Date: Wed, 6 Dec 2023 14:54:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Ayush Jain <ayush.jain3@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, kjain@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, barnali@linux.ibm.com,
	ananth.narayan@amd.com, ravi.bangoria@amd.com,
	santosh.shukla@amd.com
Subject: Re: [PATCH] perf test: Retry without grouping for all metrics test
Message-ID: <ZXC1U8y4JAUaQ6lm@kernel.org>
References: <20230614090710.680330-1-sandipan.das@amd.com>
 <1320e6e3-c029-2a8c-e8b7-2cfbb781518a@amd.com>
 <ZXByT1K6enTh2EHT@kernel.org>
 <CAP-5=fUoD=s9yyVPgV7tqGwZsJVQMSmHKd8MV_vJW438AcK9qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUoD=s9yyVPgV7tqGwZsJVQMSmHKd8MV_vJW438AcK9qQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Wed, Dec 06, 2023 at 08:35:23AM -0800, Ian Rogers escreveu:
> On Wed, Dec 6, 2023 at 5:08 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Humm, I'm not being able to reproduce here the problem, before applying
> > this patch:
 
> Please don't apply the patch. The patch masks a bug in metrics/PMUs

I didn't

> and the proper fix was:
> 8d40f74ebf21 perf vendor events amd: Fix large metrics
> https://lore.kernel.org/r/20230706063440.54189-1-sandipan.das@amd.com

that is upstream:

⬢[acme@toolbox perf-tools-next]$ git log tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
commit 8d40f74ebf217d3b9e9b7481721e6236b857cc55
Author: Sandipan Das <sandipan.das@amd.com>
Date:   Thu Jul 6 12:04:40 2023 +0530

    perf vendor events amd: Fix large metrics

    There are cases where a metric requires more events than the number of
    available counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four
    data fabric counters but the "nps1_die_to_dram" metric has eight events.

    By default, the constituent events are placed in a group and since the
    events cannot be scheduled at the same time, the metric is not computed.
    The "all metrics" test also fails because of this.

    Use the NO_GROUP_EVENTS constraint for such metrics which anyway expect
    the user to run perf with "--metric-no-group".

    E.g.

      $ sudo perf test -v 101

    Before:

      101: perf all metrics test                                           :
      --- start ---
      test child forked, pid 37131
      Testing branch_misprediction_ratio
      Testing all_remote_links_outbound
      Testing nps1_die_to_dram
      Metric 'nps1_die_to_dram' not printed in:
      Error:
      Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
      Testing macro_ops_dispatched
      Testing all_l2_cache_accesses
      Testing all_l2_cache_hits
      Testing all_l2_cache_misses
      Testing ic_fetch_miss_ratio
      Testing l2_cache_accesses_from_l2_hwpf
      Testing l2_cache_misses_from_l2_hwpf
      Testing op_cache_fetch_miss_ratio
      Testing l3_read_miss_latency
      Testing l1_itlb_misses
      test child finished with -1
      ---- end ----
      perf all metrics test: FAILED!

    After:

      101: perf all metrics test                                           :
      --- start ---
      test child forked, pid 43766
      Testing branch_misprediction_ratio
      Testing all_remote_links_outbound
      Testing nps1_die_to_dram
      Testing macro_ops_dispatched
      Testing all_l2_cache_accesses
      Testing all_l2_cache_hits
      Testing all_l2_cache_misses
      Testing ic_fetch_miss_ratio
      Testing l2_cache_accesses_from_l2_hwpf
      Testing l2_cache_misses_from_l2_hwpf
      Testing op_cache_fetch_miss_ratio
      Testing l3_read_miss_latency
      Testing l1_itlb_misses
      test child finished with 0
      ---- end ----
      perf all metrics test: Ok

    Reported-by: Ayush Jain <ayush.jain3@amd.com>
    Suggested-by: Ian Rogers <irogers@google.com>
    Signed-off-by: Sandipan Das <sandipan.das@amd.com>
    Acked-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ananth Narayan <ananth.narayan@amd.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Ravi Bangoria <ravi.bangoria@amd.com>
    Cc: Santosh Shukla <santosh.shukla@amd.com>
    Link: https://lore.kernel.org/r/20230706063440.54189-1-sandipan.das@amd.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com
 
> > Ian, I also stumbled on this:

> > [root@five ~]# perf stat -M dram_channel_data_controller_4
> > Cannot find metric or group `dram_channel_data_controller_4'
> > ^C
> >  Performance counter stats for 'system wide':

> >         284,908.91 msec cpu-clock                        #   32.002 CPUs utilized
> >          6,485,456      context-switches                 #   22.763 K/sec
> >                719      cpu-migrations                   #    2.524 /sec
> >             32,800      page-faults                      #  115.125 /sec

<SNIP>

> > I.e. -M should bail out at that point (Cannot find metric or group `dram_channel_data_controller_4'), no?

> We could. I suspect the code has always just not bailed out. I'll put
> together a patch adding the bail out.

Great, thanks,

- Arnaldo
