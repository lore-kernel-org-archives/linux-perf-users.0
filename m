Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373207;
	b=dpit090ZCv0v9TXixUDriEQB0zY2AMfGwW4o+dgzXjyW8gXDSxlyrXsous3SpPBaHUkS
	 l9UZWZ7DvArKp/yM+VDOOieXztcCYSKSDNZvnx6BNTooU5HPwxkuYL09eKpkzWoIb5yWB
	 ZUEn1pC61ZujoswXoODar2Z62CdkVi8w2Vg0NZvDkQTMyDsIzp3+sIEY7Yh4BhSfxVSVh
	 tn5vrnM5+eKOl8R1KCCq5156UA2bfhczbCwcsvIA3d1Emy1XomCpgHdSyg7LkJe6toUbJ
	 dfekwMJ+/FEahS1LikF4EDTGCZIjgONuH9gLefq/pf+u9mgR1zsMMSkByzdYYWC/Ltg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373207;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5/yB7BzHqHnOD3+10oNlkMxkHGoaXIOK9R0cGN4xeuY=;
	b=1jJvB7j5MuX8rNU3MOwpatmxBa+k9ZpgafpvlMI14oLO9MJsaIDKrIqhyfWQazpTi/oP
	 45vnmYSohFgh7LxcYR9Lqbbfn4E5PpIHNPTfrptfz3Ly1+vHJtaq+pevj+kXHlqBQdlMO
	 sw3F5PcSpH7Gb3f7Xg/uwps9GtrQJYCHZS4pp+aZULIbQsKyNdfl1w7Rn91KWssCeSCZE
	 OMugKV87rzGORGzpx6B39vYOFz926scBagUjxIqFLbaOcZwnHJbHsNOTCy+s4QBsT5tjp
	 3SErYo/75log3SqiDJN5PX9N5CvYw7yradiyP08djCRmub4Eq1Sr/kMpoh98okK9F7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l6w4H0ZZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249EE606A326;
	Fri, 30 Oct 2026 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 249EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l6w4H0ZZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5885B1BD0;
	Fri, 30 Oct 2026 08:13:23 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA3A3F59E;
	Fri, 30 Oct 2026 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373206; bh=VaYJWwoiFdzyR5bJkGPEDkSir0IV3Dz2lsAxBYS+6mQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l6w4H0ZZgjTbH8fd2jtTkO6S+glKGctkbEWyN1jJy91Q4GTJMuN37z0P5wvUxVTxt
	 HqYX3aLiPX+Wpv1k2AxLTrf4ZODEqKJR6LeaPDmUfpdOMxciNPHYW4JNKxqn94SYid
	 Tg9sBIRiPZU8k8oNDDViJlZIsTvZ8U/wMTr9jSoE=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:08 +0000
Subject: [PATCH v3 01/14] perf sample: Allow decoders to supply branch
 return addresses
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
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-1-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=8274;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=VaYJWwoiFdzyR5bJkGPEDkSir0IV3Dz2lsAxBYS+6mQ=;
 b=Og0ksmTz9rv6zXnxRy5If073i0KeK3EG+7AF/LIaVPj55q6Vhj5EAeWXWLD1JsuES1t4X0RRB
 xjGXkhu6iF9AmzUWg03DBWPAwuzmTQnA4HbgE+YtxpIPm/FY5g19tTI
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The thread stack derives return addresses from IP + insn_len. For an
interrupt or fault, the return address can instead be the sample IP even
when instruction bytes at that address are available.

Add ret_addr to perf_sample and prefer it in thread_stack__trace_end()
and thread_stack__process() when supplied. Initialize it to zero so other
samples retain the IP + insn_len calculation.

Add a regression test for explicit exception return addresses and the
ordinary call fallback when the return address is zero.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/tests.h        |   1 +
 tools/perf/tests/thread-stack.c | 106 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sample.c        |   1 +
 tools/perf/util/sample.h        |   5 ++
 tools/perf/util/thread-stack.c  |   5 +-
 7 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 58858f3d2bf954e125182d9f326817c69772f70a..5eebb2ec5ddefcfda0efe5c08e5c4e3ebf75e707 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -30,6 +30,7 @@ perf-test-y += task-exit.o
 perf-test-y += sw-clock.o
 perf-test-y += mmap-thread-lookup.o
 perf-test-y += thread-maps-share.o
+perf-test-y += thread-stack.o
 perf-test-$(CONFIG_LIBTRACEEVENT) += switch-tracking.o
 perf-test-y += keep-tracking.o
 perf-test-y += code-reading.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0b8897fd42cace9381981c1e2cf5402be0026c90..8dd72cd97cdb2de0f80f108cd72b9264c073e2a0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -132,6 +132,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__hists_filter,
 	&suite__mmap_thread_lookup,
 	&suite__thread_maps_share,
+	&suite__thread_stack,
 	&suite__hists_output,
 	&suite__hists_cumulate,
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 20ae3609892b612e92bc0881e301d4f295b764ec..59b66fe34a71420715ca8e04bf5f0f181b2c9cf9 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -156,6 +156,7 @@ DECLARE_SUITE(expr);
 DECLARE_SUITE(hists_filter);
 DECLARE_SUITE(mmap_thread_lookup);
 DECLARE_SUITE(thread_maps_share);
+DECLARE_SUITE(thread_stack);
 DECLARE_SUITE(hists_output);
 DECLARE_SUITE(hists_cumulate);
 DECLARE_SUITE(switch_tracking);
