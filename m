Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015F1D54D8;
	Fri, 19 Sep 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316030; cv=none; b=IKrSiQZ9aHRJ3DC4KfVOxiQFZiKHYrkIQbraV+7X16WSrLzJKF/fisP0fzHUbFtAUS6gXhlAjg4x0Twf3GDvyo331nsF74JmJt0PPR5pgEfrWPP3UtjS1q2yffTBh3/J4d0ouWhVJBbMfXhvb43K/8Gp3DzgkDp0DgtszXU5vZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316030; c=relaxed/simple;
	bh=LYr5OoJe/NOIKdal7VVbiv7OZhCXv4WAjka1k56pzu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDp31I4Q93x/229PaFYZp/17o7g88vPqp664YZp2/Xyv1NymvR+7DBOCSWZrMDhzvPzxGYbdlErhahu3N8LiSF9T++6AVBRcbYe/NhgusWTLGjnhZMZMFHJMeC5vhl0mg0DWgXCZ16woUpI9KOxigH2Uvj+yeGp3v0REqVF+Du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvFCimQi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvFCimQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C985CC4CEF0;
	Fri, 19 Sep 2025 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758316030;
	bh=LYr5OoJe/NOIKdal7VVbiv7OZhCXv4WAjka1k56pzu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvFCimQi0hw4GiK3oJyOEVLyCPHHN5dxl5xEQzZfqQdA+VTHL35Xr3lYlYgDWAqa6
	 S3pyH62Wu4PgFWZ14FO/EUt/MmUIKoGC0eminTMygdknCoxqBW4ZpG3k8Lfwi+W2Aj
	 TpRy4o7Au2cOtyCVajIZfcuaNNI4lm3dpgcLluw4CXVO6JLw13dInotW+xmgSwIs7k
	 uBalNkw2iRYDC2OL/jNCvBXLW/ZJYiFsQyLSjdQNIQrTNgZp+dmmsfC3LNochQmHge
	 x5qnW5oweKcylbw6ztgYDF2t4frQE99W4+6kocgO/Mg4CWrkAIYu7XYSFWxH7/GvCp
	 o8Sm8WWEjWOxQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/2] perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
Date: Fri, 19 Sep 2025 18:06:53 -0300
Message-ID: <20250919210654.317656-2-acme@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919210654.317656-1-acme@kernel.org>
References: <20250919210654.317656-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need it to fix some other libbpf version dependent issues when
building with LIBBPF_DINAMYC=1

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-filter.c | 5 +----
 tools/perf/util/bpf-utils.h  | 5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 92308c38fbb567ba..1a2e7b388d57d367 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -56,6 +56,7 @@
 #include "util/debug.h"
 #include "util/evsel.h"
 #include "util/target.h"
+#include "util/bpf-utils.h"
 
 #include "util/bpf-filter.h"
 #include <util/bpf-filter-flex.h>
@@ -443,10 +444,6 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	return -1;
 }
 
-#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)			\
-	(LIBBPF_MAJOR_VERSION > (major) ||				\
-	 (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
-
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
diff --git a/tools/perf/util/bpf-utils.h b/tools/perf/util/bpf-utils.h
index 86a5055cdfad6689..eafc43b8731f1e31 100644
--- a/tools/perf/util/bpf-utils.h
+++ b/tools/perf/util/bpf-utils.h
@@ -8,6 +8,11 @@
 #ifdef HAVE_LIBBPF_SUPPORT
 
 #include <bpf/libbpf.h>
+#include <bpf/libbpf_version.h>
+
+#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)                       \
+       (LIBBPF_MAJOR_VERSION > (major) ||                              \
+        (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
 
 /*
  * Get bpf_prog_info in continuous memory
-- 
2.51.0

