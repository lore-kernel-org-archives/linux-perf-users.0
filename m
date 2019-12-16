From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 1/7] capabilities: introduce CAP_SYS_PERFMON
 to kernel and user space
Date: Mon, 16 Dec 2019 10:14:32 +0300
Message-ID: <9066ae10-63d6-67a1-d472-1f22826c9ae8@linux.intel.com>
References: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
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
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, Alexei Starovoitov <ast@kernel.org>, james.bottomley@hansenpartnership.com, benh@kernel.crashing.org, Casey Schaufler <casey@schaufler-ca.com>, serge@hallyn.com, James Morris <jmorris@namei.org>
Cc: Song Liu <songliubraving@fb.com>, Andi Kleen <ak@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-parisc@vger.kernel.org, Jann Horn <jannh@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org, Igor Lubashev <ilubashe@akamai.com>, linux-kernel <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, bgregg@netflix.com, Jiri Olsa <jolsa@redhat.com>, bpf@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


Introduce CAP_SYS_PERFMON capability devoted to secure system performance
monitoring and observability operations so that CAP_SYS_PERFMON would assist 
CAP_SYS_ADMIN capability in its governing role for perf_events, i915_perf
and other performance monitoring and observability subsystems of the kernel.

CAP_SYS_PERFMON intends to harden system security and integrity during
system performance monitoring and observability operations by decreasing
attack surface that is available to CAP_SYS_ADMIN privileged processes.

CAP_SYS_PERFMON intends to take over CAP_SYS_ADMIN credentials related to
system performance monitoring and observability operations and balance amount
of CAP_SYS_ADMIN credentials following with the recommendations provided
in the capabilities man page [1] for CAP_SYS_ADMIN: "Note: this capability
is overloaded; see Notes to kernel developers, below."

[1] http://man7.org/linux/man-pages/man7/capabilities.7.html

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/uapi/linux/capability.h     | 8 +++++++-
 security/selinux/include/classmap.h | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 240fdb9a60f6..7d1f8606c3e6 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -366,8 +366,14 @@ struct vfs_ns_cap_data {
 
 #define CAP_AUDIT_READ		37
 
+/*
+ * Allow system performance and observability privileged operations
+ * using perf_events, i915_perf and other kernel subsystems
+ */
+
+#define CAP_SYS_PERFMON		38
 
-#define CAP_LAST_CAP         CAP_AUDIT_READ
+#define CAP_LAST_CAP         CAP_SYS_PERFMON
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 7db24855e12d..bae602c623b0 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -27,9 +27,9 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read"
+		"wake_alarm", "block_suspend", "audit_read", "sys_perfmon"
 
-#if CAP_LAST_CAP > CAP_AUDIT_READ
+#if CAP_LAST_CAP > CAP_SYS_PERFMON
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.20.1
