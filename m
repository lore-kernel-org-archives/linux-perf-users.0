Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414642ECD3A;
	Mon,  8 Jun 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882282; cv=none; b=UVIC14UrIm2VnsUwSty4e6Egse9Tbo4uJ9TKgkoSlHZ+s03Whuj21BAUjUsuRC9ZSKbo1zf9o6ARkatcgMSxV7EH5en12uAe8MlQSYdYdWYt+UNiEIxKcTv+pthasyQwybcZnFXwkeinFhnlp5BAGY+T/EXpo0QVdf3sZ0zg/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882282; c=relaxed/simple;
	bh=8oP7hB9MDt6oG1Hv7KYLG/CmRoOreb6KJ/kW2XKBrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBgpHBpP3s4K5DGWKqf3Wm8ieeFpLyE0wHF71W1LKHwEAlQQAcLKWwgGatpDpySglG3TKxnd6H2ZpvtKWhIUAb7YdNl2ZmVZU6ODA97e8tF9dy51r8CvZ5pGhbS9jh3FyiSKFI+5oBJ/rk/mZJ0uYEKTx5VlrDVQWZorjtk923k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6QK/oWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6QK/oWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655FD1F00893;
	Mon,  8 Jun 2026 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882280;
	bh=WWjO4YE2PlQ4rvEgx3bcf86O7xkbmHwbGnNMXwpflTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6QK/oWT/36Baf/PRuaAYBO+h6fJHwZEFfLGibIPgWcdaWQWX0G9bA8QL/7V3ywHt
	 lo15EIBQQlyvBgHL/d/HAgAdmj9YMjsOzuoExQxSwRcuwwctynW4GtPp8lP2KmQ4KN
	 Lii5LDAlQ9vbNJhtwyDGvbuf88/9xNRaE/TNjaEcq5XplZsFnKlu6UW6Yyt+xunQa0
	 FjNQDIEUd0Gc5aBTBqQejCFiSIuvFO8piSJMQGYgkPquXe1xxlY6PYEif9uvFqWpu+
	 EByI9aP5MhqPoPHjNzVFA5p8eMV8QkG9h5bAUrPPh+rPrWvfCbouqi5Y83Ijh/ieYl
	 nOM1rAIOi3y2A==
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
Subject: [PATCH 02/11] perf tools: Use scnprintf() in cpu_map__snprint() to prevent overflow
Date: Sun,  7 Jun 2026 22:30:46 -0300
Message-ID: <20260608013057.1942953-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cpu_map__snprint() accumulates snprintf() return values in ret.
snprintf() returns the number of characters that *would have been
written* on truncation, not the actual count.  When a fragmented CPU
list exceeds the buffer, ret grows past size, causing `size - ret` to
underflow (both are size_t), and subsequent snprintf() calls write
past the end of the caller's stack buffer.

Switch to scnprintf() which returns the actual number of characters
written, making ret accumulation safe by construction.

Fixes: a24020e6b7cf6eb8 ("perf tools: Change cpu_map__fprintf output")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1fab00ec4a59a0c7..23ebe9b97f8e58af 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -692,21 +692,21 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 		if (start == -1) {
 			start = i;
 			if (last) {
-				ret += snprintf(buf + ret, size - ret,
-						"%s%d", COMMA,
-						perf_cpu_map__cpu(map, i).cpu);
+				ret += scnprintf(buf + ret, size - ret,
+						 "%s%d", COMMA,
+						 perf_cpu_map__cpu(map, i).cpu);
 			}
 		} else if (((i - start) != (cpu.cpu - perf_cpu_map__cpu(map, start).cpu)) || last) {
 			int end = i - 1;
 
 			if (start == end) {
-				ret += snprintf(buf + ret, size - ret,
-						"%s%d", COMMA,
-						perf_cpu_map__cpu(map, start).cpu);
+				ret += scnprintf(buf + ret, size - ret,
+						 "%s%d", COMMA,
+						 perf_cpu_map__cpu(map, start).cpu);
 			} else {
-				ret += snprintf(buf + ret, size - ret,
-						"%s%d-%d", COMMA,
-						perf_cpu_map__cpu(map, start).cpu, perf_cpu_map__cpu(map, end).cpu);
+				ret += scnprintf(buf + ret, size - ret,
+						 "%s%d-%d", COMMA,
+						 perf_cpu_map__cpu(map, start).cpu, perf_cpu_map__cpu(map, end).cpu);
 			}
 			first = false;
 			start = i;
-- 
2.54.0

