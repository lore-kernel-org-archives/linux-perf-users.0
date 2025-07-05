Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FE8462;
	Sat,  5 Jul 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751726640; cv=none; b=VnTXkH+sV/MAcdJ7I5iK9ffGZOQmigw4voHl6hSCZ5OdDYBv9wAPImz5jvtJrnyMJVvBtG5QSts35LeA+Mo3AJeC+Br2q6mpwU1TJ2Ka6heOLUJ04C83lLae8P9ydSETtYWx2SYMR8ZpEmyVWVZEy5G+sdBrueOT/5QEiLUo2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751726640; c=relaxed/simple;
	bh=YI//x8ls7R+pdx9z7vF4GczOnOwBb1p1eyUMgVpi8i0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=YyF74y1LtMbqb3albBvwb+TNkkIEAzmslE+s/YxCZePFgKwkToY1UPASvS7oZa+RH95DouHYTTCuqYB0iJgAHFiSPu/KHjFzHVX8zxKRZ5SO0aXm/Y/ZhBQCkJT6NEgUOSkr05vnhYn1dSZ/4EUCl/SoIcmRozIsVtcl4NiDCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 565EhcLa057270;
	Sat, 5 Jul 2025 23:43:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 565Ehcke057266
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 5 Jul 2025 23:43:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f8dee957-d286-421d-976a-c0c580454fb3@I-love.SAKURA.ne.jp>
Date: Sat, 5 Jul 2025 23:43:37 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] perf/core: Fix WARN in perf_sigtrap()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <685af60a.a00a0220.2e5631.0092.GAE@google.com>
 <ed888189-dad4-47e1-bfc8-4f2213eda32d@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <ed888189-dad4-47e1-bfc8-4f2213eda32d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Virus-Status: clean

Since commit 4f6fc7821283 ("perf: Fix sample vs do_exit()") has moved
perf_event_exit_task() call from after exit_task_work() to before
exit_task_work(), task_work_add() from perf_event_exit_task() now returns
0 than -ESRCH, despite perf_event_exit_task_context() updates ctx->task
to TASK_TOMBSTONE. As a result, event->ctx->task == current assumption
no longer holds.

Reported-by: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=2fe61cb2a86066be6985
Fixes: 4f6fc7821283 ("perf: Fix sample vs do_exit()")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
#syz test

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7281230044d0..489f42defe3c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7208,7 +7208,8 @@ static void perf_sigtrap(struct perf_event *event)
 	 * ctx->task or current has changed in the meantime. This can be the
 	 * case on architectures that do not implement arch_irq_work_raise().
 	 */
-	if (WARN_ON_ONCE(event->ctx->task != current))
+	if (WARN_ON_ONCE(event->ctx->task != current &&
+			 event->ctx->task != TASK_TOMBSTONE))
 		return;
 
 	/*
-- 
2.50.0

