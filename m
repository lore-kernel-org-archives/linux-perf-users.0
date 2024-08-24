Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8643185E7B;
	Sat, 24 Aug 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517214; cv=none; b=uRMHYym/wuUC7PvXZOX7sPf+7G9wqc3l4q+8LnFHo0GcsKiIp5LQetFLhrneqJmLzXnHpaxAh59WxXGDhadpBNKmIRKBGCezJPfvdBVWPD6ak2onBo0ihbwkO/Z1+HsR/EhKf4dj/+mGkAKqlLnYMigQ/s73VguWPXiMzZnIegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517214; c=relaxed/simple;
	bh=bk683qJ2DYWOMbFVTIb1SnYRPjP4cgf87rQGoMsqAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUHUj15WNjxOTdbgBupy8VVy2Xxou8NmfNMgFfFJSlVNTGvmUGpg/VXcFYe27SEelwGb5x7m9+CZ7N2dGkIC7HFehDFRLvIuY6tt//M+Ord4mQhBgNj4YHIamnJKU68jlPRLvZ7Uw7cNOU1qFFe5OiYXUrNkmCvdivu8ay5Foxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6mt9Dnn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6mt9Dnn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso2266015a91.1;
        Sat, 24 Aug 2024 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517210; x=1725122010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaRuGKTP9IsE4307qeohX5bW/qRe0+n76G/9u+rihkI=;
        b=P6mt9DnnnTclDzdxKDnnQJwiqLQUo4hI+/zV4JZ+gf0gB2NMcIAgpIoGoaCE66CAi+
         Dp9fxZKE3A3UwhiK3LkpUICvjiRe69x4CRsLJmHSvv3iqhEprm5vJzAyyzaCdpiHimKQ
         cCCPrXzQFFC5pUbaN8qqR9JMfAOfy7gyCcXAjEHpB3T27YL/I8g3A7jKGGO38LlwaQFS
         wZXK+jkOtkET1OgjwzNGh4Z6eve3uFiLmtWJ5K1JqCnxmEWnN0CD/77QFeNigZEl/MaM
         119Z/SAE7hhHgyKpm9W1GjJc/8rtrIofGor83435kVmtKe/rMxmutQcvCGeRvNIBOzlM
         Ho4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517210; x=1725122010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaRuGKTP9IsE4307qeohX5bW/qRe0+n76G/9u+rihkI=;
        b=pYEkb5GGK33igrofraMo3kyemhYr+t9Y+AMCKOWR0pnnvFVZCvY9VerUMVxE67wylp
         zq76899eJj9ySgPIvPW2N1/y/BghiGSynitB1j8TGY/l4yPHyRROC3p7CPUD4Tk6ZeW6
         Go1Z8xlIqhB12MvH6gYEtSRH2hxJioojlQhkjVGUxSDaFaAiG/CI/9u68CG3hPJZ4Ck9
         86K1AztBf1QZrvLt1DKvsg8xKV8hRvwxZcCJfZXFUcgvh+GKFxjVN2FHvrZfbvRS7f8/
         CaryqJbFnsK6IhXDZwc5e61nHU3JJS82shwGGXJfD3m2v5cgQlgyiuilqQOgZ7nTxJjt
         jjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuIXTINUSKJghB6cONLTEJ0uREA0OfSsrGPynHoy83qOwdJ5e//PS3B8hVPMesB+acKqQjUuEZPhJg7kg=@vger.kernel.org, AJvYcCV1eJfCzwka4dHCdII5rNnZRNxS7B9Wc60MJwBPBZIXbTYo2cy18a0JJyGarL+asVsVfM1bKS4v/lMO0GBf7ACl5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEG6WqKHNzmThiMdxq8x7rUDhFsnhls08uGseZlIs2RidaaA51
	v4fpT49GZW+plTHHjAhAkILGvzyNdnv1iPS78amq3RaufnHgEYJX
X-Google-Smtp-Source: AGHT+IFgR0seSynDGiVKQt7sR4u3KEOmbA4drCXHG2wBXhb8pk/+BpDjhaktjYX/oEkkPZutZVAPmQ==
X-Received: by 2002:a17:90b:115:b0:2d3:dcc1:f98f with SMTP id 98e67ed59e1d1-2d646bf282bmr6030596a91.10.1724517209816;
        Sat, 24 Aug 2024 09:33:29 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:29 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 5/8] perf trace: Pretty print buffer data
Date: Sun, 25 Aug 2024 00:33:19 +0800
Message-ID: <20240824163322.60796-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define TRACE_AUG_MAX_BUF in trace_augment.h data, which is the maximum
buffer size we can augment. BPF will include this header too.

Print buffer in a way that's different than just printing a string, we
print all the control characters in \digits (such as \0 for null, and
\10 for newline, LF).

For character that has a bigger value than 127, we print the digits
instead of the character itself as well.

Committer notes:

Simplified the buffer scnprintf to avoid using multiple buffers as
discussed in the patch review thread.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240815013626.935097-8-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c      | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/trace_augment.h |  6 ++++++
 2 files changed, 39 insertions(+)
 create mode 100644 tools/perf/util/trace_augment.h

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 048bcb92624c..470d74e3f875 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -65,6 +65,7 @@
 #include "syscalltbl.h"
 #include "rb_resort.h"
 #include "../perf.h"
+#include "trace_augment.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -852,6 +853,10 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 
 #define SCA_FILENAME syscall_arg__scnprintf_filename
 
+static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg);
+
+#define SCA_BUF syscall_arg__scnprintf_buf
+
 static size_t syscall_arg__scnprintf_pipe_flags(char *bf, size_t size,
 						struct syscall_arg *arg)
 {
@@ -1745,6 +1750,32 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 	return 0;
 }
 
+#define MAX_CONTROL_CHAR 31
+#define MAX_ASCII 127
+
+static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
+{
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	unsigned char *orig = (unsigned char *)augmented_arg->value;
+	size_t printed = 0;
+	int consumed;
+
+	if (augmented_arg == NULL)
+		return 0;
+
+	for (int j = 0; j < augmented_arg->size; ++j) {
+		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
+		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
+		printed += scnprintf(bf + printed, size - printed, control_char ? "\\%d" : "%c", (int)orig[j]);
+	}
+
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+	arg->augmented.size -= consumed;
+
+	return printed;
+}
+
 static bool trace__filter_duration(struct trace *trace, double t)
 {
 	return t < (trace->duration_filter * NSEC_PER_MSEC);
@@ -1956,6 +1987,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL))
 			arg->scnprintf = SCA_FILENAME;
+		else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
+			arg->scnprintf = SCA_BUF;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			arg->scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
new file mode 100644
index 000000000000..57a3e5045937
--- /dev/null
+++ b/tools/perf/util/trace_augment.h
@@ -0,0 +1,6 @@
+#ifndef TRACE_AUGMENT_H
+#define TRACE_AUGMENT_H
+
+#define TRACE_AUG_MAX_BUF 32 /* for buffer augmentation in perf trace */
+
+#endif
-- 
2.45.2

