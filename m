Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D55A4C9
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Mar 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641237; cv=none; b=gbCH1BuhLqh9p/9ngQLQ8+o/0Mg1JxR19M4W6doDfTDOiWYlVtEjWJVmbWX2J3aoblM2g/CXZLz4mIJEYi1GGVZejwvYxAD/MCwrFEExUxOJbo5qHLUQEeZVUDyKypwyPY4xDacKa7AQuHbXBJwH1ND2wxFpXTD3gGpV0kbKtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641237; c=relaxed/simple;
	bh=gERqFyVIZ0ok10zI/NbW8mp+jooEwAimGGK020xNwzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWRNiBh4CHr/6KybdzjVd47euwEgzaiUnNPLflknKHDA84fkzvkYPMBtKdwbKpLgyqC/PNLX8InGYdqWX+7kOEPbv7QhjwbVIBqoSmk67lRo/0hC5o6ypSzON+aadMRIXgiinnFcqrM1Ewm8cx9TLD/GVFVI9OlP+1rykSgFHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 425C6UBR024255
	for <linux-perf-users@vger.kernel.org>; Tue, 5 Mar 2024 20:06:30 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 425C5Vpx023254;
	Tue, 5 Mar 2024 20:05:31 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Mar 2024
 20:05:26 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <dylan@andestech.com>, <tim609@andestech.com>,
        Ben Zong-You Xie
	<ben717@andestech.com>
Subject: [PATCH 0/2] Fix the warnings in the 32-bit platform
Date: Tue, 5 Mar 2024 20:04:59 +0800
Message-ID: <20240305120501.1785084-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 425C6UBR024255

This series fix two incompatible type warnings when building perf in the 
32-bit platform. 

Ben Zong-You Xie (2):
  perf daemon: Fix the warning about time_t
  perf riscv: Fix the warning due to the incompatible type

 tools/perf/arch/riscv/util/header.c | 2 +-
 tools/perf/builtin-daemon.c         | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1

