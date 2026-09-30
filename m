Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057D472541;
	Wed, 30 Sep 2026 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758910; cv=none; b=ADUCk36hkntbMaNHh8h1Soip1CFv++/gRStDvINY6XXMkEJ/b48ESc3NfdAI8SfdS6b/fT4zdYsxytXyHTQ2duJi10pAXDd1VBg5zPEZObVvgr7O6Wf1cTdNVAFl5lRQhQwQwm4IrUpy/OpEuKeKUWsTbC1v5f4q+HBoGptiVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758910; c=relaxed/simple;
	bh=tG05ycxW7yyGxx8/mTiqYxOCp9x/OHDfO5cfPD19NOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKoBJdNNpMbd7c3ZlWC0eimLwcbXyxO8y2ugm0XOyz6ljqD9ufPr4IwaGGzFfbUjIYVZFDcPfdQCXCGj+KxHNpAaOtvTlKvip3DY5CTqrHQyc1YYBwkwnXoMsNzungK9K9Q4NousbGF9aGf62VSjj8GXQNEWYbBJ/dVj1M/DuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PC97V+oO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PC97V+oO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15479143D;
	Wed, 30 Sep 2026 02:01:45 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E400A3F85F;
	Wed, 30 Sep 2026 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790758908; bh=tG05ycxW7yyGxx8/mTiqYxOCp9x/OHDfO5cfPD19NOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PC97V+oO8e4W5ienZnhyZAjX4dkj1IWu/T3ZZ/gyvdbbpVdmQ9Ly+I8FK6gLxDFK/
	 yDU9XmSpDW6pUr1vCwHdA0SwxwGNweOAVEYnsGGTQAhBpE2nxdhiS8qqg0JT4pz1Zg
	 p26CtYhBDtTvdhdTHL7oqN8ZhMCqAaQTgxC9UmuI=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 30 Sep 2026 10:01:13 +0100
Subject: [PATCH 2/3] perf build: Add the output Python directory to
 pylint's PYTHONPATH
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perf_fix_pylint_errors-v1-2-f72151d8b255@arm.com>
References: <20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790758902; l=1215;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=tG05ycxW7yyGxx8/mTiqYxOCp9x/OHDfO5cfPD19NOA=;
 b=ls6h//SGUIpHDhPKBDm9NOZyXv3qrfeewH5JqcLpiybkUDDzxn/4ZZMt+2alzuZD5onsdsLH/
 WC/GH8kFbjjDifNBaAzSGheIGDR3/7mJhYibEA5xA6Lj5IK+6Oxzkjz
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Prepend the output Python directory to pylint's PYTHONPATH so builds
using O= can also find the generated extension.

Fixes: 5fe83fb352c8 ("perf build: Make pylint build test opt-out (NO_PYLINT=1)")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d350d085542c64fc6d0bed4c5d7d1daac51efa8b..0151aac394569671b98c98a42d97f75d380856cc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -310,7 +310,7 @@ ifneq ($(force_fixdep),1)
       $(warning Warning: pylint version is older than 2.16.0, skipping pylint checks.)
       override PYLINT :=
     else
-      override PYLINT := PYTHONPATH=$(srctree)/tools/perf/python:$(srctree)/tools/perf/pmu-events \
+      override PYLINT := PYTHONPATH=$(abspath $(OUTPUT)python):$(srctree)/tools/perf/python:$(srctree)/tools/perf/pmu-events \
         $(PYLINT) --disable=all --enable=E,W --disable=W0123,W0311,W0511,W0603,W0622,W0718 \
         --ignored-modules=textual,setproctitle
     endif

-- 
2.34.1

