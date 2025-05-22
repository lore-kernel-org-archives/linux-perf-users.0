Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49C1A5B89;
	Thu, 22 May 2025 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905115; cv=none; b=etdDcGuOsJ/2q95uiMRAVdEUnhUMgKwNWrzOPTHMzdThWRElVZcUAhAKZ3i01x+IusLW7o6dQU4dYgGtaTgE/doJTRlKkoHakR5ryGFDNK6sueChadxKy1YZxa40hROkLm2e1K13bHbF4fIgkhDvPJ7MtaYct6Mkku6N/eEXFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905115; c=relaxed/simple;
	bh=gQgdfuuRmsQQkGuY+MBkKwNHY4Vq+mmhkn9UMRV7ZFs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PXzuPLyiSU5gNEyZ/g/NBiLotfANZ246buROesYxaH6J0ObaHNH/1N5NUJpIXy6ExW4NXs7ki2bA4EUHZwDle42AAeW8153v2qrENj/5eqqAxyiA7QONvcuc57bP/VCcIRf6I9yp/61DOfx2lVz830OTRCMta6wqPfJhQ7dv0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3vu3TS8Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M5ZyO48P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3vu3TS8Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M5ZyO48P"
Date: Thu, 22 May 2025 09:11:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747905106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghSfvNbvgXdHqKnG0NsnphSpa7y/lU16KZhti6HbAiI=;
	b=3vu3TS8YqDAKdh7imnxDlj8fs9z93ReL0+cbhpTlI6uUnJpQLVW+QGfQ04CO0p5BEXU7LX
	LcBWmjw1c4YYU8fk8bxFz+mynA9q8z0WRR/C1gi4y3zQJ4kjRangHMu3/Wltl/tiWwW0TL
	+DELOjUCKscBBFro4QLy1M5uMFmp8RR8lnDR8D/WFEb5FZ7MIrWhHOFFBc0uQMjn4FVGLW
	DZh+FtkGL0hS6VTRag4s6rWlmBQobC7+NKaDAupJP54rQnbU6AsLpOT1Qkq7IpudcC4Byo
	sZyWSBdTa7Q7B39eRkK47Pr6ax28JpSikxf2F2c9hSrtG40axxxfOgwbXX1uYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747905106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghSfvNbvgXdHqKnG0NsnphSpa7y/lU16KZhti6HbAiI=;
	b=M5ZyO48P9UVUUQ7uhxscf9d70LROWG4whQmr7cgDuacA8enP9rlFGZ/eNtyO5xHbC5dxrk
	fTmsZlHHS8kBrwAw==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/uapi: Fix PERF_RECORD_SAMPLE comments in
 <uapi/linux/perf_event.h>
Cc: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-perf-users@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250521221529.2547099-1-irogers@google.com>
References: <20250521221529.2547099-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174790510508.406.7162582718080618976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f4b18ff2c147d3b56384fcc8adb30bf733bf2300
Gitweb:        https://git.kernel.org/tip/f4b18ff2c147d3b56384fcc8adb30bf733bf2300
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Wed, 21 May 2025 15:15:28 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 22 May 2025 10:01:34 +02:00

perf/uapi: Fix PERF_RECORD_SAMPLE comments in <uapi/linux/perf_event.h>

AAUX data for PERF_SAMPLE_AUX appears last. PERF_SAMPLE_CGROUP is
missing from the comment.

This makes the <uapi/linux/perf_event.h> comment match that in the
perf_event_open man page.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org
Link: https://lore.kernel.org/r/20250521221529.2547099-1-irogers@google.com
---
 include/uapi/linux/perf_event.h       | 5 +++--
 tools/include/uapi/linux/perf_event.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 5fc753c..b2722da 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1035,10 +1035,11 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
-	 *	{ u64			size;
-	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 5fc753c..b2722da 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1035,10 +1035,11 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
-	 *	{ u64			size;
-	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
