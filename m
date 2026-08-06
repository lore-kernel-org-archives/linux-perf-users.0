Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF7279907;
	Thu,  6 Aug 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019837; cv=none; b=HG2TJWeflgwJC+DlPWWSJJJTZsnaWr3RjQ5j4lsrlskHa1aGfPv9FgRrWFxMOCAcNzhX+GzPadiUulLPXQkoWEpgCyW2fMDL2XUk+wrBeJdNXhS8i+pJIVfcqZ0iCztxslC0fBDktAjeebCrTRuu1wfrglLdiwzqAj9OqVeaRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019837; c=relaxed/simple;
	bh=SZQuzrP/ehv3y8PwjY5jperLSL3kBkBVUroC8jwdI3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCf+X5wkQTj08SKfGXdDweclltot9WRJ5duuX7HeK97JBOtTqkv/1/sulRD5q+o+ZGiBRnaovJ0VmNBTiRhphtey8C2VvyO/aeMbShekGedk9ScnNK1p6gceGWTDdOBMSeTBG/+fdvwmv1huPIZr9K91YzkPf9SUIZBGmLkK9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHh/ZG2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHh/ZG2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322261F000E9;
	Thu,  6 Aug 2026 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019830;
	bh=RUyxmj3vxNdvlR8l7JK2MtQk0vGO/OK+dQDKwAGY5Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cHh/ZG2cVOE+oWqh9qDmf8sLi6UbV3c7NcW94Pvmu9CwaNnV4hBdVJ5/nGuOUXl4N
	 2LIHUPz7HblL+8rbTiutxd+eN8l7FBiIngPg9RmXfD9d/rFNMMnAMehBdwww9h3GBy
	 MPJyLL9UfoyCUCgYeVioDjydEULnwQ9iI+q9MzXx7C1zRfTSOkY1jPgLIq7biCCdgp
	 iRUy2ltpwhwAFRtn+OLdXrWuPDRp5K2Xg4U7xpMuLS6RncrZ5ESz53sSnYeHNujPaS
	 KJ+hHWLp2EqI03uhXG1WLZBYOKenE9RhPQ/jSqVg/mqmnxdKx869svOKVjPNayO7x3
	 zB1hREg3ckTtA==
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
Date: Thu,  6 Aug 2026 09:36:02 -0300
Message-ID: <20260806123604.271277-12-acme@kernel.org>
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

jit_repipe_code_load() computes sym = (void *)jr + sizeof(jr->load) and
passes it to jit_emit_elf() which calls strlen(sym) via jit_write_elf().
If code_size equals total_size - sizeof(jr->load), the sym pointer
aliases the code blob with no NUL terminator, and strlen() scans past
the buffer into adjacent heap memory.

Add a memchr() check to verify the symbol name is NUL-terminated within
the region between the load header and the code blob before use.

Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
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

