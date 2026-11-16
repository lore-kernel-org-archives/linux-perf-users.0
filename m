Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834481;
	b=LPE6YKZU4dzKhz26m2QGsxRRVbs0UB4o4p2+TfTdGMRCFX7aacrax3uZiPyejm91iZJ2
	 7rfrC44ceZa6fZN/q6RQEwYum8s1wAHf1t3WZrNK6GTe+vFTVdqm9bYInKgFy14EzoSGm
	 GFEukc0iC8yBxPXk6ajFzLuXJ7bnltCs34fw5WbyWQj5iXH0sI+KuvN3W8ebecnIiquj8
	 RJ8X0g1x4hDRWY0j7EGW4q/6AlHOkLWVWV+RLGMOQsqt+dhjY2uKt+mdfMPoP8+P/kx67
	 KNXDJLpHc4fvUJGrvfWNGMGy2wjA7md+4LtXCqgtFGIH1Q+MnDY0d8JQn9vNckWpK/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=itR1YfXdw68plWLAJU8qPrVZYvCmpJpw3Vk4YT4jpd0=;
	b=2/ZAHb02H4VnyJnsf0LcHsDixF/24OuDRmO+XIYG0+24zwCRS7Nfl0WV761tsuw8n/Ei
	 drj1g5sMFVv8BItFoe/iYbBLnTKrSwqqaIlHIYoz7Dem0kPltJLVWetxBoWtj+96LCUZs
	 EM2+i0YgOJp2/aNEBO+b8g2M15JnVvF6ixd8X4BXGAygX7PvQT1tFKXwHe81n6yOBOpFE
	 VA51HtQ08g6dJbmdyKTmWOuJxPoj+hukJ6/V+F1m5kkGcG2e+lfN+Y+u7HOhE3gTN03AP
	 +dfiaOfOuEZryIb2IGCwfiVmYrbbXrwBX3Hn9hKk5Buyjqjk3xZD3GFmyEJIFi+cn/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hd8tSodC;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A308606A32F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 13:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A308606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hd8tSodC
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b16896b8ceso1568722a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794834480; x=1795439280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=itR1YfXdw68plWLAJU8qPrVZYvCmpJpw3Vk4YT4jpd0=;
        b=hd8tSodCq01+IdEPKWUqexRLHxVzMeBwxDmelh3sZ50m3fMepbts1xTYX1exooWWwn
         eYiIODXqCvooinEafeo5uX/A0dOIlZXZ4R+oI4W9uN0oH1jQ3Mw0JRKNpIf8ncj5D9XZ
         bDID7lTxxiNdMJI90O/d4/Gnhg7wvhTv67Q9RO67pEgRjjOgw5gVG0tidoSXKNIUqG3A
         1uyrITTGCANcDRdLpvVMZHHS1SdKYPoxdPKETqSv69hngcjc/pKfBXbNiwJXN/lBjv3v
         89/WZAHJGxItG9v8fg7IMH7la1nC87rsOn/Hrzzp2b/3Uaf7pMMN89A6QH9F6Io7mSKd
         MEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794834480; x=1795439280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itR1YfXdw68plWLAJU8qPrVZYvCmpJpw3Vk4YT4jpd0=;
        b=x3+STO/ZB9MRUKl+/4XBmxMIzqDH6rSwRWqC68YOMspkYbEU18vny+DDu7qZlqJCUg
         WDJgi2TRs3h3c32Sz+9jP1Ch2pExQgz0w50wNfk3+oZLsKKs3UNGF0rALv07rIp6gKUh
         d8HdGdfpfYSNUtdi+tiZHNjMAcR7IH0Ug8ZLdK+gHKzFn6rhFdDtRgMaExmPXAMLCmZP
         HKNaC3J2DeZRDP/uw2ahGjcP48ASi/Sc5XeoEai5pHHpbQ6UHNQri+l933CZo/cmNBFy
         Fx+9qguhgW6OIl4lxlDV1qrZcfrOY9QPZTXs2M3BcJG1sm2qrRwekLw+Gu/BGruMlhPa
         rWVg==
X-Forwarded-Encrypted: i=1; AL+hErHy0Mei2OLzGj+tO12J0lwjQQcoxr2WPomZPedETaVrznHbYqvlv912acNWJ9oq1aY5AM+9O6YX822z6RwcqT4d@vger.kernel.org
X-Gm-Message-State: APuU4Z/KmJBSVc8qkSFZTE9B3FU0oAIUNpBnDoFpgANWROyMgihyBGXr
	e7AxsX7raBjpaP1/D/QlGWX+d8BXKR2VfT9XkDMNuBbHIbCLmEphQung
