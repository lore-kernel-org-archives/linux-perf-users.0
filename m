Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21182475CF;
	Thu,  6 Aug 2026 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019779; cv=none; b=OySmwgDMgcV5BiIzee020WbvkOP4221HQuWISnwxSnuqrAW28Ti6hFEV5kEJuAfO9QM6/SHaLjVPhoWywE0uIChm8Yw822gfWH0Bquc8aHIaEbZWRfXfQp32vXuNHGrMI6cqM7rsguEOtBorhbEVEeBKDOel0jZqtrOeHzLxHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019779; c=relaxed/simple;
	bh=p1S8g7m1+MhoK7RRb87ukE8btgQpT7Hp/ZdsQZAHicE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dc0T7pVpqx9QI1Tct9xR6EGWmwkggGc/uiR6p74jUmmhYjrM/Y6xBb3z/7HmYc4keZEo/lcAs9GZ7WI4kpvZpYB2wKayVvb+L2SFDfUqA0IjGPaJbWCrsClZnJ+4UvkuosSNw2e2FjUWvf4w5TnS7T6JBbeqPY440nDNBS0DSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwOOQlFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwOOQlFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA221F00A3A;
	Thu,  6 Aug 2026 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019778;
	bh=L+XgG3zRC2xuZyKC3GoSym/L/+7SSWd9pP/277f7PNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SwOOQlFiq6hUMvs0mSpVFMkI21Rzb4UWbDEFR+HWKgL4+hFaNZ4hV3lgUGxOzHmdn
	 WensEXjPOdlSsceK+KZrzAElQwF0eDfIfn7hD9ldCWzBeo8hU8ypSAi2uteFme/rog
	 rN7ivfsfi2hh6APGtY07xT+54qZFawJmZTpK2nqlP7de763/lwieDUAYNoisJxQ7LF
	 tKkABb1wee7JDy2bXvFv2AJAOm/PXz3TX91TURco6XB3iI/AtkkKIybJVU5X8xNAJA
	 zwJz7F3n4IivRnAiatvf1OU155x+nQRjIrWQdXE4pJkXrw5g5FMli4M6RrhjJji4hs
	 LRqCXad0YZYaw==
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
Subject: [PATCH 01/12] perf jitdump: Fix extended header read that always fails
Date: Thu,  6 Aug 2026 09:35:52 -0300
Message-ID: <20260806123604.271277-2-acme@kernel.org>
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

jit_open() sets bsz = bs before the fread() that uses bs - bsz as the
read size, making the expression always evaluate to zero.  fread() with
size 0 returns 0, which triggers the ret != 1 error path — so extended
jitdump headers (total_size > sizeof(header)) have been silently broken
since the original implementation.

Additionally, when 0 < bs <= bsz the if (bs > bsz) block is skipped
entirely, leaving extended header bytes unread in the stream.  Subsequent
jit_get_next_entry() calls then parse those leftover bytes as a
jr_prefix, corrupting the record stream.

Fix by separating the buffer growth from the read: realloc only when
bs > bsz, then unconditionally fread bs bytes when bs > 0.

Fixes: 9b07e27f88b9cd78 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 83005b30b9bf3fd7..4b7c7ba7cd95ddbb 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -224,10 +224,12 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 		n = realloc(buf, bs);
 		if (!n)
 			goto error;
-		bsz = bs;
 		buf = n;
-		/* read extra we do not know about */
-		ret = fread(buf, bs - bsz, 1, jd->in);
+		bsz = bs;
+	}
+	if (bs > 0) {
+		/* consume extended header bytes from the stream */
+		ret = fread(buf, bs, 1, jd->in);
 		if (ret != 1)
 			goto error;
 	}
-- 
2.55.0

