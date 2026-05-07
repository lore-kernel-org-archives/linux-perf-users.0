Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F93624B0;
	Thu,  7 May 2026 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138803; cv=none; b=YT7nxucoi5wRGM0lWRNyPYu1IwSeaC2a2REnG4pqKmGQiGHzqPfupubeDSViZUXNEhwga25jm7JefTZhMafPcmHELMkoLJNBP7bqkv4r4mV1gFeBLLxIhlZXbcCAurPxRtVjda1Hl+YQ4UWFHX8kRcmHWPe6KPbFM5LHpbo08lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138803; c=relaxed/simple;
	bh=zI23P/kuY9HOOi1kToW10c9emHjsmuDSaBdH3GUhPcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKxUN47q3leQNOL28xY6dtnkd4hunDMQM//d/apaBsMdMR4hzI586X4S9G0jlMjtAH9d3R9kqmxkPSVdtXf+YkECabXxI3NNLIXfKWNv0/NUs42qhPTEruxG1lQhY9KRxAchTW8eDJu8q+jjGAPHAkTWIveK3qPlJg1FA7bkEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSAlyEJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSAlyEJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF3EC2BCF4;
	Thu,  7 May 2026 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778138803;
	bh=zI23P/kuY9HOOi1kToW10c9emHjsmuDSaBdH3GUhPcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSAlyEJw3wdV/8rPeTjS9H2PtVVklhdj/wAelyT8SWzxDCMhSUn7PAVgmHmqLPhPy
	 JmvAFizjF0LDLJcZ7kySs+0CFQqE8Mm2/XTiKRS72Wr6x7wJX22yd3qiEosGzOBNPz
	 fW2VTHq/FLpJ3UjIAP+Nw4QdAgPcDtAGUmAk5HIkTqWh/b3IqMqcirqBc1DGTk3VDh
	 ThqBzl2vnV3aMZYvD7iUJ3VuRAYVEYIXJBRn99Ruh7Su5MD36y2jx86f9PK8pT5IKI
	 2ESCL5j7ZtALws8AKbXzWDcnjlc6uYmbAmmeCqoOFU+aJhCaucJ1JCRm8xHw8c7EI9
	 yvesIa/ipXTLA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v2 6/7] perf trace: Add beautifier script for fsmount flags
Date: Thu,  7 May 2026 00:26:31 -0700
Message-ID: <20260507072632.37152-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507072632.37152-1-namhyung@kernel.org>
References: <20260507072632.37152-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And rename the existing one to fsmount_attr.{sh,c} to be more precise.
Now the fsmount_flags[] is generated from the mount.h like below.  The
ilog2() + 1 is an existing pattern to handle bit flags.

  $ cat tools/perf/trace/beauty/generated/fsmount_arrays.c
  static const char *fsmount_flags[] = {
  	[ilog2(0x00000001) + 1] = "CLOEXEC",
  	[ilog2(0x00000002) + 1] = "NAMESPACE",
  };

It was found by Sashiko during the review.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf                |  7 +++++++
 tools/perf/builtin-trace.c              |  7 +------
 tools/perf/trace/beauty/beauty.h        |  3 +++
 tools/perf/trace/beauty/fsmount.c       | 18 +++++++++++++++++-
 tools/perf/trace/beauty/fsmount.sh      | 11 +++--------
 tools/perf/trace/beauty/fsmount_attr.sh | 22 ++++++++++++++++++++++
 6 files changed, 53 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/trace/beauty/fsmount_attr.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 585637fc934fe6ec..f733103b5003bf79 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -564,6 +564,12 @@ fsmount_tbls := $(srctree)/tools/perf/trace/beauty/fsmount.sh
 $(fsmount_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_tbls)
 	$(Q)$(SHELL) '$(fsmount_tbls)' $(beauty_uapi_linux_dir) > $@
 
+fsmount_attr_arrays := $(beauty_outdir)/fsmount_attr_arrays.c
+fsmount_attr_tbls := $(srctree)/tools/perf/trace/beauty/fsmount_attr.sh
+
+$(fsmount_attr_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_attr_tbls)
+	$(Q)$(SHELL) '$(fsmount_attr_tbls)' $(beauty_uapi_linux_dir) > $@
+
 fspick_arrays := $(beauty_outdir)/fspick_arrays.c
 fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
 
@@ -854,6 +860,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
 	$(fadvise_advice_array) \
 	$(fsconfig_arrays) \
 	$(fsmount_arrays) \
+	$(fsmount_attr_arrays) \
 	$(fspick_arrays) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a294db..4096b855e7946d96 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -771,11 +771,6 @@ static const char *bpf_cmd[] = {
 };
 static DEFINE_STRARRAY(bpf_cmd, "BPF_");
 
