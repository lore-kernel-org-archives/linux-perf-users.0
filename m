Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62833EB12;
	Tue,  9 Sep 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421769; cv=none; b=C+roZeinYzmcrPvWRGhv/pkgTiU4eJ29OTp4oItPh2/KtwRd88ICvJr7orw1TCPe0ojOEZcUHsZBLmk0sI2KLBvwdkDD/m24mqWCYLLe5zUzPnuyrzwImY2tBZfbHx3jdzLEkl0L6wEWp9+3wt3ODQ2NDcy8H3B+71LTxuaQdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421769; c=relaxed/simple;
	bh=Pt6R1lXQxECu96oquYdgEIA0VrhXv/RzniYpUbGqgSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfSvBPLZcjKrFofMzvHnsxnSQMbuoQEATGoYUnFMfnPuxSp8rez1gvXMPIlouhiIXhgR2LzfRjHH58QAe+a8ckkfJZVcq1sjaEnXycC3upwvOY2x3DktKmfoL2hWUVlepkWSK3dmpRQem0XTFwTewf3VF5xl6M11aZ5Uj0qYr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edZhkqCg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edZhkqCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757421768; x=1788957768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pt6R1lXQxECu96oquYdgEIA0VrhXv/RzniYpUbGqgSI=;
  b=edZhkqCgIGwrMRURj45eT/Vlax5qHr/z3Y5bu1BApbRSoeWt+N2kx3i0
   yTlQ+WTc5coGb5kZDFw4CwzilgnVKC5Mllh+Ht0lNkIIXtSnYkVWg4WFk
   u4YyCfGcl1wwG2EWPg1R9qDVxj2xa1LqZ5O3ISFPutfRHna99FllhkBw2
   tl3qzkPM9JksxrFwJnzB8ZSaB2x3C9uDpABj3UC0ljkNkI8+kpOgCM+8B
   b+QfI4358wLBIR1ERALyMvM7W1ys/133hxGX+Fn82G4y1KQb0DOoGiJdA
   u3fQ93WkflEOHII4qm207/QvB7PBs9kxdKw/qE3vUvNoRF0JnO7lv1omC
   w==;
X-CSE-ConnectionGUID: rH2CTtoTSt2oQYL43tHPZA==
X-CSE-MsgGUID: rEpL8Fb2S++G/TkNCk70ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70399573"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="70399573"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:48 -0700
X-CSE-ConnectionGUID: uGyzRG44TECZQRgYsqdZqg==
X-CSE-MsgGUID: K7rh66MDRg2kow9aXEBTTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172667483"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.84])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:43 -0700
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
Subject: [PATCH 3/3] perf/core: Fix MMAP2 event device with backing files
Date: Tue,  9 Sep 2025 15:42:22 +0300
Message-ID: <20250909124222.222945-4-adrian.hunter@intel.com>
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
index e203b8d90fd2..9d281785b99e 100644
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

