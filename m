Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD893A256C;
	Tue, 24 Mar 2026 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389465; cv=none; b=eeMsdiIAA2Q2wgoTp8NaBcltvx17gnJh0DLMkul3jLr4G2KIWfQvOOjfHqO/IiAnz/m4mVweP6psMAPN4zpVZOBzLrgt7lFLs4SiTfm3D/W9bG0RpQRv0PfCalPDwUoasZRjU1ICvr1wZEee00CWkgeq9S8yl8f+oRX5jg58rwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389465; c=relaxed/simple;
	bh=USGT7ljQpuF1np0/I9D6mFQIxTW50WukqX9A62w/w5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKtwrnfPX9oIWam2CuDKFKDAQawzdIYlRGLG2xt2GeIu+aa4cfsYG3Bxw1lx0MxozAHq0RLZdkDtDpPfTWwPObGjwNwcC+iiTVPZtZvAKS/RGnSMUL05ZCQ7X8I3hOLf21ixaOqFvSPb1N2By3cAw5+53ZxaE0eSBVslHOvfNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEtPUHqj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEtPUHqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774389463; x=1805925463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=USGT7ljQpuF1np0/I9D6mFQIxTW50WukqX9A62w/w5w=;
  b=eEtPUHqjR80NyrHQQp4eN0pIQs3YfNHZP5UcOxSwiEeiDYDmm/PooBSZ
   g6pc5sGAVuCiYplB6QFhlv2HNYl0Pxy0yVMeOU9TkI1EjsZ3FtB1gbnCZ
   xTl+nAaPojD1QYswgZmeta2JlGRpjuTtJstIUYBykWdIXn+wO1XEYbCdt
   bPl0Xv1pf/cF5wDr/EnXmOjcDDWks0Ev5AH8qRXNONdMsb3E3QJ6r0xGJ
   SvX7zCbIgOcc6l4LT8K/gchZsulNRHcc25eZ3a7wlLptaTBbnxnTOmLX/
   t0Wg/jhdzXWU3LnNtAGNybd17ymfLMFUWdv9z6mocT8cO5owY1iDchJTN
   Q==;
X-CSE-ConnectionGUID: hXunU/JQSDmB2CS05CCGrw==
X-CSE-MsgGUID: oFmDihHFRfGmC9y3FP+Ddg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="100866049"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="100866049"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:57:42 -0700
X-CSE-ConnectionGUID: YSxSzdDJQkmtB1Idi2nLCg==
X-CSE-MsgGUID: 1sg4AOAgSJyc/trW4RabvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224496537"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:57:42 -0700
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH V5 0/5] Miscellaneous Intel uncore patches
Date: Tue, 24 Mar 2026 14:49:28 -0700
Message-ID: <20260324214932.10068-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mainly a RESEND of the patch set below.

No code changes since the last posting, except for a minor change in
patch 3.

I grouped these patches together for the convenience of the maintainers
and bumped the whole series to v5.

Changes since v4:
- Remove unused die_id variable from patch 3.

v4:
https://lore.kernel.org/lkml/20260313174050.171704-1-zide.chen@intel.com/

Previous versions:
https://lore.kernel.org/lkml/cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de/T/
https://lore.kernel.org/lkml/20260116031113.45098-1-zide.chen@intel.com/
https://lore.kernel.org/lkml/20260206231203.11760-1-zide.chen@intel.com/

Zide Chen (4):
  perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
  perf/x86/intel/uncore: Skip discovery table for offline dies
  perf/x86/intel/uncore: Fix die ID init and look up bugs
  perf/x86/intel/uncore: Remove extra double quote mark

 arch/x86/events/intel/uncore.c           |  1 +
 arch/x86/events/intel/uncore_discovery.c | 17 ++++---
 arch/x86/events/intel/uncore_snbep.c     | 65 ++++++++++++------------
 3 files changed, 44 insertions(+), 39 deletions(-)

-- 
2.53.0

