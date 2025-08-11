Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9E279335;
	Mon, 11 Aug 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891818; cv=none; b=D9uMvh8Om5aAUuufwDiEUU2qTAA+aBX71C+eJHbcw0ofuNqqQRi8ma4eraS3Rkm0B8p5Mq78latQKPQa5lsBdA6vBN/k/RwGKYYktE/uNdWOeiJAQaXSqEnZzM30nOMPIlhZAY8jw1WpMNtH+HTeY7fEcL9ZYdkXT+Fsogy4KC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891818; c=relaxed/simple;
	bh=g9dgtquM4X+diJh1n1m5KYnJL+cMz35zZQk0CTsBkec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEZdsBKtMAsaV0TqkXxhVUZ3nxXN8C9q2erxXvKxWWYw960pHa2XYtUJvxyfhIiR7I8wVAVbkI2WEej5jWfhbh3MTVEVEed6uZmlO+uR1jpuF8k94WcUy8yuW+iQm1k7WsNfo2QowJC8zqxEGVSHyVLBG2IcsWk40clIYkgORis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAEE53fn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAEE53fn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754891817; x=1786427817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9dgtquM4X+diJh1n1m5KYnJL+cMz35zZQk0CTsBkec=;
  b=kAEE53fnPtTGP2TkleIJbsMOD81SNLP8Ft+JlPwbT4Rms72JvqxGEBZB
   MCmWDrDeMuF66j2S3dFm0H+f2IJt0pw3Nqj4E7ggw+wI7ETv1GZnanhkk
   JvUjESgOk/za2K4Yw4qhGhrQzJmJScRwta4M9FW+e0KuyintOU+A4fmyT
   R8xcFwScF1GCng/qd0q9Xzl/0HvsfZyHfdYWbDvUVWND/dacBbo0kJ2JQ
   eUQvcEQEhsOHyv/Xc5Je3ytQL5Z/LsMa8eWFBJ8E3XCZ8qNrEGaLrrqO0
   ipfKCDcvq4lu5p43mYSir4lEe1zfyceeM7QXed1GTu9YifR9UX+gvwTBh
   A==;
X-CSE-ConnectionGUID: Of/78T0tSRmHctiH901vKg==
X-CSE-MsgGUID: HjE9/Vd4SVulyedr8sCcZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57043608"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57043608"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:56:57 -0700
X-CSE-ConnectionGUID: nqT2ajA9RXmWVyJKuRnJ7w==
X-CSE-MsgGUID: tSUVp9OsSSmpla4k6Jw/9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171183712"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2025 22:56:55 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 2/6] perf tools kwork: Add missed memory allocation check and free
Date: Mon, 11 Aug 2025 13:55:42 +0800
Message-Id: <20250811055546.296678-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same with previous builtin-kvm code, perf_kwork__record() doesn't check
the memory allocation and explicitly free the allocated memory. Just fix
it.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-kwork.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index d2e08de5976d..7f3068264568 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2273,12 +2273,23 @@ static void setup_event_list(struct perf_kwork *kwork,
 	pr_debug("\n");
 }
 
+#define STRDUP_FAIL_EXIT(s)		\
+	({	char *_p;		\
+		_p = strdup(s);		\
+		if (!_p) {		\
+			ret = -ENOMEM;	\
+			goto EXIT;	\
+		}			\
+		_p;			\
+	})
+
 static int perf_kwork__record(struct perf_kwork *kwork,
 			      int argc, const char **argv)
 {
 	const char **rec_argv;
 	unsigned int rec_argc, i, j;
 	struct kwork_class *class;
+	int ret;
 
 	const char *const record_args[] = {
 		"record",
@@ -2298,17 +2309,17 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = strdup(record_args[i]);
+		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
 
 	list_for_each_entry(class, &kwork->class_list, list) {
 		for (j = 0; j < class->nr_tracepoints; j++) {
-			rec_argv[i++] = strdup("-e");
-			rec_argv[i++] = strdup(class->tp_handlers[j].name);
+			rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
+			rec_argv[i++] = STRDUP_FAIL_EXIT(class->tp_handlers[j].name);
 		}
 	}
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
@@ -2317,7 +2328,13 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 		pr_debug("%s ", rec_argv[j]);
 	pr_debug("\n");
 
-	return cmd_record(i, rec_argv);
+	ret = cmd_record(i, rec_argv);
+
+EXIT:
+	for (i = 0; i < rec_argc; i++)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
 }
 
 int cmd_kwork(int argc, const char **argv)
-- 
2.34.1

