Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590289;
	b=zfZo34chACuz0Glc70QW6cRXOHueMR5HheXKl6F46O8kgK7N1gKjH+IrwO7kGlCNZPJC
	 8vL0WFF2qx75V0SRB702v+XwWPOtCSyfb0JOTf7d4J+6t8kCrKwFqKRS8YEU1u1FaaQ+9
	 VheCnAlS9hSPVZhNMRlZ59afcVUokULCk46uCw/z3gO9Ys0w1JbMJrkzEfrMk41T26zgn
	 51vA29DGMs7XMN8IQdAjPXSyUpYBN9fgLcoQPx4E7+t4KbXH6QGACL+QmGdfPuuMhdqQj
	 JZt1rcEUWPhEromFX0zLiz8ddiMBtFa3pAWZD25GJ+iVcuE/MvHXE4dvwagYrMd5I/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oC+cJXXLzuoEX+jEgC/4KmcXhZJg0lZwgQxJ+TdeiCA=;
	b=44kc58FfmearKTeMpQQNQQ4RBTDrUoMl4zBK7Jb9aqtCk2wbZylB4jdyeUS90IKE3jLT
	 Yl9gr22XmzLamE/5gXzd7FeDLMJ6GoLjZEu4ZySWmdQqDfTDomAZ4amEZnxYhvHzS2O+Y
	 36YXTWBcMk6xT7vvoiedJfb466zJNMfNdlheFXwJa9dYviIdUt3cyYGTYC3prqwPgxow4
	 UTxoltmYRNapQ8rOHBiedaZEJDVsEaOG/taDdkni420SdsUG1W7LpS66WdrCGEPdJT9zc
	 B+ryYsNHG6fMbPBf/JNWcfmbNI1qYPwaG4whOxVZujA3gSGMnu0Y1z9J8WWAGJTeOgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JpxenwU8;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233A607A5E7
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0233A607A5E7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JpxenwU8
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4eb0b989f0eso1998873b6e.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590288; x=1795195088; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oC+cJXXLzuoEX+jEgC/4KmcXhZJg0lZwgQxJ+TdeiCA=;
        b=JpxenwU8MXWmN49Nc0XXymVt0YPRybOmkb8UMPf230VoYdZ+dp656RqfKgOqe6g59I
         IufxsNkj9sYPJClN6GkncF6Y8J6byY957yprvAyvG4UCZYHAgyDLa3jCiOnWouE3QLdq
         OqPmrG0aaHxItO+zFhJY/93i4y7Oahn5iZxe7Zg6ingO6xRxGRaZxddbUwaxmlviv1HU
         /gvj44vpKUyV5jwTc/39iJ8PNLRtE405ZU7xq+zvpoWLGMRVIeBkJ2AAsuFenyn+I0VK
         tGANnZUoRmwJ5w0Ob7XnqD9wWzjIdqzeWiSmKwGeJCU79sVEUUXuD5Oqtp6EnD3V309y
         o9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590288; x=1795195088;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oC+cJXXLzuoEX+jEgC/4KmcXhZJg0lZwgQxJ+TdeiCA=;
        b=M4+20glCnEbux15UwV6knJXiWNw8VoKeYmbqaMUsignjgmQMHmBNiZkzUoCRizogDk
         1yVHTtkLmd7fXKkyJe4m9ZTSLhQWFiBDgGAVd+uzjj8KLQkXMwAh8lGUW0fMhaqWuG6Z
         WQgTmoCx1gpWZMRsi29cHsytob4ijIweY1cVs1XMmJzy1jDJfMokVJ7mI+0XRNN8a8ly
         7633NQVVUaSQ4wQWEvmf9S+PNug/aiOyTqdc18AW/wwfFEGVxL92Yl4uqKMfHntQeOmP
         zIr6cxJMZbMtTy8qk1Of7yXXN/JlxE+dxJCwMCNJUJYOvUzfstjXg5wvrQNTClfjZSyk
         ZHYw==
