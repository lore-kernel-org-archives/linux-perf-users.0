Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076F61FF6;
	Sat,  3 Aug 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722719615; cv=none; b=DgK0yOyJTr+X1eAXiN6KampK7/TnDOewvf1afiUd0u88eBybcfzsr+msn8mMDMq8ft7Ipsyoy+53xIf4bU3Q5kJi/+52ED9QcDVRnw7aXuwi/b9e8qRA7dsunUN8KOg9CW+ceVzokgK5ysdIiCvcilqoyoy3Ak7x9nbQrjKFEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722719615; c=relaxed/simple;
	bh=S74RA+BGZpwoXEEN1ma65H75GaeDz2xqt/5KZxfR5+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7MHzbmcJvOlbEpRIBZr1sEbrlUNeYodt3a+u4uR8Qbjm5yL2UT/4dLFFkY/vDkbqsyXvDFquS/SnD+BGeOee6bIImv2F182e6StREPzwyoeJYOitY4jOGXJg2v3D22QSjRbbfEbsJbhUVtr3d7RZKaNLh7i+ehMArq5AS1d820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwkcaR4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwkcaR4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBBDC4AF10;
	Sat,  3 Aug 2024 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722719615;
	bh=S74RA+BGZpwoXEEN1ma65H75GaeDz2xqt/5KZxfR5+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PwkcaR4BevnQqcARPbkPRjaaiDzyHWyh4mA5Adx/PsaJTA2Hbu9ZQwDq7Qcrexznc
	 oZq3uVmtfMRjtINcJpCcq5tLy+cbXbXaV6oJzZz2EtDXkCk+WrBBnwQckvcMiSDtwV
	 AV8FTBg6G4j1gpI4sEJYi5PoIEz4Eqr5mf7HW6OtX4t/z5syTU67S8CJTMdcS0VxMJ
	 srL8SmtUFv15LD9B5FkhWi0JpKl+nHnccVA/klOxSwkNvcFT6DrOeujfkFOuHnW1ej
	 cASY/UIqjzpJpfGFPhxFLocti0V71KI+BGVF+uInMkPS89ek5sqp7mo6Bp6uzKowTs
	 8XkPoeYCJIurQ==
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
Subject: [PATCH 2/5] perf annotate: Set notes->src->nr_events early
Date: Sat,  3 Aug 2024 14:13:29 -0700
Message-ID: <20240803211332.1107222-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240803211332.1107222-1-namhyung@kernel.org>
References: <20240803211332.1107222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to use it in different places so make sure it sets properly
in symbol__annotate() before creating the disasm lines.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 91ad948c89d5..09e6fdf344db 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -925,6 +925,11 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 			return -1;
 	}
 
+	if (evsel__is_group_event(evsel))
+		notes->src->nr_events = evsel->core.nr_members;
+	else
+		notes->src->nr_events = 1;
+
 	if (annotate_opts.full_addr)
 		notes->src->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
@@ -1842,10 +1847,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	size_t size = symbol__size(sym);
-	int nr_pcnt = 1, err;
-
-	if (evsel__is_group_event(evsel))
-		nr_pcnt = evsel->core.nr_members;
+	int err;
 
 	err = symbol__annotate(ms, evsel, parch);
 	if (err)
@@ -1861,8 +1863,6 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 		return err;
 
 	annotation__init_column_widths(notes, sym);
-	notes->src->nr_events = nr_pcnt;
-
 	annotation__update_column_widths(notes);
 	sym->annotate2 = 1;
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog

