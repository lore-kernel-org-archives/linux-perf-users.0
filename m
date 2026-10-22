Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634298;
	b=0uZXI1hHlb4mzUegJH3Y8HGe906IANu3sPqoUyRxsGv/2bavRu+V1YUHjmTDX9N3ADIj
	 NzduTDwTE9T6ifrCxNxEkmguNjwsl2n+46lwFcdg7HHoCarqEmFgbx55jFiZqKrB8xZw0
	 fcv/i9iwF9gJg++Rzba1ID/qkuJALiUe7LloNYU4tqMcTH+UmZAdszqOGJpUXcdoS/dEH
	 Erdm6m3ZpDb0szbGcZz+HJgIkmnu/ILngWiB0m1M1aubCRv/VvjN6Htp4iu8ZKu6HEK9W
	 uUq632CvPEd/JA2CtltsDo8iRhDohKPTiDCfR1BTlbnBnTGZn+klkGm5cihgT93sHog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n8r7pDVOusRHhAi6AWaHRjxliQyrc7O0YU7BolzZRrw=;
	b=kCtL9ZsGmVJruW07r8+pJonQow+DEm9c2a+kTetUAP/MhboaW32pIJeLzXqCKC4W50Pj
	 /IYYgGrZqytzqQTsPLXJRdShnCO+Td2FxiejMr6MbpcNWizwX275nlosRxMTVMI2HMmUv
	 4+VBDEmo9EOE5FMvWCMsVOdlDQysbv/no/06WWCq6yJRRPcz0V/kizm8RMOdjzrCgK20t
	 NrUXIEQym+fbDtP3iOF265rwHlc2LcTFVyBhXjJbtm830HGWMNGz2EusShSBl+bdwohk1
	 yT7TIc+1JAWxh4C7MQI/1mkfCtBAuKhdJrBs/ftQhCocZiibMboKoLjoMjGJtqTsPLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="IN/jLAlZ";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D035606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D035606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IN/jLAlZ
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06b436dffso563872b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 18:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634297; x=1793239097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8r7pDVOusRHhAi6AWaHRjxliQyrc7O0YU7BolzZRrw=;
        b=IN/jLAlZHfBuiCnWxgmPuH4Ccg24ZdOUqR63CbofhMX4kHiqFoo7Znc27iuyQWz4Ny
         YSMFBaxal3NTlordsbr7a2cIynCP9uy7phETVyIfnHR7ErQnF6p+vtzBFF3ysDAGhOd1
         DDOtFsFHdFqD7eMmx6lXHTIE3RzaYXi0JeGt8jbS2Bi3l+RAor3NuY1gQ3EsPojkQKj1
         1wtFg/3xWitaM9SxBY7i+czcG9z8VJJYeVjwuUE868YvXLVPYnn7BLti7Z825zmnxJ90
         ExaEHys0Mu/knEGciQhYB2+Kh85asr/PTOBgOYRXRhbpDCUHe+OE2GoD5C91HWtaDHnT
         eQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634297; x=1793239097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n8r7pDVOusRHhAi6AWaHRjxliQyrc7O0YU7BolzZRrw=;
        b=pidvZJEkJkNIU6G5CGlikmQDDqd9gB7uL9PPn3hoEUMgQNzqCxHn56FLMElzhsqykC
         Cw+UJJtBnBbmEbUGuGPOPNs0vkspIn7oOS1pF/dcNLF53aqRTDh6f8a//YzZYn3B5QCu
         5oy8RTbqYMT9RtR2BzxDAez9ZT3/AaKpMuiPtvevt1Rd1rJwG4pJAQZXtjf7wFuh5sru
         Q9i9Pts7Z+xIHIgRTazZ0d138m7xVvLJVEl/bJpggtREJMXGrJtBH9f+utetgMPIYnP5
         Gwwgv6SpUnVBqfGvS5g9kAO7WEzDr9w0QM9a7PnGXl0lnMDZSaQ8OJe1V+Iw3PPQhjnb
         HzSw==
X-Forwarded-Encrypted: i=1; AKwUvBz/U/NveP1/ydhGVUxlmxagyYW5hKar6QRHfhQuru9gPxyeQeylKqIXdrSiCJhy7IM1HEgffsYl3cXWgX58vuPW@vger.kernel.org
X-Gm-Message-State: AFq9FYIYGpWBpLZrGlzNZcAiiOTxRdOK6FKnLrChI2bv8P4zny0crkfE
	2xcSdqp/TN/vjjqc1LsJmMpJmu9uqwzQ9Xw1EdcW4604h3GCFd9bmPvn
