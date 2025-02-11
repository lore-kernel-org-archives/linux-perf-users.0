Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E21E5B7B;
	Tue, 11 Feb 2025 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254067; cv=none; b=KxXphAZNdxD+2ansHbjs63IGjY/ppzOz5vNuuBMGmGEQM7jM8a83oQQpUm9l0XcgH/T/wSe2SJWVlNLc0ljiS4vN98EGFP/WFHi6ql/ZQKWwMQD+tJR8Iya3UjtaUX8Ii/PXT2Hel5kI1ks+OhuQfJs/5zAubFYdu81lh0aTDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254067; c=relaxed/simple;
	bh=YtDx4WcNrfng51EFYXt87qrCYTKSrLBE421A2knnKao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euVRIudLb1EZ3my92WTQiwIIKKegtW+JNtVZFgkjaqMle3BSTAUpMljwXVKQu46gIp8h4EzhWcDCSmjddOjQ3plBEUpGaxu4V7RLllEbSikyrQ1rVjM66YqpFMLVHCZh/ZwhRelINq+r4pxhx7oAN32FygFYMZ0ELbOVXFwkMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAZWO46j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAZWO46j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBCDC4CEDD;
	Tue, 11 Feb 2025 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254066;
	bh=YtDx4WcNrfng51EFYXt87qrCYTKSrLBE421A2knnKao=;
	h=From:To:Cc:Subject:Date:From;
	b=hAZWO46jpoCibVqtNBjxVnOwuaDJS2DWH/eZWBSIRThFA+r0HGDoly5I46QaDoRw7
	 QrQ2NYCM2DHh7ZZKVhZk8jpjhPCBn6uxRWO7dKfnG0icny0ROfRVzHxVPWr1NIqif+
	 2bhXDiDtacDRsEKcOhgmuhKa3y9pbjTViadrTjnph7r2lhcS0Dh7hj+0STqv66H7cN
	 2L8jO+FyNaijjod5bhWYJjWVeKuEmDHw3IoFPiBByDzXWipXMGyo5FSebcoGwIh3ja
	 zBbiVqFwIrm9qEOega/iCw03Wzp+aEDlVLx/4G2KpIj6KphCgTh7aHltKggdGn1txe
	 bcgk3vCPmheTw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 1/2] perf report: Switch data file correctly in TUI
Date: Mon, 10 Feb 2025 22:07:44 -0800
Message-ID: <20250211060745.294289-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 's' key is to switch to a new data file and load the data in the
same window.  The switch_data_file() will show a popup menu to select
which data file user wants and update the 'input_name' global variable.

But in the cmd_report(), it didn't update the data.path using the new
'input_name' and keep usng the old file.  This is fairly an old bug and
I assume people don't use this feature much. :)

Closes: https://lore.kernel.org/linux-perf-users/89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org
Fixes: f5fc14124c5cefdd ("perf tools: Add data object to handle perf data file")
Reported-by: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f5fbd670d619a32a..c99b14a852dbdfbb 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1553,12 +1553,12 @@ int cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
+repeat:
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
 	symbol_conf.skip_empty = report.skip_empty;
 
-repeat:
 	perf_tool__init(&report.tool, ordered_events);
 	report.tool.sample		 = process_sample_event;
 	report.tool.mmap		 = perf_event__process_mmap;
-- 
2.48.1.502.g6dc24dfdaf-goog

