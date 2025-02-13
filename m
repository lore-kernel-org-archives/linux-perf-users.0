Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1F20D51E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437721; cv=none; b=t2L3dG5lYDfK+YG7fM1vz6YK6zsKQyvQ/WCgF/XdupEi+ojvCyN+GApfb1LS7kxvDj8ywRtbvYCnAIIjz3f1QVCI8lAv8f13Y2odYFZeo6VPZWie3b0/dY4f6GpcxUl5IBDpQkcd/PEQf5tYkNUMfKee5TAnfHrr+tmxmuhgHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437721; c=relaxed/simple;
	bh=JrTATGJXLXPnfT36NRdWEwRMkJqStLNhLoyrpg87QNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6FkEVpcOc5/JniVoA06/8Iol5QwDgfxqZV9PJUXZyIZ8xzbP8hn0FjU6fDrIFvuusKUI5DLQm+GHtUr8GAhECbg5PEF4XowDG+EtME31TY7KGAWcx01D4ce41TMpe0etxbOEpOHrvcMwLlSdHMBjyEamFPLQtHk4f5AJaP91vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRF2hl8P; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRF2hl8P"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ab7fa2b5be0so78261666b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 01:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437718; x=1740042518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjAFE95s2BudHj4Rh3WJBU6cX4YpZYt+tVJ8vz3xHhE=;
        b=JRF2hl8P1SI7/umMNjTPMuU9/9nXp9Wo8xBL6967oBCwX5cWX6zyTwhyHRCFn29DBA
         HQJJJ9PYWyGzufpItmr6VjPG4SFV3tlDUqL7YjViGR8Z6EqQ9EyjgeDV5hxqHh0SepGb
         HrA6uTxq3WdZn/eSeRV8kQ2atjlUiuAvp2JOBLzvofIJWep4vTkmOPtyrlNY62g0MPOg
         kXTpnKOCDmiBbfM+aQ9hchV8rwvhNzmT4W/vx8lDhoKudwbACOZwcfiqR7UHn+wwaxNm
         qO00MI9l0F+dnS4R3oJW3UytlZ9S4geJikZTb2WDyQvMOEFhLJn63LXrWtuA7Qxc8GPn
         E+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437718; x=1740042518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjAFE95s2BudHj4Rh3WJBU6cX4YpZYt+tVJ8vz3xHhE=;
        b=gs6dU6lCuig8SYLoQIy0ug+qPoyA03jXgWg2OMJm3pMGbt3KT9AzELXXICRT6cMCoP
         UepGL7YkJ8CrFib3q0J129x8W5/M0ULgloruY03DTTEEOg7lZZlf/5OVBKjLue6AqF/Z
         Zung1wzRjTk6hAQSm6OHj14e3ilcAMTgyUBqxPgW1bqahUxBDQktOXbxIhpaPhFh/YtG
         fCwM6ue+YKO+6eQnr9NN6q2L8cjjGH6nn99mVS6oSfnZFDr7W2h1mykU7UdJ6MTs0PBe
         H+FJV0wNFcA4jZ7RIkrBmaoFgYAvwVtHgrQv5KgNelp12xZnXxpyiCKATsuVe89Ftvos
         yY7A==
X-Gm-Message-State: AOJu0YxcUl7QnSGCwTZsgahu2lX/G89q7nfEWy8GzMpZ+RygHradY11h
	YWlTMvBLHD3IzNVsjXFEREw19xFP8sW2Xe0YZWSIRsiif5AXKrhySn7pnEmsee2GWSgGV044iVI
	zsPso+w==
X-Google-Smtp-Source: AGHT+IH9LwpfT04DDWtCH5j94A3cuMLdIHZO6FgVgF/BHCBKgnawOwnbB2bOallL0yYB74DsbmHNq/kAgJGD
X-Received: from ejdv2.prod.google.com ([2002:a17:906:2922:b0:ab7:a6ca:4d72])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7f27:b0:aa6:a7ef:7f1f
 with SMTP id a640c23a62f3a-ab7f3325255mr587122766b.11.1739437718375; Thu, 13
 Feb 2025 01:08:38 -0800 (PST)
Date: Thu, 13 Feb 2025 10:08:16 +0100
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739437531.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <32b4ce1731126c88a2d9e191dc87e39ae4651cb7.1739437531.git.dvyukov@google.com>
Subject: [PATCH v7 3/9] perf report: Switch filtered from u8 to u16
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

We already have all u8 bits taken, adding one more filter leads to unpleasant
failure mode, where code compiles w/o warnings, but the last filters silently
don't work. Add a typedef and switch to u16.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/addr_location.h | 3 ++-
 tools/perf/util/hist.c          | 2 +-
 tools/perf/util/hist.h          | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 36aaa45445f24..f83d74e370b2f 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -3,6 +3,7 @@
 #define __PERF_ADDR_LOCATION 1
 
 #include <linux/types.h>
+#include "hist.h"
 
 struct thread;
 struct maps;
@@ -17,7 +18,7 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	u8	      filtered;
+	filter_mask_t filtered;
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cafd693568189..6b8f8da8d3b66 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -585,7 +585,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	return he;
 }
 
-static u8 symbol__parent_filter(const struct symbol *parent)
+static filter_mask_t symbol__parent_filter(const struct symbol *parent)
 {
 	if (symbol_conf.exclude_other && parent == NULL)
 		return 1 << HIST_FILTER__PARENT;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index a6e662d77dc24..4035106a74087 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -33,6 +33,8 @@ enum hist_filter {
 	HIST_FILTER__C2C,
 };
 
+typedef u16 filter_mask_t;
+
 enum hist_column {
 	HISTC_SYMBOL,
 	HISTC_TIME,
@@ -244,7 +246,7 @@ struct hist_entry {
 	bool			leaf;
 
 	char			level;
-	u8			filtered;
+	filter_mask_t		filtered;
 
 	u16			callchain_size;
 	union {
-- 
2.48.1.502.g6dc24dfdaf-goog

