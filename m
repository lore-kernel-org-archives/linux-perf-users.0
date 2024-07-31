Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47E16EB6F;
	Wed, 31 Jul 2024 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470109; cv=none; b=qXHGN2LYbYnzLSLsbnqmXR0p1eJzDXu1DHwxpFxE19IxvVDU8bNTEmc6TXI6WzOSfvJGsL5XegOzCndcTNC2RkmgrwbbyC37YZscu6McDUafMp1ra5OoXH0sYQPiykHC/EhrQ+z2Gl/aWSD5pgJ2E7PAwhoJ6kWWvv4ON8aGfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470109; c=relaxed/simple;
	bh=Nt8bzaBEKnKY7ibLeGPc+4KHENLftiNUZpsx2dBIThk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4oG7JxZlwFxninNW/anwDJHaC+eYX3Sz2PKCUMiO0Bw4Sth+X7pcZC+FeHejmh0eE5uRGo5wMZ4EM3tnnJPAcuK32Wx4mDyXz8Or5uYkDSVyS61Q4DV/mdJsscnUIVBxIGzkLgTv7kwUguagjqv2BA5/SwsQWpDs/Nxg7s4Q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcKLKHAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcKLKHAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A85DC4AF0F;
	Wed, 31 Jul 2024 23:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470109;
	bh=Nt8bzaBEKnKY7ibLeGPc+4KHENLftiNUZpsx2dBIThk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcKLKHAetY4RuxidTZEmhKt0NAD8Ax8THcRA7FEhCo7eoku5Ku5UOG9bUzvhYlF2B
	 Vag236IHEKgu71lY7VAzk0p9ynfYzqGfoyOTauQgnxuZdN6UGe8/2GS2t4dVP1KZfi
	 +ucCPH9eMC7g2VQWbsyh/3eLUIJgPtNrrPdpJPiqqeyXRh0aeRw5sxVC1cad+k2HE+
	 kLUhKvDDKS9JyVI1zHEfILwhiKxTIUX3nRXvulp8z6x4iXuiUR7kGdArvDroLvLwiy
	 4ua0aEKDzR7BHATIKFiwDRMOD795KfIjmEy9xVN8MqMjnDaD7vZRQ+plsasHkC0VdU
	 CnxNcKQSwVgEQ==
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
Subject: [PATCH 5/6] perf mem: Add -s/--sort option
Date: Wed, 31 Jul 2024 16:55:04 -0700
Message-ID: <20240731235505.710436-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731235505.710436-1-namhyung@kernel.org>
References: <20240731235505.710436-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that users can set the sort key manually as they want.

  $ perf mem report -s
   Error: switch `s' requires a value
   Usage: perf mem report [<options>]

      -s, --sort <key[,key2...]>
                          sort by key(s): overhead overhead_sys overhead_us overhead_guest_sys
  			  overhead_guest_us overhead_children sample period
  			  weight1 weight2 weight3 ins_lat retire_lat p_stage_cyc
  			  pid comm dso symbol parent cpu socket srcline srcfile
  			  local_weight weight transaction trace symbol_size
  			  dso_size cgroup cgroup_id ipc_null time code_page_size
  			  local_ins_lat ins_lat local_p_stage_cyc p_stage_cyc
  			  addr local_retire_lat retire_lat simd type typeoff
  			  symoff symbol_daddr dso_daddr locked tlb mem snoop
  			  dcacheline symbol_iaddr phys_daddr data_page_size
  			  blocked

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-mem.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 819edaf6b1df..24a4f0084f49 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -19,6 +19,7 @@
 #include "util/symbol.h"
 #include "util/pmus.h"
 #include "util/sample.h"
+#include "util/sort.h"
 #include "util/string2.h"
 #include "util/util.h"
 #include <linux/err.h>
@@ -28,7 +29,8 @@
 
 struct perf_mem {
 	struct perf_tool	tool;
-	char const		*input_name;
+	const char		*input_name;
+	const char		*sort_key;
 	bool			hide_unresolved;
 	bool			dump_raw;
 	bool			force;
@@ -313,11 +315,13 @@ static char *get_sort_order(struct perf_mem *mem)
 	bool has_extra_options = (mem->phys_addr | mem->data_page_size) ? true : false;
 	char sort[128];
 
+	if (mem->sort_key)
+		scnprintf(sort, sizeof(sort), "--sort=%s", mem->sort_key);
 	/*
 	 * there is no weight (cost) associated with stores, so don't print
 	 * the column
 	 */
-	if (!(mem->operation & MEM_OPERATION_LOAD)) {
+	else if (!(mem->operation & MEM_OPERATION_LOAD)) {
 		strcpy(sort, "--sort=mem,sym,dso,symbol_daddr,"
 			     "dso_daddr,tlb,locked");
 	} else if (has_extra_options) {
@@ -468,6 +472,7 @@ int cmd_mem(int argc, const char **argv)
 		 */
 		.operation		 = MEM_OPERATION_LOAD | MEM_OPERATION_STORE,
 	};
+	char *sort_order_help = sort_help("sort by key(s):", SORT_MODE__MEMORY);
 	const struct option mem_options[] = {
 	OPT_CALLBACK('t', "type", &mem.operation,
 		   "type", "memory operations(load,store) Default load,store",
@@ -501,6 +506,8 @@ int cmd_mem(int argc, const char **argv)
 		   "separator",
 		   "separator for columns, no spaces will be added"
 		   " between columns '.' is reserved."),
+	OPT_STRING('s', "sort", &mem.sort_key, "key[,key2...]",
+		   sort_order_help),
 	OPT_PARENT(mem_options)
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
-- 
2.46.0.rc1.232.g9752f9e123-goog

