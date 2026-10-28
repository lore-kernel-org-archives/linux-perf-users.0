Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793230970;
	b=eEy0m4iS8KE7KwEFMZmt03tQgasqLysJ24mdHb1610vTTGchWi5YwKeT2X/cKTkntpfk
	 ZSqCTpxRMLqs7QKJ5hU4nVPmqr6DXCfQwUDXHHY+mYB1v9WT3m3orpnV9tUOuI1S5L1/T
	 5mTNaeROngaaSSGwlBcZT72nVGW77HCCyluvd/7EaetD3s2QCmVnTcue30Ncvd65o7noA
	 T+KO2pc5Uu7YICH5c7KoJj9bkABpog6P6b59I7KgSkbG7XUJOT9RxU8AM4/A8Ij5NxYRs
	 Mg6g9I5/toZ4IuGsOUoR2y/QhmY22BJhb0lmhJ2lgg+iFtdwVmYH7xfGyZ+o/gZUEqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230970;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=viCUp1crSW2jGJfJ3UlDk2hvRgqBta5P86Yf/Op8wjA=;
	b=5a34ZuOtilPpsIiZN2HT6smXSnoKLiANstFL9pihuxMHOy4huww/YgOzuZUMqDP+F6yi
	 0yt3k/CwckrkqbUJAMHBrDWqOC4tALGFCm2SkDJ9Sm3EpGS1x1v0qT1s//o5JJkyjfSdC
	 zB4kcdHsCJj/KGkGhRsL1DH5pt0fi+hCH2/Pp73YVQd8IyhloLaycVcBqlLKiWgLbO7Ay
	 Hdw+29Fv+aS+O5rjkWyxyzCqTM4pd5vLzyDPhBw37p1fpodx5Z5aTZyt2teNStMr4zdPh
	 p1ZDj18OlpMy4yXf7A4OWm8aNoSkug9/AewrZ8SzEpD0FxOKdWJP1a1CSZpsnzijhGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwF6AsRW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF0606A31D;
	Wed, 28 Oct 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwF6AsRW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793230970;
	b=xyq+rcWKikUoQ24RsWPlSlSiULlR1+vO7UVRXPUeun3xbItwGurnrz7W2A0M4IQJrkDA
	 96tkCV7TvN/5/SevSk6lW/YMXS0Wu1SvJ71oqCxaeIX+zw7Hw7gQrcmD8y8mHs8Ld1Q87
	 TgRkM3UwjciM5bk19rMUYXkB31ACWMNoyE4i3cgjZSd/sLt2IWjBp0Xka2UfFe7ZX+LS3
	 8ujTXrs8Tve3NZjrm6k1HB+a9926rbkik6N1GpLdGeYUiv2nU4O60R2EKgbPFdUPxqWvj
	 USRzN4De42KEtGgR6ylDQVDuR4rr9soFj/iH2fd2KtDJL02TZq/RBYfDpUKra0kJBpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793230970;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=viCUp1crSW2jGJfJ3UlDk2hvRgqBta5P86Yf/Op8wjA=;
	b=Sk4A/KmxOdyGzTicgre8hf8Ip+wCuPSnIiNnTkzgqabqt73DyQj/ehsaUwoA9YFcPsbp
	 Xxlrmo0bjandg6zFN87EC9DCFQacMWK3AfuTaLLwA112wZGnHNr+rLwHnt34Qv3a2FD1N
	 WtbyZ+qRRzQVfjK0IgE0uZpKdWkkjwocqYFSZTzqpoATBIPCIhLq8yWoT1ggCAiX3wK2X
	 DYUyd7YNDu6n+mSuN9fHf/OwSEXBZVDlfsWsuzBRufPbnFeT8KRX1oSj2Lyx7++PE0PlY
	 qAOUmGr6Krr5OtW7wTUtEwIWVEYdXlN1gOBdcr+EzQhBgeIR81ez3reutbqCkvvt49A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1D9B91F01825;
	Wed, 28 Oct 2026 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230970;
	bh=viCUp1crSW2jGJfJ3UlDk2hvRgqBta5P86Yf/Op8wjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mwF6AsRWhL+zke4zRek/V3j31Bkf9jUP4N1PJJwJC5dXACNNdmLRteSD7Q/LYpnEC
	 b80XAfnZapz1GIfAH+9vj/nJOwilMq+YucGkm9HGHcBiXRVF6EiULxYPTk215NAai0
	 0VyqZI6L/jZ1aZc78A7c8OHmAYnxS89AvMkZ3HLm9A76xhpi6XVPycjS0s7vOm4UMR
	 Vk6cSc7hmGcpH34tMIZv4mbVPgdDbn+1vjFmaqRVkgpyk/pX/7jjczdoDq4cw83ZGX
	 N/4h3/tTrPmaRUQTUezqdNv1JkO/VQfdGdnniDXIQdYFrreyt3f2QcKt9m1y5tPnR+
	 PvEtwWS/RotFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94AFF4562B;
	Wed, 28 Oct 2026 23:42:48 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Wed, 28 Oct 2026 16:42:34 -0700
