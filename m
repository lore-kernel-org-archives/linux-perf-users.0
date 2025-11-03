Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D03330B20;
	Mon,  3 Nov 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181653; cv=none; b=kjLT/BSQGHCbhxVyG+DCzJIphBWuVbD72JIHhkNikWzVSvSCzBKYJb06Rrkult4efCnY4RWOPPlOMBLPNFIWRI78nAfwxBKczG4PXqp9i6aX2Peo2HeYTSJe1KkngdqqfQDLhE+Dzk6Rb7/gXpDo0TTCnRkUqOjCMJamBVoUnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181653; c=relaxed/simple;
	bh=4s6jsp1lmDxjMyiq+Fxr6WPmKUWWu6/VM3FszmVU1VI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aCS4Fx2iaVm1ny1J7vAhyRh4aiAXNO916ttQ+uhkP2a0FPOoRLRFdy3nWkrWTnxzve9xn6UWVST8Jw8MbhUU7xY6iCaNaYG8rOjFoHyMakwSmoY1JQzS5snkbztLNByPX0h5C5wblzXkfUWvYXf24MSDKUhIWiSghcsX54JFSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5vZMG5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5vZMG5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89446C4CEE7;
	Mon,  3 Nov 2025 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181653;
	bh=4s6jsp1lmDxjMyiq+Fxr6WPmKUWWu6/VM3FszmVU1VI=;
	h=Date:From:To:Cc:Subject:From;
	b=O5vZMG5uImfesosvU8itwVpGUZB0IIm0NYO6GFMKVLryRBt9knXDxQOQuOIraT0Kf
	 LWrx02Cu/dTYBuafUx6Q42O2ATSOmG1P2fG9l748+pVmpOTBy0Uu9JAdCB1HKACsUa
	 diOzUbxGG/Sg3//BYwdCImKaZqqGzhTt4Mu9hzbFnZryVL6bnX/6JuvHV3Vw8X3b2v
	 +swSSFp/6W0SzH6iCG6q1CPjMgr7oZEoeXgyosNh1ye5Cn/VLRMFnKXEZ68qHtrFO6
	 VbyJGODYYShWYUcSXnZKHStsHiARhk31nQTbelYopzEX+stTKxMMwFTFeTvPWsTZS/
	 H0ctBwM1LzMtQ==
Date: Mon, 3 Nov 2025 11:54:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 1/1] MAINTAINERS: Add James Clark as a perf tools reviewer
Message-ID: <aQjCEfiFLJwApdlj@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just FYI, I'm carrying this on the perf tools tree.

James Clark has been actively reviewing patches and contributing
to perf tools. Reflect this by adding him as a reviewer in the
MAINTAINERS file.

Reviewed-by: James Clark <james.clark@linaro.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6cda468095de127..13a80d4a8b6b67dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20157,6 +20157,7 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:	Jiri Olsa <jolsa@kernel.org>
 R:	Ian Rogers <irogers@google.com>
 R:	Adrian Hunter <adrian.hunter@intel.com>
+R:	James Clark <james.clark@linaro.org>
 L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.51.0

