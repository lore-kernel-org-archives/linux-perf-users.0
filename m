Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E638B;
	Sun, 20 Jul 2025 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969877; cv=none; b=T4c3AoT7b5HxO5g5u2KiAZDExHnasfZjkwDT5AgjN3mYXkkt70ov5cQWRgF34zOHzm6ftRFCijGWVGb9oJtguLIqN7OptI99hM6+85SiDSYbH8XHWaJ90cSTBjiP9RCp4QnkVIMz4gBYfvORFssKzAnnVfv6lNwDNfvFoYIxpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969877; c=relaxed/simple;
	bh=a/0N6fsfVK9aeqOQRreLmiiLRg1rTgmWQQUeWM/W+OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXQQKiswRv4SHUotJka4mxAhjg+aez6saYDxk7jSf0ZY1V3dzKfhkSZpmw5FVcjXT/Wp16KsM6LuIyJLDCr3McxfdxfLU7EAB7mOvM+PRxZAj/UQb3PN6I/C5FleqY+hVvMAnaeFR1rDyEfX8sv+MHaRmnNQUlyKAv/eINVvVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVV86Rp7; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVV86Rp7"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-234c5b57557so29468665ad.3;
        Sat, 19 Jul 2025 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969875; x=1753574675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vemiVpg+Df3BqUrVFzeG/8Owi4lNAiW7v58K4RHZVAQ=;
        b=eVV86Rp7u65ySWCeyDQ+Sp/1WZz8EKUIWtVvvjNiDAyl4plyy7iDds9gD2mvFNFhX+
         wFJqZ9fGFPjLDxEbQ5bo71j0RAUi99lYGaX5wpfgZRHVYrJtcQZBR5aJQa3oNR03V8I9
         0dDqDCjPEHWz99Mlmi/iNE+ZWW5Z03a8TpABl9Nv+YHamLWVaGddxv039yYCACDJNwwc
         wps+7FoDd2irVOYg+GIqDMgpzZm4b4hLu5rYXHSTuaxQXfX75QuJDQkFTDWlMFJ0xyXc
         TSATzwOsLLUvkm/rWL5Zh2XfozDdVL8yDdoSZBvWu6qs6iwI9IxSYm6dW4toc9OngkKm
         YLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969875; x=1753574675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vemiVpg+Df3BqUrVFzeG/8Owi4lNAiW7v58K4RHZVAQ=;
        b=GK2P9lYf6VY6IEWIhDg8nmRR7FPABkq9uLKuD6xDDakw8k1Ao+w3YY9JWLUugHYJfu
         3sqZiKrjVxXZmx0yi7m3S6D7jVEsEUIwZHhbt7wDmbLIrvoeVveFXTxdLj0gDb0vtLua
         FHXkf7lXaWY63HxzWc0F9iBLEcdd0zJcCPiaQYeqkIcHqB7vNfb4hAOITjL/TdkoOA9G
         sPDEml5etgFNapZGXKq0R0pjSsidiE3GdvUKVfLuYF7+0nAo9QYGEJWt3vwtqq17Vscr
         0o25kPOaR4coiVXPiBoydMVptcHJ/VV7pudW3MaJfsg4WHmmdMtohdDPE4TuNXivzTvZ
         7Yjg==
X-Forwarded-Encrypted: i=1; AJvYcCV34unDl5A2b2omdonU/nsVt2m83E+O6O4AGFnvtMYtcRPajEjh1oWZm3eVaGizf9O2cIqvIeKisBW5K8U=@vger.kernel.org, AJvYcCXOBKSbKs+0izgOcg9wm0N/ZT3Ff6rKGE8yN92UefYmg0AQlINrPLgXVWF7bdciESBzESO9drzM9bttlVyLtYgcHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfKuTWn0e0HYppmjwH5pHTbGncNJDwDP4Qkv/O7b/8eGrTjiO
	CWKh3mBYYe5XZVP80YNXeCBfiliWciz91fcgvgL8UaNJ9RpgtfXMS3XH
