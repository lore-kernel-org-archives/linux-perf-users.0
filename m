Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68033F5BE;
	Thu,  7 May 2026 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135873; cv=none; b=YVDhbncKRfnHcXUr9DAfs2HuX6CO9DEAoiWETc3AjRJd7/XuBLdqSsrPNAs82xAb8J2CRxlbK47EK3OOfgBJs5lTCPEsv3zURvcdJN3RBPzK8GEMMF2bqgXmI5g/3Ug9oaPVWFxjGWahEA/mIAYXry3L3HhctVAK3+f/R/seYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135873; c=relaxed/simple;
	bh=1fdXuaEL7cj+fs1O7LyClBsePDWrL6Fv62mg0gLyK+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpMPRznKB5m8B5wKdZF9UAwv4N8+tZIcMvv+YhTG9TrXnl+vJCnrL9e3bHwkiPP45HC4eblAag98YWBX4msjjcC+HolO7wcozMHRKJ8amy71CqCC9mMvTAfJT22wP2NvhEObAx6xAf60auylS24XAjozqCUZsi1g+CCX88BEPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3i51/4hv; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3i51/4hv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s+UPfLYxep2lFqvQU2QLO+VRgoTiunn3ERhHANe0PMk=;
	b=3i51/4hvx2/B2QTb3i5CkNCcIB6oIuZTRnVX6uzEdhuExpJ6tr5zJgrpZM5ofV7z4xnI6lkur
	O8oGRL7SfM17nPlAqG/QDB7FLSU5lHzay7C8DqznDQzUqFG9mi2kPte+mqVl2+vSEFuaaoZhduj
	YS/3QQ15jXJVwOxzGsW7EOY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gB2Sp57yGz1prPP;
	Thu,  7 May 2026 14:31:06 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 25ACF4056D;
	Thu,  7 May 2026 14:37:41 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 14:37:41 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 14:37:40 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH v2 4/7] perf-x86: iostat: Change iostat_prefix() to static
Date: Thu, 7 May 2026 14:37:34 +0800
Message-ID: <20260507063737.3542950-5-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507063737.3542950-1-wangyushan12@huawei.com>
References: <20260507063737.3542950-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Change iostat_prefix() to static function, since it is not used outside.

Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/util/iostat.c     |  7 ------
 tools/perf/util/iostat.h     |  2 --
 tools/perf/util/x86-iostat.c | 44 ++++++++++++++++++------------------
 3 files changed, 22 insertions(+), 31 deletions(-)

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
diff --git a/tools/perf/util/x86-iostat.c b/tools/perf/util/x86-iostat.c
index 7442a2cd87ed..f8d4c9718594 100644
--- a/tools/perf/util/x86-iostat.c
+++ b/tools/perf/util/x86-iostat.c
@@ -332,6 +332,28 @@ static int iostat_event_group(struct evlist *evl,
 	return ret;
 }
 
+static void iostat_prefix(struct evlist *evlist,
+			  struct perf_stat_config *config,
+			  char *prefix, struct timespec *ts)
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
-- 
2.33.0

