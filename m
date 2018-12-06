From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/75] perf thread: Add fallback functions for cases where cpumode is insufficient
Date: Thu,  6 Dec 2018 18:24:54 -0300
Message-ID: <20181206212602.20474-8-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

For branch stacks or branch samples, the sample cpumode might not be
correct because it applies only to the sample 'ip' and not necessary to
'addr' or branch stack addresses. Add fallback functions that can be
used to deal with those cases

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20181106210712.12098-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c   | 27 +++++++++++++++++++++++++++
 tools/perf/util/machine.c | 27 +++++++++++++++++++++++++++
 tools/perf/util/machine.h |  2 ++
 tools/perf/util/thread.h  |  4 ++++
 4 files changed, 60 insertions(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e9c108a6b1c3..9431b20c1337 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1577,6 +1577,24 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	return al->map;
 }
 
+/*
+ * For branch stacks or branch samples, the sample cpumode might not be correct
+ * because it applies only to the sample 'ip' and not necessary to 'addr' or
+ * branch stack addresses. If possible, use a fallback to deal with those cases.
+ */
+struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+				struct addr_location *al)
+{
+	struct map *map = thread__find_map(thread, cpumode, addr, al);
+	struct machine *machine = thread->mg->machine;
+	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
+
+	if (map || addr_cpumode == cpumode)
+		return map;
+
+	return thread__find_map(thread, addr_cpumode, addr, al);
+}
+
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al)
 {
@@ -1586,6 +1604,15 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 	return al->sym;
 }
 
+struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
+				      u64 addr, struct addr_location *al)
+{
+	al->sym = NULL;
+	if (thread__find_map_fb(thread, cpumode, addr, al))
+		al->sym = map__find_symbol(al->map, al->addr);
+	return al->sym;
+}
+
 /*
  * Callers need to drop the reference to al->thread, obtained in
  * machine__findnew_thread()
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8f36ce813bc5..9397e3f2444d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2592,6 +2592,33 @@ int machine__get_kernel_start(struct machine *machine)
 	return err;
 }
 
+u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr)
+{
+	u8 addr_cpumode = cpumode;
+	bool kernel_ip;
+
+	if (!machine->single_address_space)
+		goto out;
+
+	kernel_ip = machine__kernel_ip(machine, addr);
+	switch (cpumode) {
+	case PERF_RECORD_MISC_KERNEL:
+	case PERF_RECORD_MISC_USER:
+		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_KERNEL :
+					   PERF_RECORD_MISC_USER;
+		break;
+	case PERF_RECORD_MISC_GUEST_KERNEL:
+	case PERF_RECORD_MISC_GUEST_USER:
+		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_GUEST_KERNEL :
+					   PERF_RECORD_MISC_GUEST_USER;
+		break;
+	default:
+		break;
+	}
+out:
+	return addr_cpumode;
+}
+
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
 {
 	return dsos__findnew(&machine->dsos, filename);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index ca897a73014c..ebde3ea70225 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -100,6 +100,8 @@ static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
 	return ip >= kernel_start;
 }
 
+u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr);
+
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 				    pid_t tid);
 struct comm *machine__thread_exec_comm(struct machine *machine,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 30e2b4c165fe..5920c3bb8ffe 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -96,9 +96,13 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al);
+struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+				struct addr_location *al);
 
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al);
+struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
+				      u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
-- 
2.19.2
