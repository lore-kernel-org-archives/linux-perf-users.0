Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB27EEFD;
	Wed, 11 Sep 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048920; cv=none; b=MyRgoAPmy8m+rNcpcugak4riU50ZrS3ujDYTLEafQg/jvlRgwPT6E11mf5rJuyfUuB70i+BGvEujWsSVIJrAQxXPgPBedalbb/35BzMj2NOhK4BJexgGF3qkt5tLBxueuL/RfWh8laLeiFhUP0sMhGieDnlwu/90rwqAKWa4ViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048920; c=relaxed/simple;
	bh=UE0KjRZuEn9CBgYcJ8bjJcQoFjDrcUC81utne6Te6YY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0o5f6cCu/Fn91YKaURk+B/XzScLBXJ5lw6ngmh1K0Tpvw0FPlHALKwzS5aiAN5fqw4OjZ130uq+S5N1zEGdahdEDY15deQmS4WcVPgVWF8ARLBhKvBkH6rA97cfvNCo+OD/bWpLICosVIutdSCi0pNA2ihrCZaKMil9yAsws34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X3bgg6brbz1SB81;
	Wed, 11 Sep 2024 18:01:19 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id C580E180042;
	Wed, 11 Sep 2024 18:01:49 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 11 Sep 2024 18:01:48 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2] perf ftrace: Detect whether ftrace is enabled on system
Date: Wed, 11 Sep 2024 18:01:26 +0800
Message-ID: <20240911100126.900779-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

v2: rebase on perf-tools-next.
---
 tools/perf/builtin-ftrace.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 88a87bf387d2..abcdc49b7a98 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -80,6 +80,24 @@ static bool check_ftrace_capable(void)
 	return false;
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
 static int __write_tracing_file(const char *name, const char *val, bool append)
 {
 	char *file;
@@ -1583,6 +1601,11 @@ int cmd_ftrace(int argc, const char **argv)
 	if (!check_ftrace_capable())
 		return -1;
 
+	if (!is_ftrace_supported()) {
+		pr_err("ftrace is not supported on this system\n");
+		return -ENOTSUP;
+	}
+
 	ret = perf_config(perf_ftrace_config, &ftrace);
 	if (ret < 0)
 		return -1;
-- 
2.34.1

