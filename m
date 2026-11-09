Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223936;
	b=uratz09cL5UDaEqTauqwpSNaL46KZkOAX4wZ4R9D9kYQX3bwI4abGSra/HEhhTPBrQ4W
	 aJHE5fEUvjg19GUZl92amnHbEPQdIoH1++VX2D9Y5cFMmEb4xK7inNJFuhq85k0sRLfWx
	 8qhP4Ho5rdTnZ7+DiiXYtGyiGC24CKM9feP7kg6rvGBUncUCWMgHY51rQf0COqStCSRR3
	 S0rLZBUUecBMDmbSs0PXF3iv/3LKGXKTA+LLvIsETX1UhOMXbS1wQwFHVY2DizI8jhvkI
	 kzPUn081XTObm0++AwFhMzWwWd5mLsKW1CSAKqWKcOoBJo/BLsLBQp918Pkst2Karnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223936;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=CXHQRvzu9ySr8LuHBBRQmSRAHwMMhm14WW1qfDMLw/c=;
	b=VHZST4CwF3pci3Pmg2myylJ9gkSDgM8/iIR8DcswCxwKcwoHcyvslAFsxgkbmQUHBVXq
	 V3QwYmL8EP6FkjcoGAs677xUXT/QqYN8O4VRSHfwc20txbLOLdgdCtjKN1biVphEngeii
	 LLECSDLbsLH/Kxt6KzXDB5BhS8f9kLPdOqVL1WSJrNkQrh1gJOMvBzissqm52UjhmH2l5
	 NSBnB0xtea1cFtJYH9td0OJsa/NKjg80YY8Qc3ZRy0807ol2GXeIyIuW9VlXXssb+0cCG
	 Ft2jjnbWIFRaPPOzgAXnOxp6fXp46Fh2nTc4AkKY0Za3lsbzhN2/jBfGN+J19egQyjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hMg7TyP8;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1559606A321;
	Mon,  9 Nov 2026 11:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1559606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hMg7TyP8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118511516;
	Mon,  9 Nov 2026 03:32:12 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 638FF3F85F;
	Mon,  9 Nov 2026 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794223935; bh=r0wxlvvbX4+OZAvcNk00XNBeViJ9UtAC+4++EEYcwcA=;
	h=From:Date:Subject:To:Cc:From;
	b=hMg7TyP8YQOM4N79+1WjmlQWjRNykXwLvLmDcBN2EAZ8JuB5knQU6LcJzSLxu3qoF
	 QtFj3IbRWEUUszuarolBh5WjyMax3jgMKZUMdqHIkjEa3yRxP/uX0STUul7fKWuSta
	 glWVnI9nDcFHRz+lLOPD8BM2BeiI1dWrg0kR6ViQ=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 09 Nov 2026 11:31:53 +0000
Subject: [PATCH] perf/aux: Fix a memory leak on AUX allocation failure
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-perf_fix_aux_page_memleak-v1-1-aae781d6749c@arm.com>
X-B4-Tracking: v=1; b=H4sIACmv8WoC/x2M3QqEIBQGXyXOdUJm7Na+SoSYfdahnxWlCKJ3T
 7ocmJmLIgIj0i+7KODgyP8tgcwzspPZRggeElNZlB8pi0Z4BKcdn9rsp/ZmhF6xLjCzaAarvs7
 2daUUpd4HJO99t919P9V9qtJrAAAA
X-Change-ID: 20261109-perf_fix_aux_page_memleak-9dc37fcb8433
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794223933; l=1781;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=r0wxlvvbX4+OZAvcNk00XNBeViJ9UtAC+4++EEYcwcA=;
 b=zJD8U6yffrHJiNrOFC5llDvc7sJv10tIeTLsnQjA8NUOVC81FMoWVwPDqogMIJ9OjK6USk+1a
 zGumgocFo2/AK4X6UZvR5kyJ1TkBhMm5VJuyHH51MHuqBd1x4Fsdyaq
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

rb_alloc_aux() allocates rb->aux_pages before allocating the AUX data
pages. If the first rb_alloc_aux_page() call fails, rb->aux_nr_pages is
still zero, so __rb_free_aux() skips freeing the pointer array.

Commit ee9397a6fb9bc ("perf: Fix double-free of the AUX buffer") added
the aux_nr_pages guard because AUX cleanup and main ring buffer release
shared an IRQ-work callback that could call __rb_free_aux() twice.

Since commit 95ff4ca26c49 ("perf/core: Free AUX pages in unmap path")
removed that shared cleanup path, main ring buffer release no longer
invokes AUX cleanup. The earlier double-free race is therefore gone, so
the guard is no longer needed for freeing the pointer array.

Free rb->aux_pages unconditionally to cover the zero-page failure case.

Fixes: 95ff4ca26c49 ("perf/core: Free AUX pages in unmap path")
Closes: https://sashiko.dev/#/bug/linux-c1a2bb3b-5d2a-4fca-a697-ce07992a5cc1
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 95f4fbdfd2764de5b72d901d778c46302f525fad..687d89c1fd5fe06963ba2a9563887d5f0d693e93 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -674,9 +674,10 @@ static void __rb_free_aux(struct perf_buffer *rb)
 		for (pg = 0; pg < rb->aux_nr_pages; pg++)
 			rb_free_aux_page(rb, pg);
 
-		kfree(rb->aux_pages);
 		rb->aux_nr_pages = 0;
 	}
+
+	kfree(rb->aux_pages);
 }
 
 int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,

---
base-commit: 2651f6deb3326129a052897df193052dc28ea94f
change-id: 20261109-perf_fix_aux_page_memleak-9dc37fcb8433

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

