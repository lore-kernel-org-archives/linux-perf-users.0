Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDEC2BE7A7;
	Wed, 10 Sep 2025 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482353; cv=none; b=tYpz+dSSITfIJhKiC5gkJSw2m0jDi3pf2V3y11KBaDbE+D6dNmQDB+i42gn8HnBUvH2LHZ6FGzDliyPoZKDCtGdY8mqGi6+jJEu/vAz3pzgBi2/7caxbySjy6xvlLGyRKrAKEppklhYpAB2dpJhQw8aWzFRlXXFj1Cxg+ekRbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482353; c=relaxed/simple;
	bh=15VBJBsycYcl0PWHKJjzdoOmi+NENRGyhtLziQQos3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtfQzvxHpXZd7CWg26Xf4Sw6FyavzNShV5u1iKLnsKHHXI6vJFAGB4i7rtoZTZb/rYOqtvD+agvjLfodiuLYe+hVsYk8Kdf6EqrAwG9kcWwJF29lgee79f86CV0nSCDxRgI686AjnGi/1z8bj9ofoK0Iz+JCKFbgW7x809TmixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOCsgrvj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOCsgrvj"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso6913010b3a.1;
        Tue, 09 Sep 2025 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482351; x=1758087151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3evZkOOAwLovlQ4xAZyrzRxNzWtrzok12LdiaOixdrk=;
        b=KOCsgrvjjT57SMtk/3b5Rj76GqEYjQIZRUh6S5bHPJmkckrwBzgO+ez4KKWitjvL7V
         Tw57/XjnqXiSyVHo2gvRwNAs/PHDJ1Fb0UgAGAu2RY09CscDBLJE2O/oiJAyBX6/aZLG
         iK47aSlgNCEgTrjMaG5Xd9Oi2UxIPqOyg7LimmXaSEP2q4ZEcrWKFPn2hCHkq2mzmR0n
         Z5e1rPZ3y8YeBtFXEVNsqenZNKaSQPyw3rw2NjlHCz/cR4Vd9ny6E6Sd8j1Qr5/1Pv4D
         pwhYMUA+C8VItLWoWSN6E/4TC3e80vlNilVuN1xO/y5cmYdmo7fthiKAGzT3kEkQK/WC
         DMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482351; x=1758087151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3evZkOOAwLovlQ4xAZyrzRxNzWtrzok12LdiaOixdrk=;
        b=pdOt62ZTiomsXbJizrHZfZSYdgEzllTups37X8P7JLFXVgFoVRbqz8E8Yxy/BRdeP9
         /bjaQGUNTCAXkQHeXWQ8v6kHPl5zPJgqzoz46eDIUpo/hPwQ8o2JavzkMCX01YsW3BTl
         LINmu8NprYuzjr2SjVYj1Vm3Z7qE9IwZ7IHVdYOfrEYEk5AnUAEJ3LhHJCZhn9LTs/JH
         /8sue6Mi8Uh22ce7DTVTpNqqM0aLQEjA/xC7ERQ2bg2gLrLcAX0MHlLcuaAN/nGRefQi
         FRcAxzTGs7A1SOxUY9DQnamWuosIkp+gU9I9VsFFd4dpaMd1Sufj+SPloH11ieusAHaU
         SLmw==
X-Forwarded-Encrypted: i=1; AJvYcCV99ZWlg+RgOvK+RrXkJ7EZQMVXv41iVYQqaFFGz/Y6pLVt6sgW+OnurTBBjGSC1hnVCjLDcyCOLDZVdHaCiB4mMFSo@vger.kernel.org, AJvYcCVLVvXSjymk7LIc1MGLsBgFAK6ddJq+UUBBW6VhQ5FQSqQpXMzhet4uOHyUVRZ35wxcezzSzJV0aaG67dt9tdab@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJYtAYBqjHCoh9zmd0+CDnFjt0hgSjS7dh1FOgoqq2vC2ykfF
	fq+dyEyZO/z33e9sPzngAhQRDi4vrnIM7rDleVTQ2SIlTBABVEhykUaC
X-Gm-Gg: ASbGnctQ5C2Ni74hDa/mazE7+Vl5GNfWIXEX6f0h0q51uznuZeX9V4Jf9LxbblvdiDh
	wh5r5ITogAqX6WeO8NIwz5EnZkPUJ8RUDON86sUC6fLP9l+w2EPaNqzE+GDIGpNuVQs16fRrcpc
	BojHwYfwFKhk2EC+jRSaJFtZXwF/tjJx5Cg3nxVnT2huxOaGQSnBiIgFsNGLpuE40rOAYkUgknS
	IycrAk+buiYlHhzIACUzl0iEMcAuxSC9w67eROHSc36J4tTBzW0ub4qzHKNeCFzSwT2dbACjDfw
	w9KGjyIyYkBL7H/adA8uj2G3KmUO9nNZEG5t9juTWQr1qsvmjHLr0o5X0uS+h8OW+ZfpdiX8pG3
	TBKyZEe0dXoD5nqVBwfRXQWvMD7//s/aN1RBmK9D0ykgmVgfUaw==
