Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B86347538
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015482; cv=none; b=CJtgtQ6CMk3A/s8brmSuybcJ9hlw1T99llp+Ku58h8K8WRnesXoOh6Yc6oZKV1VuojH97M14+wmzugmR5EW1g+OPC6rgTTMaaj/3AUFKD8xwJksdK0Y0Ir33H1+SscKUwhLTSJfzVRilvc8xmzyA0F0i9uMZLROsJiaraBdzguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015482; c=relaxed/simple;
	bh=/b18pfGcYG5J49852Uf/xpNRcW6fiySK2y+B7W3dtrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6rGEeqUHOQlzNpfbBt/qxLS4Xp2QKR4rHjLgYhIlYQYKidgbCDqPjXL33s9Eb6YBdO3uiNA7BGE3tuFHNjI3YJ6fA6fR13u78WV7Jp/IU+v7jVBWq931iyg2JFzd6O3Fabu2qAHRwgvUIr7uoqaFG5553ZDeCPt12QTUMa/i4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFZ0jSap; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFZ0jSap"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eedc94d37so2845802f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015479; x=1781620279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAiQptcYOlXy/icTduKx1v/eUqigIfQCIUFTgmuIVAI=;
        b=kFZ0jSapWdBGEQrsb+bsOa+LRoRBOmlN2c9Dmwsdi6XeDdAuWnLcfX+HnBjzd0GuV5
         Djvn9H9YS431GNNBRX17kUY+sMfEgpl36zfXZkCMLHJWDMdH3f6FjzlRAGHozgXhl0uA
         Ud6IY9BikGZWJqks717J2ZFBGgLrEgvyM39ewW264PXHrXcs9xjvRk8Yx1kAMk5bQLUM
         mVEvQ6CmogQEnyP6i4yhkAM1b22719ozQQjMYwh3MdnsK3/lnhuOzD12MumceSQUH1xw
         XGxXTSs99N2zatahMBlsaYoLHqsvSFZpam8Sc4hs9H4IkEHPc3fNxOG6jXs1CfxgI/K4
         fJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015479; x=1781620279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XAiQptcYOlXy/icTduKx1v/eUqigIfQCIUFTgmuIVAI=;
        b=NsnSdGX1vgRzrWZd+aCd5yZqzHJaqUAoiePhZ6l++9bIZueWYfjftd06gfwKfHh/M1
         Z483VfI5lObmctPpRPUG88YjNFHm4wbjkpyYljOFvQfmn/Zg5aw0E1KeWYUgtjAxN9kr
         iaHBZSbC3lubENg82Xo8AXKB+qHOFOprPiQrWxwiaXik4MiGbX6TgDhxHJL21LJMi5p8
         xFCR5F6Ihj1q6loxoO+kcTIKi0zyVQUOH6sIWbLl+YAOtKUaTPQ/GbSE1OPkCji5hhRF
         1n5qu6Hok+wc5fdDJsP0cu9MzD+7CdZbzbhsY/WaTj6JZcp0gSfubk+UvWRduBXvukSP
         2jfA==
X-Forwarded-Encrypted: i=1; AFNElJ9m8fZrmOKSXH+VZ2JpFy+bEhxhV4UKo2ioHNUJ4rU+1sHBqn6nsDt09aMWIWa5ua3B0XZSLKQd5ztOp2EBSSoh@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNZ1HjbdeDLMelXarhF/SWx5jhzjDUuxItsS4gGo33DC5onwt
	wXPBv7Q8LCZmoDFq+JC//jntNnH0pRVl9k+Kjc2SsB5UJA58fu9P73vv3+jvA2bn+FY=