X-Forwarded-Encrypted: i=1; AL+hErHN3wThR7EysazgjLZ67Hg29qDOV8vwT68Gogz+yhbLpCxceU1d9MLuW9+qevx4vg5U6BacxOIrf4pU/FEUEL08@vger.kernel.org
X-Gm-Message-State: APuU4Z/crGtAqFW6LRs11v4olEBnVwZdi40hGoKn3hNIrc25zf4NC/eE
	FF1Xdj5Z6wSc2hhi/ghcV/hkGUjtKJit21Zi34eKRrLWPfZUPxwDJLWtz1VY2RGZQ+FlgGsjcKi
	Rr/Ky9p1q3A==
X-Received: from oiag19.prod.google.com ([2002:a05:6808:82d3:b0:4f5:740:2bcf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:6412:b0:4b8:4703:db8b
 with SMTP id 5614622812f47-56cd7d0f742mr4801477b6e.20.1794590287597; Fri, 13
 Nov 2026 09:18:07 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:16 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-6-irogers@google.com>
Subject: [PATCH v4 05/23] perf machine: Protect machines->guests rbtree with a rw_semaphore
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Unlike struct dsos, struct maps, and struct threads, struct machines had
no lock protecting its machines->guests rbtree. Synchronizing access to
machines->guests is needed both for concurrent guest machine lookups and
so machines__shrink() can safely iterate guest machines using
down_read_trylock(&machines->lock).

Add a rw_semaphore lock to struct machines to synchronize access to the
machines->guests rbtree across machines__add(), machines__find(),
machines__set_comm_exec(), machines__process_guests(),
machines__set_id_hdr_size(), machines__fprintf_dsos(),
machines__fprintf_dsos_buildid(), machines__destroy_kernel_maps(), and
machines__for_each_thread(), and check for an existing guest machine PID
under write lock in machines__add().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 42 +++++++++++++++++++++++++++++++++------
 tools/perf/util/machine.h |  1 +
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dc0aaac992f9..a300f3c1f5a4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -237,6 +237,7 @@ int machines__init(struct machines *machines, struct perf_session *session)
 {
 	int err = machine__init(&machines->host, "", HOST_KERNEL_ID);
 
+	init_rwsem(&machines->lock);
 	machines->session = session;
 	machines->host.machines = machines;
 	machines->guests = RB_ROOT_CACHED;
@@ -247,12 +248,13 @@ void machines__exit(struct machines *machines)
 {
 	machine__exit(&machines->host);
 	/* XXX exit guest */
+	exit_rwsem(&machines->lock);
 }
 
 struct machine *machines__add(struct machines *machines, pid_t pid,
 			      const char *root_dir)
 {
-	struct rb_node **p = &machines->guests.rb_root.rb_node;
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct machine *pos, *machine = malloc(sizeof(*machine));
 	bool leftmost = true;
@@ -265,9 +267,17 @@ struct machine *machines__add(struct machines *machines, pid_t pid,
 		return NULL;
 	}
 
+	down_write(&machines->lock);
+	p = &machines->guests.rb_root.rb_node;
 	while (*p != NULL) {
 		parent = *p;
 		pos = rb_entry(parent, struct machine, rb_node);
+		if (pid == pos->pid) {
+			up_write(&machines->lock);
+			machine__exit(machine);
+			free(machine);
+			return pos;
+		}
 		if (pid < pos->pid)
 			p = &(*p)->rb_left;
 		else {
@@ -278,8 +288,8 @@ struct machine *machines__add(struct machines *machines, pid_t pid,
 
 	rb_link_node(&machine->rb_node, parent, p);
 	rb_insert_color_cached(&machine->rb_node, &machines->guests, leftmost);
-
 	machine->machines = machines;
+	up_write(&machines->lock);
 
 	return machine;
 }
@@ -290,16 +300,18 @@ void machines__set_comm_exec(struct machines *machines, bool comm_exec)
 
 	machines->host.comm_exec = comm_exec;
 
+	down_read(&machines->lock);
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *machine = rb_entry(nd, struct machine, rb_node);
 
 		machine->comm_exec = comm_exec;
 	}
+	up_read(&machines->lock);
 }
 
 struct machine *machines__find(struct machines *machines, pid_t pid)
 {
-	struct rb_node **p = &machines->guests.rb_root.rb_node;
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct machine *machine;
 	struct machine *default_machine = NULL;
@@ -307,6 +319,8 @@ struct machine *machines__find(struct machines *machines, pid_t pid)
 	if (pid == HOST_KERNEL_ID)
 		return &machines->host;
 
+	down_read(&machines->lock);
+	p = &machines->guests.rb_root.rb_node;
 	while (*p != NULL) {
 		parent = *p;
 		machine = rb_entry(parent, struct machine, rb_node);
@@ -314,11 +328,14 @@ struct machine *machines__find(struct machines *machines, pid_t pid)
 			p = &(*p)->rb_left;
 		else if (pid > machine->pid)
 			p = &(*p)->rb_right;
-		else
+		else {
+			up_read(&machines->lock);
 			return machine;
+		}
 		if (!machine->pid)
 			default_machine = machine;
 	}
+	up_read(&machines->lock);
 
 	return default_machine;
 }
@@ -464,10 +481,12 @@ void machines__process_guests(struct machines *machines,
 {
 	struct rb_node *nd;
 
+	down_read(&machines->lock);
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		process(pos, data);
 	}
+	up_read(&machines->lock);
 }
 
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size)
@@ -477,11 +496,13 @@ void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size)
 
 	machines->host.id_hdr_size = id_hdr_size;
 
+	down_read(&machines->lock);
 	for (node = rb_first_cached(&machines->guests); node;
 	     node = rb_next(node)) {
 		machine = rb_entry(node, struct machine, rb_node);
 		machine->id_hdr_size = id_hdr_size;
 	}
+	up_read(&machines->lock);
 
 	return;
 }
@@ -934,10 +955,12 @@ size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 	struct rb_node *nd;
 	size_t ret = dsos__fprintf(&machines->host.dsos, fp);
 
+	down_read(&machines->lock);
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		ret += dsos__fprintf(&pos->dsos, fp);
 	}
