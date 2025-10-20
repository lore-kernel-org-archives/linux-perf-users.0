Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F22E40E;
	Mon, 20 Oct 2025 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922958; cv=none; b=q/kTkFceeaZGInBvOCXO+SJP9dwMvg4QJPCHrj7DO1Ks7UtRwVTGaK4X483Mqc3zdHlabXFtTtA0oI3oDiGh7WbUVO5J+770iUMMB8tkv3laRB4Fg3hZsCkS/WsNELBxLnYGzEdA0g7UTTpywndcj+VF6GwucXhnn6It+ZrNxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922958; c=relaxed/simple;
	bh=KT8U6ugMgpwakjHE7nx7F2fe8sHW+2AY6AOoDrhd2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJl+fyDAqOy+DFG6KIolgBK4X007j5bHSHxP6m2AVmpgS6Eo0UHMVQSA9jfi/7P8sNgWPg6openyyYm+EByVe/qy6m8wyDxTbnE5nFd5B//j59E8ulhqfSWmXQySb6sN9weE3HuqHOWyswxBwHZok+IKttqWWSBE64Z26Yhuh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVYv9fQu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVYv9fQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760922956; x=1792458956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KT8U6ugMgpwakjHE7nx7F2fe8sHW+2AY6AOoDrhd2NI=;
  b=TVYv9fQuq8GaL2zF+kM3/AB0koV8ZP8Gcr/la7m7t/e5EYybaHz+OjZs
   4IXUv3Rlm6X87stVBBx+Ue0sfIpjASV8KgsjCDmzg/EXakEhFMW9jQJtu
   1PAqn0mY7ejryCv18tWCNBuZF7O3ITGSyVpGsfBRkfpg66OoowUEhEsn4
   LOedwevzzJ+kBMUYmD+ScInC2xMjEUqW96XwT7QMlYmmWsvhnlUMKVkBH
   /AmZUVgVdrtsjSFkX/sO2LumuNBghwlWgRmQnSdx5fegLPo63X2i2+QFf
   u+hPqkbVSz85YrFvbUZ53sRVKPekBy4Sylu80Yb9ha/2lgsV5IyQ6Vcc1
   g==;
X-CSE-ConnectionGUID: 9UBEyed+R3yi8VC0WBBvPA==
X-CSE-MsgGUID: UVGNO3NFSm64xUSsRgC4Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62251742"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="62251742"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 18:15:56 -0700
X-CSE-ConnectionGUID: fhyOkvBfRhGFwKf1Dn/jZg==
X-CSE-MsgGUID: hnB9vB4cTLSl398D+vKO4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="182401398"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by orviesa010.jf.intel.com with ESMTP; 19 Oct 2025 18:15:51 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] perf tools annotate: Align the symbol_annotate return code
Date: Mon, 20 Oct 2025 10:14:34 +0800
Message-ID: <20251020021434.29082-2-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aPRbfdU92XRLR-2N@google.com>
References: <aPRbfdU92XRLR-2N@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return error code from the symbol_annotate previously checks the
evsel__get_arch from '<0', now to '!=0'.

Suggested-by: James Clark <james.clark@linaro.org>
Tested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tianyou Li <tianyou.li@intel.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 39d6594850f1..859e802a1e5e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1021,7 +1021,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	int err, nr;
 
 	err = evsel__get_arch(evsel, &arch);
-	if (err < 0)
+	if (err)
 		return err;
 
 	if (parch)
-- 
2.47.1

