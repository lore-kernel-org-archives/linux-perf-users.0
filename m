Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD263AB
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jan 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8AxzehSIJll4JkCAA--.832S3;
	Sat, 06 Jan 2024 17:41:38 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxXNxPIJllFXEEAA--.11574S2;
	Sat, 06 Jan 2024 17:41:36 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH] tools/perf: Fix compiler error when using gcc-14.
Date: Sat,  6 Jan 2024 17:41:29 +0800
Message-Id: <20240106094129.3337057-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxXNxPIJllFXEEAA--.11574S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF48Ar45ZF4xAF43Aw17twc_yoW5Cr4fpr
	WkC3srtr1YqF1YywnFyF4jvFW7uws7ZFW5G34Fva1kZw1Skw4xtrWxtFyY9FW7ZF4DJw1a
	ywn5Wry8tw4kJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

From: Sun Haiyong <sunhaiyong@loongson.cn>

the definition of calloc is as follows:
    void *calloc(size_t nmemb, size_t size);
number of members is in the first parameter and the size is in the second
parameter.

fixed error message on the gcc 14 20240102:
error: 'calloc' sizes specified with 'sizeof' in the earlier argument and
not in the later argument [-Werror=calloc-transposed-args]

Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/perf/builtin-record.c        | 4 ++--
 tools/perf/util/hist.c             | 4 ++--
 tools/perf/util/metricgroup.c      | 2 +-
 tools/perf/util/synthetic-events.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 91e6828c38cc..86c910125172 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4080,8 +4080,8 @@ int cmd_record(int argc, const char **argv)
 	}
 
 	if (rec->switch_output.num_files) {
-		rec->switch_output.filenames = calloc(sizeof(char *),
-						      rec->switch_output.num_files);
+		rec->switch_output.filenames = calloc(rec->switch_output.num_files,
+						      sizeof(char *));
 		if (!rec->switch_output.filenames) {
 			err = -EINVAL;
 			goto out_opts;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0888b7163b7c..fa359180ebf8 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -491,8 +491,8 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 
 	if (symbol_conf.res_sample) {
-		he->res_samples = calloc(sizeof(struct res_sample),
-					symbol_conf.res_sample);
+		he->res_samples = calloc(symbol_conf.res_sample,
+					sizeof(struct res_sample));
 		if (!he->res_samples)
 			goto err_srcline;
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ca3e0404f187..966cca5a3e88 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -286,7 +286,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
 
-	metric_events = calloc(sizeof(void *), ids_size + 1);
+	metric_events = calloc(ids_size + 1, sizeof(void *));
 	if (!metric_events)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3712186353fb..2a0289c14959 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1055,11 +1055,11 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 	if (thread_nr > n)
 		thread_nr = n;
 
-	synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
+	synthesize_threads = calloc(thread_nr, sizeof(pthread_t));
 	if (synthesize_threads == NULL)
 		goto free_dirent;
 
-	args = calloc(sizeof(*args), thread_nr);
+	args = calloc(thread_nr, sizeof(*args));
 	if (args == NULL)
 		goto free_threads;
 
-- 
2.31.4

