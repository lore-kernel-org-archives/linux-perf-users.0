Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DFA16DC07;
	Wed, 31 Jul 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470106; cv=none; b=k0/lpCAGx8qqtZgC1OJP17cy+LM5jra6NvutPDofRetT2mjBx7AagDXrdnhlTy8AAbZgGvyb0uooogkQz9nLR8okeO/nUAnFUjZaflgCCnOHYtsGTRA94tyBmqTVb7DAgiLy9AENB/soZPFx+KoW2U8KE6CMRc1+Jn7edksB1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470106; c=relaxed/simple;
	bh=35QfRKQoUhGdr9YthZIDsh1LPwHY2NuVSvspUJp1CAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqQVzPcWmmeqSae9tiuip3tbs8HgjZCvfEzntHVgJ4XC43wraw7SAdLWYtVLeAy2VCadhWA2E5FXez5or03zFSqLvU1aoPSGVMvTOv4QrJdFSRshgzSSAVFqx6M3DmGl746ZMAGv6JAsxCC+j18LySDKL/3H7f8gCvVKQYYFco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9HjWwAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9HjWwAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12ACC116B1;
	Wed, 31 Jul 2024 23:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470106;
	bh=35QfRKQoUhGdr9YthZIDsh1LPwHY2NuVSvspUJp1CAU=;
	h=From:To:Cc:Subject:Date:From;
	b=l9HjWwANTHbJqX7CKiOMzVB2Qmv5w5tn7x9ibme+W9Ej45C6QWG5Rp8XPCGId7/QC
	 OH7OyCe+Ndcu9bMtV1/Mw+8yNW4SngaiPI1VS1FH/OdOMBQr3Od+7p0Lfg4WO7Q93/
	 hRZATbhRPFo+c8inosoPvqSFgNuN5MmuiweVCx5odEF+VacNV3rG9hRHI+SwpVqCMb
	 7/X4hyarxiZo8NVYNA0zoI3PKP+giUiQpplR3mB3WoiJaa10LF7Iq4Y6Kbzu+BE+3d
	 YgxGZYI6iEYuBdq35R3jRquSDqHX0bl/osD6MfAXbx2RMuJpA3AYk1+1g3Ra78s1FQ
	 zioZ91xW+3nCg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCHSET 0/6] perf mem: Basic support for data type profiling (v1)
Date: Wed, 31 Jul 2024 16:54:59 -0700
Message-ID: <20240731235505.710436-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

As we added data type profiling, 'perf mem report' should support that
as well.  This patches just added a couple of convenient options.

  $ perf mem report -T -s mem
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 131  of event 'cpu/mem-loads,ldlat=30/P'
  # Total weight : 18561
  # Sort order   : mem,type
  #
  # Overhead       Samples  Memory access                            Data Type
  # ........  ............  .......................................  .........
  #
      14.84%            22  L1 hit                                   (unknown)
      12.02%             8  RAM hit                                  (unknown)
       7.68%             8  LFB/MAB hit                              (unknown)
       6.29%            12  L1 hit                                   (stack operation)
       3.97%             5  LFB/MAB hit                              struct psi_group_cpu
       3.69%             3  L1 hit                                   struct   
       3.18%             3  LFB/MAB hit                              (stack operation)
       2.89%             5  L3 hit                                   (unknown)
       2.58%             3  L1 hit                                   unsigned int
       2.31%             2  L1 hit                                   struct psi_group_cpu
       2.21%             2  LFB/MAB hit                              struct cfs_rq
       2.19%             2  RAM hit                                  struct sched_entity
       2.16%             1  L1 hit                                   struct task_struct
       1.85%             3  L1 hit                                   struct pcpu_hot
       1.78%             1  RAM hit                                  struct tss_struct
       1.72%             1  LFB/MAB hit                              struct mm_struct
       1.62%             2  L1 hit                                   struct psi_group
       ...


The code is also available at 'perf/mem-type-v1' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf hist: Correct hist_entry->mem_info refcounts
  perf mem: Free the allocated sort string
  perf mem: Rework command option handling
  perf tools: Add mode argument to sort_help()
  perf mem: Add -s/--sort option
  perf mem: Add -T/--data-type option to report subcommand

 tools/perf/builtin-mem.c     | 100 ++++++++++++++++++++++-------------
 tools/perf/builtin-report.c  |   4 +-
 tools/perf/util/hist.c       |  14 ++---
 tools/perf/util/map_symbol.c |  18 +++++++
 tools/perf/util/map_symbol.h |   3 ++
 tools/perf/util/mem-info.c   |  13 +++++
 tools/perf/util/mem-info.h   |   1 +
 tools/perf/util/sort.c       |  12 +++--
 tools/perf/util/sort.h       |   2 +-
 9 files changed, 116 insertions(+), 51 deletions(-)

-- 
2.46.0.rc1.232.g9752f9e123-goog