X-Gm-Gg: ASbGncs7dPdmVMFdHQ/5QGKLJIp0iwHCb5oXyWyotQsY6oLNAGJaOwJ1LnEyRBXJKN2
	Q+s0tiiyUXfd9i1aGutEPeB92HySQY5prAVxC0+tiTFoG9nzRzKHBP4ctkHuPRSEZGZ/+kOrpta
	Ho0bMlBtLTIcAKr5Ws2qAQS+v3lFFdJdfS9jM4GjZh+wg5HC4LbM49shL+VickvG8XYwdSyhfR2
	TcSMd2WgreNO5X33mUXlarE3amC82mFSeKRg98E0njp/qXWziPGYq2SYrjqOYF7Xsdnw+2iWTwv
	xMlfLGby4b5fW8BKml06cfIGOAJkXlDn3U16v0WMrJ3MUgrxhQpG1bC8Oys6/ZQEqsf+yMePHpv
	bk5KTQe2gVNmkc9lhQWpwXNG4CaD+PoSmjM065O5oSQ9ehImDIDQXif8smx49Jq5bCrgbERe3fi
	IkkGNqxzIAEztZoaYaRYgxPkVo2kD7Rj5v5u2Vv/PYVW4EF5I=
X-Google-Smtp-Source: AGHT+IFB4ZAE/+ICoAqf5zvm9ZAWbXKVXVGvuWjHjQQB19ce1rjoRmkI5pBOhpvN0rwjxpibd5I8Ow==
X-Received: by 2002:a17:902:d54a:b0:235:27b6:a897 with SMTP id d9443c01a7336-23e257300ddmr225472995ad.34.1752969875471;
        Sat, 19 Jul 2025 17:04:35 -0700 (PDT)
Received: from localhost.localdomain (ec2-57-180-245-237.ap-northeast-1.compute.amazonaws.com. [57.180.245.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4e84sm34062755ad.104.2025.07.19.17.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:04:35 -0700 (PDT)
From: thaumy.love@gmail.com
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thaumy Cheng <thaumy.love@gmail.com>
Subject: [PATCH] perf/core: Fix missing read event generation on task exit
Date: Sun, 20 Jul 2025 08:04:24 +0800
Message-ID: <20250720000424.12572-1-thaumy.love@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thaumy Cheng <thaumy.love@gmail.com>

For events with inherit_stat enabled, a "read" event will be generated
to collect per task event counts on task exit.

The call chain is as follows:

do_exit
  -> perf_event_exit_task
    -> perf_event_exit_task_context
      -> perf_event_exit_event
        -> perf_remove_from_context
          -> perf_child_detach
            -> sync_child_event
              -> perf_event_read_event

However, the child event context detaches the task too early in
perf_event_exit_task_context, which causes sync_child_event to never
generate the read event in this case, since child_event->ctx->task is
always set to TASK_TOMBSTONE. This patch intends to fix that.

This bug can be reproduced by running "perf record -s" and attaching to
any program that generates perf events in its child tasks. If we check
the result with "perf report -T", the last line of the report will leave
an empty table like "# PID  TID", which is expected to contain the
per-task event counts by design.

Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
---
 kernel/events/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22fdf0c187cd..266b9eabb342 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14057,6 +14057,17 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	 */
 	mutex_lock(&ctx->mutex);

+	/*
+	 * Report the task dead after unscheduling the events so that we
+	 * won't get any samples after PERF_RECORD_EXIT. We can however still
+	 * get a few PERF_RECORD_READ events.
+	 */
+	if (exit)
+		perf_event_task(task, ctx, 0);
+
+	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
+		perf_event_exit_event(child_event, ctx, false);
+
 	/*
 	 * In a single ctx::lock section, de-schedule the events and detach the
 	 * context from the task such that we cannot ever get it scheduled back
@@ -14081,17 +14092,6 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	if (clone_ctx)
 		put_ctx(clone_ctx);

-	/*
-	 * Report the task dead after unscheduling the events so that we
-	 * won't get any samples after PERF_RECORD_EXIT. We can however still
-	 * get a few PERF_RECORD_READ events.
-	 */
-	if (exit)
-		perf_event_task(task, ctx, 0);
-
-	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, false);
-
 	mutex_unlock(&ctx->mutex);

 	if (!exit) {
--
2.49.0