Subject: [PATCH v6 3/5] perf symbols: Point to the symbol name instead of
 embedding it
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
Message-Id: <20261028-perf-symbol-memory-send-v6-3-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
In-Reply-To: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=StUqBnmB7QE/x00WFgZFXRbs4qC9OsQOqq8JJSIB66s=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBq4oh2X2YhnuN8Atl7FP7ZuNj2so0EbTGJo3DCM
 B8n5IlOJIqJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCauKIdhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjYExAAm1r7nsfEKO3RCcNzWSYQLbKzprw4Rgc
 h03jixxBalliuQYkyu+VsAhBgTiX0x2ARqszoH8ayjjh15pBGLgIKakavaybX+OmE+Sp9ih3sn8
 zLtZWA0bxz3T+HIGmsAsP/1fJC6e22JYJwFKv1hNWPBi9nlz+t1mxmyOEh1B0ePTk+C53N9E55j
 tNeYzOf7N78mi/TT9zFoD17XY5TpJHqMMbAt5IsPrVFOn4aEbd3+9j+5eUxJiPFVnU/Ff2mJmk6
 VIyoGzMNdSuaUDryBEKDerCjczivPG/xi+oEBYadNN5nNnA0jWRmslXvAsupWvleFxS9WTKO9VJ
 nGE/teWGGes3u/D1DV3M8h6K8fjZ7c/0Z5llOW+a5CF868FwAlsh/vBByzC50BLM00UWRLAWnUW
 YannlalMTPNmdfrMcoskGjddR65iamCAKtpcw4U0FG9cs5Bdm26sL0sqnhqg5buGlbqRfwUrzrR
 aLKtYoiOqIe/FF/51iP54qhIX4VnG+ihFq96QiqyTBHtLcvP9JD4up1fUAs1pfzrKjK2Wu8AXBW
 qhPb7rOOVJpDaH5qysgvBt+hQOiG62dnWQwxcN5JgRlCl/KVCK+UFSEox35KMDyncwKKwAXO5Md
 P0q98P6nDGb53Co0B2Pvjm+1Q9GgzVASs4Ae+87y+vrMdaQBtRuU=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

This patch changes the type of the name field in struct symbol from a
flexible array (char name[]) to a pointer (char *name). It is a
refactoring and does not change behavior, but it adds 8 bytes to each
symbol allocation on 64-bit hosts.

The next patch creates symbols whose names are read only when they are
needed. When perf creates such a symbol, it does not know the length of
the name, so it cannot allocate space for the name after the symbol.
Perf also cannot allocate a larger symbol after it reads the name,
because the rb-tree and the callers keep pointers to the symbol. With a
pointer, perf can allocate the name separately and set the pointer later.

Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/ui/stdio/hist.c | 1 +
 tools/perf/util/symbol.c   | 1 +
 tools/perf/util/symbol.h   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 8c4c8925df2c..c65e3aa73a13 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -106,6 +106,7 @@ static void init_rem_hits(void)
 		return;
 	}
 
+	rem_sq_bracket->name = (char *)(rem_sq_bracket + 1);
 	strcpy(rem_sq_bracket->name, "[...]");
 	rem_hits.ms.sym = rem_sq_bracket;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2d611c05d000..02c077d7e2a6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -362,6 +362,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
 	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
 		  __func__, name, start, sym->end);
+	sym->name = (char *)(sym + 1);
 	memcpy(sym->name, name, namelen);
 
 	return sym;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d8386c4a7fc5..c231d8e4427c 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -95,7 +95,7 @@ struct symbol {
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
 	/** The name of length namelen associated with the symbol. */
-	char		name[];
+	char		*name;
 };
 
 void symbol__delete(struct symbol *sym);

-- 
Git-157)


