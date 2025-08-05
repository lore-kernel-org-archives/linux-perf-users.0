Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F96188596;
	Tue,  5 Aug 2025 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354855; cv=none; b=JjtLGL21pNIeH2k8jz+fzZgQvd0D1EPS2MiEz1BMOJvOQ606mJHyk4hd08+7rTDTRVbza+tE7p+vRYFlBIghsdFY6eT2unAfJahC9rqWr53i5tugmlFy6pb/yKNlTMyp1HeE3Bf+HlI82FWQGN9U6OUQWAgB9UUQoOLdBf+i96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354855; c=relaxed/simple;
	bh=QLfgBUux07soUI5AicB9psHxrDdj4LIKM6BIPIuHtvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6FtCrixg143NzhH1bwQ1Hw2W/kQ1e/do7yDubeXQ2mViGcYowTOip7ae5aPjKfaKWrWgazhbVyK/Gh1OLOBMnab0L5agPOB7VOSkQFtjOQ7x68MuR5+S6rfDFUL1NodWl4ZtXaWRckgCJi3mzyvyJIcku3UWxYGZZmpZiJ4tcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+lTGzji; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+lTGzji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754354854; x=1785890854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLfgBUux07soUI5AicB9psHxrDdj4LIKM6BIPIuHtvU=;
  b=J+lTGzjicuxY7tESDiYpJa/Zde45z95zkI0wmZ9hbUdVgVh9IrlBNN7W
   4S9fN8Up0Y5hiWwVR91OD1YWVDSc7w+kG4NbbRPxRn99HWwd2GyhKoBGM
   YEyR50wVSM5qIUarw+CxZ3MS+arFKoe66D6VyvcJKF333xZVf1fk4GFbm
   lb+9pYLp0eTUDr6p9x3zomOg/PrYBOwivZgWhlv7/0lktU520xiqKaQqV
   IegXWvXDnO/5g19XdwYQ/GT8nwzZHT2b0xf+nvnyEihcMVCzocxgGjFmW
   NV8Xf0RH0jfL+31BMgbVLdWGwiz05c+oeMFJNzX5XyWajwnj+/MLed/6I
   Q==;
X-CSE-ConnectionGUID: HpXh7LMUQFWZimM51W5Vng==
X-CSE-MsgGUID: P1JykY4EQ9uV8FrkSvk7dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56523826"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56523826"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:47:34 -0700
X-CSE-ConnectionGUID: NIegug8rRhC7XETT3NrBIw==
X-CSE-MsgGUID: oI0LrwU9RNeDXAtVAnb78Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169605429"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa004.fm.intel.com with ESMTP; 04 Aug 2025 17:47:31 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/5] perf tools kvm: Add missed memory allocation check and free
Date: Tue,  5 Aug 2025 08:46:29 +0800
Message-Id: <20250805004633.135904-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code allocates rec_argv[] array, but doesn't check if the
allocation is successful and explicitly free the rec_argv[] array.

Add them back.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-kvm.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 7b15b4a705e4..f78a67a199ff 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1719,7 +1719,9 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 	set_option_flag(record_options, 0, "transaction", PARSE_OPT_DISABLED);
 
 	record_usage = kvm_stat_record_usage;
-	return cmd_record(i, rec_argv);
+	ret = cmd_record(i, rec_argv);
+	free(rec_argv);
+	return ret;
 }
 
 static int
@@ -2006,6 +2008,9 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	rec_argc = argc + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	if (!rec_argv)
+		return -ENOMEM;
+
 	rec_argv[i++] = strdup("record");
 	rec_argv[i++] = strdup("-o");
 	rec_argv[i++] = strdup(file_name);
@@ -2014,16 +2019,21 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_record(i, rec_argv);
+	ret = cmd_record(i, rec_argv);
+	free(rec_argv);
+	return ret;
 }
 
 static int __cmd_report(const char *file_name, int argc, const char **argv)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
 
 	rec_argc = argc + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	if (!rec_argv)
+		return -ENOMEM;
+
 	rec_argv[i++] = strdup("report");
 	rec_argv[i++] = strdup("-i");
 	rec_argv[i++] = strdup(file_name);
@@ -2032,17 +2042,22 @@ static int __cmd_report(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_report(i, rec_argv);
+	ret = cmd_report(i, rec_argv);
+	free(rec_argv);
+	return ret;
 }
 
 static int
 __cmd_buildid_list(const char *file_name, int argc, const char **argv)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
 
 	rec_argc = argc + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	if (!rec_argv)
+		return -ENOMEM;
+
 	rec_argv[i++] = strdup("buildid-list");
 	rec_argv[i++] = strdup("-i");
 	rec_argv[i++] = strdup(file_name);
@@ -2051,7 +2066,9 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_buildid_list(i, rec_argv);
+	ret = cmd_buildid_list(i, rec_argv);
+	free(rec_argv);
+	return ret;
 }
 
 int cmd_kvm(int argc, const char **argv)
-- 
2.34.1

