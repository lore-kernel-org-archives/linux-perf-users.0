Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051576;
	b=QM/EoT/7pVW2SmuJo+qd5ieRCY7r90zaMWEftqXA+jA3F4fzcDUtAKnUgYElFnOV+zr5
	 KtKOXP376rR92Bc5unz6Cm3yRbgwowRdGGgdnlJue8ult55X/D6JXr/oP/Xi3RGcyyWUB
	 fyLPK8tm8qnSN2k2Hs/FE+ABFKvAq5aGFMX/WmfBmGu2sAVYR1WpYXVsLoZBMfNSVhF1M
	 XxPfQ+orbySnHw0X6cwKrfZz9hKUAmLLonYS0gOnqRhufiUEJMBQmWH0/MGcucDQFOhbr
	 4Z9z9hWn9PrYy82O2sAZ2oCOJVCaGciRHHEfi0g8zkGUJQVql4wQExGOThlUhV900tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oogWXdI71uSApWoisQtM4clnwhLv0Vs2bmtqChsuYec=;
	b=eiyZX/UngqDnT5H6BZ6pCgHt6ENZbLlpxGBW43VfhtrQYxbDMQIFvuSeR9EfOeV7gjWI
	 XwGRXr5VCs1iETLQVg2pVUUgK4XVy84lsy0at9lVUWzFyfvZHdfBvKLFVGXT4Shk9c1b5
	 ckivK7HX+X6OhbdMSzcI6VqWCoX6b6psYltiQWlyfSj5bIDJyMkEWcgdhw12thj3n+aDM
	 E26zDRqCSupQHbOVvISYn13J4BnmsLf+LSPTI/uJWeb2+tsOOLKTYX4rzbJej+nNHan1z
	 zqk67MVylGZzTtouz7EIs5qdpfw7U8J6br0Eh5vVQaiT/gbYZIlt+YeiE4Vc3PwmGxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GcJ6SH3D;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837F60A380D
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3837F60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GcJ6SH3D
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd633da24f8so4263201a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051571; x=1793656371; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oogWXdI71uSApWoisQtM4clnwhLv0Vs2bmtqChsuYec=;
        b=GcJ6SH3DP8673zHsA6ML96BEbU6cg5jxwi7vPhslem9DNm2Va3231VI+rjFbBPfSFq
         CtQBwjfNzzN3yflXuOk10QkuUBss6GzqQN7A/1ZdszC392LovU9nxme3fzQ+K+wS86F+
         Y+im1T1FAFbe8SQcRoRh1tYlHphShMub+mYyZvBV1jWhRyESvkJ4EbDz1J86/4rbvO9V
         khVx3GdZlLA6XH9kCgmtLz4vRvtOVMTNKP5iY6QF9gLByYBa4ltm0185dQTbJPRksJSd
         7FkPyWxQZ6ldrmMJgE8NPwAEsUhlPcxcLEFEJMnEGGC+lpcGbVD9R1+BkHvDWyidwk+t
         IAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051571; x=1793656371;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oogWXdI71uSApWoisQtM4clnwhLv0Vs2bmtqChsuYec=;
        b=dtMqVp3ylJH3YnNbkxQ08VdMs50xUA9YWjFVvDhmoZl0eg3yAZDjaqTRJ1M17lG8td
         ZvwCK9L3Svb3CRk8Q+gmXeOoGIFbNW980dA/g0JoSyJeeQZD6JXKmRWG6YqPK+SM5aoG
         e9Ia9wWqZCJ0vo9k9coBlOOemQtdSLDTHpBN05N88xC6erIqs0tvyS5orw00PQyCWYhS
         DQuD1/v+n/KVjIvs2/HCTAGFTHLbr0leXHI13bQYoDW6dxgLaKVUAUPDVrQ91k6gklWq
         6f4VIcaN0PQgNR5CwUoY/8gb8jkq7LEeBzT6tmMfrG2UVjJjedt+HkeEVzjIP5vU4UcL
         x4ag==
X-Forwarded-Encrypted: i=1; AKwUvBwzAXLAfLXQsKlj+ef678gsME7O5jbOKUAFHZjQfSMc3pwMY3Q8FKcQqckZ87Z1Bpo5xXthB8bQS9mpr/7nr0gz@vger.kernel.org
X-Gm-Message-State: AFq9FYKS0lTTvikEHdbvnbPsv7gQ46ksf9xw49Vx+Y8Fh4FtBsusgibv
	5UNF9HjhJX62HinLkbECWS2ERamUT8Gjddhp+k6mdgN/WsZmqAvmV4K54H7tnQIpyQ9ekGF8OC5
	0Wf38uJKwndnGkgPrlQZOUQ==
