Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C811B151F;
	Thu,  4 Jul 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112673; cv=none; b=IXClgXoB3zpC0fEkVcsoH6vD4HJngPsNCC0vKf0l2tZnUakYUH4oz1LHPTZit7UDF5NzymHM0LnkEll0K7iKx2DyJ+IY84+FMAzob0L5mQkjkPcbbW1zHKlQoCq7j3JHFyIerLeNyUTXf+yFDz20xHT26ooK2iZh57tr6ayVfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112673; c=relaxed/simple;
	bh=6eqRPcMlbj+4GVbr5+U0VOyaTZIgPiL/0X2LQRUJRks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZI2bpFumGO+skjt2KKNazJ+gC2CFajoNCKilfraLGSUee5+AnURRHNhFqY2nGVLDbrApCtB1SgCFj0Qu5d8DuHm/EdJVr+Q5jgoW8t4DGMXs+ARNdWSHIFhXve0tAPWSA315aCXxIq0LxJwSBX1VhqeLqwlj7GqieZTll++pzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bywyui1x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HKQ3CKiW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bywyui1x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKQ3CKiW"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poySimGW+vu2aH2BbOceqnQrJPwa17Ey3AjyM7/+uMc=;
	b=Bywyui1xnrK/jO9L52kEa/1jMRp69HkTNh3x5+ZW1b15PNiwFB3HJI/xWYV6M1wvbHwbOA
	1vsO4Ko83PhAEsObJYdzeTs8b1VNX/pc2OQdcQD7xu35a7g7icrCimdZPM0+Vub7+Oon0m
	8DqoLHY8n3lBpdYsuCVJLW4x4jmjTwt7E8ZQ+1XMHlJ0PZhpvfhySJ81xSL7SNP/OYno8q
	JzmrLr+tM8d5V2rsmG/FsPlAULjZqf754QKrtZZYOSWq0CYzxDGoOrvwUAtQi9dmzcXodA
	Vl3wtCESbAOx2gLIKrpjan3RdOcvs6W6jLqNqWs9gfVRv/IwuNKfdbt6LcWXDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poySimGW+vu2aH2BbOceqnQrJPwa17Ey3AjyM7/+uMc=;
	b=HKQ3CKiWv88vO5FChtzpBmgGQ4x5UyxmAo2NufTRW6ZBJsVuoniA+JCupAOPY7jsPkfoGN
	HV1iBy7Ak7fGKNBA==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang  <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 2/7] task_work: Add TWA_NMI_CURRENT as an additional notify mode.
Date: Thu,  4 Jul 2024 19:03:36 +0200
Message-ID: <20240704170424.1466941-3-bigeasy@linutronix.de>
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding task_work from NMI context requires the following:
- The kasan_record_aux_stack() is not NMU safe and must be avoided.
- Using TWA_RESUME is NMI safe. If the NMI occurs while the CPU is in
  userland then it will continue in userland and not invoke the `work'
  callback.

Add TWA_NMI_CURRENT as an additional notify mode. In this mode skip
kasan and use irq_work in hardirq-mode to for needed interrupt. Set
TIF_NOTIFY_RESUME within the irq_work callback due to k[ac]san
instrumentation in test_and_set_bit() which does not look NMI safe in
case of a report.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/task_work.h |  1 +
 kernel/task_work.c        | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 26b8a47f41fca..cf5e7e891a776 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -18,6 +18,7 @@ enum task_work_notify_mode {
 	TWA_RESUME,
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
+	TWA_NMI_CURRENT,
 };
=20
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 2134ac8057a94..05fb41fe09f5d 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -1,10 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/irq_work.h>
 #include <linux/spinlock.h>
 #include <linux/task_work.h>
 #include <linux/resume_user_mode.h>
+#include <trace/events/ipi.h>
=20
 static struct callback_head work_exited; /* all we need is ->next =3D=3D N=
ULL */
=20
+static void task_work_set_notify_irq(struct irq_work *entry)
+{
+	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+}
+static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =3D
+	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
+
 /**
  * task_work_add - ask the @task to execute @work->func()
  * @task: the task which should run the callback
@@ -12,7 +21,7 @@ static struct callback_head work_exited; /* all we need i=
s ->next =3D=3D NULL */
  * @notify: how to notify the targeted task
  *
  * Queue @work for task_work_run() below and notify the @task if @notify
- * is @TWA_RESUME, @TWA_SIGNAL, or @TWA_SIGNAL_NO_IPI.
+ * is @TWA_RESUME, @TWA_SIGNAL, @TWA_SIGNAL_NO_IPI or @TWA_NMI_CURRENT.
  *
  * @TWA_SIGNAL works like signals, in that the it will interrupt the targe=
ted
  * task and run the task_work, regardless of whether the task is currently
@@ -24,6 +33,8 @@ static struct callback_head work_exited; /* all we need i=
s ->next =3D=3D NULL */
  * kernel anyway.
  * @TWA_RESUME work is run only when the task exits the kernel and returns=
 to
  * user mode, or before entering guest mode.
+ * @TWA_NMI_CURRENT works like @TWA_RESUME, except it can only be used for=
 the
+ * current @task and if the current context is NMI.
  *
  * Fails if the @task is exiting/exited and thus it can't process this @wo=
rk.
  * Otherwise @work->func() will be called when the @task goes through one =
of
@@ -44,8 +55,13 @@ int task_work_add(struct task_struct *task, struct callb=
ack_head *work,
 {
 	struct callback_head *head;
=20
-	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack(work);
+	if (notify =3D=3D TWA_NMI_CURRENT) {
+		if (WARN_ON_ONCE(task !=3D current))
+			return -EINVAL;
+	} else {
+		/* record the work call stack in order to print it in KASAN reports */
+		kasan_record_aux_stack(work);
+	}
=20
 	head =3D READ_ONCE(task->task_works);
 	do {
@@ -66,6 +82,9 @@ int task_work_add(struct task_struct *task, struct callba=
ck_head *work,
 	case TWA_SIGNAL_NO_IPI:
 		__set_notify_signal(task);
 		break;
+	case TWA_NMI_CURRENT:
+		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
--=20
2.45.2

