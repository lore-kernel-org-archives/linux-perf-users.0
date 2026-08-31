Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCE332629;
	Mon, 31 Aug 2026 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181889; cv=none; b=oxsKvGKOdwT3bwblM/CuXgfHcLhFb0C0wV3MCE7HlIcOYMEdRq9Tllm9TSBIF/8tyviuQy2Jk59x4TNMmexwNui0qeClxnPuW/ZPSzFkgQ9ddbnEhARk3hEsC3XywdKrOsziG8tVFEJioA8YrkMpHuhAr8zhjCUBpzPfUhWOGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181889; c=relaxed/simple;
	bh=xfFObntrl3MqzhkA//sxs5FzBMlKzetmWbUp3feYzu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVyxmLBCZhkLovbQkoDlqeMgFFjpkWnNItqBkYAStc6kW/5Nx6X3VPv+GOQ6wMRfs0MQc0xRdn2/ruufGZi7de+LghlFopnAZ0v8sB21Wfsf79DwIbvvATBH2MzZR1uU2m/ndNM96ERyoP2B0eQ9Io81v6viafhFK9Ntjtr8ZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG/WNBLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG/WNBLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8351F00A3D;
	Mon, 31 Aug 2026 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181888;
	bh=HDLIWnY3FmW/7weGAhAHGuE8Z/kXZbN9jNMUaKnDRGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SG/WNBLfiyRJSI1hIqjQwSPs7mvh3J6YVfN0/xTTwC9RyuExGAjkitTgzr1xDJB1p
	 pS2HI3tUqlkW6m1S5THq4hS0QJ3FL/Aj/BMoskjMe0Zr2XbAtqMYKht1FEko9zFFao
	 4TMqb/fdeHH4Lqdf75SJDelSzI93a3YiVLprUkkYsrk6D9KBwricjCwY6En+5C35CG
	 C2VJsu8JJFmkoRtxbzhUjW/bvTQyGZ3Vqki1erAOGw09KwNhsPB9UP9y6dCO/9hkwU
	 8QqrWAq1DQL/yoDBoGHFXhNwjckUCTfcJN5bjx2nlfG2olsTYB1QCVwFZtd44CBOq7
	 9J4aWizR9/B/A==
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
Date: Mon, 31 Aug 2026 10:10:57 -0300
Message-ID: <20260831131110.4681-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
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

