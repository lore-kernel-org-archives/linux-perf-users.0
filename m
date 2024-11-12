Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B1201270;
	Tue, 12 Nov 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435151; cv=none; b=Qvwr3uRXzGcr0NPAPGptLP5xEDDuTLCSUKtYy9OJAZ8sH+hwNfpmMXTXOQ927kdlW1Skc4Uti9VTcmZk6d8IKrm+Q80GH8zylVDKqg+ONu1a5i5Iy2G27Qvpp39wsx3BHnyFQlNAHYpvB0V0eXQtXklKCiwyMLkSdNPn4TiMk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435151; c=relaxed/simple;
	bh=mnFCwIumAaetpb3TtoRkP+X2pbNFYvGrJF9fQc2iPcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StOtWGS4ycz8PF3Rk9NSBwgrk+i/LgbtBzpvrVNYyg7+e8PughEMvT6V5EY81Ja/UYvggCmFRDhl0HD2KOIz7WEPHcts3XR3TPvkVmUXesgLcSKAqejmJk+Vvo4zJnMXkZ1Q5nLg5L1SlCdJT53ABcoIKpLmzvpLh6cg+bSGYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFj21LSh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFj21LSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38563C4CED5;
	Tue, 12 Nov 2024 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435150;
	bh=mnFCwIumAaetpb3TtoRkP+X2pbNFYvGrJF9fQc2iPcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFj21LSh98rfceCXLmFHSSZMufnMUQxT7Gkr5cKMmUSKnAZUvBkyv8uN8TqG5oFxc
	 NuO5eCZ/tLZEU8hdXUzbqbm770BwvkuFuUvAcFo2DmsjzVOiYlNrkuX0/FOpBTcaHR
	 PZRfiB6tlrfGurHwo0Dg4T5DfqeHNF8pC+poHOr4D+lhG75oZfk17679PLnJlaswlK
	 igwYSazv/0E1ugTWlpreLtPTQHzqHO3sEursAxGBvzdLQEnBmCVhVksPTWqaCSgM46
	 YlkyX4uEStd8fVROUHN9IFHYj008vjvo3Jngvb+Tkhdd8mCtOufHfAPHKuTzy9cFPW
	 4cissFAz06nog==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/4] perf ftrace latency: Pass ftrace pointer to histogram routines to pass more args
Date: Tue, 12 Nov 2024 15:12:11 -0300
Message-ID: <20241112181214.1171244-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112181214.1171244-1-acme@kernel.org>
References: <20241112181214.1171244-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The ftrace->use_nsec arg is being passed to both make_historgram() and
display_histogram(), since another ftrace field will be passed to those
functions in a followup patch, make them look like other functions in
this codebase that receive the 'struct perf_ftrace' pointer.

No change in logic.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 272d3c70810e7dc3..88b9f0597b925c69 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -726,8 +726,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
-static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf,
-			   bool use_nsec)
+static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
+			   char *buf, size_t len, char *linebuf)
 {
 	char *p, *q;
 	char *unit;
@@ -774,7 +774,7 @@ static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf,
 		if (!unit || strncmp(unit, " us", 3))
 			goto next;
 
-		if (use_nsec)
+		if (ftrace->use_nsec)
 			num *= 1000;
 
 		i = log2(num);
@@ -794,8 +794,9 @@ static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf,
 	strcat(linebuf, p);
 }
 
-static void display_histogram(int buckets[], bool use_nsec)
+static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 {
+	bool use_nsec = ftrace->use_nsec;
 	int i;
 	int total = 0;
 	int bar_total = 46;  /* to fit in 80 column */
@@ -951,7 +952,7 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 			if (n < 0)
 				break;
 
-			make_histogram(buckets, buf, n, line, ftrace->use_nsec);
+			make_histogram(ftrace, buckets, buf, n, line);
 		}
 	}
 
@@ -968,12 +969,12 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 		int n = read(trace_fd, buf, sizeof(buf) - 1);
 		if (n <= 0)
 			break;
-		make_histogram(buckets, buf, n, line, ftrace->use_nsec);
+		make_histogram(ftrace, buckets, buf, n, line);
 	}
 
 	read_func_latency(ftrace, buckets);
 
-	display_histogram(buckets, ftrace->use_nsec);
+	display_histogram(ftrace, buckets);
 
 out:
 	close(trace_fd);
-- 
2.47.0

