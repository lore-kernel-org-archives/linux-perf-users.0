Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0B920328
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214876; cv=none; b=DNQg0HOQwafLXbMt+524g3biFT/aG03TcuCFip6DO7sRf82+xEBUnO/f+WprfkJRaP2gxZfARquz4PKP046wjN0aA2PCFZwh5tF8+H+SzQ5iLOqm+lNDKTVp5pfV83BXQ5aMmoNK4wjIUxfNQtnQbahVBYyC3sgljdees9qtZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214876; c=relaxed/simple;
	bh=Ht42p/R3GvLPsEkGjA4DAAVNTKk7SjZobV1MMBLi7PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TiCy/qd1WOxDlWpEAF3cTR5mBbB60qWHJUC6Vm/5Q4Jzy4RjVPteMD7BX0IHVLqfkVAePc5K58G5ZZPH4hd4I6ugLzH9nux2lT5cbO/A2S5hNMPk4AVhgSVUi/QHZkYSXIlr3/6dzOunQ8lxT9Wf+NosfhcbtT60eN+B7dghw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crjbuO8n; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crjbuO8n"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso1243741a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 21:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738214874; x=1738819674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZWmWQKUD35icTNF3HhWFGiCoHcg7wGDsZidgu9Msnk=;
        b=crjbuO8n1PMExqmUF/R8hbdwQcIGaoujUGGLLkJZDIWzq6QcruUG+V4JOZRUa1de7c
         M06O1tuDPq9c6G1+uT858Xdp/er1LlrZIcdGtCDFzg+ObS6EWIMx2CDpvPlrRyZxt2ti
         NTW09S+JGnEkmh9bPuKk7ztX91cdWT0IgNE/9UzE8ENKPWCUJ6HP2KTDZljFwFE5CruY
         42Dari9wXscyYGce4f6cp4G+AFYfTIFPxOsESguZYIId2IfNRL8ytqcAV0WmAz1J/0q9
         A5bfIqUZ23RXKKi6oKkHu8CiLGwQLqvWYaDLx6QOGmAta61910MxylNiVrR6+EzUDzPF
         XC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738214874; x=1738819674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZWmWQKUD35icTNF3HhWFGiCoHcg7wGDsZidgu9Msnk=;
        b=CpcmFqatKsaJlUUskNH8bb20QZLzXJMG+gzMMPJhKYCx/bli2X4FLzm6hHL3jOwL2T
         Uc+wA3YyINtbWgQFdbDE9U2IL8wkSyf3Vu4vSUgUIh03IT6E4WeT9S7//Wr68g/mapLe
         +gtz14T1G7V1XsGA5QsBRTD41H2cNTjDSdIbKk9qB5U+qDHuhMCKhakSEslIRBVxup+A
         B97CiOsD/36wYmnRGX23Sft3i4E4WZwECUvKVc+by9BghCIC2dgYXjqI3f41VwWpDArK
         M5T2UuqjYF4zFNNd5zGuMqRtteSvwTkqOHa+9CUnMr1jsvrJiYnj1zoHXHTORaFSYf5h
         088g==
X-Forwarded-Encrypted: i=1; AJvYcCU6Qu0dk+CfsTAc/v8vN1XuVmQzVcruTEU+mqF4qOqBJ6t8WM2zFMon7oh1D8k5QYRvsr47erAOGR5mJjAPsTGq@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7xvsGy4kd4URst4e3RTd3G7MGjOKpEzybzRQWeKMWBtMS58d
	3kKX4q1cUTKy/f9tKFYuWcTaWZA0pJ9So5RgTuOLSUw/3Zs12zhU8NuUtKUdWe4Fnw3fXYqdtAQ
	4fA==
X-Google-Smtp-Source: AGHT+IFTGGMJDvsDA2u5yz62HGQdtvml8XGOC02A1JQSSppiaRkgKuKOZukXXfRh7ajMa8jwe35GDum78Gs=
X-Received: from pjbtb14.prod.google.com ([2002:a17:90b:53ce:b0:2e0:aba3:662a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c03:b0:2ee:d18c:7d84
 with SMTP id 98e67ed59e1d1-2f83ac17ebemr8179710a91.20.1738214874459; Wed, 29
 Jan 2025 21:27:54 -0800 (PST)
Date: Wed, 29 Jan 2025 21:21:37 -0800
In-Reply-To: <20250130052510.860318-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130052510.860318-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130052510.860318-4-ctshao@google.com>
Subject: [PATCH v4 3/5] perf lock: Make rb_tree helper functions generic
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
2.48.1.362.g079036d154-goog