-static const char *fsmount_flags[] = {
-	[1] = "CLOEXEC",
-};
-static DEFINE_STRARRAY(fsmount_flags, "FSMOUNT_");
-
 #include "trace/beauty/generated/fsconfig_arrays.c"
 
 static DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
@@ -1202,7 +1197,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name     = "fsconfig",
 	  .arg = { [1] = STRARRAY(cmd, fsconfig_cmds), }, },
 	{ .name     = "fsmount",
-	  .arg = { [1] = STRARRAY_FLAGS(flags, fsmount_flags),
+	  .arg = { [1] = { .scnprintf = SCA_FSMOUNT_FLAGS, /* fsmount_flags */ },
 		   [2] = { .scnprintf = SCA_FSMOUNT_ATTR_FLAGS, /* attr_flags */ }, }, },
 	{ .name     = "fspick",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dfd */ },
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 0a07ad158f87c73c..a90c35fa5c123f2b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -179,6 +179,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_flock(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FLOCK syscall_arg__scnprintf_flock
 
+size_t syscall_arg__scnprintf_fsmount_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FSMOUNT_FLAGS syscall_arg__scnprintf_fsmount_flags
+
 size_t syscall_arg__scnprintf_fsmount_attr_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FSMOUNT_ATTR_FLAGS syscall_arg__scnprintf_fsmount_attr_flags
 
diff --git a/tools/perf/trace/beauty/fsmount.c b/tools/perf/trace/beauty/fsmount.c
index 28c2c16fc1a80dfd..0f13ef6599b9d0ee 100644
--- a/tools/perf/trace/beauty/fsmount.c
+++ b/tools/perf/trace/beauty/fsmount.c
@@ -18,7 +18,7 @@
 
 static size_t fsmount__scnprintf_attr_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
-#include "trace/beauty/generated/fsmount_arrays.c"
+#include "trace/beauty/generated/fsmount_attr_arrays.c"
        static DEFINE_STRARRAY(fsmount_attr_flags, "MOUNT_ATTR_");
        size_t printed = 0;
 
@@ -39,3 +39,19 @@ size_t syscall_arg__scnprintf_fsmount_attr_flags(char *bf, size_t size, struct s
 
 	return fsmount__scnprintf_attr_flags(flags, bf, size, arg->show_string_prefix);
 }
+
+
+static size_t fsmount__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+#include "trace/beauty/generated/fsmount_arrays.c"
+	static DEFINE_STRARRAY(fsmount_flags, "FSMOUNT_");
+
+	return strarray__scnprintf_flags(&strarray__fsmount_flags, bf, size, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_fsmount_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return fsmount__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
+}
diff --git a/tools/perf/trace/beauty/fsmount.sh b/tools/perf/trace/beauty/fsmount.sh
index 6b67a54cdeee64b3..6d1e80bc15e4416b 100755
--- a/tools/perf/trace/beauty/fsmount.sh
+++ b/tools/perf/trace/beauty/fsmount.sh
@@ -9,14 +9,9 @@ fi
 
 linux_mount=${beauty_uapi_linux_dir}/mount.h
 
-# Remove MOUNT_ATTR_RELATIME as it is zeros, handle it a special way in the beautifier
-# Only handle MOUNT_ATTR_ followed by a capital letter/num as __ is special case
-# for things like MOUNT_ATTR__ATIME that is a mask for the possible ATIME handling
-# bits. Special case it as well in the beautifier
-
-printf "static const char *fsmount_attr_flags[] = {\n"
-regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOUNT_ATTR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-grep -E $regex ${linux_mount} | grep -v MOUNT_ATTR_RELATIME | \
+printf "static const char *fsmount_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+FSMOUNT_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+grep -E $regex ${linux_mount} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/fsmount_attr.sh b/tools/perf/trace/beauty/fsmount_attr.sh
new file mode 100644
index 0000000000000000..6b67a54cdeee64b3
--- /dev/null
+++ b/tools/perf/trace/beauty/fsmount_attr.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	beauty_uapi_linux_dir=tools/perf/trace/beauty/include/uapi/linux/
+else
+	beauty_uapi_linux_dir=$1
+fi
+
+linux_mount=${beauty_uapi_linux_dir}/mount.h
+
+# Remove MOUNT_ATTR_RELATIME as it is zeros, handle it a special way in the beautifier
+# Only handle MOUNT_ATTR_ followed by a capital letter/num as __ is special case
+# for things like MOUNT_ATTR__ATIME that is a mask for the possible ATIME handling
+# bits. Special case it as well in the beautifier
+
+printf "static const char *fsmount_attr_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOUNT_ATTR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+grep -E $regex ${linux_mount} | grep -v MOUNT_ATTR_RELATIME | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.53.0

