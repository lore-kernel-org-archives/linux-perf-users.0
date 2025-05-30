Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0722D4EF
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597480; cv=none; b=WMYLcpnfKUqfkMconqgJPhgYjWkTmrGP1BRklgqmwN6gz42LMl/yKwbiZTwFZFfEhgjw9IhDIY/MnrFfnrDAmuitnVD3kJYsZZ3p1QIvBGJgB7SohKbx67FpjFvZNhuUi3o1x4nYRYEG8wIGXHZgcTRFFgtUKgY59DoNPG7vl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597480; c=relaxed/simple;
	bh=Tz+y1/2E7hEgjo92We1jW9pwmbJC4Y8VL7rWkTlATqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euL/Pbjj7UHxrzWt7GK+s2RiwA5CxoAGDgW9AQS7abfl/WIAYVr16NkcDhoJ+qbJTbHKNm5VubiKN44e32gzLaTx/kss24heNA2FfwRi4mepe7vNv0OfeZXnl9jEDjJC2/JGZHz3kAZyAX/RAJ1ayhyI4cBYnq8wyb/QywkjiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jwyq/Lyc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jwyq/Lyc"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311e993f49aso1475981a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597476; x=1749202276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwsjAroG47yqr2xPwlaPw9IAGrmPcW3kvk56UsePHN4=;
        b=jwyq/Lyc7gPUizE/hhobMGttC9h5H4LG6rALzLCKqbhOgIzv8AnuLHN3YZVxJSxJ8T
         OOz73r2H6eJgoKqVl0zWDwRnVt2jLxZ4+hOf4g3eXfO1IAsbSkYz+eImrRqK24G2B9XZ
         QbmvFbiAP9OmQ5bO/ddHIuoHzT1oNPsAfEhL4cTw0W1WH1+Fu95FMnRX6ZCMGq9Y84/B
         1rhocUonYYUvAjdLNB4qRw/YCxSVqMtMnq1Z4NHTPdNLfUS84d91NjLsLSvXcyT1HLM0
         x0FCdGTKHS9EyZCuUtAs69D05MaOKYcPTn6G0ddzWuYkPhh1PnVD+UK63XScJXRO6P41
         jxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597476; x=1749202276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwsjAroG47yqr2xPwlaPw9IAGrmPcW3kvk56UsePHN4=;
        b=ilK4L389W28kkMnWFF4M8BFvFmA8MmGufUbPIju3JHiBJfycwxd+A1XGhigOUc+CM5
         jubcXj+cPT5v2WqQJvw2MDgu/q04Z0dq5ZcxDQnS+ZANJzO0xuYuuLCZkHpUrVm1rB5z
         /2M90fgDWG/f62FLkyPK15hrcgnhfHBjj1esbXvjv0CCfWvXnWPRvtgWNujWmdCkdEqR
         Dh3guRg0iyn7r+Mya/rifckAF6bvhqooKKnKjCerMDFD/oM9bn7LKjva5JSMX3BUOE5b
         AeLtzwhlDGDp/Ln8T2qicm7taJ9cAntNsubULJ6TtejjEWqsKHHWJiEEIfYt6a/WQo3K
         UbnA==
X-Forwarded-Encrypted: i=1; AJvYcCX9kNK2VoiM5Ee1HgYezMKs8eDzWGXrZ1t5SeVlIX8LmTK2i/Ta9Xr4A0eHtvZDAJwcvMFvtBR7p8FUpu3ijC2X@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWa3qplBVOZHT6KnEWgiRINGJ9W62eFg66hVGr2qFfPnQ7cle
	z+0Dm+UuMJpgzcwGgEPyEv/DTSb8qr2BWh6IaLBbeMyLzRjbjTYQrwALK/a5gJ5dLHU=
