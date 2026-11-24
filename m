Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795548563;
	b=uO/+t3MeJtWpukTRiiEINfSncOUyFFG5CSNMyd5oNCIRbzUmssR7Pb1n+LF8s7OzzP0B
	 JoWzixClAXPfXhpwyBBdYGvW4Dzh3bgraq8qQzC9jrOcbUzTvGeKb3B8+yTnA7YaXSz1d
	 Q8A5EzRpX5glPPS0zHDB+R6C9pjX80/4JXP8a6m8hfDAkjf/ZkVBM7rgToTI6LVXphUYE
	 eSY0j4gcFivAfoAQPx7roBkp7i/sknb29iqiVle5IcWm51YZA891KzegPxJ36RT4n3lFw
	 xk1ONaWKpObCzHSWB0jW1M8DZ5y9F0fYuAo6jFDA45O9d+Wn0HVED7RZKcuZr8sa5tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548563;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h+rrny5OBus9/cvOtjxl4whOeX2bBelq9yxd+2tysUM=;
	b=b1gxiCY/Fk6lWLSb1Yz2yDJna5rIBCxocjIIhVsHL4KXR/SDh560UFNd1HIRRCdAGbyh
	 c5/a+GZlhxFWyNV/bfSmmQFDyh0n3S3AP9UyyEhQhbEMdEhE0JIFlEnXJOBMf9aLEJXi7
	 rYgnvokTjwlItXVhMaHX/WjwB5LJMKzD7zWl8ZmRpudAu2bUNbco/Oj/BKp+QOKODFBFo
	 +xSnLOBhfA8RePiI+VErOgHc7iVKYjdOXNR64i6euVBlra+qyxRVjj19Ec1aV3MBWen+N
	 +S7rOyH5H/Y+sUhyvi/VO4R5X2dhUqufWfai9u0nRbzOYiO02Ah1Gwfgz3YqKbcGd+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRWBBjny;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C987606A321;
	Tue, 24 Nov 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRWBBjny
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795548562;
	b=x7A7uAwKrsYNVx415E9FdYcDy1Qg+XKODEubI1x2KiS3abRRyNA1FJApRg9h8Rvcrb8O
	 RpCEJixsseEi/AMy6NcjpNHvsqNE6CKJnOKdz3MQz1o4qam0ieDl4xVgnWfksNbP05niX
	 bVYfeaH/0jiGrlSq3hi1QxOvEz8ppqZgazZoOyZ77HjkHsdjYNsmE9MeFTdrEOanUq2eO
	 B5NQMp3asD4za6dRpV5+k26P2b6e688fPD/Z+7u6Nu2mAGjS5ZoFfFAfIomJInf2j7k5d
	 +TQv6bODot1DA7iQVfyqpUVkjq8R1uUoI8dvkiogo3sDmJ6yo3eXNxglgBjzGWsQ7dw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795548562;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h+rrny5OBus9/cvOtjxl4whOeX2bBelq9yxd+2tysUM=;
	b=lCZdFm0IirMKAlBjhDn3hXDsCfSn0J5O8gjZZYkyzwnjj6bMAjKaxqj6XytRqOu387df
	 XiFP0qvHJwFubOvHb5bhUQ/gZ1q5vR4h5hWMBdMq6AGn1XnVf2LtvX8Z0UHxba7c67LCQ
	 LZ5el9lh24ZQ1OUoYs1bZeBdqsQht65GuRYg912pQkwun0f7kvTYN8LkBQ36NE0n7RwNH
	 nWs2rDwP3l2BrJaKOXepqLLk5qz4sFYd6KwxTe3bIZw02ZQwMOnGGDht6p49iOKq6pRCL
	 /9M1nFp2kIJs4mVCr+pb8SXikAQTWfwr/OG4hS3YIPpT5kaq3aRSJhVwD/J3kG00rDQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 597531F000E1;
	Tue, 24 Nov 2026 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795548562;
	bh=h+rrny5OBus9/cvOtjxl4whOeX2bBelq9yxd+2tysUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mRWBBjny2q35tjFIfHdjEWVRQlnLjChMY78PXywvYWvvL25B50Ax+dOqrxXFRgeGC
	 nXANt+bdlF1GJg0o8/S1BEWdHHJ1iGCvhUfdKlpWZMT1of1mnWkK/XbVGoxRSJbkap
	 MvPZgvqa7ye34NgLBb33QtE9shfPSOAy2dyOtrHZS+ve+9dIp+nAvY8DaCCxjqfnen
	 xrchTI9VWZzAtgY7IQXsVQL565ddYCLPmzdQuHlTlszXF0ec7e+2IcgeWcXKroRT7l
	 fRQtLoWJgcTNu6pfj+soksHiEGXPoqFISfvECiTfIi5tUOvtx3t7OWF2Z0658r1o7V
	 cvIRtmZM7aceg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DADB34CB64;
	Tue, 24 Nov 2026 19:29:11 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Tue, 24 Nov 2026 11:28:24 -0800
Subject: [PATCH v9 1/7] perf symbols: Split out name-independent duplicate
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
Message-Id: <20261124-perf-symbol-memory-send-v9-1-56f298185eae@uber.com>
References: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
In-Reply-To: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
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
 bh=UqrMhQWdcnzp2DKimaobLxyHYzeN04T9j5HC1/5V6JI=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrBeWEQCyb7BsUQ9ebI4IynMv9LLGJjODXVVulV
 kTyFiqg0JSJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawXlhBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjjDQ/9ERnMqlEpX//dRSQy6XdQ2nj8jubWWsA
 QvQ/yTDZxB6OTqfuLj+6ubsnCQ1zh8xOKkhyZniufCKbk8WrQswyrfT9DaTyjA1rGQo+sM0Uk9P
 TZ0CwDATMyVhhjoXdZNT3+lSSLMoqX5llzsNykHxGiH1eSV6FQbJXxx4JgbSY5b9U38oxQN/wyP
 UsOz7/gqZWcqIGN8QG9M5ILgfv0SDMC0Z2G/0tg/VApLnhZyEAnoBQFTuwZdGbsOBMdddIbrs46
 MJNz80tiiRgmOUa0nIlJCDrbAPo21c3TjnPNbBchalWv0ek8hr/JqZbDl8fyBojfpZVaDyUzTtR
 gT0LGHjVKND6cRiirUqzOPKwtXp29nsWGNAQGvjdXzA2UvhmkfKkPgKjjZm93LfHSUPrf+f2mab
 LMp1WaQTggeyPr11ADIPL3niyiZduAwhSxVjj5xnsoqiFQI8piRPwtAIHzZ0fk32ZKAROIAjOEO
 lAhkCHeHrB3QDbvJR/ldn4GRY77K3zckz6teoms67tZXw98unjnbeSx72DKSrAnzu/Y3ZCFZ9mG
 T2A/QPWV0aFkPiHKdz/E0/wtVGUxxlqVFzn+GXLikY3FA5/phf8L6m7MEIgknp02srxX9rboVGE
 G2UuQEIUfhbD9bV6SZHfHtWIC0kvGbzdFFd4QDG2mo+hDX41WhRs=
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
index 35b08c05a2fd..d9866916fe9a 100644
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
index 8b8ab7e1e148..41417bc85bb9 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -327,6 +327,7 @@ int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
 int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
+bool symbol__choice_needs_names(const struct symbol *syma, const struct symbol *symb);
 
 enum symbol_tag_include {
 	SYMBOL_TAG_INCLUDE__NONE = 0,

-- 
Git-157)


