Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E181422AD;
	Thu, 18 Jul 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313677; cv=none; b=JuU/5tLO5G67vIifbpCHukqxI15UBJ8kPay5GJylxrw/3wWWfSJ9pb1rHMCqdU5ihwzulQ/hc6bQmlpAJ59YkUzHnQA6wLVqMvNB/0p1cwJPmL7Wng/igAdUCm+G+4HEwMld8FwzMPlQjfvtpkahpkH3ZsUFwZSgFrpf0zl8+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313677; c=relaxed/simple;
	bh=piSSvhcOXa7lk50JaJgPTy2qVuOMxR5seC/zJ+ZV1iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dwxyn2KUUmb8pwPZq3ORySCPy0yOyn2T1AsDZhJVMgm38kLdXDM2uNmuUBKkUTXBHIe8IixPM5bBRhF7ENG+KoCYbfb4C/y/gbTSzuMC/Yrd2G4KnE0VNO/cbV0c6BjyJ/1Q8X1oEs4UHZcAZ7kUD94q0DzMwlBOnOPQbdu+x1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz; spf=pass smtp.mailfrom=foxlink.cz; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxlink.cz
Received: from mx-8.mail.web4u.cz (localhost [IPv6:::1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id 1ED6B1FFCBF;
	Thu, 18 Jul 2024 16:30:54 +0200 (CEST)
Received: from kettlebell.localdomain (unknown [193.86.188.206])
	(Authenticated sender: m.liska@foxlink.cz)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id E55901FF9DF;
	Thu, 18 Jul 2024 16:30:53 +0200 (CEST)
From: m.liska@foxlink.cz
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	irogers@google.com,
	Martin Liska <martin.liska@hey.com>
Subject: [PATCH] perf script: add --addr2line option
Date: Thu, 18 Jul 2024 16:30:09 +0200
Message-ID: <20240718143009.197851-1-m.liska@foxlink.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-W4U-Auth: 873ed7be6bc925f4f6c218afcc7769815718d707

From: Martin Liska <martin.liska@hey.com>

Similarly to other subcommands (like report, top), it would be handy to
provide a path for addr2line command.
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index ff086ef05a0c..5abb960c4960 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -369,6 +369,9 @@ OPTIONS
 --demangle-kernel::
 	Demangle kernel symbol names to human readable form (for C++ kernels).
 
+--addr2line=<path>::
+	Path to addr2line binary.
+
 --header
 	Show perf.data header.
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..301ea1c98e36 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3897,7 +3897,7 @@ int cmd_script(int argc, const char **argv)
 	};
 	struct utsname uts;
 	char *script_path = NULL;
-	const char *dlfilter_file = NULL;
+	const char *dlfilter_file = NULL, *addr2line_path = NULL;
 	const char **__argv;
 	int i, j, err = 0;
 	struct perf_script script = {
@@ -4052,6 +4052,8 @@ int cmd_script(int argc, const char **argv)
 			"Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 			"Enable kernel symbol demangling"),
+	OPT_STRING(0, "addr2line", &addr2line_path, "path",
+			"addr2line binary to use for line numbers"),
 	OPT_STRING(0, "time", &script.time_str, "str",
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
@@ -4138,6 +4140,12 @@ int cmd_script(int argc, const char **argv)
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
 
+	if (addr2line_path) {
+		symbol_conf.addr2line_path = strdup(addr2line_path);
+		if (!symbol_conf.addr2line_path)
+			return -ENOMEM;
+	}
+
 	/* make sure PERF_EXEC_PATH is set for scripts */
 	set_argv_exec_path(get_argv_exec_path());
 
-- 
2.45.2

