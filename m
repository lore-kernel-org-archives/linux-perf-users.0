Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97232C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 11:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729896115B
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 11:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhIIL3s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:29:48 -0400
Received: from smoke.leastfixedpoint.com ([81.4.107.66]:35048 "EHLO
        mail.leastfixedpoint.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhIIL3s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 07:29:48 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2021 07:29:48 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.leastfixedpoint.com (Postfix) with ESMTPSA id B770B67EBD;
        Thu,  9 Sep 2021 12:22:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leastfixedpoint.com;
        s=default; t=1631186562;
        bh=wN+5W1H85mb08IIs8upbjnX70Ewv+fmvSRh7NgcHYfg=;
        h=From:To:Cc:Subject:Date;
        b=rqflSxqXOYh/EdIWq3cuIuCgu6sCW0NHDC8k0rvFiCud5gTedcNjdvyLmFtvoPFDe
         AN//XeJKHUhlAC0/owtH6YUKSgFBwTWzhjtuC++Q8YluIQeOqYJYe+R1tnz1Y7UrMt
         zeeYmQcp7ZyHfoTqtNZGl1g9VD71elqXHyDhs4yo=
From:   Tony Garnock-Jones <tonyg@leastfixedpoint.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Subject: [PATCH] tools/perf: Use long-running addr2line per dso
Date:   Thu,  9 Sep 2021 13:22:02 +0200
Message-Id: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Invoking addr2line in a separate subprocess, one for each required
lookup, takes a terribly long time. This patch introduces a
long-running addr2line process for each dso, *DRAMATICALLY* speeding
up runs of perf. What used to take tens of minutes now takes tens of
seconds.

Debian bug report about this issue:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911815

Signed-off-by: Tony Garnock-Jones <tonyg@leastfixedpoint.com>

---
 tools/perf/util/srcline.c | 430 +++++++++++++++++++++++++++++---------
 1 file changed, 330 insertions(+), 100 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 5b7d6c16d33f..767dc9af2789 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
 
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -119,6 +124,8 @@ static struct symbol *new_inline_sym(struct dso *dso,
 	return inline_sym;
 }
 
+#define MAX_INLINE_NEST 1024
+
 #ifdef HAVE_LIBBFD_SUPPORT
 
 /*
@@ -273,8 +280,6 @@ static void addr2line_cleanup(struct a2l_data *a2l)
 	free(a2l);
 }
 
-#define MAX_INLINE_NEST 1024
-
 static int inline_list__append_dso_a2l(struct dso *dso,
 				       struct inline_node *node,
 				       struct symbol *sym)
@@ -361,26 +366,14 @@ void dso__free_a2l(struct dso *dso)
 	dso->a2l = NULL;
 }
 
-static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
-					struct dso *dso, struct symbol *sym)
-{
-	struct inline_node *node;
-
-	node = zalloc(sizeof(*node));
-	if (node == NULL) {
-		perror("not enough memory for the inline node");
-		return NULL;
-	}
-
-	INIT_LIST_HEAD(&node->val);
-	node->addr = addr;
-
-	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
-	return node;
-}
-
 #else /* HAVE_LIBBFD_SUPPORT */
 
+struct a2l_subprocess {
+	pid_t addr2line_pid;
+	FILE *to_child;
+	FILE *from_child;
+};
+
 static int filename_split(char *filename, unsigned int *line_nr)
 {
 	char *sep;
@@ -402,114 +395,351 @@ static int filename_split(char *filename, unsigned int *line_nr)
 	return 0;
 }
 
+static FILE *dup_fdopen(int fd, const char *mode)
+{
+	FILE *f = NULL;
+	int nfd = dup(fd);
+
+	if (nfd == -1)
+		goto out;
+
+	f = fdopen(nfd, mode);
+	if (f == NULL) {
+		close(nfd);
+		goto out;
+	}
+
+out:
+	return f;
+}
+
+static void addr2line_subprocess_cleanup(struct a2l_subprocess *a2l)
+{
+	int _wstatus = 0;
+
+	if (a2l->addr2line_pid != -1) {
+		kill(a2l->addr2line_pid, SIGKILL);
+		waitpid(a2l->addr2line_pid, &_wstatus, 0);
+		a2l->addr2line_pid = -1;
+	}
+
+	if (a2l->to_child != NULL) {
+		fclose(a2l->to_child);
+		a2l->to_child = NULL;
+	}
+
+	if (a2l->from_child != NULL) {
+		fclose(a2l->from_child);
+		a2l->from_child = NULL;
+	}
+
+	free(a2l);
+}
+
+static struct a2l_subprocess *addr2line_subprocess_init(const char *path)
+{
+	struct a2l_subprocess *a2l = NULL;
+	int sockets[2] = {-1, -1};
+
+	a2l = zalloc(sizeof(*a2l));
+	if (a2l == NULL)
+		goto out;
+
+	a2l->addr2line_pid = -1;
+	a2l->to_child = NULL;
+	a2l->from_child = NULL;
+
+	/* Our convention: sockets[0] is for the parent, sockets[1] for the child */
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sockets) == -1)
+		goto out;
+
+	a2l->addr2line_pid = fork();
+
+	switch (a2l->addr2line_pid) {
+	case -1:
+		pr_warning("fork failed for addr2line of %s\n", path);
+		goto out;
+	case 0:
+		/* We are in the child process. */
+		if (sockets[1] != STDIN_FILENO) {
+			if (dup2(sockets[1], STDIN_FILENO) == -1) {
+				pr_warning("could not set stdin for addr2line of %s\n", path);
+				close(sockets[1]);
+				goto out;
+			}
+			close(sockets[1]);
+			sockets[1] = STDIN_FILENO;
+		}
+		if (sockets[1] != STDOUT_FILENO) {
+			if (dup2(sockets[1], STDOUT_FILENO) == -1) {
+				pr_warning("could not set stdout for addr2line of %s\n", path);
+				close(sockets[1]);
+				goto out;
+			}
+		}
+		close(sockets[0]);
+		execlp("addr2line", "addr2line", "-e", path, "-i", "-f", NULL);
+		abort(); /* If execute reaches here, we're in serious trouble anyway, so be noisy */
+		/* not reached */
+		break;
+
+	default:
+		close(sockets[1]);
+		break;
+	}
+
+	/*
+	 * We are in the parent process, sockets[1] is closed, and sockets[0] is waiting to be
+	 * used.
+	 */
+
+	a2l->to_child = dup_fdopen(sockets[0], "w");
+	if (a2l->to_child == NULL) {
+		pr_warning("could not open write-stream to addr2line of %s\n", path);
+		goto out;
+	}
+
+	a2l->from_child = dup_fdopen(sockets[0], "r");
+	if (a2l->from_child == NULL) {
+		pr_warning("could not open read-stream from addr2line of %s\n", path);
+		goto out;
+	}
+
+	close(sockets[0]);
+
+	return a2l;
+
+out:
+	if (a2l)
+		addr2line_subprocess_cleanup(a2l);
+
+	close(sockets[0]);
+	close(sockets[1]);
+	return NULL;
+}
+
+static int read_addr2line_stanza(struct a2l_subprocess *a2l,
+				 char **function,
+				 char **filename,
+				 unsigned int *line_nr)
+{
+	/*
+	 * Returns:
+	 * -1 ==> error
+	 * 0 ==> sentinel (or other ill-formed) stanza read
+	 * 1 ==> a genuine stanza read
+	 */
+	char *line = NULL;
+	size_t line_len = 0;
+	unsigned int dummy_line_nr = 0;
+	int ret = -1;
+
+	if (function != NULL && *function != NULL) {
+		free(*function);
+		*function = NULL;
+	}
+
+	if (filename != NULL && *filename != NULL) {
+		free(*filename);
+		*filename = NULL;
+	}
+
+	if (line_nr != NULL)
+		*line_nr = 0;
+
+	if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len)
+		goto error;
+
+	if (function != NULL)
+		*function = strdup(strim(line));
+
+	free(line);
+	line = NULL;
+	line_len = 0;
+
+	if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len)
+		goto error;
+
+	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0) {
+		ret = 0;
+		goto error;
+	}
+
+	if (filename != NULL)
+		*filename = strdup(line);
+
+	free(line);
+	line = NULL;
+	line_len = 0;
+
+	return 1;
+
+error:
+	if (line != NULL)
+		free(line);
+	if (function != NULL && *function != NULL) {
+		free(*function);
+		*function = NULL;
+	}
+	if (filename != NULL && *filename != NULL) {
+		free(*filename);
+		*filename = NULL;
+	}
+	return ret;
+}
+
+static int inline_list__append_stanza(struct dso *dso,
+				      struct inline_node *node,
+				      struct symbol *sym,
+				      const char *function,
+				      const char *filename,
+				      unsigned int line_nr)
+{
+	struct symbol *inline_sym = new_inline_sym(dso, sym, function);
+
+	return inline_list__append(inline_sym, srcline_from_fileline(filename, line_nr), node);
+}
+
 static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line_nr,
