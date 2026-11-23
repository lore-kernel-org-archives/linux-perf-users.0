Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471252;
	b=3L6rdDWtBnmVJBeIsebeQAegokGIIQGbXdNpxOCkvkVtrxbhrrojQQxFNzYhck8eTnMu
	 ziyAiz8HuI9F55beIm/8f0y0merhFMFdNEz2/SIqhRro229o7tP0nFVtNiiGlxuNZqi1i
	 3pxCi/H2gnuO64PrMEltkiMCm9QnClq6xnpP8IBXO7/LIAcxUaG3QwGo6Y8Wf59YZD9Xf
	 VTTebZWPfksha/xeX5aABWA81nWHitmp37Umf3AVyMHXuDvjv+RZhlSzC11nMXRE88rYY
	 Ze0u8DOeWoT2QprZM4Z62a4O8bP03ucnu+e3xSSEVuLrtHNN4nsbNLQ3WDpc8Gg+L2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BAilv4VoXsQ9+WVNQ6tURkpXxWXhgKWKJX5ZMQISyiE=;
	b=WTRTgBpZPwoA7atW4rCzEVbNZyKqpFMJRgKnM/UkwMSg5NJreWCRXbXnigq5KQ5eFfN+
	 h44jNJEDV3Z2oimsDmytzRD2GCu1CqifVcMshF2bflKMa9tkpOZKYg/vl8Q5I4oPkcrWq
	 AGPC2Ob1aZ/8CKZl4WyM7hZJD49n0pJFMVudix9X/YfmoEyR+w/sNSygqQq/EhRfj88DP
	 kgG8Df3mJ+CVq6AfwggxPP2nSCyTNodpmcoXjR1TiDD6iN/DjjYRzjkkx3V2d2DAMnkyr
	 yccEhev1L6+fi4FXS90F+Dei3FG6qIjIdq/hmgz8M999HOwuHBdqhAezvpk/cZIZ4Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBb8nUCy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A797606A31E;
	Mon, 23 Nov 2026 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBb8nUCy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6592C1F000C0;
	Mon, 23 Nov 2026 22:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471252;
	bh=BAilv4VoXsQ9+WVNQ6tURkpXxWXhgKWKJX5ZMQISyiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kBb8nUCyzRVdbwB8HX5SdoiLQnFJEUlWuCz8zYwpDfgevQrmODokwFmf8UcAegqHX
	 2MuDv+WEpsAzVQ2+Mw343agvPssXdih/jC59D0LDVVvnvH2nC3kLSdfcN4Oai2eUB9
	 /PT0YwbIz0Xe0tGEVyTjYPnzqMB5+1Fl92KucO9/JDyyb8VA4vKNXBxIKQnrGK8tVr
	 524xAejs75q5kc5ztslNjp9CLPR3tV/Dlo5QsNUkn6Jjn9DLuRF/K8Dt6hoR7bqyUm
	 EfRrlWNtFtNyVT+R2IOsIRbhiYn+Q5PPGXzAHzKwx8Zq1Cobm6h/uIaoptVJFJC+x5
	 9q0YMBPPQSKSw==
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
Subject: [PATCH v12 06/19] perf annotate-x86: Parse movabs like a mov
Date: Mon, 23 Nov 2026 19:00:11 -0300
Message-ID: <20261123220024.14891-7-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

Add it as a mov; with the previous patch recording the immediate in 64
bits, both objdump spellings of the KASAN shadow offset track the same
constant.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 94c45806029ee670..0c74266cd4b99925 100644
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

