Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCE3655F0
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907768; cv=none; b=WsWtTa+ROH8Fe8GQZd+Nx4sLkQRyC4tu48ySwVfc2+IWAFVjf1xoI7wa2B7pH6gYn1EwgSUtaV2VUBJgMXubou80Nugs7XWxrqPaOTtYqWZigZ3RIUqmqru+L5hBowoCJtz5A1SaDbn34LoB87K/3clb1o56WGY+MNkFFoHaya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907768; c=relaxed/simple;
	bh=p2qqezOeQBJ7LeJXpKYU5pekBY4tC8RKSZZqP5XrTYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPbH2ct24DVdf3jBNrzC5yg3Sika77uat250rvtDwlqVuJPwHn5L2p5rzLw/IiNIihe9LOmk9Tpj1SXkOkj5gIiQI1LBTiBqjz9IPh4BO0JG4IC3olzETO+4fMtgXFl8ksVB9oxyzvmE1QjOuKb0mSa5K0phCQaUTlYwCelysk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOlG1fyw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOlG1fyw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956242332dso5576605e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784907765; x=1785512565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wb0dqaku2IAsiOylX1Z0HPckkT83j8rG7POsYnzZWxY=;
        b=bOlG1fywgUM/mDHTLS0Bi0ogttc/tLw7LVj9X2nKkKlBFPC9X00CTv7Mc3s1xPmDmx
         659lGXt1jgiGMIe3WjxE7/Cnf2wN5o3/kQPXFLAvZ6DTDWgl7XZilteK8F7sWUVVTw1B
         WFOhYxQXeRXO6CpNhBOK7TQpETe4V5N0+pxV4tBmorI1q1eVzv8oYvBeYvRqlJYi75pf
         yN4XojBldpSEURz/jf7MBjx8kt8+n0KoUkzSEHMKyMJ0ITq8gUY0kRoAizwtWkxNX4+N
         0ddoGTMCnqKq1IFgL3uz72lgjCayCghrIHI+WcDp0u/Jl8OqWJBKHGYgWOaFSlc92SD8
         HeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907765; x=1785512565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wb0dqaku2IAsiOylX1Z0HPckkT83j8rG7POsYnzZWxY=;
        b=H51Mn2f0ngGakyFhW+P1QvFqH1Il4NXET0j7Ip4WAWHTdY9n+LIbmFGVi27wEZglCi
         PmgpWcdNa82s4AbcYZTm9NBzJvjt6UpHnaCZVILxQL1phpQe/S3wXD/3iWaVuSccirWK
         BfI1G8JJgWcBUgE8tbzPwOJ9UHYVv4eG+e3fN06e5do58XflaZ7pjwIrIPBdfM3LI69r
         ePL/PTk7WUf7v8nUYaLUe9UqYHLjoLetisrk0R9IpKi2Vc4bMPEMmEPGoFedY86mJOIi
         Mmd6qKrktzG3x5pzNrz2vs5fu9TX/nbFfnbYnWXr8mXqlfjmEVO/4wmjY7Kt7v6jgRwo
         0c6Q==
X-Gm-Message-State: AOJu0YzwxyM7fclK8gZmSsnvbjiH5k3gAQ/DxGwJwVYfl30m8VoDPmdp
	9lBFebanDFGbdahjZ5tmq9QnCOsPBSQTOPcMlBsGf9DqR/6Puo4+8nJT6/8i2+sj
X-Gm-Gg: AR+sD13Jb4SR7fv+jiCSTkwYIqDPjx2T3Pihe49Fls0XDAnzJ+D0lTUyk2jS3qgtVyh
	XUF0PuIIbjLOhI93Yjg9coVeZmy5V3UyEzqo2ar9ul26EjB6oUdb6D6lI6NuUdiGv2kkwyXx17a
	Z+7ashMNsuDsyQupVbXwQb3gGoktMMyOglvTudI7l94ahhDi1xxgZHnjOjIGYjtuq3QmdQaI1D1
	d9mPLQfJcIQbuO05VawNor+iqeHHiJtYII/otBv2zn0jMJaRKWKtwRWqB59biMvQJft6ZhHnn1x
	HFzVheiXilaCIuymKc/Gjsp4gl5O1qTA7OcIIwu/x9Fy/PjmQSTwUoqGmYwWukqCO/1HvKgiRP6
	29dQQtGfE9vPDQAcA13kYMwm4Q2D+deFoveDwbBaCZoyhn7uR4w8w9F9IEZxwDKWDGdyCFa1SNV
	eTzWsF8495/kyZrjSOGn5qNzMHAII=
X-Received: by 2002:a05:600c:310d:b0:495:7b1b:f387 with SMTP id 5b1f17b1804b1-4957b1bf404mr51427305e9.24.1784907764448;
        Fri, 24 Jul 2026 08:42:44 -0700 (PDT)