X-Gm-Gg: AZFdTZdbxfPJldQMUoOdBXz8uM262DQNwdCnH0vE1f1yr9ZmkSt7k2tqOFujSuRIb4x
	rfgocYWXcmd3ZvqV1S7hKK415XOzW5c/Y9Zio4B6xT/27ulQxi0XI0+WjCib8ss5jV0oLDCrAi9
	NHbAGAx9ydgJyfM/ScOVMvZfVBPhDHQyeOM4EsSjO2MKyIAQEh4Jsd5U84SLWAbM+HSw6lU8KN+
	breo4FN1LTAQBTOYqqGddTUhzJnSCOmSI0kVUTbKTWjmHOn/w42qtlyhZmyI2Fg2/11VhXG1/2N
	hnsIm1dFAJXhZNChZKlbLMvqUYnbZ3pO7qqKpyQeHi9fnkRpmVqydi7Xs4KvvWbC+wCvBvvIl9j
	oRPQujTnDhTA4NFuh/fJxjxGOHGF1eTwC3OYsFyGwcmFT4oxml1QVEL9oeJvg6w4m+GY6WUuznR
	fsMRGuEqqDmL5bbjyBl76t/UeBG2jYGILi5wQFqduN7uht8XIhB4chigiIx5y6nFkOfY8YxxX4c
	TapJZlMTLBMR/oTofUhKeMpYC1IuHTxiNad7+PQxMwEsP3VEXdZnr/OgLXs2omnNw28ihZWYzIs
	7eiNqVavFKf5jOImSdONoq8CigMUVcxAe7A1N0bUfXhMpLRxnDh4mS38tnCIcUkkMhR05nEB+zJ
	hhjukTxavyNL28QfKGS3pKQVUZnGuIJGNNRVwMo5EQoqkSFpnkNkYz5Hpb9Cnt9zRl7DKz8wV6V
	rDig+uhtxAViz9yXhvO8LzNNGysQZnRSwx1EzwNCtr1603Jume8kvwkGL3Dkf5LYYc3pg4QgVjg
	SK7g87Wz7E4Jj8KyR9GWd/XqlhGtC/cCmGEqX17vYjMXTHy1FsjU+xY0CXgqlA4VF0ol4+dYXrb
	M5NXb2jk9Q==
X-Received: by 2002:a17:90b:4a45:b0:3ac:af8b:6f3 with SMTP id 98e67ed59e1d1-3b1b0b5e4bfmr9173020a91.52.1794834480402;
        Mon, 16 Nov 2026 05:08:00 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18b4352sm4494530a12.24.2026.11.16.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:07:59 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	Jun Yang <junvyyang@tencent.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Don't read the original event's pmu_ctx in inherit_event()
Date: Mon, 16 Nov 2026 23:37:35 +1030
Message-Id: <20261116130736.32585-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inherit_event() walks @parent_event up to the original, top-level event
and takes the PMU from its pmu_ctx. perf_event_init_context() holds the
mutex of the forking task's own context, but that original is attached to
the context it was opened in, whose mutex and lock are both unheld, and the
fork is not in an RCU read-side section. The move_group path of
perf_event_open() drops that pmu_ctx with put_pmu_ctx(), which can free it
through call_rcu(), and reinstalls the pointer only two loops later:

  G: perf_event_open(group_fd = P)      M, a child of G: fork()
  --------------------------------      ----------------------------
  put_pmu_ctx(P->pmu_ctx)
    call_rcu(free_epc_rcu)
  [ grace period -> kfree() ]           inherit_event(C)
                                          parent_event = P
                                          P->pmu_ctx->pmu  <-- freed
  P->pmu_ctx = pmu_ctx

The value is used as a struct pmu. No privilege is needed: a software
leader, an inheriting hardware event on the caller's own task, and a fork.

Take the PMU from the event inherit_event() is given, before the
replacement; it is attached to @parent_ctx, whose mutex is held. The result
differs only when the group was moved after the context was cloned from it.

Fixes: 4b9ce6719606 ("perf: Make sure to use pmu_ctx->pmu for groups")
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Cc: stable@vger.kernel.org
---
Tested on mainline b3dfbde62cf1 (kernel/events identical to v7.4-rc2),
x86-64 with KASAN and lockdep, as uid 65534 at perf_event_paranoid 2.

With synchronize_rcu(), rcu_barrier() and msleep(3000) after that
put_pmu_ctx() to hold the window open, and no patch: "BUG: KASAN:
slab-use-after-free in inherit_event", freed from an RCU callback queued by
put_pmu_ctx(), then an oops in perf_ctx_disable(). With the delay and this
patch, and with this patch and no delay: clean.

Not tested without the delay: only a task whose own context is not the
leader's can race it, since perf_event_init_context() takes the forking
task's ctx->mutex and perf_event_open() takes the leader's.

4b9ce6719606 is in 6.6, 6.12, 6.18 and 6.19 stable. Jun Yang's unmerged
"perf/core: Remove group siblings before the leader in move_group" reorders
that block; it shortens this window but does not close it.

 kernel/events/core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5f2261f1fe..544a2c10409 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14974,6 +14974,15 @@ inherit_event(struct perf_event *parent_event,
 	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_event *child_event;
 	unsigned long flags;
+	struct pmu *pmu;
+
+	/*
+	 * @parent_event is attached to @parent_ctx, whose mutex is held, so
+	 * its pmu_ctx is stable. The original it is replaced with below can
+	 * be in another context, where perf_event_open()'s move_group path
+	 * may have dropped the pmu_ctx and not yet installed the new one.
+	 */
+	pmu = parent_event->pmu_ctx->pmu;
 
 	/*
 	 * Instead of creating recursive hierarchies of events,
@@ -15003,7 +15012,7 @@ inherit_event(struct perf_event *parent_event,
 	get_ctx(child_ctx);
 	child_event->ctx = child_ctx;
 
-	pmu_ctx = find_get_pmu_context(parent_event->pmu_ctx->pmu, child_ctx, child_event);
+	pmu_ctx = find_get_pmu_context(pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
 		return ERR_CAST(pmu_ctx);
