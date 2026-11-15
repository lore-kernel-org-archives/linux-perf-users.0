Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703165;
	b=OFZMPiijG5JpQEAnD8vYWE2rShXycyohF2J+M+JHeLWGdGJxNaVW98PLLH3SfeYFOGW3
	 kQYgMjnDmzDEs/MFlkOk08HJ04pPPXqpMLj/bHkrwOpUgpjX9UJ3wLpYA26i/UNnjrKed
	 wQ+TidVIqbUGPEQW4OVcEmCVNMT7sxkeGMJP+H/+302BUT8dMGLKwuRhONZvLOqnj/k8L
	 hV/6lz3+dBMUlYwR9cDFpGqwBHLJDl/W8GRaupzAZnyrCx/x7AYFJIppm+cUCHKsaFNFj
	 071Y2hd1sSIYZobBwcrbE9uskBH3P/9S4f0f8WhJ3/lRTdhMQoCc1jjQahHO5Wo7CEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AmLLppEFOPvTRAprkKzlNES6CSqTXbzX5HYhiEOrIVc=;
	b=niyWlRvBwdF1oKDIIEMy8mZeS8c6o5mFUAjwC9E68Okvl4nDX21VCMr7mizQHVAZuIeG
	 x0Ic8+ilwh7JLZYt7HckS2mNHV/h+bnvPn21h5aum1RuYG/rHqbOrryDWIx0rXUU0o82e
	 +SAVuKRaFcpa4Yl2yOMXrqzomc3nrpzjHz0glgbnAIt2++f6KKzf+mN/1MmXRi4inngDT
	 +qqxJlEYcP7Xzx2kGjIiNwNYvY172Ps6BHE9Xb1J8kQLtNVwawgOBlDsCed5GsdVlwk8O
	 FgmGRGHXxg0dly1NxBhvRkIjcouLhpWIH7tnldC4NIkB9tmlNkEDIGsCC44kTemIT0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/DoGnhF";
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160EE606A33E
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160EE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/DoGnhF
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67be4686827so2127727d50.2
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 16:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703164; x=1795307964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmLLppEFOPvTRAprkKzlNES6CSqTXbzX5HYhiEOrIVc=;
        b=l/DoGnhFF7+ypxBEew/dllCBAZYIA7H/dltmZ1WcY7x7O5Nkb/CG6EvD98YUwIWOSy
         dIVQt27CGjHX4rgOGxXDuU1obvD3otLbmLKVY/eEXMgYkOj71JGZenaJLQnjligFcX0F
         Wt2ogxCmi7+MUtHcbQsfq1pSh9bxqFevTiauym00k3TqHO6poJzx2XdupYeIjFU17DnA
         Sdeyv7ebInjxttZLll5H8Z00iI/KLd0nlSShkmlXXVL5OHkqOETLDt4weZyU1z8F9VAX
         2MN1QpyRMwamArI5jcWa5mYlYyC6xT7rH89uu4S3EE/dj5WIemKI3MpkqAC3UGk1dnVo
         YtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703164; x=1795307964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmLLppEFOPvTRAprkKzlNES6CSqTXbzX5HYhiEOrIVc=;
        b=XpzH7p3c4XRUn1DTM+Hpss7cAYcgxF+MmtT/qJhPRm9hg+iBe+hgO8ahFsNbL6gt9q
         x9W/ZhBqDEsGU9ipU/qt/XGsahWYrUUlQBKiHr5fbY8tFrNIfpKGWah+ycObuMYtAjw8
         xxbwBG2aBV6MS61Bi3OPpgvDvGzm6uup7A+vjsSlYF4QBbvB56MaVhL6jhiZ2FsRe/0T
         u6kvJ9LdASREU4NNcbhzUYzT6GUtJB80VyJ3jm2Bih/nU/VKpjk6pOhAFvOz372dupOo
         If+eiGEgIv9DyYDH0GxPtWnhgbpLscSBMzmhAH239NSueqdddPenxNZigo1dZbTe7xQx
         fQdg==
X-Forwarded-Encrypted: i=1; AL+hErG9sjyB6xxtyRNnqR+sgTsTBHPFz8EX+sRo5E3xtx2on+CdE+JpVBbj4dfaxaUBOs45fpGcYtDmVssrxQJUzpMH@vger.kernel.org
X-Gm-Message-State: APuU4Z/4+6JGW88vua8VN3CphN52B6afWoI6rf1TYBX4U+fx5KZ0Juoz
	RSTGcKmLtpE6akfC3x6YbpsqEO8WF6FMLPFDkGyOMeAkKSSzEp7KkCDh
