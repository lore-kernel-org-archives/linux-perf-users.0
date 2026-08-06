Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03224A047;
	Thu,  6 Aug 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019790; cv=none; b=UeRkiliFAGUOLXdPOHNP8/L/VnXZK21yBpf+cZsSX/1VKuuCPPlaB8DC8AHQxYSHR+WE99nYyeQrvcefXu6FE5k1U66vy8i7+kQ0lNqxKNJqOerAnuO78Pb6QrrYOrOZN7/zocHLD4Xug42F3HrKhp55gb1UC1fG9kmEjRXxC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019790; c=relaxed/simple;
	bh=CDCKFwCfPfmcjkEOEl8ncWKeHh2Q/pyhiz/e9U/uYr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfRG35tl0ToTH58K2WLaUAcap0eI9TDFpcfLCpNPnTIfagNltCKRAWJqxbr+zpoBeDK1CGjI48IJBG9q0BMevZ3LtXGF358nI9XUsBfQ/qu2oy73GhQB21WCViUX0VxAxYbNzaITBKGYzmYXhPgcqSeu0liPyyJMInDq+32JMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNCVyR4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNCVyR4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7601F00A3A;
	Thu,  6 Aug 2026 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019789;
	bh=B/uvvDQ1yB6qzXLpKraWtRVkItiDchEOjBPUMLg+uIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eNCVyR4TOVJo2SzVFHbLbW+LOaUsBvnpXmrO1Mc4sX/VYHEP9uEHTpf9rTdymA+rx
	 MfuUWle7K/35NYiO8sbMBFp/PwUoRiF1thzopvxzOvEmFsGiYoaay1wLiLKoqjpysX
	 gt2DyGhIjEq1EuA65c1vVGKf8QKZhqbX3gNUtZXUNf0thsQ4/V1p542mQxAtX/0hB6
	 nWqiloPn4bTTHY2k4CaLt0tuQG4iLdGkCH9oeNIKGgW3ebu8B72dTL9uKfdbQGmh3O
	 hkdRVGu/+WdYd83wfEBIcQV+zwns1ejwYvM+xDoGfDmmHybPpTtNVkHNOFKPaEKWt/
	 w0bv7Aj7p5bZQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 03/12] perf jitdump: Validate code_size against total_size in code load
Date: Thu,  6 Aug 2026 09:35:54 -0300
Message-ID: <20260806123604.271277-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_load() reads code_size from the jitdump record and uses
it to compute a pointer to the code blob:

  code = (unsigned long)jr + jr->load.p.total_size - csize;

An oversized code_size underflows the pointer arithmetic, causing OOB
reads into earlier heap memory.  Validate that code_size fits within the
record (total_size - sizeof(jr->load)) before the pointer computation.

code_size is uint64_t but csize is int; values above INT_MAX wrap
negative when narrowed into csize, which defeats the bounds check and
sends the code pointer past the end of the record.  Reject those too.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Assisted-by: Opencode:mimo-v2.5-free
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index dcb26d9c6c8fc551..14bd23c8d1963e92 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <byteswap.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -452,6 +453,16 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	csize = jr->load.code_size;
 	usize = jd->unwinding_mapped_size;
 	addr  = jr->load.code_addr;
+
+	/* code blob lives at the end of the record, validate it fits */
+	if (jr->load.p.total_size < sizeof(jr->load) ||
+	    jr->load.code_size > jr->load.p.total_size - sizeof(jr->load) ||
+	    jr->load.code_size > INT_MAX) {
+		pr_warning("jitdump: invalid code_size %" PRIu64 " (total_size=%u) in code_load record\n",
+			   (uint64_t)jr->load.code_size, jr->load.p.total_size);
+		return -1;
+	}
+
 	sym   = (void *)((unsigned long)jr + sizeof(jr->load));
 	code  = (unsigned long)jr + jr->load.p.total_size - csize;
 	count = jr->load.code_index;
-- 
2.55.0

