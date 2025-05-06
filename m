Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FC265CDF;
	Tue,  6 May 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524962; cv=none; b=GS0s9RO/7aQOJbn855gYwpUvZqEmhJz1mMsCSmMQ6zb3egpNorcrOYaYXzqqt/DCwBeOoHVIJjApgwZHoEGDT67uMNjoztpEYkkQFV0urg2GkR72oXCHFELI3u7+C9l24liJDHnsr57SKt76WB8oAwmpvdkFz9wFUPgLiiYyeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524962; c=relaxed/simple;
	bh=wli3H1iA05utUdiTrcGE9JgEgoGq9bqSBJ+cNt4ftts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WziQMdQNJjHyLBaIien1bq3jdFI9ePv7QYWcA2JLxYQwtKfa8hu3Azm3hdLOaiCGa5RxxKSPQ7+TsFKOHr1w6AmspIPfsULbxeh+tPoivMI4eX3Iacmktgr0dRAdw7q76+xot0VaitqG7UWVvtQzC1UjShkavHZLWgyheR1hlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZsD673dVtz12LXP;
	Tue,  6 May 2025 17:45:35 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id E42C41800B3;
	Tue,  6 May 2025 17:49:10 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 May 2025 17:49:09 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH] x86: pebs: remove redundant assignments to sample.period
Date: Tue, 6 May 2025 17:49:07 +0800
Message-ID: <20250506094907.2724-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The perf_sample_data_init() has already set the period of sample, so no
need to do it again.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 arch/x86/events/intel/ds.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9b20acc0e932..292ef21cbfbd 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1828,8 +1828,6 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 
 	perf_sample_data_init(data, 0, event->hw.last_period);
 
-	data->period = event->hw.last_period;
-
 	/*
 	 * Use latency for weight (only avail with PEBS-LL)
 	 */
@@ -2082,7 +2080,6 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	sample_type = event->attr.sample_type;
 	format_group = basic->format_group;
 	perf_sample_data_init(data, 0, event->hw.last_period);
-	data->period = event->hw.last_period;
 
 	setup_pebs_time(event, data, basic->tsc);
 
-- 
2.43.0

