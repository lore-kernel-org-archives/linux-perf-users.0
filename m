Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5D1DFE1C;
	Mon, 28 Oct 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147018; cv=none; b=s9JgtNlopUFkwT4izm3cSgo6TM1FGCpCKwgpbNMe7Ws3rolzxSw+8kdl5wk5ZaWr21wWfGgfRsrWrOImM3wZFwJzksjAKCKjN8CCVzYiEw4CeIWoKaSCpDAS7daA703O0WjP5/ih8Mo1Le1sZ2/ZH3UNpl3vMu2XtaOAWAtncLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147018; c=relaxed/simple;
	bh=ygxt109xKE1bMCf6lGpv/3u6u0A5LB3R6ch8sQBAzGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4QTarOMZlnz7pGhE6YGleUofBia+jQ4T3TZ5jVpQfHtJyjn91eiaXrbFutAkiUGTaF+dPN2p++VFPSEJ6GNrM7vS5YeXITlytL/kfkFLzgfcf7QBeAYb6BDDeR4OOD5JRNixvkr24riQpuppW8H6QfsphIyug4gDFIcrzh5Eq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av7GQBxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av7GQBxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B58C4CEE3;
	Mon, 28 Oct 2024 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147018;
	bh=ygxt109xKE1bMCf6lGpv/3u6u0A5LB3R6ch8sQBAzGE=;
	h=From:To:Cc:Subject:Date:From;
	b=av7GQBxMizERkeAvSNQzZ6LT9Y3Wa3PuAXd2dEG2SAVCTNWo46fKTLLB7z6QJieFL
	 8HhlcfIACN4d0+7PIbaGVgnHpaTDE+COzauxkmMp2OtbSf5P8QXC21a5gyqdf8GDQr
	 IzUcy97nHbWnc5nFXl+45VosXBc+/UuxtIK0qHsLlpv7S/1zMrz6eB4/+UW73stCD5
	 CnG+2BRs4kThdTRG1sx14y8HKSKgVBUzLJ13Ja2r/k+E35gA2TW450p/BowVDf2dqm
	 Fcs+Jfb9mbJxsHgMJ714iQp6i3jT2mVQumk5/vDh7LGFji5hPalhqUNHS2Uf0G/WnA
	 Cm2Db2HRtBmXg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf mem: Add -H/--hierarchy option for report subcommand
Date: Mon, 28 Oct 2024 13:23:36 -0700
Message-ID: <20241028202336.1478570-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like in perf report, the -H/--hierarchy mode supports hierarchical
output using the given sort key.  But with -T/--type-profile option it
would be better to have the 'type' sort key in the beginning so that
users can see something like following:

  $ perf mem report -T -H
  ...
  #
  #          Overhead       Samples  Data Type / Memory access / Snoop / TLB access
  # ...............................  ..............................................
  #
      97.96%          4099           (unknown)
         97.05%          4089           L1 hit
            97.05%          4089           None
               97.05%          4089           L1 or L2 hit
          0.71%             6           RAM hit
             0.71%             6           Hit
                0.71%             6           L1 or L2 hit
          0.16%             2           L2 hit
             0.16%             2           None
                0.16%             2           L1 or L2 hit
          0.04%             2           LFB/MAB hit
             0.04%             2           None
                0.04%             2           L1 or L2 hit
       0.98%            12           struct folio
          0.61%             9           L1 hit
             0.61%             9           None
                0.61%             9           L1 or L2 hit
          0.37%             3           LFB/MAB hit
             0.37%             3           None
                0.37%             3           L1 or L2 hit
       0.45%             5           unsigned char
          0.45%             5           LFB/MAB hit
             0.45%             5           None

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-mem.txt |  6 ++++++
 tools/perf/builtin-mem.c              | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 8a1bd9ff0f86dfb8..ac16c1b276e3912c 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -125,6 +125,12 @@ REPORT OPTIONS
 	Specify the field separator used when dump raw samples (-D option). By default,
 	The separator is the space character.
 
+-H::
+--hierarchy::
+	Enable hierarchical output.  In the hierarchy mode, each sort key groups
+	samples based on the criteria and then sub-divide it using the lower
+	level sort key.  See linkperf:perf-report[1] for details.
+
 In addition, for report all perf report options are valid, and for record
 all perf record options.
 
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 651188c1d8259842..2efa01947cf17aa0 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -39,6 +39,7 @@ struct perf_mem {
 	bool			all_kernel;
 	bool			all_user;
 	bool			data_type;
+	bool			report_hierarchy;
 	int			operation;
 	const char		*cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -329,6 +330,8 @@ static char *get_sort_order(struct perf_mem *mem)
 
 	if (mem->sort_key)
 		scnprintf(sort, sizeof(sort), "--sort=%s", mem->sort_key);
+	else if (mem->report_hierarchy && mem->data_type)
+		strcpy(sort, "--sort=type,mem,snoop,tlb");
 	else if (mem->data_type)
 		strcpy(sort, "--sort=mem,snoop,tlb,type");
 	/*
@@ -374,7 +377,7 @@ static int __cmd_report(int argc, const char **argv, struct perf_mem *mem,
 	if (mem->dump_raw)
 		return report_raw_events(mem);
 
-	rep_argc = argc + 3;
+	rep_argc = argc + 5;
 	rep_argv = calloc(rep_argc + 1, sizeof(char *));
 	if (!rep_argv)
 		return -1;
@@ -387,6 +390,9 @@ static int __cmd_report(int argc, const char **argv, struct perf_mem *mem,
 	if (new_sort_order)
 		rep_argv[i++] = new_sort_order;
 
+	if (mem->report_hierarchy)
+		rep_argv[i++] = "-H";
+
 	for (j = 0; j < argc; j++, i++)
 		rep_argv[i] = argv[j];
 
@@ -513,6 +519,8 @@ int cmd_mem(int argc, const char **argv)
 		   sort_order_help),
 	OPT_BOOLEAN('T', "type-profile", &mem.data_type,
 		    "Show data-type profile result"),
+	OPT_BOOLEAN('H', "hierarchy", &mem.report_hierarchy,
+		    "Show entries in a hierarchy"),
 	OPT_PARENT(mem_options)
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
-- 
2.47.0.163.g1226f6d8fa-goog

