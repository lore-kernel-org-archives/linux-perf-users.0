Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555DD32D7EE;
	Thu, 16 Oct 2025 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618670; cv=none; b=FfnU5eKdySNQyKuJgHzC7RWqDqxzc2/V71qoxTTTH47+5hm7KBOi4PRmsOoIMZSb+DMMJ727GDD8CDW0YjItA88Lg1cgvxfBuDl/7T3iiqc8cqOrGNygGSaF+PZLryTCwusA5JrQ89HjiTAhGiEzcZwbR30Mwqeyx51n7qvkf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618670; c=relaxed/simple;
	bh=pko+Sz+zbn4N9c1pHJpcRm2vsnOhT9/f5CoxdPS8PEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOzul0aVjlcGeH1XgFv1DfHuen0nOLgqhwmHyQ1T2vHW5ifbvc3HINv3oAOHKWZhvCaewB1OCZRHxjZmzj2++FdeT5jMgw9k6CLedwb+GjgRyU9DphXZ/lCOmenBFbmXeXXdA+9IKyJunLqe8EnNwYeh/DJTfkRvukb98vEZglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFED7C113D0;
	Thu, 16 Oct 2025 12:44:27 +0000 (UTC)
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
Subject: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
Date: Thu, 16 Oct 2025 14:44:12 +0200
Message-ID: <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
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

The build looks for "python" and "python-config", while modern
distributions provide only "python3" and "python3-config" by default.
Suggest installing "python-is-python3" and "python-dev-is-python3", as
available on Debian 11 (bullseye) and Ubuntu 20.04 LTS (focal) and
later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a6448a804ee53a36..b37149afdb1d27ba 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -872,7 +872,7 @@ ifdef NO_LIBPYTHON
 else
 
   ifndef PYTHON
-    $(call disable-python,No python interpreter was found: disables Python support - please install python-devel/python-dev)
+    $(call disable-python,No python interpreter was found: disables Python support - please install python-devel/python-dev/python-dev-is-python3)
   else
     PYTHON_WORD := $(call shell-wordify,$(PYTHON))
 
@@ -915,7 +915,7 @@ endif
 ifneq ($(NO_JEVENTS),1)
   NO_JEVENTS := 0
   ifndef PYTHON
-    $(error ERROR: No python interpreter found for jevents generation. Install python or build with NO_JEVENTS=1.)
+    $(error ERROR: No python interpreter found for jevents generation. Install python/python-is-python3 or build with NO_JEVENTS=1.)
   else
     # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
     JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
-- 
2.43.0

