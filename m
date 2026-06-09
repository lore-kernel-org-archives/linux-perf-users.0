Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E303403F6
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016030; cv=none; b=tVNCGK/VdVWQ4hE09dF1pyLgB6kTRnFYtP4+j5Qj+InE/6hAWK50Fg8h1AtBPvpKtEVMKDP3gh53JZ8l293j7pveiTrgpuxWU1iyxzOfHWCSNED8d/NVEt43IyWGTzIUg8VcVWNtngT3frhFDGIguMViINHOP98OfZJL2sgT5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016030; c=relaxed/simple;
	bh=/b18pfGcYG5J49852Uf/xpNRcW6fiySK2y+B7W3dtrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3jRYN3TtjFk7G2ww/cbrNl/yswa2o+1Ngy7kvFaXN5Yx5ViuZLzDwWdpdZnctUOVpHPsU0CO19VXr/huyFsjtJEyS29YLSriYTez+Mfdf04YT2ud6bHqHjar12ov2GEzuFc4vElxtVQSRogAv3GbLu0ckswEWHHAXWGweNR4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xVLIE3ON; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVLIE3ON"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4905529b933so60946005e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016026; x=1781620826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAiQptcYOlXy/icTduKx1v/eUqigIfQCIUFTgmuIVAI=;
        b=xVLIE3ONKnmphLnncee56OSAgPKTIIfwT5PDnm8TXvuWUM+EYWQgdfh+AwdCwQgZHE
         xp+1pGAgoNwVGqm9Fs7p/YILC01+DaR3cYsPTNdZWeV5VowiWHig3wm5YKyVlKO5S7tm
         Ym0t/r2q2Jj4lfI71wHzKzAx3Fidx5ZQUWYLVzbjR8kJLdWlUFvnGMG2lZG/hupXwkNR
         FxEYPeOK3G4qZVbTzewH4vUVoKnLG3NpRL4dJanXGuzSdZEOd6fwMC5RfImbXsurBJKM
         hXNjO//KVr+m9+KlyMSDGk3cifAbSw4hcp4t9UpA6NENx1TiVgN/ucxTqxunIt2r6fVz
         dung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016026; x=1781620826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XAiQptcYOlXy/icTduKx1v/eUqigIfQCIUFTgmuIVAI=;
        b=sWzQTlaznOPYP1+AxI+5FQqxgFhjhf7xsmhp9Qmv7Gq9g+hZqjJcNd5BlpNOY5MOc6
         TzfY4r78r8Le17OOissujC4vKIpQHBTUSUPQexCl2ESHffdKRqdmtrXIXQkqC4wi5+be
         anEJWwceiRIPZuYlZii8sIH391eTAKZQJ2tQgd/8SXC14rGbkIvYfBQpFJsVsJ0rrXcO
         qy7Hmm0knNUx72nVpqEzgcvrGNpgw54zi6sJ7+hvp8bhraazIcOo99Q4JsuPuVdXnGUE
         ooLE5hD2U5TXphVOcMHOnW+uVw1v+7/yWKMRGTX/gciM6Um3kbSPaNSSFwdx90FjdH0o
         BlKw==
X-Forwarded-Encrypted: i=1; AFNElJ8K8jMrXqwXY3YUdFMzDo5MFJsr5bYyiTV1IFYMzXvWJl+oeNzCTR0fqD37corDs9DTRNGymOFKbZQ5DZMFowPs@vger.kernel.org
X-Gm-Message-State: AOJu0YwuoSEocK2+truDmkvxJ+QSLjjB//WyB8J0vlyWStRv3Zd/7CYJ
	om81ZDpiKbAu2p4U6FtDExbfi+otTA+Vnnwm/R11MU+kNCRqQtXjhYGhu4/pcEXElio=
X-Gm-Gg: Acq92OG7tWtMN1ROiCONAyvyL6t1XhDQVJircNq6XqA5x8iWMyNNzyMTfWswbsDio6Z
	SGjctnQLtJQ3Zxg+/aXNgrxwiS0wbdqJAmXatZwrNBQRWMFIKp1QRWbXvPtqCt43nI0XNaU2xlV
	UY6i/bAmqb6CAYMyp6g7VGTeuau3LqNwPYuv39zR1zvCM1XRQMkdBocTjOjV9jTYeGPUtzG6bAK
	xTKNYBwb7BvofTPgTr/8G7jn7Ek2UyvjqultGVsAw9Rv4hWVGZKVQTvxKyyYVIo7GICVNTiEWz+
	UehGNVLdpPXybb0liLPZC5nwxZGjdLkVnDtIVRm2iE5Bw7qRplp4pL2sDqeDrlvY7kpoD2G8s1W
	5LGt/+kO5a+YHWHxNvudK3Akl0JhwuBtMlT0e5t5CYyLfztnKJdjX1kcXqvOS/nYgvIWCetEqyL
	vbDvjPsPCij3nnMSv+3HQCM5697flCpQ2o9DFMqLCk12U=
X-Received: by 2002:a05:600c:81ca:b0:490:484b:bf41 with SMTP id 5b1f17b1804b1-490c2560445mr297559445e9.6.1781016026211;
        Tue, 09 Jun 2026 07:40:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:07 +0100
Subject: [PATCH v5 02/19] perf test: Add workload-ctl option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-2-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
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

