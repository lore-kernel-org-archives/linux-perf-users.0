Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB334F24E;
	Mon, 31 Aug 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181934; cv=none; b=cSGl8T1rD0ck+DzzoT0eJpnuZAvHBr+a9RIFErzuRvpOVjYbc2ZipNU06zm4gkDfvawCIVQfKVDqL5664qsEC3UzY15KHXNxZ7B5S+ZzbvMynmzk1/8jKDUnX07mTYUorNzZsmfGhsGUVEWMYAhbW1nwB4bPwN1so4fMkccffUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181934; c=relaxed/simple;
	bh=xl/07EV2vtr5hM95uAerTBPQFFkjji/5/upijS/97rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQeNhbgOX0ADhrhe8601GhRPQTeilQ38JUHXKKV1rfNWyKXd/95npd/v+wlstWa7xntevQuCdMkzWfPs/gLM1nx5/hPlt3e5/wgjiAwCU5OiMz3uDe2qd2/VtcHX6+qPZOsNIpNmwIXdBH+M9oNzgZPWPmpUrHyfvSvqCY+NtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3woriln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3woriln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058091F00A3D;
	Mon, 31 Aug 2026 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181933;
	bh=nhhOI5XjtPiaW/+0O6x/xQeN6xRlHOVXxDTNBWxUzIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3worilnEbQmM8xMt6Xlx1enMnUvpJxfF5V6opr7c+oY5FAfIxWAuaZcvrqUhfVoz
	 OnCcguMefqiGzJ4woqrYbFlHVsjjjzYGfmEphKFJn6juM5po+Dy+G27qvp2zSxUi7g
	 ySrSbFZQlmSdj6G+EPlk6hEyRC2xkR2aHSS9RyZ40j71ZCpaH+Gn98kY0zZPneEGfV
	 AnE7TpMVrgxU35+avUnlqbgDAmVht6jIwNHtnydqfTS9iZvdorUeLGBW+MwLd/AsE8
	 lJEgYMJPLhrg6URKU80jEQNUqWJ6f1Y149zz71Ab/bI80fqD6Ha8Isl07srvZH8BFu
	 unstj44a9XpSg==
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
Subject: [PATCH 11/12] perf jitdump: Validate sym string NUL-termination in code load
Date: Mon, 31 Aug 2026 10:11:07 -0300
Message-ID: <20260831131110.4681-12-acme@kernel.org>
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

jit_repipe_code_load() computes sym = (void *)jr + sizeof(jr->load) and
passes it to jit_emit_elf() which calls strlen(sym) via jit_write_elf().
If code_size equals total_size - sizeof(jr->load), the sym pointer
aliases the code blob with no NUL terminator, and strlen() scans past
the buffer into adjacent heap memory.

Add a memchr() check to verify the symbol name is NUL-terminated within
the region between the load header and the code blob before use.

Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 5a3ea2681fb37105..5898a7d8eb962daf 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -487,6 +487,13 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	sym   = (void *)((unsigned long)jr + sizeof(jr->load));
 	code  = (unsigned long)jr + jr->load.p.total_size - csize;
+
+	/* sym string lives between the load header and the code blob */
+	if (!memchr(sym, '\0', code - (unsigned long)sym)) {
+		pr_warning("jitdump: unterminated symbol name in code_load record\n");
+		return -1;
+	}
+
 	count = jr->load.code_index;
 	idr_size = jd->machine->id_hdr_size;
 
-- 
2.55.0

