Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4E3C3BEC
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019235; cv=none; b=tZKv4JyslvBRBAfc8siKqrDJQRqHj98lkWgEgZXfEtM3Jy8Nhj5akBMsol5gc3D2DHFOJDc8KPkuLVOGWtvSwhc0AAtZb/Ad85llA9rZndSrpZHE3BAvf4CjqEB5QYMepD3EGG48inIme6gum8V/Oz2qksnZdnTLo1/0csCUpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019235; c=relaxed/simple;
	bh=zlK8bp5lhaItN6noJ5qmz1QnOKbm4xIKwbQYlmssYVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLNdX8V1cSILLD9X59Mhw4gwysqZuQC7Q3FRPhaXKEageBuqgUCoSx84qTAWqVaFy0gQ9Ci0QR8wuVHLkP9O2qOGAc3OqBfef3mWlQY3lHa+ZRNzPD8Iy54vZdTEsfIyuvSVjDtIWPwwKNmkGFTmJYDyF0hKfJ6go3mCfiolit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEeKrVFM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEeKrVFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774019232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymU5aAieowyXyTG234GxvAgmw2idXfV9LJVKTMon4JE=;
	b=XEeKrVFMXcvZ7slVvj9Ia6XuYYxcnKuSfzpFWNZSowkCl2XvWRPEuUFl9ViV717IvGmcYl
	f9uP9KttB+ggKwE1VSgYM/p2cMGMKape/FUXrH1ycIlfzauvmC+DbdTU54W6pV33KKNxjr
	WsoMeRj0/3CuBdJXdw57m2/5DIIQa/M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-MxAGsUiGNAaTGRhxc7DCog-1; Fri,
 20 Mar 2026 11:07:09 -0400
X-MC-Unique: MxAGsUiGNAaTGRhxc7DCog-1
X-Mimecast-MFC-AGG-ID: MxAGsUiGNAaTGRhxc7DCog_1774019227
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6175195608B;
	Fri, 20 Mar 2026 15:07:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2218D30002DF;
	Fri, 20 Mar 2026 15:07:03 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH 1/3] rtla: Add libsubcmd dependency
Date: Fri, 20 Mar 2026 16:06:49 +0100
Message-ID: <20260320150651.51057-2-tglozar@redhat.com>
In-Reply-To: <20260320150651.51057-1-tglozar@redhat.com>
References: <20260320150651.51057-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In preparation to migrating RTLA to libsubcmd, build libsubcmd from the
appropriate directory next to the RTLA build proper, and link the
resulting object to RTLA.

libsubcmd uses str_error_r() and strlcpy() at several places. To support
these, also link the respective libraries from tools/lib.

For completeness, also add tools/include to include path. This will
allow other userspace function and macros shipped with the kernel to be
used in RTLA; perf and bpftool, two other users of libsubcmd, already do
that.

To prevent name conflict, rename RTLA's run_command() function to
run_tool_command(), and replace RTLA's own container_of implementation
with the one in tools/include/linux/container_of.h.

Assisted-by: Composer:composer-1
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/.gitignore  |  1 +
 tools/tracing/rtla/Makefile    | 53 +++++++++++++++++++++++++++++-----
 tools/tracing/rtla/src/rtla.c  |  8 ++---
 tools/tracing/rtla/src/utils.h |  6 ++--
 4 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
index 4d39d64ac08c..123c2d5ed7ac 100644
--- a/tools/tracing/rtla/.gitignore
+++ b/tools/tracing/rtla/.gitignore
@@ -9,3 +9,4 @@ custom_filename.txt
 osnoise_irq_noise_hist.txt
 osnoise_trace.txt
 timerlat_trace.txt
+libsubcmd/
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 45690ee14544..289e44c9664b 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -27,6 +27,24 @@ endif
 RTLA		:= $(OUTPUT)rtla
 RTLA_IN		:= $(RTLA)-in.o
 
+LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
+ifneq ($(OUTPUT),)
+  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
+else
+  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
+endif
+LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
+LIBSUBCMD_INCLUDES = -I$(LIBSUBCMD_OUTPUT)/include
+LIBSUBCMD_MAKEFLAGS = O=$(LIBSUBCMD_OUTPUT) DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir=
+
+TOOLS_INCLUDES = -I$(srctree)/tools/include
+
+LIB_STRING = $(OUTPUT)string.o
+LIB_STRING_SRC = $(srctree)/tools/lib/string.c
+
+LIB_STR_ERROR_R = $(OUTPUT)str_error_r.o
+LIB_STR_ERROR_R_SRC = $(srctree)/tools/lib/str_error_r.c
+
 VERSION		:= $(shell sh -c "make -sC ../../.. kernelversion | grep -v make")
 DOCSRC		:= ../../../Documentation/tools/rtla/
 
