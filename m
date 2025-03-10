Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483E1C54B2;
	Mon, 10 Mar 2025 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635947; cv=none; b=myRewu5QpAyCmNIZumpuRVFpUVX494jBCROHrXHRglu1KBc2GNi28mWrr2mEr4G9E3EryiiL148uQ73DLKv8dpCRaXE8+xasKx56mK/ebAK+F2ozYFal3sL6trEU125o5466XK35exoqJL5IvwHeqD058sZe64Bndn/c5vyg9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635947; c=relaxed/simple;
	bh=PEz4emfpDKQq21xA68IP+8sMdrnLr+bpnTcP9/ehJtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu6KGtWdID1+sAKBQh7HNC0JmWmtV+/C/laHjaznUNk8n8ZS5ZQAq6IF9HQd1XswFiY8d/DJ6eqp5wgYQUFXRogdVjj58F+to2bB0cxkfCgXyYrcM6ppZTHgEffZta8fAl1jk83Rk7KPc2/Z1rMk7eEHRbE5Ab6aMKhyoGoDN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVeoX++N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVeoX++N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F72C4CEE5;
	Mon, 10 Mar 2025 19:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635946;
	bh=PEz4emfpDKQq21xA68IP+8sMdrnLr+bpnTcP9/ehJtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVeoX++N6k/yrc1rkFtu9v6vqQy8tGqg/9Zr4IJMlY+xK8iGlA2iMPo1hrbNkbCPm
	 5r96tx8leIKss2vMG97G8JI9E4rr9lyYBNtHnBO2HyQ6+76WOJh8ORjY63CoIFOD87
	 ftkOwi00BwnA5SNOvvAHdhhL6/vBs5vbWnhVUMukJJedXGWBJaNaweUNx5nnE2d5Wz
	 LSc3DtJz5LM7Hsm5TnvTGsq3vd00fz28ZtH2IorWus7Xlj7JZia3M/bIeVC8XrXLZw
	 2S2fsjyyqCzi6mtGV4Sladm69XQol2a3VXgy0Eum7yvz3ajhB+jSfJNNm5AVPLgha8
	 bxECLxFXflDSA==
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
Subject: [PATCH 2/3] perf units: Fix insufficient array space
Date: Mon, 10 Mar 2025 16:45:32 -0300
Message-ID: <20250310194534.265487-3-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310194534.265487-1-acme@kernel.org>
References: <20250310194534.265487-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to specify the array size, let the compiler figure that out.

This addresses this compiler warning that was noticed while build
testing on fedora rawhide:

  31    15.81 fedora:rawhide                : FAIL gcc version 15.0.1 20250225 (Red Hat 15.0.1-0) (GCC)
    util/units.c: In function 'unit_number__scnprintf':
    util/units.c:67:24: error: initializer-string for array of 'char' is too long [-Werror=unterminated-string-initialization]
       67 |         char unit[4] = "BKMG";
          |                        ^~~~~~
    cc1: all warnings being treated as errors

Fixes: 9808143ba2e54818 ("perf tools: Add unit_number__scnprintf function")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/units.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
index 32c39cfe209b3bba..4c6a86e1cb54b222 100644
--- a/tools/perf/util/units.c
+++ b/tools/perf/util/units.c
@@ -64,7 +64,7 @@ unsigned long convert_unit(unsigned long value, char *unit)
 
 int unit_number__scnprintf(char *buf, size_t size, u64 n)
 {
-	char unit[4] = "BKMG";
+	char unit[] = "BKMG";
 	int i = 0;
 
 	while (((n / 1024) > 1) && (i < 3)) {
-- 
2.48.1

