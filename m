Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67D246770;
	Thu,  6 Aug 2026 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019802; cv=none; b=EQIqorHO2q/5pORoDA0hUnkp7hkXZLfJJRvrTxvU15KBxP3ZOuOikVJlgEl/ww0+7mKhGauJe2ONn+B3dKuQ8a5A6bN1tE+3BJxtVFnabk8fqM/XEHF4KLxxi+SonG2cmNChVX8gbCzCKWhlTlM5Rt2D5ngnvUm/ojC98uc3ENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019802; c=relaxed/simple;
	bh=F5t1pmx1MJGa+4Wacd5mAjTnkxXeeTJwGRMqw0Y/6fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0aYLLmFbbwssbl3GFCVshZmOUs0738bsh4glKc+pxEMcwK0FUSUBr8Ujn+l9AsmUu7SN6DRM4mZWtn63j4FkdRYjnDZGga7ahfQDTAH91Ydxy4z9SPsFNWCjI/LK0/6l2zFoDogzIsJBm/Avy4/cv9f2uHxUjhHBQWJiP1RwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/jSOIob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/jSOIob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05191F00A3D;
	Thu,  6 Aug 2026 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019799;
	bh=E+1OJPyfkUfOKy6ZjfP6envJXPAjjgNC0CBQ2p7QvNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F/jSOIobcv6tCaQ+wA0rfhA/SwLNlTLLaOuy5KxCau9+J7Oyml40ND3nFepn7Hao0
	 zedv5ZCcyKJHnXgy/bzrC3JAqsHDxHUfWEQupdT733F6SKSJwB29OMlKn3X18YuB0S
	 aTmnK9uoAg79VJctNof2qx38pd6JkAz6ZFMyJlFNH9wH9EtIkWbj1aA5PDekAu1+US
	 9qjn1JeNedIRX7av3Zx2wvBbF+RT1k3ZCgA/ZHhepvJKfc/0cYcONDR6ldgx+B1SVh
	 Googs/PRff1PQGKa38MJf9MqvLw1lZsWcJ1CW53DuIcpPVTS34I9eVZxY9OrEwgNU4
	 cvW7ClC83FXiw==
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
Subject: [PATCH 05/12] perf jitdump: Bounds-check debug entry byte-swap loop
Date: Thu,  6 Aug 2026 09:35:56 -0300
Message-ID: <20260806123604.271277-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The byte-swap loop for JIT_CODE_DEBUG_INFO uses array indexing
(jr->info.entries[n]) to iterate debug entries.  struct debug_entry has
a flexible array member name[], so each entry has a different size.
Array indexing computes offsets assuming fixed-size elements, landing
inside variable-length name strings after the first entry and
byte-swapping garbage.

Additionally, nr_entry is read from untrusted jitdump input without
validation against total_size, so a crafted value causes OOB reads.

Replace the array indexing with debug_entry_next() pointer arithmetic
(which correctly accounts for the variable-length name) and
bounds-check each entry against the record's total_size before
byte-swapping.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index f79e9420c6bd7c51..7efbaa07f1ba73f9 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -320,14 +320,32 @@ jit_get_next_entry(struct jit_buf_desc *jd)
 	switch(id) {
 	case JIT_CODE_DEBUG_INFO:
 		if (jd->needs_bswap) {
+			void *end = (void *)jr + jr->prefix.total_size;
+			struct debug_entry *ent;
 			uint64_t n;
+
 			jr->info.code_addr = bswap_64(jr->info.code_addr);
 			jr->info.nr_entry  = bswap_64(jr->info.nr_entry);
-			for (n = 0 ; n < jr->info.nr_entry; n++) {
-				jr->info.entries[n].addr    = bswap_64(jr->info.entries[n].addr);
-				jr->info.entries[n].lineno  = bswap_32(jr->info.entries[n].lineno);
-				jr->info.entries[n].discrim = bswap_32(jr->info.entries[n].discrim);
+
+			/*
+			 * debug_entry has a variable-length name[], so array
+			 * indexing would compute wrong offsets — use
+			 * debug_entry_next() and bounds-check each entry.
+			 */
+			ent = &jr->info.entries[0];
+			for (n = 0; n < jr->info.nr_entry; n++) {
+				if ((void *)ent + sizeof(*ent) > end)
+					break;
+				/* name must be NUL-terminated within the record */
+				if (!memchr(ent->name, '\0', (char *)end - ent->name))
+					break;
+				ent->addr    = bswap_64(ent->addr);
+				ent->lineno  = bswap_32(ent->lineno);
+				ent->discrim = bswap_32(ent->discrim);
+				ent = debug_entry_next(ent);
 			}
+			/* clamp so downstream consumers don't overrun */
+			jr->info.nr_entry = n;
 		}
 		break;
 	case JIT_CODE_UNWINDING_INFO:
-- 
2.55.0