+	up_read(&machines->lock);
 
 	return ret;
 }
@@ -954,10 +977,12 @@ size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
 	struct rb_node *nd;
 	size_t ret = machine__fprintf_dsos_buildid(&machines->host, fp, skip, parm);
 
+	down_read(&machines->lock);
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		ret += machine__fprintf_dsos_buildid(pos, fp, skip, parm);
 	}
+	up_read(&machines->lock);
 	return ret;
 }
 
@@ -1296,10 +1321,12 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 
 void machines__destroy_kernel_maps(struct machines *machines)
 {
-	struct rb_node *next = rb_first_cached(&machines->guests);
+	struct rb_node *next;
 
 	machine__destroy_kernel_maps(&machines->host);
 
+	down_write(&machines->lock);
+	next = rb_first_cached(&machines->guests);
 	while (next) {
 		struct machine *pos = rb_entry(next, struct machine, rb_node);
 
@@ -1307,6 +1334,7 @@ void machines__destroy_kernel_maps(struct machines *machines)
 		rb_erase_cached(&pos->rb_node, &machines->guests);
 		machine__delete(pos);
 	}
+	up_write(&machines->lock);
 }
 
 int machines__create_kernel_maps(struct machines *machines, pid_t pid)
@@ -3129,13 +3157,15 @@ int machines__for_each_thread(struct machines *machines,
 	if (rc != 0)
 		return rc;
 
+	down_read(&machines->lock);
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *machine = rb_entry(nd, struct machine, rb_node);
 
 		rc = machine__for_each_thread(machine, fn, priv);
 		if (rc != 0)
-			return rc;
+			break;
 	}
+	up_read(&machines->lock);
 	return rc;
 }
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 973a59f7c26a..147ce343e370 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -151,6 +151,7 @@ typedef void (*machine__process_t)(struct machine *machine, void *data);
 struct machines {
 	/** @session: back link to owning session if there is one. */
 	struct perf_session *session;
+	struct rw_semaphore lock;
 	struct machine host;
 	struct rb_root_cached guests;
 };
-- 
2.56.1.703.gf848ed807c-goog