Received: from fedora (cld-mpp10glb2.wlp.is. [185.12.130.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af6ad58sm91326945e9.4.2026.07.24.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:42:44 -0700 (PDT)
From: Alessio Podda <aleph.pi.gh@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shimin Guo <shimin.guo@skydio.com>,
	Alessio Podda <aleph.pi.gh@gmail.com>
Subject: [PATCH v2] perf unwind-libdw: Fix unwinding of multi-threaded processes
Date: Fri, 24 Jul 2026 17:40:57 +0200
Message-ID: <20260724154057.896074-1-aleph.pi.gh@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAP-5=fVpWMOg8PE_b9or5PHwLBY0H1UNOZRxUXR-5=qwEW2M0g@mail.gmail.com>
References: <CAP-5=fVpWMOg8PE_b9or5PHwLBY0H1UNOZRxUXR-5=qwEW2M0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libdw callback API has two levels: dwfl_getthread_frames() first finds
the requested thread using the next_thread() or get_thread() callback and
then walks its stack.

Since perf only has a snapshot of the stack of a single thread, it
provides a stubbed-out API that always returns the pid the Dwfl was
attached with (i.e. whatever was passed to dwfl_attach_state()), rather
than the actual sampled thread's TID.

Commit 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF
after every unwind") changed libdw unwinding from recreating the Dwfl
object for each sample to caching it in struct maps, which is shared by
every thread in the process. It left next_thread() unchanged.

Since the pid passed to dwfl_attach_state() is only set at creation, only
the thread of the first sample is ever found. As a result,
dwfl_getthread_frames() fails with ESRCH when asked to unwind a sample
from another thread.

Make next_thread() return the current sample's TID, provide get_thread()
so libdw can find it directly, and pass the process PID expected by
dwfl_attach_state(). This allows libdw to unwind samples from every thread
in a multi-threaded process.

Add a shell regression test that records a four-thread workload and
verifies that libdw recovers the worker callchain for every worker TID.

Fixes: 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF after every unwind")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Alessio Podda <aleph.pi.gh@gmail.com>
---
Changes in v2:
- Add a shell regression test for multi-threaded libdw unwinding.
- Include <assert.h> directly instead of relying on a transitive include.

 .../shell/test_dwarf_unwind_multithreaded.sh  | 65 +++++++++++++++++++
 tools/perf/util/unwind-libdw.c                | 24 ++++++-
 2 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh

diff --git a/tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh b/tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh
new file mode 100755
index 000000000000..49e6e3af771f
--- /dev/null
+++ b/tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Test libdw unwinding of multi-threaded processes (exclusive)
+
+set -e
+
+if ! perf check feature -q libdw-dwarf-unwind; then
+	echo "Skip: libdw DWARF unwinding is not available"
+	exit 2
+fi
+
+tmpdir=$(mktemp -d /tmp/perf-test-dwarf-unwind-multithreaded.XXXXXX)
+perf_data="$tmpdir/perf.data"
+perf_script="$tmpdir/perf-script.txt"
+nr_threads=4
+nr_worker_threads=$((nr_threads - 1))
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	rm -rf "$tmpdir"
+}
+
+trap cleanup EXIT TERM INT
+
+if ! perf record -q -e task-clock:u -F 99 --call-graph dwarf,8192 \
+	-o "$perf_data" -- perf test -w thloop 2 "$nr_threads"
+then
+	echo "Skip: failed to record task-clock:u"
+	exit 2
+fi
+
+if ! perf script --unwind-style=libdw \
+	-F comm,pid,tid,event,ip,sym -i "$perf_data" > "$perf_script"
+then
+	echo "Error: failed to process the recording with libdw" >&2
+	exit 1
+fi
+
+nr_unwound_threads=$(
+	awk '
+		BEGIN { RS = "" }
+
+		# thfunc is the worker-only caller of test_loop. Finding it proves
+		# that libdw unwound beyond the sampled leaf for this worker TID.
+		/thfunc/ {
+			split($2, id, "/")
+			seen[id[2]] = 1
+		}
+
+		END {
+			for (tid in seen)
+				nr_tids++
+			print nr_tids + 0
+		}
+	' "$perf_script"
+)
+
+if [ "$nr_unwound_threads" -ne "$nr_worker_threads" ]; then
+	echo "Error: expected callchains for $nr_worker_threads worker TIDs," \
+		"found $nr_unwound_threads" >&2
+	exit 1
+fi
+
+exit 0
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 7f35042be567..63a5c2253174 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
 #include <linux/compiler.h>
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
@@ -173,14 +174,30 @@ static int entry(u64 ip, struct unwind_info *ui)
 	return 0;
 }
 
-static pid_t next_thread(Dwfl *dwfl, void *arg, void **thread_argp)
+static pid_t next_thread(Dwfl *dwfl __maybe_unused, void *arg, void **thread_argp)
 {
+	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
+
 	/* We want only single thread to be processed. */
 	if (*thread_argp != NULL)
 		return 0;
 
+	assert(dwfl_ui_ti->ui != NULL);
 	*thread_argp = arg;
-	return dwfl_pid(dwfl);
+	return thread__tid(dwfl_ui_ti->ui->thread);
+}
+
+static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
+		       void **thread_argp)
+{
+	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
+
+	assert(dwfl_ui_ti->ui != NULL);
+	if (tid != thread__tid(dwfl_ui_ti->ui->thread))
+		return false;
+
+	*thread_argp = arg;
+	return true;
 }
 
 static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
@@ -306,6 +323,7 @@ static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 
 static const Dwfl_Thread_Callbacks callbacks = {
 	.next_thread           = next_thread,
+	.get_thread            = get_thread,
 	.memory_read           = memory_read,
 	.set_initial_registers = libdw_set_initial_registers,
 };
@@ -400,7 +418,7 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		goto out;
 
-	dwfl_attach_state(dwfl, /*elf=*/NULL, thread__tid(thread), &callbacks,
+	dwfl_attach_state(dwfl, /*elf=*/NULL, thread__pid(thread), &callbacks,
 			  /* Dwfl thread function argument*/dwfl_ui_ti);
 	// Ignore thread already attached error.
 

base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
-- 
2.55.0
