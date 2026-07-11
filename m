Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A57262E;
	Sat, 11 Jul 2026 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783729958; cv=none; b=K8v0R6eIjKvOq/HxElIiC/lhw3ksRTpNPhcTemHlpKkNza9SoX6lp2fnw4YzkYQKYMvbD+YufCHbW8JpQdqm0qCin3hlhn8nTk1L3aiUdFO1nus7DkV53nVDY8/jxnxoslIhhYx0aMveOsHA2zJe5ONeDK0NaRGxuFZ8Jp+YGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783729958; c=relaxed/simple;
	bh=Ly68Tfd4D5vR00qocuFl3myZHSA/r66yrnYN/zwJRC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFGv5YvReyxvRNpgjt70kEIfKEr/gyyAju/amgSrqx87U/SWmLk8lWtpQwnTy2/vhhPV5mBcWAOAvVnFS+uRDIlN+F8v7FO09nOuM+BhujsR1awDllqRDsGIrVKrJp4hQjx2ihXSL+TJ3PMWBcSvOozboDY1F7ik+S66sdu7IRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EryyZCc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EryyZCc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4AB1F000E9;
	Sat, 11 Jul 2026 00:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783729957;
	bh=bwlPmL772MXnPG81IbEeOXuXQxPHrxdMoZqTsvv1hOw=;
	h=From:To:Cc:Subject:Date;
	b=EryyZCc9tFtCADKkjKIr1g942KbtFY+YUYXZVKT0rRUmZhvoJOAnQ03XwwRBIw+oH
	 ztEElnRbLlZej4iT41v8XadGgMLImy8Ynj6vdYiT4tTnsDLpHOJAMAwBpnWh0RcPEc
	 aobD+djU/rHGOUrJSZCA2nI1PxVs8NDLZGGXYE8yEy+GS3TNVzHX1EfdAgdJHW/NQA
	 dgWjlBR9foOs6XOPSq9OKxumTe9dmmvZH+FQdXwXIzsab9X8Vev4x1QjLPkwAoNzbo
	 Zp2uNViSI20RHxmvwwWMD6CpCt7QvJpf/wH1I0HY7N+Qr+skFVB2engzvWAlQjod0Y
	 cCZX/VreWbIsw==
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
Subject: [PATCH v2] tools/lib/api: Fix potential double-free from fdarray__grow()
Date: Fri, 10 Jul 2026 17:32:35 -0700
Message-ID: <20260711003235.1963043-1-namhyung@kernel.org>
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
v2 changes)
 * update the patch subject

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

