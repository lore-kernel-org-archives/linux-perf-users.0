Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285311798C;
	Sat, 10 Aug 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723306577; cv=none; b=BCGmQcKxC4cqcbDH2ZjDKZIBwgU3ayfA7l1DQOhJJbGvpIKwIyAiQ0F6gZCAJyf8VEuVmXEaBTdSrCwLrmbloP7kqj0vq/YaSdDEwwXzSF5f+zEVlRhuTGQTAHZaUUTPDXiqGmC6sNUIu8pfHvtacG6LB+zBj99dHpw3tG4qAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723306577; c=relaxed/simple;
	bh=D3D32SrpDNrDy4cockWsCqpamN76Db0cd49m73FiSxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bEYXc+H8OCpX/c+iqRiUWvovI9kHLVPXPJ/dIYOOQfKrUlfPyQpfVqfqiqAt/BsPgLJXJZPmhpAFZwAvYmDkISQtns22gumsVZ9WdWlYzdskJZ2f+aePYyEHendYriCLxF5llMH5QFCHNpiC11WKSp4DvC73VrduO4CGr1l16W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65437FEC;
	Sat, 10 Aug 2024 09:16:34 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DF673F71E;
	Sat, 10 Aug 2024 09:16:06 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	james.clark@linaro.org,
	Govindarajan.Mohandoss@arm.com
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf docs: Refine the description for the buffer size
Date: Sat, 10 Aug 2024 17:15:40 +0100
Message-Id: <20240810161540.2282535-1-leo.yan@arm.com>
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
buffer share the same semantics.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-record.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

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
-- 
2.34.1

