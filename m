Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA501B0F33;
	Mon, 28 Apr 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745835163; cv=none; b=j6q7bGY+lnZ6M6DXoeSl6BtIN4hkyqoXjAidQwWBPbM9juCp+QgpfMtKuDWqM0JRr+IOb9KhEJOdDHxWFZzAgyHWa0xNfpxK7olR+XdK4UiTSwu2k4muXbtkXS/AaUT9w3DWQvFHpdstIwGnwQvNwNT0feZjmz0Afc4xsrdzja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745835163; c=relaxed/simple;
	bh=jjlR1ar6QQnzvTkkStYxJdUZeSvn6A+bxXCtKDctF/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESrsNtS9DLc9vCLf2GjI0o3KvMop+PfwV8/f0/RWEwE/tv4Op9eAbZ4HZA460IEbeq37dhM3Ub8tm32ZWbh1DZj9/Q1w6qD0UEYgec0QbQZrOCcO4Bl+T49xxmknRlilME3lyNPH+SjIJY+F1reJGq0M2Kuh5Qe557Dc2ldJ3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B8AC1515;
	Mon, 28 Apr 2025 03:12:33 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847833F66E;
	Mon, 28 Apr 2025 03:12:39 -0700 (PDT)
Date: Mon, 28 Apr 2025 11:12:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Wander Costa <wcosta@redhat.com>
Subject: Re: [BUG] perf segfaults when combining --overwrite and intel_pt
 event
Message-ID: <20250428101234.GB551819@e132581.arm.com>
References: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>

Hi Tomas,

On Mon, Apr 28, 2025 at 11:07:21AM +0200, Tomas Glozar wrote:
> Dear maintainers,
> 
> I would like to report a bug in perf I ran into when trying to combine
> --overwrite and intel_pt on latest perf from 6.15-rc4:

> $ perf record --overwrite -a -e intel_pt/cyc,noretcomp/k
> perf: Segmentation fault

[...]

> GDB gives the following backtrace:
> 
> (gdb) bt
> #0  0x000000000061bb16 in auxtrace_mmap__mmap (mm=0x7c9fa0,
> mp=0x7fffffff9008, userpg=0x7ffff7cff000, fd=7) at util/auxtrace.c:136

[...]

I can reproduce the issue with Arm CoreSight as well.  The cause is
the user page is mapped as read-only (see the mmap_per_evsel() function
in tools/lib/perf/evlist.c), afterwards AUX trace needs to update info
into it.

I would like to suggest a fix blow.  For overwrite mode, we need a
fixup to remap the user page with write permission.

Could you confirm if works at you side?

Thanks,
Leo

---8<---

From f969b3a7c3b338f47f271a2ac012813aec76b5a3 Mon Sep 17 00:00:00 2001
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 28 Apr 2025 10:59:28 +0100
Subject: [PATCH] libperf: Grant write permission for user page

When perf runs in overwrite mode, the ring buffer is mapped read-only.

On the other hand, the first page in the ring buffer is for user page,
which is used for exchanging parameters between the kernel and the
userspace.  The read-only permission causes Segmentation fault with
command:

  $ perf record --overwrite -a -e cs_etm//
    perf: Segmentation fault

This patch grants write permission for the mapped user page so the
userspace tool can update info properly.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/perf/mmap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c1a51d925e0e..465e12ec5a60 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -4,6 +4,7 @@
 #include <asm/bug.h>
 #include <errno.h>
 #include <string.h>
+#include <unistd.h>
 #include <linux/ring_buffer.h>
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
@@ -36,6 +37,8 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map)
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		    int fd, struct perf_cpu cpu)
 {
+	const long page_sz = sysconf(_SC_PAGE_SIZE);
+
 	map->prev = 0;
 	map->mask = mp->mask;
 	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
@@ -45,6 +48,19 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 		return -1;
 	}
 
+	/*
+	 * In overwrite mode, pages are mapped read-only.  Fixup writable
+	 * permission for the user page as the tool needs to update info
+	 * into it.
+	 */
+	if (mp->prot == PROT_READ) {
+		if (mprotect(map->base, page_sz, mp->prot | PROT_WRITE) < 0) {
+			munmap(map->base, perf_mmap__mmap_len(map));
+			map->base = NULL;
+			return -1;
+		}
+	}
+
 	map->fd  = fd;
 	map->cpu = cpu;
 	return 0;
-- 
2.34.1