@@ -66,7 +84,7 @@ ifeq ($(config),1)
   include Makefile.config
 endif
 
-CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
+CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES) $(TOOLS_INCLUDES) $(LIBSUBCMD_INCLUDES)
 
 export CFLAGS OUTPUT srctree
 
@@ -93,20 +111,41 @@ tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
 	$(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bpf_action_map.o"
 endif
 
-$(RTLA): $(RTLA_IN)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(EXTLIBS)
+$(RTLA): $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
 
-static: $(RTLA_IN)
+static: $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
 	$(eval LDFLAGS += -static)
-	$(QUIET_LINK)$(CC) -static $(LDFLAGS) -o $(RTLA)-static $(RTLA_IN)  $(EXTLIBS)
+	$(QUIET_LINK)$(CC) -static $(LDFLAGS) -o $(RTLA)-static $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
 
 rtla.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=. $@
 
-$(RTLA_IN): fixdep FORCE src/timerlat.skel.h
+$(RTLA_IN): fixdep FORCE src/timerlat.skel.h $(LIBSUBCMD_INCLUDES)
 	make $(build)=rtla
 
-clean: doc_clean fixdep-clean
+$(LIBSUBCMD_OUTPUT):
+	$(Q)$(MKDIR) -p $@
+
+$(LIBSUBCMD_INCLUDES): $(LIBSUBCMD_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) $(LIBSUBCMD_MAKEFLAGS) \
+		install_headers
+
+$(LIBSUBCMD): fixdep $(LIBSUBCMD_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) $(LIBSUBCMD_MAKEFLAGS) \
+		$@
+
+$(LIB_STR_ERROR_R): $(LIB_STR_ERROR_R_SRC)
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
+
+$(LIB_STRING): $(LIB_STRING_SRC)
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
+
+$(LIBSUBCMD)-clean:
+	$(call QUIET_CLEAN, libsubcmd)
+	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
+
+clean: doc_clean fixdep-clean $(LIBSUBCMD)-clean
 	$(call QUIET_CLEAN, rtla)
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
index 7635c70123ab..845932f902ef 100644
--- a/tools/tracing/rtla/src/rtla.c
+++ b/tools/tracing/rtla/src/rtla.c
@@ -38,12 +38,12 @@ static void rtla_usage(int err)
 }
 
 /*
- * run_command - try to run a rtla tool command
+ * run_tool_command - try to run a rtla tool command
  *
  * It returns 0 if it fails. The tool's main will generally not
  * return as they should call exit().
  */
-int run_command(int argc, char **argv, int start_position)
+int run_tool_command(int argc, char **argv, int start_position)
 {
 	if (strcmp(argv[start_position], "osnoise") == 0) {
 		osnoise_main(argc-start_position, &argv[start_position]);
@@ -66,7 +66,7 @@ int main(int argc, char *argv[])
 	int retval;
 
 	/* is it an alias? */
-	retval = run_command(argc, argv, 0);
+	retval = run_tool_command(argc, argv, 0);
 	if (retval)
 		exit(0);
 
@@ -79,7 +79,7 @@ int main(int argc, char *argv[])
 		rtla_usage(0);
 	}
 
-	retval = run_command(argc, argv, 1);
+	retval = run_tool_command(argc, argv, 1);
 	if (retval)
 		exit(0);
 
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index e794ede64b2c..96fd72042717 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -7,6 +7,8 @@
 #include <stdbool.h>
 #include <stdlib.h>
 
+#include <linux/container_of.h>
+
 /*
  * '18446744073709551615\0'
  */
@@ -37,10 +39,6 @@ static inline bool str_has_prefix(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
-#define container_of(ptr, type, member)({			\
-	const typeof(((type *)0)->member) *__mptr = (ptr);	\
-	(type *)((char *)__mptr - offsetof(type, member)) ; })
-
 extern int config_debug;
 void debug_msg(const char *fmt, ...);
 void err_msg(const char *fmt, ...);
-- 
2.53.0

