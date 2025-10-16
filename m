Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BD32D7EE;
	Thu, 16 Oct 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618668; cv=none; b=IgTWxTBpM2a0s4n5BO5QkL8VNMwbxUCd3Nd5dZFmxihouQHa8SUf4RBKYQa7DZNpuKNtrmIisidcHSvh33KDZG8oPcq4xbh8qtDC4Sfv8B1G0eqkrrNU8z6/eo5nEIaiz5r9hpz0Krc/xV7UtO6kxofyZfugz0VNdcNwnSB3OCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618668; c=relaxed/simple;
	bh=wRfqpzikK0uqrGv9z1MjAp+CKuVXDPwHBy6XbDt08o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StfjYMnmaqe9BCdZW3xkI7N0KeaPeKIIp0azzX3VeGvdF1Qh08X3NcLY7MBVq7rBX0qoi6Bu0ySD5cc9pQ22dDUanmhuc4OODaVgwmP1KRR+z+qf8j8k1qJx6UasTNe4re/Eh59MEISjWMReN2otOXJLplQs65iUiagMy8bxGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B34C116B1;
	Thu, 16 Oct 2025 12:44:24 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] perf build: Fix confusing "No python interpreter needed" message
Date: Thu, 16 Oct 2025 14:44:11 +0200
Message-ID: <ac4511e76ee6c92b89556aa0a77e2a4a03112a84.1760617634.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760617634.git.geert+renesas@glider.be>
References: <cover.1760617634.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When python is not installed, the error message sounds like python is
not a dependency, while it is.  Reword to make this clear.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5700516aa84aec2c..a6448a804ee53a36 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -915,7 +915,7 @@ endif
 ifneq ($(NO_JEVENTS),1)
   NO_JEVENTS := 0
   ifndef PYTHON
-    $(error ERROR: No python interpreter needed for jevents generation. Install python or build with NO_JEVENTS=1.)
+    $(error ERROR: No python interpreter found for jevents generation. Install python or build with NO_JEVENTS=1.)
   else
     # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
     JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
-- 
2.43.0

