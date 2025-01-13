Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444F1BD014
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745814; cv=none; b=CneloGgxTbNq8IaUwq3FRY342abf8eeiExKZ508Oze2qKaEnITzhtfh4tshvwijxDOYlg35/J9W3SuAHUlWDlX0ox/Fqux9xxjOVAIoHzODi5qa2DHb035b7vsD4P5FzxZbRQ38JncR4tmmkonsZqGX20TIaEE1uLmNJRyRb9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745814; c=relaxed/simple;
	bh=7r3spX1VTM6b7Ljhi+bgUnGyr89CaYIzvQ4zgRIgmY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YoPz2neK4VcJ/+F4pX+Rd1ieiDKCmDsYuWxQX6LJ3E0KTa55TjSeXEnstgA/yVbDiqN+A5HbtC4ndxzDAsPFVZB4yMKO+LRfCMnmUaz1ybriQaoSaIkopvY8kqXdHMzGKSm0PsLTmEQPyryfB0yS8o8VdbT1kRm9EK+FktdFxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9gWE0Mn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9gWE0Mn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so11355224a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 21:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736745813; x=1737350613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nK90VQgfJdgs3XY2vlzkWlR2hkLCvAiNELZrM3w+SYE=;
        b=l9gWE0MnlB+/Ap7+uXWp5IZlT8D00cC1G1wWbXa/wxRT8pmFlC8gbbzwKGGTGLbrlo
         tOohqX5fYEJsUDFXzeGmO1z0YC1XAfHbXdTuixGP0fLidnBXFj3NjZJFuckuUC7rPSO1
         zhFsw93ndcCTEn4qLpi7ryM/L+O+B1q2aAt7PcnIwQXoYRW4JhYUdIEMXKBbe49Ffpl+
         VSftBygeSO8hdgblj93H8jQ6rhbC84ukl8qm11rN7G6ERTPsli6RtP85DSvIGRNpvUra
         LOiP5aak2gib4/SqN8YHYnWs53IAEiO8EGvfqgjktn96VTT/aPxgpyplzWHU96J4Mrks
         Iqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745813; x=1737350613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nK90VQgfJdgs3XY2vlzkWlR2hkLCvAiNELZrM3w+SYE=;
        b=pUux/m0LHJ9X43B9gEwRo+D0TGv9Uw+140awn6HkRRTsGZxxL3KXXFzjFEaF4GQ57o
         CTqZxQ0aXwIhrHgBpIuCm77jsDgPIDym9a1vxXywGc0z+5N7OtripN8BZaMPrqHtJKlx
         OsGZkCsk/BKVdy6aFDLbDm/zAicuJohm8ec4EGzMFZ5bbN0bbpw6hi3ucWTmHMgSHV4/
         yL0Qh+JSYuK4L96tCFSIb9Iy2NU2daMYvxy3x7WaSDrOWdRgdmIb0pBItBDgn9Vmn2E9
         DQzlFwDpZInvkcNvOYjSHXGAKBIdBGHKea6UGuqqUNYuM/pIMCkX7hu8XxaO6LHHBML+
         NpKA==
X-Forwarded-Encrypted: i=1; AJvYcCW5/4wTn1kQDQfhs9CC2v58CjPiWJt9aU+QWlWxJ+h9px1RapGGf/0MNQn79bTJ18MgTy2FprZyJpUi6E0nn2HW@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcNpwMvmQrC/yXogeiIXwEMStCEYnVsoa95mwmSrghhGYByvh
	HS2T1H+t2Ay18hbhsY2PEP9/DckXqwDpGNBXU5Z2BkOZWaJO+2h4yFRdoG6B02EYtR8rnf8GINl
	e9Q==
X-Google-Smtp-Source: AGHT+IE2T0lvVUiEK+HXuBqpPOONhCmR9IKp8db4I+ItSYAUaSSsYzmbt6l7f7ysmcwdqshEHrllE2BAF+4=
X-Received: from pfiv28.prod.google.com ([2002:aa7:99dc:0:b0:725:dec7:dd47])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc2:b0:726:f7c9:7b36
 with SMTP id d2e1a72fcca58-72d21f325b8mr31890687b3a.8.1736745812736; Sun, 12
 Jan 2025 21:23:32 -0800 (PST)
Date: Sun, 12 Jan 2025 21:20:16 -0800
In-Reply-To: <20250113052220.2105645-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113052220.2105645-4-ctshao@google.com>
Subject: [PATCH v2 3/4] perf lock: Make rb_tree helper functions generic
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rb_tree helper functions can be reused for parsing `owner_lock_stat`
into rb tree for sorting.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..f9b7620444c0 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -438,16 +438,13 @@ static void combine_lock_stats(struct lock_stat *st)
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
@@ -459,13 +456,21 @@ static void insert_to_result(struct lock_stat *st,
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
@@ -473,8 +478,15 @@ static struct lock_stat *pop_from_result(void)
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
 
 struct lock_stat *lock_stat_find(u64 addr)
-- 
2.47.1.688.g23fc6f90ad-goog