X-Gm-Gg: ASbGnctXAIFkJQKtTUceyOSFDiBSwiWGsYrRXqFBTOj9jzW8RrPRFkBzVSQmKi2sEwJ
	7u7zA7ReAN2eY8+wkqjLTfYG6r5UvKKRVg03Ksfj8wvARtP1ohNfx7F8sHJlBRGcVvriU51szcf
	eUoyzduGQqBs/IIfx6Oi+dG65jUXmWBm51hihUEiHWgtnKN328HMo68Dtp2ADwOtMH9sRJvxYkW
	kw3t3KXOaUlRJ532GI3Y89eB/8yL0mRsotUINtPzd8eIpy2S1rM6/orcon8eGW6+Dq6cWDomSR6
	Hy8ki6XKegyONcTX11Hez30H0OSvfaCfo+rs/Oc8kfr9u6YkjXpSTiDO5L/8etYHBYlwQJ+OybW
	9pvbf4gQg6Xm+qgW9wmCi
X-Google-Smtp-Source: AGHT+IHRc0pSTHqnWWemzLU4cZ03FJzQxrkM5nsu9yl2b6TGMlL/6vitJMQ7NNciKXpMzxjmPBfgdQ==
X-Received: by 2002:a17:90a:d448:b0:312:29e:9ed8 with SMTP id 98e67ed59e1d1-31250413834mr2149974a91.20.1748597475019;
        Fri, 30 May 2025 02:31:15 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.31.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:31:14 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 11/35] RPAL: add service request/release
Date: Fri, 30 May 2025 17:27:39 +0800
Message-Id: <d3e954630da8219029d5aba22fc27acc1e234fdb.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Services communicating via RPAL require a series of operations to perform
RPAL calls, such as mapping each other's memory and obtaining each other's
metadata.

This patch adds the rpal_request_service() and rpal_release_service()
interfaces. Before communication, services must first complete a handshake
process by mutually requesting each other. Only after both parties have
completed their requests will RPAL copy each other's p4d entries into the
other party's page tables, thereby achieving address space sharing. The
patch defines RPAL_REQUEST_MAP and RPAL_REVERSE_MAP to indicate whether a
service has requested another service or has been requested by another
service.

rpal_release_service() can release previously requested services, which
triggers the removal of mutual p4d entries and terminates address space
sharing. When a service exits the enabled state, the kernel will release
all services it has ever requested, thereby terminating all address space
sharing involving this service.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/internal.h |   5 +
 arch/x86/rpal/proc.c     |   6 +
 arch/x86/rpal/service.c  | 265 ++++++++++++++++++++++++++++++++++++++-
 include/linux/rpal.h     |  42 +++++++
 4 files changed, 316 insertions(+), 2 deletions(-)

diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index 769d3bbe5a6b..c504b6efff64 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -12,6 +12,9 @@
 #include <linux/mm.h>
 #include <linux/file.h>
 
+#define RPAL_REQUEST_MAP 0x1
+#define RPAL_REVERSE_MAP 0x2
+
 extern bool rpal_inited;
 
 /* service.c */
@@ -19,6 +22,8 @@ int __init rpal_service_init(void);
 void __init rpal_service_exit(void);
 int rpal_enable_service(unsigned long arg);
 int rpal_disable_service(void);
+int rpal_request_service(unsigned long arg);
+int rpal_release_service(u64 key);
 
 /* mm.c */
 static inline struct rpal_shared_page *
diff --git a/arch/x86/rpal/proc.c b/arch/x86/rpal/proc.c
index acd814f31649..f001afd40562 100644
--- a/arch/x86/rpal/proc.c
+++ b/arch/x86/rpal/proc.c
@@ -69,6 +69,12 @@ static long rpal_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case RPAL_IOCTL_DISABLE_SERVICE:
 		ret = rpal_disable_service();
 		break;
+	case RPAL_IOCTL_REQUEST_SERVICE:
+		ret = rpal_request_service(arg);
+		break;
+	case RPAL_IOCTL_RELEASE_SERVICE:
+		ret = rpal_release_service(arg);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 8a7b679bc28b..16a2155873a1 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -178,6 +178,9 @@ struct rpal_service *rpal_register_service(void)
 	INIT_LIST_HEAD(&rs->shared_pages);
 	atomic_set(&rs->thread_cnt, 0);
 	rs->enabled = false;
