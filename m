Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FD199E9E;
	Mon, 26 Aug 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710247; cv=none; b=DxesvccCN4g+J5kmN4mADnlpjPTA9Pa6RUeW0iS6KMkgtDjEqEA/DNPFtNrJm63MataO8mZXGaLNzUuYdyUwyacIA05d2dKI6xv0vTR4BOIEpa/8hf7l2qsceMaJpa9zp72LWaZFra5kHT2atBaCJHterCTkniDI5W09NBD7SMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710247; c=relaxed/simple;
	bh=JkfxekS+W466Brz06l8M63jsU2+f+MeKbbTPTtcrgp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNXWM2P36evTZ28mxiZ90KD+mCeqhs5COJ+QSJYT8eC8ILq0wlDlakJ3efTB+QdlvdnJIwlTSo+5eWvW26QRs0i9wKfiKKCuHKscBcKm7aWtPA/fMK7XZae5kbCnbvNjm+JgKOSety0L4Kl811OPBzYnPb0KI/D+TseN2F+XYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+0CbOeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+0CbOeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88243C8B7BC;
	Mon, 26 Aug 2024 22:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724710247;
	bh=JkfxekS+W466Brz06l8M63jsU2+f+MeKbbTPTtcrgp8=;
	h=From:To:Cc:Subject:Date:From;
	b=U+0CbOeRSvMXFXyRClSB82HVXfyMGN4uVSGrjfWhc4oESuNvIolfPym3mCe1885f0
	 Nfzq1SmgHAT2VM39YyYiPBw6nhOhL4NLO3vAZR6vUXT5h7M2elRoHwjukQ90o///MA
	 TKnP0ndvcGgktqo3fXMz5AZaFeOPfwVS0B4tdkvqR1XEa/P74bLaImQgJsGDcW3xTc
	 3QiYNZ0UbCpnMajPeTlFwvmq/mgKNF4TUpoQ5nsW+NrDI4oCmksmc2vwOljaO1JLCP
	 vcHaQOmUid1vo2KO3oYCkpqVLeKEFQ2zk/rPsxQWL6N009FwtZL3EqdNlLEfMKBq4K
	 hrbJ296aczX6A==
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
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 0/4] perf bpf-filter: Add cgroup filter term (v1)
Date: Mon, 26 Aug 2024 15:10:41 -0700
Message-ID: <20240826221045.1202305-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm adding a new 'cgroup' filter term in the filter expression so that
it can be used in the BPF.

The cgroup filter takes a pathname and allows either '==' or '!='
operators only.  The requires '--all-cgroups' option so it can see the
cgroup_id in the sample data.  Actually BPF programs can get the
cgroup of the current task without looking sample data, but I added it
for consistency with other fields.

  $ sudo perf record --synth=cgroup -e cycles --filter 'cgroup > /' -a true
  perf_bpf_filter: cgroup accepts '==' or '!=' only

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

          --filter <filter>
                            event filter

  $ sudo perf record -e cycles --filter 'cgroup == /' \
      -a --synth=cgroup -o- sleep 1 | perf report -i- -s cgroup
  Error: cycles event does not have PERF_SAMPLE_CGROUP
   Hint: please add --all-cgroups option to perf record
  Failed to process filter entries
  failed to set filter "BPF" on event cycles with 2 (No such file or directory)
  incompatible file format (rerun with -v to learn more)

On the filter syntax, it used to reject arbitrary strings.  But it
needs to handle strings because of the cgroup paths.  For now, the bpf
filter parser will reject strings if it's not used for cgroups.

For now, it only supports the exact matching of target cgroups.  So
specifying the root cgroup ("/") will match tasks in the root cgroup
directly (not in the descendants).

  $ sudo perf record --all-cgroups -e cycles --filter 'cgroup == /' \
      -a --synth=cgroup -o- sleep 1 | perf report -i- -s cgroup
  ...
  #
  # Total Lost Samples: 0
  #
  # Samples: 621  of event 'cycles'
  # Event count (approx.): 108101281
  #
  # Overhead  Cgroup
  # ........  ......
  #
     100.00%  /
  
  

Thanks,
Namhyung


Namhyung Kim (4):
  perf report: Fix segfault when 'sym' sort key is not used
  perf bpf-filter: Add build dependency to header files
  perf bpf-filter: Support filtering on cgroups
  perf test: Add perf record cgroup filtering test

 tools/perf/tests/shell/record_bpf_filter.sh  | 39 ++++++++++++++++++--
 tools/perf/util/Build                        |  4 +-
 tools/perf/util/bpf-filter.c                 |  1 +
 tools/perf/util/bpf-filter.l                 | 28 +++++++++++---
 tools/perf/util/bpf-filter.y                 | 28 +++++++++++++-
 tools/perf/util/bpf_skel/sample-filter.h     |  2 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  4 +-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h   |  1 +
 tools/perf/util/hist.c                       |  2 +-
 9 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog

