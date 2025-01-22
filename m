Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9214AD02;
	Wed, 22 Jan 2025 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513114; cv=none; b=gGlAqbd9/DGs0wL3G23V7L7Ix6MLit+X8Ctf3wRjZQzX+jKnm9ywd89Hm2hXMXK7ZbWXm5rI2RGhbPnnv3coSUNuepT3zIZuYS1hsUSIIw2lR/rJZXdsj2X1u0o0LE7CLsQCLYHtttjLbRrNYIm3se/MnQxyw6NKO5az7RFKris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513114; c=relaxed/simple;
	bh=/FYrIsePcDCAg2/76OvXHiQ6BEsZk0avCDYiwfXrc5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXgbqheMV3OUKrVy+Uw0TqtRBw6/eXkdsf6uyVN9kwYx/FnbLkLOvRU0yRkTBP14ag61ZbY6xtANl3TzbxgzP4BAkSOknz69IL4eurVbuP9iSJdgWMMRhNkgtb8IIQXZydjX+rTYQpwb1i7t0tpHK1Df/5/RHNsIH3+q5yZi8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9qVTnat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9qVTnat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F0FC4CEE5;
	Wed, 22 Jan 2025 02:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513113;
	bh=/FYrIsePcDCAg2/76OvXHiQ6BEsZk0avCDYiwfXrc5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9qVTnatIttb84SXYhP9jtH2vB1TgJ2sbCWJExDsSPf6gCm1cXAqNhHQq72EQYjt1
	 DNn2LjPgGXu+4ORZOaWZM7JFB6JP3eZjZnBqTXefVg8ZUMlVJagHR5LqpuNkdAufHo
	 22+HhIVDdJ5+6SGi24MIMKWpSaTRkLoya0u2ZZ3/VLbsbROQwrBmselQkkYlD6mRPl
	 yLdjPNvv6b5t2raAvH8GCVPN3E3IhMhLZAem3LDLUFeFVQlxk/XIdYLzmx4lf9Vvud
	 Snl+WnQ1oFRhjVP3FeI4WeZdnmQAf7cr1XMAABcPWaCVaZwmMMdzibn/z5GMzVM5Dk
	 213Kk2SuQMraA==
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
Subject: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with __schedule()
Date: Tue, 21 Jan 2025 18:30:54 -0800
Message-ID: <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
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

If TWA_NMI_CURRENT task work is queued from an NMI triggered while
running in __schedule() with IRQs disabled, task_work_set_notify_irq()
ends up inadvertently running on the next scheduled task.  So the
original task doesn't get its TIF_NOTIFY_RESUME flag set and the task
work may get delayed indefinitely, or may not get to run at all.

    __schedule()
	// disable irqs
	    <NMI>
		task_work_add(current, work, TWA_NMI_CURRENT);
	    </NMI>
	// current = next;
	// enable irqs
	    <IRQ>
		task_work_set_notify_irq()
		test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME); // wrong task!
	    </IRQ>
	// original task skips task work on its next return to user (or exit!)

Fix it by storing the task pointer along with the irq_work struct and
passing that task to set_notify_resume().

Fixes: 466e4d801cd4 ("task_work: Add TWA_NMI_CURRENT as an additional notify mode.")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/task_work.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 92024a8bfe12..f17447f69843 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -7,12 +7,23 @@
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
 #ifdef CONFIG_IRQ_WORK
+
+struct nmi_irq_work {
+	struct irq_work work;
+	struct task_struct *task;
+};
+
 static void task_work_set_notify_irq(struct irq_work *entry)
 {
-	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	struct nmi_irq_work *work = container_of(entry, struct nmi_irq_work, work);
+
+	set_notify_resume(work->task);
 }
-static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
-	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
+
+static DEFINE_PER_CPU(struct nmi_irq_work, nmi_irq_work) = {
+	.work = IRQ_WORK_INIT_HARD(task_work_set_notify_irq),
+};
+
 #endif
 
 /**
@@ -65,15 +76,21 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		if (!IS_ENABLED(CONFIG_IRQ_WORK))
 			return -EINVAL;
 #ifdef CONFIG_IRQ_WORK
+{
+		struct nmi_irq_work *irq_work = this_cpu_ptr(&nmi_irq_work);
+
 		head = task->task_works;
 		if (unlikely(head == &work_exited))
 			return -ESRCH;
 
-		if (!irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume)))
+		if (!irq_work_queue(&irq_work->work))
 			return -EBUSY;
 
+		irq_work->task = current;
+
 		work->next = head;
 		task->task_works = work;
+}
 #endif
 		return 0;
 	}
@@ -109,11 +126,6 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	case TWA_SIGNAL_NO_IPI:
 		__set_notify_signal(task);
 		break;
-#ifdef CONFIG_IRQ_WORK
-	case TWA_NMI_CURRENT:
-		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
-		break;
-#endif
 	default:
 		WARN_ON_ONCE(1);
 		break;
-- 
2.48.1

