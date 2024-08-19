Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1715A865;
	Mon, 19 Aug 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110565; cv=none; b=X3dofF/p8su5lTiOjZ/FjnYyVaOAfAHCbMZoQfpLB/AMm7xqj9p4sxW/KQdCzIn3sQ2j2Tu9VZ4nE1PqsSyT2XLI3OvZJ2SEP06LKW4lJ+7sDnAxjYh1shXWqADrzfQ5jq2l/YZjMGFrN0LoDkUoCvP4z4cu9mVwpMzAipzqlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110565; c=relaxed/simple;
	bh=qCj+LfiT5tpvzxgDU9mFZEMQHSF/m8fBskRBqqFVy60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKZPOhXaTE3+MpWPIl8gI5yV6hWHNdwrs5mMiXIydaqPCA8Om+iohPuGexndQL6YCD9nGsKlCob5jLpPyE2KkAPlGzkeWz1GRxF5Qiz+6hxigd40Quz3+KGEpHNcLnlblCYuu7iNYWtI5DRW6McJ5U0BOvyRxCgIXK4fm0214tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdjd6Cql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdjd6Cql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD571C32782;
	Mon, 19 Aug 2024 23:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724110565;
	bh=qCj+LfiT5tpvzxgDU9mFZEMQHSF/m8fBskRBqqFVy60=;
	h=From:To:Cc:Subject:Date:From;
	b=Vdjd6CqlvTeD5MNbK1AvUOw1FLmscSgL4bW6KesPtpIJzqvYp4oS3v8NXb9WE9kAp
	 w+Mx7RacVQ8mouBBK4DwHzlzWz9f66m+bVLa8as8vh7WkY2Bp0XyoHzAgJ4mtFcG6C
	 ZBz6niDOjC3C3WTan8UVyXGYaKyv1j7MTC8cseSFXYsTxdwck3EWBJxzTyR3KtDV8y
	 ce3n000uLVGPiJWOUa7NeEV5TFDPMjVBFQJokB5nAaLII1KslGuMDFDI5s8h3ElQe4
	 WTVbJ2uog2CAC2aQko+iGJT/q2i6cHC7TfQtBQ7Aji076KNSs3FgXprYNbeOni6FZ7
	 e4UxQjo6SxAVA==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf annotate-data: Show offset and size in hex
Date: Mon, 19 Aug 2024 16:36:02 -0700
Message-ID: <20240819233603.54941-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It'd be better to have them in hex to check cacheline alignment.

 Percent     offset       size  field
  100.00          0      0x1c0  struct cfs_rq    {
    0.00          0       0x10      struct load_weight  load {
    0.00          0        0x8          long unsigned int       weight;
    0.00        0x8        0x4          u32     inv_weight;
                                    };
    0.00       0x10        0x4      unsigned int        nr_running;
   14.56       0x14        0x4      unsigned int        h_nr_running;
    0.00       0x18        0x4      unsigned int        idle_nr_running;
    0.00       0x1c        0x4      unsigned int        idle_h_nr_running;
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 4 ++--
 tools/perf/util/annotate-data.c        | 2 +-
 tools/perf/util/sort.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index f563a3bb072c..cd562a8822b7 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -427,12 +427,12 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 
 	/* print type info */
 	if (be->indent == 0 && !member->var_name) {
-		ui_browser__printf(uib, " %10d %10d  %s%s",
+		ui_browser__printf(uib, " %#10x %#10x  %s%s",
 				   member->offset, member->size,
 				   member->type_name,
 				   list_empty(&member->children) || be->folded? ";" : " {");
 	} else {
-		ui_browser__printf(uib, " %10d %10d  %*s%s\t%s%s",
+		ui_browser__printf(uib, " %#10x %#10x  %*s%s\t%s%s",
 				   member->offset, member->size,
 				   be->indent * 4, "", member->type_name,
 				   member->var_name ?: "",
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index aa330c7d8edd..25105b3b9a13 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1660,7 +1660,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 		nr_events++;
 	}
 
-	printf(" %10d %10d  %*s%s\t%s",
+	printf(" %#10x %#10x  %*s%s\t%s",
 	       member->offset, member->size, indent, "", member->type_name,
 	       member->var_name ?: "");
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c4046d5d1749..d315308f9170 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2312,7 +2312,7 @@ static int hist_entry__typeoff_snprintf(struct hist_entry *he, char *bf,
 				 he->mem_type_off, true);
 	buf[4095] = '\0';
 
-	return repsep_snprintf(bf, size, "%s %+d (%s)", he_type->self.type_name,
+	return repsep_snprintf(bf, size, "%s +%#x (%s)", he_type->self.type_name,
 			       he->mem_type_off, buf);
 }
 
-- 
2.46.0.184.g6999bdac58-goog

