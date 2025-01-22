Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340A1CAA6B;
	Wed, 22 Jan 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513134; cv=none; b=aX06OKEGRyhLi9cFoVRTrezxH7hK8PdEnnNn152OftZ4qCEhVrLI0/EeONC6k8lQ8OBDTnVy248qz9RAbb0fog0Zu9EroWzXeq7CNqoHlq+CNsaooPvWo0z/Ms+Cdo1wML9wurhwV0e4r5NM3bPlszOjZvNq5Zaro0UtntlC/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513134; c=relaxed/simple;
	bh=W29l9qey3ChAqB78fMRVvzdYJy8KJI4PhdoLFfE4Oos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSv22ql4+1xaZhq6joK3JuEs9sNNF/RPE3sx4zs8f8YnNJO2QjOytIkfkNT1ImOPwVSftznTtwA/Zg8hFau74/Thw1AbKC//6FHD+55Bzl3ndO0/kMdxX7O7fbocwd8By5dzpZ7KSTtXlXM081SlCAly2j5zWaSdDOJcevs0iog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0TwhpOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0TwhpOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C23EC4CEE2;
	Wed, 22 Jan 2025 02:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513134;
	bh=W29l9qey3ChAqB78fMRVvzdYJy8KJI4PhdoLFfE4Oos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0TwhpOTDa5ZT+nHd5+YGB9ajqEgjRA+nFIME4pcWlshoVRAPQvBH6LGtKWyAGqSN
	 OpjpMLpjy58vSe+1LbYbflPql0DXz8oUnLaM5D1+zR49Wo2ZaTdGgQtgRO3LXSBObI
	 HQlgpC2HLoKJlZgOKW5/EDlqmkcRPY4R1UP6qgxzaTzM6FbaDZb4BgkGIU2z+RR0e7
	 UmmY03L1+L3y+cfkkE6JuQJ3n5acPzDHez0fq/X6JmCxYP/wXGmdMCQgrk+Ha/ZWfv
	 qGsdqE4BWlTnRE40lLlaF1wquuQvkAvEud72Ucm/MfdECobfcKW/4sVdU/95TwSWby
	 mQbeitzUf7t7g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 21/39] unwind_user/sframe: Add prctl() interface for registering .sframe sections
Date: Tue, 21 Jan 2025 18:31:13 -0800
Message-ID: <a97dacceca896254d40b86657c72b398c157bdc7.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel doesn't have direct visibility to the ELF contents of shared
libraries.  Add some prctl() interfaces which allow glibc to tell the
kernel where to find .sframe sections.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/uapi/linux/prctl.h | 5 ++++-
 kernel/sys.c               | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5c6080680cb2..4a52e3f9ccc9 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -351,6 +351,9 @@ struct prctl_mm_map {
  * configuration.  All bits may be locked via this call, including
  * undefined bits.
  */
-#define PR_LOCK_SHADOW_STACK_STATUS      76
+#define PR_LOCK_SHADOW_STACK_STATUS	76
+
+#define PR_ADD_SFRAME			77
+#define PR_REMOVE_SFRAME		78
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index c4c701c6f0b4..414dfd6ee9fa 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -64,6 +64,7 @@
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
+#include <linux/sframe.h>
 
 #include <linux/nospec.h>
 
@@ -2809,6 +2810,14 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_ADD_SFRAME:
+		error = sframe_add_section(arg2, arg3, arg4, arg5);
+		break;
+	case PR_REMOVE_SFRAME:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = sframe_remove_section(arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.48.1

