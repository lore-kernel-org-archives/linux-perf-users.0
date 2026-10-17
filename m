Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667146C4AA
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792249685; cv=none; b=AfAgCgmz1wtDj7vN+lDIziqQbEtKWtz7LD6x6dmo5VkPvWzo30RiW14c2WHfXJ5+k+8newFxDH/Tr3nTt99NU0Zl57LVegnkBkhWorSDILHUkuv8amMpx32YlC7/Yf/6nCb47UN0Ll5X8H2Mxvn7b+vPYhdfi6T9fon1Ija4jXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792249685; c=relaxed/simple;
	bh=Kg6BdoFIkjeOzKCsxysAUmbbDHrUmYo8GVsjvFtXfnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfN8C3Yf4UNf5WAH9ZGe5oHPa5pjgEguZWTlZNl43L30IiUe4n/n5Ukf133yir3hN1yuZf3kA86ayA4/tMPvby2Fss9Y1KgLYHKCi2dRMaRX0Ag71v9eBya+oSOMjNH8f2NuRz2/fIb8c6lXJv+ME4PJg/zuXlvLuAs9nxKS33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icHbXWKu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icHbXWKu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd76b1361dso3485545ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792249684; x=1792854484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HpFyQ1JhzFAk3k0PVXxqxnjjqP5mAKjbBeavfDK0fBM=;
        b=icHbXWKux6qrJAvbdoEg0q4tlo5nS4+5zJZsrjBo582xcgYau+iOv4Njim/kEcjrcr
         lFHmxK/zBnEt/P7OcS0mFMVyVv5B69UmpzSzohKCk+SuD67BtpPD6xHANDrgFZbxZjI6
         AXE8+E/hgdW8yMOI0o0CLBAUO2u1603h/sw5KryWhO8o3iPwotgrcpobwNLtRWYLzzKY
         xJGTc5TK/SYZv1P4JPiUC+KKOZXPoPo4TNXQko2DsBLntHVv7R0qVCFTeUOpPBuj1X1c
         hP5qLqlXlOo8O6pJiIvpKqMPEFfcoF1P96kpvctYfKnZ62XiF8QaQlSN5UMChQN3vqMP
         Ng3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792249684; x=1792854484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HpFyQ1JhzFAk3k0PVXxqxnjjqP5mAKjbBeavfDK0fBM=;
        b=KwOuzloEloT2psrql/EP1JDjwAKIQstSh3qzdo4IynLJ61qAfsHhS18r+zLMdBw8n5
         BQc/A7U749IsuUCcHAtlz8nuBF3DYNsRjFhag+nmoMDBXpofoIpp2Ny1E9O89PHEwijR
         onzgjeC4Duco3v0cFUGGnVk6eUfh/4ibq5WDrd0yBfgKkU4pkRpg6ST+MjIkFonT/9od
         P9oGqdibQ8HMsdAFB4+SxgCppDISQq2NKX+k3+QTEOe87B6t9cTj8BgpW4oDkynbNYvy
         O/NsXo3INDlXmV8bLMaHSt9HoYbnacGLSV1cfuh1pePo5RoHXq9Jkb9u0PeC56wVFI6X
         NbFQ==
X-Forwarded-Encrypted: i=1; AKwUvByj3a2EH79X+/m/KrO6S5LpuQGXfyiiaXI4EASGWI2ERFWuAn5jGlb7Ip94j6MIv56LfmYLv9eFRtMZ+3Ol2Co2@vger.kernel.org
X-Gm-Message-State: AFq9FYJuTFM9z6tkBT8fs9GkiY2nLwdG9xPZlwNSe7Fp7gYOvE1ke8vs
	k9DrjWXQ3cGbmMxyJDiU9NhaBMkW0o4iDikb0A/qkkH3xj3sKHqwlp9G
