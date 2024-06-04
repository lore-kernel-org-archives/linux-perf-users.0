Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C8C147;
	Tue,  4 Jun 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511495; cv=none; b=p0IH9/0509gbemaP1kh0s6Q/5KrZYw+oEWCZIUmAY2+a7QJ5XPn6n73kzqoZccobV+5HCMJsj3tHqE5pQ6i/qaHymhHzZz/g7kAgi2nQuMy9qlDiIFwJr89wvQGLhIGVMEizQhyRmhtrNyVXO6TVOshPcToCDGKjByfyeWlArdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511495; c=relaxed/simple;
	bh=1Za128McDTF/C8ZV/bPj12q2cashQOnFU9fLRV2wwQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdzDkgHNOAqiKc5PjNJFVc84UQRYJGh2xJhIvF1MbDWfDGR92tqMV8xdqOVFV4qtE1G2nkdS3EDa9OSJ3iLz2+kzEweTygO/1Jij+KZv763Furh84ulp1uUXLvVx/v00yYVshUKwmRM809l2k9reRH6sb/d47MmiFJ+NfJUTEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4700F1042;
	Tue,  4 Jun 2024 07:31:58 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7F403F64C;
	Tue,  4 Jun 2024 07:31:30 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 02/16] perf auxtrace: Allow number of queues to be specified
Date: Tue,  4 Jun 2024 15:30:11 +0100
Message-Id: <20240604143030.519906-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604143030.519906-1-james.clark@arm.com>
References: <20240604143030.519906-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it's only possible to initialize with the default number of
queues and then use auxtrace_queues__add_event() to grow the array. But
that's problematic if you don't have a real event to pass into that
function yet.

The queues hold a void *priv member to store custom state, and for
Coresight we want to create decoders upfront before receiving data, so
add a new function that allows pre-allocating queues. One reason to do
this is because we might need to store metadata (HW_ID events) that
effects other queues, but never actually receive auxtrace data on that
queue.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/auxtrace.c | 9 +++++++--
 tools/perf/util/auxtrace.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3684e6009b63..563b6c4fca31 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -218,15 +218,20 @@ static struct auxtrace_queue *auxtrace_alloc_queue_array(unsigned int nr_queues)
 	return queue_array;
 }
 
-int auxtrace_queues__init(struct auxtrace_queues *queues)
+int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues)
 {
-	queues->nr_queues = AUXTRACE_INIT_NR_QUEUES;
+	queues->nr_queues = nr_queues;
 	queues->queue_array = auxtrace_alloc_queue_array(queues->nr_queues);
 	if (!queues->queue_array)
 		return -ENOMEM;
 	return 0;
 }
 
+int auxtrace_queues__init(struct auxtrace_queues *queues)
+{
+	return auxtrace_queues__init_nr(queues, AUXTRACE_INIT_NR_QUEUES);
+}
+
 static int auxtrace_queues__grow(struct auxtrace_queues *queues,
 				 unsigned int new_nr_queues)
 {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 55702215a82d..8a6ec9565835 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -521,6 +521,7 @@ int auxtrace_mmap__read_snapshot(struct mmap *map,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size);
 
+int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues);
 int auxtrace_queues__init(struct auxtrace_queues *queues);
 int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       struct perf_session *session,
-- 
2.34.1

