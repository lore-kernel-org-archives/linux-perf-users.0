Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795279283;
	b=ZVjMxan+yWcOtiu2VJYXyUhIGHOCjrG+BG4MiK6d93qxd1Ri3MLHzsxqHQdtt4pbRVCO
	 myOt6zx8p1mkJYnjYRYuyB2bKBjR+8jd8ZNNq9vSJwgLCfASY8OcxoyIl6v8Gkyk4DVvM
	 nBuBn7+f7aKIaTSZBSOqSMPlDlHiWbSx+vA1DOtugGsGDd8v0nPAur79F9lfjOPbflhuc
	 uFWHfR3QbsQPxv/j27nYQfsBkA1Jevu6pqvex/fRN5P/whYdYNjlfqi6P6x7EVmYsCwLm
	 5Cp8gqyoLCA/3CnCVWiReedkbdWyKF/fPILSs/kolwyZy6a8YAX31XT4w3fYyzXie4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279283;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X7jOf2bHUIQ1znpCVryw+UrUbONt2NMOHYuwQfxmifo=;
	b=ThBJlkPM1i6LbVIPHOpM8N7YUMz3V66gConpJ0RE1ikViJRQcuMlXRlyH/1+EYDhC0YI
	 PxwiOnf9MO46soRcdEK7mdDDtgz9bV67t/4CNCwK1Hy7PrvArH7kzRKksLzjj+JwzWMHA
	 5svJFvZrNe5g4ooJWU5nfEaJBm43mf9PhMXq6bU246LQdDeFbHiC/h/LL1AGarCjCyxoN
	 jhN4Pw2mxmkgXXFThD5QP3VgQJRnXS8nAPsIV9fTyGnU/9PjrL3cfVA5/d8hrIZ+7S+GR
	 RCn/htzNQFDTkKWCs+k/PUkc5vckSJ7OB0QZzG/Ge2wJX7s+teYahh+h9E4paVJ/ZlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IH22OBsN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C361606A338;
	Sat, 21 Nov 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IH22OBsN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795279282;
	b=pfffIZ7WdMddK4a6VJFrJzoWMvYG1fP7KbN4sZIzicsTS4PWfMheltTQyDdY9GBn4NT4
	 dPDvNRGO7OvRcFio8FiLTmw36L6Z1NDsNMKHkdfIDiYW5X9ecshaFNfvEUt14bs2DAKcS
	 AarmxJpCCPO9o6j9EE4NzkSid6w4UyZ7PA1V36EhrR35vMVnyCE73RoNfIH3AEJXcXIXe
	 yMJ0N3ACz9SBZ3ELsu9g7Ad9bksSiavGh8jJ4gPvoHKHqnG89IepkKTRrHLYLI3USYi5h
	 gNLvqLLoUCOFYvcsPkYnxxxHwxrenDRDZ1OUWf84FVezqt9hGLIK9FTS9CVRCxhod7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795279282;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X7jOf2bHUIQ1znpCVryw+UrUbONt2NMOHYuwQfxmifo=;
	b=0nExutdnmWUlDlKLT4V6Tn5Ssqs2mETwsz31cqcWbQWKijYZXwya5wBXIDRdafsdxmep
	 /rQAyolVzpKJhHUvsRNDK+UOZL87L87rBejNxYRM1PhMLESI5eGlFCvuTXYDkyq+I4Fm0
	 p1cDfm2qkBXTfuc86FkVX1ctb69FBGjlewFNu6hLCjLsKLzyGkzas3QEqFuv82B6Rw6+F
	 PBMM5/Wkwwk21K03oxtyjWAtwiPDoko7Y1PkOKMHoa6BUN9MelFXQsUtIDYuFbPgO+BFV
	 DIcNQsKDXFxqREcskxjgppozzLiZ1mQTY2oKhvXWBFjK1X4BooJPX5duC7oaVxSEoxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 778431F000C4;
	Sat, 21 Nov 2026 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795279282;
	bh=X7jOf2bHUIQ1znpCVryw+UrUbONt2NMOHYuwQfxmifo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IH22OBsNRMQPqU7E9AUdm6aNO9kQns+TURqi6rSlTYrRigW8j6xL4TGpIIQPkPMjW
	 +pfP8Z8YVAMazDSRBmXDb2xweE9Qwm94aoNNPCqOixcnNnf4xHKY+0DBF5Yupadn2X
	 qChKKw2JSDwN6DK2J5CBUUdjgQYI9A1a/GnS8QHXt2fXIeE7nCvHktBFSwKvYYLL2y
	 9FQ206xfhU2wBAEz/j6zuTfk/Aq7enWSFgPOp9xi/AD04sYjzmvsinzfEneERn4bMn
	 pCvPy+t6ZvXgBhGVesFnBU3lZXbA0grVY8wCavKcoUotmFb9qr6m2V0FcKLOTUOou+
	 l3691Ay3F4aMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F075C4BD00;
	Sat, 21 Nov 2026 16:41:20 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Sat, 21 Nov 2026 08:41:01 -0800
