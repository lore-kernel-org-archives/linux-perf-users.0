Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C782343892;
	Tue, 19 May 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213068; cv=none; b=ihCTNfvEFDV7jNyUlZPFoTXTtfm7Cm5NAEwwBLhyKUzCGh6KzaRJDjdHkb3Twz1oYkjGb7ZOh+Clg73G2pdXg8ulmu2j2bEQi2NgsTF1g8+5mCbYoSI0tA7i/BJm4GH/LaCmKFbdlZzfKAV1LwhTjEIsooxKxSCAqJZu0D2y/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213068; c=relaxed/simple;
	bh=rYkMWxM3YUTZEhCX/r9k1ofUbqVQcZYrVCMNOFuBcqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGdsqbjy8qUbSJg5yCpkmywIZAQWI7NYwDdBP4zRzKrBSPFkSdy7H9bXZmSAeKFvr0NhLTC94WKtxGzHYQVO5YC7HrvKRgVg9PT95yBBY/FYdM7byS/ONcyIfEEVNOcT1/iLG+chMGt56Aerv75dBbRUK5koH4SrtDIT7HjFc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7L2zSI0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7L2zSI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779213064; x=1810749064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYkMWxM3YUTZEhCX/r9k1ofUbqVQcZYrVCMNOFuBcqA=;
  b=Z7L2zSI0JSdFGS1VCdcqWlsSGmlQncmjDVjQDhR9/0tS0cz8NUXETeW4
   Bx1jn+dPB9knztyKmqwSbZIf2dl4xuFZwXnbrZb4JouQkNvqfZSSSXSAL
   YWJHXqORYLL6JvcIKzEyI/chE4pGFLDRcN73fBoezBWO9ynksuXhqI9ER
   g8xHWprkfDXmm25VbdxgDhiZlt1YiUVVQKjSMgak8zRNc1n5f3Vzbj0U/
   QobgZVmBrVkcQsRK+y3cxAed9CJ2zFYV5tL94B08fbi5K9pXPQgGpoXQe
   B4XhY1W8TL5a6cC9NqQyxvxxl/bRpF7DVlDxd+AzV9FdTMJl4uA0q3Bsn
   A==;
X-CSE-ConnectionGUID: 61d8qTGIQLGqId6cR4V8Ww==
X-CSE-MsgGUID: NY6IaDuiRESDGGJCLOuu5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79951787"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79951787"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:50:56 -0700
X-CSE-ConnectionGUID: EG/I68z5RGe9mZ25TjGG2w==
X-CSE-MsgGUID: IVXO+mYIQPOqc3ffxZNjwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233475595"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.238])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:50:55 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [RESEND PATCH 1/2 v2] perf script: Fix missing '+' indicator when branch counter reaches upper limit
Date: Tue, 19 May 2026 12:50:42 -0500
Message-ID: <20260519175043.1490261-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519175043.1490261-1-thomas.falcon@intel.com>
References: <20260519175043.1490261-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

When displaying branch counter (br_cntr) information, a "+"
suffix represents that event occurrences may have been lost
due to branch counter saturation. However, this indicator was
missing in perf script. Add it back.

Before:

 # Branch counter abbr list:
 # cpu_core/event=0xc4,umask=0x20/ppp = A
 # cpu_core/instructions/ = B
 # cpu_core/MEM_INST_RETIRED.ALL_LOADS/ = C
 # cpu_core/MEM_LOAD_RETIRED.L2_MISS/ = D
 # '-' No event occurs
 # '+' Event occurrences may be lost due to branch counter saturated
...
        datasym+190:
        00005567f9951676        jz 0x5567f995162dr_cntr: BBBC   # PRED 1 cycles [1]
...
After:
...
        datasym+190:
        00005567f9951676        jz 0x5567f995162dr_cntr: BBB+C  # PRED 1 cycles [1]
...

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-script.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..f865c8b2f95f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1287,8 +1287,12 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			if (!verbose) {
 				for (j = 0; j < num; j++)
 					printed += fprintf(fp, "%s", pos->abbr_name);
-			} else
-				printed += fprintf(fp, "%s %d ", pos->name, num);
+				if (num == mask)
+					printed += fprintf(fp, "+");
+			} else {
+				printed += fprintf(fp, "%s %d%s", pos->name,
+						   num, num == mask ? "+ " : " ");
+			}
 		}
 		if (numprinted == 0 && !verbose)
 			printed += fprintf(fp, "-");
-- 
2.43.0