X-Gm-Gg: AYBFou1+Tc/CWrmlOgZ2a2fiCL6TZyHr1udp9gUnedC6rl+de/zEuRxs8puzdrZsYDE
	HbSU7knZtNVa8g6BYNuJlMvoUgfAwoRBPpDhycPXEFtnTrLYZCnl2OWlzv98zHyFGxgDgPIBn80
	vRvceiYQ3Lk+3/cgTep3LUo4Ef6Atc2Ru28aGEZMTqZ9MwUiJPJLv6di6w+TH7USQ3L7avPp08I
	GbtrZNX0Ycq5zdCoTuNiKPa8tltKK6I3GBWx4KdDx85OgNF4KdSOUv9KtJavByqG56r6vka9Bue
	p9kwCVHQG+l6TgTnvxzvv5BLK0Ms1Rx+14OI+JSK3w5mDHpJh1bWggaJIoMj4LO2acJ0gIDs7PG
	jVBx8mJJv6/a0dPD2fql3ENiZGVaNbfBqe7vPoIeI9RYYV92Mmp46B7dQiYQTv1ckcPFsdQiPKg
	cJtFEYan+NBcxj8Maxp1acqanE83cnbquaO7j8ocgpNLeebG34aCxk8i7nlWRse01TqADaUF5MT
	VoD0W8gZ5xfrfXVxKOeAD2QphlVFdXZBGVUjZ2K7RXzTETEq16TSE7Lw+ENM+JD44g2XSCZn5uZ
	O/pIgJnpKMV66wNeNeldmfYA+T5fGu61HdUIHoVkfnyMRUgZHWqD4YUn1yvOOmvm6m00W3Z6IY5
	Qdwl4WkFBrmsXaMQG5cPUKaXU
X-Received: by 2002:a05:6a00:27a6:b0:878:3538:8f77 with SMTP id d2e1a72fcca58-8a089e90ad8mr3119416b3a.37.1792634296297;
        Wed, 21 Oct 2026 18:58:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b37c5sm1470060b3a.11.2026.10.21.18.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 9/9] selftests/bpf: Test uprobes and fork() with busy mmap_lock
Date: Thu, 22 Oct 2026 01:57:12 +0000
Message-ID: <20261022015712.1297331-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A process keeps its mmap_lock busy with MADV_POPULATE_READ of a large
read-only anonymous area. It maps zero page, so it costs page tables only.

- fork_multi, fork_perf: the busy process forks while uprobe is attached
  and detached. When attach is over the child has the breakpoint. When
  detach is over the child doesn't have it, and can call the function.
- fork_not_blocked: fork() of another process returns while attach is
  waiting for mmap_lock of the busy process.
- attach_not_blocked: attach to the file that the busy process doesn't map
  returns while fork() of the busy process is waiting for its mmap_lock.

The last two compare the order of events, not the time they take.

The test is serial. The busy process maps test_progs, so it would delay
uprobe attaches of other workers.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_busy_mm.c | 447 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_busy_mm.c      |  22 +
 2 files changed, 469 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_busy_mm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c b/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c
