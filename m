Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876D1D6AB
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4674138;
	Thu,  2 Nov 2023 09:12:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC4B2F4;
	Thu,  2 Nov 2023 09:12:42 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.. (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.2.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DBBC03F738;
	Thu,  2 Nov 2023 09:11:58 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] tools/perf: Fix man page formatting for perf lock
Date: Thu,  2 Nov 2023 16:11:16 +0000
Message-ID: <20231102161117.49533-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes "CONTENTION" a top level section (rather than a subsection of
"INFO").

Fixes: 79079f21f50a ("perf lock: Add -k and -F options to 'contention' subcommand")
Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 tools/perf/Documentation/perf-lock.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 503abcba1438..f5938d616d75 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -119,7 +119,7 @@ INFO OPTIONS
 
 
 CONTENTION OPTIONS
---------------
+------------------
 
 -k::
 --key=<value>::
-- 
2.42.0

