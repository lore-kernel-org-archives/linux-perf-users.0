Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F61F92A
	for <linux-perf-users@vger.kernel.org>; Sun, 29 Jun 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751194325; cv=none; b=T4rELSupUlEw21k4rStCzGDjYpFprR/O43Wdlqp3vmdBNo6b7XCW2T8YqDSlrevjnd4tR1HE7PPAkagu+P1IjIlminzDlpFX/cWfb5UiFRO/PZhkN3GB4oeRENPwIOlaqzr61CAWo2DEweBNWl1vSIdK5wLIkfXwYXtKOfzY2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751194325; c=relaxed/simple;
	bh=rUYSYfiO5NWyG6GJ6BqRO9d3+wlDxgQEDdY4uttUl9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=d6VpZ4T0cia6S+2gk76TlFGx82gFfeGLTZevDMTRdyd8wDl5SkMcfHXW6qtp9PsNwONmBuEAbGu+oxQTzt3i8rpjveZ48C8MMINGqGLvygnTIdxAkZpVbjF/8Dduj9mbgGL54MacOPe6kYbw+ywRT5Z6l20xBSc0qPgXk6uk5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55TAp25C053061;
	Sun, 29 Jun 2025 19:51:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55TAp1mT053058
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 29 Jun 2025 19:51:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ed888189-dad4-47e1-bfc8-4f2213eda32d@I-love.SAKURA.ne.jp>
Date: Sun, 29 Jun 2025 19:51:00 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [perf?] WARNING in perf_pending_task
To: Baisheng Gao <baisheng.gao@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <685af60a.a00a0220.2e5631.0092.GAE@google.com>
Content-Language: en-US
Cc: acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        jolsa@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mingo@redhat.com, namhyung@kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <685af60a.a00a0220.2e5631.0092.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

Hello.

I think that the cause of this problem is commit 4f6fc7821283 ("perf: Fix sample vs do_exit()"), for
syzbot found this problem in 5.15.186 and 6.1.142 where that was the only commit in kernel/events/ area
which has been backported between v5.15.185...v5.15.186 and v6.1.141...v6.1.142 .

Please have a look on this change. Maybe we need to swap WARN_ON_ONCE() and PF_EXITING checks?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f746469fda5..5a3a1331311f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7204,18 +7204,18 @@ void perf_event_wakeup(struct perf_event *event)
 static void perf_sigtrap(struct perf_event *event)
 {
 	/*
-	 * We'd expect this to only occur if the irq_work is delayed and either
-	 * ctx->task or current has changed in the meantime. This can be the
-	 * case on architectures that do not implement arch_irq_work_raise().
+	 * Both perf_pending_task() and perf_pending_irq() can race with the
+	 * task exiting.
 	 */
-	if (WARN_ON_ONCE(event->ctx->task != current))
+	if (current->flags & PF_EXITING)
 		return;
 
 	/*
-	 * Both perf_pending_task() and perf_pending_irq() can race with the
-	 * task exiting.
+	 * We'd expect this to only occur if the irq_work is delayed and either
+	 * ctx->task or current has changed in the meantime. This can be the
+	 * case on architectures that do not implement arch_irq_work_raise().
 	 */
-	if (current->flags & PF_EXITING)
+	if (WARN_ON_ONCE(event->ctx->task != current))
 		return;
 
 	send_sig_perf((void __user *)event->pending_addr,

On 2025/06/25 4:01, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b67ec639010f Merge tag 'i2c-for-6.16-rc3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17715b0c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fe61cb2a86066be6985
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f15b0c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1692ab0c580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b67ec639.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3bcb2b262d02/vmlinux-b67ec639.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f5d4477f1e2e/bzImage-b67ec639.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com
