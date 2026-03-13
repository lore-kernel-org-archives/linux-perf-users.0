Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692040DFB7;
	Fri, 13 Mar 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424235; cv=none; b=F8rTYXwXOKgZxKYomjr2ggrGfOZuWfyWXKAuTDItIZ2gkWmi/TgJrhnZmeCso/7nC/tydtCRmoMy/dg4RhR9yYtFxcS0x97j88sS+IIi/LGM5HYmD35UBp21I1qzKggELi50fD9F1j9ZVC91BGgXf6hyc0d/1BDhwnutkLZlVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424235; c=relaxed/simple;
	bh=lSZOgTpv2vN2Pz+/aw57z/FZvm62aYixbQ6+L6fQaDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RS00qe1A6+NycSMv+UHfD6lAj/HVWyHEkt86srYgjRejguIgceZQhYFSP+Fu39jBS7YXKO66HsPNOTXKOco24ZQ6jbY+bcJcu24SPkqbm8ZHH6qzziCBMyW4jYI4cxw+LWFpmhAysqwIyBwcuouGKsfIm0V7agYD5mxHDZ/RHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddyRVifG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddyRVifG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773424234; x=1804960234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lSZOgTpv2vN2Pz+/aw57z/FZvm62aYixbQ6+L6fQaDc=;
  b=ddyRVifGFZNURBHSDfWq1XgwvEhHEpbqWdrnNZxZ731RfOQHtlsHKu3g
   oVGFGy+yxu5XqL5v+65N996r1nwq72ozdAZ77N1Vdub4+y2o5qcCUMjBI
   d9wfQhyifpJGepoSTCLoRl3KcUlA/DuJPktMZ46bjcNo4y9shYUw+u9wg
   DUbT5Xz9FxNrZ0r+VEFFQs5p3WSMOp/Op50HSnUVS6iboTA6mvgxnWhUh
   hK11fJ9F9OJD6sHYZD0+4N04TccdZe/TnK97MYSRjY53dYatH/JjI3/lS
   m7ENZdIS7OE71uXTQtMleAWCVZ27MdLUVVFnfGtqB5IVvtGZM63vHptfM
   A==;
X-CSE-ConnectionGUID: veaanChSRDq9JCZejmr7Gg==
X-CSE-MsgGUID: DU2UUa1hRFitN4RTz4/RkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74508688"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74508688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:50:34 -0700
X-CSE-ConnectionGUID: y60mLqrdQNu9uPRvDXNtUQ==
X-CSE-MsgGUID: 7NNfQ0NhQSiO9oFOCX+Gog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="259128512"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:50:33 -0700
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
Subject: [PATCH V4 0/4] Miscellaneous Intel uncore patches
Date: Fri, 13 Mar 2026 10:40:46 -0700
Message-ID: <20260313174050.171704-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mainly a RESEND of the patches listed below.

No code changes since the last posting.  Only some Reviewed-by tags
have been added.

I grouped these patches together for the convenience of the maintainers
and bumped the whole series to V4.

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
 arch/x86/events/intel/uncore_snbep.c     | 61 ++++++++++++------------
 3 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.53.0

