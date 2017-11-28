From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/30] tools headers: Synchronize prctl.h ABI header
Date: Tue, 28 Nov 2017 12:02:18 -0300
Message-ID: <20171128150220.5064-29-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dave Martin <Dave.Martin@arm.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up changes from:

  2d2123bc7c7f ("arm64/sve: Add prctl controls for userspace vector length management")
  7582e22038a2 ("arm64/sve: Backend logic for setting the vector length")

That showed a limitation of the regexp used in tools/perf/trace/beauty/prctl_option.sh,
that matches only PR_{SET,GET}_, but should match a few more, like
PR_MPX_*, PR_CAP_* and the one added by the above commit, PR_SVE_SET_*.

This silences this warning when building tools/perf:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'

Support for those extra prctl options should be left for the next merge
window tho.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-r52dsyuzy04qzqyfcifjs35t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index b640071421f7..af5f8c2df87a 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -198,4 +198,13 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+/* arm64 Scalable Vector Extension controls */
+/* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
+#define PR_SVE_SET_VL			50	/* set task vector length */
+# define PR_SVE_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+#define PR_SVE_GET_VL			51	/* get task vector length */
+/* Bits common to PR_SVE_SET_VL and PR_SVE_GET_VL */
+# define PR_SVE_VL_LEN_MASK		0xffff
+# define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.13.6
