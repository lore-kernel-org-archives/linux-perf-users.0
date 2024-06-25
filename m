Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E711CD37;
	Tue, 25 Jun 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312348; cv=none; b=BOPNmlvgizqRrbCYkXAr6aXSjT5WLzUQ6mMAn0z7NnTra68JC+ITv4SkWuhL7+db20tp9UfKglmoTcMccXP6e7QRaKaCYkL/aKfK8zffCtcNcLa1gjPxmNiv3rASw+6ysfV0eiNCS7ELtVRkI49Y32rOBJ0mf4hzSCYUXPjHvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312348; c=relaxed/simple;
	bh=iJdiU4bPl+eVnnB/NjjhMJX7GryKWUf9ilbIQNnOr20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HhJtixLHm0YFftJiji7EGjjB/eWQNnuQIdGiWzUvNCQlHVPNZ0EpNafENvgTn5VJ7PddQO2O1TvS3Z9LabcrwSbhk+Co5KnjO1YxO13Q6hVBDR6JmvOeq3BhVMggIff0/5LCTN/gasDsBVd6y2xd+2Pzjwl3QaJHch7Tw3BUta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBNFrk+i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBNFrk+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719312346; x=1750848346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iJdiU4bPl+eVnnB/NjjhMJX7GryKWUf9ilbIQNnOr20=;
  b=eBNFrk+iFiWcZxV7hEnAUKoRtaIb54Lvoz9Vnxeh+yUmg5FBtKLgwR89
   2PnjD6Mx/nE6k7H07TYIN5OP4h5Zm0rYhF39kgzEGZptTOj8I+DapVSJh
   OND5GAnyotS2ase2FLY6BFJfOtDz78ZkRM4a8mliOXR8zfdy80kSjq75t
   9ecLXSNCCdWTUuDXrPETrV8AnkKQ+yKa2mcprPdhookbAaGbWzNgDHmO/
   DB07Gi7Vtjjir0BYiVqdr3g4XYnmm/w2kcGHxQdXMUBNnGtJYjnN5glsE
   Eyzb2Qu+LtCZ2fCyzZ4Lce0mKCzPADOm3vy6bcPIJqQEkjN9txnWf/oON
   Q==;
X-CSE-ConnectionGUID: T1BEtDm0Rp+Ud1llRObXpA==
X-CSE-MsgGUID: WcAj9iyoSXKDZK3DR++zVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26944144"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26944144"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 03:45:46 -0700
X-CSE-ConnectionGUID: /S5ES3cSSLa34QiZt44zXQ==
X-CSE-MsgGUID: nlLY3LQaTaOAe9kpQbMBcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43676511"
Received: from gcivario-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.48.191])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 03:45:44 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf intel-pt: Some small fixes
Date: Tue, 25 Jun 2024 13:45:30 +0300
Message-Id: <20240625104532.11990-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Here are a couple of small Intel PT fixes.


Adrian Hunter (2):
      perf intel-pt: Fix aux_watermark calculation for 64-bit size
      perf intel-pt: Fix exclude_guest setting

 tools/perf/arch/x86/util/intel-pt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


Regards
Adrian
