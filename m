Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11034CE66B;
	Mon,  5 Oct 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221538; cv=none; b=Q4iuuy0ZpQT3ZhHbcYJxavxt4pa18YOtadcKVrpTgxuBhX3Jx45v7wzIJ890D15uWzl8JlQxp5mJNIU7YFCOQADJGt8pElrEcMO/MIG2IjSDKASMnB9PfiPN+EBUNjC8oFuJ2vLbZ2wavHKiAiZZEgbHM4CWXCtnnIbajGEzK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221538; c=relaxed/simple;
	bh=ef4/doqkLnjyR7FrM9GrShQwWwnrw1B1ABNfQvp/c88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBwUhyqZA5XhbFQ9sIQuKBGPcpLJjJhfMY6eOCMW02C8Ao/KrimSPArXyip6SMNnJrH/eY5cmHHiCWh8lj1eKcrRcS611WFqebGlS4p9AKNle/L6/8epPeAml+xdfbdJq4u6ZYabvt2TFgETMMgtIxXSF+/Nuoy6P7dd3Wxj1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSM7XZ4L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSM7XZ4L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AED5EC4AF62;
	Mon,  5 Oct 2026 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791221537;
	bh=ef4/doqkLnjyR7FrM9GrShQwWwnrw1B1ABNfQvp/c88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PSM7XZ4LLNXsoSxaJ7M5R0f6gCLG9JGvVj/XN/1Yivgea0mQGX0w96Ujwgh238FoT
	 5LsmwF54ZAXgKGTEZ0kRj61c/90ub1Y3oW1w+QCLNrk8M4YO/d6nAKZJl+qaMcRYuL
	 mn2HEqOVG5IT5ZrfP1MoAoBVPTVNS7L7xAPkJfI4ZbWtKz0KCguiE3IBhTT4lRsaei
	 45Q7fWgy6igBfUcmZrLFT1fdIf/PPDxRhRfoMKJw73eGjODbyrdHbl5YGU93Mqk/JH
	 g37jMor3L/fy7tqtg0JK0GEdXMk9xu0+gWkHSudY0u5dp4FRL1833W64ZZVHCNP4Kb
	 ZKoF1RSmSA3gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF7CCA5FFF;
	Mon,  5 Oct 2026 17:32:17 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Mon, 05 Oct 2026 10:30:33 -0700
Subject: [PATCH v5 3/5] perf symbols: Factor out duplicate symbol selection
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-perf-symbol-memory-send-v5-3-165dceb2b049@uber.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
In-Reply-To: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andriin@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5684; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=Ky+OYrqZSHk+7lank2LYMaDOqGiz1W+4+DT3dXV1I8E=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBqw98f66ieHNfTZS90y9izyK0f3CzcrMOi8PVvl
 46pNk2eXNmJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCasPfHxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjNyRAAjpfdRTlWU4dQiyJ8Qm1TZrl7EiHijLK
 /aeGrIafCfljk5WqBo3RhGrKT4a8DNLbqhHY4P21u3N5gXICTmQzUm8jtji0cvamlskLIHJjF1T
 Td94vwQWgdqFpyEslTmFgEYBRkhC2II+S+/gAnTSJqwjmXsyhBX9xmFFCuZZvQwvdQNWCLeBNEy
 tbQq1m2A0aSzmKQBQB5wXFuK5hyznSNHtQrbDP25Q40cs3q/oQW2uZ/B7iBS2dTP5pF2/k9wB60
 /HHY1CA2wTPrdruMhSRCMmXVJARIdx7Yv2sV31A+BhgojzuiAgxY3EXTpXa3DxAoD/Ji0rrL2cH
 JrRch1M1oYp4cXHfRQP5nY0IIqiKkxsmt5G1nWd2eXVgvWzs56mb19nTWoBoQl7L94rCIjEBT6F
 5bmusUAC82A3ENTpi+JeMj0g1914wHDmSuH48MFhk7a2amRWTvn8uu2jKzMrGsVAWuomWJ+4xEr
 O3qDoH9cxhpzqYJQOVGcuiMDBJTd5E0s/qPHhemakVg9WAN26iET3dnh37ev3LHvzUL+YvpGZly
 SaC7jj50o4okerLU4tClvc5AATP2urtHl0rnDYTR31A0zzjlp+bg/aUxp3t7mDeFQ3xXqbyCtgD
 cmR+upQwLv5WkpJIxwg/o/HoAEb6pcPE991WJN9tpb+AXJ4+fsPQ=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com

From: Alireza Haghdoost <haghdoost@uber.com>

symbols__fixup_duplicate() chooses between symbols with the same start
address through choose_best_symbol(), which needs fully constructed
struct symbol objects. The lazy symbol loader added later in this series
selects among aliases from its index entries, before any struct symbol
exists, so it cannot use it.

