Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F5233946;
	Thu,  6 Aug 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019796; cv=none; b=tqXGKLQA+JcslFm0/FpKlxXLH1mvDaj1KbeO1hZ4sAgAc2zfWWbDgQcWO6/8e66ick+VJIg3vkrCVnwpT/yMnffh8WdeD8ulJL0SRtCPOpGUIm0erXj2krH7CRKT9OX6+GfwIoLY1nFC42mYTAJw0Otff0PUSb5M8vRWUbpRHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019796; c=relaxed/simple;
	bh=FFkKcdyGhQ08NmxkzO6fJ7ipzicX9hbBdn226DLbthY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F88g4aWQed4EUAAy7KTU572lZFCxpWtw0N5CwNfaH5d+f6U246sxoPw5Xh1/9GT+xAIGo3FXA2tiLjF0B7WmCdyw2q+YYaZMnt31Q1ryL6F9BQB4ZQ7TjMPfNIX8a/CWx10xbG+DQeWKml3wYHaPybiZEbgVhOIUMhZi4P54oVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbMP0ZUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbMP0ZUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89C21F000E9;
	Thu,  6 Aug 2026 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019795;
	bh=bOV0ZaLH/oUBi1ChkEZxJZfm7NSfyMtKGz3vkX58DvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbMP0ZUTCwPh4kuYLvrK6jI6s805XktlCqBs0KxS6WSIjGI7iTsvpg54OXAvFLay9
	 1eHBLWmJr8UNEguyXMTumVIchCV9EXGq1WbbThRTVr5uaMQswaRdfrrtkqXfTFO30g
	 1eH7/gVmoIRPJ2/h0LMApOfdifBJCICVVy7Dzop4010xDZjYAS1X+N6NoeqoFIYi3q
	 +NSL7zxRK+PRoOEH2RxSvekBrCkVKIci56Rjv/ToJ3xA9Kay33xy8z9LD6vVjo4CHw
	 i9p9y74FfC8tEySQnS7xXyvAiD/TKW8ObApdlvOKyIq74CzYUsAF7N4lma4D5DD+oX
	 agyM1f10YjLZg==
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
Subject: [PATCH 04/12] perf jitdump: Prevent integer underflow in debug info size calculation
Date: Thu,  6 Aug 2026 09:35:55 -0300
Message-ID: <20260806123604.271277-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 14bd23c8d1963e92..f79e9420c6bd7c51 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -671,6 +671,10 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	if (!(jd && jr))
 		return -1;
 
+	/* total_size must cover at least the fixed header */
+	if (jr->prefix.total_size < sizeof(jr->info))
+		return -1;
+
 	sz  = jr->prefix.total_size - sizeof(jr->info);
 	data = malloc(sz);
 	if (!data)
@@ -699,6 +703,10 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, union jr_entry *jr)
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

