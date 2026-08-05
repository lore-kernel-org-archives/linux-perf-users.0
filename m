Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FA471246;
	Wed,  5 Aug 2026 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936685; cv=none; b=bn82dmDw9Ul+nGdD3AJ/ZG6J7rNjuCqmz7+YE2yFHw4VhwePLDOoA8JM0iDlvvW0LZcicq/Fu8ZpBDqo2W3QczGdA93AWFFJdFwmo+htGmZn2VnQiPQTV0JpVuMtakp7IYb6reX8PlQPMUYIQc4SCAHmlZAtkXjOrVaAdkZeWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936685; c=relaxed/simple;
	bh=bxkbjvjH3PR73oWSLczuqdxQFZY0bWmOlSKjeaRTDKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4frXurtVbUFAVAezj9FiS8pIDgS1NneDGGeDda6drYXdixZgz64wA2FatuP3svxZdmXpe99fGx4MyVB4TWdE7TmJxog5/HHCw3jfmryHQtki26X2yXzb+D00RUCbpTkckFmTl2tIUdAajf4PVEnVj65i5POMj31FpH8MrfVYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCF6iOje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCF6iOje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC951F000E9;
	Wed,  5 Aug 2026 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936684;
	bh=5hNEFcTuONvGHX51AFIg3nJnFMlGn8L15Q3WLQ6IMws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCF6iOje+7bIyb17Oubd+7v2/vTz4hEAuJ8dbVnwavwf4BfcRRzNEMJX6ooPk3bAE
	 8hTUBtMNUDrSMkNtCRc78ieYaLd7+kT7NSg/kM73cpYAQwqOQOLgcPD9q9DM4ED9mg
	 JIRoeckltsvlwnydTKtOIwLt7eqMG1x8pOTc9YTSfdWKtwErE6lHjDFsgz4o9GDntw
	 MTEcKoGeOL54SbOBDe5PlbtEO7L1EJLpsIKlARHHHl5D0Pngy8Yoiep2v0zcClMFJJ
	 kcxNKoq+2Bt2eCy9I31pKG6/wyo1edHSvIxgLEFAEUmlVJ5jeVL2M7etT5jJwgsIlS
	 SVm6l1ShLbkYQ==
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
Subject: [PATCH 02/12] perf jitdump: Validate code_size against total_size in code load
Date: Wed,  5 Aug 2026 10:30:01 -0300
Message-ID: <20260805133013.235016-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
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
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 4b7c7ba7cd95ddbb..3195f94187164066 100644
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
@@ -450,6 +451,16 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
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

