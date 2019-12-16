From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3 5/7] trace/bpf_trace: open access for CAP_SYS_PERFMON
 privileged process
Date: Mon, 16 Dec 2019 23:03:45 +0300
Message-ID: <d94e5d0b-aa34-ad21-349f-fa3fd6862345@linux.intel.com>
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


Open access to bpf_trace monitoring for CAP_SYS_PERFMON privileged processes.
For backward compatibility reasons access to bpf_trace monitoring remains open
for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
bpf_trace monitoring is discouraged with respect to CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 44bd08f2443b..bafe21ac6d92 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1272,7 +1272,7 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 	u32 *ids, prog_cnt, ids_len;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!perfmon_capable())
 		return -EPERM;
 	if (event->attr.type != PERF_TYPE_TRACEPOINT)
 		return -EINVAL;
-- 
2.20.1
