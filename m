Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209F2701CB;
	Tue, 14 Apr 2026 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199745; cv=none; b=TnMPn6qwMSGW/UcTp5crBbKIsOFrXd5YfwmpQiMH5jI28vfqqWqbx/NoFwUCzWQZQ/QZT32/vbJX+fQwvHIBxVgcMSo7mDkh8+XycGfEJJ0ZzaUHq8EFbNN0wIcgryAYKG07M3tpDxEcZhHCoUKHNsrOvRGpmR05tsWzDAJwPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199745; c=relaxed/simple;
	bh=H6liez7WESmbfgSAy1NtmogDKAjTD1AhH+U1x5vV9kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpitI6JRzC9lfCVpmmOQ1BwS0VykaWtVZKFfs1tGcW4frDNxFZtuztcbcCFGiQtck8+PGAe8KrbwnvfTJgQ6AyiFArSCToGVVe8bM4ynYSQepUZ3fEAIgyx75cmfD947kxWZpJZEus74tU1HZHJiMRdQNqTXR4NoHVk4dgr9gdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suaLpmYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suaLpmYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEA5C2BCB5;
	Tue, 14 Apr 2026 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199745;
	bh=H6liez7WESmbfgSAy1NtmogDKAjTD1AhH+U1x5vV9kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suaLpmYWDxUR4L3YpLyTrPKEKkoslggBsWb94Kx2bhK/ilV3jLdnWQPWfVc1JOSvG
	 Aok3iFWJa4Al/cH829Ud2lLx57XfTR0YslcRhyi8GgDJAY0yHwcI4IZJ2xDQbYZCIv
	 QaE1LlAMNMHCbCLqRnswDVF7VfoCg70zuWG2xpYd/9bPV/K4s3JtwE7pPjSX3YH6Tn
	 khB7tS2qE8iTUri27E4E6EBm9a3tEulMchzbM0x7FQLaVniOLd19/u3cjj9RiysKLC
	 VhTv70O64FaqoDpKuGvGULWmty1LIgze87/ZqVFpf1Fx3rdCgJa10nHhOrk4Dgc7rZ
	 UlgcHZ8F2w7SA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/4] perf header: Validate string length before allocating in do_read_string()
Date: Tue, 14 Apr 2026 17:48:45 -0300
Message-ID: <20260414204847.293557-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414204847.293557-1-acme@kernel.org>
References: <20260414204847.293557-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

do_read_string() reads a u32 length from the file and immediately
allocates that many bytes. A crafted perf.data could claim a huge
string length, triggering a large allocation that would only be freed
moments later when __do_read() rejects the read against the section
bounds.

Check len against the remaining section size before the malloc().

Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 13bbf8df15f66cab..c27ed90727ea6629 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -269,6 +269,9 @@ static char *do_read_string(struct feat_fd *ff)
 	if (do_read_u32(ff, &len))
 		return NULL;
 
+	if (len > ff->size - ff->offset)
+		return NULL;
+
 	buf = malloc(len);
 	if (!buf)
 		return NULL;
-- 
2.53.0

