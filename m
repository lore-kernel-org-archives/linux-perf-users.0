From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v4 5/9] trace/bpf_trace: open access for
 CAP_SYS_PERFMON privileged process
Date: Wed, 18 Dec 2019 12:28:10 +0300
Message-ID: <1d46cc07-ced7-9a29-a9a3-3cba6ef2df21@linux.intel.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Casey Schaufler <casey@schaufler-ca.com>, Robert Richter <rric@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Igor Lubashev <ilubashe@akamai.com>, oprofile-list@lists.sf.net, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, linuxppc-dev@list
List-Id: linux-perf-users.vger.kernel.org


Open access to bpf_trace monitoring for CAP_SYS_PERFMON privileged
processes. For backward compatibility reasons access to bpf_trace
monitoring remains open for CAP_SYS_ADMIN privileged processes but
CAP_SYS_ADMIN usage for secure bpf_trace monitoring is discouraged
with respect to CAP_SYS_PERFMON capability.

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
