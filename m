Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB817BEB7;
	Tue,  3 Dec 2024 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198034; cv=none; b=ZajmtPtLw5VHWrkTkxi1v03Pp6E78/AoM6cnqY+J37gouwc9aH+ti4FG+w8Axo0iUuOy+8Kq/QyYaJP5AnI43yGKfENri3lu1hFG8O09cL8Jt/RbsM5Z1M2whM/AN6zEqMMMwZBGEbHRk075z84v0eHwDe8eKu4YKpuJhx8u+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198034; c=relaxed/simple;
	bh=tiwTL8knJ9/lrpjwCPKYVq4WT5/OioYslIWbXCg5OG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1Kqcii4/mHcTfSQbPXyhkwcs3EB4kSTOxyov15ZEV0XRfe+znn43jz4EpWPgfCmcSciFI39hL1XpHlQjUG2FrvwPSk+RRpsquidDs7T4nx1OzCSc4ENtgNK4eplzIKa1LweQf7Ybh6tijrQIyctyQzYYns6+kmlXbza6nvTeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7PeW/Gt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7PeW/Gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F18CC4CED8;
	Tue,  3 Dec 2024 03:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198033;
	bh=tiwTL8knJ9/lrpjwCPKYVq4WT5/OioYslIWbXCg5OG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7PeW/GtL8/W8v8LZJI7Sj3AucD0sOgsSvbAK0rzGR3nf5Pev53gXPlzEX2L++gDM
	 ZHZ/7E7NIyf5FO6sCXYST/S3ZsnA4p0z5dLlO5HopR/u2zUQ5z0Sfp0i/mPmpsFqzW
	 jCew6t+FWyADMFUio7lIGUnNXVx1U+HKuPyz0rx66dsCZ4Ig6PsCuiFVOBO15jOgAn
	 gOSy7t5R8ZDRYmOenfx6V7WSOd/7+0dRcZ9MEArzViduGvK7X9+pSC7n5PB8zEjCQ9
	 KuKsn2cPTG7MHDRsI6kazGbp6nOORvRIXCfmdaq3UX2I79NnnbbDUtkqFVbX8rK/Pr
	 5/M6l7RDPE6tg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 02/11] tools headers: Sync uapi/linux/perf_event.h with the kernel sources
Date: Mon,  2 Dec 2024 19:53:40 -0800
Message-ID: <20241203035349.1901262-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  18d92bb57c39504d ("perf/core: Add aux_pause, aux_resume, aux_start_paused")

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4842c36fdf801996..0524d541d4e3d501 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -511,7 +511,16 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_action;
+		struct {
+			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
+				aux_pause        :  1, /* on overflow, pause AUX area tracing */
+				aux_resume       :  1, /* on overflow, resume AUX area tracing */
+				__reserved_3     : 29;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
-- 
2.47.0.338.g60cca15819-goog

