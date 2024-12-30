Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23245158858;
	Mon, 30 Dec 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735542690; cv=none; b=DiLmXnP1YWDBDu7dHk5lWI9P1LX0r5xjJFj16gWJasf173Kn2EGR86IXLj49VIl82hVXq9FzUoy0/d2DTdYiC7ayHXwiubxA9TNBWQAJ4FQnPWlVW8HV1yJnZlg7YwsNqCoqhaRjjCP54uytaRCrFh67cdZvGu9R9GngoloIe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735542690; c=relaxed/simple;
	bh=srwxXHJ6dqrMzEVJaJ81BHBRHrIWWX5P/aPY6vFfFos=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LoUW88R7NDyJDX4j3N9njoDPxCuNlXVlMc8JPmd4tCztJ/IExra+HypkJINhN/Od1O7NNiDhgoJdl90emhoASL6LoKB8YBZu0HWZd025LIabwUFsdn1oWi5ikZdQPNZouQr53IHWlOL+v97C0mxqcGiVfXAOIY8o785Iw7qzQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VNFPgdkw; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VNFPgdkw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735542679; h=From:To:Subject:Date:Message-Id;
	bh=+u9xGx6TvKuIWPpFjWiwC86W0KToY2v21bBV3957iZM=;
	b=VNFPgdkwHLV+UFX69ERbqK5/myBRu3Hvr3rhT8ee4hVDqSGO+iT0BquxseQ7ydMphRYDvYdJxIDFQQ8b440pyFBrUMH5O2UvWRkIPJvRhcSLZaDFQHa9y+b6TOFImWdRxbEQszvaDn8uoz98Co4JEaH1IwU36Oe/5r9yfDMQ2P4=
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WMU8jk2_1735542674 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Dec 2024 15:11:19 +0800
From: Jing Zhang <renyu.zj@linux.alibaba.com>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Fix the lack of ch_mask format for SPR
Date: Mon, 30 Dec 2024 15:11:12 +0800
Message-Id: <1735542672-113067-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL event
because of lack of ch_mask format in drivers, and perf test "104: perf
all PMU test (exclusive)" failed.

$perf stat -e perf stat -e UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
sleep 1

Initial error:
event syntax error: 'UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL'
                                \___ unknown term 'ch_mask' for pmu 'uncore_cha_0'

104: perf all PMU test (exclusive)                                   : FAILED!

Add ch_mask format for SPR to fix it.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ca98744..e537623 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5967,6 +5967,7 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
 	&format_attr_inv.attr,
 	&format_attr_thresh8.attr,
 	&format_attr_filter_tid5.attr,
+	&format_attr_ch_mask.attr,
 	NULL,
 };
 static const struct attribute_group spr_uncore_chabox_format_group = {
-- 
1.8.3.1

