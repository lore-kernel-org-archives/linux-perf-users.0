Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAF3F3281;
	Wed,  5 Aug 2026 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965278; cv=none; b=RDuknX/beMIy2T3N23yz7m19icZVe7C6yxUJRquQbBL96jb97EGex0GqQUlAK7VaRa3zAJy9+3x8M6HOCQpOvYU+lu8YdBV4x3OOC/Dwenx/xbSPRheH34EwQ1uWui5MkoMoA9qWS8oCa1fThS+7g9FZb9RsnsSsR5iNDQ9zrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965278; c=relaxed/simple;
	bh=78JUD2JGGLuJVO4V85ddsO0NJQ+8ku1lGbYjrMLxD10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2krC3SLDZBgzWx8DW106+VSI+etG3k0T05pX9GbZ+bm05eUbLDUBmlo36Ra12AwSG+sRsiB9Jz4pRhEStcM2TgzyNLjvNxwy++wPJToqALqk+f0BbHgWRa8qtjodhLdhmfmYC0qtovxNX6UR3Mz/KTsiiaA+X4erCCiQOKCxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft5r15Cd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft5r15Cd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99481F000E9;
	Wed,  5 Aug 2026 21:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965276;
	bh=DwL11wD1aWkwCZotm9ZScj4gL12D2idG2VplIIApDcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ft5r15Cd/86z8DT8ScY7TEJ7ueU57pxJU+NsUc7RyH/tL8jvfyKFZBOsL6dHdP2m2
	 1EQbZnxGJ36vm7u1uZBUxF94s89SoPDe/Crr8RchIaD5urZIsKoti7IVkK0GvWzmEr
	 4gqGbhxZS3qF3ZP3Haqhu/DPUMDPCL1NgWzI4vm7hwcvt6/OKr21+chhh24qCNJmaW
	 U+EITEcpOexrQ4WM/zjo340QMzH7qpublMTP6kvh3tyO66nY1nHAKqz9rQO+b7gh+/
	 hgmp7c4nBSC121+qUp5epfYT9k8VoWNyKYPCrFpcPos/pOpzLBE9q2TnyGjvJZjEgH
	 YmtM7BJfOZXWw==
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
Subject: [PATCH 08/12] perf jitdump: Fix debug_data and unwinding_data leaks
Date: Wed,  5 Aug 2026 18:26:58 -0300
Message-ID: <20260805212704.267779-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805212704.267779-1-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_debug_info() overwrites jd->debug_data without freeing the
previous allocation.  If two consecutive JIT_CODE_DEBUG_INFO records
appear without an intervening LOAD record consuming the data, the first
allocation leaks.

The sibling jit_repipe_unwinding_info() already frees the old
jd->unwinding_data before reassignment — add the same pattern to
jit_repipe_debug_info() using zfree().

Also add cleanup of both buffers in jit_close() so they are freed when
the jitdump session ends, even if no LOAD record consumed them.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index f3d9a2b01053a92b..91aa1eea8229faac 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -118,6 +118,8 @@ jit_close(struct jit_buf_desc *jd)
 	funlockfile(jd->in);
 	fclose(jd->in);
 	jd->in = NULL;
+	zfree(&jd->debug_data);
+	zfree(&jd->unwinding_data);
 }
 
 static int
@@ -706,6 +708,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	memcpy(data, &jr->info.entries, sz);
 
+	zfree(&jd->debug_data);
 	jd->debug_data       = data;
 
 	/*
-- 
2.55.0

