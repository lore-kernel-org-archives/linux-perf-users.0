Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA12379988;
	Tue,  7 Apr 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591540; cv=none; b=VZYJi4LWq1F4cR/JMwMpUAjJgwwz+ajAxcLmSkmgCCnXGXjB8Cah3zFqj7HZPkpxltVUYxzyNwuv6L8UrVs4AvYiqeNO6IWUIAX0TpAhHe0shLWuDhNXfMCjCwDdH/xNvtQ6VmilNcQtTWaaPCc/nwyuvMYdAYnuP8e1WtY5ZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591540; c=relaxed/simple;
	bh=yMksQZpxRqpHOsAjR6fOn0HO1g7ZV12s4QLL+KOhC2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psdfErlUyL78KA3h8gL1I5Dix4jmrhe/jtRuufpPSEODQwndKUTFerf1ntCPFjgYw0iHSZ6ZY2au5teBBqZiKkIHKmha9cziVr/GZvEICMxvaSMhsGtgDZS8S0h6+qSsKfPUkyQ1MPv4wvwGzuqen9jnfcU097ioaD5lAnv2NOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=towLaHDG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="towLaHDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D738C19421;
	Tue,  7 Apr 2026 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775591540;
	bh=yMksQZpxRqpHOsAjR6fOn0HO1g7ZV12s4QLL+KOhC2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=towLaHDGlDFYNnaOHm35hY8IsNfxAEkh2dLcFBqeiFFQK6Mu1zriyS+mNOmp4kV5r
	 qiAj8sEG3uZRL7Qww3zEa5Ne2pjXbVdbEbp7vVHlaOVzg+v/KH1eC/8RQ9ZOMDwVmX
	 oJPtbT99mNGmv8KYw4jPpn5MFUXD9gwG2G00yLjOZbUJeXXiTkJE2HQsNjynDy6wPu
	 1s49FbUX5ziQ6bsI2+bL7j5rlOYp0Pu0YB/raovSi5bk8+ncAqopojjGftTzhh/gQz
	 WWzNkNGFGbzBvb9yKAUIzbOjW7B1Cur1tFlNY9DwhXfdD1qPpWhqYu6gjuRxDMRCel
	 LMrZ+km9dahQg==
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
Subject: [PATCH 6/6] perf util: Kill die() prototype, dead for a long time
Date: Tue,  7 Apr 2026 16:51:45 -0300
Message-ID: <20260407195145.2372104-7-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407195145.2372104-1-acme@kernel.org>
References: <20260407195145.2372104-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In fef2a735167a827a ("perf tools: Kill die()") the die() function was
removed, but not the prototype in util.h, now when building with
LIBPERL=1, during a 'make -C tools/perf build-test' routine test, it is
failing as perl likes die() calls and then this clashes with this
remnant, remove it.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 8d32bc8895c9fe4b..87a0818a8c765c45 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -30,7 +30,6 @@ extern bool perf_guest;
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
-void die(const char *err, ...) __noreturn __printf(1, 2);
 
 struct dirent;
 struct strlist;
-- 
2.53.0

