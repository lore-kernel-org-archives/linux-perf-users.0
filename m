Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1859164;
	Wed, 22 May 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716348964; cv=none; b=LSSvbLQrV7MKNTZ9BKlZh+2cWdkEAHkWERJEI53Y1Rbc72y92EkbA0FenhZS46VxU8Vyt+uXMiBjrVdkAIBq9jOfdxQaz+m5Vx7iUMuVk+orEAYc+WOtDeptE+i60WyXIa2wFtlNPUcw2L0dhMze4hJc4Qib8jxFbk9fc56ySKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716348964; c=relaxed/simple;
	bh=sjpKKp9DX4G/NY3q5VzNPZB2bVHY8cy8J+6ci3Tf/JA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RcxlR3G8qmwk7KzX0bqey31CTOH5VfxWbfXbhSYpk/Bq16AoFNm7AfNsJrKscc5NMzUNAMFwY8Mc/A4jGqbwS4mNQZT5J+bUC0HcBLuLLvDnamktY9rGlE14JKJ/ak991GVdpWP0NAYPtB+inx+oatGkA66wZadMUoM8foeZB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VkcLV44GRzxPfR;
	Wed, 22 May 2024 11:32:18 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id A783F140382;
	Wed, 22 May 2024 11:35:59 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 22 May 2024 11:35:58 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [RESEND PATCH v3 0/2] Always show mmap prot even though PROT_NONE
Date: Wed, 22 May 2024 11:35:40 +0800
Message-ID: <20240522033542.1359421-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Before: PROT_NONE is not shown for prot 0.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2979231 syscalls:sys_enter_mmap(len: 4220888, flags: PRIVATE|ANONYMOUS)

After: PROT_NONE is displayed.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2975708 syscalls:sys_enter_mmap(len: 4220888, prot: NONE, flags: PRIVATE|ANONYMOUS)

Changbin Du (2):
  perf trace beauty: Always show param if show_zero is set
  perf trace beauty: Always show mmap prot even though PROT_NONE

 tools/perf/builtin-trace.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

-- 
2.34.1