diff --git a/tools/perf/tests/thread-stack.c b/tools/perf/tests/thread-stack.c
new file mode 100644
index 0000000000000000000000000000000000000000..0239e3bee34faf8fd4ddc7b723cf479609760064
--- /dev/null
+++ b/tools/perf/tests/thread-stack.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <unistd.h>
+#include "tests.h"
+#include "util/addr_location.h"
+#include "util/event.h"
+#include "util/sample.h"
+#include "util/thread.h"
+#include "util/thread-stack.h"
+
+#define CALL_REF		1234UL
+#define RET_REF			5678UL
+
+struct return_check {
+	unsigned int matched;
+	unsigned int unmatched;
+};
+
+static int check_call_return(struct call_return *cr,
+			     u64 *parent_db_id __maybe_unused, void *data)
+{
+	struct return_check *check = data;
+
+	if (cr->call_ref == CALL_REF && cr->return_ref == RET_REF && !cr->flags)
+		check->matched++;
+	else
+		check->unmatched++;
+
+	return 0;
+}
+
+/* A zero expected_ret_addr asks the stack to use ip + insn_len. */
+static int check_return_address(u64 expected_ret_addr, u64 actual_ret_addr,
+				u32 flags)
+{
+	struct call_return_processor *crp;
+	struct return_check check = { };
+	struct thread *thread;
+	struct addr_location from = { }, to = { };
+	struct perf_sample sample = { };
+	int ret = TEST_FAIL;
+
+	thread = thread__new(getpid(), getpid());
+	if (!thread)
+		return TEST_FAIL;
+
+	crp = call_return_processor__new(check_call_return, &check);
+	if (!crp)
+		goto out;
+
+	sample.ip = 0x1000;		/* Call or exception source addr */
+	sample.addr = 0x2000;		/* Callee or exception handler addr */
+	sample.ret_addr = expected_ret_addr;
+	sample.flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | flags;
+	sample.time = 1;
+	/* Model the opcode length after an instruction fetch. */
+	sample.insn_len = 4;
+	if (thread_stack__process(thread, thread__comm(thread), &sample,
+				  &from, &to, CALL_REF, crp))
+		goto out;
+
+	sample.ip = 0x2000;		/* Return instruction addr */
+	sample.addr = actual_ret_addr;	/* Return branch target addr */
+	sample.ret_addr = 0;
+	sample.flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN |
+		       (flags & (PERF_IP_FLAG_INTERRUPT | PERF_IP_FLAG_SYSCALLRET));
+	sample.time = 2;
+	if (thread_stack__process(thread, thread__comm(thread), &sample,
+				  &to, &from, RET_REF, crp))
+		goto out;
+
+	if (check.matched == 1 && !check.unmatched)
+		ret = TEST_OK;
+
+out:
+	thread__put(thread);
+	call_return_processor__free(crp);
+	return ret;
+}
+
+static int test__thread_stack(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
+{
+	static const struct {
+		const char *name;
+		u64 expected_ret_addr;
+		u64 actual_ret_addr;
+		u32 flags;
+	} cases[] = {
+		{ "ordinary call", 0, 0x1004, 0 },
+		{ "interrupt", 0x1000, 0x1000, PERF_IP_FLAG_ASYNC | PERF_IP_FLAG_INTERRUPT },
+		{ "fault or trap", 0x1000, 0x1000, PERF_IP_FLAG_INTERRUPT },
+		{ "SVC", 0x1004, 0x1004, PERF_IP_FLAG_SYSCALLRET },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
+		if (check_return_address(cases[i].expected_ret_addr,
+					 cases[i].actual_ret_addr, cases[i].flags)) {
+			pr_debug("Incorrect return address for %s\n", cases[i].name);
+			return TEST_FAIL;
+		}
+	}
+	return TEST_OK;
+}
+
+DEFINE_SUITE("Thread stack return addresses after instruction fetching", thread_stack);
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index bccc19e2aaf25118a8ecde88473aa6cb16fa561a..4abb689132bc27d0f2318eeafca20f7e57621837 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -29,6 +29,7 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 		sample->intr_regs = NULL;
 		sample->merged_callchain = false;
 		sample->callchain = NULL;
+		sample->ret_addr = 0;
 	}
 }
 
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index cb4b16654876e9a5c3bfd66be3e0235ac15795e0..865ed18200f1339f5949ef3f185ed57a34aace72 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -131,6 +131,11 @@ struct perf_sample {
 	u64 time;
 	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
 	u64 addr;
+	/**
+	 * @ret_addr: Return address supplied by the decoder for a branch sample.
+	 *            Zero means use ip + insn_len.
+	 */
+	u64 ret_addr;
 	/** @id: The sample event PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER value. */
 	u64 id;
 	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 1360f44421ef8bb80fe5cfdba59be7e6029b0240..d452d1a7eabb16f040ca3dada23e6fdec8fb1088 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -1030,7 +1030,7 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp, NULL, 0,
 				ts->kernel_start);
 
-	ret_addr = sample->ip + sample->insn_len;
+	ret_addr = sample->ret_addr ? sample->ret_addr : sample->ip + sample->insn_len;
 
 	return thread_stack__push_cp(ts, ret_addr, sample->time, ref, cp,
 				     false, true);
@@ -1154,7 +1154,8 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		if (!sample->ip || !sample->addr)
 			return 0;
 
-		ret_addr = sample->ip + sample->insn_len;
+		/* Opcode fetching must not change a decoder-supplied return address. */
+		ret_addr = sample->ret_addr ? sample->ret_addr : sample->ip + sample->insn_len;
 		if (ret_addr == sample->addr)
 			return 0; /* Zero-length calls are excluded */
 

-- 
2.34.1

