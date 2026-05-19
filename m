Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8336C59A;
	Tue, 19 May 2026 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216727; cv=none; b=Q5Xqv2lRMxQqYsS0lo/PX4Rb3n+t9SkHc6L/k/kKT0T8l7CyflQfbSH3WxYvKmglBePLiWwUGZv19D72PDlHkbt+ti9NSshTQD0X/bTQ5pyc8gT5LVjlMWV01qK8U2DRcd90Oh9p6R1bK+rjEQk9OmenuySeBFxu/bN9aL25huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216727; c=relaxed/simple;
	bh=CKsIF0fCaBVEsWMMogugn8G7cs1NuJPfituR9/kqfmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmKbQ6C8vG/v2VBDVQ1SkGH3Gdhg3H8Ll3W06m8cL2Scyc1nL2JP4av8htt3ifcPjOWZfFmXMxpNGo6KRMHQ+4LU6b+zDfyZt9dzF20UQspA3vnsjAaLuUqaewDf3uUjusUcwMZtuSJXTcNo7ZF0owHUiABSe3q+0XYjbx4Nn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AKOyaAIl; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AKOyaAIl"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 66C13C00303C;
	Tue, 19 May 2026 11:52:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 66C13C00303C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1779216720;
	bh=CKsIF0fCaBVEsWMMogugn8G7cs1NuJPfituR9/kqfmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKOyaAIlC4TIDwBFsVQvFQY0bUcjv5J10f1PQTvA5yha9EIeaPARxELGzTl+G7uEx
	 9UNJCChlNrTH26oce+8X7na/oXJu/Nv/oaRCzlpQxkABEsuW9tI00j56l2UReJdvYI
	 0LvyPQiBYa+TUjoVpo4V94h/YPNE4yO8eiOK0EZs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 9AB04AEA2;
	Tue, 19 May 2026 14:51:58 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh@kernel.org>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.1 2/3] perf parse-events: Make YYDEBUG dependent on doing a debug build
Date: Tue, 19 May 2026 11:51:53 -0700
Message-Id: <20260519185154.2987285-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

commit d4ce60190e08d84f88937019defa5e3d23409ac1 upstream

YYDEBUG enables line numbers and other error helpers in the generated
parse-events-bison.c. These shouldn't be generated when debugging
isn't enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230911170559.4037734-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/util/parse-events.y | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index be8c51770051..dbc350a2c382 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -6,7 +6,9 @@
 
 %{
 
+#ifndef NDEBUG
 #define YYDEBUG 1
+#endif
 
 #include <fnmatch.h>
 #include <stdio.h>
-- 
2.34.1

