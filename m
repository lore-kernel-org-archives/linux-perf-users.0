Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48B16EB57;
	Wed, 31 Jul 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470108; cv=none; b=d0h+V7xYkHI27lUHeYfVFeixwAZ+rhkYt260oD7Z2sDqUHLidYLhU/vwFxGrGYvVBg6N7VFtL7EI2GmR3ogc8d5r/sk01G39JX7zWSf244Bl9U9q8OE5z4oOzmng9egcw6oOO5g97pzWMXG1C+xiVWVgbi6jL8nSKsuKrvp2GQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470108; c=relaxed/simple;
	bh=Dfzv4j/8Hd+vCw26hzqNqBmXI1ENVx0lDrBXK1X327E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEiUDZoELzvg+jMiMks3pdRorbkd0lRwDXhJosni0tBTA5zc34b6RYCJwVRcO//yNU2GWI1dWUx7QfRckDZEEjL6EHx9ZG/7nNiFvkykqbn0G5r/v3+B7o7vEZfJH0Ps/AwWZ1dKWdASPQISTAsA8zGA+rWTjgD5qEZrp/H63Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDhUJfW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDhUJfW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D269C4AF12;
	Wed, 31 Jul 2024 23:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470108;
	bh=Dfzv4j/8Hd+vCw26hzqNqBmXI1ENVx0lDrBXK1X327E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDhUJfW8ETB60uj1pqk3jjWceMzyTk2i9EOhXztQcQMUfk9Vy9qP+emEadM07zAP8
	 HH7RLcfB7eW6v1C7TalZ87mNkRhZwzIgNg/ORBN0/WRDuTo3HzjOdIW3/rhhpuZkG4
	 +DudxBuCBKIeIXs8g/oR+aQBiPU/Am9IuJRH1qwaSBiJiqwgVeSBtlcQUIzz/EkvYg
	 wnuC3fkexDiwVpFeecepMsvh2XJiakr54LDsSa+OvkCnxfkxB8fPWR+2V8UbrByl1/
	 dT8IjOKBogaRZauH+a0pwsWT5J0QsTbug0SNp7ZZBFec+8HoDfU2NRks6IMdR/qkFL
	 4pWB9Yj0769Qw==
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
Subject: [PATCH 4/6] perf tools: Add mode argument to sort_help()
Date: Wed, 31 Jul 2024 16:55:03 -0700
Message-ID: <20240731235505.710436-5-namhyung@kernel.org>
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

Some sort keys are meaningful only in a specific mode - like branch
stack and memory (data-src).  Add the mode to skip unnecessary ones.
This will be used for 'perf mem report' later.

While at it, change the prefix for the -F/--fields option to remove
the duplicate part.

Before:
  $ perf report -F
   Error: switch `F' requires a value
   Usage: perf report [<options>]

      -F, --fields <key[,keys...]>
  			  output field(s): overhead period sample  overhead overhead_sys
  			  overhead_us overhead_guest_sys overhead_guest_us overhead_children
  			  sample period weight1 weight2 weight3 ins_lat retire_lat
  			  ...
After:
  $ perf report -F
   Error: switch `F' requires a value
   Usage: perf report [<options>]

      -F, --fields <key[,keys...]>
  			  output field(s): overhead overhead_sys overhead_us
  			  overhead_guest_sys overhead_guest_us overhead_children
  			  sample period weight1 weight2 weight3 ins_lat retire_lat
  			  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c |  4 ++--
 tools/perf/util/sort.c      | 12 +++++++-----
 tools/perf/util/sort.h      |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6edc0d4ce6fb..930052961c1a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1301,8 +1301,8 @@ int cmd_report(int argc, const char **argv)
 		.socket_filter		 = -1,
 		.skip_empty		 = true,
 	};
-	char *sort_order_help = sort_help("sort by key(s):");
-	char *field_order_help = sort_help("output field(s): overhead period sample ");
+	char *sort_order_help = sort_help("sort by key(s):", SORT_MODE__NORMAL);
+	char *field_order_help = sort_help("output field(s):", SORT_MODE__NORMAL);
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index ab7c7ff35f9b..c4046d5d1749 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3960,7 +3960,7 @@ static void add_hpp_sort_string(struct strbuf *sb, struct hpp_dimension *s, int
 		add_key(sb, s[i].name, llen);
 }
 
-char *sort_help(const char *prefix)
+char *sort_help(const char *prefix, enum sort_mode mode)
 {
 	struct strbuf sb;
 	char *s;
@@ -3972,10 +3972,12 @@ char *sort_help(const char *prefix)
 			    ARRAY_SIZE(hpp_sort_dimensions), &len);
 	add_sort_string(&sb, common_sort_dimensions,
 			    ARRAY_SIZE(common_sort_dimensions), &len);
-	add_sort_string(&sb, bstack_sort_dimensions,
-			    ARRAY_SIZE(bstack_sort_dimensions), &len);
-	add_sort_string(&sb, memory_sort_dimensions,
-			    ARRAY_SIZE(memory_sort_dimensions), &len);
+	if (mode == SORT_MODE__NORMAL || mode == SORT_MODE__BRANCH)
+		add_sort_string(&sb, bstack_sort_dimensions,
+				ARRAY_SIZE(bstack_sort_dimensions), &len);
+	if (mode == SORT_MODE__NORMAL || mode == SORT_MODE__MEMORY)
+		add_sort_string(&sb, memory_sort_dimensions,
+				ARRAY_SIZE(memory_sort_dimensions), &len);
 	s = strbuf_detach(&sb, NULL);
 	strbuf_release(&sb);
 	return s;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 0bd0ee3ae76b..6357bc32c5ca 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -130,7 +130,7 @@ void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
 void perf_hpp__set_elide(int idx, bool elide);
 
-char *sort_help(const char *prefix);
+char *sort_help(const char *prefix, enum sort_mode mode);
 
 int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, int unset);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

