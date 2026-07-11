Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E797260F;
	Sat, 11 Jul 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783729384; cv=none; b=AmpDnomPDdBnLUD24nAMCDGtDhqpLtiSuGtX854qWcGbsXsfE4+fFgDRaLKnTu1TXrlBu9onJ7+v28WQdAW8Ax+cXMeXsnAPibqY5F/lQCXZFrT/K4EkAFliLScEpgOny1ZaJPRLmFBf3+y5STkk9Iifi07SuMJj5878pMmBm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783729384; c=relaxed/simple;
	bh=OynS5KP+TuEbPjvJJGJilCR7CR00tC7rY5wY/7zXumU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVY6gPH43k34y3Nlgl0u7ElCmKfnPmqGMHhaiBeUBe5iLdqu8oBhCeUTIaMaAnvktbS0xcM27BB29r998ORs3LvbFU3+RqaeIiQBb7Bw01B7g/LNPcHy/Bf70VsbPjCAWwgh84RGuGx2PB4PMsjz+cl+f0GyRkAQ1SA4J189MmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADsFCPMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADsFCPMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084061F00A3A;
	Sat, 11 Jul 2026 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783729383;
	bh=Sfs/cPBhe3QHac9glPIBd9heFrlOp34K0spoYg0gEMc=;
	h=From:To:Cc:Subject:Date;
	b=ADsFCPMZq/hNN/7B8A3rhsoyk1TM7xpyj6rwTCMJrSxKwqU9pq5fvZ5wuxmMXDzeS
	 9puW/cZCG96fd94beEPawXUrMbWV/6/uXWVU2VxOvKpahlhTYbrKlnO/r9ScWO+SUD
	 694pHcSCFgJwJpG2D1fCX6TFUiTrUnc38b1VMnksYoIxghzY89P4+g7xKKo8T5+b72
	 lp7cbv4Jovx1cMYfMoYrzs27Ewh6w6VOS/PsFoCqFjo1AO0nMB5w6iaXuhDPEY+VNn
	 ncrmEyOVqTHgd7kycoVztGd1bg+SJK3qi37HJTyrngMK5GnK56v5TkN8784f4wR0N2
	 QwZaGANnWh+Ww==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sashiko Review <sashiko-bot@kernel.org>
Subject: [PATCH v1] lib/api/fd: Fix potential double-free from fdarray__grow()
Date: Fri, 10 Jul 2026 17:22:59 -0700
Message-ID: <20260711002259.1958597-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the realloc for fda->entries succeeds but the realloc for fda->priv
fails, the error path frees the newly allocated entries.

However, fda->entries is neither updated to point to the new entries block
nor cleared to NULL. If realloc moved the allocation to a new block, the
old fda->entries pointer is now freed memory.

When fdarray__exit() is later called to clean up, it executes
free(fda->entries), which would trigger a double-free on that old pointer.

Reported-by: Sashiko Review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260710200150.11FE71F00A3A@smtp.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/api/fd/array.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index ffe8272af59b2da0..23b476a35de477fe 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -31,7 +31,8 @@ int fdarray__grow(struct fdarray *fda, int nr)
 
 	priv = realloc(fda->priv, psize);
 	if (priv == NULL) {
-		free(entries);
+		/* this will be freed by fdarray__exit() */
+		fda->entries = entries;
 		return -ENOMEM;
 	}
 
@@ -50,7 +51,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow)
 
 	if (fda != NULL) {
 		if (fdarray__grow(fda, nr_alloc)) {
-			free(fda);
+			fdarray__delete(fda);
 			fda = NULL;
 		} else {
 			fda->nr_autogrow = nr_autogrow;
-- 
2.55.0.795.g602f6c329a-goog