X-Gm-Gg: Acq92OEUks4N+FgRvcE4Zb/A1C8l20sO8vryhMwvwCdgUj/4gbyIy9GmvMb0VUYR2sv
	MV/litDi3Sp1suwg631b7O0DNmahkMq8uF9waS7Ci4p2N7g39Lh8TbhO8a6NFe23ACjj7ca3auB
	Tu9Vb9kOf0rMf2SuZL6/Z5U8YUsPhdza7f4NvAYFbh7CBU7mey0ML1rJO+ko9U2ejKfc40/5IhJ
	X7t8E0FFIqP/eD9yOzODYrqeQPG8bjCY5Q3w053ImvSrTwVn5EKcK/LkqNwDMEaZhy0wrmD9t0F
	tEMlBEV0kud5dm9h7jR/luc9bd6bF77SeX7HBQ3Im6AHHYKiY4UX4yZPelIt+OrGZlWaOTLK+pe
	RhDSTkj0RTinFd4nlWVG+AOGuZ4wfQM/83GrW4dzamjE+3FpsAOIbOL9PHvhVtDp1pDNjDUG9Nd
	/ZYcCTiqOSZeCTOFT/WgNtujZCKaEM13tM6ochBoaHmtM=
X-Received: by 2002:a05:6000:2888:b0:460:3233:beec with SMTP id ffacd0b85a97d-460566db54fmr4205631f8f.40.1781015478791;
        Tue, 09 Jun 2026 07:31:18 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:18 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:30:55 +0100
Subject: [PATCH v4 02/19] perf test: Add workload-ctl option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-2-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Add a --workload-ctl=fifo:ctl-fifo[,ack-fifo] option for 'perf test
-w'. When set, run_workload() opens the named FIFO, writes enable before
invoking the builtin workload, writes disable before returning, and
waits for ack responses when an ack FIFO is provided to ensure that the
workload doesn't run until the events are enabled.

This can be used to limit the scope of the recording to only the
workload execution and avoid recording Perf setup and teardown code if
Perf record is started with events disabled (-D 1).

Assisted-by: Codex:GPT-5.5
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt |  12 +++
 tools/perf/tests/builtin-test.c        | 184 ++++++++++++++++++++++++++++++++-
 2 files changed, 194 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 32da0d1fa86a..2f4a91f5b9dc 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -69,3 +69,15 @@ OPTIONS
 
 --list-workloads::
 	List the available workloads to use with -w/--workload.
+
+--record-ctl=fifo:ctl-fifo[,ack-fifo]::
+	This option is used to communicate with a perf record session in order
+	to control the recording scope to only the workload and avoid recording
+	setup and teardown code. When specifying this option, the same FIFO path
+	must be specified in the record session via:
+
+	  perf record -D -1 --control=fifo:ctl-fifo[,ack-fifo] ...
+
+	Perf test sends 'enable' and 'disable' commands through ctl-fifo to
+	control event recording. If 'ack-fifo' is provided, the workload runner
+	waits for an 'ack' response after each command.
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b64fc2204f22..86ea427eb0aa 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -56,6 +56,7 @@ static unsigned int runs_per_test = 1;
 static unsigned int failure_snippet_lines = 10;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
