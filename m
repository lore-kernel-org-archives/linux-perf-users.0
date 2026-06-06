Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A938A715;
	Sat,  6 Jun 2026 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776390; cv=none; b=WHlKu7Wi0cebgr3UDqZRX2WNgiYLLy9/Vf3elDUhsX9hmca7QgjolPFGPZjCcRJaUemKgVqDy0RH7tpqbtMEkdGNTnOpWX9zEprLttsb99FVyccUxtU/Nz+iwtFH/J8SoOq2EB6nw6L0YpaLmcFnx2dBikdZ7bNWzzTfvhgL97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776390; c=relaxed/simple;
	bh=cygiRNJeWqRLT+jF20O19SCQdbQVytNO4NvwaK+vi0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWCrc5nZLwsn6fDO+xCVI5Bi+GGY62P21I5qurYRb+Y08YsQ5LpB9vSVexRFdbUwx4R+xZbYXAijHuDPr4ygyP5lPnvLkQEME4op7x3dDTEQNZ5H7GI/Ima38I4GLVvwDyurSDcRSdDrQWyuRoUqNyusucufFwH9sM9Flu3/WUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzPxkUyj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzPxkUyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBF91F00898;
	Sat,  6 Jun 2026 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776388;
	bh=KOL3QUGILJlAiqmTRGM1oKLgGF3YQH/5gbajDmTJRTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzPxkUyjykMGoz/HKhpJ4Us6xd9gXVURrrIhWnr1TXL38zc18MztQRSpxlXD0PA26
	 hUtpNIjNOOvQWSjaJrZ49/mJQecyTCXO2J9UgUwueD9gGFxwARZ2Q5bhFw/X0k8Yrk
	 Q7WFllu4dJQUjV7X790AWUyd5N1FI2uTKxweFu5/yzcYFYCIx1qaogHhvUVgiO721z
	 7TLoZNLPIEWOxqg+2wY6oVbnsGcXvRocEv37g9JoGmEpky6QWttJe8AoSzp0OetVzC
	 Rlc4TBvXKq61w/B58PoGVLXdMbnHVxaTFHoQfoUhW3jGbYxSb0keYN4CtlnUo+oyF2
	 Spdt0XTehwjMg==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 3/7] perf c2c: Fix use-after-free in he__get_c2c_hists() error path
Date: Sat,  6 Jun 2026 17:05:55 -0300
Message-ID: <20260606200601.1861227-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606200601.1861227-1-acme@kernel.org>
References: <20260606200601.1861227-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

he__get_c2c_hists() assigns c2c_he->hists before calling
c2c_hists__init().  If init fails, the error path calls free(hists)
but leaves c2c_he->hists pointing to freed memory.  On teardown,
c2c_he_free() finds the non-NULL pointer and calls
hists__delete_entries() on it, causing a use-after-free.

Set c2c_he->hists to NULL before freeing so teardown skips the
already-freed allocation.

Fixes: b2252ae67b687d2b ("perf c2c report: Decode c2c_stats for hist entries")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index cfc1ebe8c0af74dc..e205f58b2f3d3786 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -225,6 +225,7 @@ he__get_c2c_hists(struct hist_entry *he,
 
 	ret = c2c_hists__init(hists, sort, nr_header_lines, env);
 	if (ret) {
+		c2c_he->hists = NULL;
 		free(hists);
 		return NULL;
 	}
-- 
2.54.0