X-Gm-Gg: AYBFou1KAyJRQR9jKEYMqF0knGz5oXF9P8MRkoK5sARm/4CZRilzkkfTXOxVm9mVLQw
	K4/Tm2Oixqn8gS/rfDGhutpjguC6sqAi8xxoN3rx8EWJh9npJyDYlIoHD2dS/SqFg5lT2KYW3xD
	ywdfH0W9ONBu4lhDYCeN09k7CT8P8GXBYuG7KDvYVgLJy6/8t1NjaDFNUQgB9xQ1cCKpy9VjNUx
	oJDfUowh9TZQGJ9/K7Few/IEuTQxWeOyePtbLtfQPPXD9e7k+6Ic4QJjYZNGikWVfL4bkEVlS0h
	IbyROrRPpVGrVw0AUayhg7FYhKYCE/qXcBq5sXeA4x3kYG7xPQYwwuO5VP4tDdHM0VysvfivwfG
	CFUyEGQi98vvoeG/dhPOzE3SVOdR58J+kP22eK4W7twsglMdkxZqCrXQiFh2/oeZRS/HWQQXsta
	HfVbheIfJI6++2kmwqk/KnJhw37+j4puz9uElnTwCiBRUNVagE8zJSW/Omas2xUPJUev3KBdxna
	HW/ZLE6rMu72ww12ejREg==
X-Received: by 2002:a17:902:f785:b0:2e9:87e8:71c8 with SMTP id d9443c01a7336-2e9a6834941mr28772055ad.4.1792249683767;
        Sat, 17 Oct 2026 08:08:03 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e305f1dsm22815045ad.0.2026.10.17.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:08:01 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	elver@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/core: Close owner-list publication race with remove-on-exec
Date: Sun, 18 Oct 2026 00:07:47 +0900
Message-ID: <20261017150747.1119197-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016084508.GQ2009045@noisy.programming.kicks-ass.net>
References: <20261015123416.795008-1-4ncienth@gmail.com> <20261016084508.GQ2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_event_open() makes a user event visible in the target context before
adding owner_entry to the opener's perf_event_list. For a remote task, it
also releases exec_update_lock before adding the list node.

A concurrent target exec can therefore process a remove_on_exec event in
this interval. perf_remove_from_owner() sees the published non-NULL owner
and calls list_del_init() on the zero-allocated owner_entry, triggering a
list corruption diagnostic. With BUG_ON_DATA_CORRUPTION, this panics the
kernel.

If the diagnostic is non-fatal, the open path subsequently links the
ownerless event. Closing its file descriptor then frees an event that
remains on the owner list, leading to a use-after-free on the next list
insertion.

Keep the target exec_update_lock held until owner_entry is linked. The
documented lock order permits exec_update_lock to nest outside
perf_event_mutex, and target exec can no longer observe the partially
published event.

An unprivileged remote-task reproducer triggered the NULL-link panic on an
unmodified hardened kernel. With corruption reporting made non-fatal, it
reached a KASAN use-after-free in the next owner-list insertion. With this
change, the patched hardened kernel completed 1,229,779 remote opens during
60 seconds of concurrent exec without a list diagnostic, oops, or panic.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Keep exec_update_lock held through the existing owner-list insertion
  instead of repairing the race after partial publication, as suggested by
  Peter Zijlstra.
- Rebase onto current mainline commit 58161ead29e5.

 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f6..2fdd8d71dcd55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14246,15 +14246,15 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	mutex_unlock(&ctx->mutex);
 
+	mutex_lock(&current->perf_event_mutex);
+	list_add_tail(&event->owner_entry, &current->perf_event_list);
+	mutex_unlock(&current->perf_event_mutex);
+
 	if (task) {
 		up_read(&task->signal->exec_update_lock);
 		put_task_struct(task);
 	}
 
-	mutex_lock(&current->perf_event_mutex);
-	list_add_tail(&event->owner_entry, &current->perf_event_list);
-	mutex_unlock(&current->perf_event_mutex);
-
 	/*
 	 * File reference in group guarantees that group_leader has been
 	 * kept alive until we place the new event on the sibling_list.

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.55.0

