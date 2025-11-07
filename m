Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846D24677B;
	Fri,  7 Nov 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536722; cv=none; b=PCE0lHU78/0HoTvl9Grq+eRaL5t4c+FxybGyUpE36tI7/gbbuoP9xgpN6ygT7xqHhb2rGlVY9YjwlXnv/7cLCDGhyfkoVqFl7E7JpwCXi+CJyp1E5HnjphgxOEqVPySgqdMJrlaQ54IYwkmzXoOwrGqn3C0itjn42WJVGhxZ24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536722; c=relaxed/simple;
	bh=rtYEbJDdno3leNNOD42LfxWcCzJPfHjqsYFv2+VNSeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8fbpcqyACYSLDz1DkpYW3xdXSs64AjpYH8ueMs1fUfnt8G5udAzU9CuoLO6OP8v4VRkylZ1OMx/fMyOmC6+4vPjDxa0vbr17ArgfkG/IrDg0/eWbR+h+0ouwBaka0bH+ZsbLITNHHPl9AasPlnsbgq4BGpwMnMu84q5mnXIa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wj98Lrzx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wj98Lrzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762536721; x=1794072721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rtYEbJDdno3leNNOD42LfxWcCzJPfHjqsYFv2+VNSeQ=;
  b=Wj98LrzxVmWvoc4abAlIvKfig/PY7EnGQ9tz5cn/lSMkoi3Wv6sB50O8
   1xV11/LbYXNJXoVd3dCK5YBiVcn24YjsOVgGV7GoW9+v/mIJmyTrk3Gqi
   elk9TRtEkr3lI+l2MOeX1VFW1ITUApkKgetJYkhByJq4drsk+8rrSF3hM
   RSJyBaNktR3F2LQqllr+UVhBWV8daUHf3EfzV+xAWyFd2ZK3WXDM1YLUQ
   ddOJeDFWF/BeqLVlFxuMwu6Uye5L0is0YNnvOl2pUKOlMKg48E0orO/7x
   u4cbI7jYg4SPM4npPcPjdjr62bkTIIwk9lFeSCaiWBdRO8MThylqGSgf1
   Q==;
X-CSE-ConnectionGUID: ffE1YWX0S36EIEZruY7PzA==
X-CSE-MsgGUID: DAtvHM/HRqugbMThzjuCcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="76040379"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="76040379"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:32:00 -0800
X-CSE-ConnectionGUID: /YtKh+hJTDyc/BxXE2xNcQ==
X-CSE-MsgGUID: eYHGvonEQH2NhvoXBxdoGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187927068"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.91])
  by fmviesa006.fm.intel.com with ESMTP; 07 Nov 2025 09:31:59 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf: write bpf_prog (infos|btfs)_cnt to data file
Date: Fri,  7 Nov 2025 11:31:50 -0600
Message-ID: <20251107173150.135037-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF
info"), the write_bpf_( prog_info() | btf() ) functions exit
without writing anything if env->bpf_prog.(infos| btfs)_cnt is zero.

process_bpf_( prog_info() | btf() ), however, still expect a "count"
value to exist in the data file. If btf information is empty, for
example, process_bpf_btf will read garbage or some other data as the
number of btf nodes in the data file. As a result, the data file will
not be processed correctly.

Instead, write the count to the data file and exit if it is zero.

Fixes: f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF info")
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/header.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index db2ad19fa50d..54968881481c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1022,12 +1022,9 @@ static int write_bpf_prog_info(struct feat_fd *ff,
 
 	down_read(&env->bpf_progs.lock);
 
-	if (env->bpf_progs.infos_cnt == 0)
-		goto out;
-
 	ret = do_write(ff, &env->bpf_progs.infos_cnt,
 		       sizeof(env->bpf_progs.infos_cnt));
-	if (ret < 0)
+	if (ret < 0 || env->bpf_progs.infos_cnt == 0)
 		goto out;
 
 	root = &env->bpf_progs.infos;
@@ -1067,13 +1064,10 @@ static int write_bpf_btf(struct feat_fd *ff,
 
 	down_read(&env->bpf_progs.lock);
 
-	if (env->bpf_progs.btfs_cnt == 0)
-		goto out;
-
 	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
 		       sizeof(env->bpf_progs.btfs_cnt));
 
-	if (ret < 0)
+	if (ret < 0 || env->bpf_progs.btfs_cnt == 0)
 		goto out;
 
 	root = &env->bpf_progs.btfs;
-- 
2.47.3

