Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B81C5F2C;
	Fri, 13 Jun 2025 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785825; cv=none; b=Nqb8E0oNnE/nMsMwd9cRep3kfTh6L/WklhEwMET6ZdBTchRjcwjK1q/dc1T4ckbKjgbS77dw6aBeQwvlfeGiDy23xf4VCB2GvJAhNpBc7c+54bEC/45h/Gw9CPZ+TOp1wn1nbbFJWn3o5lchDq0pex1fuRB/ZLXyzymK2GKUpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785825; c=relaxed/simple;
	bh=wNKMwlFkVR1w4IR5EJhRljPNniCJa6HZfnDC2dnCNAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h34RLKZpcp0/81JJCOIMIDRcGmMljJWMw7L+cdR1wq0n2jANS63DHQodpg+6UW+rQg59RbLsmsvtFq4tAdvUvbTl9XhqqEBNEoTOYB2sdxkiyTEEbW686pDRgcRp06orIQcZKrYznqmLVG4SZeQymPt8FVvfJBFZPQi198dubFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEdP7HO8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEdP7HO8"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2fc93728b2so1322615a12.0;
        Thu, 12 Jun 2025 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749785823; x=1750390623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4u4RmDCaFqCXce9oSxwMeAVYPY052nOMNt31DfVJ+ac=;
        b=fEdP7HO82C+Wh3/kv3Winy6hG/Sbm5ZgN8Hx5AzD9yuJGLhq8Us7aWdaMs666KpM3S
         5ep3CzmZm8UqJDIU3RNRfRCcIM1/UklSdzuY6E4sS1EVgwfa+WKfeI0uc/AcjFhAAzoM
         cRETUUvBndt5y/ZRehF65tMM4XZwoSQE5ObiXKNHKTTE5ckkO4l3C5WtaJfeefUfQPmw
         v35FXrW7uuxrsJqN6YxDdkSrwvoNkjIFlroZUTS3/JvI1t+SOeNclPQ5diJ12jUW9qNy
         x/84RcCw4zPbuu7N+fhGK3isZB3+apO6MxSCN+yDCp6DUq2H6cfIbdsfHEUSNIkJag2b
         VdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749785823; x=1750390623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u4RmDCaFqCXce9oSxwMeAVYPY052nOMNt31DfVJ+ac=;
        b=MNu6phODrgn4brVTVLHJnVIWCdEn2oNjgEzHcN8UY/tE9k3SXV3+RP3Z0xAmC6zcO2
         uEaXfEovxX0Th0WO4yy95UWzHRy9tmiKvztSJ+3Wwdfs96vTDZ9sUqODpNy5mDwS+0Uh
         iwRsv0b+84Ns5Pr/YMqXwG83dj87DwLojG7tZ0ElG/TYabmfdn3UtXXTzFymFd2+iM8W
         vwaFT+70zWytK9bX1UDzH6JDGhp3+8HVVB7jAM5u3idRCmKstgAErv1j3oDEfcKz3o92
         BTQvKV9SR56PheO5xHWmIkJQGo6rAXeio/xYtOs3qc8pvwz7XpLblhvcvEQBUNg+KxHu
         jmrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj6UiSO8KyA9FxngPrgwEduHQoNcQMDR6fHEPm8IeakmaR3KA77o5PybKSxEeRMBF+Z6x1RIu/opDV+EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyNzT904bqIehhnj+uwVBxF2UsHr+KeUpPo1jiAqe1M9yZFyh
	FR3R/Y7hycDSDVQoMb+Y08LqNxjWfbD2aUkLNIsjcjTGZ72/2qhMkOKU
X-Gm-Gg: ASbGncu8Qc/Pwdr3XeYSJEe5Y3gNCw+BI8NU06e9RfKGaLoovrPpd+p/4ywUnHb0M4q
	uJMNgrgKTi4ZJ+qUmK48o3U92yioJ6DA+K6QVzWjT+Cx2cQ5jKxXx6BgsfQypIpkOFjJAyPim2U
	Ls3+hO4TzqGdydBl1ccwS1J4wiCRM9ffeN9TNofBSVdm5oTyyaqFcttPL2a8bscqQyRXBIKN7N8
	ggq72Qmy1DUGNWvGn3+IdFt4DIdfU/owYwsj3DFYQvABHDffF/xDeVDy/8sQU1Fr5xJo4ykXQCX
	lmCm0ZnLdinlFgFGGs81wd9wO4pNqnKFnDJprb0t19Xs
X-Google-Smtp-Source: AGHT+IFttDOPWPsjhIje6EHEtX+s/9DHzubRfrFbhH9LVIkOP2onLg/4lBspvLdpNlJqHk0gjwlNmA==
X-Received: by 2002:a05:6a20:a120:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-21facbc3512mr2008832637.6.1749785823157;
        Thu, 12 Jun 2025 20:37:03 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::f55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168ccafsm469267a12.55.2025.06.12.20.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:37:02 -0700 (PDT)
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
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH] perf build: Specify that spellcheck should use the bash dialect.
Date: Thu, 12 Jun 2025 20:36:38 -0700
Message-ID: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 tools/perf/tests/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2181f5a92148..26efc5d20f6c 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -89,7 +89,7 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
 
-- 
2.49.0

