Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C3B3321DC;
	Sun,  7 Jun 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780874989; cv=none; b=J1TKuClEJAIQ75A4G2LODWVQqfD/ESx+2UAUuknJA4zc+izqICBNt83gwhscg0Qq4T1kT2K3rDh6teyac1v3oMtbPOtUOj603qUn6Ur/Md2uF2NmYHpPQvWgatWS1/PQJcFWep+xxajcAhV+9LB0v6RgHH5ocrNixqsWURqJjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780874989; c=relaxed/simple;
	bh=8oP7hB9MDt6oG1Hv7KYLG/CmRoOreb6KJ/kW2XKBrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8XdGTEaG1lSO8YXWwE3aMoTxNve+Z7urgUzhhVoVXfOcKu+6j0FsQkNIHdTTAsG98WTktmPa+0AVePYMjzu8nw7KkAc6P98kLHZ5J5FwfX3JIozs+Wx4gzt/nEXLQqiCJGWKro4zxZP/p1SQ7y2Ypw/DYCk5dlqXbQpWvZgigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ/csMTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ/csMTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E44F1F00893;
	Sun,  7 Jun 2026 23:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780874988;
	bh=WWjO4YE2PlQ4rvEgx3bcf86O7xkbmHwbGnNMXwpflTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iZ/csMTsCw3ueEJC8xAWYIh8zDeL+TYLSOtJKNXdwYrRIBcI+nBv7VfqSpnfVm+4J
	 85T50zY/6xfBH3nyk8eRV398XvGSBTnUVYPUXfIrCL/YrOCnOXOBDtUBcQP8+cz4Ym
	 H47FClZ41Iq7yBfeVFoZbpJcSpTO9DceEiK10Xo/LeeSeN/isaEbGbW+Mr2vWm4/15
	 hxgn+8vBOmgQqez4eOddtEt6Q3lP/iabku8CkT9LlsXoW2lDBtkK2Pt+VqQrbEcmyZ
	 kmRQyOQB9h7GsmTEdXnXawrKH3wNp/XC3dtW8DTgef7JAG115wS/GXCPTzWYzVnBd8
	 N+ekh4ZOo7zfQ==
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
Date: Sun,  7 Jun 2026 20:29:15 -0300
Message-ID: <20260607232925.1935819-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
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