This patch moves the policy into symbol__choose_best(), which compares
the size, name, type and binding of two candidates described by struct
symbol_candidate, and passes the same description to the
arch__choose_best_symbol() hook. choose_best_symbol() becomes a wrapper
that describes two struct symbols. No functional change intended.

symbol__choose_best() is not static so that the lazy loader can call it.
struct symbol_candidate stays in symbol.h because powerpc overrides the
weak arch__choose_best_symbol(), which takes it.

Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  6 ++--
 tools/perf/util/symbol.c                    | 43 +++++++++++++++++++++--------
 tools/perf/util/symbol.h                    | 14 +++++++++-
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 947bfad7aa59..c263cbfefba5 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -10,10 +10,10 @@
 #include "probe-event.h"
 #include "probe-file.h"
 
-int arch__choose_best_symbol(struct symbol *syma,
-			     struct symbol *symb __maybe_unused)
+int arch__choose_best_symbol(const struct symbol_candidate *syma,
+			     const struct symbol_candidate *symb __maybe_unused)
 {
-	char *sym = syma->name;
+	const char *sym = syma->name;
 
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Skip over any initial dot */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5d98888d068c..f590b69f9f01 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -145,8 +145,8 @@ int __weak arch__compare_symbol_names_n(const char *namea, const char *nameb,
 	return strncmp(namea, nameb, n);
 }
 
-int __weak arch__choose_best_symbol(struct symbol *syma,
-				    struct symbol *symb __maybe_unused)
+int __weak arch__choose_best_symbol(const struct symbol_candidate *syma,
+				    const struct symbol_candidate *symb __maybe_unused)
 {
 	/* Avoid "SyS" kernel syscall aliases */
 	if (strlen(syma->name) >= 3 && !strncmp(syma->name, "SyS", 3))
@@ -157,38 +157,39 @@ int __weak arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
 
-static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
+int symbol__choose_best(const struct symbol_candidate *syma,
+			const struct symbol_candidate *symb)
 {
 	s64 a;
 	s64 b;
 	size_t na, nb;
 
 	/* Prefer a symbol with non zero length */
-	a = syma->end - syma->start;
-	b = symb->end - symb->start;
+	a = syma->size;
+	b = symb->size;
 	if ((b == 0) && (a > 0))
 		return SYMBOL_A;
 	else if ((a == 0) && (b > 0))
 		return SYMBOL_B;
 
-	if (symbol__type(syma) != symbol__type(symb)) {
-		if (symbol__type(syma) == STT_NOTYPE)
+	if (syma->type != symb->type) {
+		if (syma->type == STT_NOTYPE)
 			return SYMBOL_B;
-		if (symbol__type(symb) == STT_NOTYPE)
+		if (symb->type == STT_NOTYPE)
 			return SYMBOL_A;
 	}
 
 	/* Prefer a non weak symbol over a weak one */
-	a = symbol__binding(syma) == STB_WEAK;
-	b = symbol__binding(symb) == STB_WEAK;
+	a = syma->binding == STB_WEAK;
+	b = symb->binding == STB_WEAK;
 	if (b && !a)
 		return SYMBOL_A;
 	if (a && !b)
 		return SYMBOL_B;
 
 	/* Prefer a global symbol over a non global one */
-	a = symbol__binding(syma) == STB_GLOBAL;
-	b = symbol__binding(symb) == STB_GLOBAL;
+	a = syma->binding == STB_GLOBAL;
+	b = symb->binding == STB_GLOBAL;
 	if (a && !b)
 		return SYMBOL_A;
 	if (b && !a)
@@ -213,6 +214,24 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	return arch__choose_best_symbol(syma, symb);
 }
 
+static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
+{
+	struct symbol_candidate a = {
+		.size = syma->end - syma->start,
+		.name = syma->name,
+		.type = symbol__type(syma),
+		.binding = symbol__binding(syma),
+	};
+	struct symbol_candidate b = {
+		.size = symb->end - symb->start,
+		.name = symb->name,
+		.type = symbol__type(symb),
+		.binding = symbol__binding(symb),
+	};
+
+	return symbol__choose_best(&a, &b);
+}
+
 void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 {
 	struct rb_node *nd;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 46b1649c64fc..b9fa722a9a14 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -299,10 +299,22 @@ const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
+/* Attributes used to choose between symbols that share a start address. */
+struct symbol_candidate {
+	u64		size;
+	const char	*name;
+	u8		type;
+	u8		binding;
+};
+
+int symbol__choose_best(const struct symbol_candidate *a,
+			const struct symbol_candidate *b);
+
 int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
-int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
+int arch__choose_best_symbol(const struct symbol_candidate *a,
+			     const struct symbol_candidate *b);
 
 enum symbol_tag_include {
 	SYMBOL_TAG_INCLUDE__NONE = 0,

-- 
Git-157)


