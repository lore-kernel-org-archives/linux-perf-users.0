From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v6 03/10] perf/core: open access to probes for CAP_PERFMON
 privileged process
Date: Tue, 28 Jan 2020 09:09:13 +0300
Message-ID: <6cdc10f2-31e5-6d71-7d71-c6b5250b74f1@linux.intel.com>
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>, Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, linux-perf-users@vger.ke
List-Id: linux-perf-users.vger.kernel.org


Open access to monitoring via kprobes and uprobes and eBPF tracing for
CAP_PERFMON privileged process. Providing the access under CAP_PERFMON
capability singly, without the rest of CAP_SYS_ADMIN credentials, excludes
chances to misuse the credentials and makes operation more secure.

perf kprobes and uprobes are used by ftrace and eBPF. perf probe uses
ftrace to define new kprobe events, and those events are treated as
tracepoint events. eBPF defines new probes via perf_event_open interface
and then the probes are used in eBPF tracing.

CAP_PERFMON implements the principal of least privilege for performance
monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39 principle
of least privilege: A security design principle that states that a process or
program be granted only those privileges (e.g., capabilities) necessary to
accomplish its legitimate function, and only for the time that such privileges
are actually required)

For backward compatibility reasons access to perf_events subsystem remains
open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for
secure perf_events monitoring is discouraged with respect to CAP_PERFMON
capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d956c81bd310..c6453320ffea 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9088,7 +9088,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
 	if (event->attr.type != perf_kprobe.type)
 		return -ENOENT;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!perfmon_capable())
 		return -EACCES;
 
 	/*
@@ -9148,7 +9148,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
 	if (event->attr.type != perf_uprobe.type)
 		return -ENOENT;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!perfmon_capable())
 		return -EACCES;
 
 	/*
-- 
2.20.1
