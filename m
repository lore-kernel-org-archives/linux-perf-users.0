Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E94ADD8A;
	Thu,  3 Sep 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441792; cv=none; b=jlSBUXtLG2JA9kl8nyygTv/589vP58kXd6gMClxf0SzMJiSPOjsiADJxRfyfiRHou+CEdFsVGZXtgSM/HpxKmx/isqka6SnjIon4P9dd8XmOY8/EaB9X5dGG5ePrErOZ880yGnyEPtV0ptpg4s2WQDQ7IwEdKH/nHygvNotrGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441792; c=relaxed/simple;
	bh=WU7m4HlKW3kdHtsYh/Q0n1wYe988EY4t+zrtpzwPc+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFO3TyzVQ5V59FYuqkDVVc6G3iPEf3QmRPqsTKzUHex5sgdBLYsbnAkauFbY9hBm03U11G/5XXSSXa8WN776Q2dUTyzompEb4936Hd3Sk6Qnqm8+TzvPJiaKk8ALnRr2XLs1mnW7DhXjgS35HfDI8+CTB+Q4godDfrhj2pIGInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rye1m5FQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rye1m5FQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4AE1F00A3E;
	Thu,  3 Sep 2026 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441780;
	bh=EHKFKHJ3yJDXjG8mIdYl0n+9u/+CfaZfUFzjPOjHdgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rye1m5FQZCLFWGFlFrvpqOnI5JnRuZmtqUcXSbYKkQbcAhUWWQvo18uVH3q9Gwcp8
	 JYc1K25ZDqpIgE30u2bD25rJJJo0nyFe1xXVPORx3p2ycJkxD9UDTh0REJeZn/Vn9u
	 tUCVB6kIPgbalfsL2epFaIkMX211AtHUdcr6tLIbmrgy9XfmlUyPZdVkIKeDiVeU3e
	 g3eB/eHMUyvnYCKozebCVlhr5+kH4ZMN35VWwK8EZNIK1LXUqHAOJFt6B+E36a/t6q
	 UtBYSUHmGAMaLBe0AAsfGYVvjGH40a1wFX3r6peYrBOm2o6xkU5sKu3YAaluFc88LT
	 vbes8ReXZfIdg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/5] perf jitdump: Byte-swap debug entries via unaligned-safe accessors
Date: Thu,  3 Sep 2026 10:22:47 -0300
Message-ID: <20260903132251.237029-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903132251.237029-1-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

debug_entry records are packed with a variable-length name[] field, so
entries after the first may start at addresses that are not naturally
aligned for their u64 addr and int lineno/discrim fields.  On strict
alignment architectures the byte-swap loop in jit_get_next_entry()
performed misaligned 64-bit loads and stores through struct member
access, which is undefined behavior.

Use get_unaligned()/put_unaligned() for the byte-swap of each field.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index d25a9fe9b020ce87..e0d5cc9a828189a2 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -14,6 +14,8 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <linux/stringify.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
 
 #include "event.h"
 #include "debug.h"
@@ -343,9 +345,14 @@ jit_get_next_entry(struct jit_buf_desc *jd)
 				/* name must be NUL-terminated within the record */
 				if (!memchr(ent->name, '\0', (char *)end - ent->name))
 					break;
-				ent->addr    = bswap_64(ent->addr);
-				ent->lineno  = bswap_32(ent->lineno);
-				ent->discrim = bswap_32(ent->discrim);
+				/*
+				 * debug entries are packed with a variable-length
+				 * name[], so entries after the first may be
+				 * unaligned: byte-swap via unaligned-safe accessors.
+				 */
+				put_unaligned(bswap_64(get_unaligned(&ent->addr)), &ent->addr);
+				put_unaligned(bswap_32(get_unaligned(&ent->lineno)), &ent->lineno);
+				put_unaligned(bswap_32(get_unaligned(&ent->discrim)), &ent->discrim);
 				ent = debug_entry_next(ent);
 			}
 			/* clamp so downstream consumers don't overrun */
-- 
2.55.0