+	atomic_set(&rs->req_avail_cnt, MAX_REQUEST_SERVICE);
+	bitmap_zero(rs->requested_service_bitmap, RPAL_NR_ID);
+	spin_lock_init(&rs->lock);
 
 	rs->bad_service = false;
 	rs->base = calculate_base_address(rs->id);
@@ -229,6 +232,262 @@ void rpal_unregister_service(struct rpal_service *rs)
 	rpal_put_service(rs);
 }
 
+static inline void set_requested_service_bitmap(struct rpal_service *rs, int id)
+{
+	set_bit(id, rs->requested_service_bitmap);
+}
+
+static inline void clear_requested_service_bitmap(struct rpal_service *rs, int id)
+{
+	clear_bit(id, rs->requested_service_bitmap);
+}
+
+static int add_mapped_service(struct rpal_service *rs, struct rpal_service *tgt,
+			      int type_bit)
+{
+	struct rpal_mapped_service *node;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&rs->lock, flags);
+	node = rpal_get_mapped_node(rs, tgt->id);
+	if (type_bit == RPAL_REQUEST_MAP) {
+		if (atomic_read(&rs->req_avail_cnt) == 0) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	}
+
+	if (node->rs == NULL) {
+		node->rs = rpal_get_service(tgt);
+		set_bit(type_bit, &node->type);
+	} else {
+		if (node->rs != tgt) {
+			ret = -EINVAL;
+			goto unlock;
+		} else {
+			if (test_and_set_bit(type_bit, &node->type)) {
+				ret = -EINVAL;
+				goto unlock;
+			}
+		}
+	}
+
+	if (type_bit == RPAL_REQUEST_MAP) {
+		set_requested_service_bitmap(rs, tgt->id);
+		atomic_dec(&rs->req_avail_cnt);
+	}
+
+unlock:
+	spin_unlock_irqrestore(&rs->lock, flags);
+	return ret;
+}
+
+static void remove_mapped_service(struct rpal_service *rs, int id, int type_bit)
+{
+	struct rpal_mapped_service *node;
+	struct rpal_service *t;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rs->lock, flags);
+	node = rpal_get_mapped_node(rs, id);
+	if (node->rs == NULL)
+		goto unlock;
+
+	clear_bit(type_bit, &node->type);
+	if (type_bit == RPAL_REQUEST_MAP) {
+		clear_requested_service_bitmap(rs, id);
+		atomic_inc(&rs->req_avail_cnt);
+	}
+
+	if (node->type == 0) {
+		t = node->rs;
+		node->rs = NULL;
+		rpal_put_service(t);
+	}
+
+unlock:
+	spin_unlock_irqrestore(&rs->lock, flags);
+}
+
+static bool ready_to_map(struct rpal_service *cur, int tgt_id)
+{
+	struct rpal_mapped_service *node;
+	unsigned long flags;
+	bool need_map = false;
+
+	spin_lock_irqsave(&cur->lock, flags);
+	node = rpal_get_mapped_node(cur, tgt_id);
+	if (test_bit(RPAL_REQUEST_MAP, &node->type) &&
+	    test_bit(RPAL_REVERSE_MAP, &node->type)) {
+		need_map = true;
+	}
+	spin_unlock_irqrestore(&cur->lock, flags);
+
+	return need_map;
+}
+
+int rpal_request_service(unsigned long arg)
+{
+	struct rpal_service *cur, *tgt;
+	struct rpal_request_arg rra;
+	long ret = 0;
+	int id;
+
+	cur = rpal_current_service();
+
+	if (copy_from_user(&rra, (void __user *)arg, sizeof(rra))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (cur->key == rra.key) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (atomic_read(&cur->req_avail_cnt) == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&cur->mutex);
+
+	if (!cur->enabled) {
+		ret = -EINVAL;
+		goto unlock_mutex;
+	}
+
+	tgt = rpal_get_service_by_key(rra.key);
+	if (tgt == NULL) {
+		ret = -EINVAL;
+		goto unlock_mutex;
+	}
+
+	if (!tgt->enabled) {
+		ret = -EPERM;
+		goto put_service;
+	}
+
+	ret = put_user((unsigned long)(tgt->rsm.user_meta), rra.user_metap);
+	if (ret) {
+		ret = -EFAULT;
+		goto put_service;
+	}
+
+	ret = put_user(tgt->id, rra.id);
+	if (ret) {
+		ret = -EFAULT;
+		goto put_service;
+	}
+
+	id = tgt->id;
+	ret = add_mapped_service(cur, tgt, RPAL_REQUEST_MAP);
+	if (ret < 0)
+		goto put_service;
+
+	ret = add_mapped_service(tgt, cur, RPAL_REVERSE_MAP);
+	if (ret < 0)
+		goto remove_request;
+
+	/* only map shared address space when both process request each other */
+	if (ready_to_map(cur, id)) {
+		ret = rpal_map_service(tgt);
+		if (ret < 0)
+			goto remove_reverse;
+	}
+
+	mutex_unlock(&cur->mutex);
+
+	rpal_put_service(tgt);
+
+	return 0;
+
+remove_reverse:
+	remove_mapped_service(tgt, cur->id, RPAL_REVERSE_MAP);
+remove_request:
+	remove_mapped_service(cur, tgt->id, RPAL_REQUEST_MAP);
+put_service:
+	rpal_put_service(tgt);
+unlock_mutex:
+	mutex_unlock(&cur->mutex);
+out:
+	return ret;
+}
+
+static int release_service(struct rpal_service *cur, struct rpal_service *tgt)
+{
+	remove_mapped_service(tgt, cur->id, RPAL_REVERSE_MAP);
+	remove_mapped_service(cur, tgt->id, RPAL_REQUEST_MAP);
+	rpal_unmap_service(tgt);
+
+	return 0;
+}
+
+static void rpal_release_service_all(void)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_service *tgt;
+	int ret, i;
+
+	rpal_for_each_requested_service(cur, i) {
+		struct rpal_mapped_service *node;
+
+		if (i == cur->id)
+			continue;
+		node = rpal_get_mapped_node(cur, i);
+		tgt = rpal_get_service(node->rs);
+		if (!tgt)
+			continue;
+
+		if (test_bit(RPAL_REQUEST_MAP, &node->type)) {
+			ret = release_service(cur, tgt);
+			if (unlikely(ret)) {
+				rpal_err("service %d release service %d fail\n",
+					 cur->id, tgt->id);
+			}
+		}
+		rpal_put_service(tgt);
+	}
+}
+
+int rpal_release_service(u64 key)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_service *tgt = NULL;
+	struct rpal_mapped_service *node;
+	int ret = 0;
+	int i;
+
+	mutex_lock(&cur->mutex);
+
+	if (cur->key == key) {
+		ret = -EINVAL;
+		goto unlock_mutex;
+	}
+
+	rpal_for_each_requested_service(cur, i) {
+		node = rpal_get_mapped_node(cur, i);
+		if (node->rs->key == key) {
+			tgt = rpal_get_service(node->rs);
+			break;
+		}
+	}
+
+	if (!tgt) {
+		ret = -EINVAL;
+		goto unlock_mutex;
+	}
+
+	ret = release_service(cur, tgt);
+
+	rpal_put_service(tgt);
+
+unlock_mutex:
+	mutex_unlock(&cur->mutex);
+	return ret;
+}
+
 int rpal_enable_service(unsigned long arg)
 {
 	struct rpal_service *cur = rpal_current_service();
@@ -270,6 +529,8 @@ int rpal_disable_service(void)
 		goto unlock_mutex;
 	}
 
