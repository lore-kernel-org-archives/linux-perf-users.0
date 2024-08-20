Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9EEAC5;
	Tue, 20 Aug 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178691; cv=none; b=eitLMMOT8s4oOr5OARopTzkwHhyktrnW+1dN//nOtmRePS3BCqNGFqaSHHHEY81C9dZ6casGbqip+zmba9tBFekW0l5Td5XI3xmbRdZYxY7UMlpF1geGyRNjFhmPonh18t7X5Q8WyG3Oo7qYMEkzPTP8dU8fi8G4lU4w1Q1eXp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178691; c=relaxed/simple;
	bh=liGTDXoscxLcCROjnOLpYkcFAv6EbxOlUytlw+YakPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePIQbszzwaLpQh6IM8X0YnJ3DEwa9GJjol4/ZnmAn6kZOwEUNdpYrrPcT00Q2/ZebFFQGD/4TzBKFM9WzdY7ea5y6VVWeYp3NaYpMVc2r/2ibutzZ9A2qvMdIZQdlCDQYHY7jusVBkfd+2OrtHVazViNmVFsojhxvOYz95EjmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Orm8RUUX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Orm8RUUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724178689; x=1755714689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=liGTDXoscxLcCROjnOLpYkcFAv6EbxOlUytlw+YakPw=;
  b=Orm8RUUXrQ5JZ28mCvtaLe62wrBNHWcKCTS51g4Uv50w6MDiHGgyRBX/
   xKPLYXWgrprdXDp+ledjItq4qzeqvFUtFa2UoTaHq1G533G4CyIXWtd5Y
   Pt+vDAPrZfBHp5cWdu3m+aXLXPVojEbbRt9CQ/pe47M4Eddqde8TflSsF
   H6GpdqlxmpEIfQzyMJjB7tfXk+bScFdxbT9DjBaitLIvxi0O6gM4/3K5y
   WYwNhzu9lFfgWT/EXFM6q0JIHgOrMpHM3ixfdN9EQqme123dDRcso+edv
   E3AD6tP4c47UAj99Hev4AGIQ6HvvxeIdxQ19VXOHIrbdY9uiKYyHeqIjF
   w==;
X-CSE-ConnectionGUID: iBNf1kUgS7OKcOU81MAfXQ==
X-CSE-MsgGUID: x8RG1vswS8y7+PhiMa4PWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33164131"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33164131"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 11:31:28 -0700
X-CSE-ConnectionGUID: GT3sWMfNRtOHB08T3IEVlw==
X-CSE-MsgGUID: mZjCh3r/SbSazfChsvVoVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60458133"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 20 Aug 2024 11:31:28 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf hist: Don't set hpp_fmt_value for members in --no-group
Date: Tue, 20 Aug 2024 11:32:02 -0700
Message-Id: <20240820183202.3174323-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Perf crashes as below when applying --no-group

perf record -e "{cache-misses,branches"} -b sleep 1
perf report --stdio --no-group
free(): invalid next size (fast)
Aborted (core dumped)

In the __hpp__fmt(), only 1 hpp_fmt_value is allocated for the current
event when --no-group is applied. However, the current implementation
tries to assign the hists from all members to the hpp_fmt_value, which
exceeds the allocated memory.

Fixes: 8f6071a3dce4 ("perf hist: Simplify __hpp_fmt() using hpp_fmt_data")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/ui/hist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 5d1f04f66a5a..e5491995adf0 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -62,7 +62,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	struct evsel *pos;
 	char *buf = hpp->buf;
 	size_t size = hpp->size;
-	int i, nr_members = 1;
+	int i = 0, nr_members = 1;
 	struct hpp_fmt_value *values;
 
 	if (evsel__is_group_event(evsel))
@@ -72,16 +72,16 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	if (values == NULL)
 		return 0;
 
-	i = 0;
-	for_each_group_evsel(pos, evsel)
-		values[i++].hists = evsel__hists(pos);
-
+	values[0].hists = evsel__hists(evsel);
 	values[0].val = get_field(he);
 	values[0].samples = he->stat.nr_events;
 
 	if (evsel__is_group_event(evsel)) {
 		struct hist_entry *pair;
 
+		for_each_group_member(pos, evsel)
+			values[++i].hists = evsel__hists(pos);
+
 		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
 			for (i = 0; i < nr_members; i++) {
 				if (values[i].hists != pair->hists)
-- 
2.38.1

