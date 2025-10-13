Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7842E7F20;
	Mon, 13 Oct 2025 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340201; cv=none; b=oO163c+lz0fmXS2K6saip4JFF5pK3B09Tsl6ALDNCGjlNv8f/kKQoSHBd2OzbPCy7x9/1BJnVoup3gRlxeoRxVHymXZJUKezH7pKS6LB5q0zpgB/nkyzh0Kiesr6TyOgSs2OMIiyE7enPy0AK5HBimJBI9dN2rbKGuQbfnrrJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340201; c=relaxed/simple;
	bh=5rYjsN5XeOyunE3PUJZcaBEskdY9kWOsawHLMQzQslQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcw+R9bVVn+JuDtAAYC/1xAuXObijz2hKFn3nA2NkFOtBdUAohoDK2OXTWrody7OKCwdSWpBuE1tOnMgRMtx4oGlIJbZsabvCkoiVrCLwG0g0t9fTxiZvRPrBs3ZE6m6ooZ86GJ7Ls9bDZn3VYWOoNF5/cvsmk/kJmilVqa3LZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFxJ3RYe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFxJ3RYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760340199; x=1791876199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5rYjsN5XeOyunE3PUJZcaBEskdY9kWOsawHLMQzQslQ=;
  b=aFxJ3RYe+JpT5PtCZtf6A9mVVwtUh5ZANsotILAgPvpMU6p0616N/Q02
   6zxN0sHx2AKlGVQrFOakLQqvXkcy/UU1gKoFXtlgA/mHeI1ojzBkaBV9Y
   xILGsCvXABfbkQXJGpPGt79T/JiZeQSqlXLiNs/htLyNMxbp9UkkaBuWV
   trl0Cy7uG4Yq/VtC5p4aYIsCgoY20a3a0llGGLKvZkDoM9vKosdLB0+W9
   sUC25eUvqCgT71JF4Mhy+2RNt1oZigZ5p2sLs+nQd+GBdS0/kmGDYl8th
   M0IzI70Hp9Q8jNbIw51dVPoGexTBlteNqmDvNNcUpQqBSIVkxVgAWAeC6
   Q==;
X-CSE-ConnectionGUID: /9bP2/SCRkuJPy31QpY77g==
X-CSE-MsgGUID: ICFwt8cUQn6RehtxnrBHSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="61510111"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="61510111"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:23:16 -0700
X-CSE-ConnectionGUID: LxgLBrP8Q4Wrhw0ocGu1Ow==
X-CSE-MsgGUID: c65J513iRO+SljnR4gx7tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="185790523"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.25])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:23:11 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Edd Barrett <edd@theunixzoo.co.uk>,
	Laurence Tratt <laurie@tratt.net>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH RESEND 3/3] perf/core: Fix MMAP2 event device with backing files
Date: Mon, 13 Oct 2025 10:22:44 +0300
Message-ID: <20251013072244.82591-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013072244.82591-1-adrian.hunter@intel.com>
References: <20251013072244.82591-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Some file systems like FUSE-based ones or overlayfs may record the backing
file in struct vm_area_struct vm_file, instead of the user file that the
user mmapped.

That causes perf to misreport the device major/minor numbers of the file
system of the file, and the generation of the file, and potentially other
inode details.  There is an existing helper file_user_inode() for that
situation.

Use file_user_inode() instead of file_inode() to get the inode for MMAP2
events.

Example:

  Setup:

    # cd /root
    # mkdir test ; cd test ; mkdir lower upper work merged
    # cp `which cat` lower
    # mount -t overlay overlay -olowerdir=lower,upperdir=upper,workdir=work merged
    # perf record -e cycles:u -- /root/test/merged/cat /proc/self/maps
    ...
    55b2c91d0000-55b2c926b000 r-xp 00018000 00:1a 3419                       /root/test/merged/cat
    ...
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.004 MB perf.data (5 samples) ]
    #
    # stat /root/test/merged/cat
      File: /root/test/merged/cat
      Size: 1127792         Blocks: 2208       IO Block: 4096   regular file
    Device: 0,26    Inode: 3419        Links: 1
    Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
    Access: 2025-09-08 12:23:59.453309624 +0000
    Modify: 2025-09-08 12:23:59.454309624 +0000
    Change: 2025-09-08 12:23:59.454309624 +0000
     Birth: 2025-09-08 12:23:59.453309624 +0000

  Before:

    Device reported 00:02 differs from stat output and /proc/self/maps

    # perf script --show-mmap-events | grep /root/test/merged/cat
             cat     377 [-01]   243.078558: PERF_RECORD_MMAP2 377/377: [0x55b2c91d0000(0x9b000) @ 0x18000 00:02 3419 2068525940]: r-xp /root/test/merged/cat

  After:

    Device reported 00:1a is the same as stat output and /proc/self/maps

    # perf script --show-mmap-events | grep /root/test/merged/cat
             cat     362 [-01]   127.755167: PERF_RECORD_MMAP2 362/362: [0x55ba6e781000(0x9b000) @ 0x18000 00:1a 3419 0]: r-xp /root/test/merged/cat

With respect to stable kernels, overlayfs mmap function ovl_mmap() was
added in v4.19 but file_user_inode() was not added until v6.8 and never
back-ported to stable kernels.  FMODE_BACKING that it depends on was added
in v6.5.  This issue has gone largely unnoticed, so back-porting before
v6.8 is probably not worth it, so put 6.8 as the stable kernel prerequisite
version, although in practice the next long term kernel is 6.12.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7b5c2373a8d7..177e57c1a362 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9403,7 +9403,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		flags |= MAP_HUGETLB;
 
 	if (file) {
-		struct inode *inode;
+		const struct inode *inode;
 		dev_t dev;
 
 		buf = kmalloc(PATH_MAX, GFP_KERNEL);
@@ -9421,7 +9421,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 			name = "//toolong";
 			goto cpy_name;
 		}
-		inode = file_inode(vma->vm_file);
+		inode = file_user_inode(vma->vm_file);
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
 		gen = inode->i_generation;
-- 
2.48.1

