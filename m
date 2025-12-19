Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD7226863;
	Fri, 19 Dec 2025 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107102; cv=none; b=JK2eT5nONg2xuqznBZ5w8XVT9hWjnxtYuuEPDHI/Ub3hI5/ZFZK/bOvvhk07m5OiyWhe1lf4LM7xnfmI23LUREp9QW/EfVTUJlOTtneAtMuev3CGvhMJnZuhEqaXLSyaICnLq5d7tN9RBNfqREKU/H2MBW+rt/z5Pf3D7KB99a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107102; c=relaxed/simple;
	bh=ko18m9lDWuTJbcF/zeHXzG2K/ahuw74r8I77D+KayVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVFXABfpbBOVAWkSWDFnseFnQB/9oi5m08wEyxqeCBt4quWFemG8mPIBdyiVkDNzjI7l1dWupH84OMLOoYymThOjt9QYpB4l/UNlIfSNU/bwsF/UEieujhWD2j2hDW3s08MMjoPEuHvkOlzaVHz8YCtsiYrQ53HQx95Pe31R/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj5xRNee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj5xRNee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1496C19423;
	Fri, 19 Dec 2025 01:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766107102;
	bh=ko18m9lDWuTJbcF/zeHXzG2K/ahuw74r8I77D+KayVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jj5xRNeeARfJBoKB3N1RGnhOpTWpOLFmWR7PwMLmcRi8ZIemmmfHBGuu0vV5Z37xf
	 tsFbbMWPLkwasMXUPvxWwHqc961AiCzV23furK3Ai72/OgUaNSrkFHq3nZoA5ky66S
	 bRnZNKP9B6QGi9Nj/bvLip5Z0zpB/8V5bCYpoalXxTTQfvi1eYpmxZ3iomp+HHlfRT
	 MNhWWIWuwHIYiGHFdI0YcRIF5QFo8ecqnuycerdhFzlHpffRO14hlUtM7t4RlA+quM
	 KLntnisIWdJF2I7WsR8tD1t/hqfhJcZsfLCBRp6k07nxyx01lvi//JC2UcsKw+MWb2
	 rLK0ik38YgKDA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf test: Use shelldir to refer perf source location
Date: Thu, 18 Dec 2025 17:18:18 -0800
Message-ID: <20251219011820.2505506-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
In-Reply-To: <20251219011820.2505506-1-namhyung@kernel.org>
References: <20251219011820.2505506-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It uses tools/perf/include which assumes it's running from the root of
the linux kernel source tree.  But you can run perf from other places
like tools/perf, then the include path won't match.  We can use the
shelldir variable to locate the test script in the tree.

  $ cd tools/perf

  $ ./perf test dlfilter
   63: dlfilter C API                                                  : Ok
  101: perf script --dlfilter tests                                    : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/script_dlfilter.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
index 7895ab0309b29dd5..aaed92bb78285dfd 100755
--- a/tools/perf/tests/shell/script_dlfilter.sh
+++ b/tools/perf/tests/shell/script_dlfilter.sh
@@ -68,7 +68,7 @@ test_dlfilter() {
 	fi
 
 	# Build the dlfilter
-	if ! cc -c -I tools/perf/include -fpic -x c "${dlfilter_c}" -o "${dlfilter_so}.o"
+	if ! cc -c -I ${shelldir}/../../include -fpic -x c "${dlfilter_c}" -o "${dlfilter_so}.o"
 	then
 		echo "Basic --dlfilter test [Skip - failed to build dlfilter object]"
 		err=2
-- 
2.52.0.322.g1dd061c0dc-goog