Subject: [PATCH v8 1/7] perf symbols: Split out name-independent duplicate
 symbol selection
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-perf-symbol-memory-send-v8-1-370561cbb5a7@uber.com>
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
In-Reply-To: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=VGrhvbBMlOezaIej0nQ/zA/IXFiLbKzeTc7elGOodLk=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrAcmt0Xkby2keCpXtfE7nzOqOHFa1/SpVOjDrh
 H5FxvVNhb6JAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawHJrRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAthd2w/8DvPTWAN9EW/zSErnaq9QLh0x8joZdMi
 ikZEQLuy8GsPxKefPLCwKSeoVDsTW7BDbLvBg4aqucPvdL5DImryrOk7t2wbaF1kSKhSHPL1oFN
 +8BlQ+6fEdJVnQfSSesn5pZ1HDzk1LV6OANDKoeCebJEmjhAMyV9ctgspCD8jNRNXJyibtzVlB6
 hIVxSK1TShS60jdgpRWxy+hgCHjR1CVFjx8/NkKnv8mruLz9DIdAvfAvN8UyLrGNsRA8GsR653K
 th8OQEo/saW1oIRuZJas8+KjmnJXd1UKku/7GPqEz/NTVsKre7WjBKJA+2ymkpPUEa+vytUI5ut
 4Ee5agEsaczzEJH3oszq2eEFCd8OgB35NxFUiCJ/VQbCbOyTvDREvYmYBd6N1PPwuO4WbTFD35J
 kpcCfzYMnjeEXshsA4WyY+uYrn9oZ3CErd3n9qI+ccJvezuuKlR9sQz6YboajScXhNVugY4UsxY
 m896Qbh9NZ+nu/BDQDQofpsxtYPCvREiujFLmfPV27TMVtEXGpFH2sg+9HdaMgvmeDsjmxvsFhr
 ynbJ7XtsBbYiBgufqqo/jTvpNda72/T1ddvSBNSsqhyNmEj2gVCJSZ4A+m9dfBqk0tzWGr/XPi1
 tn4Nzt/+kjkPNK3zUXRXuddw2pb9Ddt2r6JBoKc2k0f66cMEHY/c=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

This patch is a refactoring and does not change behavior. It moves the
size, type and binding checks from choose_best_symbol() to
choose_best_symbol_by_attrs(), and adds symbol__choice_needs_names() to
tell whether choosing between two symbols needs their names.

symbols__fixup_duplicate() keeps one of the symbols that share a start
address. It compares size, type and binding first. If those are equal,
it compares leading underscores, name lengths and the result of
arch__choose_best_symbol().

An unresolved lazy symbol stores a file offset instead of a name
pointer, so the lazy loader cannot call choose_best_symbol() before it
has read both names. The new helper lets it leave the names unread when
the attributes already pick one of the symbols.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/util/symbol.c | 26 ++++++++++++++++++++++++--
 tools/perf/util/symbol.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a1ac1cd1d2e7..a5ed8a65986b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -157,11 +157,15 @@ int __weak arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
 
-static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
+/*
+ * Choose between two symbols at the same address by size, type and binding.
+ * Returns SYMBOL_A or SYMBOL_B, or -1 if only their names can decide.
+ */
+static int choose_best_symbol_by_attrs(const struct symbol *syma,
+				       const struct symbol *symb)
 {
 	s64 a;
 	s64 b;
-	size_t na, nb;
 
 	/* Prefer a symbol with non zero length */
 	a = syma->end - syma->start;
@@ -194,6 +198,24 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	if (b && !a)
 		return SYMBOL_B;
 
+	return -1;
+}
+
+bool symbol__choice_needs_names(const struct symbol *syma, const struct symbol *symb)
+{
+	return choose_best_symbol_by_attrs(syma, symb) < 0;
+}
+
+static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
+{
+	int ret = choose_best_symbol_by_attrs(syma, symb);
+	s64 a;
+	s64 b;
+	size_t na, nb;
+
+	if (ret >= 0)
+		return ret;
+
 	/* Prefer a symbol with less underscores */
 	a = prefix_underscores_count(syma->name);
 	b = prefix_underscores_count(symb->name);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a6a2ab200f98..fc98fab1c8d0 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -295,6 +295,7 @@ int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
 int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
+bool symbol__choice_needs_names(const struct symbol *syma, const struct symbol *symb);
 
 enum symbol_tag_include {
 	SYMBOL_TAG_INCLUDE__NONE = 0,

-- 
Git-157)


