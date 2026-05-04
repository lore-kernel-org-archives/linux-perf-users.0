Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105E28C009;
	Mon,  4 May 2026 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777876089; cv=none; b=fmTLafJ2t7Lbznb5wFf5ghQodRW3PUYkFwO66h2yI6vMtaJ4ochiMue8iFKqLVHLVo1h+9x+ELkEgRMkpAtPGrNw5z869nfoZPGUu2jQrk0f7vcWeZTEVLpYO6EQmNIStzPxE4eD4wWmZAHXFzPY9LnVB9mvaG5e2ELY65jpD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777876089; c=relaxed/simple;
	bh=SagCNADX4hw2Ho0e1b35RZD+4ryErLG0Q67sc2BGO7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yh0zGnfMTVPScxrnNEvdDrZjwv8HOmXcu12dWOyu/tT752PpEi7GARQAzHOES9Q6XQI93UwL+UYUtCiFQVDIF5CbTQ3zE6ZgbjF1JNdKWOasA3azECe6zu1TUA+12ID6Nw9g6pVOtimn50q+vxVMVBe2ZrhvEz2wljdYhbOAb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHjjZ+gB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHjjZ+gB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F0C2BCB8;
	Mon,  4 May 2026 06:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777876089;
	bh=SagCNADX4hw2Ho0e1b35RZD+4ryErLG0Q67sc2BGO7o=;
	h=From:To:Cc:Subject:Date:From;
	b=EHjjZ+gBMU1FUAq/maL0OynqOEG5KvC85LF7xR1+fXnAoLRZ2vFOn5RqySt/G7O70
	 SuBepJKLpob48SjCQpOAyvoBYYIHfhA7On+Cfqlaqk4znxMDFFd3jIye5B6+Z34ZUi
	 HIs6z8kcuEcqxkUypDeZ89uNl1hk30W1VzWfpf41LGalAGDti2mQsD4k8z+Dxia+JX
	 6/1COJWLvna0qVTnqgAJ5kYTTRypDMEUYhg7UuK/KuqhKdZO9CxcsHVO+hPLHC9N9F
	 4oYpW32+hoLeSUmo2RyYk8LeB1DN7L1VHc8RuC+fHtDd3/v/XVgrpZTUtqzJuTIgLM
	 Jp4V4CEolOHUw==
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
Subject: [PATCH v2 1/3] perf build: Update error message for BUILD_NONDISTRO=1
Date: Sun,  3 May 2026 23:27:56 -0700
Message-ID: <20260504062758.92001-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should say binutils-dev(el) instead of plain binutils package as it's
mostly installed already and can confuse people like me. :)

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 333ddd0e4bd814e9..06d7a3f9990ce522 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -923,7 +923,7 @@ ifdef BUILD_NONDISTRO
   $(call feature_check,libbfd-liberty-z)
 
   ifneq ($(feature-libbfd-threadsafe), 1)
-    $(error binutils 2.42 or later is required for non-distro builds)
+    $(error binutils-dev(el) 2.42 or later is required for non-distro builds)
   endif
 
   # we may be on a system that requires -liberty and (maybe) -lz
-- 
2.53.0

