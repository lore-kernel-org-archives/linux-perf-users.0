Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383654;
	b=cr9N+rCYpojMpeoVs6nZhSLiWMHMuBiIDgfqNjEERInyyxhYau1YOQD1vd9+T3ibAIux
	 M6WCzbHO1tM6TEusd/V9/4UuvliD7/Uvn7HVdvZtohDXcTxlP5HtoDp+QuDBrgMQk/ki4
	 Yz+GKKZJhgHKqpXo3BTRL5vTcXMPe+7ZM1z0oCR/W4GH6cLdwPqBoYX8rSe0UTdzSBdQv
	 70YDuwl//oknHJ9ULR5y2KiwX5OtP70fR0+0bl8F1VJXXvS7Ig+9dSMT5m+yQ3SDJpoas
	 VLcZdvm73w7JfMTEnjHHy6uccZD7ndbL1c7PbOAWUug34r3/k9M2hHWzh1BV8U0hhGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BuOQpxxnJrgdxoRaqUkxeQM/mke/RW5jA38iKyRzh9g=;
	b=wEZbLZikF6kbk1zezVB06Kyin75jry65blgXIDlUqNqim6lHbekxI7t2R0sVVH3RQSDY
	 r2NnUpxRtas/gS/eDscHQQGr3qvTpUYc7R1g009XgkgcyRetQIQdypgkKNuGufZMvAY6N
	 PgUgQYjAsEcPJiLXEKKtdJonMvdpGlBV1oJEbO186qnNc/tJBisTR0booX1mLlLdECxSo
	 lJwBePqiv7G00oDw1m3m3sjH701Lsx9N+BKoPxEdQetaIfCWYKYZQ4EvzyvybvdoZ3cYv
	 fUqEqV1cXlfj6Ntft0DqZO0aJ0Hkiv7dD1t1u3DW59Le9D1nLqaaIOfTcFTgVGv31zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RuHWYDs/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248C606A327;
	Sun, 22 Nov 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuHWYDs/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4D51F000C4;
	Sun, 22 Nov 2026 21:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383654;
	bh=BuOQpxxnJrgdxoRaqUkxeQM/mke/RW5jA38iKyRzh9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RuHWYDs/8fHTRnIMWCn+N53iW9jCoMp58ZyCPyiYBL7i68m+33pItCcef+ESUMOc9
	 ixeiOKvFzTOWBgAtfRhP23xDW5xfb7JDwOASEikuX10jLDovUSeQ2st4lm0W7Vnvt3
	 tQqjKjqNEnLcgxBhko/lo2Xg9O3rEGsBBLjLcYYbT8IHPphaWQY7XvonNKPmJyfFyL
	 rT0D3pN1z3bwwRN4c9zmvqJl1vi681sS2VyQB5EaBzWn92v9iMAhqD0BJfNTaTRmgU
	 OSfHTfddEzGBiQvvn+RslwmLQvz/Cij7pdXXujR7NXMUIqZWHWHgKeyqa0IJhK6Uh8
	 C/BIhgZfZD7GQ==
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
Subject: [PATCH v11 06/19] perf annotate-x86: Parse movabs like a mov
Date: Sun, 22 Nov 2026 18:40:12 -0300
Message-ID: <20261122214025.16769-7-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
2.56.1

