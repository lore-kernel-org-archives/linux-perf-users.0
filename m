Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240442DF144;
	Thu, 27 Nov 2025 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764218660; cv=none; b=ikqm6vKHR+z83tGFjLCpqk4B/LxOGeVNPS58KL7n0f7tXOTEReHTIgV70ff2O7GiG+PVS0O3Qty8L6VLz2OiJ6eZCu/pNir/DTB1ElTgY5MvxIics8oTEqYnMPI5u76PSNmINWEYm713hTpcLOmwgkJCtcZMaPRiaTtNDC03p/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764218660; c=relaxed/simple;
	bh=odNUPVkd3OWxfZFbBCkAb6oVbbG/scpWrx0iT14zz4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJDf/xy3zr/DekURISl4FmFSoFo8FaSVpI9hbcjpvxzsb5IyDsSiVDZBAVjeAOxPfEyh7LEsKf4jbA/TNO6yVh7Py7Dl/BYM8jDpx/Y3PechKEhJ8uEWssX99AzuKNgwalWorzRFD+2LeuX7Kv5BiBCyECM7EgCMPkqsbjO3nW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlsO1PeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlsO1PeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222A5C4CEF8;
	Thu, 27 Nov 2025 04:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764218659;
	bh=odNUPVkd3OWxfZFbBCkAb6oVbbG/scpWrx0iT14zz4E=;
	h=From:To:Cc:Subject:Date:From;
	b=NlsO1PeGq5FuGXojcOLcwtdhOjA/soGZJOAjKcDrjNV36Az5GJlyAJ+iR/WTrUNAe
	 MqkSq3MkWUc++v6skc+P9wEE4ZHINA1nKTw8GxzRvDgWu9nSVXovnMLcFenuKli82/
	 v57bF+O6GAodGgiaheHGWg4VmmNIslvb4JGoQ2pQAt7wl/FXMSANFkuUkBESnB/VlA
	 S8sRRGejLMKN5TqY36QcayZzb6JVU6uIMgN3uUhWBU+msM8Y/+Y6nsekqpaZcodGiq
	 cmi5B/OzqQph7bOjnEDY3eOCX+Sc27NAfrWA/b/CPw3jKQ9VZ+VX4Kji8KPZH0f3fi
	 jc5GX152KaXCg==
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
	Thomas Richter <tmricht@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Skip internal syscall arguments
Date: Wed, 26 Nov 2025 20:44:18 -0800
Message-ID: <20251127044418.677379-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes in the linux-next kernel will add new field for syscalls
to have contents in the userspace like below.

  # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
  name: sys_enter_write
  ID: 758
  format:
          field:unsigned short common_type;       offset:0;       size:2; signed:0;
          field:unsigned char common_flags;       offset:2;       size:1; signed:0;
          field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
          field:int common_pid;   offset:4;       size:4; signed:1;

          field:int __syscall_nr; offset:8;       size:4; signed:1;
          field:unsigned int fd;  offset:16;      size:8; signed:0;
          field:const char * buf; offset:24;      size:8; signed:0;
          field:size_t count;     offset:32;      size:8; signed:0;
          field:__data_loc char[] __buf_val;      offset:40;      size:4; signed:0;

  print fmt: "fd: 0x%08lx, buf: 0x%08lx (%s), count: 0x%08lx", ((unsigned long)(REC->fd)),
             ((unsigned long)(REC->buf)), __print_dynamic_array(__buf_val, 1),
             ((unsigned long)(REC->count))

We have a different way to handle those arguments and this change
confuses perf trace then make some tests failing.  Fix it by skipping
the new fields that have "__data_loc char[]" type.

Maybe we can switch to this instead of the BPF augmentation later.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a743bda294bd3400..baee1f6956001d86 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2069,6 +2069,15 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
        return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_name, nmemb, name);
 }
 
+/*
+ * v6.19 kernel added new fields to read userspace memory for event tracing.
+ * But it's not used by perf and confuses the syscall parameters.
+ */
+static bool is_internal_field(struct tep_format_field *field)
+{
+	return !strcmp(field->type, "__data_loc char[]");
+}
+
 static struct tep_format_field *
 syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
 			    bool *use_btf)
@@ -2077,6 +2086,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 	int len;
 
 	for (; field; field = field->next, ++arg) {
+		/* assume it's the last argument */
+		if (is_internal_field(field))
+			continue;
+
 		last_field = field;
 
 		if (arg->scnprintf)
@@ -2145,6 +2158,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 {
 	char tp_name[128];
 	const char *name;
+	struct tep_format_field *field;
 	int err;
 
 	if (sc->nonexistent)
@@ -2201,6 +2215,13 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		--sc->nr_args;
 	}
 
+	field = sc->args;
+	while (field) {
+		if (is_internal_field(field))
+			--sc->nr_args;
+		field = field->next;
+	}
+
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-- 
2.52.0.487.g5c8c507ade-goog