+	rpal_release_service_all();
+
 unlock_mutex:
 	mutex_unlock(&cur->mutex);
 	return ret;
@@ -289,11 +550,11 @@ void exit_rpal(bool group_dead)
 	if (!rs)
 		return;
 
-	exit_rpal_thread();
-
 	if (group_dead)
 		rpal_disable_service();
 
+	exit_rpal_thread();
+
 	current->rpal_rs = NULL;
 	rpal_put_service(rs);
 
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 2e5010602177..1fe177523a36 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -77,6 +77,9 @@
 #define RPAL_ADDRESS_SPACE_LOW  ((0UL) + RPAL_ADDR_SPACE_SIZE)
 #define RPAL_ADDRESS_SPACE_HIGH ((0UL) + RPAL_NR_ADDR_SPACE * RPAL_ADDR_SPACE_SIZE)
 
+/* No more than 15 services can be requested due to limitation of MPK. */
+#define MAX_REQUEST_SERVICE 15
+
 extern unsigned long rpal_cap;
 
 enum rpal_task_flag_bits {
@@ -92,6 +95,18 @@ struct rpal_service_metadata {
 	void __user *user_meta;
 };
 
+struct rpal_request_arg {
+	unsigned long version;
+	u64 key;
+	unsigned long __user *user_metap;
+	int __user *id;
+};
+
+struct rpal_mapped_service {
+	unsigned long type;
+	struct rpal_service *rs;
+};
+
 /*
  * Each RPAL process (a.k.a RPAL service) should have a pointer to
  * struct rpal_service in all its tasks' task_struct.
@@ -125,6 +140,8 @@ struct rpal_service {
      */
 	/* Mutex for time consuming operations */
 	struct mutex mutex;
+	/* spinlock for short operations */
+	spinlock_t lock;
 
 	/* pinned pages */
 	int nr_shared_pages;
@@ -137,6 +154,13 @@ struct rpal_service {
 	bool enabled;
 	struct rpal_service_metadata rsm;
 
+	/* the number of services allow to be requested */
+	atomic_t req_avail_cnt;
+
+	/* map for services required, being required and mapped  */
+	struct rpal_mapped_service service_map[RPAL_NR_ID];
+	DECLARE_BITMAP(requested_service_bitmap, RPAL_NR_ID);
+
 	/* delayed service put work */
 	struct delayed_work delayed_put_work;
 
@@ -220,6 +244,8 @@ enum rpal_command_type {
 	RPAL_CMD_UNREGISTER_RECEIVER,
 	RPAL_CMD_ENABLE_SERVICE,
 	RPAL_CMD_DISABLE_SERVICE,
+	RPAL_CMD_REQUEST_SERVICE,
+	RPAL_CMD_RELEASE_SERVICE,
 	RPAL_NR_CMD,
 };
 
@@ -244,6 +270,16 @@ enum rpal_command_type {
 	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_ENABLE_SERVICE, unsigned long)
 #define RPAL_IOCTL_DISABLE_SERVICE \
 	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_DISABLE_SERVICE)
+#define RPAL_IOCTL_REQUEST_SERVICE \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REQUEST_SERVICE, unsigned long)
+#define RPAL_IOCTL_RELEASE_SERVICE \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_RELEASE_SERVICE, unsigned long)
+
+#define rpal_for_each_requested_service(rs, idx)                             \
+	for (idx = find_first_bit(rs->requested_service_bitmap, RPAL_NR_ID); \
+	     idx < RPAL_NR_ID;                                               \
+	     idx = find_next_bit(rs->requested_service_bitmap, RPAL_NR_ID,   \
+				 idx + 1))
 
 /**
  * @brief get new reference to a rpal service, a corresponding
@@ -274,6 +310,12 @@ static inline unsigned long rpal_get_top(struct rpal_service *rs)
 	return rs->base + RPAL_ADDR_SPACE_SIZE;
 }
 
+static inline struct rpal_mapped_service *
+rpal_get_mapped_node(struct rpal_service *rs, int id)
+{
+	return &rs->service_map[id];
+}
+
 #ifdef CONFIG_RPAL
 static inline struct rpal_service *rpal_current_service(void)
 {
-- 
2.20.1

