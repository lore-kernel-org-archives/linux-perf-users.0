Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FE41A54B;
	Wed,  5 Aug 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936680; cv=none; b=iyD8N/YqIoPSkBTjWOM1rTcxQCHo0PsYfbFuD3uO40N38+7oGa2aGbcv1PhzcTA5/iLudVBoRImfUt1+B9d4fWH2BsPuYzq32jiYMwk1yBJzU/TTial0khJDXaZGPPJt4rCKaHB7GJSuus5fXeooSklne9QwuWR2s97p6CepxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936680; c=relaxed/simple;
	bh=fRGmXGaHb5SpkLn0+AAs910q+lB7cz0Fp22es0fXd1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kza40UW8Nm0LGa0+RueK8RXuB6QkpfBI/5T2V9+o6fwK4QVt/VOWU/65tqAiWr7uGSY8xhRrbT4bO0xW3tN4JHm2IRW7VBnfVuOEe4Etk9PMGCkyBrDC0YmUPFG/azbBIu0aRq2Ge1vk270CLMVol1120OB5st+On9JhaztCjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MedekOzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MedekOzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B173B1F00A3A;
	Wed,  5 Aug 2026 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936679;
	bh=e1Q0ojvl+8bO5DnzYd6w7JYVX4ZMv2eI74LKEXp7g80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MedekOzGd3ThSSD4/8Ck+oDqVMjsa8EMT8Y7PyM9vy7ooTLGIuvBold0WDT0HlwKp
	 kQDnZIdLlAeMVT9yLEQNkWRNYD3EbhfaZQ4WJU7fFSTsI+2jRUwFYtE1zGIgEVBfSe
	 9n+nfvhFsLW20ErKTEbiS7lrBTZ7drRiYGTTm+pPfrX96nzCqNIDII4EU5okfD63ea
	 o3+qpeMQiPyUnZsL1AvCpeDWPRWgSLWFXNB4uu7arPP9dGAWYMCQvZEojc/9FIrhec
	 8enPA8D2Bf9tyrAT8Cyh0rsObTGsPWkCS5U9aF6rKOQW/pUvN1uWFduDuq2eDi14tC
	 HAxPwRdsPscsQ==
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
Date: Wed,  5 Aug 2026 10:30:00 -0300
Message-ID: <20260805133013.235016-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
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

