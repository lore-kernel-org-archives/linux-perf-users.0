Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830728;
	b=117DLZiWBz0RaoBlqKjfo4iZ57hv5VH+8xhjeWkNHpNvfvsZnEK78Q8pei7Wzvcqn8zy
	 bVbpGz8QWwAeMPmC8MFUpYs41F3oERL5xUo4VaBoeRu7MLkYRAyv1XqO5V1RXF3yTuDxd
	 2nDpWShrMZJM9uV1tA+2nCHwJl6elaqPyB/OJdudHlAjvcvgobH0s4qA6WOgOUfmjBw/2
	 9TasEVZdZQliGmuC8d5PAIpCz5nd0g1MEBhFuNNMV4/dKvZf3i5omN8GxfucR11ItsvPR
	 Rcqfu7xZFjRtMDLsVMqydZ6bboc9tPAbzl24QMLH6oDf8s8evddugAifrhIRqiTsg9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830728;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=gnU4+EwBT9Yy+gbxDxLRhY3mmvHPY7F2R3oFBIuWmPk=;
	b=fyV/R7K2yz3VAeOOuyFzufTlmfy+CP5CV6owyaTaMwfkpX3OPBGkMRGCWvjFcpNuNZI6
	 QPDkDIIwFintdoJlVRpFWRwpm3vydCZjr3nknWCgoaG3SViG3WbHpxwfUDujsKszKZN54
	 QG9RWQMr0I5B2zHyya5ZJZB3FG1TO5VdofwKDCYdGTwpOEfwbeth9QKBU8ybu1/uwSJjH
	 JxM0scU9N5C5cSE6uCM37oR0vRnog94a1fY1eAbp5hddAVM6fOZG7oNyQmDFwre1LfFAM
	 sPXVcEChqhLXYpO4fMPBLNNbYsAj/ZRLHyU7yJ4eyEw6m0cjl4BMKVarewBioJzLVFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF484606A330;
	Mon, 16 Nov 2026 12:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF484606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gnU4+EwBT9Yy+gbxDxLRhY3mmvHPY7F2R3oFBIuWmPk=; b=YP+HyxR72saZz
	eQkLbzd8u4286T09fnvSMZ0HA6rSrZDugya5ChoVOzhviHHxQB4f9KifGdLgvroz
	TMfOel5heuKsvLOx3zGkF1/TIcsZQSPiG3k6IZnLsXfQi+R8csp7qSNiMKwpMX0T
	7oVKnyqJ39MtvzQmiRQ0dI1LZY+Uf4=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [240e:454:8411:e49:29:34e0:92e:39c2])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkAGC_5o8fpqGke3AQ--.45651S2;
	Mon, 16 Nov 2026 20:04:58 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+56ad4cdaff8716472033@syzkaller.appspotmail.com,
	Jinning Zhang <25031212117@stu.xidian.edu.cn>,
	Bin Yu <byu@xidian.edu.cn>,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>
Subject: [PATCH] perf/core: Protect ctx after dropping its reference
Date: Mon, 16 Nov 2026 20:04:52 +0800
Message-Id: <20261116120452.22269-1-26031212468@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkAGC_5o8fpqGke3AQ--.45651S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4kWw48tryxKF13Gr4kZwb_yoW5Jry5pr
	WkAr1Yk395WFnIya1DKwnrWw18Cws5JrZrAryvg3WxZrnxX3yaya4Igr45ZFZ8Zr92ya40
	qF4qyr45Ca98ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vEIxC_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnbyZ
	UUUUU
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAQUTEWr5ytfRTwABsX

Take an RCU read lock before decrementing the reference and retain it
through the non-final branch's tombstone check and wakeup. This keeps ctx
alive until that branch has finished. When the decrement is final,
release the read lock immediately; that caller continues the final
cleanup and queues the RCU callback.

Read ctx->task with READ_ONCE(), matching the WRITE_ONCE() used when the
task context is marked as a tombstone. Keep smp_mb__after_atomic(): it
preserves the existing wait_var_event() ordering, while RCU protects the
context's lifetime.

A similar fix was posted by Weiming Shi in October:
https://lkml.iu.edu/2610.0/09721.html. This version releases the RCU
read lock immediately on the final-put path and uses READ_ONCE() for the
lockless ctx->task check.

The report shows the access in put_ctx() reached through event release,
and the free callback was queued from task-exit context cleanup. These
stacks are consistent with the post-decrement lifetime race described
above.

Fixes: 59f3aa4a3ee2 ("perf: Simplify perf_event_free_task() wait")
Reported-by: syzbot+56ad4cdaff8716472033@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=56ad4cdaff8716472033
Link: https://lkml.iu.edu/2610.0/09721.html
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>
---
 kernel/events/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1385,13 +1385,17 @@ static void put_ctx(struct perf_event_context *ctx)
 {
+	/* The non-final path accesses ctx after dropping its reference. */
+	rcu_read_lock();
 	if (refcount_dec_and_test(&ctx->refcount)) {
+		rcu_read_unlock();
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
 			put_task_struct(ctx->task);
 		call_rcu(&ctx->rcu_head, free_ctx);
 	} else {
 		smp_mb__after_atomic(); /* pairs with wait_var_event() */
-		if (ctx->task == TASK_TOMBSTONE)
+		if (READ_ONCE(ctx->task) == TASK_TOMBSTONE)
 			wake_up_var(&ctx->refcount);
+		rcu_read_unlock();
 	}
 }




