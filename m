Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE479F0;
	Sun, 26 May 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716724727; cv=none; b=GoIHXJFV3+JYyX0nlEvSVHq8w7JwJKryQGDqqR+YaVonZ53o/d5sY051z0A/N0lLkYKVJGMf2zguOiKvE5qZc9oNHU2f2ZT7rkr8K3qYUUzE+DocbDRBs3vSJAZW5tZy3kDZu5sAtSSVsAl/TWCfis2wlOdhIOR/tTIRnouz82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716724727; c=relaxed/simple;
	bh=EWcBBtyN6+y2nkXr64hj8Ucg0fbw9yI7WdQnUzStA1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0PDqB5yhpsRouubI41vDNbkN/Io1LEIUoapUC46da96wCyELyVrzkemeYhV1bVg+XoRJc/rxBLTQMrbONoMkD3BTVoVFxA8y3fm+L2SAr+VtoGsUTIV0+qHxIRn9JWkRBLYcRYXGcim1xde/Ic5bagn0Cyw7qt0dEwTlXCVZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF+5wyAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF+5wyAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031FFC2BD10;
	Sun, 26 May 2024 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716724727;
	bh=EWcBBtyN6+y2nkXr64hj8Ucg0fbw9yI7WdQnUzStA1o=;
	h=From:To:Cc:Subject:Date:From;
	b=oF+5wyAbskOHXquGT9HktcZKJaiHignQKnd0rwofNHsksrLKpDL6szU8U/NO0lNRX
	 W3l2O95h2SQqou1ppjLJ8UlRYkXnOoxrpPYhMoVotGI94Rdss/2s8JhBKmjQs/JfOr
	 /zPMJzXIvd6ZE77wF9LDwbB7WSc8Qv31NEjKHzktvfk0tTX1qOVC0P1kFmSaKwO1vS
	 X6IKLNcpuMHVbf0RvZsT2+MmCH/3paoP78S0XWtUcDFvPMOwRGyHawydvxJj4fmvPd
	 NIX0KIk1EYfMTiC+voo7a5o8X33FM5m15oYhxVa+SdOFX6Cm32u0NcRk2FTmmHIHGr
	 yUm1F4RCJTB3A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Ethan Adams <j.ethan.adams@gmail.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Yang Jihong <yangjihong@bytedance.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fix for v6.10
Date: Sun, 26 May 2024 08:58:34 -0300
Message-ID: <20240526115834.4080389-1-acme@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling, with the revert no 'perf test'
regressions were noticed on this Intel hybrid system:

  root@x1:~# grep -m1 'model name' /proc/cpuinfo 
  model name	: 13th Gen Intel(R) Core(TM) i7-1365U
  root@x1:~# perf stat -a sleep 1
  
   Performance counter stats for 'system wide':
  
           12,054.90 msec cpu-clock                        #   11.998 CPUs utilized             
               1,865      context-switches                 #  154.709 /sec                      
                 108      cpu-migrations                   #    8.959 /sec                      
                 111      page-faults                      #    9.208 /sec                      
         418,070,471      cpu_atom/cycles/                 #    0.035 GHz                         (74.91%)
          55,680,862      cpu_core/cycles/                 #    0.005 GHz                       
          95,014,672      cpu_atom/instructions/           #    0.23  insn per cycle              (87.46%)
          33,161,707      cpu_core/instructions/           #    0.08  insn per cycle            
          18,525,790      cpu_atom/branches/               #    1.537 M/sec                       (87.49%)
           5,792,527      cpu_core/branches/               #  480.512 K/sec                     
           1,939,067      cpu_atom/branch-misses/          #   10.47% of all branches             (87.43%)
             238,479      cpu_core/branch-misses/          #    1.29% of all branches           
               TopdownL1 (cpu_core)                 #     33.3 %  tma_backend_bound      
                                                    #      6.5 %  tma_bad_speculation    
                                                    #     49.0 %  tma_frontend_bound     
                                                    #     11.2 %  tma_retiring           
               TopdownL1 (cpu_atom)                 #     16.5 %  tma_bad_speculation    
                                                    #      6.5 %  tma_retiring             (87.56%)
                                                    #     41.1 %  tma_backend_bound      
                                                    #     41.1 %  tma_backend_bound_aux  
                                                    #     35.8 %  tma_frontend_bound       (87.56%)
  
         1.004776564 seconds time elapsed
  
  root@x1:~#
  root@x1:~# perf stat -a -e cycles:P sleep 1
  
   Performance counter stats for 'system wide':
  
         273,063,480      cpu_atom/cycles:P/                                                    
         156,166,111      cpu_core/cycles:P/                                                    
  
         1.005749149 seconds time elapsed
  
  root@x1:~#
  
Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (1):
  Revert "perf parse-events: Prefer sysfs/JSON hardware events over legacy"

 tools/perf/util/parse-events.c | 31 ++++----------
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 62 ++++++++++-----------------
 4 files changed, 68 insertions(+), 103 deletions(-)

-- 
2.45.1

The following changes since commit 29c73fc794c83505066ee6db893b2a83ac5fac63:

  Merge tag 'perf-tools-for-v6.10-1-2024-05-21' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools (2024-05-21 15:45:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-1-2024-05-26

for you to fetch changes up to 4f1b067359ac8364cdb7f9fda41085fa85789d0f:

  Revert "perf parse-events: Prefer sysfs/JSON hardware events over legacy" (2024-05-26 08:41:34 -0300)

----------------------------------------------------------------
Revert a patch causing a regression as described in the cset:

    "This made a simple 'perf record -e cycles:pp make -j199' stop working on
    the Ampere ARM64 system Linus uses to test ARM64 kernels, as discussed
    at length in the threads in the Link tags below.

    The fix provided by Ian wasn't acceptable and work to fix this will take
    time we don't have at this point, so lets revert this and work on it on
    the next devel cycle."

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      Revert "perf parse-events: Prefer sysfs/JSON hardware events over legacy"

 tools/perf/util/parse-events.c | 31 +++++------------
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.l | 76 +++++++++++++++++++++---------------------
 tools/perf/util/parse-events.y | 62 ++++++++++++----------------------
 4 files changed, 68 insertions(+), 103 deletions(-)
