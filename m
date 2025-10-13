Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513502E8B83;
	Mon, 13 Oct 2025 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340189; cv=none; b=DZ2QtQGl3XAVrjL7cO4VDs40bU1zbj32bkmtnFUOB70ZCvqVLBsgAt1ZrKS8qYlBwPfjl0Hcwj9/Vpo/79jJVaKARH6Uzb7r2DfLgD1TKjCPA9eBE7Zx/Z+maptkJ2KLa2H0N9OcxHSFQXGkbf9vRjuxQaSqU6nFZgx+mqloC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340189; c=relaxed/simple;
	bh=JCdjH5SYxp2d00xYTWypj6ZEy4T+jFDzGWOlXCSAMos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkyqDH/f5NzHr6uXih6EKrDX/Zl+SsCp05rCsykdjFiY5HUQE9ILfNWqOv7GVcyIoa/YnZ2HmZiHMgZV9fWQy5Ah4sUuCpQ0WTpHRShknXTVbcs42wmbIp9+dYCq/ZpeETk5nrYGVGCeh1cOeM27l1vIrcJVxSAa+8DCpCQ8yvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJ83caIk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJ83caIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760340187; x=1791876187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JCdjH5SYxp2d00xYTWypj6ZEy4T+jFDzGWOlXCSAMos=;
  b=BJ83caIk/n3OOYnT895MI4Y9ExS5KHZhXqljU9fv1HAdHxNK4CntJ+Ez
   TCHaC6+HzyJWhtL11PA7B2ZojDHE4p0jw/7Twt8XOLs28YDvGrlXbIqbl
   H958RRElAbXhgpZ8BPpMz2XR6uADGjgmrNXYrIf6re66cZk44ESp5wdjN
   W71yQxUyNimc8eOVvK8tzZS6MUmdoNZcTJg6rODACmKROIBTn8bpoW88/
   IBs3NGTeQfK/JEzCHh3SQB3w0wqU5IQ37m4rXa5GCpWAi3SWGr5dVV3PB
   ovP3dsGfimBelW49j9T/sBfnGvuqeMRNpsq5rT6VPci8rA+SeClCivMZ0
   g==;
X-CSE-ConnectionGUID: dAXkKWa4RmW22ZAMMNd+rg==
X-CSE-MsgGUID: GxL95zfnReGpS4eNJJ7Ifg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="61510054"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="61510054"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:23:07 -0700
X-CSE-ConnectionGUID: U/WDZ7+7Q3+vFMf6+kAUow==
X-CSE-MsgGUID: 5j9tr7oqT+2knrb+/wr8tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="185790453"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.25])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:23:02 -0700
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
Subject: [PATCH RESEND 1/3] perf/core: Fix address filter match with backing files
Date: Mon, 13 Oct 2025 10:22:42 +0300
Message-ID: <20251013072244.82591-2-adrian.hunter@intel.com>
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
index 7541f6f85fcb..cd63ec84e386 100644
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

