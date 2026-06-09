Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D425B09D;
	Tue,  9 Jun 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967141; cv=none; b=HxF23aETHgjU2MuZAjUCtjXp5NE3yvkpr2o8enPahl6jkvBJX5fhi22IpUfAY2AwwR+O4VuP8HnccH3Ff09zWV6IcxPdN8Qebvdtp7IHZuHbO9/LkeLA86IJEsxb9hHzfdQYSoN+q1Edqjm2YYYfHtBd/vvkDEtvfawwIukGRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967141; c=relaxed/simple;
	bh=fIY4tBDbxr/VoTRY10sITFLHoq4fpQQPfql7EhwWukE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knc4GPv41kJU/r6my/CDxFgBczFKwfPwmNh595SBpnoOLAJeOKNpqV5xscS/3izSf26xcT/NnQRHObaGcbuOrM6lXDqYdTkZJatzSoBoPvOFVHFZLMunjxwwa0fofey9OgmsOiZWc8MBErvAHOAZobc+ClC6cJ2gi22ycJ9o+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDyHtF2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDyHtF2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33331F00893;
	Tue,  9 Jun 2026 01:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967140;
	bh=IDEpi7rzGjAKJsN5adCBWdAC/uJCOWbut3XQjREtJ80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDyHtF2qH3JJqLvCRpE0G7UU02Ko3vhu01P5O/9525p3ZWahaWcC1KWpKhSwwWYMe
	 5AKLmkoreSHNcNv9PId72SJjD3ylclDR+OstjZzPAFtJPzFbJUBZa5OPl+lTL9FYlw
	 t+usOU1AunIxXiuswILrIdr4DjAllU9y4FdpMxsHLE5+rUNNJPSlJ0euxYHQtbArNp
	 Ot1hny2Nml3q0xXuh96S/+m2CyPpFL3Ix4RJRJLSmiEen+gpt/Ygg4UlZzKDgA6gBs
	 PwbrFq1pLOaMAOL1Q6VUpdYdnQ5Eyy3Ou90MeU9PBJr273pM+i+DyKswk5FDerpfq8
	 UlrPFl2mYp06A==
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
Date: Mon,  8 Jun 2026 22:05:16 -0300
Message-ID: <20260609010526.1998472-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