-		     struct dso *dso __maybe_unused,
-		     bool unwind_inlines __maybe_unused,
-		     struct inline_node *node __maybe_unused,
+		     struct dso *dso,
+		     bool unwind_inlines,
+		     struct inline_node *node,
 		     struct symbol *sym __maybe_unused)
 {
-	FILE *fp;
-	char cmd[PATH_MAX];
-	char *filename = NULL;
-	size_t len;
+	struct a2l_subprocess *a2l = dso->a2l;
+	char *stanza_function = NULL;
+	char *stanza_filename = NULL;
+	unsigned int stanza_line_nr = 0;
+	int stanza_status = -1;
 	int ret = 0;
+	size_t inline_count = 0;
 
-	scnprintf(cmd, sizeof(cmd), "addr2line -e %s %016"PRIx64,
-		  dso_name, addr);
+	if (!a2l) {
+		dso->a2l = addr2line_subprocess_init(dso_name);
+		a2l = dso->a2l;
+	}
 
-	fp = popen(cmd, "r");
-	if (fp == NULL) {
-		pr_warning("popen failed for %s\n", dso_name);
-		return 0;
+	if (a2l == NULL) {
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
+		goto out;
 	}
 
-	if (getline(&filename, &len, fp) < 0 || !len) {
-		pr_warning("addr2line has no output for %s\n", dso_name);
+	/*
+	 * Send our request and then *deliberately* send something that can't be interpreted as
+	 * a valid address to ask addr2line about (namely, ","). This causes addr2line to first
+	 * write out the answer to our request, in an unbounded/unknown number of stanzas, and
+	 * then to write out the lines "??" and "??:0", so that we can detect when it has
+	 * finished giving us anything useful. We have to be careful about the first stanza,
+	 * though, because it may be genuinely unknown, in which case we'll get two sets of
+	 * "??"/"??:0" lines.
+	 */
+	if (fprintf(a2l->to_child, "%016"PRIx64"\n,\n", addr) < 0 || fflush(a2l->to_child) != 0) {
+		pr_warning("%s %s: could not send request\n", __func__, dso_name);
 		goto out;
 	}
 
-	ret = filename_split(filename, line_nr);
-	if (ret != 1) {
-		free(filename);
+	switch (read_addr2line_stanza(a2l, &stanza_function, &stanza_filename, &stanza_line_nr)) {
+	case -1:
+		pr_warning("%s %s: could not read first stanza\n", __func__, dso_name);
 		goto out;
+	case 0:
+		/*
+		 * The first stanza was invalid, so return failure, but first read another
+		 * stanza, since we asked a junk question and have to clear the answer out.
+		 */
+		switch (read_addr2line_stanza(a2l, NULL, NULL, NULL)) {
+		case -1:
+			pr_warning("%s %s: could not read delimiter stanza\n", __func__, dso_name);
+			break;
+		case 0:
+			/* As expected. */
+			break;
+		default:
+			pr_warning("%s %s: unexpected stanza instead of sentinel",
+				   __func__, dso_name);
+			break;
+		}
+		goto out;
+	default:
+		break;
+	}
+
+	if (file) {
+		*file = strdup(stanza_filename);
+		ret = 1;
+	}
+	if (line_nr)
+		*line_nr = stanza_line_nr;
+
+	if (unwind_inlines) {
+		if (node && inline_list__append_stanza(dso, node, sym,
+						       stanza_function,
+						       stanza_filename,
+						       stanza_line_nr)) {
+			ret = 0;
+			goto out;
+		}
 	}
 
-	*file = filename;
+	/* We have to read the stanzas even if we don't care about the inline info. */
+	while ((stanza_status = read_addr2line_stanza(a2l,
+						      &stanza_function,
+						      &stanza_filename,
+						      &stanza_line_nr)) == 1) {
+		if (unwind_inlines && node && inline_count++ < MAX_INLINE_NEST) {
+			if (inline_list__append_stanza(dso, node, sym,
+						       stanza_function,
+						       stanza_filename,
+						       stanza_line_nr)) {
+				ret = 0;
+				goto out;
+			}
+			ret = 1; /* found at least one inline frame */
+		}
+	}
 
 out:
-	pclose(fp);
+	if (stanza_function != NULL)
+		free(stanza_function);
+	if (stanza_filename != NULL)
+		free(stanza_filename);
 	return ret;
 }
 
-void dso__free_a2l(struct dso *dso __maybe_unused)
+void dso__free_a2l(struct dso *dso)
 {
-}
+	struct a2l_subprocess *a2l = dso->a2l;
 
-static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
-					struct dso *dso __maybe_unused,
-					struct symbol *sym)
-{
-	FILE *fp;
-	char cmd[PATH_MAX];
-	struct inline_node *node;
-	char *filename = NULL;
-	char *funcname = NULL;
-	size_t filelen, funclen;
-	unsigned int line_nr = 0;
-
-	scnprintf(cmd, sizeof(cmd), "addr2line -e %s -i -f %016"PRIx64,
-		  dso_name, addr);
-
-	fp = popen(cmd, "r");
-	if (fp == NULL) {
-		pr_err("popen failed for %s\n", dso_name);
-		return NULL;
-	}
-
-	node = zalloc(sizeof(*node));
-	if (node == NULL) {
-		perror("not enough memory for the inline node");
-		goto out;
-	}
-
-	INIT_LIST_HEAD(&node->val);
-	node->addr = addr;
-
-	/* addr2line -f generates two lines for each inlined functions */
-	while (getline(&funcname, &funclen, fp) != -1) {
-		char *srcline;
-		struct symbol *inline_sym;
-
-		strim(funcname);
-
-		if (getline(&filename, &filelen, fp) == -1)
-			goto out;
-
-		if (filename_split(filename, &line_nr) != 1)
-			goto out;
-
-		srcline = srcline_from_fileline(filename, line_nr);
-		inline_sym = new_inline_sym(dso, sym, funcname);
-
-		if (inline_list__append(inline_sym, srcline, node) != 0) {
-			free(srcline);
-			if (inline_sym && inline_sym->inlined)
-				symbol__delete(inline_sym);
-			goto out;
-		}
-	}
+	if (!a2l)
+		return;
 
-out:
-	pclose(fp);
-	free(filename);
-	free(funcname);
+	addr2line_subprocess_cleanup(a2l);
 
-	return node;
+	dso->a2l = NULL;
 }
 
 #endif /* HAVE_LIBBFD_SUPPORT */
 
+static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
+					struct dso *dso, struct symbol *sym)
+{
+	struct inline_node *node;
+
+	node = zalloc(sizeof(*node));
+	if (node == NULL) {
+		perror("not enough memory for the inline node");
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&node->val);
+	node->addr = addr;
+
+	addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
+	return node;
+}
+
 /*
  * Number of addr2line failures (without success) before disabling it for that
  * dso.
-- 
2.33.0

