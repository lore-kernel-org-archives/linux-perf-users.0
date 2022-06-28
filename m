Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A3C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbiF1KAI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344462AbiF1J7o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCE2F3B4
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:59:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128-20020a25dd86000000b0066073927e92so10637656ybg.13
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OJ712p3S1OHPRYNkQ5hzwMPKCksP3C27n0j33eqLkMg=;
        b=d/0QyIe6c6w8YnTv4B7+92tlMrSeIOkNzc8AsQwybZxLipkSsctnUSpQhnXJk3gpQW
         pG7oJE8EMfatuBSTTfzESX61MQT+ZGgqgv/2IQAPK+0Tesd7jB3FKf3aKT9DFS9E5zAE
         nYgEOoHejQURnHC4IjuJqgzxg6cLijpuZQEhOtxvCpWbo1Tam7nN+46hKsWbur8cjeA1
         ZhZT2aa0B7od+m5ukRJTx4SR3zTMzoYTkekeqUfVZ3QziyHy9JQ+YZxu6HoTlk3qqf1H
         eoUemFii0CtNlmMaOzeYoX+faIcxpGae5tdadgrjfMJQ39bU5ebMj5wLE68UG9Dnnuvx
         52cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OJ712p3S1OHPRYNkQ5hzwMPKCksP3C27n0j33eqLkMg=;
        b=LPKP22r30zhmYtdIxJQv4NWUOeo9o1q1Q27Vtvek97q5NvcDgqs0kCylKcUhg02Unc
         eVKj8qOtEMNL1ZlPROZBRheXfDsL8x635FHL3LZtvrPQqXWpdqSFhZYnCP96ChZ0I+lY
         iYEWfrTOcmxj+mIFiRyI//JXa09eRlbZQ5ONJLdWQ0zmlqm7Ji5kAFsaWKKT3Le4pXla
         ll2blrUGaiZA31pP6N3jXAOTkGgFu0kpJwSKVnFGfG2YK1mXTgd2NOE26VixYOFD3r2v
         ijwJkmSsfLjBUyHHtlOZNNL4vrnjGg3kjIXAPoD5VTINncP39S4wEMkK1mLLhyvGw7qK
         yFfw==
X-Gm-Message-State: AJIora+MvvftCAShx7i6jUwl7fgBtjr1exrqg2UTofzZ12ehxFVCKOPr
        8Lb0UW8mHdwOIad2j9DHzzGsx4ydkA==
X-Google-Smtp-Source: AGRyM1taDiYbLihOjjyRXPicCa4AHPJVlW3QJBjDYYiQqAt3+ZFsXssWabp4YL8IpafvyHDmt/JVzkEIEQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a25:1985:0:b0:66d:2027:1c7b with SMTP id
 127-20020a251985000000b0066d20271c7bmr3929985ybz.161.1656410363110; Tue, 28
 Jun 2022 02:59:23 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:29 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-10-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 09/13] locking/percpu-rwsem: Add percpu_is_write_locked()
 and percpu_is_read_locked()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Implement simple accessors to probe percpu-rwsem's locked state:
percpu_is_write_locked(), percpu_is_read_locked().

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 include/linux/percpu-rwsem.h  | 6 ++++++
 kernel/locking/percpu-rwsem.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f97fe9..36b942b67b7d 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -121,9 +121,15 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 	preempt_enable();
 }
 
+extern bool percpu_is_read_locked(struct percpu_rw_semaphore *);
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
+static inline bool percpu_is_write_locked(struct percpu_rw_semaphore *sem)
+{
+	return atomic_read(&sem->block);
+}
+
 extern int __percpu_init_rwsem(struct percpu_rw_semaphore *,
 				const char *, struct lock_class_key *);
 
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 5fe4c5495ba3..213d114fb025 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -192,6 +192,12 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
 	__sum;								\
 })
 
+bool percpu_is_read_locked(struct percpu_rw_semaphore *sem)
+{
+	return per_cpu_sum(*sem->read_count) != 0;
+}
+EXPORT_SYMBOL_GPL(percpu_is_read_locked);
+
 /*
  * Return true if the modular sum of the sem->read_count per-CPU variable is
  * zero.  If this sum is zero, then it is stable due to the fact that if any
-- 
2.37.0.rc0.161.g10f37bed90-goog

