Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639E364053
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481847; cv=none; b=RGAgbEwgCsD9GNyHmczvRL5YK5YHIh8RQClBjA++oHyhGvrTBMcut6FlCMpw9nESddy+BpYJgzJ3IBbk8zW+AksC2sZSDuss6D+LudOZZSivjS0OMfDZuD5rTm1Jgbu5kt1tGwZfMkP3lbz1m0tIEIW1UmCNgextPO0cGQTrQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481847; c=relaxed/simple;
	bh=aR1osBtg8+dXgkU8gRUvP5gNGrwRuwN2bVKWjW+bwQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYc1/uKbu/JDO7UT+d/vZM6mq0CY3bjO4jbtr6nzNb/1aG/cEu3imlniRH4LCNqoLJQsU5OMqPAfCaUuFLTapawdHMnxFOOpDObBIcEfRBl0xvT8S6l60+LR9NketUQmKS8CFWhCZe+nhSwYYGc10GLllghZMJ/wr74gVc3cl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OxC3VMbP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxC3VMbP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so20452325e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481844; x=1781086644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYNGLIkJZMjRjHk0hF9NSWbns9QHjdminA/Y/0E/C8I=;
        b=OxC3VMbPggN8D7Yu+AaHpOXTyB+kUpz1vaDZg2hjKHsNywfV0FlNgppYStF05SgCQq
         cc5Qx2OPRWt5ir6zV6xBRdtcWnLCtNrKeEw50gag4v2KIgNg/WdqNrEq33Ju0+9BPjPk
         9JtcgiICc8BiCi+BauXwB66xjrYnCgeApROGPj3J3rlx1gpftTB9BXRB8uD0fjDj8hD2
         cO+USv11uEa5UvpoYR8+17j/bonnPfVdGhv108kc0fvJk9pdlPtPVHr2Isow2fKtKrIa
         xtxWUUzid+YUc7Tz0WQ4yIB1OQ/OUa47coAj/BLk69I2RSnG7qGYXyKQF1lzVdanD8ZE
         dBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481844; x=1781086644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LYNGLIkJZMjRjHk0hF9NSWbns9QHjdminA/Y/0E/C8I=;
        b=SJMtFKObUPA7L8qWTwTsjxhaCe7A/O0b3Vlf+7nw++fw4+7QNSNFj3Jpt+WvNQ11pA
         bf/pZ+DARivsz6gC1G/4ONC352S6fPWNNF6v/o5dDJa0hM+YWPGjAkldA8MYrlMNt6wd
         ZaWSz7K7eNbc3EDRYtrZhpuRj4K1jlYORZh/5ORe1z8wMJdBW2j8CdWXXTM/hqtYH0Gv
         /4IocdIkUCIBHGnvU33okCn4o/767IfQA07q2ixbRohucDDKnZe/li3VgHPJn7FgtxHJ
         smVgIfU6H9Jn7j5qb5z+0aoxjr+8KVU3NA66Wxjzhb1ACE3ytJIcLnssFw0rmELg+ppH
         lygw==
X-Forwarded-Encrypted: i=1; AFNElJ/Zuo8Vbx62xfWcCbh838SbfrH/rbgXz+oBBTcUiVCWNSgDY5oG/Vv6KztLTfr/9bFPW4HOa8fl+A5ANMBCZI+A@vger.kernel.org
X-Gm-Message-State: AOJu0YzFk9XdylkBY/UgecCrGEv5x+cGt/4WxfCpp0xoD4c7OL9bzPca
	xzn+JOvuERqoeE3OWZX6grblLXLpWzhSnwI3k7UOYFs10FpD0vtccyhdwI+6lvUhzCs=
X-Gm-Gg: Acq92OGPWqHNDR3wPr28XolLapeFOg4ZzUhTD4WdrJQTkTSu/TvPGuQpoAuwmS3xHye
	2xxk8SZXQtArJasOU21ozWfkb9lAVUTCTujJHFtDwV+I9I0IOHsKp4BvhG7mceRtT+fZBkZ5GYY
	mN6JQG10VdJkSzqEj2nGpTUh17fGPQ0nKbQM744N5GQdEPmpydgeB3+vG8UHM2xLHRCHvaxJvAk
	ANWSKi1p1zq4ch3wo7yCyzbkE9kC+nZo3g6u9cHGvO175JNYtqwfOnzrwPX87E5wVALc7iWAngm
	3hp1rIXYs7yMo+fKxoBi+/9YnnLMNyGZ+/l/abpatf/C6HIrsQM6QK3ZzQ/tTa9UjJea8frGDgJ
	llvptW8RpZt2S+iKKcwSIuNb7OANbjO/QLnRpCiGWbSiZxrMr0Pp9ZRrAZWqK0cdZs4jgw7VUdv
	mnmy+lgO1qABPw9JDnddXIg68QX2b5jSyYsCdErstXbao=
X-Received: by 2002:a05:600c:4f50:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-490b5ea32a4mr51625575e9.15.1780481843826;
        Wed, 03 Jun 2026 03:17:23 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:06 +0100
Subject: [PATCH v3 02/19] perf test: Add workload-ctl option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-2-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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
 tools/perf/Documentation/perf-test.txt |   6 ++
 tools/perf/tests/builtin-test.c        | 184 ++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 32da0d1fa86a..1faf30d4a7be 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -69,3 +69,9 @@ OPTIONS
 
 --list-workloads::
 	List the available workloads to use with -w/--workload.
+
+--workload-ctl=fifo:ctl-fifo[,ack-fifo]::
+	Write 'enable' to ctl-fifo before running the workload and 'disable'
+	before returning. If ack-fifo is provided, the workload runner waits for
+	an 'ack' response after each command. This scopes the recording to only
+	the workload if used with 'perf record -D 1 --control ...'.
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index f2c135891477..a9e67d7da700 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -50,6 +50,7 @@ static bool sequential;
 static unsigned int runs_per_test = 1;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
+static const char *workload_control;
 
 /*
  * List of architecture specific tests. Not a weak symbol as the array length is
@@ -161,6 +162,11 @@ static struct test_workload *workloads[] = {
 #endif
 };
 
+struct workload_control {
+	int ctl_fd;
+	int ack_fd;
+};
+
 #define workloads__for_each(workload) \
 	for (unsigned i = 0; i < ARRAY_SIZE(workloads) && ({ workload = workloads[i]; 1; }); i++)
 
@@ -711,13 +717,185 @@ static int workloads__fprintf_list(FILE *fp)
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
@@ -799,6 +977,8 @@ int cmd_test(int argc, const char **argv)
 	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
 		     "Run each test the given number of times, default 1"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
+	OPT_STRING(0, "workload-ctl", &workload_control, "fifo:ctl-fifo[,ack-fifo]",
+		   "Write enable to the fifo just before running the workload and disable after, with optional ack from ack-fifo"),
 	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",

-- 
2.34.1