+static const char *workload_control;
 
 /*
  * List of architecture specific tests. Not a weak symbol as the array length is
@@ -168,6 +169,11 @@ static struct test_workload *workloads[] = {
 #endif
 };
 
+struct workload_control {
+	int ctl_fd;
+	int ack_fd;
+};
+
 #define workloads__for_each(workload) \
 	for (unsigned i = 0; i < ARRAY_SIZE(workloads) && ({ workload = workloads[i]; 1; }); i++)
 
@@ -1387,13 +1393,185 @@ static int workloads__fprintf_list(FILE *fp)
 	return printed;
 }
 
+static int perf_control_open_fifo(struct workload_control *ctl, const char *str)
+{
+	char *s, *p;
+	int ret;
+
+	if (strncmp(str, "fifo:", 5))
+		return -EINVAL;
+
+	str += 5;
+	if (!*str || *str == ',')
+		return -EINVAL;
+
+	s = strdup(str);
+	if (!s)
+		return -ENOMEM;
+
+	p = strchr(s, ',');
+	if (p)
+		*p = '\0';
+
+	ctl->ctl_fd = open(s, O_WRONLY | O_CLOEXEC);
+	if (ctl->ctl_fd < 0) {
+		ret = -errno;
+		pr_err("Failed to open workload control FIFO '%s': %m\n", s);
+		free(s);
+		return ret;
+	}
+
+	if (p && *++p) {
+		ctl->ack_fd = open(p, O_RDONLY | O_CLOEXEC);
+		if (ctl->ack_fd < 0) {
+			ret = -errno;
+			pr_err("Failed to open workload control ack FIFO '%s': %m\n", p);
+			close(ctl->ctl_fd);
+			ctl->ctl_fd = -1;
+			free(s);
+			return ret;
+		}
+	}
+
+	free(s);
+	return 0;
+}
+
+static int perf_control_open(struct workload_control *ctl)
+{
+	int ret;
+
+	if (!workload_control)
+		return 0;
+
+	ret = perf_control_open_fifo(ctl, workload_control);
+
+	if (ret == -EINVAL) {
+		pr_err("Unsupported workload control spec '%s', expected fifo:ctl-fifo[,ack-fifo]\n",
+			workload_control);
+	}
+
+	return ret;
+}
+
+static void perf_control_close(struct workload_control *ctl)
+{
+	if (ctl->ctl_fd >= 0) {
+		close(ctl->ctl_fd);
+		ctl->ctl_fd = -1;
+	}
+	if (ctl->ack_fd >= 0) {
+		close(ctl->ack_fd);
+		ctl->ack_fd = -1;
+	}
+}
+
+static int perf_control_write_cmd(int fd, const char *cmd)
+{
+	size_t len = strlen(cmd);
+	ssize_t ret;
+
+	while (len) {
+		ret = write(fd, cmd, len);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			pr_err("Failed to write perf control command: %m\n");
+			return -1;
+		}
+
+		if (!ret) {
+			pr_err("Failed to write perf control command: short write\n");
+			return -1;
+		}
+
+		cmd += ret;
+		len -= ret;
+	}
+
+	return 0;
+}
+
+static int perf_control_read_ack(int fd)
+{
+	char buf[16];
+	ssize_t ret;
+
+	do {
+		ret = read(fd, buf, sizeof(buf) - 1);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0) {
+		pr_err("Failed to read perf control ack: %m\n");
+		return -1;
+	}
+
+	if (!ret) {
+		pr_err("Unexpected EOF while reading perf control ack\n");
+		return -1;
+	}
+
+	buf[ret] = '\0';
+	for (ssize_t i = 0; i < ret; i++) {
+		if (buf[i] == '\n' || buf[i] == '\0') {
+			buf[i] = '\0';
+			break;
+		}
+	}
+
+	if (strcmp(buf, "ack")) {
+		pr_err("Unexpected perf control ack: %s\n", buf);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int perf_control_send(struct workload_control *ctl, const char *cmd)
+{
+	if (ctl->ctl_fd < 0)
+		return 0;
+
+	if (perf_control_write_cmd(ctl->ctl_fd, cmd))
+		return -1;
+
+	if (ctl->ack_fd >= 0 && perf_control_read_ack(ctl->ack_fd))
+		return -1;
+
+	return 0;
+}
+
 static int run_workload(const char *work, int argc, const char **argv)
 {
 	struct test_workload *twl;
 
 	workloads__for_each(twl) {
-		if (!strcmp(twl->name, work))
-			return twl->func(argc, argv);
+		struct workload_control ctl = {
+			.ctl_fd = -1,
+			.ack_fd = -1,
+		};
+		int control_ret, ret;
+
+		if (strcmp(twl->name, work))
+			continue;
+
+		ret = perf_control_open(&ctl);
+		if (ret)
+			return ret;
+
+		if (perf_control_send(&ctl, "enable\n")) {
+			perf_control_close(&ctl);
+			return -1;
+		}
+
+		ret = twl->func(argc, argv);
+
+		control_ret = perf_control_send(&ctl, "disable\n");
+		perf_control_close(&ctl);
+		if (control_ret)
+			return -1;
+
+		return ret;
 	}
 
 	pr_info("No workload found: %s\n", work);
@@ -1486,6 +1664,8 @@ int cmd_test(int argc, const char **argv)
 	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
 		     "Run each test the given number of times, default 1"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
+	OPT_STRING(0, "record-ctl", &workload_control, "fifo:ctl-fifo[,ack-fifo]",
+		   "Write enable to the fifo just before running the workload and disable after, with optional ack from ack-fifo"),
 	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",

-- 
2.34.1

