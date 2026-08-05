Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FD471D09;
	Wed,  5 Aug 2026 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936691; cv=none; b=ERsdnf3ahxUgW4e3BoQm+wAtW+q03qE4CQUuvcLko72pxi2U1coXVEARc3Dwdugu6abUTd3hHNVVfOxdV1DwnIUuQlFhX0isxw/LyuFKT7FcLlM82luxy2yYSkJasgLE6Yqmo0oRxEzxeGbVubUl5BIjTZxXiTK3rIIJn/vQv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936691; c=relaxed/simple;
	bh=+eET+vtLrV+dDxyeP+Jq1Slogc/Rmdn3ZTNkCK/wlvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dik66SPhRSMoNivsBX8bA/zWjoM+ZkoUdkPqqKBUMOJhDmLLp6WKusaEa/1gv2q0i+ntlLrdOBeAao91c2xe24VYyLWVmAaLwRJh7MjkuaSc2o52Cxx2yfETegzwL9wveOUgOiDdmZAuJLLRS3E9pacslSEKJBC+WMajQmhJJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsJkf94/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsJkf94/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82771F00A3A;
	Wed,  5 Aug 2026 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936689;
	bh=myGsoeIiu4huum95gabL7WYLI7F7P1PM7rMMi2FE1aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsJkf94/OZy0wIZBb1SQnkXM9hdpoDusjeitFAi3pQeaMj49plHWQTG5hslrLuVaE
	 O9YEt6mX6pBTkSKKTGnM3PnRrduNuOHMsTmHKCKh1jL9I9opVGEJP7LKzJoeii8VRD
	 qxxQSnVxKU8Te5jcj24vcNYJa19qEc7ujSjQAaJaJYLndhIi8YqCfrHKRoj9gYIWhT
	 MmhfIY7s6SLMNUsLLxXV+gJh2Ce7788JB4Gzt0jDqK2YQs32d1wOxqX7eoGaKMyciq
	 kGtJ4TT/QCwlbvvokHvZ3yVp+Gx8Fb8YF1qM9aj0Wxx4ddC0WHM2W8coH+fYZSbqwh
	 Szcvn9NpqAvbQ==
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
	Stephane Eranian <eranian@google.com>,
	Stefano Sanfilippo <ssanfilippo@chromium.org>
Subject: [PATCH 03/12] perf jitdump: Prevent integer underflow in debug info size calculation
Date: Wed,  5 Aug 2026 10:30:02 -0300
Message-ID: <20260805133013.235016-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_debug_info() and jit_repipe_unwinding_info() compute payload
sizes by subtracting the fixed header size from total_size:

  sz = jr->prefix.total_size - sizeof(jr->info);

When total_size is smaller than the header struct (from a truncated or
corrupted jitdump record), the subtraction underflows to a massive
value, causing an oversized allocation followed by an OOB memcpy.

Validate that total_size covers at least the fixed header before the
subtraction in both functions.

Fixes: 598b7c6919c7 ("perf jit: add source line info support")
Fixes: 0284fecd13b6 ("perf jit: Add unwinding support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 3195f94187164066..787f8a03dae87908 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -669,6 +669,10 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	if (!(jd && jr))
 		return -1;
 
+	/* total_size must cover at least the fixed header */
+	if (jr->prefix.total_size < sizeof(jr->info))
+		return -1;
+
 	sz  = jr->prefix.total_size - sizeof(jr->info);
 	data = malloc(sz);
 	if (!data)
@@ -696,6 +700,10 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	if (!(jd && jr))
 		return -1;
 
+	/* total_size must cover at least the fixed header */
+	if (jr->prefix.total_size < sizeof(jr->unwinding))
+		return -1;
+
 	unwinding_data_size  = jr->prefix.total_size - sizeof(jr->unwinding);
 	unwinding_data = malloc(unwinding_data_size);
 	if (!unwinding_data)
-- 
2.55.0

