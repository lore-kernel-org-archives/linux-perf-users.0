Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB121465AE;
	Wed, 22 Jan 2025 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513113; cv=none; b=csZSVBSD95nuZXZ4BNGgx3/WhnOAc054lbxDX9hgQ1QCZjVBoei+beJNypwrbdcBXslZ1mwSrCggxIvmS9El/i4IV13/zs7KGAb2DuP3+fLCBA5XkToHNASiYrKv7jHZJNt7ZQ4Qsj58A04f9rEzWJaHIgWshhEbBGy1lWSj2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513113; c=relaxed/simple;
	bh=8KZmk0K4mi+40CnPVJnUplDw7ju6nxeHQ4/nuHlfpKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYtR6tfug1U3hh4EKaZ1/lIoMNlcinSLRjzs3dYJfBikXTtNtbBWVHDhAzj12CVSQxiignC5uONFOvNd6I0FHqu26cJntkGxW1DHD/DkOkow7t4N5/5atyAyoCPKHDYeJPzHxtXmVGBnbHtATsBbQKZeaZ4YrT4q3B3+ePfDgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBEm3bdR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBEm3bdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DEBC4CEE8;
	Wed, 22 Jan 2025 02:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513112;
	bh=8KZmk0K4mi+40CnPVJnUplDw7ju6nxeHQ4/nuHlfpKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBEm3bdRCpqONhsGvtNzK8V6nbw/Qmo0U43b7s5g4ha8Rw9JlKPxLDRENW9KtTNZ7
	 iSga87+dV/IE0W8Gr0gSbim8NrxZQr6ufYggdoD8AbUg2PRXoFc/qHz9CUypGEnUrK
	 UGfcngYdekSR80SLQCwZcle3cyNJSqpj+8UcdcZ0Eza4o5XT6Z8GtFOjyBbLfgE0Xo
	 XrLTxSFG/lefeaLbOZmM3yKUxoFHJZu29tCitAMXyhvg9UnPrKrgIZIqb9xwy7D9YO
	 10Antf7EWD/Q1n04GzfYHWG5i9fSxFgkfSQ6CLMza+xNzSgg6UGS/LtVtjkNH+ENhD
	 Q94trD+u092UA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 01/39] task_work: Fix TWA_NMI_CURRENT error handling
Date: Tue, 21 Jan 2025 18:30:53 -0800
Message-ID: <b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible for irq_work_queue() to fail if the work has already been
claimed.  That can happen if a TWA_NMI_CURRENT task work is requested
before a previous TWA_NMI_CURRENT IRQ work on the same CPU has gotten a
chance to run.

The error has to be checked before the write to task->task_works.  Also
the try_cmpxchg() loop isn't needed in NMI context.  The TWA_NMI_CURRENT
case really is special, keep things simple by keeping its code all
together in one place.

Fixes: 466e4d801cd4 ("task_work: Add TWA_NMI_CURRENT as an additional notify mode.")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/task_work.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index c969f1f26be5..92024a8bfe12 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -58,25 +58,38 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	int flags = notify & TWA_FLAGS;
 
 	notify &= ~TWA_FLAGS;
+
 	if (notify == TWA_NMI_CURRENT) {
-		if (WARN_ON_ONCE(task != current))
+		if (WARN_ON_ONCE(!in_nmi() || task != current))
 			return -EINVAL;
 		if (!IS_ENABLED(CONFIG_IRQ_WORK))
 			return -EINVAL;
-	} else {
-		/*
-		 * Record the work call stack in order to print it in KASAN
-		 * reports.
-		 *
-		 * Note that stack allocation can fail if TWAF_NO_ALLOC flag
-		 * is set and new page is needed to expand the stack buffer.
-		 */
-		if (flags & TWAF_NO_ALLOC)
-			kasan_record_aux_stack_noalloc(work);
-		else
-			kasan_record_aux_stack(work);
+#ifdef CONFIG_IRQ_WORK
+		head = task->task_works;
+		if (unlikely(head == &work_exited))
+			return -ESRCH;
+
+		if (!irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume)))
+			return -EBUSY;
+
+		work->next = head;
+		task->task_works = work;
+#endif
+		return 0;
 	}
 
+	/*
+	 * Record the work call stack in order to print it in KASAN
+	 * reports.
+	 *
+	 * Note that stack allocation can fail if TWAF_NO_ALLOC flag
+	 * is set and new page is needed to expand the stack buffer.
+	 */
+	if (flags & TWAF_NO_ALLOC)
+		kasan_record_aux_stack_noalloc(work);
+	else
+		kasan_record_aux_stack(work);
+
 	head = READ_ONCE(task->task_works);
 	do {
 		if (unlikely(head == &work_exited))
-- 
2.48.1

