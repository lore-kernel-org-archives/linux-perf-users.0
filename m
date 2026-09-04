Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC523A1E92;
	Fri,  4 Sep 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532874; cv=none; b=kWbVYNKeRNTljsuYgbdag02goxZ5o/3oUcxM0UQPsBxXHH1HZNhuao0QyE87NmHm7ktgFA0wl3x5cqbxnCkjT6Ma/YyB44KiXgPnbhpIvihG9vnJfX+GZN5CvJ+w4JDb1bb3Lu8IT+k2Tyl3GbgztYJe5tnAbTQ2ac1CYUxGr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532874; c=relaxed/simple;
	bh=WU7m4HlKW3kdHtsYh/Q0n1wYe988EY4t+zrtpzwPc+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLeDRmUJ30hLd78XTOfYhFcx7BdViS6ZBN834qs6BOFKR5Dj4QQ8rzPQV7p2PIkFdOFS8aF0ETIaWghrSogo3N8qMDIVQMzWV6oo1uDHCpbSVSByp4o3M4QQTkQkpxC0WcQMRd4KNKHS93MocizikTj4OFtAQSCDwGOTMbXV4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diHLz92k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diHLz92k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1469B1F00A3E;
	Fri,  4 Sep 2026 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532872;
	bh=EHKFKHJ3yJDXjG8mIdYl0n+9u/+CfaZfUFzjPOjHdgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=diHLz92kXqz+2DaoevwFsmDvDc772J9Ml0bteABvvowMRdATaPKg3+PmWJEGDJyvG
	 fjjkRqdL5uwADIoAQz+o2VokLNf2C5Vw0lQxO75z6+Z6ucFJNB22jEtkqmfEF4SR+C
	 Ss7fArftF9qnaenPjbQc1DXh6cJ1jJHrngsF5dSx7ncIQBnyguDRJRvK6B1CSV0q83
	 OvwTvq3QNqAZE/qaTueJZRONefs7mc5bWdgPYicg03a2WRJsj0fQhLPLLXq7aBiJ2y
	 yvlAb7AiaIuXZiBtUdB3upTNIVsO9Ru3VzcYqsx0qfTVpwoKjulbWy2EmyIDZXmCKY
	 zUFIo4MrWvIPw==
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
Date: Fri,  4 Sep 2026 11:40:53 -0300
Message-ID: <20260904144058.3341-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904144058.3341-1-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
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

