Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385029A0;
	Fri, 28 Jun 2024 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533165; cv=none; b=T0bCp5W4dJyt00CjtsHR+XdNSHRgLLUrf4p1D0SvboqGhY2PAhXvcVPkKf7FN9Otw0skrbZkAhTJK0Rf0MLMQccZ6+OAjZAWIpUKztS+ff5p8/umPDijGhrHbnbb0vOUTmXkVabqKXmM5yixSc1SX0XXDRaav0l24jvDTtuLeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533165; c=relaxed/simple;
	bh=0CyfdFxIwNPXXscTyygI74xUEUEhVUnmTakcgjIn3rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQOni8SJzTETJRYNpxPfdUAWjBnlTSoOFTcssN/xRKMj8b3Zf07dFa6tHHFet+9GDnpgskAHSmhoRjG4PxRLG4aN/OE6JZUDIClVtOZiUvUBsGOYzHzGx9LJT3jyxw/QkEE3LwaIANWp/PpYbcr+oEJSj0mqAO4Zoi4wzXYSPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEnR3Eqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEnR3Eqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEC2C32786;
	Fri, 28 Jun 2024 00:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719533165;
	bh=0CyfdFxIwNPXXscTyygI74xUEUEhVUnmTakcgjIn3rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEnR3EqqXFCcFhvGEm55uemDB45fA1WlZVMl/AvDkNBZRc02OQB56osOUjBoYkOk2
	 4288ZXR81JuISqdSil7XeCpz1+uQZvm0YaULfoINaKlwPWJ8eZhPIgPMX5csQBWiYp
	 P+y7QTs2AfFfgH9pZ0Qp+5FDLdKsU+GCxE3fUJxKQxU7qtmHiEZdzdHfwxHkPnDc2f
	 gH4T1bpqWRD/5NuUT4w2/sFkJJyv8R0q74b1p84D+5xOliZSfVbIBAsP7OxTUmE3oq
	 EOIwBgkKcaPsGaeYnEbDtpmluSQZ5z5zh0Aa7nYmk+YBKcPWqloOLFPMyI8oYSLBdc
	 2x0F+Mrg9xlMA==
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
Subject: [PATCH v2 2/2] perf stat: Use field separator in the metric header
Date: Thu, 27 Jun 2024 17:06:04 -0700
Message-ID: <20240628000604.1296808-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628000604.1296808-1-namhyung@kernel.org>
References: <20240628000604.1296808-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It didn't use the passed field separator (using -x option) when it
prints the metric headers and always put "," between the fields.

Before:
  $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
  core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" expected
  S0-D0-C0:2:10.5:
  S0-D0-C1:2:14.8:
  S0-D0-C2:2:9.9:
  S0-D0-C3:2:13.2:

After:
  $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
  core:cpus:%  tma_core_bound:
  S0-D0-C0:2:10.5:
  S0-D0-C1:2:15.0:
  S0-D0-C2:2:16.5:
  S0-D0-C3:2:12.5:

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 186305fd2d0e..c38bcb6f4c78 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1186,10 +1186,21 @@ static void print_metric_headers_std(struct perf_stat_config *config,
 static void print_metric_headers_csv(struct perf_stat_config *config,
 				     bool no_indent __maybe_unused)
 {
+	const char *p;
+
 	if (config->interval)
-		fputs("time,", config->output);
-	if (!config->iostat_run)
-		fputs(aggr_header_csv[config->aggr_mode], config->output);
+		fprintf(config->output, "time%s", config->csv_sep);
+	if (config->iostat_run)
+		return;
+
+	p = aggr_header_csv[config->aggr_mode];
+	while (*p) {
+		if (*p == ',')
+			fputs(config->csv_sep, config->output);
+		else
+			fputc(*p, config->output);
+		p++;
+	}
 }
 
 static void print_metric_headers_json(struct perf_stat_config *config __maybe_unused,
-- 
2.45.2.803.g4e1b14247a-goog

