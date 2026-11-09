Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185508;
	b=t/zaBrUZxiMukmGa7rUytXdkQzhXnXAvux8S23O3hnxV1utqmLvvXuBi8Dy5fadekong
	 P3l2JD6UbW/W8HeqHYgQs3NyMev5kAiyTDAAL74nmHX/wsi+Kq/wjUxQQQtEfovwwJR2g
	 GxQm71ynDdxZkkYH5q2OfrimKkFLCiMkV+OXgXCAKDKSrNczLKlXUs8bdF6XiMp2772Ps
	 fgkFd5PNNkP+kqdn5lyi+iXHeg4PW4J2gXGduzYoRwK7X1D6k5//z5+DmPenvI9eLzQNf
	 jJJBkvJlUxjuGpUJfg6/+jbNwDuqiONBvWvKLA7yPUQy6gLv3zEDWMVoHFF1uKakvuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185508;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=md4DV7Uq6VE7WZ7howJj84G8xOt7wd8gui73Hd+prt4=;
	b=N2Ry1Da7X9kahjD3O8Sqk6oUSKTNkOUk/OomnYk20gQ4EeqvJ6WenOq7qkn568zQ1/eC
	 j9xOfuIUkHhcasPNPEK2m07FUuUMyvkUt8AbXtYse24X1wuPDJDH0oWcaR99yjP93wwOL
	 /2woWImsGhM7q7skLg8ke6Z4p8cqLXKVVG3hmge1Wbu/oWcpNyezDSVy+X9WKu/Q814l6
	 s/eZFjUcA16sNL1+gsYx03L0YrbR+a8CGNWYqC/9pw9VTtwkhvFklKSCoLMs1hga70k5L
	 47e7cr7kEuHkyOxZGzSQAOnAzp3Cm8lk+O7WkIdAzPHf+bp3HuBqHK0fSix2Ytkxb0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HgpVvV0y;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61495606A322;
	Mon,  9 Nov 2026 00:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61495606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HgpVvV0y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794185507; x=1825721507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70d4DhRMabrnAiAt2CKS7Ue/r14+uvnteF2U7TPnl70=;
  b=HgpVvV0ydBlw09qH7I6Zb/63T/4zp5OSILTUOLHBStS8AADplBqr9mcl
   dG54eV8rsvuEp6YVewzK6v9TZ/vl7v/lhNCksY1jhdKueyGoWuCt5s3r8
   wI7+KJLVZ5IwpvnWkotqbwM0JyoVhZtBLLLySLgc/7Lt3XNRPXejO9Bos
   umhGZEchZZJ9z/ZpJ1eo4lf6IZQqMgy07FpzUUQqt4aIVuyy4jNdH5PqH
   IIgVwxMWJIFETo2GLei/os5wdI7lH6DBPlAyFt/ikVxDfRTDnvCFWMYAt
   DrgUC9LGELl9SyxoJPjJWhTZVNCeZtXqSAeO7xRlrupkE0Z8b8g9E32f+
   w==;
X-CSE-ConnectionGUID: iPombG3YSV2m/NABSm372Q==
X-CSE-MsgGUID: cLglGQM8S4KsiUdAy2tGMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2829548"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2829548"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:51:47 -0800
X-CSE-ConnectionGUID: IG8DUaOYTr+xORzVEZZ9pg==
X-CSE-MsgGUID: /O7aGvcOT1quiDR3bFC43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7874298"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2026 16:51:45 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	kernel test robot <yi1.lai@intel.com>
Subject: [Patch v2 1/5] perf tests: Skip zero sample IP in object-code reading test
Date: Mon,  9 Nov 2026 08:43:58 +0800
Message-Id: <20261109004402.1403713-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel may clear the sample IP to 0 when a user-space address is
expected but a kernel address is sampled due to hardware skid. A zero
sample IP causes the object-code reading test to fail incorrectly.

Skip zero sample IP values in the object-code reading test to avoid
false-positive failures.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202609151503.cb02f753-lkp@intel.com
Fixes: 166f10836a65 ("perf/core: Fix kernel register info leak via hardware skid")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/code-reading.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 130cd6021f93..7b80c4ab6916 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -546,6 +546,11 @@ static int process_sample_event(struct machine *machine, struct evlist *evlist,
 		goto out;
 	}
 
+	if (!sample.ip) {
+		pr_debug("kernel may clear IP to 0 in invalid cases, skip it\n");
+		goto out;
+	}
+
 	thread = machine__findnew_thread(machine, sample.pid, sample.tid);
 	if (!thread) {
 		pr_debug("machine__findnew_thread failed\n");
-- 
2.34.1

