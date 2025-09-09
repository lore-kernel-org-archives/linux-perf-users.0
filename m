Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12F33A00C;
	Tue,  9 Sep 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421761; cv=none; b=NFFJGXyyU2n4VH1NkDI70V2qRRPbOh4S7vxqB4/nhBNqS2mT1jLV+VvrqZJflLj/EA+IVGvbHJVY/Gr/KQUO5OaxZ4sU74Ja+mOwyN2FcZLJIbBDjhVNsWkM2/d09UqmUtqc3CiRNqRxkaOt4lI1FxGQI3pmyCLBJ4882R2DmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421761; c=relaxed/simple;
	bh=nyivRvoUeQGaRx+MBdk7W2K+tf1UkUWsqGHfGsHD3hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYXW1kGjQYgD1pNv2bXogaKh7BgTAaplFjKVc4I/r1V0OCFM2rLULO7I84eCd0XcgxhRmWr/Qq08zP2eH2E6UHv9xAJF7igBEbROSPfjM++ABfeF3fBpUC/woHwTik6fZ1auj6ql6A2PhcXKH+EaHm+5tUBgUwepOVjv6jAoDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hecm/bRw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hecm/bRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757421760; x=1788957760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyivRvoUeQGaRx+MBdk7W2K+tf1UkUWsqGHfGsHD3hc=;
  b=hecm/bRwOi4B/kFWwva5YJdJhIG0RIcDyHbml+ZGldiGbOcVjCda5RUA
   mI4jlaXa64YxIJNBd5J6NkQuz6H2Wvo/QkJYg1K2r107CM2s2uo9q0Ka1
   qQk49aOcGETHPpsqlxeYddohVETUPJB3xdpqsZ0tCnCwKyZIlX/kpDda4
   CH46uNST4+qN5QkdVtz6R+FwOpnxa0InSeRyCntt1OYMgqYVK7cFJM5La
   h11SNnZ9vUlU6EW8ndC3SWKXrH23Z6bpYr9fuO070qXxrFLmq6yoNd5wT
   E2pI4QPO5/HuUnD/n1/xE9zeYjx9mq/oK6F0ipNSJVSMkVML/H/HdCFgW
   A==;
X-CSE-ConnectionGUID: 6PI059jgT1GEsQhoX1lrJg==
X-CSE-MsgGUID: QOYo/xCbS3mEID8VM7hDbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70399542"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="70399542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:39 -0700
X-CSE-ConnectionGUID: 21ZjgzN4Tp2M3aEDsx0rWg==
X-CSE-MsgGUID: QPtgvQS+RC+uripbR6KwCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172667422"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.84])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:35 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf/core: Fix address filter match with backing files
Date: Tue,  9 Sep 2025 15:42:20 +0300
Message-ID: <20250909124222.222945-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909124222.222945-1-adrian.hunter@intel.com>
References: <20250909124222.222945-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

It was reported that Intel PT address filters do not work in Docker
containers.  That relates to the use of overlayfs.

overlayfs records the backing file in struct vm_area_struct vm_file,
instead of the user file that the user mmapped.  In order for an address
filter to match, it must compare to the user file inode.  There is an
existing helper file_user_inode() for that situation.

Use file_user_inode() instead of file_inode() to get the inode for address
filter matching.

Example:

  Setup:

    # cd /root
    # mkdir test ; cd test ; mkdir lower upper work merged
    # cp `which cat` lower
    # mount -t overlay overlay -olowerdir=lower,upperdir=upper,workdir=work merged
    # perf record --buildid-mmap -e intel_pt//u --filter 'filter * @ /root/test/merged/cat' -- /root/test/merged/cat /proc/self/maps
    ...
    55d61d246000-55d61d2e1000 r-xp 00018000 00:1a 3418                       /root/test/merged/cat
    ...
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.015 MB perf.data ]
    # perf buildid-cache --add /root/test/merged/cat

  Before:

    Address filter does not match so there are no control flow packets

    # perf script --itrace=e
    # perf script --itrace=b | wc -l
    0
    # perf script -D | grep 'TIP.PGE' | wc -l
    0
    #

  After:

    Address filter does match so there are control flow packets

    # perf script --itrace=e
    # perf script --itrace=b | wc -l
    235
    # perf script -D | grep 'TIP.PGE' | wc -l
    57
    #

With respect to stable kernels, overlayfs mmap function ovl_mmap() was
added in v4.19 but file_user_inode() was not added until v6.8 and never
back-ported to stable kernels.  FMODE_BACKING that it depends on was added
in v6.5.  This issue has gone largely unnoticed, so back-porting before
v6.8 is probably not worth it, so put 6.8 as the stable kernel prerequisite
version, although in practice the next long term kernel is 6.12.

Reported-by: Edd Barrett <edd@theunixzoo.co.uk>
Closes: https://lore.kernel.org/linux-perf-users/aBCwoq7w8ohBRQCh@fremen.lan
Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fb1eae762044..184f3dc7b03b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9492,7 +9492,7 @@ static bool perf_addr_filter_match(struct perf_addr_filter *filter,
 	if (!filter->path.dentry)
 		return false;
 
-	if (d_inode(filter->path.dentry) != file_inode(file))
+	if (d_inode(filter->path.dentry) != file_user_inode(file))
 		return false;
 
 	if (filter->offset > offset + size)
-- 
2.48.1

