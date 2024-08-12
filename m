Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CC20323;
	Mon, 12 Aug 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455318; cv=none; b=q0gxDMftDHXSSAej8imWvSfkGxX8d1tNYCucoNwJf1scMAfApRBoDvZLLOPxpaCyuyUkA0FkQO6sYe8zNdV0x+FCyQAGu6yl0EQL40gRy/lLEVjt62Dni0jrKpRBeQo3B5A83cHQk17uWFAq2WqdUhOYDkacY/2T1QMMmDFqu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455318; c=relaxed/simple;
	bh=25iON2aOSkv1pwiu6PEitoWSc9We2+COGfPD5yyWuWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vczux81D+27f1US83l/AjgTlt5XYY52oEENExCpg2Apzb8HqhvfPFl59f95/62OoysEBzHodPYivSqsWpZEbHd7nPQbrx5okw59Gvzw7pwaYoa1cbV4IMaZY4wEpwCbKiE9pLjVzOy4/CbN2I3wEK3HOVplL9NNftIecM+UYr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4192FEC;
	Mon, 12 Aug 2024 02:35:40 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 975E83F73B;
	Mon, 12 Aug 2024 02:35:13 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2] perf docs: Refine the description for the buffer size
Date: Mon, 12 Aug 2024 10:34:59 +0100
Message-Id: <20240812093459.2575278-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current description for the AUX trace buffer size is misleading. When a
user specifies the option '-m,512M', it represents a size value in bytes
(512MiB) but not 512M pages (512M x 4KiB regard to a page of 4KiB).

Make the document clear that the normal buffer and the AUX tracing
buffer share the same semantics. Syncs the documents for consistent
text.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---

Changes from v1:
 Synced for all documents for consistent description (James)

 tools/perf/Documentation/perf-kvm.txt    | 6 +++---
 tools/perf/Documentation/perf-record.txt | 9 +++++----
 tools/perf/Documentation/perf-top.txt    | 4 ++--
 tools/perf/Documentation/perf-trace.txt  | 4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index b66be66fe836..c26524d38f47 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -115,9 +115,9 @@ STAT LIVE OPTIONS
 
 -m::
 --mmap-pages=::
-    Number of mmap data pages (must be a power of two) or size
-    specification with appended unit character - B/K/M/G. The
-    size is rounded up to have nearest pages power of two value.
+        Number of mmap data pages (must be a power of two) or size
+        specification in bytes with appended unit character - B/K/M/G.
+        The size is rounded up to the nearest power-of-two page value.
 
 -a::
 --all-cpus::
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 41e36b4dc765..242223240a08 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -273,10 +273,11 @@ OPTIONS
 -m::
 --mmap-pages=::
 	Number of mmap data pages (must be a power of two) or size
-	specification with appended unit character - B/K/M/G. The
-	size is rounded up to have nearest pages power of two value.
-	Also, by adding a comma, the number of mmap pages for AUX
-	area tracing can be specified.
+	specification in bytes with appended unit character - B/K/M/G.
+	The size is rounded up to the nearest power-of-two page value.
+	By adding a comma, an additional parameter with the same
+	semantics used for the normal mmap areas can be specified for
+	AUX tracing area.
 
 -g::
 	Enables call-graph (stack chain/backtrace) recording for both
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 667e5102075e..af3e4230c72f 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -83,8 +83,8 @@ Default is to monitor all CPUS.
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
-	specification with appended unit character - B/K/M/G. The
-	size is rounded up to have nearest pages power of two value.
+	specification in bytes with appended unit character - B/K/M/G.
+	The size is rounded up to the nearest power-of-two page value.
 
 -p <pid>::
 --pid=<pid>::
diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index f0da8cf63e9a..6e0cc50bbc13 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -106,8 +106,8 @@ filter out the startup phase of the program, which is often very different.
 -m::
 --mmap-pages=::
 	Number of mmap data pages (must be a power of two) or size
-	specification with appended unit character - B/K/M/G. The
-	size is rounded up to have nearest pages power of two value.
+	specification in bytes with appended unit character - B/K/M/G.
+	The size is rounded up to the nearest power-of-two page value.
 
 -C::
 --cpu::
-- 
2.34.1

