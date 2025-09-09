Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE3334722;
	Tue,  9 Sep 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421765; cv=none; b=DILGcTf6t6o49bqa6N4KYiUqhD8TqQNmcgW6bbD/Y1oT/3EyoHTVvSfHYCXYkt+0EYF2UZVxyvxhUXNmj0usY0dSj4mXX7SCVXecGl8Nk9gWlohyLHjD1xn1rGQId7O7ljrYw0QMlBl+rXmvFj66JPmV+ousJ9zdHK/jIMHUC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421765; c=relaxed/simple;
	bh=HXMhf8VGncxYHCwDK/v+GA73/bpOnN36hTkT2QbX1Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvD+BaVkCVPa07ImoT4Ez1vpnWP4h9hZnRK2ZqGoKcFcCQYUnPcw14Mv1/W1JghQJRI/p1dxVxhrgQuHuxjpCDxP7Hn7Cn26I3NIDY/Abwz9uL0kq2kFHHyCah7UbM8WWY3QSZPAxYnA1n6s0V/WtfSwsQ+zEcsMnoS5dnZ8RT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fmj69ral; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fmj69ral"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757421764; x=1788957764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXMhf8VGncxYHCwDK/v+GA73/bpOnN36hTkT2QbX1Oc=;
  b=Fmj69ralNgucutJUTPnCXvNSzXfy8PqSdDirEw66g08yxGnNyq5bzX1w
   dQlEuHZvV8zP2d8DYXgm9lQBAlZjUXxI3/e97JxeZsskt+BhqLEXs1VNR
   86ykPWH3CMVkhqXiRjRyYLF7KBbA7FmdYNa9cKzTUeijk7zQpziMD4RQl
   xnRqGtAd7v8l9X6WaY/gmGWy/2hj8IPAYtf4pGGkbV5NIEReDbI/ugF/2
   wCqXbibheLuseJkI5+68j2AZ7dcBnYevEhL2tHSllyOLjkY0bq2SKj9Ve
   iEtIEy3HRSxELz/N1kNpnnaBHgchqyrIqsvHE0AlKTKsKlUnxIlJnxObj
   g==;
X-CSE-ConnectionGUID: HZ2e26RfTp+KtM5x/i4yxQ==
X-CSE-MsgGUID: q0glqhm0QkuiIK3SEpYe3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70399556"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="70399556"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:43 -0700
X-CSE-ConnectionGUID: c+vPT1/MSpm46JdSgeOfJw==
X-CSE-MsgGUID: 0n1u8bFiRYW6T/2X/rpE2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172667451"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.84])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:39 -0700
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
Subject: [PATCH 2/3] perf/core: Fix MMAP event path names with backing files
Date: Tue,  9 Sep 2025 15:42:21 +0300
Message-ID: <20250909124222.222945-3-adrian.hunter@intel.com>
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
index 184f3dc7b03b..e203b8d90fd2 100644
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