X-Gm-Gg: AYBFou0C1lglhvJH1cjB2vyP/l7tiERh39etQiQ70ljUQtbxI8hDkPeUjtxHwzDZ6jZ
	k9vTMBgtWcquO9zlrhM1vMmAXA8CnFkceK+a9ZJ5rWsrI/IVkDi7E2n7luVAGCVJE+U7qNGyL4L
	U0mMdspT44Pb2AEc6uKkT/TY8EMT9S6LkKtZmOGzWteKAKgL1kCirhUK8PXL0BUqziQs+p9030+
	C5osR0rKZ+pDjuwFWcsENcFzlrUp/2qtLxTKTeltuDM+b+2CxKsjUbhubEVKgdayaX8YMRrByuw
	9llxI/jl3QWH4tOCnvdhICFH1EjLzZZHfqBOGkRnWLE5wxXIUHLAcTgscgm44VEc74y2Aghwo8s
	51bovTQC/BSZRIFmU34CtHjzVeHVfyic29tDHKjVARpVGyndqVT6tXqMXd8GIbc3EJX9ndWkzeA
	3pUHqu1nfjKekncxO4lzzwyEzCZT9c0eviMZtvctlpbUtpDZbj6gOfNJD2vuXBS/rHt1K3oTMYD
	4QC5XPo5hRM13iwbKL/j4EGYK0SeEw0HBEGVrKw60zq7j4jztwI2dGLn1kaqEdkhb2WVQCEDp5A
	nUx6b7Yr/nnmXQDxKQ3j63/NWUKOJtgevoa+pyaX83dC4uRjmz3cANiw
X-Received: by 2002:a05:690e:47da:20b0:67c:1dca:80c with SMTP id 956f58d0204a3-67d8971741dmr3150254d50.45.1794703164085;
        Sat, 14 Nov 2026 16:39:24 -0800 (PST)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm189602d50.19.2026.11.14.16.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:39:23 -0800 (PST)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: adrian.hunter@intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH 1/4] perf python: Add kernel attribute to callchain_node
Date: Sun, 15 Nov 2026 00:39:13 +0000
Message-ID: <20261115003916.1873857-2-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115003916.1873857-1-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts that convert callchains to other formats often need to know
whether a frame is in the kernel. A callchain_node only has the DSO
name, so gecko.py guesses from names like "kallsyms", "/vmlinux" and
".ko", which misses kernel DSOs named anything else.

Add a "kernel" attribute that is true when the frame's DSO is a host or
guest kernel DSO.

Assisted-by: LLM
Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
---
 tools/perf/python/perf.pyi | 1 +
 tools/perf/util/python.c   | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 087da00728fd..5b68d70c5216 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -353,6 +353,7 @@ class callchain_node:
     symbol: str
     dso: str
     sym_offset: Optional[int]
+    kernel: bool
 
 class callchain:
     """Sequence of callchain frames."""
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 902157c472b3..3ba3ce0e651c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -994,11 +994,20 @@ static PyObject *pyrf_callchain_node__get_sym_offset(struct pyrf_callchain_node
 	return PyLong_FromUnsignedLongLong(addr - pnode->sym->start);
 }
 
+static PyObject *pyrf_callchain_node__get_kernel(struct pyrf_callchain_node *pnode,
+						 void *closure __maybe_unused)
+{
+	struct dso *dso = pnode->map ? map__dso(pnode->map) : NULL;
+
+	return PyBool_FromLong(dso && dso__kernel(dso) != DSO_SPACE__USER);
+}
+
 static PyGetSetDef pyrf_callchain_node__getset[] = {
 	{ .name = "ip",         .get = (getter)pyrf_callchain_node__get_ip, },
 	{ .name = "symbol",     .get = (getter)pyrf_callchain_node__get_symbol, },
 	{ .name = "dso",        .get = (getter)pyrf_callchain_node__get_dso, },
 	{ .name = "sym_offset", .get = (getter)pyrf_callchain_node__get_sym_offset, },
+	{ .name = "kernel",     .get = (getter)pyrf_callchain_node__get_kernel, },
 	{ .name = NULL, },
 };
 
-- 
2.56.0

