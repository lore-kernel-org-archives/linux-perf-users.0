Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464326139E
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423069; cv=none; b=urs/s5F2H3f0ISBIs2ZpXmdb6uaFCYPb+jNf74kol7hYu8NJ+HA4p9MwEXxuY6sI0wryHJlRwSP8huoYDLccPnq/l0J+QmlOvqqztMzSlwIrkEzyYJXcwIjoafnSxpiLN9GXBDylLV3HoNoPodi/hI9NUIMU3XVJSyuudE4Q5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423069; c=relaxed/simple;
	bh=SLA+bDmdTB6ULu5zbTamkrhePwVhtRIJqJ5avVgZmLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=enN/e2l1ov1I6axXryrR1WWXBQO645ls2bP/+TY2IbokKLNsSRjb8d4hCCczhO6kDQOxOoBUV86jB6CNiFiqBuiJib5gN/ORGR+Ybp0ZQYje0SXX87oSuwmy0v2IVVEFtcZb9iWXFEplA62DGw28BQMM5f2gptQgNh5JoeWmh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvcMtr3B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvcMtr3B"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so15728773a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 10:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740423067; x=1741027867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PFYTBhXyGigxmAagzwCn1stPWOoCBAs7wU0xTcNHU0=;
        b=WvcMtr3BKhpwlWndhLCmA9p/SXdw8LBk8rv920dZiUXptu+fxUPfgkuVEqMGsFtn62
         lB3nvxKNrEbYYvP3yDNi4+AxkRi9hdz5FEeshlw5j1/ZPsYvgA9wyYxY/VHximaGl4jY
         2NNFvg8CEeolnF8BKsH+czxzPtjg8Cke7hLSnWrqXL0kaEMi0a1Grs/GVmpZGo89jaEl
         6MEKkDdQ7p8inbdzGU0SQkfKeoBCzvO1NSPPEauwMOJLQDly0jks3e7vQp0ua9vvLkxl
         IKYaer807SgneOy413O1zo06G954bbUvsl3dZmUwj2MNTxql5F1axXwN8oQvfvCKYxrw
         HO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423067; x=1741027867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PFYTBhXyGigxmAagzwCn1stPWOoCBAs7wU0xTcNHU0=;
        b=Ac2j3WO01esdrKlQ5bF0Xs6tPEBU1Y2rzvU9dI44Tuu7sk+rdMM/mjXyWUF5sIPg0Q
         7up3PIydz5tDEBBEeggNGOXW1o7FF3e8rt4QEUw81jerCc45iJaP2YhhsnrlFCloOMt0
         zdFZvKxw8lp8ymaSBK1jAluIEAY5ztY6Ic3pGHuQlw962g8+U+jQ9aF4kjdjZXqKJo5q
         725YdHdRvnvqmWuHsln1sXqM5JtUo2ezUbHVBKZw2E0edOgctXtOM1JupkM/d31WiTdq
         XSpkcswGvCyazj72BGbGI5kEaaGWUOr+ey+SkGqwrxPfmIT2es4fI3rM0kfRu4KpWXkD
         abIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhD2oBtsO5lbpzARn8w+e43UoViMyuVQ0vf45VyHHrUAUAhritsjAMopPsLYput5dAEGsCqnPEebZ1ifFOXw2W@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2x4gzHS98TmYJLbhGAMfeuzlPmrT9QRX2yvbOc9nL3aTOTzf
	liHmqLmaOerCiB3xnTH6hhnoOy5fNM6aS08aB2sxtbsEouXTJSwN/nVZbT8ubA/xio+VOAClsKB
	UIw==
X-Google-Smtp-Source: AGHT+IHBJ0S/vfoZwcwLL32RzZSgNFIQA2ntgsWLkZmiVrk9sGPlhL4/XXbPVBWMgrB6QkbBP2cKfAL4f2M=
X-Received: from pjbph4.prod.google.com ([2002:a17:90b:3bc4:b0:2fc:3022:36b4])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da87:b0:2fa:1e3e:9be0
 with SMTP id 98e67ed59e1d1-2fce78c9247mr22071548a91.19.1740423067265; Mon, 24
 Feb 2025 10:51:07 -0800 (PST)
Date: Mon, 24 Feb 2025 10:42:50 -0800
In-Reply-To: <20250224184742.4144931-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224184742.4144931-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224184742.4144931-4-ctshao@google.com>
Subject: [PATCH v7 3/4] perf lock: Make rb_tree helper functions generic
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rb_tree helper functions can be reused for parsing `owner_lock_stat`
into rb tree for sorting.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5d405cd8e696..9bebc186286f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -418,16 +418,13 @@ static void combine_lock_stats(struct lock_stat *st)
 	rb_insert_color(&st->rb, &sorted);
 }
 
-static void insert_to_result(struct lock_stat *st,
-			     int (*bigger)(struct lock_stat *, struct lock_stat *))
+static void insert_to(struct rb_root *rr, struct lock_stat *st,
+		      int (*bigger)(struct lock_stat *, struct lock_stat *))
 {
-	struct rb_node **rb = &result.rb_node;
+	struct rb_node **rb = &rr->rb_node;
 	struct rb_node *parent = NULL;
 	struct lock_stat *p;
 
-	if (combine_locks && st->combined)
-		return;
-
 	while (*rb) {
 		p = container_of(*rb, struct lock_stat, rb);
 		parent = *rb;
@@ -439,13 +436,21 @@ static void insert_to_result(struct lock_stat *st,
 	}
 
 	rb_link_node(&st->rb, parent, rb);
-	rb_insert_color(&st->rb, &result);
+	rb_insert_color(&st->rb, rr);
 }
 
-/* returns left most element of result, and erase it */
-static struct lock_stat *pop_from_result(void)
+static inline void insert_to_result(struct lock_stat *st,
+				    int (*bigger)(struct lock_stat *,
+						  struct lock_stat *))
+{
+	if (combine_locks && st->combined)
+		return;
+	insert_to(&result, st, bigger);
+}
+
+static inline struct lock_stat *pop_from(struct rb_root *rr)
 {
-	struct rb_node *node = result.rb_node;
+	struct rb_node *node = rr->rb_node;
 
 	if (!node)
 		return NULL;
@@ -453,8 +458,15 @@ static struct lock_stat *pop_from_result(void)
 	while (node->rb_left)
 		node = node->rb_left;
 
-	rb_erase(node, &result);
+	rb_erase(node, rr);
 	return container_of(node, struct lock_stat, rb);
+
+}
+
+/* returns left most element of result, and erase it */
+static struct lock_stat *pop_from_result(void)
+{
+	return pop_from(&result);
 }
 
 struct trace_lock_handler {
-- 
2.48.1.658.g4767266eb4-goog

