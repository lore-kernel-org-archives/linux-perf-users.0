Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3F1465BB;
	Tue,  4 Jun 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511598; cv=none; b=jsgveJXw2jemEjHX1CD4bOv4bNS4e79fFIdFN90ju+tOxtJVGvfIkG3LysayuVZvQeoLCL3uVXd0f6HR5I19eKQofREetT5tc4tEft+O02rPUzPEQ4y037EGquE7Kj/KEH+bB7kI8QPfxXNwm4tYcYzvrhgO30C7NBawbUrxZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511598; c=relaxed/simple;
	bh=y7xNLn9XuqoEgeGbYseeZwudJQLOaoFCJmiHnIB8mBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTlVjO1P1/CkXAMwvar94BNx8wU7q/4qL7BeBKlxqkprud8VKxefLdAJzb51S1DRy/a2ZdhlbsGgQKLWs41BXpNrqjqehZJD9H6SSi+kK56wvbYyrqidRlrQ5MIE2H+fYEIuRDZn3MzLa535OrMOHh+4wbZhdR0nw8NvWK5v1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2786E1474;
	Tue,  4 Jun 2024 07:33:41 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4CD43F64C;
	Tue,  4 Jun 2024 07:33:13 -0700 (PDT)
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
Subject: [PATCH v2 15/16] coresight: Re-emit trace IDs when the sink changes in per-thread mode
Date: Tue,  4 Jun 2024 15:30:24 +0100
Message-Id: <20240604143030.519906-16-james.clark@arm.com>
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

In per-cpu mode there are multiple aux buffers and each one has a
fixed sink, so the hw ID mappings which only need to be emitted once
for each buffer, even with the new per-sink trace ID pools.

But in per-thread mode there is only a single buffer which can be
written to from any sink with now potentially overlapping trace IDs, so
hw ID mappings need to be re-emitted every time the sink changes.

This will require a change in Perf to track this so it knows which
decode tree to use for each segment of the buffer. In theory it's also
possible to look at the CPU ID on the AUX records, but this is more
consistent with the existing system, and allows for correct decode using
either mechanism.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 14 ++++++++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 17cafa1a7f18..b6f505b50e67 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -499,6 +499,20 @@ static void etm_event_start(struct perf_event *event, int flags)
 				      &sink->perf_sink_id_map))
 		goto fail_disable_path;
 
+	/*
+	 * In per-cpu mode there are multiple aux buffers and each one has a
+	 * fixed sink, so the hw ID mappings which only need to be emitted once
+	 * for each buffer.
+	 *
+	 * But in per-thread mode there is only a single buffer which can be
+	 * written to from any sink with potentially overlapping trace IDs, so
+	 * hw ID mappings need to be re-emitted every time the sink changes.
+	 */
+	if (event->cpu == -1 && event_data->last_sink_hwid != sink) {
+		cpumask_clear(&event_data->aux_hwid_done);
+		event_data->last_sink_hwid = sink;
+	}
+
 	/*
 	 * output cpu / trace ID in perf record, once for the lifetime
 	 * of the event.
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 744531158d6b..bd4553b2a1ec 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -52,6 +52,7 @@ struct etm_filters {
  * @snk_config:		The sink configuration.
  * @cfg_hash:		The hash id of any coresight config selected.
  * @path:		An array of path, each slot for one CPU.
+ * @last_sink_hwid:	Last sink that a hwid was emitted for.
  */
 struct etm_event_data {
 	struct work_struct work;
@@ -60,6 +61,7 @@ struct etm_event_data {
 	void *snk_config;
 	u32 cfg_hash;
 	struct list_head * __percpu *path;
+	struct coresight_device *last_sink_hwid;
 };
 
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
-- 
2.34.1

