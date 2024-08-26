Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418919D082;
	Mon, 26 Aug 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710248; cv=none; b=aLTMosac3AAln2rYb9yaUzO51IjOd8ZnZUF0u6TypGLzzvtdhM7oFhh/uRcxpxJcLZVMIsCFyu5ZW0vzhEBKp1B7JjZvCpLgQ2VMW6UKa2KTNZXKOiXl4aQELZH0GQunQboA32UJItnPnrL4nrl4fWjExlxWIWStG/bRNgIPdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710248; c=relaxed/simple;
	bh=C5ZJ+orkYSjjfOqZKUEsjhgj6GSofEI+72XLr0ut0ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCUp1Zcio4nYg+xRmGMZprKqTiH/u6fEJgJ3Ik9fo8DFTbAa6lPMv99xrqEpp5G40E2UT1wZ2mwG9uHCoPUejWViejx++zEuCCenpcgtnyHj9fJ7VJYzwEXnigAHvlynplgrIm2ZPMNa8Uwwxu1Q9PSpDN4AetSNp9CEL5Ir0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRRU680C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRRU680C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC200C8B7B7;
	Mon, 26 Aug 2024 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724710248;
	bh=C5ZJ+orkYSjjfOqZKUEsjhgj6GSofEI+72XLr0ut0ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRRU680CXdCQFuCnfSFdYUfg+YqPTGwSUPYX3EPIsgwMK+3LKoJE0vln7ViHh0MxI
	 vk6E+yQcU5asMw5umh2x8yDIiX696YDte7nKxkJhg1KVZRqHESLV4dJ5snG1NyJm28
	 /Uy35BEt3WQuDAu+2xWuIEvFrZyywHHjt2LGMP1Hd4l7rc+y919hYrdH+5pIrXQXFv
	 L2HRGZbIlnGNF40E43KO/rpHwOS0BF3tYoHkOrww3SYOp+g6sSSpzbagZOgXxC2j9K
	 u3yOU8DCRsq3IaBNbfvxtcQFSJIBPZzAFOnxvJ/zcJpBK3AVAMu7juwvCL9epmpO+m
	 7R32YuhYYY6UA==
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
Subject: [PATCH 2/4] perf bpf-filter: Add build dependency to header files
Date: Mon, 26 Aug 2024 15:10:43 -0700
Message-ID: <20240826221045.1202305-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240826221045.1202305-1-namhyung@kernel.org>
References: <20240826221045.1202305-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flex and bison files need to be recompiled when one of these header
filters are changed.

 * util/bpf-filter.h
 * util/bpf_skel/sample-filter.h

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/Build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b87f918bdfe7..260cec2f6c0b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -278,12 +278,12 @@ $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
-$(OUTPUT)util/bpf-filter-flex.c $(OUTPUT)util/bpf-filter-flex.h: util/bpf-filter.l $(OUTPUT)util/bpf-filter-bison.c
+$(OUTPUT)util/bpf-filter-flex.c $(OUTPUT)util/bpf-filter-flex.h: util/bpf-filter.l $(OUTPUT)util/bpf-filter-bison.c util/bpf-filter.h util/bpf_skel/sample-filter.h
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/bpf-filter-flex.c \
 		--header-file=$(OUTPUT)util/bpf-filter-flex.h $(PARSER_DEBUG_FLEX) $<
 
-$(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filter.y
+$(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filter.y util/bpf-filter.h util/bpf_skel/sample-filter.h
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/bpf-filter-bison.c -p perf_bpf_filter_
-- 
2.46.0.295.g3b9ea8a38a-goog

