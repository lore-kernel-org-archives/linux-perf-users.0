From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 4/7] drm/i915/perf: open access for CAP_SYS_PERFMON
 privileged process
Date: Mon, 16 Dec 2019 10:17:07 +0300
Message-ID: <2072a292-24f9-71c1-53bc-c89073427432@linux.intel.com>
References: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, Alexei Starovoitov <ast@kernel.org>, james.bottomley@hansenpartnership.com, benh@kernel.crashing.org, Casey Schaufler <casey@schaufler-ca.com>, serge@hallyn.com, James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, intel-gfx@lists.freedesktop.org, bgregg@netflix.com, Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org


Open access to i915_perf monitoring for CAP_SYS_PERFMON privileged processes.
For backward compatibility reasons access to i915_perf subsystem remains open
for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
i915_perf monitoring is discouraged with respect to CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index e42b86827d6b..8a9ff40b1b0b 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -2748,10 +2748,11 @@ i915_perf_open_ioctl_locked(struct drm_i915_private *dev_priv,
 	/* Similar to perf's kernel.perf_paranoid_cpu sysctl option
 	 * we check a dev.i915.perf_stream_paranoid sysctl option
 	 * to determine if it's ok to access system wide OA counters
-	 * without CAP_SYS_ADMIN privileges.
+	 * without CAP_SYS_PERFMON or CAP_SYS_ADMIN privileges.
 	 */
 	if (privileged_op &&
-	    i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	    i915_perf_stream_paranoid &&
+	    !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN))) {
 		DRM_DEBUG("Insufficient privileges to open system-wide i915 perf stream\n");
 		ret = -EACCES;
 		goto err_ctx;
@@ -2940,8 +2941,8 @@ static int read_properties_unlocked(struct drm_i915_private *dev_priv,
 				oa_freq_hz = 0;
 
 			if (oa_freq_hz > i915_oa_max_sample_rate &&
-			    !capable(CAP_SYS_ADMIN)) {
-				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without root privileges\n",
+			    !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN))) {
+				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without CAP_SYS_PERFMON or CAP_SYS_ADMIN privileges\n",
 					  i915_oa_max_sample_rate);
 				return -EACCES;
 			}
@@ -3328,7 +3329,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	if (i915_perf_stream_paranoid && !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN))) {
 		DRM_DEBUG("Insufficient privileges to add i915 OA config\n");
 		return -EACCES;
 	}
@@ -3474,7 +3475,7 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 	}
 
-	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	if (i915_perf_stream_paranoid && !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN))) {
 		DRM_DEBUG("Insufficient privileges to remove i915 OA config\n");
 		return -EACCES;
 	}
-- 
2.20.1
