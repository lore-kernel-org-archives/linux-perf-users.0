Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F591E1A3D
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950790; cv=none; b=EVfU/DDTmapBi0YOWoYNJzf3Wy27ADAnV46zkoR9Kl7NgUC4Kd3m1D+lETpTSwCxgumhEacQ+Dz4dUSS/36B4fo+SZbELYqHatDdeio3EPmPmyPgp+lAXz+6cxFYIZ4SMFoY8UDln79vSSodmb1rzOMrVPJepkhfxEftgS+CDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950790; c=relaxed/simple;
	bh=JuCBa24Q8mcK4IKnzSx3OFgFtgWwVjqbYpPpkFwtRIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTT34Xjs9AiztsQRaAgrthAegfc/BYy4PmKFJMQVXMhKpaZsXRS7smo+JgM3owZK1L9ivbJY5HTKP/fwfm9ES7ccSsqA6s3LMxe8biC4A6aDHe7SEgOnAgU6ay5KjvZuivL24+x48v001pUudTuUAttm15SCsyhI4RCD8N/Wzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHZvwieB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHZvwieB"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ec6188so14523855ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 17:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789950789; x=1790555589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rMRLgcYmgr1ReQQm9bu3ytCdU9X0QEixo1U1Eo8/PJA=;
        b=JHZvwieBH0u7ScD1d6le0c8i4r3zobbI8/gzbWKCwb6tYkQXHTncEAJZpRWJm0vm3+
         nzTunqQzwLzXwgN714hKUEtbcJ7C/LUuaRkVf9xDx6PxcKpcWaUnv4t5pfKyRWIu46tj
         Uw3a275P4uAGyz/MSd09TQTWXSxmBA0nUWhiKLiXGwhJ9jeRbntTu6gKx96HY1sdDtev
         IRO1OfUHeyIyQm1eZZp0l16FbCRjU8Ok6R4hDWM40CBZKdLkRqDghgbWR4jvRtEDzOsV
         E/iUQQ8709WwV8O8wgMVVVpT6ov18Y21HK65w9VYMwWBZuqOhaonic4fVN9SzZXNaGXV
         09vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789950789; x=1790555589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rMRLgcYmgr1ReQQm9bu3ytCdU9X0QEixo1U1Eo8/PJA=;
        b=1/mygD1x1G5yDLs5sjusKUgwYaLCflKzr6EL6QeFCKIYLrLDHFJ+b0wvysYxWOBJ03
         qKNE2PAH+aExSbyACIQIaB/iCeYciXudzdgfwQPle8/U+0WbCV5YdiNgtIn973GpHtxS
         TBVFNBGilPhNxT4iS+HGgNeM2RAHEO6Jl3xretl6OORJ7Nefa3NQCuINrUDvvsyWAL6c
         3qNym9RELCxytEPgoR31wRYhQQL+kqv2StayM38M04IbHEw3uQ5lY+v/cyhU8RbPpEYZ
         c2OhO7OvGgjgh7xabUDzN1X1HKG6DtjbW77cJRViDquO+pYpwgziGw2kXvLhWkVenAu3
         QJ0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZ2Y/J6k7hckHSK3NNObqvQr88ShtTCSmMC5/iTzowRF60jv4ouaPBPJ/kQ+ri4lcNdcDb1GY7VarM9TrkH/8Z@vger.kernel.org
X-Gm-Message-State: AFuF++lP/iOXb7OHrkKHhuyA8IhlyMNqK1nWiKJwBuc8KaN3hQg/yKFS
	bQqoGS+V1E1ZTcaF8FZj8t3mzNfeoF9gdj0DlLAne4pyxGX1IEXu8YHV
X-Gm-Gg: AYBFou3v61P/n49sZQAQLJOqY6iIhVAc+X4vn6ZL43ISTDgL2oydbuEmqOEWwOeEoDq
	R6u4m1QrQQ9MSmSFZDLnb2hFukqK6eJj/VubwYMKtWUpFJt2vMekt5jtKEprmWeHMuMwltgKPZn
	ZmHQfsZRVULEICubcRVEujb0D9loVpmcUc593aKzmT1FeqXxnPaooBCnsUPEKXi7V8YJSvqyQbZ
	L9vszAe1IfXsMyt6vXXXp3i7AYZ82qUhgp71+WDWN2t2iTLw5efUZaLK4avd/ll/V+0JH/jOP0e
	GcCG7TToqXTF0P/50a9YgDM308oDqt4un0KzZzOhtJIqfSFspjSXCQjrRNe1qHBDyoDbrA0WAWf
	ZCkh3M2+tnhEM88t8scX4dpxlgVjXBm6sCrfaCy3Pa44iC3k76GgygIo4oookoDnHch9rgOIDZ8
	pb1zfVL0mAWuklnLD8zFPD7q8G7gmFnmOeigJRMqGSt1p+Xq/1kAZMJmK6GVgwtMAbNtqhgy0YJ
	bpteDWejhSDP7DZi5VbBXZFRMSd0NnrY/x2w3e8U6Zh0avK7qZYq5hOGcvrjIr0SvTq9t0DYIBE
	FiBicXsxJrEC/Ajcw8b6