X-Received: from pjbml16.prod.google.com ([2002:a17:90b:3610:b0:3ab:54fb:2a3d])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:56ce:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3adeaae618emr6704272a91.10.1793051570356;
 Mon, 26 Oct 2026 14:52:50 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:19 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-4-jthoughton@google.com>
Subject: [RFC PATCH 03/10] bpf: Fail sleepable user copy helpers when
 current->mm is NULL
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Sleepable BPF programs can run on behalf of a kernel thread, or of a
task that has already gone through exit_mm(). For example, bpf_wq
callbacks always run from a kworker, bpf_task_work callbacks queued
late enough run from exit_task_work(), and lsm.s or fentry.s programs
may be attached to functions called during exit_files(),
exit_task_work() or from kernel threads (e.g. security_file_release()
from a kworker running delayed_fput()).

In such contexts, bpf_copy_from_user(), bpf_copy_from_user_str() and
bpf_copy_from_user{,_str}_dynptr() (when reading from the current task)
call copy_from_user() or strncpy_from_user() without an mm. That access
does not reliably fail: the user half of the address space belongs to
whatever mm happens to be lazily loaded, if any, so the program may read
another task's memory.

As there is no user memory to read from in this case, fail with -EFAULT
without attempting the access.

Fixes: 07be4c4a3e7a ("bpf: Add bpf_copy_from_user() helper.")
Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Signed-off-by: James Houghton <jthoughton@google.com>
---
Tested with a small bpf_wq reproducer: a SEC("syscall") program arms a
bpf_wq whose callback (which runs in a kworker) calls
bpf_copy_from_user() on an address in the loader. With the uaccess check
from later in this series but without this patch, that triggers the new
WARN from bpf_copy_from_user(); with this patch, the helper returns
-EFAULT without warning. I can turn this into a selftest under
tools/testing/selftests/bpf if that's useful.
---
 kernel/bpf/helpers.c     | 11 +++++++++--
 kernel/trace/bpf_trace.c |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 712dca5a2c5b..c4aa8bcaf2bd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -659,7 +659,11 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,
 	   const void __user *, user_ptr)
 {
-	int ret = copy_from_user(dst, user_ptr, size);
+	int ret = -EFAULT;
+
+	/* Sleepable programs may run without an mm, e.g. on kernel threads. */
+	if (likely(current->mm))
+		ret = copy_from_user(dst, user_ptr, size);
 
 	if (unlikely(ret)) {
 		memset(dst, 0, size);
@@ -3642,7 +3646,10 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	if (unlikely(!dst__sz))
 		return 0;
 
-	ret = strncpy_from_user(dst, unsafe_ptr__ign, dst__sz - 1);
+	if (unlikely(!current->mm))
+		ret = -EFAULT;
+	else
+		ret = strncpy_from_user(dst, unsafe_ptr__ign, dst__sz - 1);
 	if (ret < 0) {
 		if (flags & BPF_F_PAD_ZEROS)
 			memset((char *)dst, 0, dst__sz);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 88c3b5b513ab..793fb3dce5f1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3556,6 +3556,8 @@ static __always_inline int copy_user_data_sleepable(void *dst, const void *unsaf
 	int ret;
 
 	if (!tsk) { /* Read from the current task */
+		if (unlikely(!current->mm))
+			return -EFAULT;
 		ret = copy_from_user(dst, (const void __user *)unsafe_src, size);
 		if (ret)
 			return -EFAULT;
@@ -3590,6 +3592,8 @@ static __always_inline int copy_user_str_sleepable(void *dst, const void *unsafe
 
 	if (tsk) {
 		ret = copy_remote_vm_str(tsk, (unsigned long)unsafe_src, dst, size, 0);
+	} else if (unlikely(!current->mm)) {
+		ret = -EFAULT;
 	} else {
 		ret = strncpy_from_user(dst, (const void __user *)unsafe_src, size - 1);
 		/* strncpy_from_user does not guarantee NUL termination */
-- 
2.56.0.307.g5fe7bd680c-goog

