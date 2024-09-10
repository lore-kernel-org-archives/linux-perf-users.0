Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07C13E02C;
	Tue, 10 Sep 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725939416; cv=none; b=uyRWCKEdMnvQx3d5yafYTNmeacLWnte/LxpxMU/r4+oDUK8sF3/wBWwx3ItFh2XdK8v+kAMItaN4l/redLbfXthnyoDkUrQQI0/niKGsmedyOIkzxLxz5H94sMgUTkpfGwnad1wlQNtLGQ6ZHuzC7wZlQVogWp2M+KGT4+6JwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725939416; c=relaxed/simple;
	bh=Z5ePbuSsncyqtNx1yHiIjf2+UiNeWV1k0vc9OfpkV8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yv7pO2xmlyg3CuCRpq1gGHDJw6icMZZEuDNAwzk58cRR0vqnLZeYMdl2Htl3cGorTpbJusGJR8nBYJVsYWxeb1uY0cotAKcV0CtfnxAfI7FU715pXFX8BAl5OjHfjpZZkkYDx27BfcVtWsQ2G2O6BDMWXENkOsNerfrAxaxe23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X2q885tRRzpVZK;
	Tue, 10 Sep 2024 11:34:48 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id DB1DD18005F;
	Tue, 10 Sep 2024 11:36:49 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 10 Sep 2024 11:36:48 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf ftrace: Detect whether ftrace is enabled on system
Date: Tue, 10 Sep 2024 11:36:25 +0800
Message-ID: <20240910033625.3569729-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100011.china.huawei.com (7.221.188.204)

To make error messages more accurate, this change detects whether ftrace is
enabled on system by checking trace file "set_ftrace_pid".

Before:
~ # perf ftrace
failed to reset ftrace

After:
~ # perf ftrace
ftrace is not supported on this system

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-ftrace.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index eb30c8eca488..e1dc2768bc0f 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1112,6 +1112,24 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	return 0;
 }
 
+static bool is_ftrace_supported(void)
+{
+	char *file;
+	bool supported = false;
+
+	file = get_tracing_file("set_ftrace_pid");
+	if (!file) {
+		pr_debug("cannot get tracing file set_ftrace_pid\n");
+		return false;
+	}
+
+	if (!access(file, F_OK))
+		supported = true;
+
+	put_tracing_file(file);
+	return supported;
+}
+
 enum perf_ftrace_subcommand {
 	PERF_FTRACE_NONE,
 	PERF_FTRACE_TRACE,
@@ -1254,6 +1272,12 @@ int cmd_ftrace(int argc, const char **argv)
 		goto out_delete_filters;
 	}
 
+	if (!is_ftrace_supported()) {
+		pr_err("ftrace is not supported on this system\n");
+		ret = -ENOTSUP;
+		goto out_delete_filters;
+	}
+
 	ret = target__validate(&ftrace.target);
 	if (ret) {
 		char errbuf[512];
-- 
2.34.1

