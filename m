Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231278;
	b=KPUNM7+BEvvYLSXq+wbrq5OcjgCEvCQuzwfdj/mAcK45AAKI0Mwmod7y/okgSL/sBNV5
	 mfMBzPYdvvOSIHB7Gw6uzlxg5dDVwPmCNgJb6pfGZBeC3ZT9xvQUCukbVAKLBS/js1VeS
	 QQQWRgt6o3m/MFvdJq8CTqz2mFZZ9v7oBW3yLHpKMt9JJLUFUPB1VsHVica/ZakAmqe7y
	 DzVWMX+01FBPlv9umEPmqI7bBA2YzWGnBMGpk6eVceSY8wEnMKQJTh13+fF7r+ISnjGiQ
	 jrSDAh+tt0kbe+N3mFe4AA8Tbgo8fi2U5zweqHYBKeBdOogXfXWW7edy4XcBciy9KEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gmlXJ2gj2oRHcrb86o27HkxiK/PCmvR7X2wnRkuJdE0=;
	b=JbYHBhJUbBAQvsghWpV7pnoKmVakHNBobaaeuXBrNCAj0gGxoH9mG30HMcib68+vN0sL
	 7Io9aAclu+97r39LExxan/KiYW/zYgBQv6I0LkXobBZCSISLZd+Xh2sjQM2h8p9vy8Gca
	 Oq/rdCLR5GcMRrXsutlMt6Jm1BrBw1N7XalkHjKM0Qad0ks/g/B9x1L3svaN/Tm3PtBM/
	 0KmPGHqiPw5dDsW1LkqlZRIuimnl0Z7QR/+KRnm0fkieC4A2Z912iagHV7/3U1QpfsXDk
	 Q4hApB4fveX5kqzPhGdWcz8sujKtHVhil6meLYGVcRB1JgJXUq2/clJoWd1JLPhPcqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Iv4yup/0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CE60A2613;
	Sat, 21 Nov 2026 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iv4yup/0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED64C1F000D1;
	Sat, 21 Nov 2026 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231277;
	bh=gmlXJ2gj2oRHcrb86o27HkxiK/PCmvR7X2wnRkuJdE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iv4yup/0u14OheXqjzIBQ+wGylpPtPmfnhYzOkJvnWdfyOGvDTmU5D7+a0fuxpWiH
	 fTxMZQC9+C5P0p0UXZOrDz5tZQLVDHGL9XrbzquwAc656QCM01/SwHhXjOXepD9nVe
	 4wvyKbewX/0sJvndEUSw1UrykW7QjSrxSh6UYw4YHUi4rLFq/SvtPTQejn5PuLeVGx
	 VVH8Ms550bW4JZP6v7pG7Cy/znv7O788RAmcyB/kkaxlKypfFH5AeQQgB2J8dje8hn
	 MMurrydRHe4w8KGfuvclOVlJa4JmKBpXI+20P+Uu0xnmk/3Errg+m3aXiZNfVt5s4j
	 ePnezJYp9jk2A==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v10 05/16] perf annotate-x86: Parse movabs like a mov
Date: Sat, 21 Nov 2026 00:20:41 -0300
Message-ID: <20261121032052.1392234-6-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

x86__instructions[] has no movabs: ins__find() strips the size suffix
of "movabsq" and still finds nothing, so mov__parse() never runs and
the source and target operands of the instruction are not split.  The
data type tracking then sees nothing, where the same instruction as a
plain mov sets the destination register.

The clang allmodconfig build has plenty, 282558 in vmlinux, all with an
immediate, the KASAN shadow offset:

  ffffffff81271e2b:	movabsq	$-0x2000040000000000, %r15

No movabs with a memory operand shows up in vmlinux or in any object of
that build.

Add it as a mov.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 19663b780d19e2c4..3f6cf3bfb63dd300 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -85,6 +85,7 @@ static const struct ins x86__instructions[] = {
 	{ .name = "lea",	.ops = &mov_ops,  },
 	{ .name = "lock",	.ops = &lock_ops, },
 	{ .name = "mov",	.ops = &mov_ops,  },
+	{ .name = "movabs",	.ops = &mov_ops,  },
 	{ .name = "movapd",	.ops = &mov_ops,  },
 	{ .name = "movaps",	.ops = &mov_ops,  },
 	{ .name = "movdqa",	.ops = &mov_ops,  },
-- 
2.56.0

