Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693559;
	b=BKP1LTAZyDOkj/W2ql546553+VeyzBfI0aUTxvRsdS7gatI2JS1rArzWmQHZyAAFfUi4
	 fbauywvT3NHZvn9mgyOTPvA6Q9eh47WJXhu6u4ZOCId2R4QlWhDj3wEKPlyjUpufGzsvE
	 FNo3xsT+eTvtVsk3yVre3kyuOTnaaodEAgsI1Wh+QaIQzxRSrMgccVAMIACWprt021t7+
	 uWjmdfaKSBDEtBzdfLokL6rQ4w4VllOM9asy9pueTPr08TR39RihpqYK3HzLzwCXfxCcO
	 YUglyJ164wXCBfoJoE1ktmsTMMe8WwY8RdMJ8Mhzqlb5VLmZUvEav3kH7l100oY0aug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693559;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oCVKkm4f9Obj7XlSywE0ap8ndEiiATh44eN7085wCzk=;
	b=AkGN5ovxsovMfJUD2p+hPpZlAJxPcbzIKXtD7DD8P9QHXCAGGBUvYVc3oi0m43yVji1O
	 QiNvDKWynclvLNdTkArJlM+vQ3UgxYDZRy/v3mKjaHqOo/KD/1g2cde8WrEuGJ0M9WrZs
	 dJ8LvECFjbf7KQI1WIW7hZ13ZFoe92AMQXYD6w+gLrowQ3FupxAscszjhNovEth/Arwyk
	 yfOqVlMOnhdC8q3crqUJp7BltLrGw98G3EFr2YxLCsa7OsoILBkgnZWRjRWOa2L/HkTxk
	 q6tJaI5n7qfoWhRRPcaYZD6d+qb5iqoz+BloSuVNzQ9nK1RRNGQqvzNttSqGXN8515Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eV9snUd7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12D606A683;
	Thu, 26 Nov 2026 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eV9snUd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4D11F000D3;
	Thu, 26 Nov 2026 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693559;
	bh=oCVKkm4f9Obj7XlSywE0ap8ndEiiATh44eN7085wCzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eV9snUd7w6kHtqORv8OiDNahUVQnAn2zxYU1i+xbeDGfaejjxmCqHBXMXW25oEzzS
	 jYL2RvC+AZe2jtyZVLPJ4uaDRRh78AepoKZZMJ4zohhj0p+c6JiDDviEsTiWmzgqAe
	 zzf0/GC2f8C7mWsHrIWV+NHWj7mJjmn9bjRHzzqFZOveig8T2j2n5Feq+W1amweFTO
	 ZprdQQQtK0Oh1TlWbgrCKD/U4RsVLKygQwSDfX4AjhGv1hFzDTrYGrxYHhBf6DEIdw
	 4Fh2PJQZyAZ6fDhGnuSjQHaafaM7m5Fj4HE7wtG71qtNoL58U3ucY8PR7CRX3JnEpo
	 PtzkhCwB5ZL6g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 12:45:38 +0100
Subject: [PATCH 2/2] proc: call task_vsize() without exec_update_lock held
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-work-exec-update_lock-leftovers-v1-2-1024b26792bc@kernel.org>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
In-Reply-To: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jann Horn <jannh@google.com>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZLfIS/MvPu3e7kPlZkdOosmk2kMkrxHknsWGHGztnvE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzSL895pG1s7Wkvri6gjmo+ktT+BPWL6smCEqZ+n5oC
 HUqsk/tKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIhnHiPDr4/c+kef741cMmlb
 mc4E3nO+f+VfHnWKEN53y01izredMxn+2e5R7+9dUX+Gacft07XL3s2Z53NpeZjfMwuW3lvNp1u
 qeAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit 6650527444da ("proc: protect ptrace_may_access() with
exec_update_lock (part 1)") do_task_stat() holds the exec_update_lock of
the task from the access check until the last field is printed. In
between it calls task_vsize() and without an MMU that takes the mmap
lock to add up the vmas:

  locks held by stat-reader/46:
   #0: (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0x38/0x32a
   #1: (&sig->exec_update_lock){++++}-{4:4}, at: do_task_stat+0x50/0xd04
   #2: (&mm->mmap_lock){++++}-{4:4}, at: task_vsize+0x5e/0xd2

So a read of /proc/<pid>/stat waits for the mmap lock with
exec_update_lock held. And without an MMU the mmap lock can be held for
a long time. A private mapping of a file is read into memory with it
held for writing:

  locks held by holder/47:
   #0: (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x56/0x136
   #1: (nommu_region_sem){+.+.}-{4:4}, at: do_mmap+0x21e/0xb02
   #2: (&sb->s_type->i_mutex_key#7){.+.+}-{4:4}, at: blkdev_read_iter+0xa6/0x1c0

The lock is only needed for the access check and for what is read from
the task depending on it. The mm is pinned and everything else is shown
to everyone anyway. So drop the lock once that is done and call
task_vsize() afterwards.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/array.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index f6f75d206762a..3ff6f2455e5e4 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -493,7 +493,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	permitted = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS | PTRACE_MODE_NOAUDIT);
 	mm = get_task_mm(task);
 	if (mm) {
-		vsize = task_vsize(mm);
 		/*
 		 * esp and eip are intentionally zeroed out.  There is no
 		 * non-racy way to read them without freezing the task.
@@ -543,6 +542,17 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
 
+	/*
+	 * What depends on the access check has been read from the task or
+	 * comes from the mm that was pinned along with it. Don't hold
+	 * exec_update_lock for the rest, task_vsize() takes the mmap lock
+	 * without an MMU.
+	 */
+	up_read(&task->signal->exec_update_lock);
+
+	if (mm)
+		vsize = task_vsize(mm);
+
 	scoped_guard(rcu) {
 		scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
 			cmin_flt = sig->cmin_flt;
@@ -662,7 +672,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, " 0");
 
 	seq_putc(m, '\n');
-	up_read(&task->signal->exec_update_lock);
 	if (mm)
 		mmput(mm);
 	return 0;

-- 
2.53.0

