From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3 2/7] perf/core: open access for CAP_SYS_PERFMON privileged
 process
Date: Mon, 16 Dec 2019 22:59:11 +0300
Message-ID: <3605ca5e-864f-84b2-b3ae-3a7d6c8d4fa9@linux.intel.com>
References: <b175f283-d256-e37e-f447-6ba4ab4f3d3a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b175f283-d256-e37e-f447-6ba4ab4f3d3a@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, linux-kernel@vger.kernel.org, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, intel-gfx@lists.freedesktop.org, Brendan Gregg <bgregg@netflix.com>, songliubraving@fb.com, "bpf@vger.kernel.org" <bpf@vger.kernel.org>li
List-Id: linux-perf-users.vger.kernel.org


Open access to perf_events monitoring for CAP_SYS_PERFMON privileged processes.
For backward compatibility reasons access to perf_events subsystem remains open
for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
perf_events monitoring is discouraged with respect to CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/linux/perf_event.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 34c7c6910026..f46acd69425f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1285,7 +1285,7 @@ static inline int perf_is_paranoid(void)
 
 static inline int perf_allow_kernel(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
 		return -EACCES;
 
 	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
@@ -1293,7 +1293,7 @@ static inline int perf_allow_kernel(struct perf_event_attr *attr)
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
+	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
 		return -EACCES;
 
 	return security_perf_event_open(attr, PERF_SECURITY_CPU);
@@ -1301,7 +1301,7 @@ static inline int perf_allow_cpu(struct perf_event_attr *attr)
 
 static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
+	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
 		return -EPERM;
 
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
-- 
2.20.1