X-Google-Smtp-Source: AGHT+IGgiGpkBgsz8ZnP03+D6W8a7MBFD7GkD9tVVGPHeuidNDi6K7cf2epcquENy/jb+9dIMJJ3hQ==
X-Received: by 2002:a05:6a00:84e:b0:771:f69a:c426 with SMTP id d2e1a72fcca58-7742ddadc99mr21024675b3a.14.1757482351351;
        Tue, 09 Sep 2025 22:32:31 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:32:30 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 11/19] mm/ksw: add recursive depth tracking
Date: Wed, 10 Sep 2025 13:31:09 +0800
Message-ID: <20250910053147.1152253-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053147.1152253-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <20250910053147.1152253-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track per-task recursion depth using a simple hashtable keyed by PID.
Entry/exit handlers update the depth, triggering only at the configured
recursion level.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 100 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 3ea0f9de698e..669876057f0b 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -3,6 +3,8 @@
 
 #include <linux/atomic.h>
 #include <linux/fprobe.h>
+#include <linux/hash.h>
+#include <linux/hashtable.h>
 #include <linux/kprobes.h>
 #include <linux/printk.h>
 #include <linux/spinlock.h>
@@ -15,6 +17,83 @@ static struct fprobe exit_probe;
 static atomic_t ksw_stack_pid = ATOMIC_INIT(INVALID_PID);
 #define MAX_CANARY_SEARCH_STEPS 128
 
+struct depth_entry {
+	pid_t pid;
+	int depth; /* starts from 0 */
+	struct hlist_node node;
+};
+
+#define DEPTH_HASH_BITS 8
+#define DEPTH_HASH_SIZE BIT(DEPTH_HASH_BITS)
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
+	hash_for_each_possible(depth_hash, entry, node, pid) {
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
+	hash_for_each_possible(depth_hash, entry, node, pid) {
+		if (entry->pid == pid) {
+			entry->depth = depth;
+			found = true;
+			break;
+		}
+	}
+
+	if (found) {
+		// last exit handler
+		if (depth == 0) {
+			hash_del(&entry->node);
+			kfree(entry);
+		}
+		goto unlock;
+	}
+
+	WARN_ONCE(depth != 1, "new entry depth %d should be 1", depth);
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	if (entry) {
+		entry->pid = pid;
+		entry->depth = depth;
+		hash_add(depth_hash, &entry->node, pid);
+	}
+unlock:
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
 static unsigned long ksw_find_stack_canary_addr(struct pt_regs *regs)
 {
 	unsigned long *stack_ptr, *stack_end, *stack_base;
@@ -109,8 +188,15 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 {
 	u64 watch_addr;
 	u64 watch_len;
+	int cur_depth;
 	int ret;
 
+	cur_depth = get_recursive_depth();
+	set_recursive_depth(cur_depth + 1);
+
+	if (cur_depth != ksw_get_config()->depth)
+		return;
+
 	if (atomic_cmpxchg(&ksw_stack_pid, INVALID_PID, current->pid) !=
 	    INVALID_PID)
 		return;
@@ -126,8 +212,8 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 	ret = ksw_watch_on(watch_addr, watch_len);
 	if (ret) {
 		atomic_set(&ksw_stack_pid, INVALID_PID);
-		pr_err("failed to watch on addr:0x%llx len:%llu %d\n",
-		       watch_addr, watch_len, ret);
+		pr_err("failed to watch on depth:%d addr:0x%llx len:%llu %d\n",
+		       cur_depth, watch_addr, watch_len, ret);
 		return;
 	}
 }
@@ -136,6 +222,14 @@ static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
 				   unsigned long ret_ip,
 				   struct ftrace_regs *regs, void *data)
 {
+	int cur_depth;
+
+	cur_depth = get_recursive_depth() - 1;
+	set_recursive_depth(cur_depth);
+
+	if (cur_depth != ksw_get_config()->depth)
+		return;
+
 	if (atomic_read(&ksw_stack_pid) != current->pid)
 		return;
 
@@ -149,6 +243,8 @@ int ksw_stack_init(void)
 	int ret;
 	char *symbuf = NULL;
 
+	reset_recursive_depth();
+
 	memset(&entry_probe, 0, sizeof(entry_probe));
 	entry_probe.symbol_name = ksw_get_config()->function;
 	entry_probe.offset = ksw_get_config()->ip_offset;
-- 
2.43.0

