Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759511DF723;
	Thu,  4 Sep 2025 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945401; cv=none; b=uE1EbT+N7SUVZFJwo10ykPVMVNcV1ReGTOEtUztZ1TUyppJt89l96cDZAv6PBmfcTSwzAwyDaf3y/mZrzpjla/sOf0SByml2FG9Nvvc5eEyqE11juT1q+6sZRO3uw1FcYQayFFAnYz0H1IVPKlCJaKfiDF8FEg3bhj/6kwVhBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945401; c=relaxed/simple;
	bh=U7CutZhDSDeFyrxaFAIBsWLB2f2n69YdYMG7rkCCFZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI+WRyTHcLg2ZVPey9ugX8Nacm9mum3gljoJBHNohufGaBYdxAlxs8RBLiXo54n7b4qkXQTB9EUy6AbFBJJ2Ybf3QWDCsYLqK5SrHmM5DxZWLHo4EUI5L4pgCGqmyYT4ex42xKrYhHgfXm1EKzBdz4di859KmJHgEEeWBZZRxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTx3t0Hi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTx3t0Hi"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-772481b2329so570227b3a.2;
        Wed, 03 Sep 2025 17:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945399; x=1757550199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18zaW3moNW/J2OB76TZ6MBmnN/MPkuC7bfXPlyWG+/g=;
        b=CTx3t0HiVxEY9Gt7Tm3NdKOobOYNjqf9+Mr48lRdisFhPl8n8R4iCmwmDmArcssj66
         eMtCaI6BnT1qS7DvxZcKSTSAC1Mjg/EYi9wPAhQimgwnKzOWtSxJNAqi9rIK3GrUIaKb
         6roB4sjl/KsNhdJCfi7u5xRoxuHzNMsFUaApmC/KDPur8J1buxVfjaH7YX0xfR2fiE6c
         jspd+CH+QEiQ+TyNJxEJgHhvVgai/PyQ2chZIwdfjoTYFRldA7IXPDo8CwgYNB/yxTcM
         PzH46EnhIlTNu7YBPi0aXiGXpG9KOdYB+0Sub/qVwIctIXgt9ydtEAZjtQ7Zi92qSLpM
         vApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945399; x=1757550199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18zaW3moNW/J2OB76TZ6MBmnN/MPkuC7bfXPlyWG+/g=;
        b=O3t14s1cR3r7sfqmiuE8Ob3+hjY8Yt9pys/SMf3x7Xh100cWdW/C3DBeTTR7VyqY8M
         pj7GpiTJwlBjpK1tMw8mzB9dPaxZWcXQTtHNvp4xYO4UKK/FWz8355oFDmb1NhY9hG3e
         B11atQfCQ/OS1XXQeYZZ/VYVyvm2bSxJ0bVQG1ugoN37mFi36TBqa/wFb/47EoqrW6BA
         ioloYT32YWFlTbKWOimHv3hzNSk2qs6IN74Zo+8tcCDngllCvuNL5qPfXMfseo/KhxgA
         y/BAUj0slGm+1R5odB1rdTcDSWtZPXSIXAKxvicsHWE5zCSUAoQjGd1Md4ZUghnr9qSO
         njgw==
X-Forwarded-Encrypted: i=1; AJvYcCWC3vzosVw/A8eWhCwkuVtXCV9sofI8hjuIIktS5D32+u92+ZjB11JSUIAPgog9JhcRMsvB1z3wBwbzEFDFFopuClUj@vger.kernel.org, AJvYcCWcFm5+0QX8P/x1mDkUMg3IyDkRXVVoIVUFNrxigK1snSvOZ8aO1NBx0Rdi/vOAKqLO0/LxaoXKIxKmO5vFx4TP@vger.kernel.org
X-Gm-Message-State: AOJu0YweMP4VrCrcWhNPT3YwhjQYZbbaSs1Hbp3Gra31NX0/3TPLpwOq
	KZ/Ii4iv7X2M9eEKgF2LrH1Uh84J07eKihwrVE5Ujw8RWKB9zi/oimihugfVD0RYGbxUkw==
X-Gm-Gg: ASbGncsQcziw0U7y4VRu07VkLhm8p3WqJop6GC22EGtFIIFSd6IHl1MGlBBF6u5QvN/
	beaYDpas8w0Ro2Mb4gSwX/KMcB/6JUJJ0g9fJ8eA0BRyX5pokQsBUQ5MI6EZQSoDpR4FlKWQHYX
	Dt6NSa/E1DEpv00vmvMpzVCYFv40dAJOGy1Y0qM8DEqmK+OJAVc/Xys7ykyZNgR5QiI1tVCUf4s
	r5NKj7fEMD4UQq3MOJVLxNw06CsuSExYVF8q6sMPJFZKKjOukV8Ann5UvTpwc6ENiNTnMOLQMw0
	R1DmKHYZvoKAM8eyaKSKf66PXo750pQJaiCCAq10+xeptKQClE+an82GRd5gpH2/SLrczCGlXtZ
	rp1SsgS6qX9YLt/DzI4jV0lPjEC4YxKA62NRQNbyr5WyRS9ur5F16
X-Google-Smtp-Source: AGHT+IFn+y2P+lkSjCxmHbNPVMFNCQGc4aVUADK0EWUrb+8UNHFLYez+kqXUbc2XvO+u3VVteAjfqA==
X-Received: by 2002:a05:6a00:3492:b0:772:5899:eae8 with SMTP id d2e1a72fcca58-772589a2e50mr16425370b3a.27.1756945398629;
        Wed, 03 Sep 2025 17:23:18 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:23:18 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 10/18] mm/ksw: add per-task recursion depth tracking
