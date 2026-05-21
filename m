Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A72BE7BE
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373130; cv=none; b=BUXb5aa2ciLdspIve2AwzubXBCOuC/4UooWyffcXyZPK0+mN7NvvyJOjuNRAcFZHG4Q8t0M7t8g6rijLyEVMleWzD/InQFPpCiztQVfyjtKccNZ7o4eDZbpa5mpgeklhXLUfWuR79j5u1iyrhX0nrNHyxBj/1HWBy57J2c2sPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373130; c=relaxed/simple;
	bh=55YlRYChFr/1kv/e7yVZ5w04U8HdZ0Qv46fqHYbd8lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfreAoj5JlxM+OkyVi17oez/JxodpXCZMjImbceucC67gai9+edXl/mHOpJ+tXs1YecSSiUHhvTVC/zPJVZBrPLeHMLPPxwccPH6b/atUDAOsQA0nP54PJPNSlBNO+ysY4LetIVdmaDWWWgNc6+Hd+nQGWBvOGLYP+OnoYncn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hG8Bi92U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hG8Bi92U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779373128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fk3Xl9XlxIYip2ISIzinPX3J5ZgeotOzmja4RirWRCE=;
	b=hG8Bi92UU7ZOHDY8Pr9mpnF+OqRr7nPLq0WppLsag1kmv9rPS2IbgzQYF7IpRLg8rPrE5H
	3z/R+Ywtha/rlGR5XHcc/x+sCY7W0yKKO63RYrbVgdFnMAYCJOep5iVBoAWmnVZKnnKm/s
	CAPH3vBfSbL1kVePIlhi/6nPK5QqrB4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-dXLOjquUMIOEdpX706_Fsg-1; Thu,
 21 May 2026 10:18:45 -0400
X-MC-Unique: dXLOjquUMIOEdpX706_Fsg-1
X-Mimecast-MFC-AGG-ID: dXLOjquUMIOEdpX706_Fsg_1779373124
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA2BE1956066;
	Thu, 21 May 2026 14:18:43 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE56E1684;
	Thu, 21 May 2026 14:18:40 +0000 (UTC)
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2 1/6] rtla: Add libsubcmd dependency
Date: Thu, 21 May 2026 16:18:28 +0200
Message-ID: <20260521141833.2353025-2-tglozar@redhat.com>
In-Reply-To: <20260521141833.2353025-1-tglozar@redhat.com>
References: <20260521141833.2353025-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

In preparation for migrating RTLA to libsubcmd, build libsubcmd from the
appropriate directory next to the RTLA build proper, and link the
resulting object to RTLA.

libsubcmd uses str_error_r() and strlcpy() at several places. To support
these, also link the respective libraries from tools/lib.

For completeness, also add tools/include to include path. This will
allow other userspace functions and macros shipped with the kernel to be
used in RTLA; perf and bpftool, two other users of libsubcmd, already do
that.

To prevent a name conflict, rename RTLA's run_command() function to
run_tool_command(), and replace RTLA's own container_of implementation
with the one in tools/include/linux/container_of.h.

Assisted-by: Composer:composer-1
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/.gitignore  |  2 ++
 tools/tracing/rtla/Makefile    | 66 ++++++++++++++++++++++++++++++----
 tools/tracing/rtla/src/rtla.c  |  8 ++---
 tools/tracing/rtla/src/utils.h |  6 ++--
 4 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
index 231fb8d67f97..c7b4bf1c8ba9 100644
--- a/tools/tracing/rtla/.gitignore
+++ b/tools/tracing/rtla/.gitignore
@@ -10,3 +10,5 @@ custom_filename.txt
 osnoise_irq_noise_hist.txt
 osnoise_trace.txt
 timerlat_trace.txt
+libsubcmd/
+lib/
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 45690ee14544..19eb5581fa23 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -27,6 +27,30 @@ endif
 RTLA		:= $(OUTPUT)rtla
 RTLA_IN		:= $(RTLA)-in.o
 
+LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
+ifneq ($(OUTPUT),)
+  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
+else
+  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
+endif
+LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
+LIBSUBCMD_INCLUDES = $(LIBSUBCMD_OUTPUT)/include
+LIBSUBCMD_MAKEFLAGS = O=$(LIBSUBCMD_OUTPUT) DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir=
+
+TOOLS_INCLUDES = -I$(srctree)/tools/include
+
+ifneq ($(OUTPUT),)
+  LIB_OUTPUT = $(abspath $(OUTPUT))/lib
+else
+  LIB_OUTPUT = $(CURDIR)/lib
+endif
+
+LIB_STRING = $(LIB_OUTPUT)/string.o
+LIB_STRING_SRC = $(srctree)/tools/lib/string.c
+
+LIB_STR_ERROR_R = $(LIB_OUTPUT)/str_error_r.o
+LIB_STR_ERROR_R_SRC = $(srctree)/tools/lib/str_error_r.c
+
 VERSION		:= $(shell sh -c "make -sC ../../.. kernelversion | grep -v make")
 DOCSRC		:= ../../../Documentation/tools/rtla/
 
@@ -66,7 +90,7 @@ ifeq ($(config),1)
   include Makefile.config
 endif
 
-CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
+CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES) $(TOOLS_INCLUDES) -I$(LIBSUBCMD_INCLUDES)
 
 export CFLAGS OUTPUT srctree
 
@@ -93,20 +117,48 @@ tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
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
+$(LIB_OUTPUT):
+	$(Q)$(MKDIR) -p $@
+
+$(LIB_STR_ERROR_R): $(LIB_STR_ERROR_R_SRC) $(LIB_OUTPUT)
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
+
+$(LIB_STRING): $(LIB_STRING_SRC) $(LIB_OUTPUT)
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
+
+libsubcmd-clean:
+	$(call QUIET_CLEAN, libsubcmd)
+	$(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
+
+lib-clean:
+	$(call QUIET_CLEAN, lib)
+	$(Q)$(RM) -r -- $(LIB_OUTPUT)
+
+clean: doc_clean fixdep-clean libsubcmd-clean lib-clean
 	$(call QUIET_CLEAN, rtla)
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
index 3398250076ea..f4342ca684c3 100644
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
@@ -69,7 +69,7 @@ int main(int argc, char *argv[])
 	int retval;
 
 	/* is it an alias? */
-	retval = run_command(argc, argv, 0);
+	retval = run_tool_command(argc, argv, 0);
 	if (retval)
 		exit(0);
 
@@ -82,7 +82,7 @@ int main(int argc, char *argv[])
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
2.54.0

