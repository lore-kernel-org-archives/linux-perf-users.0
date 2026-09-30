Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154A4E4C25;
	Wed, 30 Sep 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773918; cv=none; b=FcDfBfnllpExd5n+0CF4QX6grsPdb2cjeFp15tcVkx8pUP+Nn3bbonlx+2FdC1lGsapYL5JXtnEcWgGGQ1LtZBm9JMHw9gf2ArxelqQPGES9uuXgSXwTAdc4U3ZrX1v5XMgm0zBCHtVs+uD1oHo3jD2ZVV9Kek04adRzU5AIBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773918; c=relaxed/simple;
	bh=WpLtts0nlzHoASQ+B6Q/WizZBMFNUaTRRX99/OHzIDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dd/wR5fyCkj0/jVKfpos75MNEc2ss66bpcj7g/VnBXvwGoYfv26qCTBhb7DXjpvQ27pOsjM9m0+lm2u1258b8MBMIq2Fx02iFrmwlAzbxVWxJ8u//bQWvIX4YLJG5cTGU+lMkwcikZRWp/5gIliTJbwERQ6gBu6U6uVdQHpT+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pfhRMTg3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pfhRMTg3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A14168F;
	Wed, 30 Sep 2026 06:11:47 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2A773F86F;
	Wed, 30 Sep 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790773910; bh=WpLtts0nlzHoASQ+B6Q/WizZBMFNUaTRRX99/OHzIDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pfhRMTg3vLXWk/Feg0a5vOAbhPsa+SW357MvrG2o9KQBqUz5kJKBUboivx/h5PjUk
	 khTGG2ajs5SUFTh1Hsch4B/uFWrGbZjliccIiUM7lQjGpL5PCi7keH+d3wEgeaLWUj
	 xodgNYScvcKMjr01RS9U885Ahga6bWz2HfE5PRqE=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 30 Sep 2026 14:11:37 +0100
Subject: [PATCH v2 2/4] perf build: Add the output Python directory to
 pylint's PYTHONPATH
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perf_fix_pylint_errors-v2-2-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790773904; l=1215;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=WpLtts0nlzHoASQ+B6Q/WizZBMFNUaTRRX99/OHzIDw=;
 b=nIY5ryEmJ73WHfwAzs5P6GYyELK8gqrRHRLUmbt3ReCwwBU9iBqXDVMSp/mBM3HWZxn9ODkVE
 dj+3XUNJGItDxInHInVYYvZW/qnPsWFb1TBO9lNXSUX3pbLQl7pgGYG
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
index 0eb4e7c29c400021907d3da716bc4871f0df8d88..7ceefc1da774625d9f48d3bb0498ceb819b84d26 100644
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

