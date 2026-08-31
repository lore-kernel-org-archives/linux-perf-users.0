Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18BC3403EA;
	Mon, 31 Aug 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181899; cv=none; b=smzsSzVnGrf/BZrUU+1RDhBon+UpuOvsXPe82U+cFmsubqKGPHQmxVhIIg6zN8b8WDi9MhCWcS20qTiee/SaAm6F/Seaewu3/6KrrHiGwAgMBxrCuIEp2X/gDdiUADnpr2ARZXpGGoQlFpt143R4OCsL4Koyfa4uxCeDOyvlB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181899; c=relaxed/simple;
	bh=1plszNX5YJI2grUZ9UoSn5KchYMLJbBYQ1UxdFC5Kzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKSIOq13HRewrRacJ3lcIhrYRofsAZ/FL3Ylu1sn7HebfDorERXk5V1OkI7jqw9rl7tZQKl4cWwYshw/aE+Cer8SisJWmi6amPDZTI20/4Tqd21ZpTxEQOPNVd/CE+yaIef94zzPcoPum7kHo48nkajw5nEf8JVKswR5znyRenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4C8USy1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4C8USy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD401F00A3D;
	Mon, 31 Aug 2026 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181897;
	bh=pyoeWkFyGgKAhAYW3vko3P5GY3z1QKRZ4IjWXd0etss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4C8USy16mOE15C6B6l8NNPH4rFvZ9zjsz98egtyZt9M5c47/fDY1ulqgzM/Amw6n
	 mDRnp+OgA9tZAjijpIaN4pOnIlvCy8ADT20PmkYQ5tYHStlSLas1xfHiGu5laj86R5
	 OWHNC5FvaLPrOG0R9kOOkKsGCkktwpCfBn2AwIKh+shHZdZQodxB/feox5zkkcKs31
	 HWy4Ce+66Iax4WTtMgPuHt0eJZJazKJOaPP4J/8qOxVWvTEb8aIb6TtjRpL5BJLeEn
	 VXkaDQWVdCeQWmVJO/jtJYo+tcVTjdvPmPBse/JG5pHrCD+XROFjAvrpxQzn/hbeue
	 DyYvgpKWrF4+g==
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
Date: Mon, 31 Aug 2026 10:10:59 -0300
Message-ID: <20260831131110.4681-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
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

