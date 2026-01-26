Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8ED32ED58
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430924; cv=none; b=q0f1fJ4rc4S6dj5FpRCySMZxT0wW00Cjx4yM/ztgvCXIRrcax4P9bEP59lMWPvLoN57eAs+x/oT4EejTMs2DIYHnwv7c2qnX8FdBO8mUO5FntNyJNQ93aDwJsQw4WP21aaKQVnlqzzF24XWbQlCuDHPG52UwMow0PxPGBRC37FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430924; c=relaxed/simple;
	bh=DYlf4y4D1NoS0f/57EKWvSrS/t6sZ0RvMp+VO8R9j/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogsGAEHwTH7jD7jDnET45Jrd0jM8+e4uPEQaZPkjS3rG3gf0jyXOH8BpVQcKfSL9l+JVVtXhe/j4prkWZF8EKzhOHzolZHjvhGPhTNmxoNMV9AGdeMIxT4wygWYFjtVi2mVfyGsgH07IWnwm+119mdZfCOI2NxYOODWTic4Opyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gkXtVwke; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gkXtVwke"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=361jl3ZBvPce/bZFSyo9F3iPIRY3ChB06KKYWGi1P08=;
	b=gkXtVwkesS1P2D2hVqSMKXMD55Dhaypv5o5ehoLZ3vXTu82yrNUDJPWNFfISxN+TnIl1buG9f
	BOgU4GFk1hb/44Vdv9LNBqYouApYmGPDPHjdPHJsyHLqJY42PKJkB3qj0K6QQpdhU6qG7RVjupV
	GVUvp3eG6tFnSGi8bZT/H0o=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f07Ff0zPxz1prMx;
	Mon, 26 Jan 2026 20:31:50 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id DD55E40571;
	Mon, 26 Jan 2026 20:35:18 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 20:35:18 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 20:35:17 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<john.g.garry@oracle.com>, <Jonathan.Cameron@huawei.com>,
	<shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH 3/7] perf-x86: iostat: Change iostat_prefix() to static
Date: Mon, 26 Jan 2026 20:35:10 +0800
Message-ID: <20260126123514.3238425-4-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260126123514.3238425-1-wangyushan12@huawei.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Change iostat_probe() to static function since it is not used outside.

Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/arch/x86/util/iostat.c | 44 +++++++++++++++----------------
 tools/perf/util/iostat.c          |  7 -----
 tools/perf/util/iostat.h          |  2 --
 3 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 7442a2cd87ed..83be505955c8 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -332,6 +332,28 @@ static int iostat_event_group(struct evlist *evl,
 	return ret;
 }
 
+static void iostat_prefix(struct evlist *evlist,
+		   struct perf_stat_config *config,
+		   char *prefix, struct timespec *ts)
+{
+	struct iio_root_port *rp = evlist->selected->priv;
+
+	if (rp) {
+		/*
+		 * TODO: This is the incorrect format in JSON mode.
+		 *       See prepare_timestamp()
+		 */
+		if (ts)
+			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
+				ts->tv_sec, ts->tv_nsec,
+				config->csv_sep, rp->domain, rp->bus,
+				config->csv_sep);
+		else
+			sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
+				config->csv_sep);
+	}
+}
+
 int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config)
 {
 	if (evlist->core.nr_entries > 0) {
@@ -396,28 +418,6 @@ void iostat_release(struct evlist *evlist)
 	}
 }
 
-void iostat_prefix(struct evlist *evlist,
-		   struct perf_stat_config *config,
-		   char *prefix, struct timespec *ts)
-{
-	struct iio_root_port *rp = evlist->selected->priv;
-
-	if (rp) {
-		/*
-		 * TODO: This is the incorrect format in JSON mode.
-		 *       See prepare_timestamp()
-		 */
-		if (ts)
-			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
-				ts->tv_sec, ts->tv_nsec,
-				config->csv_sep, rp->domain, rp->bus,
-				config->csv_sep);
-		else
-			sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
-				config->csv_sep);
-	}
-}
-
 void iostat_print_header_prefix(struct perf_stat_config *config)
 {
 	if (config->csv_output)
diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
index b770bd473af7..a68ab100780d 100644
--- a/tools/perf/util/iostat.c
+++ b/tools/perf/util/iostat.c
@@ -37,13 +37,6 @@ __weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
 {
 }
 
-__weak void iostat_prefix(struct evlist *evlist __maybe_unused,
-			  struct perf_stat_config *config __maybe_unused,
-			  char *prefix __maybe_unused,
-			  struct timespec *ts __maybe_unused)
-{
-}
-
 __weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
 				  struct perf_stat_config *config __maybe_unused,
 				  struct timespec *ts __maybe_unused,
diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
index a4e7299c5c2f..820930a096d9 100644
--- a/tools/perf/util/iostat.h
+++ b/tools/perf/util/iostat.h
@@ -35,8 +35,6 @@ int iostat_parse(const struct option *opt, const char *str,
 		 int unset __maybe_unused);
 void iostat_list(struct evlist *evlist, struct perf_stat_config *config);
 void iostat_release(struct evlist *evlist);
-void iostat_prefix(struct evlist *evlist, struct perf_stat_config *config,
-		   char *prefix, struct timespec *ts);
 void iostat_print_header_prefix(struct perf_stat_config *config);
 void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 			 struct perf_stat_output_ctx *out);
-- 
2.33.0

