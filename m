Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4674F7CB0;
	Mon, 28 Sep 2026 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633219; cv=none; b=GB2wCuh8jAkFozCjIRoSRY583eloh4xNqH9sUAQO47EwYx8GMXhA95AOIy/Jf+rRMvz+HzaqrJDqWUO7CnGlhXg1SgDwS4y/kvgq6lYxq8zxlaDKV/Pbk+pC2vE2rNMqPNrxZAWGTeAWgMnxkLQ6TtW7IzpfXzHtFxObua2Ui0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633219; c=relaxed/simple;
	bh=zOGLU3H0NGHkfdaXervuB3EenEC66RQFAoVPr1ydiiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkxOS/0b+MUJBq3rwseOUzV9H0LVvFBcxZ2g05AfpQkXs3ngER+DpMrI59/Ecm4khz4LjP+mK0xr1HwtS8Wvam1z6iE6TwbRD1JzIenWQH4eAucwfq4Kt4cDyKW7wJlRgkBQRGZRARMa+yZLCGJldCdRly/SZnag0JmMfpgACrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUfwyNbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUfwyNbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E901F000FF;
	Mon, 28 Sep 2026 22:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633217;
	bh=Yo4OmuVy0iOUrX0dIs9Yx9vGKkVpATes0ESTIMMsU30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUfwyNbJ4eHby6KjGFiAQRtgkPYWVCqw9YOHDP1eaYC09UBYRv5XII4MHHLcJprKh
	 rl8Bn9uGGQlHaaeiHsS1lCHnDL1mxa+fluXOitkfXWvkPfXbOfZZymav3Nnk+HF5Tq
	 z8VV5HDyOMPcs/bi8mN98NcyR5M7eCbwHp4Nr//vXzX5AuJmhgI8CDjgMIc99OQDmK
	 RoOorCWHf4z3KM9mZHlAr8AXqt27xKW/mRyFgI2WTwToQQCkx3tf7jRf+uBY242Dq6
	 Jq46z83HeLYlkL8WHBn1cfU+n8la7rrIOW84NQkTYMs8i6t/xelVrcJs6IdG4RZJZ9
	 SmRftGqtS2AGA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/4] perf test: Add false_sharing workload exhibiting cross-CPU false sharing
Date: Tue, 29 Sep 2026 00:06:34 +0200
Message-ID: <20260928220634.2451784-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928220634.2451784-1-acme@kernel.org>
References: <20260928220634.2451784-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a 'perf test -w false_sharing' workload that hammers one shared
struct from several CPUs, shaped as a TCP connection: a read-mostly
identity (five-tuple) shares a cacheline with per-packet rx counters
(the false-sharing line), a second line has packet-path private tx and
congestion control counters, and a third the connection config.

The packet path runs in the main thread and up to four lookup threads
hash the five-tuple and pull the config, reading one volatile shared
instance directly so the accesses are PC-relative and resolvable by the
data type profiler.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/shell/data_type_profiling.sh |   9 +-
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/workloads/Build              |   2 +
 tools/perf/tests/workloads/false_sharing.c    | 240 ++++++++++++++++++
 5 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/tests/workloads/false_sharing.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2f594921e25bda9..98134b1c74cf80f4 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -175,6 +175,7 @@ static struct test_workload *workloads[] = {
 	&workload__context_switch_loop,
 	&workload__deterministic,
 	&workload__callchain,
+	&workload__false_sharing,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index a916c410274aa888..57203e0e5f857540 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -8,8 +8,8 @@ set -e
 # data type profiling manifestation
 
 # Values in testtypes and testprogs should match
-testtypes=("# data-type: struct Buf" "# data-type: struct buf")
-testprogs=("perf test -w code_with_type" "perf test -w datasym")
+testtypes=("# data-type: struct Buf" "# data-type: struct buf" "# data-type: struct net_conn")
+testprogs=("perf test -w code_with_type" "perf test -w datasym" "perf test -w false_sharing")
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
@@ -59,6 +59,9 @@ test_basic_annotate() {
 
     "xC")
     index=1 ;;
+
+    "xFS")
+    index=2 ;;
   esac
 
   # Under 'set -e' a bare failing command aborts the script through the EXIT
@@ -114,6 +117,8 @@ test_basic_annotate Basic Rust
 test_basic_annotate Pipe Rust
 test_basic_annotate Basic C
 test_basic_annotate Pipe C
+test_basic_annotate Basic FS
+test_basic_annotate Pipe FS
 
 cleanup
 exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9c96f33483d14356..f379620069d34f3a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -250,6 +250,7 @@ DECLARE_WORKLOAD(jitdump);
 DECLARE_WORKLOAD(context_switch_loop);
 DECLARE_WORKLOAD(deterministic);
 DECLARE_WORKLOAD(callchain);
