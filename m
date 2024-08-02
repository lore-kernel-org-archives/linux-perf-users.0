Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7E13634B;
	Fri,  2 Aug 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622156; cv=none; b=MI5dNSRe4w11VD6LLt+z+YG3s5n894hIxgBIn2wfThZgQA9kaz50Id6k1KyCiQlxaW4T/nNMZwxbI3oLZvUes5jxNZe3cHUTfVM6GjULXxXzFuAycaYOGpSaleBgDl6TUi1E1PQs7QDqOSEnVXApBD2bRxe9FQjRx86HKWtBT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622156; c=relaxed/simple;
	bh=661HsJSYUSjLBHgbOmJlKx/oaAEcvLmKUqv7JMQThtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNGeI8zStoQxzbxOQH3zTRk/u2E7gnpyOxwTpFaQxPGsAbkiSBlf/pncIKDrBLWj9kEkvkHarV0B4cowXWL+ERrIFTFu/NBvlAnIOvHyyowkiBW3zX8HXv45IY6LV6DixGHqoTF0U6jLs95i5yshu6PNVpm0Kz+b9xAg3Ug648U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sadPMPVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sadPMPVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5896BC32782;
	Fri,  2 Aug 2024 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622155;
	bh=661HsJSYUSjLBHgbOmJlKx/oaAEcvLmKUqv7JMQThtY=;
	h=From:To:Cc:Subject:Date:From;
	b=sadPMPVHueVSeZ3h2ZrlIDd5Gaul3jfYZ48eBOyahzVv7uEjDqaUtDosUjU1KeDyW
	 WKMFtSA0GU4aYDRxLQHMn4f2QS11mjPX/WNQnMdPgF/o9mIJcVtep1Cu7ww9rigvjn
	 oac9fG3eUwWLDw0TT7jnTh/SqCU/s0oKthbiu3vesBGorPdu9YEgzfJizDCzqrBZWP
	 jO3Ty7pyOvfSsAfD6T9uE5c7YDiM1Y9Fzl0Xx/0VtULocQKGdYhSNPQYidDmsnjX3l
	 QGrAQtQ9DD6P6LNYtj5ucKvHIq1xLvzF1A4xePlSdmoP7gMLvYiQQ0TxdyTUWdF6ry
	 UCqFJKgpJCtPw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH] perf mem: Update documentation for new options
Date: Fri,  2 Aug 2024 11:09:13 -0700
Message-ID: <20240802180913.1023886-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a common options section and move some items to the section.  Also
add description of new options to report options.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-mem.txt | 94 ++++++++++++++++++---------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 47456b212e99..8a1bd9ff0f86 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -28,15 +28,8 @@ and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
 Due to the statistical nature of SPE sampling, not every memory operation will
 be sampled.
 
-OPTIONS
--------
-<command>...::
-	Any command you can specify in a shell.
-
--i::
---input=<file>::
-	Input file name.
-
+COMMON OPTIONS
+--------------
 -f::
 --force::
 	Don't do ownership validation
@@ -45,24 +38,9 @@ OPTIONS
 --type=<type>::
 	Select the memory operation type: load or store (default: load,store)
 
--D::
---dump-raw-samples::
-	Dump the raw decoded samples on the screen in a format that is easy to parse with
-	one sample per line.
-
--x::
---field-separator=<separator>::
-	Specify the field separator used when dump raw samples (-D option). By default,
-	The separator is the space character.
-
--C::
---cpu=<cpu>::
-	Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
-        comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default
-        is to monitor all CPUS.
--U::
---hide-unresolved::
-	Only display entries resolved to a symbol.
+-v::
+--verbose::
+	Be more verbose (show counter open errors, etc)
 
 -p::
 --phys-data::
@@ -73,6 +51,9 @@ OPTIONS
 
 RECORD OPTIONS
 --------------
+<command>...::
+	Any command you can specify in a shell.
+
 -e::
 --event <event>::
 	Event selector. Use 'perf mem record -e list' to list available events.
@@ -85,14 +66,65 @@ RECORD OPTIONS
 --all-user::
 	Configure all used events to run in user space.
 
--v::
---verbose::
-	Be more verbose (show counter open errors, etc)
-
 --ldlat <n>::
 	Specify desired latency for loads event. Supported on Intel and Arm64
 	processors only. Ignored on other archs.
 
+REPORT OPTIONS
+--------------
+-i::
+--input=<file>::
+	Input file name.
+
+-C::
+--cpu=<cpu>::
+	Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
+        comma-separated list with no space: 0,1. Ranges of CPUs are specified with -
+	like 0-2. Default is to monitor all CPUS.
+
+-D::
+--dump-raw-samples::
+	Dump the raw decoded samples on the screen in a format that is easy to parse with
+	one sample per line.
+
+-s::
+--sort=<key>::
+	Group result by given key(s) - multiple keys can be specified
+	in CSV format.  The keys are specific to memory samples are:
+	symbol_daddr, symbol_iaddr, dso_daddr, locked, tlb, mem, snoop,
+	dcacheline, phys_daddr, data_page_size, blocked.
+
+	- symbol_daddr: name of data symbol being executed on at the time of sample
+	- symbol_iaddr: name of code symbol being executed on at the time of sample
+	- dso_daddr: name of library or module containing the data being executed
+	             on at the time of the sample
+	- locked: whether the bus was locked at the time of the sample
+	- tlb: type of tlb access for the data at the time of the sample
+	- mem: type of memory access for the data at the time of the sample
+	- snoop: type of snoop (if any) for the data at the time of the sample
+	- dcacheline: the cacheline the data address is on at the time of the sample
+	- phys_daddr: physical address of data being executed on at the time of sample
+	- data_page_size: the data page size of data being executed on at the time of sample
+	- blocked: reason of blocked load access for the data at the time of the sample
+
+	And the default sort keys are changed to local_weight, mem, sym, dso,
+	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, local_ins_lat.
+
+-T::
+--type-profile::
+	Show data-type profile result instead of code symbols.  This requires
+	the debug information and it will change the default sort keys to:
+	mem, snoop, tlb, type.
+
+-U::
+--hide-unresolved::
+	Only display entries resolved to a symbol.
+
+-x::
+--field-separator=<separator>::
+	Specify the field separator used when dump raw samples (-D option). By default,
+	The separator is the space character.
+
 In addition, for report all perf report options are valid, and for record
 all perf record options.
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog

