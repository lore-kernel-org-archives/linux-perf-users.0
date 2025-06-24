Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCD1534EC;
	Tue, 24 Jun 2025 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730786; cv=none; b=QavH9xqg6HwwMggsK5RRkL/yuF8TQhUiayfqOoDieCj8OsA9hVa2EwB/XhAdKwFoNJqJohzKG1qed14gMFZsFNpWjgaxjVa6c+Q++HxD54XZXTiWoXIxJg7bqULHN1l11OpHGTzx6u2Ui2Horsdl75FStQ6+yPRHtyzkxHsyuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730786; c=relaxed/simple;
	bh=GJR3d0+YakXgNTLXGF9wrmrDfF4LBiz/RLUft7VJtJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1yC+Hi1AoJr0k12zayKfw47tt8/RLwpG4LKDYxX5ODQRlN2OkyL3xiOk2SG79XAynm8oxE55pkQPcnEEKQtkcI56Xb89Ppp1nX/9KvnUifNbaMTcJtpnGh9guxBoSbdKUrkz3cybyB/cUaFmugxWyqve5oUm+zLl2DItmzwaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX4CkCWe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX4CkCWe"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fc7506d4so3797951b3a.0;
        Mon, 23 Jun 2025 19:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750730784; x=1751335584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rNITh+t2+x5/s2VvwZUC6lgwwyId84oh+/DyWcDpLQ=;
        b=EX4CkCWeslCVVuv8JfMdTzLXmefenpFFEIyx5Hn8EIPCtF4aKSQAJVSLv4ZEyYYEzY
         PfUV1UcqXaB5lPf52XO2lk8zklwGFVT7Jfr22SQNK3XYLv2fAu3Lga1D+TaWF3jz7v8m
         s0kItyubs5xmUE5QRr63ykxsux5Xgv+23B84f7QIemqiiOUGOesDmt+4/a+c2UNIyHh8
         A7UkFUB61P+bFGol1Lou/Gi5VRa1eWsPa2LYK7CjFswavV6bPfsb35iZHZYHbgL7/Iki
         Ood0sP7i+px6kek541HCJq4Ci5Wx2QZQP27gKq6eZEG+72X3vk6VyJykl2ui3NSYhkk0
         7q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750730784; x=1751335584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rNITh+t2+x5/s2VvwZUC6lgwwyId84oh+/DyWcDpLQ=;
        b=YyUOxHGvc3Fur1g78P/JjGJAtH6rPkmolVLKtqw/aR9H4WxYLFZF8oq4c+2bn3mcO9
         1cKTEqgdAk8ZkdQ2bwX89iYZ1o3H9IRM+NykAMbcb9vYqG1/HKFosXxiqsetK7V9eoDq
         9e6dtwklb7l1pa7RWq1MQVrqt4nvqmr3xRKL0b5fxrQKQ3bXVlbmO8WMapfnbhF+uqUG
         f/Gaw1eQ95QANOtJehblHIGn0gTrD108o28T2SA9umVZOZ09E3jFSyWzv5QdlMhqVioe
         H0p+c6gqEuIC2RHknzHEgBfKoSpZO4xLh5CdidMTo/SNIW5DgTK2U6MP5gB2tNGB0ODL
         1dsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6AQnNer7rwJjiUlafW40fgyNr52s08vxgg4+1uTuzjTkOWBKrRlj7EHVVIZLlLYl5c5cwoknpm12u3go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1BvL5IXeNjpqAopC8TPIOjaZDFIZC18FeffUZJ89Tanf504m
	+hL5dLSrXDX7r46do4JfvHOxFvX0o8sJiGIj9/DZBamsEbBms3LhEqVxGNWgTM1u
X-Gm-Gg: ASbGnct/32ZiGtQqqwZsA97cHFpO7smwNd08307SpjJkXrO3tnR1R2BPuJhbh3kdxb7
	34z/hib/+O2zxDK8tRwvWJ+bkInx6lRKO/QIXXdC+eCsadfUlFGnLk04WkV+TnYDh0E5JpM+rXZ
	zxyVYYBoVWu/poITYnD5Qo0qEfc81fhuPKfnmdB3h+GIEFOEyR5RFE1YPXbwGrMO+egP5jYym+W
	SVVOiMVYGtCfZY4qcCqdrVeGL0p2DAI45ierZAkrPqFiSVgxzFlHBrfcyHZyBsw036AhWLvLw8k
	TsDXHlVFtVRE2Mmz4nAgoP4+vtuOs5sxlB5BISMiqa5BwA==
X-Google-Smtp-Source: AGHT+IGsy7Ig8lWXfTAueW2YzrG+Z8KtttnEg3OR52aPkdhZSYLYLXM+0QeImPbjWOiNAdfgEhI+jw==
X-Received: by 2002:a05:6a20:ce4f:b0:1f5:a3e8:64c1 with SMTP id adf61e73a8af0-22025ea3dedmr23401214637.0.1750730783851;
        Mon, 23 Jun 2025 19:06:23 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::1707])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427e5sm7785395a12.50.2025.06.23.19.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:06:23 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH v2] [PATCH] perf build: Specify that shellcheck should use the bash dialect.
Date: Mon, 23 Jun 2025 19:05:56 -0700
Message-ID: <f7ea3a430dc2bd77656c50f93283547d1245e2fe.1750730589.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When someone has a global shellcheckrc file, for example at
~/.config/shellcheckrc, with the directive 'shell=sh', building perf
will fail with many shellcheck errors like:

    In tests/shell/base_probe/test_adding_kernel.sh line 294:
    (( TEST_RESULT += $? ))
    ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((..)) is undefined.

    For more information:
      https://www.shellcheck.net/wiki/SC3006 -- In POSIX sh, standalone ((..)) is...
    make[5]: *** [tests/Build:91: tests/shell/base_probe/test_adding_kernel.sh.shellcheck_log] Error 1

Passing the '-s bash' option ensures that it runs correctly regardless
of a developers global configuration.

This patch adds '-s bash' to the SHELLCHECK variable in Makefile.perf
and makes use of the variable consistently.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 tools/perf/Build                | 2 +-
 tools/perf/Makefile.perf        | 2 +-
 tools/perf/arch/x86/Build       | 2 +-
 tools/perf/arch/x86/tests/Build | 2 +-
 tools/perf/tests/Build          | 2 +-
 tools/perf/trace/beauty/Build   | 2 +-
 tools/perf/util/Build           | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 06107f1e1d42..e69665bf9dce 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -73,7 +73,7 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(SHELL_TEST_LOGS)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a7..6810d321ff73 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -252,7 +252,7 @@ endif
 ifeq ($(NO_SHELLCHECK),1)
   SHELLCHECK :=
 else
-  SHELLCHECK := $(shell which shellcheck 2> /dev/null)
+  SHELLCHECK := $(shell which shellcheck 2> /dev/null) -s bash
 endif
 
 # shellcheck is using in tools/perf/tests/Build with option -a/--check-sourced (
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index afae7b8f6bd6..71e2553e5af1 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -10,6 +10,6 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 5e00cbfd2d56..fd3af16f63bb 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -22,6 +22,6 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2181f5a92148..4a27fde30eb6 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -89,7 +89,7 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
 
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index f50ebdc445b8..727ce0a5c30a 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -31,6 +31,6 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7910d908c814..626a359fee1e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -421,7 +421,7 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(SHELL_TEST_LOGS)
 
-- 
2.49.0

