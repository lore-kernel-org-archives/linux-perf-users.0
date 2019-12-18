From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v4 4/9] drm/i915/perf: open access for CAP_SYS_PERFMON
 privileged process
Date: Wed, 18 Dec 2019 12:27:18 +0300
Message-ID: <ea050255-a125-8831-ce91-ee23bd6ad08b@linux.intel.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Casey Schaufler <casey@schaufler-ca.com>, Robert Richter <rric@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, Song Liu <songliubraving@fb.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org


Open access to i915_perf monitoring for CAP_SYS_PERFMON privileged
processes. For backward compatibility reasons access to i915_perf
subsystem remains open for CAP_SYS_ADMIN privileged processes but
CAP_SYS_ADMIN usage for secure i915_perf monitoring is discouraged
with respect to CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index e42b86827d6b..e2697f8d04de 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -2748,10 +2748,10 @@ i915_perf_open_ioctl_locked(struct drm_i915_private *dev_priv,
 	/* Similar to perf's kernel.perf_paranoid_cpu sysctl option
 	 * we check a dev.i915.perf_stream_paranoid sysctl option
 	 * to determine if it's ok to access system wide OA counters
-	 * without CAP_SYS_ADMIN privileges.
+	 * without CAP_SYS_PERFMON or CAP_SYS_ADMIN privileges.
 	 */
 	if (privileged_op &&
-	    i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	    i915_perf_stream_paranoid && !perfmon_capable()) {
 		DRM_DEBUG("Insufficient privileges to open system-wide i915 perf stream\n");
 		ret = -EACCES;
 		goto err_ctx;
@@ -2939,9 +2939,8 @@ static int read_properties_unlocked(struct drm_i915_private *dev_priv,
 			} else
 				oa_freq_hz = 0;
 
-			if (oa_freq_hz > i915_oa_max_sample_rate &&
-			    !capable(CAP_SYS_ADMIN)) {
-				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without root privileges\n",
+			if (oa_freq_hz > i915_oa_max_sample_rate && !perfmon_capable()) {
+				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without CAP_SYS_PERFMON or CAP_SYS_ADMIN privileges\n",
 					  i915_oa_max_sample_rate);
 				return -EACCES;
 			}
@@ -3328,7 +3327,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	if (i915_perf_stream_paranoid && !perfmon_capable()) {
 		DRM_DEBUG("Insufficient privileges to add i915 OA config\n");
 		return -EACCES;
 	}
@@ -3474,7 +3473,7 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 	}
 
-	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	if (i915_perf_stream_paranoid && !perfmon_capable()) {
 		DRM_DEBUG("Insufficient privileges to remove i915 OA config\n");
 		return -EACCES;
 	}
-- 
2.20.1
