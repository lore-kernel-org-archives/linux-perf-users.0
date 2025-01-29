Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D617B502
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110390; cv=none; b=pyljv9rbdcX/xEm/yMC7Nr+UaQSORvC7ZsG8FE8cnasYCc1+fT9hcU/ZBng83F7FsfFlfkEo15lCFCoxmQyfu5uR8hJw53LeiBLeiYs8Kg/DhbTuE/RxjxJZtgVpJtmBpcfip0RMj+scF/SdNxVvuclIVRFOJAux6clPIerihjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110390; c=relaxed/simple;
	bh=ttHPeGDMTcjcBIoqQRbKRxvn64T3Ln0kMiIrAztObZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QvFuFdUsHWyG7E4jRAz8xORjOK+saLxTOEhjI5zt6ttGi/4CKXuc482oD+rJ3/1iGqBdJaXMpc7Yn+mfBse4IPQhw5XF0LZKdWhwy12FdAYqCQYDVwJlsYh2jJIz5xDln1wWWobtzBR2rwYzyuW9E2V+FwPEIFlgZjL44+YeI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBRmaTqG; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBRmaTqG"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-29f9dcd1235so3723019fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738110388; x=1738715188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWNil8Fjn4Jar+XAMcIdAlTx0TuFDQai1n5OzDTNvzE=;
        b=VBRmaTqGQ4qYMo1iGsTK3FH/zCoaaQW7MoxpKwxsslOlGk/OuF3wICqLvZ0v4Ber0s
         a7WXuYZp4pd0FPcvKGTTSivuAsu8JO4Sbu2Tp7Sj8RJORqAjs8eK0NAZx7AVY9c0uCHl
         XafKEnV+fJcLZV3DqaHtBQEkCT86lJtfzVr53IWro21mfn5F/lhw0tjDPYzvNFn1Y6Q2
         k4VzBx+maPMqGmYispp6vkQzZZH+HIq71mRXmX0V7DaW9HPQ6Achz0sKkXeiklgdJpT3
         8HuaSpLkARSqc++c13BojKhXoSqZEarZ3n4/YbmfC5CBVBI0rcVEKlEi3a5NXGYoylvA
         isuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738110388; x=1738715188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWNil8Fjn4Jar+XAMcIdAlTx0TuFDQai1n5OzDTNvzE=;
        b=MdSZFi6k0OYCxFCAatZ8vMLpe7lv4E0/JMSfjdwg+uRHZeGD6Oio46s4u7FOecSeBp
         F4ZZ5Lo3+jDyXzVt03Pa5tDKhz747ja+CHnxOJKN5rScZ0oj1jujUgdTAMQWuHvo362L
         b4XTOggV2izxwiG3GTr6gx853nq5Whlq9EhMQtWT1KoTDGm1eT8q1pvvYyFbuo/uuMi4
         2t73KKttz1AI2fCRUoNqi3QDZXKeVDFhIB+qshCo3NK+lVAeO8JmKYlOceadLPFkucjC
         LFfcQV1zAkDu7l0Qj2YWkc8j9Ybro/YcNXgQK/U8OHanOLbZz4Xkz/BVZtW8vaGC9beO
         +XoA==
X-Forwarded-Encrypted: i=1; AJvYcCXGTOBN9Y1W/ZBur43796oyJwAEEqNkSS1QdudKks2FW3Ts4O1dtojfy5hkj31aMrVY+oWzf8NUDbWS3j9PNSns@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1m/wYdgcEV1JGmvXdP77SHUzhBzPJBVR377O0HJ8jBCNpFNw
	P0z5zT6W8IL0ViRrnBge1G4HRaHcm8+fyyW9m4sBF9rX/nQD+L8CHy2oRlr+KweWSTzci+eElpW
	5gA==
X-Google-Smtp-Source: AGHT+IHsDI3JvNuSMQ9/eovun24uNULLxtkUZVYW6kTWXvv63qVQ/psGtmGrSgUv9BBLi2ZcriE/74v7jeg=
X-Received: from oabsa15.prod.google.com ([2002:a05:6871:210f:b0:297:1959:a097])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:71d6:b0:29e:49b4:92b2
 with SMTP id 586e51a60fabf-2b32f0434e2mr647836fac.12.1738110387974; Tue, 28
 Jan 2025 16:26:27 -0800 (PST)
Date: Tue, 28 Jan 2025 16:14:59 -0800
In-Reply-To: <20250129001905.619859-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129001905.619859-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129001905.619859-4-ctshao@google.com>
Subject: [PATCH v3 3/5] perf lock: Make rb_tree helper functions generic
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
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
2.48.1.262.g85cc9f2d1e-goog

