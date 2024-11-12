Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381920B218;
	Tue, 12 Nov 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441233; cv=none; b=OiqYd0mz5CvNKLAvZz3Vvqbcd3J950Zk1HqRFwUMbYEvB74DeW2TzydjQ2WKiBRwuvY+uzXj5CicgrqN3qQ45CRvKEL5GDJmDQfc/VEmCOLMfBIy5fkSzeMdYde2zCpF616baXMLUwp3SHTTnHlascdXn589T6j9rtzjbNNR+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441233; c=relaxed/simple;
	bh=rjHZyXk/3959QHkhD4RQLVEu0+udPS3rqazDkBqcJuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9LFl54YasxKtfF7sjhxflGa+R32vyJTRdl3LiJVKmEl3pkUEnI/b7ZOyeQsBxUP0hjGQW9+mrThoTzcfXjuLCCeR2+U2dMm4/CC/AceX5oooj0uDM+R/nVTKChy3YdD8VJKMcYRzdzmSMQVfeua9EauOLOoOhIVs3E6mmI2zvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B785150C;
	Tue, 12 Nov 2024 11:54:18 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD86A3F66E;
	Tue, 12 Nov 2024 11:53:47 -0800 (PST)
Date: Tue, 12 Nov 2024 19:53:43 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] perf record: Skip don't fail for events that
 don't open
Message-ID: <20241112195343.GA404636@e132581.arm.com>
References: <20241026121758.143259-1-irogers@google.com>
 <20241026121758.143259-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241026121758.143259-4-irogers@google.com>

On Sat, Oct 26, 2024 at 05:17:57AM -0700, Ian Rogers wrote:
> 
> Whilst for many tools it is an expected behavior that failure to open
> a perf event is a failure, ARM decided to name PMU events the same as
> legacy events and then failed to rename such events on a server uncore
> SLC PMU. As perf's default behavior when no PMU is specified is to
> open the event on all PMUs that advertise/"have" the event, this
> yielded failures when trying to make the priority of legacy and
> sysfs/json events uniform - something requested by RISC-V and ARM. A
> legacy event user on ARM hardware may find their event opened on an
> uncore PMU which for perf record will fail. Arnaldo suggested skipping
> such events which this patch implements. Rather than have the skipping
> conditional on running on ARM, the skipping is done on all
> architectures as such a fundamental behavioral difference could lead
> to problems with tools built/depending on perf.
> 
> An example of perf record failing to open events on x86 is:
> ```
> $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> The LLC-prefetch-read event is not supported.
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> 
> $ perf report --stats
> Aggregated stats:
>                TOTAL events:      17255
>                 MMAP events:        284  ( 1.6%)
>                 COMM events:       1961  (11.4%)
>                 EXIT events:          1  ( 0.0%)
>                 FORK events:       1960  (11.4%)
>               SAMPLE events:         87  ( 0.5%)
>                MMAP2 events:      12836  (74.4%)
>              KSYMBOL events:         83  ( 0.5%)
>            BPF_EVENT events:         36  ( 0.2%)
>       FINISHED_ROUND events:          2  ( 0.0%)
>             ID_INDEX events:          1  ( 0.0%)
>           THREAD_MAP events:          1  ( 0.0%)
>              CPU_MAP events:          1  ( 0.0%)
>            TIME_CONV events:          1  ( 0.0%)
>        FINISHED_INIT events:          1  ( 0.0%)
> cycles stats:
>               SAMPLE events:         87
> ```

Thanks for James reminding me.  Tested on AVA platform:

# tree /sys/bus/event_source/devices/arm_dsu_*/events
  ...
  /sys/bus/event_source/devices/arm_dsu_9/events
  ├── bus_access
  ├── bus_cycles
  ├── cycles
  ├── l3d_cache
  ├── l3d_cache_allocate
  ├── l3d_cache_refill
  ├── l3d_cache_wb
  └── memory_error

# ./perf record -- sleep 0.1
 Error:
 Failure to open event 'cycles:PH' on PMU 'arm_dsu_0' which will be
 removed.
 cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
 Try 'perf stat'
 Error:
 Failure to open event 'cycles:PH' on PMU 'arm_dsu_1' which will be
 removed.
 cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
 Try 'perf stat'
 ...
 Error:
 Failure to open event 'cycles:PH' on PMU 'arm_dsu_15' which will be
 removed.
 cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
 Try 'perf stat'
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.008 MB perf.data (8 samples) ]

# ./perf report --stats

 Aggregated stats:
                TOTAL events:         67
                 MMAP events:         40  (59.7%)
                 COMM events:          1  ( 1.5%)
               SAMPLE events:          8  (11.9%)
              KSYMBOL events:          6  ( 9.0%)
            BPF_EVENT events:          6  ( 9.0%)
       FINISHED_ROUND events:          1  ( 1.5%)
             ID_INDEX events:          1  ( 1.5%)
           THREAD_MAP events:          1  ( 1.5%)
              CPU_MAP events:          1  ( 1.5%)
            TIME_CONV events:          1  ( 1.5%)
        FINISHED_INIT events:          1  ( 1.5%)
 cycles:P stats:
               SAMPLE events:          8

# ./perf stat -- sleep 0.1

 Performance counter stats for 'sleep 0.1':

              0.87 msec task-clock                       #    0.009 CPUs utilized
                 1      context-switches                 #    1.148 K/sec
                 0      cpu-migrations                   #    0.000 /sec
                52      page-faults                      #   59.685 K/sec
           877,835      instructions                     #    1.14  insn per cycle
                                                  #    0.25  stalled cycles per insn
           772,102      cycles                           #  886.210 M/sec
           191,914      stalled-cycles-frontend          #   24.86% frontend cycles idle
           219,183      stalled-cycles-backend           #   28.39% backend cycles idle
           184,099      branches                         #  211.307 M/sec
             8,548      branch-misses                    #    4.64% of all branches

       0.101623529 seconds time elapsed

       0.001645000 seconds user
       0.000000000 seconds sys

Tested-by: Leo Yan <leo.yan@arm.com>