new file mode 100644
index 000000000000..30614e8b92cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Attach and detach uprobes while a process keeps its mmap_lock busy.
+ * Other processes should be able to fork, and children of the busy process
+ * should have the same breakpoints as everybody else.
+ */
+#include <pthread.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+#include "uprobe_busy_mm.skel.h"
+
+#ifndef MADV_POPULATE_READ
+#define MADV_POPULATE_READ 22
+#endif
+
+#define LOAD(x)		__atomic_load_n(&(x), __ATOMIC_SEQ_CST)
+#define STORE(x, v)	__atomic_store_n(&(x), v, __ATOMIC_SEQ_CST)
+#define INC(x)		__atomic_add_fetch(&(x), 1, __ATOMIC_SEQ_CST)
+
+#define AREA_MAX	(64UL << 30)
+#define AREA_MIN	(64UL << 20)
+#define MAX_CHILDREN	8
+#define MAX_TRIES	10
+#define TIMEOUT_NS	(30 * 1000000000ULL)
+
+struct shared {
+	/* written by the test */
+	int stop;
+	int gen;		/* odd while attach or detach is in progress */
+	int attached;
+	int hold_ms;
+	bool do_fork;
+	char insn[4];
+	/* written by the busy process */
+	int ready;
+	int hold_seq;		/* number of times mmap_lock was let go */
+	__u64 hold_ns;		/* for how long it was held the last time */
+	int in_hold;
+	int in_fork;
+	int forks;		/* number of times fork() returned */
+	int errors;
+	int checked[2];		/* children that checked their breakpoint, by ->attached */
+};
+
+static struct shared *sh;
+
+static noinline void uprobe_busy_mm_func(void)
+{
+	asm volatile ("");
+}
+
+static __u64 now_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
+/*
+ * MADV_POPULATE_READ holds mmap_lock for reading while it maps zero page
+ * all over the area. It costs page tables only.
+ */
+static void *hold_mmap_lock(void *arg)
+{
+	size_t size = AREA_MIN;
+	void *area;
+	__u64 t;
+
+	area = mmap(NULL, AREA_MAX, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
+	if (area == MAP_FAILED)
+		goto err;
+	/* EINVAL without CONFIG_TRANSPARENT_HUGEPAGE */
+	madvise(area, AREA_MAX, MADV_NOHUGEPAGE);
+
+	t = now_ns();
+	if (madvise(area, size, MADV_POPULATE_READ))
+		goto err;
+	t = now_ns() - t;
+	size *= sh->hold_ms * 1000000ULL / t + 1;
+	if (size > AREA_MAX)
+		size = AREA_MAX;
+
+	while (!LOAD(sh->stop)) {
+		STORE(sh->in_hold, 1);
+		t = now_ns();
+		madvise(area, size, MADV_POPULATE_READ);
+		/* before anything that can fault and wait for fork() */
+		INC(sh->hold_seq);
+		STORE(sh->hold_ns, now_ns() - t);
+		STORE(sh->in_hold, 0);
+		madvise(area, size, MADV_DONTNEED);
+		STORE(sh->ready, 1);
+	}
+	return NULL;
+err:
+	INC(sh->errors);
+	STORE(sh->ready, 1);
+	return NULL;
+}
+
+/*
+ * fork() began while attach or detach was in progress.
+ * When it's over the child should be like other processes.
+ */
+static int child(int gen)
+{
+	bool attached, bp;
+
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+	if (!(gen & 1))
+		return 0;
+	gen++;
+
+	while (LOAD(sh->gen) < gen) {
+		if (LOAD(sh->stop))
+			return 0;
+		usleep(100);
+	}
+
+	attached = LOAD(sh->attached);
+	bp = memcmp((void *)uprobe_busy_mm_func, sh->insn, sizeof(sh->insn));
+	if (LOAD(sh->gen) != gen)
+		return 0;
+	if (bp != attached)
+		return 1;
+
+	/* SIGTRAP when there is a breakpoint without uprobe */
+	uprobe_busy_mm_func();
+	if (LOAD(sh->gen) == gen)
+		INC(sh->checked[attached]);
+	return 0;
+}
+
+static void busy_process(void)
+{
+	int status, gen, nr = 0;
+	pthread_t thread;
+	pid_t pid;
+
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+	if (pthread_create(&thread, NULL, hold_mmap_lock, NULL)) {
+		INC(sh->errors);
+		STORE(sh->ready, 1);
+		_exit(1);
+	}
+
+	while (sh->do_fork && !LOAD(sh->stop)) {
+		while (nr && waitpid(-1, &status, nr < MAX_CHILDREN ? WNOHANG : 0) > 0) {
+			if (status)
+				INC(sh->errors);
+			nr--;
+		}
+
+		gen = LOAD(sh->gen);
+		STORE(sh->in_fork, 1);
+		pid = fork();
+		if (!pid)
+			_exit(child(gen));
+		INC(sh->forks);
+		STORE(sh->in_fork, 0);
+		if (pid < 0) {
+			INC(sh->errors);
+			break;
+		}
+		nr++;
+	}
+
+	while (nr-- && wait(&status) > 0)
+		if (status)
+			INC(sh->errors);
+	pthread_join(thread, NULL);
+	_exit(0);
+}
+
+/* The busy process gave up or is gone */
+static bool busy_process_failed(pid_t pid)
+{
+	siginfo_t si = {};
+
+	return LOAD(sh->errors) ||
+	       waitid(P_PID, pid, &si, WEXITED | WNOHANG | WNOWAIT) || si.si_pid;
+}
+
+static pid_t start_busy_process(int hold_ms, bool do_fork)
+{
+	__u64 t = now_ns();
+	pid_t pid;
+
+	sh = mmap(NULL, sizeof(*sh), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(sh, MAP_FAILED, "mmap"))
+		return -1;
+
+	sh->hold_ms = hold_ms;
+	sh->do_fork = do_fork;
+	memcpy(sh->insn, (void *)uprobe_busy_mm_func, sizeof(sh->insn));
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork")) {
+		munmap(sh, sizeof(*sh));
+		return -1;
+	}
+	if (!pid)
+		busy_process();
+
+	while (!LOAD(sh->ready) && !busy_process_failed(pid) && now_ns() - t < TIMEOUT_NS)
+		usleep(1000);
+	if (!ASSERT_TRUE(LOAD(sh->ready), "busy_process_ready")) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		munmap(sh, sizeof(*sh));
+		return -1;
+	}
+	return pid;
+}
+
+static void stop_busy_process(pid_t pid)
+{
+	int status = -1;
+
+	STORE(sh->stop, 1);
+	waitpid(pid, &status, 0);
+	ASSERT_EQ(status, 0, "busy_process_status");
+	ASSERT_EQ(sh->errors, 0, "errors");
+	munmap(sh, sizeof(*sh));
+}
+
+/* Returns hold_seq of the hold that has just begun, -1 if there won't be one */
+static int wait_for_hold(pid_t pid, bool in_fork)
+{
+	__u64 t = now_ns();
+	int seq;
+
+	while (!busy_process_failed(pid) && now_ns() - t < TIMEOUT_NS) {
+		if (!LOAD(sh->in_hold) || (in_fork && !LOAD(sh->in_fork))) {
+			usleep(100);
+			continue;
+		}
+		seq = LOAD(sh->hold_seq);
+		/* let them get into the kernel */
+		usleep(10000);
+		if (LOAD(sh->hold_seq) == seq && (!in_fork || LOAD(sh->in_fork)))
+			return seq;
+	}
+
+	return -1;
+}
+
+static struct bpf_link *attach(struct uprobe_busy_mm *skel, bool multi,
+			       const char *path, unsigned long offset)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts, .offsets = &offset, .cnt = 1);
+
+	if (multi)
+		return bpf_program__attach_uprobe_multi(skel->progs.probe_multi, -1, path,
+							NULL, &opts);
+	return bpf_program__attach_uprobe(skel->progs.probe_perf, false, -1, path, offset);
+}
+
+/*
+ * Wait for a child to check its breakpoint in this state. fork() that began
+ * during attach or detach may sleep until the next hold is over.
+ */
+static void wait_for_check(int attached, int checked)
+{
+	__u64 t = now_ns(), max = 2 * LOAD(sh->hold_ns) + 100 * 1000000ULL;
+
+	while (LOAD(sh->checked[attached]) == checked && now_ns() - t < max)
+		usleep(1000);
+}
+
+static void test_fork(struct uprobe_busy_mm *skel, bool multi)
+{
+	struct bpf_link *link;
+	ssize_t offset;
+	int i, checked;
+	pid_t pid;
+	__u64 t;
+
+	offset = get_uprobe_offset(&uprobe_busy_mm_func);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return;
+
+	pid = start_busy_process(20, true);
+	if (pid < 0)
+		return;
+	skel->bss->hits = 0;
+	t = now_ns();
+
+	for (i = 0; !busy_process_failed(pid) && now_ns() - t < TIMEOUT_NS; i++) {
+		if (i >= 10 && LOAD(sh->checked[0]) && LOAD(sh->checked[1]))
+			break;
+
+		checked = LOAD(sh->checked[1]);
+		INC(sh->gen);
+		link = attach(skel, multi, "/proc/self/exe", offset);
+		if (!ASSERT_OK_PTR(link, "attach"))
+			break;
+		STORE(sh->attached, 1);
+		INC(sh->gen);
+		wait_for_check(1, checked);
+
+		checked = LOAD(sh->checked[0]);
+		INC(sh->gen);
+		bpf_link__destroy(link);
+		STORE(sh->attached, 0);
+		INC(sh->gen);
+		wait_for_check(0, checked);
+	}
+
+	ASSERT_GT(LOAD(sh->checked[1]), 0, "checked_attached");
+	ASSERT_GT(LOAD(sh->checked[0]), 0, "checked_detached");
+	ASSERT_GE(skel->bss->hits, LOAD(sh->checked[1]), "hits");
+	stop_busy_process(pid);
+}
+
+struct attach_args {
+	struct uprobe_busy_mm *skel;
+	unsigned long offset;
+	struct bpf_link *link;
+	int done;
+};
+
+static void *attach_thread(void *arg)
+{
+	struct attach_args *args = arg;
+
+	args->link = attach(args->skel, true, "/proc/self/exe", args->offset);
+	STORE(args->done, 1);
+	return NULL;
+}
+
+/* fork() doesn't wait for attach that waits for mmap_lock of the busy process */
+static void test_fork_not_blocked(struct uprobe_busy_mm *skel)
+{
+	struct attach_args args = { .skel = skel };
+	pid_t pid, child_pid;
+	bool ok = false;
+	pthread_t thread;
+	ssize_t offset;
+	int i, seq;
+
+	offset = get_uprobe_offset(&uprobe_busy_mm_func);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return;
+	args.offset = offset;
+
+	pid = start_busy_process(300, false);
+	if (pid < 0)
+		return;
+
+	for (i = 0; i < MAX_TRIES && !ok && !LOAD(sh->errors); i++) {
+		seq = wait_for_hold(pid, false);
+		if (!ASSERT_GE(seq, 0, "wait_for_hold"))
+			break;
+
+		args.done = 0;
+		if (!ASSERT_OK(pthread_create(&thread, NULL, attach_thread, &args),
+			       "pthread_create"))
+			break;
+		/* attach waits for RCU first, fork() isn't blocked by that */
+		usleep(LOAD(sh->hold_ns) / 2000);
+
+		child_pid = fork();
+		if (!child_pid)
+			_exit(0);
+		ok = child_pid > 0 && !LOAD(args.done) && LOAD(sh->hold_seq) == seq;
+		if (child_pid > 0)
+			waitpid(child_pid, NULL, 0);
+
+		pthread_join(thread, NULL);
+		if (!ASSERT_OK_PTR(args.link, "attach"))
+			break;
+		bpf_link__destroy(args.link);
+	}
+
+	ASSERT_TRUE(ok, "fork_not_blocked");
+	stop_busy_process(pid);
+}
+
+/* attach doesn't wait for fork() that waits for mmap_lock of the busy process */
+static void test_attach_not_blocked(struct uprobe_busy_mm *skel)
+{
+	const char *path = "./uprobe_multi", *sym = "uprobe_multi_func_00000";
+	unsigned long *offsets = NULL;
+	struct bpf_link *link;
+	bool ok = false;
+	int i, seq, forks;
+	pid_t pid;
+
+	if (!ASSERT_OK(elf_resolve_syms_offsets(path, 1, &sym, &offsets, STT_FUNC),
+		       "elf_resolve_syms_offsets"))
+		return;
+
+	pid = start_busy_process(300, true);
+	if (pid < 0)
+		goto out;
+
+	for (i = 0; i < MAX_TRIES && !ok && !LOAD(sh->errors); i++) {
+		seq = wait_for_hold(pid, true);
+		if (!ASSERT_GE(seq, 0, "wait_for_hold"))
+			break;
+
+		forks = LOAD(sh->forks);
+
+		link = attach(skel, true, path, offsets[0]);
+		/*
+		 * attach that waited for fork() returns as soon as fork() has
+		 * copied mm, maybe before the busy process bumps forks and
+		 * hold_seq. Give it a quarter of the hold to do that.
+		 */
+		usleep(LOAD(sh->hold_ns) / 4000);
+		ok = LOAD(sh->in_fork) && LOAD(sh->forks) == forks &&
+		     LOAD(sh->hold_seq) == seq;
+		if (!ASSERT_OK_PTR(link, "attach"))
+			break;
+		bpf_link__destroy(link);
+	}
+
+	ASSERT_TRUE(ok, "attach_not_blocked");
+	stop_busy_process(pid);
+out:
+	free(offsets);
+}
+
+void serial_test_uprobe_busy_mm(void)
+{
+	struct uprobe_busy_mm *skel;
+
+	skel = uprobe_busy_mm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_busy_mm__open_and_load"))
+		return;
+
+	if (test__start_subtest("fork_multi"))
+		test_fork(skel, true);
+	if (test__start_subtest("fork_perf"))
+		test_fork(skel, false);
+	if (test__start_subtest("fork_not_blocked"))
+		test_fork_not_blocked(skel);
+	if (test__start_subtest("attach_not_blocked"))
+		test_attach_not_blocked(skel);
+
+	uprobe_busy_mm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_busy_mm.c b/tools/testing/selftests/bpf/progs/uprobe_busy_mm.c
new file mode 100644
index 000000000000..c07a9961db13
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_busy_mm.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 hits;
+
+SEC("uprobe.multi")
+int probe_multi(struct pt_regs *ctx)
+{
+	__sync_fetch_and_add(&hits, 1);
+	return 0;
+}
+
+SEC("uprobe")
+int probe_perf(struct pt_regs *ctx)
+{
+	__sync_fetch_and_add(&hits, 1);
+	return 0;
+}
-- 
2.55.0

