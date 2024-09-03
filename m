Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00112200133
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352869; cv=none; b=rqrXZcZPCWsyefFQtxGzxNMi0+czi3NwUE+X7TJLBJALgbSOBToNRAMQXU/OWRYYq1xEe+S+bjGgwcgxAA2iL5G+NaWyAw+s3IsCu8xmGGy/JI+KwNe96t2i2O9+XWKAxa9JIZ0pLlYNQbW8arLfT5l2eCo4IZCw8sdPpoiTKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352869; c=relaxed/simple;
	bh=HRTm6FMoTj7icyw+BDc4OcrvXVqdobLmvETifTGDXZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wf265Knw33v/t5CeeaJAglEIi1b8L/D/AO6f1hgDUfi83bt/sQMPqiX4aw4b2icb0Imc1XhwXZLyRQFc9wkRwzUrrOE2Uu1u8+5OkzrFMapXYL9nURelZK+j3jUEopIig09RLMGWivQqirM5glak9FcJbK5BDK6eEC8n/DC7MuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RTTiztNl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RTTiztNl"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71774dcd09aso73516b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725352865; x=1725957665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p16rGgsm4xckpgdT1zNkI4kgPUb4epe1Eaf93VAZH3Q=;
        b=RTTiztNl9f11fewyhfk31HOhhMzAtaAdM/455nG/I+9+T4ENRz/51EBgoN0EmzP/SW
         xWYP6E5UL4lG6fZzhu1cEj+mfXoVE2yKFlXBSVLpT77pYbl+7XACVg+AK0g+/6Lqxcff
         H/y7eieRMXI5O97tCyArNKOVQ8yID22EK9jPaeHXdxm2QG478wbes4A6d/C+4FrOXouH
         /2lTdvKnnlBmo0bSFfVLIjm8ARXvhReuwOKGmT+yvQlxE+To7I2gMy13F0nB03+2syuY
         dMLQffMpX/VT8VV+QGW4x3LJdR6uN9eBSLS0jwsaCo6+LeiQ0duBlP2TVtyil5Zb3Wvv
         dzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352865; x=1725957665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p16rGgsm4xckpgdT1zNkI4kgPUb4epe1Eaf93VAZH3Q=;
        b=u8MGKywXSEFL32th70cGO8KCEfCD/vZTcfxI0GIYFWKpqgyNfKEUxWNubHLujoKnw8
         5IsJFTds1YvfrOkf9wUXTSAokldEdumqsXG2ayxgTA3/h19sW9vXjh9iy14VdXMTYfqx
         hbyHfnFpUGIEmOdrENLCweB4+NckP+2Mx1UUtOHM9fkpi3SfL+FOL1g5Xs++Sm/gjSL+
         KAzX8Nm8Rc+4g34E03SxBIG3jwdqN7k4rFBRrfgAG2Hl95bmCI7+xDYhbTNmkRMF9ssm
         /RkTCfUoneRKFIpBpIlBXrLkne1FBGr7PeRtFni2U0bcBaCS6KF7HYDOKulRkKnXne9e
         +Gvg==
X-Forwarded-Encrypted: i=1; AJvYcCUZFItX0+XvIEp0l1q/CVN56lrYO7Vj1M8Qy/3cwoLhUPd3eVh+IPGKcz//H7KQbtbksWXRJrLaxfNpMCZGSZfx@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmDMK2YH58aU5Obw1nX8ax9MWS+Ivps9PySPEUyoWEAPsB8Ki
	0h+Sqg3EeB8R/TbmwvrAbI0Tfiluu74ev3wmXF2WX3eMvKXbO8Oqtx1gpxSc6hQ=
X-Google-Smtp-Source: AGHT+IH4uV69NEot5xOV4KWWeuTFkrpmvWEXPnzuNlbZv/tHuhOYGF3kqeM1e/T6MtaCwt+lFY/MJQ==
X-Received: by 2002:a05:6a00:a22:b0:70d:2583:7227 with SMTP id d2e1a72fcca58-7173fa0a2d3mr9097144b3a.6.1725352865060;
        Tue, 03 Sep 2024 01:41:05 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55769f3sm8277836b3a.10.2024.09.03.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:41:04 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: irogers@google.com,
	acme@redhat.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] tools lib subcmd: Use array data to save built usage string
Date: Tue,  3 Sep 2024 16:40:48 +0800
Message-Id: <20240903084048.766892-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
free built usage string to solve the memory leak problem,
which causes perf tool to not print subcommands when outputting usage help,
reducing the friendliness of the information.

If use original method of dynamically allocating memory, caller needs to
free the memory in appropriate place. In order to avoid it, use an array
to save built usage string.
Currently, only perf tool uses this function, 128 bytes are enough.

Before:
  # perf sched

   Usage: (null)

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)

After:
  # perf sched

   Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)

Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/lib/subcmd/parse-options.c | 27 +++++++++++++++------------
 tools/lib/subcmd/parse-options.h | 10 ++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 4b60ec03b0bb..1e41a204864a 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -633,20 +633,26 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
-	char *buf = NULL;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
-		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
+		int n;
+		static char buf[USAGESTR_BUF_SIZE];
+		int buf_size = sizeof(buf);
 
-		for (int i = 0; subcommands[i]; i++) {
-			if (i)
-				astrcat(&buf, "|");
-			astrcat(&buf, subcommands[i]);
+		n = scnprintf(buf, buf_size, "%s %s [<options>] {",
+			      subcmd_config.exec_name, argv[0]);
+
+		for (int i = 0; subcommands[i] && n < buf_size - 1; i++) {
+			n += scnprintf(buf + n, buf_size - n, "%s%s",
+				       i ? "|" : "", subcommands[i]);
 		}
-		astrcat(&buf, "}");
+		if (n < buf_size - 1)
+			n += scnprintf(buf + n, buf_size - n, "}");
 
-		usagestr[0] = buf;
+		/* only provided if a complete string is built */
+		if (n < buf_size - 1)
+			usagestr[0] = buf;
 	}
 
 	parse_options_start(&ctx, argc, argv, flags);
@@ -678,10 +684,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
 		usage_with_options(usagestr, options);
 	}
-	if (buf) {
-		usagestr[0] = NULL;
-		free(buf);
-	}
+
 	return parse_options_end(&ctx);
 }
 
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 8e9147358a28..654ba0a2201c 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -174,6 +174,16 @@ extern int parse_options(int argc, const char **argv,
                          const struct option *options,
                          const char * const usagestr[], int flags);
 
+/* parse_options_subcommand() will filter out the processed options
+ * and subcommands, leave the non-option argments in argv[].
+ * If usagestr is empty, it will build usage string based on subcommands
+ * in format of "exec_name argv[0] [<options>] {subcommand1|subcomman2|...}".
+ *
+ * NOTE: In order to avoid the caller needing to free memory,
+ * use an 128-bytes array to store the built usage string.
+ * If need to expand the array size, please modify USAGESTR_BUF_SIZE macro.
+ */
+#define USAGESTR_BUF_SIZE 128
 extern int parse_options_subcommand(int argc, const char **argv,
 				const struct option *options,
 				const char *const subcommands[],
-- 
2.25.1

