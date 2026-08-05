Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77743ED10F;
	Wed,  5 Aug 2026 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965294; cv=none; b=iKVh4tIsBKSDdPUanOxnb+uWN8ivtqfF/cJiN+kd7C4fsFqekyBY/DEO/x6/Psss5J6DOLnBJL4Q/Rqc+tYzv8CMtPaW0EaDsJ85JcWvmKtUvQR1fzobJpcXGgQXYW0WnUnLTL3zPB1e/5V9n0/tj5wypSwoQ+MND2+a9M3mNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965294; c=relaxed/simple;
	bh=SZQuzrP/ehv3y8PwjY5jperLSL3kBkBVUroC8jwdI3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGFNbj73i4S5vFrF5inFLQFxj175w4I9sTRVLe7c0gzP25Pl5fD8GjNTDU4rP2rnKTPEd2DnmZ77CgcYc5zKSI5EBJpuyWmPgmAnffIbIzTlCdklv8FmbDdjIjmD4WkBt5hY1MtkBPNX61CaNwxXgiDRWq14HJaOVvKYoXdipxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCifNleg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCifNleg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7291F00A3A;
	Wed,  5 Aug 2026 21:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965292;
	bh=RUyxmj3vxNdvlR8l7JK2MtQk0vGO/OK+dQDKwAGY5Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCifNlegBDQFTaomFnstyVvnkPAKjRPveAPbQfAZtxSlMCq44cBuid7ZIuON3w9cw
	 sa7w7+MHpyoV1ojXdd98zFhWJ+Wbf+EbRGD7xbHIdd2X/0tcaNu58+z7xnuciuhH49
	 GUkfvNUawHrSgtyrzJPQnc984CH2TLA4pOpS160EU9KQsUroJM9HSe2SL+RR8qQhBw
	 tL4NESueckPk0GHaaTsy+ODtgE0VmUL5/GXAFXhv+67WVA3s3agMfIkWhUB64tUc0/
	 qOetCcLdoIWCrrh9szIjGT+5lKzvKUFbZVbbm4SyeU65lpp6une8onrz96t4gvOidB
	 Z4JHMSNoEfMWw==
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
Date: Wed,  5 Aug 2026 18:27:01 -0300
Message-ID: <20260805212704.267779-12-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805212704.267779-1-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
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