X-Received: by 2002:a17:902:c948:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2ddb1ab39edmr133532675ad.4.1789950788805;
        Sun, 20 Sep 2026 17:33:08 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df44673b36sm8566115ad.0.2026.09.20.17.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 17:33:08 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf/core: fix user->locked_vm leak on secondary mmap()
Date: Mon, 21 Sep 2026 00:33:06 +0000
Message-ID: <20260921003306.426050-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919221728.3707189-1-benquike@gmail.com>
References: <20260919221728.3707189-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()") hoisted
`user_extra = nr_pages` ahead of the existing-buffer checks (`if
(event->rb)` and `if (rb_has_aux(rb))`), and subsequently
commit 5d299897f1e3 ("perf: Split out the RB allocation") and
commit 2aee37682391 ("perf: Split out the AUX buffer allocation")
carried `long extra = 0, user_extra = nr_pages` into perf_mmap_rb() and
perf_mmap_aux().

As a result, when an already-allocated ring buffer (`event->rb`) or AUX
buffer (`rb_has_aux(rb)`) is mapped again via mmap(), perf_mmap_account()
is called with `user_extra = nr_pages` instead of `0`, charging `nr_pages`
to `current_user()->locked_vm` on every additional mapping. However,
perf_mmap_unaccount() and perf_mmap_close() only subtract the ring buffer's
and AUX buffer's pages once when the final `rb->mmap_count` /
`rb->aux_mmap_count` reference drops to zero. Consequently, every secondary
mmap() + munmap() cycle on a perf event permanently leaks `nr_pages` in
`user->locked_vm`, eventually exhausting `perf_event_mlock_kb` and
`RLIMIT_MEMLOCK` (-EPERM) for that user.

Fix this by only calling perf_mmap_account() when allocating a new ring
buffer in perf_mmap_rb() or a new AUX buffer in perf_mmap_aux().

Tested in QEMU against Linux 7.3.0-rc3 with a standalone C reproducer
running as an unprivileged user (UID 1000, RLIMIT_MEMLOCK=0,
perf_event_paranoid=1) that opens a software perf event, maps a 65-page
ring buffer, performs 10 secondary mmap() + munmap() cycles on the same
event fd, and then unmaps and closes the event. On the unfixed kernel,
subsequent perf_mmap() calls by UID 1000 permanently fail with -EPERM due
to the leaked `user->locked_vm` (650 pages leaked), whereas with the fix
applied `user->locked_vm` returns to 0 and subsequent perf_mmap() calls
succeed.

Fixes: 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Dropped the cross-MM `pinned_vm` / `rb->mmap_mm` (`mmgrab`/`mmdrop`)
  changes (which caused an RCU softirq context violation in `rb_free_rcu()`
  in v1, flagged by sashiko-bot) to keep this patch focused on the
  `user->locked_vm` leak on secondary `mmap()`.
- Updated the `Fixes:` tag to `0c8a4e4139ad ("perf/core: Further simplify
  perf_mmap()")` and added QEMU reproducer test details to the commit
  message.

 kernel/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe33fe15689d..8fc15239bd7e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7311,7 +7311,6 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			 * Success -- managed to mmap() the same buffer
 			 * multiple times.
 			 */
-			perf_mmap_account(vma, user_extra, extra);
 			refcount_inc(&event->mmap_count);
 			return 0;
 		}
@@ -7399,7 +7398,6 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 
 	if (rb_has_aux(rb)) {
 		refcount_inc(&rb->aux_mmap_count);
-
 	} else {
 		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
 			refcount_dec(&rb->mmap_count);
@@ -7420,9 +7418,9 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 
 		refcount_set(&rb->aux_mmap_count, 1);
 		rb->aux_mmap_locked = extra;
+		perf_mmap_account(vma, user_extra, extra);
 	}
 
-	perf_mmap_account(vma, user_extra, extra);
 	refcount_inc(&event->mmap_count);
 
 	return 0;
-- 
2.47.3
