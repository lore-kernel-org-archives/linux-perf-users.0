From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v6 01/10] capabilities: introduce CAP_PERFMON to kernel and
 user space
Date: Tue, 28 Jan 2020 09:07:26 +0300
Message-ID: <62274abc-6067-9121-9397-c9b626ca5f7a@linux.intel.com>
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
Content-Language: en-US
Sender: linux-parisc-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>, Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, linux-perf-users@vger.ke
List-Id: linux-perf-users.vger.kernel.org


Introduce CAP_PERFMON capability designed to secure system performance
monitoring and observability operations so that CAP_PERFMON would assist
CAP_SYS_ADMIN capability in its governing role for performance monitoring
and observability subsystems.

CAP_PERFMON hardens system security and integrity during system performance
monitoring and observability operations by decreasing attack surface that
is available to a CAP_SYS_ADMIN privileged process [2]. Providing the access
to system performance monitoring and observability operations under CAP_PERFMON
capability singly, without the rest of CAP_SYS_ADMIN credentials, excludes
chances to misuse the credentials and makes the operation more secure.
Thus, CAP_PERFMON implements the principal of least privilege for performance
monitoring and observability operations (POSIX IEEE 1003.1e: 2.2.2.39 principle
of least privilege: A security design principle that states that a process
or program be granted only those privileges (e.g., capabilities) necessary
to accomplish its legitimate function, and only for the time that such
privileges are actually required)

CAP_PERFMON meets the demand to secure system performance monitoring and
observability operations for adoption in security sensitive, restricted,
multiuser production environments (e.g. HPC clusters, cloud and virtual compute
environments), where root or CAP_SYS_ADMIN credentials are not available to
mass users of a system, and securely unblocks applicability and scalability
of system performance monitoring and observability operations beyond root
and CAP_SYS_ADMIN process use cases.

CAP_PERFMON takes over CAP_SYS_ADMIN credentials related to system performance
monitoring and observability operations and balances amount of CAP_SYS_ADMIN
credentials following the recommendations in the capabilities man page [1]
for CAP_SYS_ADMIN: "Note: this capability is overloaded; see Notes to kernel
developers, below." For backward compatibility reasons access to system
performance monitoring and observability subsystems of the kernel remains
open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN capability
usage for secure system performance monitoring and observability operations
is discouraged with respect to the designed CAP_PERFMON capability.

Although the software running under CAP_PERFMON can not ensure avoidance
of related hardware issues, the software can still mitigate these issues
following the official embargoed hardware issues mitigation procedure [2].
The bugs in the software itself can be fixed following the standard kernel
development process [3] to maintain and harden security of system performance
monitoring and observability operations.

[1] http://man7.org/linux/man-pages/man7/capabilities.7.html
[2] https://www.kernel.org/doc/html/latest/process/embargoed-hardware-issues.html
[3] https://www.kernel.org/doc/html/latest/admin-guide/security-bugs.html

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/linux/capability.h          | 4 ++++
 include/uapi/linux/capability.h     | 8 +++++++-
 security/selinux/include/classmap.h | 4 ++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index ecce0f43c73a..027d7e4a853b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -251,6 +251,10 @@ extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct
 extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
 extern bool file_ns_capable(const struct file *file, struct user_namespace *ns, int cap);
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
+static inline bool perfmon_capable(void)
+{
+	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
+}
 
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 240fdb9a60f6..8b416e5f3afa 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -366,8 +366,14 @@ struct vfs_ns_cap_data {
 
 #define CAP_AUDIT_READ		37
 
+/*
+ * Allow system performance and observability privileged operations
+ * using perf_events, i915_perf and other kernel subsystems
+ */
+
+#define CAP_PERFMON		38
 
-#define CAP_LAST_CAP         CAP_AUDIT_READ
+#define CAP_LAST_CAP         CAP_PERFMON
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 7db24855e12d..c599b0c2b0e7 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -27,9 +27,9 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read"
+		"wake_alarm", "block_suspend", "audit_read", "perfmon"
 
-#if CAP_LAST_CAP > CAP_AUDIT_READ
+#if CAP_LAST_CAP > CAP_PERFMON
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.20.1
