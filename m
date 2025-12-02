Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663932548A;
	Tue,  2 Dec 2025 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719845; cv=none; b=pqQX5e1lRnVLgMN/0YouMnfbtB/AjpyE8b7P1xIEq4wrHLeb4omuWw3tmtE8CG4Qno/4xmoCBcpEcCTFw6LALBf0PNKomakH20eIc0f6x7cN3xW7h9At5lm/tbaji++RkASwkwjWOYzwV0UhJ4RQz3D8BztmUs+jo/MRKUklhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719845; c=relaxed/simple;
	bh=51SzdK5YgOrpwG29nPtjhtZWeR3CnIAEyultKDgodK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agkwdWxUJ9ToG3VX+MeSde2XwGidXpmM/M+iOjUnFQBHlMxLffT5dl5cQayotu5k7MqEgiEbrzdOQ5bh2WMlyljjYhZMCGzeNRDmYHpE2+nLDZrBba1wOiql4st/INxN9NwBz+tf2PAv2FYgEYAZopYbRdeF4/TSSHqHXEp7e5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE8FxKsj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE8FxKsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A72C4CEF1;
	Tue,  2 Dec 2025 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719844;
	bh=51SzdK5YgOrpwG29nPtjhtZWeR3CnIAEyultKDgodK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE8FxKsj70s8pG/l0htHiXf9GvKqCEaBP1DlQC44ewU3rcRZHomgCRHF495JgCSbR
	 PHJbmMZrmUiLKcMayp/sLFKbaoz4PXMWi8wbdRRbpPDiaG+Gi1HQVvPIsdEyYJ1rXR
	 W7g+r7R2+ryRC6cSRJTR46OERFhngfIuihlBtalBXrkmru9HKuisQafMok5+FZbmDf
	 TsjpkSp5UUPi8liRzEh3KMq1K0YWLv4FPNdcStA6HoT81ebIm8svhxPLZSfV9r3Tj/
	 2ZoG9gOS7U2f/tTP/8sMYmFDk2LlhbkRlWKiaiw/Sd1A+NKqIf+YGIiVGVXMyXuh5v
	 x40ZHsKmM4fvA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/5] perf tools: Fallback to initial kernel map properly
Date: Tue,  2 Dec 2025 15:57:16 -0800
Message-ID: <20251202235718.1018752-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202235718.1018752-1-namhyung@kernel.org>
References: <20251202235718.1018752-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In maps__split_kallsyms(), it assumes new kernel map when it finds a
symbol without module after any module and the initial kernel map has
some symbols.  Because it expects modules are out of the kernel map so
modules should not have symbols in the kernel map.

For example, the following memory map shows symbols and maps.  Any
symbols in the module 1 area will go to the module 1.  The main kernel
map starts at 0xffffffffbc200000.  But if any symbol has a module
between the symbols in that area, next symbols after 0xffffffffbd008000
will generate new kernel maps like [kernel].1.

   kernel address   |                     |
                    |                     |
 0xffffffffc0000000 |---------------------|
                    |     (symbols)       |
                    |        ...          |   <---  [kernel].N
 0xffffffffbc400000 |---------------------|
                    |     (symbols)       |
                    |      module 2       |   <---  bad?
 0xffffffffbc380000 |---------------------|
                    |        ...          |
                    |     (symbols)       |
                    |  [kernel.kallsyms]  |   <---  initial map
 0xffffffffbc200000 |---------------------|
                    |                     |
                    |                     |
 0xffffffffabcde000 |---------------------|
                    |     (symbols)       |
                    |      module 1       |
 0xffffffffabcd0000 |---------------------|

This is very fragile when the module has a symbol that falls into the
main kernel map for some reason.  My system has a livepatch module with
such symbols.  And it created a lot of new kernel maps after those
symbols.  But the symbol may have broken addresses and the later symbols
can still be found in the initial kernel map.

Let's check the symbol address in the initial map and use it if found.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8eea49c50453d13a..b533fbf17a8b19a3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -951,7 +951,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				pos->end -= delta;
 			}
 
-			if (count == 0) {
+			if (map__start(initial_map) <= (pos->start + delta) &&
+			    (pos->start + delta) < map__end(initial_map)) {
 				map__zput(curr_map);
 				curr_map = map__get(initial_map);
 				goto add_symbol;
-- 
2.52.0.158.g65b55ccf14-goog

