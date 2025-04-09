Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB02940F;
	Wed,  9 Apr 2025 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165426; cv=none; b=CXTDcpijfwWhgfmN0g0avPm0fGWC8yms8xD2/xN0c9K86mrFlA/Q4VZpgbyW5s/dMxqMqUTjsaeR9Ae6w1o26D8DFkpwqgCyXbfnTs5p6bEbGqkoLlVUHibEfv2qcjvaXJ0DMPcGu5gj76tHsJWOD95Oxa0XBXSeLpw7mmvHNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165426; c=relaxed/simple;
	bh=MFPau5lifW8jMHZfdSw/2NIo4U/nm4MojtGTr6OejvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IE67xO1vS0ttFzC9Cm6kNytfEJyddYrk/YLFfoHNc196DRGrHGZGyzkVW9DUoEdj6AC0RcwAWE9QbOcZ1xSoUi1qxmMGH34WEi/JmQdZ9oWJfr5C3jJvbzc+x4YNJohYzah2AVhItTBKf4fJZ4FITXbKP1wUzfso9LjPjsXDrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDO8Siqy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDO8Siqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744165424; x=1775701424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MFPau5lifW8jMHZfdSw/2NIo4U/nm4MojtGTr6OejvA=;
  b=dDO8Siqys7DzuxEvSpe77omIdtD2GWcQzhjauHflJcrfMachxAGCH4mc
   1PzeTVD45B+yrBP/ZY+Z4ObtOrOTEXHQS5E7nurP+1zRCQtPhWxbkdbrn
   vc8tGh3qFIjDrfMUmPaNPRKGqxjYidYUtTHThjSD0oMrL/Mk3yWPZJa8l
   +ZrYyO4YfqipK4XQQjetvorQOC6SVdEn9nfV9fVoIx+8Cqq0iTwIUqLya
   OoqgYf9TIm8m30ULMAtthM5SArjCYV+oIRXPRYOiBQDKwjEdGs8/8YXot
   Ph4gA9jjFAR9IgxMW1GaNH2MZ83U9PBSihUoU4ZRZIXSUSq1/dogWElk0
   A==;
X-CSE-ConnectionGUID: ohBDsV96RoK/XZCdlNcHBA==
X-CSE-MsgGUID: dCEoFr3rQv2P1V6GgWaWoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45784192"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45784192"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 19:23:43 -0700
X-CSE-ConnectionGUID: Ppnwobg6RqKNtrFV7mD+Qw==
X-CSE-MsgGUID: Stmnr3IERtGTLHBlnrrVNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="165675265"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.153.94])
  by orviesa001.jf.intel.com with ESMTP; 08 Apr 2025 19:23:39 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] perf symbols: Ignore mapping symbols on riscv
Date: Wed,  9 Apr 2025 10:51:56 +0800
Message-ID: <20250409025202.201046-1-haibo1.xu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISCV ELF use mapping symbols with special names $x, $d to
identify regions of RISCV code or code with different ISAs[1].
These symbols don't identify functions, so will confuse the
perf output.

The patch filters out these symbols at load time, similar to
"4886f2ca perf symbols: Ignore mapping symbols on aarch64".

[1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/
    master/riscv-elf.adoc#mapping-symbol

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/perf/util/symbol-elf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fbf6d0f73af9..55b1409b0593 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1733,6 +1733,12 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				continue;
 		}
 
+		/* Reject RISCV ELF "mapping symbols" */
+		if (ehdr.e_machine == EM_RISCV) {
+			if (elf_name[0] == '$' && strchr("dx", elf_name[1]))
+				continue;
+		}
+
 		if (runtime_ss->opdsec && sym.st_shndx == runtime_ss->opdidx) {
 			u32 offset = sym.st_value - syms_ss->opdshdr.sh_addr;
 			u64 *opd = opddata->d_buf + offset;
-- 
2.43.0

