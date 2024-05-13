Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29414A4F8
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596821; cv=none; b=nislNPQBR9iprQ31GDwU522RXJfn7WKn+IadNZazOEcNZlxYmNAM8w6exdS1+L3lBJmUTqvy5Dc2d4VietYEFXSpltvgvQOsx2lJ9zzWdmzhHFXZvZ0IMdfgHufqGG22P70UPQEpoNgvk8jnTmbpWHaahc3Y3F23kohHJm0UBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596821; c=relaxed/simple;
	bh=p5Q2GOl/EQWCxna/AMLd/bkO94wUGNtC6V8AMrx57Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lf8fh4pgSYf6eN6n1ba2Dd8lOYfD0ZnOW4vMzn8h0Ju/6C7jypr9pMPmskB7TXtPgOqWAWdDPefVXuCkjJlTZpFjY/TuFtB/JusL6C679ArI5kC/LVdZPq0xh/QXwhMxyR/VmN4NwUonuBhblo/7jE+sUAmcrKEC7Q3HPPXyw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=CE9MvLLl; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="CE9MvLLl"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-61eba9f9c5dso3193438a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1715596819; x=1716201619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrlM4I62umYG/2gHEkVTt/muxhnq5jSDYrq38HrPJW8=;
        b=CE9MvLLlXUflQyZ9Qt854g+49ghciZv/hc8XLgHLSLLmaQtr4eDTDfsZ4ZgTTjiomM
         Ke2YjrNFuUjY8kTnwqiUL8WKQ5VJ4sLgk9y6A/asISL0LxeBQPjlvJqJUbtdbABTKt0h
         aP+dvmJ7h85JIELizJZOx2hxEzR/IpvKPP3ndU7T7IsI7zZMnmKPI1Fi0SqqC+14M9CN
         H1woc4JbSLCH373DtuvV3zCP93ON4DNs4HeejPImHC88Dwum1EtxbAxbvI6XtPCTj1mN
         GvQF96vG1umWNqaPwYetKTk/nb03bXCZEyzXQiMqBAqOaOSXLRq0kUDKccuNcHBnJJ/k
         ECqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715596819; x=1716201619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrlM4I62umYG/2gHEkVTt/muxhnq5jSDYrq38HrPJW8=;
        b=C4016mHHu6z/oMdYEb9flmMvEJsKFCVUcim3xvJWcQDpZXwHVDfy0KReTxLScMJU+x
         mswqYkzQ9o+grqPFkCYBpaZREYNSR/FV2LwJDdZmRfSL4Lle8fD2TJVONSdRwh1al4ls
         DR0L/hIm60eE/xVRi6FEqHJqbaHN4t3nQqKwJKgmgy2I2+TP1l/WzbBkJMfzR14C0/UX
         enRzVuq2Wh6wjqdptBVO/mTOh5+CYIXabG9zWJSZG6WO0YWky27mOJc9UF0AVF/8vTzI
         YxyLcaqABcCJ86ZkzU6X6rEJ/TDHJwBT7GussM5WNHOvI9IAd3lDg7JNv6PX53aO/nXJ
         14zA==
X-Forwarded-Encrypted: i=1; AJvYcCXDxM8XUyw7RKfRwyObZkxX/kZ69XzZ9n1DH640poRMhPr/Df6fgb9TqF0stQVYLiF9mqbnh/cO6qerZlRFPFhZ+sua7m2Vf915iOoWm0tO1Q==
X-Gm-Message-State: AOJu0YwNrJivAQvQGSLBLOzLKTQzLEpcl11XFHwDMstphqwRapjs4dHd
	fOVphs1E1hsKrLB7AMm3oCRV7gw8WvcfVWzooxHCxmSRtMTwwjMtGaT8Vxsdz9Y=
X-Google-Smtp-Source: AGHT+IGRyBW7aktP1xEoJkajy/bs6gnaIULhIW0yiuFcyofLUbDpxdGDsFqSLkmu3UQWeXdtlVTKww==
X-Received: by 2002:a05:6a20:dc95:b0:1af:7646:fc14 with SMTP id adf61e73a8af0-1afddf12766mr8682701637.0.1715596819107;
        Mon, 13 May 2024 03:40:19 -0700 (PDT)
Received: from localhost.localdomain ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30baesm76338985ad.158.2024.05.13.03.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:40:18 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	frederic@kernel.org,
	mark.rutland@arm.com
Cc: acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v4] perf/core: Fix missing wakeup when waiting for context reference
Date: Mon, 13 May 2024 10:39:48 +0000
Message-Id: <20240513103948.33570-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, we found many hung tasks which are
blocked for more than 18 hours. Their call traces are like this:

[346278.191038] __schedule+0x2d8/0x890
[346278.191046] schedule+0x4e/0xb0
[346278.191049] perf_event_free_task+0x220/0x270
[346278.191056] ? init_wait_var_entry+0x50/0x50
[346278.191060] copy_process+0x663/0x18d0
[346278.191068] kernel_clone+0x9d/0x3d0
[346278.191072] __do_sys_clone+0x5d/0x80
[346278.191076] __x64_sys_clone+0x25/0x30
[346278.191079] do_syscall_64+0x5c/0xc0
[346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
[346278.191086] ? do_syscall_64+0x69/0xc0
[346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
[346278.191092] ? irqentry_exit+0x19/0x30
[346278.191095] ? exc_page_fault+0x89/0x160
[346278.191097] ? asm_exc_page_fault+0x8/0x30
[346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae

The task was waiting for the refcount become to 1, but from the vmcore,
we found the refcount has already been 1. It seems that the task didn't
get woken up by perf_event_release_kernel() and got stuck forever. The
below scenario may cause the problem.

Thread A					Thread B
...						...
perf_event_free_task				perf_event_release_kernel
						   ...
						   acquire event->child_mutex
						   ...
						   get_ctx
   ...						   release event->child_mutex
   acquire ctx->mutex
   ...
   perf_free_event (acquire/release event->child_mutex)
   ...
   release ctx->mutex
   wait_var_event
						   acquire ctx->mutex
						   acquire event->child_mutex
						   # move existing events to free_list
						   release event->child_mutex
						   release ctx->mutex
						   put_ctx
...						...

In this case, all events of the ctx have been freed, so we couldn't
find the ctx in free_list and Thread A will miss the wakeup. It's thus
necessary to add a wakeup after dropping the reference.

Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
Cc: stable@vger.kernel.org
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
Changes since v1:
- Add the fixed tag.
- Simplify v1's patch. (Frederic)

Changes since v2:
- Use Reviewed-by tag instead of Signed-off-by tag.

Changes since v3:
- Add Acked-by tag.
- Cc stable@vger.kernel.org. (Mark)
---
 kernel/events/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f0c45ab8d7d..15c35070db6a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5340,6 +5340,7 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var = NULL;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -5380,11 +5381,23 @@ int perf_event_release_kernel(struct perf_event *event)
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
+
+		if (var) {
+			/*
+			 * If perf_event_free_task() has deleted all events from the
+			 * ctx while the child_mutex got released above, make sure to
+			 * notify about the preceding put_ctx().
+			 */
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(var);
+		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
-- 
2.25.1

