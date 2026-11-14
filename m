Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794633000;
	b=N9hrFNEGrlAb42EjmfT3K/NtM6rPvYrI+jvDNfK4RvEheLriK+q5FpghuDq3och7RARV
	 pGZJMItjkXi5+1yyoY3efP+btX3809ETgTxuBxl3tnzLCrWmmpLWOjOA3MZzVfi8P8JaW
	 76V+zMRizZTUS5kSXvB9vM0fFV/2GvzG1JkDQOi+Fk3Hx5YWNbv7K1ec5QldJGgsjj/Zg
	 DevPSH5SokjVOkbKvbwbaDqhWlgHEFYvzmN2SrTg2U54+x+6HrjhreAPWJbQwXD596p0T
	 UNSGY/PFnsMTTuAQ+LVoyPZqAlSdPv2rI6gPem08pYsyc6govk6fSkOMhRf2OXfeVrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633000;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CmUMfTEIrSVPj9+nTqq+5XofnCFeqQ5zgVwy4h2b+rM=;
	b=iO+AqJcmmzXaLoWj2fe/8SwGIEfZ4CNTjD3h/Co2dwe7u5/nUxmJLt/F+164fN/+iZps
	 gKisg8mPNG0LChzL4dMIMHz6mA2eAChyp4+o+piouaCLUT3dJcIdfCOstMmNFhPOCrqu4
	 plSt6kPE7xKFeL7oFPJD5FlKoHkxBxh3jtKjFeCWyrsozWmdDm3YUy896WFQ9zU4iZWo8
	 gkSPq3m6y9joLOgP5vex7cIIy0Rtm0nPYYYtdJzpM2z5jJQ10I7sW8FjOal7lL7Cd7Z9H
	 hPZkPA6lG7fR6LtqAlKRqKT1nf8VF0nLjWpHl19U0lBVX01gFYyE3wkl8loaNrvJ3NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VASCQhea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633ED606A884;
	Sat, 14 Nov 2026 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VASCQhea
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794633000;
	b=oPGVNjRh76qvsq8eVoWWmomH/1sNnhTJDBsDqUrqsXdRYVOeJxSKDYPdMpphFPsCJiHp
	 u8UaxkKfHKLBhaGC4703kOHtyWjp03IuWPaXgDtefEUUydkX7jNVFjnvLWrjkkBG7Q5l9
	 e3xAz44z9tc2W/U4oCtKNMed4hs7xDDrE9rGIManH05NrpuGw22/rf/gZX22bbDZAcVCR
	 Rx2ArDAQ9AwJboE/Xa4Lb7M8GjJ+wZYwKLy9Qxnxdd1UIozimlpez76KuRWJ7aOxT0q+b
	 tf/cdts+MXdiR6TNR+vbwg1ec4LqfoC/Dnjt0qGKt0ur98es5BtzO4nwb6veg2pdZ3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794633000;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CmUMfTEIrSVPj9+nTqq+5XofnCFeqQ5zgVwy4h2b+rM=;
	b=U+Z39vnnNsmEPWfG37PTz+WZXio7LaRFkTHN8p7raZPmd4T/5FOfPhvUGSOTdDokyE4i
	 APi9dzWgqFc/pCnsJKrtzOWEJpi6nKJ5tXZu7lfnZuXmvbEe+s3LD0BeAEBw9Sxh9IKhl
	 zJ6D8GmuVO9ihxYJd0gRDKZ/2sxLXTLsnvRXOkTv5ZhUEAZp2KTweDxDygJI6MyWf/JjH
	 Yp3h09IGVD5x7JPCgxGQnqohyL1rMhkikdFpgfoUChFEYSgzOlJ0JdmdOPlufrbfM3LdW
	 Jn4nn1XBPu+mynKNCSSbmlZR2WrR4wvQK98b8qX/aD5zUICW5wD/hyHIdCwglN7rjyg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D70B1F000C7;
	Sat, 14 Nov 2026 05:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633000;
	bh=CmUMfTEIrSVPj9+nTqq+5XofnCFeqQ5zgVwy4h2b+rM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VASCQhealflqrbzVADQFgqWDDTr7tzwBi6bjbXoKVx6a9jZzS/a/eLIy8JLt8F9UA
	 rvo0OPi+xMHdvwA1JclOQH11AIRCUDve4M5AxUwmAgH8CDbpyrUEW2nXyqe/kKaKr2
	 nypzOsidWxEl47v3ef8Qbq0Lu81QSbqyWmsj6Nzf2fMY/0UrFrIiqNpEH1NGlhJX6R
	 l9xsOL4K5A4TJCaO+dXwDqr5gP9Jh32iPO6+/lmK8XDcEncwzUMm4c2x93snDKlpNF
	 isNPAcH9AdP/5FuCTSL+qwXOgW8+4W0HocH8DvbRi2wV4FVyiJdesnlrPyM2tieX9a
	 SljEWFDMDLRPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7AA3149C8D;
	Sat, 14 Nov 2026 05:09:58 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Fri, 13 Nov 2026 21:09:06 -0800
Subject: [PATCH v7 1/4] perf symbols: Split out name-independent duplicate
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
Message-Id: <20261113-perf-symbol-memory-send-v7-1-d992eced9f9c@uber.com>
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
In-Reply-To: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=DQuKAcc/eg1Lh4Q4w9Z+uaojSWSxiLMNYdq0w6yVHrM=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBq9+0k1kqf2Do+wX6uJQRiiBZfDFhqQ80oxmnN/
 uq7oNIRXhmJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCavftJBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtgKQg/+IWL+2AbqKWl60cRWmq8gxWwUmNMVQSu
 iHSduKWCllyivQo7DxrJQToN6d9+HHYYWGFT2ECOrL6cPXRqrx3/HU2kjm23Ox4A8s3XPb2W/9j
 I0bi4BYbcQD2gKCkDg+UODhu9sqk9c8OmiF+BLPb6I7UDgjmfBhK0XE+OMoSBfmWP/bgtydaQPQ
 JfUpgw3jbP/822Yz8j22AdVdY9xN1SwDRMpPflei/WBDaR8o+UkorEpjzlfuBJb2nK84WXr0xfz
 D8jwjwgwnGwScSTPYC0RdfSqfIsXqq/ZRR6gc+WQjilEOWyK2i/gUm+CEED3ldnMKNp8bda4yEP
 stVWrTKYXyM6u3DSE/y8F1hYvgqZ/UhNr2x5lehCHBOPFoT2pLV4OVQimsGAj8jxGcfV26fcdAc
 KM5v47wyvEJfWxf1NqQa2ee3eN0VVJGxEKiojGuT//m3RPXP0pIZLeJ45i4z1MawkKKJuBbUAc6
 9CE6eM7CdEO/fi1OmeVorxQhFb/S3AuaRMbjyoeDuEN/nixXBGNjQiubYUxDdBzkvxaUDAoBM6i
 7t2aclThmSx/Sa8PnwJtio853wf7kYAaXH54WDcwTV7ySzlI4zGiO1gAo9pni6cv5Bq/3KAr9aE
 /mMy7UnnrjyI9j9p6BrEl9yYxZC26OGxCoaRy9Vs4bHHhvWV87BA=
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
index b61a574ce9a3..2d611c05d000 100644
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
index 6347bd218ad5..ae7ede8f6070 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -301,6 +301,7 @@ int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
 int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
+bool symbol__choice_needs_names(const struct symbol *syma, const struct symbol *symb);
 
 enum symbol_tag_include {
 	SYMBOL_TAG_INCLUDE__NONE = 0,

-- 
Git-157)


