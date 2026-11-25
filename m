Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634619;
	b=EIY03b9nbs0yYmrW/gcftTLHPrc4hjAr057LP7pCoaBfemV7dI3qq+tY/83AUoll12YR
	 Tp2iKarK+c1gxvNEt1skB20bmKJzNcJ52T7ALz26xs2uK021AdizdZsPfh3tEw8+aJPm7
	 akCzjuOa/GPPImoqEXt75KciG88LCJjwIuA5FpKLQhuBEAAJZvEGzLwgM6rYEcfs0B4Z8
	 cXQLvnKFpv527AYSJrTqFcgf52XzK+o2hJoCQPVCegcmozWwor3RXi2CQJNa+r1+J4vh6
	 5rCA+5ynDAZA4osFzeu1BvCaRW/Kh8k2rRc/COS2lTKKhC7zFWlUhkrv1iaMGZDZ07w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gg4At9jhdTZPrtPx1p+oUEu8XE+d0Qnh1B9TU1rQd94=;
	b=Q4TFIhaRPQgiwvxMZRVgGEhK84HXtVX/DHtbZzmHAACdXiaW16Ds/OJdyCIDXOlXfRwd
	 N5teX+/4EUzLMSE1sp5dp4r50drWBcRbLq1b/+rDvTO8oxXen+OpXPlNEx+6E3ITUFGOB
	 DkcAvJHjBYV7kw5xtQQ8rlyjHRgQSLd91bEbBVGoV0hTECiG0x8dvqa6xF87pxoTKa7tX
	 pV/bivO9mq7QE40ammfIJMDJJgrYdEeLA+SgMjeyV5WY1S/S7+f50YpdMIC3gSyMzGmo6
	 66vukfYbAe3pv/t+5TQG3TiB0vgyr5qEXfXqCQKG7q0+8Xe7VpW0rprhTkrEssLEUeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbdyV5lw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D264606A32A;
	Wed, 25 Nov 2026 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbdyV5lw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082591F000C0;
	Wed, 25 Nov 2026 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634618;
	bh=Gg4At9jhdTZPrtPx1p+oUEu8XE+d0Qnh1B9TU1rQd94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WbdyV5lwnftUVqHfoAXFSOFzGM1XgOFg/pwk50qOhZs6MUbV7Jc/Sb3sxwwwS6DIb
	 TfHJul8EW/zg8Iagg+U09h6p4jpLeaVnQ6j2bZNTTvJdaahmE/eKGHzCeWlayLJVcW
	 OG4ep95576Ww5mOEBi2qT4qCeAtDbRQc2jL3n2FVZA3TuLdaV+hHO/iSu6MdjZFs0N
	 bTTcYgd3XpT9KOBQaxQljmVqS/jbg+Z4MLWSYzItElSyaOOCxiLE7Uc1YwGyfB3A3T
	 pVsV0uwetMCU9qesh8MPL9Heiks8noJxZS9BHznRHIK281vgSgYSooEQ/pISu4OpMF
	 14ATgfPoiMDRQ==
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
Subject: [PATCH v13 06/19] perf annotate-x86: Parse movabs like a mov
Date: Wed, 25 Nov 2026 16:22:59 -0300
Message-ID: <20261125192312.34134-7-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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
index 1ec32ecdebba5e1f..e6162d9d6c7c25a3 100644
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

