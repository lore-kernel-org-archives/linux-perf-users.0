Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192F2E6CD3;
	Mon, 13 Oct 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340199; cv=none; b=egeh7t8KR5xwqb3yYEuC5ZLhWNbe3i2Vor1qmwQooL0oDFHM9jOX7G8LC1TJxvHbEYfnpbMBs418dRBuz4KX6cuCi6lvcGsBngkLjwMD8Or6Wb6aGzai4Xn7Q1l8Ha0qM+edLzaCPa1nxW1vdWT5aSOecWa5znp0aZbNme26QcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340199; c=relaxed/simple;
	bh=9eCr45ti5YENOnRedAdaS9/m2ZHTeHl6SLXPdxEhH48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptUFPSO4aFKRXv0P2Su7P/ZGZvQJl7vfIEI7LaV95h41j9MPjUHxYWqZvg/0xuB80x6JWQN2+9TlrKgVg1NZmgnApigsys2DEcTqUmcahApVLON6YrTL0XkxmgJgE6ue0mbRxgVj3/iqH29ZcoFV6LMmWDTlO/XrgqfLv9kNoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlScEkFb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlScEkFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760340198; x=1791876198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eCr45ti5YENOnRedAdaS9/m2ZHTeHl6SLXPdxEhH48=;
  b=LlScEkFbpLotD/Fd+Qop8FKkV06p9+3b2lQqW06KMxHE45HZmpJ9NT9J
   5foAfsublWw87cFHo81jIKhZVoaIZ8GK81eruB2bfIRkrP2K4/S69ICKy
   VV972y4TqW2k++j8m/Fu9oGjzXP2InVEekjcTWXVeQvBq1EPNs3+TGvJl
   u3aWKfIjOzEM3F0srZ3+l2p2BttjmwJ+VWOMo9hOqlT6MB2UZxY3LwjLP
   9BXJCpNXWa12uE8Em43bDkhF0jFESxW1+uAo5Gaa+3nZpzJ+CJkwdRnAE
   JLdv2WgcA9ikBsaobODbsrxjoayOYs8F2b5BapIu/15T2BOQyqeGGXq4e
   w==;
X-CSE-ConnectionGUID: WLnymyanSuOnxcn7PZsIEA==
X-CSE-MsgGUID: XVMzW8rCST2TEHMbqNd7vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="61510085"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="61510085"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:23:11 -0700
X-CSE-ConnectionGUID: pNVLPpn9TVywtiB5NTE0bQ==
X-CSE-MsgGUID: RM+UvgeLQn2WaFeU87/wmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="185790499"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.25])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:23:07 -0700
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
Subject: [PATCH RESEND 2/3] perf/core: Fix MMAP event path names with backing files
Date: Mon, 13 Oct 2025 10:22:43 +0300
Message-ID: <20251013072244.82591-3-adrian.hunter@intel.com>
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

Since commit def3ae83da02f ("fs: store real path instead of fake path in
backing file f_path"), file_path() no longer returns the user file path
when applied to a backing file.  There is an existing helper
file_user_path() for that situation.

Use file_user_path() instead of file_path() to get the path for MMAP
and MMAP2 events.

Example:

  Setup:

    # cd /root
    # mkdir test ; cd test ; mkdir lower upper work merged
    # cp `which cat` lower
    # mount -t overlay overlay -olowerdir=lower,upperdir=upper,workdir=work merged
    # perf record -e intel_pt//u -- /root/test/merged/cat /proc/self/maps
    ...
    55b0ba399000-55b0ba434000 r-xp 00018000 00:1a 3419                       /root/test/merged/cat
    ...
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.060 MB perf.data ]
    #

  Before:

    File name is wrong (/cat), so decoding fails:

    # perf script --no-itrace --show-mmap-events
             cat     367 [016]   100.491492: PERF_RECORD_MMAP2 367/367: [0x55b0ba399000(0x9b000) @ 0x18000 00:02 3419 489959280]: r-xp /cat
    ...
    # perf script --itrace=e | wc -l
    Warning:
    19 instruction trace errors
    19
    #

  After:

    File name is correct (/root/test/merged/cat), so decoding is ok:

    # perf script --no-itrace --show-mmap-events
                 cat     364 [016]    72.153006: PERF_RECORD_MMAP2 364/364: [0x55ce4003d000(0x9b000) @ 0x18000 00:02 3419 3132534314]: r-xp /root/test/merged/cat
    # perf script --itrace=e
    # perf script --itrace=e | wc -l
    0
    #

Fixes: def3ae83da02f ("fs: store real path instead of fake path in backing file f_path")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cd63ec84e386..7b5c2373a8d7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9416,7 +9416,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		 * need to add enough zero bytes after the string to handle
 		 * the 64bit alignment we do later.
 		 */
-		name = file_path(file, buf, PATH_MAX - sizeof(u64));
+		name = d_path(file_user_path(file), buf, PATH_MAX - sizeof(u64));
 		if (IS_ERR(name)) {
 			name = "//toolong";
 			goto cpy_name;
-- 
2.48.1