Date: Thu,  4 Sep 2025 08:21:07 +0800
Message-ID: <20250904002126.1514566-11-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement depth tracking for KStackWatch to support stack-level filtering.
Each task's recursive entry depth is stored in a global hash table keyed by
pid:

 - get_recursive_depth()/set_recursive_depth() manage per-task depth
 - reset_recursive_depth() clears all tracked entries
 - entry/exit handlers increment or decrement depth and skip  if the
   current depth does not match the configured depth.

This works even across task scheduling or in interrupt context, since depth
is tracked per-task, ensuring KStackWatch can selectively monitor a
specific recursion level without redundant triggers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 105 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 00cb38085a9f..8758b8b94f7f 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/fprobe.h>
+#include <linux/hashtable.h>
+#include <linux/hash.h>
 #include <linux/interrupt.h>
 #include <linux/kprobes.h>
 #include <linux/percpu.h>
@@ -12,6 +14,81 @@
 
 struct ksw_config *probe_config;
 
+#define DEPTH_HASH_BITS 8
+#define DEPTH_HASH_SIZE BIT(DEPTH_HASH_BITS)
+
+struct depth_entry {
+	pid_t pid;
+	int depth; /* starts from 0 */
+	struct hlist_node node;
+};
+
+static DEFINE_HASHTABLE(depth_hash, DEPTH_HASH_BITS);
+static DEFINE_SPINLOCK(depth_hash_lock);
+
+static int get_recursive_depth(void)
+{
+	struct depth_entry *entry;
+	pid_t pid = current->pid;
+	int depth = 0;
+
+	spin_lock(&depth_hash_lock);
+	hash_for_each_possible(depth_hash, entry, node,
+			       hash_32(pid, DEPTH_HASH_BITS)) {
+		if (entry->pid == pid) {
+			depth = entry->depth;
+			break;
+		}
+	}
+	spin_unlock(&depth_hash_lock);
+	return depth;
+}
+
+static void set_recursive_depth(int depth)
+{
+	struct depth_entry *entry;
+	pid_t pid = current->pid;
+	bool found = false;
+
+	spin_lock(&depth_hash_lock);
+	hash_for_each_possible(depth_hash, entry, node,
+			       hash_32(pid, DEPTH_HASH_BITS)) {
+		if (entry->pid == pid) {
+			entry->depth = depth;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found && depth > 0) {
+		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+		if (entry) {
+			entry->pid = pid;
+			entry->depth = depth;
+			hash_add(depth_hash, &entry->node,
+				 hash_32(pid, DEPTH_HASH_BITS));
+		}
+	} else if (found && depth == 0) {
+		hash_del(&entry->node);
+		kfree(entry);
+	}
+	spin_unlock(&depth_hash_lock);
+}
+
+static void reset_recursive_depth(void)
+{
+	struct depth_entry *entry;
+	struct hlist_node *tmp;
+	int bkt;
+
+	spin_lock(&depth_hash_lock);
+	hash_for_each_safe(depth_hash, bkt, tmp, entry, node) {
+		hash_del(&entry->node);
+		kfree(entry);
+	}
+	spin_unlock(&depth_hash_lock);
+}
+
 /* Find canary address in current stack frame */
 static unsigned long ksw_stack_find_canary(struct pt_regs *regs)
 {
@@ -119,10 +196,21 @@ static struct fprobe exit_probe_fprobe;
 static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 				    unsigned long flags)
 {
+	int cur_depth;
 	int ret;
 	u64 watch_addr;
 	u64 watch_len;
 
+	cur_depth = get_recursive_depth();
+	set_recursive_depth(cur_depth + 1);
+
+	/* depth start from 0 */
+	if (cur_depth != probe_config->depth) {
+		pr_info("KSW: config_depth:%u cur_depth:%d entry skipping\n",
+			probe_config->depth, cur_depth);
+		return;
+	}
+
 	ret = ksw_stack_prepare_watch(regs, probe_config, &watch_addr,
 				      &watch_len);
 	if (ret) {
@@ -132,8 +220,8 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 
 	ret = ksw_watch_on(watch_addr, watch_len);
 	if (ret) {
-		pr_err("KSW: failed to watch on addr:0x%llx len:%llx %d\n",
-		       watch_addr, watch_len, ret);
+		pr_err("KSW: failed to watch on depth:%d addr:0x%llx len:%llx %d\n",
+		       cur_depth, watch_addr, watch_len, ret);
 		return;
 	}
 }
@@ -142,6 +230,17 @@ static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
 				   unsigned long ret_ip,
 				   struct ftrace_regs *regs, void *data)
 {
+	int cur_depth;
+
+	cur_depth = get_recursive_depth() - 1;
+	set_recursive_depth(cur_depth);
+
+	if (cur_depth != probe_config->depth) {
+		pr_info("KSW: config_depth:%u cur_depth:%d exit skipping\n",
+			probe_config->depth, cur_depth);
+		return;
+	}
+
 	ksw_watch_off();
 }
 
@@ -150,6 +249,8 @@ int ksw_stack_init(struct ksw_config *config)
 	int ret;
 	char *symbuf = NULL;
 
+	reset_recursive_depth();
+
 	/* Setup entry probe */
 	memset(&entry_probe, 0, sizeof(entry_probe));
 	entry_probe.symbol_name = config->function;
-- 
2.43.0