+DECLARE_WORKLOAD(false_sharing);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 048e371eb63e3164..18fceddccb56c013 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -14,6 +14,7 @@ perf-test-y += jitdump.o
 perf-test-y += context_switch_loop.o
 perf-test-y += deterministic.o
 perf-test-y += callchain.o
+perf-test-y += false_sharing.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -29,3 +30,4 @@ CFLAGS_inlineloop.o       = -g -O2
 CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/false_sharing.c b/tools/perf/tests/workloads/false_sharing.c
new file mode 100644
index 0000000000000000..12e10d10b87e0d77
--- /dev/null
+++ b/tools/perf/tests/workloads/false_sharing.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * False-sharing demo for data type profiling, shaped as a TCP
+ * connection: a read-mostly identity shares a cacheline with per-packet
+ * rx counters (the false-sharing line), a second line has packet-path
+ * private tx and congestion control counters, and a third the connection
+ * config.
+ *
+ * With a 'perf mem record' of this workload the profiler shows accesses
+ * to different members of the same cacheline, which the CTF stream lets
+ * pahole flag as false sharing on line 0.
+ */
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+struct net_conn {
+	/* cacheline 0: identity (read-mostly) + rx counters (per packet) */
+	uint32_t	saddr;		/*   0 */
+	uint32_t	daddr;		/*   4 */
+	uint16_t	sport;		/*   8 */
+	uint16_t	dport;		/*  10 */
+	uint8_t		state;		/*  12: 1 == ESTABLISHED */
+	uint8_t		protocol;	/*  13: 6 == TCP */
+	uint16_t	__pad0;		/*  14 */
+	uint64_t	bytes_rx;	/*  16: every packet */
+	uint64_t	packets_rx;	/*  24: every packet */
+	uint32_t	rx_queue;	/*  32: backlog depth, fluctuates */
+	uint8_t		__pad1[24];	/*  36..59 */
+	uint32_t	last_ack;	/*  60: written per ACK */
+	/* cacheline 1: tx + congestion control (packet-path private) */
+	uint64_t	bytes_tx;	/*  64: every packet */
+	uint64_t	packets_tx;	/*  72: every packet */
+	uint32_t	cwnd;		/*  80: on every ACK */
+	uint32_t	ssthresh;	/*  84: on loss */
+	uint32_t	rtt_us;		/*  88: on every ACK */
+	uint32_t	retrans;	/*  92: on timeout */
+	uint32_t	__pad2[8];	/*  96..127 */
+	/* cacheline 2: config, set at setup, read by everybody */
+	uint16_t	mss;		/* 128 */
+	uint8_t		snd_wscale;	/* 130 */
+	uint8_t		rcv_wscale;	/* 131 */
+	uint32_t	keepalive_int;	/* 132 */
+	uint32_t	mark;		/* 136: firewall mark */
+	uint32_t	priority;	/* 140: traffic class */
+	uint32_t	__pad3[12];	/* 144..191 */
+} __attribute__((aligned(64)));
+
+/* Volatile so every iteration really loads and stores. */
+static volatile struct net_conn conn;
+/* Keeps the reader checksums alive after the threads join. */
+static volatile unsigned long fs_sink;
+
+static volatile sig_atomic_t done;
+
+struct fs_reader {
+	pthread_t	thread;
+	int		cpu;
+	unsigned long	sum;
+	char		__pad[64 - sizeof(pthread_t) - sizeof(int) - sizeof(unsigned long)];
+} __attribute__((aligned(64)));
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static void pin_to_cpu(int cpu)
+{
+	cpu_set_t set;
+
+	/* There may be no second CPU in a restricted cpuset. */
+	if (cpu < 0)
+		return;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	/* Best effort: in a restricted cpuset this fails and the thread runs unpinned. */
+	pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
+}
+
+/*
+ * Connection lookup, as a load balancer or 'ss' scrape would do it: the
+ * reads go straight to the global, this file is built -O0 and a local
+ * pointer would be reloaded from a stack slot, a form the data type
+ * resolver does not track.
+ */
+static void *reader_fn(void *arg)
+{
+	struct fs_reader *r = arg;
+	unsigned long sum = 0;
+
+	pthread_setname_np(pthread_self(), "fs-reader");
+	pin_to_cpu(r->cpu);
+
+	while (!done) {
+		sum += conn.saddr + conn.daddr + conn.sport + conn.dport +
+		       conn.state + conn.protocol;
+		sum += conn.mss + conn.snd_wscale + conn.rcv_wscale +
+		       conn.keepalive_int + conn.mark + conn.priority;
+	}
+	r->sum = sum;
+	return NULL;
+}
+
+static int false_sharing(int argc, const char **argv)
+{
+	double sec = 2.0;
+	int nreaders = 0, nr_allowed = 0, err = 1;
+	int *allowed = NULL, nallowed = 0, ncpus;
+	cpu_set_t set;
+	struct fs_reader *readers = NULL;
+	int i, writer_cpu;
+	unsigned long n = 0;
+
+	pthread_setname_np(pthread_self(), "fs-writer");
+	if (argc > 0)
+		sec = atof(argv[0]);
+	if (!(sec > 0.0)) {
+		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);
+		return 1;
+	}
+	if (argc > 1)
+		nreaders = atoi(argv[1]);
+
+	/*
+	 * A connection that just got established: identity and config fixed
+	 * from here on, counters at zero.
+	 */
+	conn.saddr = 0x0a000001;	/* 10.0.0.1 */
+	conn.daddr = 0x0a000002;	/* 10.0.0.2 */
+	conn.sport = 54321;
+	conn.dport = 443;
+	conn.state = 1;			/* ESTABLISHED */
+	conn.protocol = 6;		/* TCP */
+	conn.mss = 1448;
+	conn.snd_wscale = 7;
+	conn.rcv_wscale = 7;
+	conn.keepalive_int = 7200;
+	conn.cwnd = 10;
+	conn.ssthresh = 65535;
+	conn.rtt_us = 50;
+
+	/* Pin against the allowed set, restricted cpusets still spread the threads. */
+	ncpus = sysconf(_SC_NPROCESSORS_CONF);
+	if (sched_getaffinity(0, sizeof(set), &set) == 0) {
+		for (i = 0; i < ncpus && i < CPU_SETSIZE; i++) {
+			if (!CPU_ISSET(i, &set))
+				continue;
+			nr_allowed++;
+		}
+		allowed = malloc(nr_allowed * sizeof(int));
+		if (allowed == NULL) {
+			fprintf(stderr, "Error: malloc failed for CPU list\n");
+			return 1;
+		}
+		for (i = 0; i < ncpus && i < CPU_SETSIZE; i++) {
+			if (CPU_ISSET(i, &set))
+				allowed[nallowed++] = i;
+		}
+	}
+	if (nreaders <= 0) {
+		/* By default leave one CPU for the packet path, up to 4 readers. */
+		nreaders = nallowed > 1 ? nallowed - 1 : 1;
+		if (nreaders > 4)
+			nreaders = 4;
+	}
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+
+	readers = calloc(nreaders, sizeof(*readers));
+	if (readers == NULL) {
+		fprintf(stderr, "Error: calloc failed for %d readers\n", nreaders);
+		goto out;
+	}
+	for (i = 0; i < nreaders; i++) {
+		int cpu = nallowed > 1 ? allowed[(i + 1) % nallowed] : -1;
+
+		readers[i].cpu = cpu;
+		if (pthread_create(&readers[i].thread, NULL, reader_fn, &readers[i])) {
+			fprintf(stderr, "Error: failed to create reader %d\n", i);
+			done = 1; // Ensure started threads terminate.
+			nreaders = i;
+			goto out_join;
+		}
+	}
+	writer_cpu = nallowed > 0 ? allowed[0] : -1;
+	if (nallowed == 1)
+		fprintf(stderr, "Warning: single CPU allowed, no cross-CPU traffic expected\n");
+	if (writer_cpu >= 0)
+		pin_to_cpu(writer_cpu);
+
+	/*
+	 * The packet path: receive, acknowledge, transmit, repeat; every 64th
+	 * packet simulates a loss so ssthresh/retrans get sampled too.
+	 */
+	if (sec < 1.0) {
+		useconds_t usecs = (useconds_t)(sec * 1000000.0);
+
+		ualarm(usecs > 0 ? usecs : 1, 0);
+	} else
+		alarm((unsigned int)sec);
+	while (!done) {
+		conn.bytes_rx += conn.mss;
+		conn.packets_rx++;
+		conn.rx_queue = (uint32_t)(n & 0x3f);
+		conn.last_ack = (uint32_t)n;
+		conn.bytes_tx += conn.mss;
+		conn.packets_tx++;
+		conn.cwnd = 10 + (n & 15);
+		conn.rtt_us = 50 + (n & 7);
+		if ((n & 63) == 0) {
+			conn.ssthresh = conn.cwnd / 2;
+			conn.retrans++;
+		}
+		n++;
+	}
+	err = 0;
+out_join:
+	for (i = 0; i < nreaders; i++) {
+		if (readers[i].thread) {
+			pthread_join(readers[i].thread, /*retval=*/NULL);
+			fs_sink += readers[i].sum;
+		}
+	}
+	fs_sink += (unsigned long)(conn.bytes_rx + conn.bytes_tx + n);
+	free(readers);
+out:
+	free(allowed);
+	return err;
+}
+
+DEFINE_WORKLOAD(false_sharing);
-- 
2.55.0

