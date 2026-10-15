Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DF51C077
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067670; cv=none; b=W6v4yRVgQpNk48tf3QV6KKVIsxlqGyALzEGl3gZc876frCn3qv+EP9p4M29ZWBEV8a6xXTa4+WmX2w1Lc4ivvrBtQYTnKJdUPnTBvEJ1CKJDJkOKqwjbeBLJ9RGSyG9heFb/zrGLe5/ByAUoMEuKKcMp5nIDmoJVrRJZh7phiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067670; c=relaxed/simple;
	bh=6RYCJTgmZtkhTJF0IB6+IuC6pGbjy5IhOnHcNqjkuBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ulm5g/ViKdddCtFrvIf9PV90z0+f1AJS8YiBFuTZF1UJ9leHhFIiEZa/YNztCjTivgPNoDe5a28DSL+L4JRJFpJ8FzwqqthdmjnLuScLH/zPqUBnCe7oSWTXW9CDxjNDF9Zqw5hl5QFzUH702dW45bUrNsBnkNXi49uNvXlV3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bes+hyL9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bes+hyL9"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so49023a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792067669; x=1792672469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuIQxTwfSJeHtZkn09gsG33Ccv5vPWVkF/kC4waNbbY=;
        b=Bes+hyL9Gkg2QnWiLjSO7paxXpTj8q8o+7xp0hD4eT5TyitpciP5VjBUkruqGr8qnd
         AUp7tKX0/tQmzet2x+L5+1nejaeSgltV9+JQGzrZt8hM60yGd8woKFFoByYE3+R6T+jg
         c3CQJD30XJZkFlMoxBSVzRrtkBznVTgE3M9AU7g7MI8LEUcpKMS5WQ/jq2/Gfaj8s7Uy
         kIKua/ipYWIPcc/AqFO4iQsM1Sdz6Qdz42z2bXMl2mk7eKP7zWIa/LNY8+xkdkPboy8Y
         6NfaDYgA79uzWwRLExul81/0dLyM9lYnSv5+ZhWOA2jGyj8JsS+RoJ9PhsuUj4AKk7oM
         k0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792067669; x=1792672469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuIQxTwfSJeHtZkn09gsG33Ccv5vPWVkF/kC4waNbbY=;
        b=b0nBJCthqlpcY7EupzpqIltESDi6g33GFOAIkLHvUG0tAdDpl4xJCS3AVMlrcYuuaJ
         BBGA2ZlscQ8wSXXVVWQ5w6ROQuEkhUOEObG/rzMGKscfDyZVxucP6JmbQaCvx/3y03Ov
         MhgOI1W+vbkOIWCTczp3u491tVJaG0p+TAmkMeNIuXZR8fU59ggUqRBkKeSnhHZlIYom
         CeZWYctUomzbIG0iXBgHcx49I4XCzBB19/JhCEJBZM7FhiNTGhxEvMyvrkcibLIZViF+
         snzTsYRAA7f/Wz4yAjFBNOE16USxbIPf0WzAlDrGeBed8c7chwk44H20Cs4f3dClrQqH
         cghA==
X-Forwarded-Encrypted: i=1; AKwUvBwA0e4NLuGW/3lum3FLcLrXBGGNqc8IERe7YWaKJOUtLnBQoWokx1SxNYers1cXFPekqFurXI+UhTGbUnBxT/5a@vger.kernel.org
X-Gm-Message-State: AFq9FYLGhGQhn5QoB9q+ePZXhONpudfYLOqbOrMjT+TOXGOed5Odzuwm
	05Nn8jbcP5/91TOxODQg2mJ1lM9ckdIKwccfSu/Bzf2c1B8gj2bq4b2t
X-Gm-Gg: AYBFou2eFWDhHuqpWtWHu6EpiYiNGJjzcEAhtS/yuHyyUYosTs6NR0norjLa1WrtIV9
	9AQtrG+Knb6b+0XOApQYzTprc1u9XAd4Y+mMkGBsTw7vF/E4uYG9LcYVRwZNCkSUQ5/oDBKVxGx
	olFv82Q4ECNIBqOCIlXcQa+I+rh4gRIe82wt1xgQMf9x0PEi/rofjCb1gMueeYlBkhGjiduUGjT
	O5uzAQxY1TtQtbPz6ktGy8BH0vCecXfo1bZqAtQCeBL/M3gGXcaxSlOj5yRHGLoFc034azt4g5Y
	M8P7p7k3GKHXvn7ZeN3tjIZDmhy4jYOHrb8dbp0vJnrkMRM6PLKl8zVMSJf+czf43nI2GOvCr5N
	o1GdFjrKZPcVv3yBQ6QVyWxkNu9HeOa3nCQ8dLDh6N4Rllt/H94DnTBWaDlix8Q0GNsxpX2iDuW
	aJxMArrS6h2rdy91C3MzBMILlzlPwHkY8IJ/70fryg8hboO73vZAHOf7fXRgBEW9Of3qz8qa6Cx
	b40wFSPmTU=
X-Received: by 2002:a17:90b:314d:b0:3ac:7556:8eed with SMTP id 98e67ed59e1d1-3ac7556a42cmr3796079a91.44.1792067668726;
        Thu, 15 Oct 2026 05:34:28 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9444a0c6sm4714146a91.11.2026.10.15.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:34:28 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] perf/core: Close owner-list publication race with remove-on-exec
Date: Thu, 15 Oct 2026 21:34:16 +0900
Message-ID: <20261015123416.795008-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_event_open() makes a user event visible in the target context before
adding owner_entry to the opener's perf_event_list.  For a remote task, it
also releases exec_update_lock before adding the list node.

A concurrent target exec can therefore process a remove_on_exec event in
this interval.  perf_remove_from_owner() sees the published non-NULL owner
and calls list_del_init() on the zero-allocated, but not initialized,
owner_entry.  DEBUG_LIST reports a NULL-link list corruption and can panic
the kernel.

If list corruption reporting is non-fatal, list_del_init() initializes the
node and clears the owner.  The open path then adds the ownerless event to
the opener's list.  Closing the returned file descriptor frees the event
while it remains linked, and the next owner-list insertion accesses the
freed object.

Initialize owner_entry when the event is allocated.  After taking the
opener's perf_event_mutex, add the node only if the exec side has not
cleared the owner.  The existing mutex then makes both orders safe: the
open side either publishes the list node before exec removes it, or skips
the late add after exec clears the owner.

An unprivileged remote-task reproducer triggered the NULL-link panic on an
unmodified hardened kernel.  With corruption reporting made non-fatal, the
same reproducer triggered a KASAN use-after-free in the next owner-list
insertion.  The patched hardened kernel completed 1,264,540 remote opens
during 60 seconds of concurrent exec without a list diagnostic or panic.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f6c..5e191757a08ccc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13382,6 +13382,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	INIT_LIST_HEAD(&event->rb_entry);
 	INIT_LIST_HEAD(&event->active_entry);
 	INIT_LIST_HEAD(&event->addr_filters.list);
+	INIT_LIST_HEAD(&event->owner_entry);
 	INIT_HLIST_NODE(&event->hlist_entry);
 	INIT_LIST_HEAD(&event->pmu_list);
 
@@ -14252,7 +14253,8 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	mutex_lock(&current->perf_event_mutex);
-	list_add_tail(&event->owner_entry, &current->perf_event_list);
+	if (event->owner)
+		list_add_tail(&event->owner_entry, &current->perf_event_list);
 	mutex_unlock(&current->perf_event_mutex);
 
 	/*

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
