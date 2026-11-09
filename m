Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185506;
	b=dCwOHfItQhRbbfHsh4O35kQkguLGb25AexLA8f7UspIe/3JXs91JAN88neSwJypL7BfC
	 Vf/04iSiGD9jz3N4QvL4V1QBKikNkkU2lv9RZBPs7ZVm22Rb4JYDV6q68itPd4dED/u6f
	 NzxdjTh9ITWpQdjY38X9oLUCktKstlTTW6sayJ6V8/qweh7JTi3+tO0+A4Lm2ISA3Y0ws
	 uYw2fOznviTRWwhDoW+ry3OQ6T5OgS4pjLVsJaxZiC1SspVm/LH+b6Tmiu4+N0jpjBVg1
	 F4E4aCGWqyARSOGaFppTGJyTpgVRc5CJq7hwIsEqtLh6R8/R7Z2l6h2y5BGjvKg2KQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185506;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gPqUlhQ+5YbkYup8q7G4xt3o+aGi3rZy/AeQx5jHVl0=;
	b=yYFnborAwaQuVf3JKGZtQ68wiNdpt/b9kljWEFkofBSOj4ZuTUtWH6C9xZGhpXK7foA8
	 o53G7rST0ySOYMNj2R4fDtt+1VAkZz3Tcxj+YSQvbU42CODtRFf6yehPi+8mGYcZGfcf9
	 Fijdezu+iaMuhml/48PQeQGsweJ4XcECVTWjXorhAzE8GHPpo7Iis5n/kRNoXJL8geeqv
	 1KKRsv3Qv5wI1L987a4RYrOEyC1+EUzx/LlTJ1YxmB5q8mCVxQTNwx5bALOlqloe1LJ/b
	 0SSV2EjlmoYSvVRfD9koTigJlGQae7rWQciaegDsnOgUKEK/rRRMCOcIF0+fXPvWijg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="hLlIer/7";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF91606A31C;
	Mon,  9 Nov 2026 00:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF91606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hLlIer/7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794185505; x=1825721505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hd+yKzPhVrI8JTjc0kGI78CkSuXPpofKjvV66O96rA4=;
  b=hLlIer/7ixCon5O2YudaEGpvVQpwaEmtOiGk9sidmliCxY9fwcLULye7
   e1356FzK7RNLIRCSJ5Wz5iwLPY2T7iiDzi5T9Mj01fCjogyddNLeEkK23
   TM17gCaZJ7u7YGUwbhdTAJOC3VLoW/xL0apizS+ZJOlbPUTsPpeJWtX71
   8VJFw1SBwXZf5sJQYwOsdF7jMQvaxaTpI1HOAdT5evXlEB9U+Jwjy2ZwQ
   rMxKiyxmLTb7kxvQ213sf7TrAIoIpcnYpnZGruMtdJEjsHtHFaniQx/Fv
   ijN90gmeaSsmpq7xF/UAuaz6+UeDsFJegfvQNiE3a0C+EMOUzoTW6csMG
   A==;
X-CSE-ConnectionGUID: 8J6BCAhiSqGEdpnOhK0kCA==
X-CSE-MsgGUID: g0fe/HXxT4uEcxtPdathaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2829542"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2829542"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:51:44 -0800
X-CSE-ConnectionGUID: C/E9kC8tRgyr8zClVFa9DQ==
X-CSE-MsgGUID: Cn4XU1o/Q8G2TvON5g9iPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7874290"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2026 16:51:41 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 0/5] perf: fix test error and improve c2c memory-region display
Date: Mon,  9 Nov 2026 08:43:57 +0800
Message-Id: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

This patch series fixes a failing object-code reading test and improves
the c2c memory-region display in perf tools. In particular, it adds
memory-region information to the per-cacheline view and ensures that all
sampled memory regions are displayed, rather than only the last one.
These changes improve correctness and make the c2c output more
informative for debugging and analysis.

History:
v1: https://lore.kernel.org/all/20261106073018.903126-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (5):
  perf tests: Skip zero sample IP in object-code reading test
  perf c2c: Fix top-level histogram ownership check
  perf c2c: Show memory region in the per-cacheline view
  perf c2c: Show all memory regions in the region column
  perf c2c: Rename "Region" column to "Range" for consistency

 tools/perf/builtin-c2c.c        | 139 ++++++++++++++++++++++----------
 tools/perf/tests/code-reading.c |   5 ++
 tools/perf/util/c2c.h           |   3 +-
 3 files changed, 105 insertions(+), 42 deletions(-)


base-commit: 73adad359f45f67e81f71c016f49abd7dbf57405
-- 
2.34.1

