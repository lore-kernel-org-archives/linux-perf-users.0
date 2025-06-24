Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F119C546;
	Tue, 24 Jun 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750743921; cv=none; b=uOo3BFC+G0Ukoyl1b/KH3thafUPETeXdCmh9PUH+2xW/hLwSHEOn90ljsS1u3d5shB8vuf9rhonrfmcCxRIbKD8hrz6Y09Y7HghdoAu78/aiYowLK9MM6J53jCmF/f3/0MMIy0z7S5lvsI4t6g4M446WzBl5oCc5gQpfZB9vXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750743921; c=relaxed/simple;
	bh=EtF+yaGuJF3j9Mq5cSGsIUOF6ix7MOFy5FzlzzWfoj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef9IfekUm0RLKY5CRZudCcvp7rX6sQL45U7IFtIOjiRQmJ88Q90HgDqPKQ7r+dwSz0tdHLnLh4HN4mP7wv7OwwnvdE/+D4poUPT2r8ATDbarRW3s0XmzEacgdSalbWrtLlgwxWjhg8zFq6Qbx6nxywxiW4ECzdNXAetgnIGRv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdsie3t4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdsie3t4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so63207b3a.0;
        Mon, 23 Jun 2025 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750743918; x=1751348718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgKsM416bqMqvI55x8cJU8L9NhSAKr4ObSXw0Ig8+pg=;
        b=kdsie3t4ScSvRu889ZN8yM7Yuc0ZzVFF4F7zXfJuGPBCytWvCxe00blZo4rO01Wjmj
         0xwde18yme2yFYN5e3Vk/mW47bI66yfxmVDe1G4cqGdz6QRFVaY0WDR3FXsv8fw6/qBK
         U5GETjtNMkvhayZlRz4yE1EfXSjmFo0ZZD6lDiMn0Atii9A0Fhk+8WpA8Y+T3HhROC3g
         J6esZlX6ozAw7oFrrFbLkYc2025rG5GS5i5+SPxiKbjSgPKhBaRCoAULpFHESSREFxb7
         netE8+VwkgKjreOxndOMxQmAll+iucV29C4E1Y0o+1sIrkVtqixO4Kjbd4i1Txhn5K5B
         3Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750743918; x=1751348718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgKsM416bqMqvI55x8cJU8L9NhSAKr4ObSXw0Ig8+pg=;
        b=tllI1qeJlssSASeUO6XGt2fAdbRrebnMFNFO339RlBnVZyPkSh0o1nJCLBlIN2bcxw
         xmg2nlB+Wnpn4xnAKiDl/wqcUEEAaoDrU1cTGofz0YX+T2K9tfzTUdH/NMsAaok/Tc9M
         kVZYMC9R082HpvhdattB84jd3smH0GY+lPaB4LevaFUC262smZ6G0aTqQE2Tey7BiBKj
         MsFH2TJxm/sNiAjKVQzk0xMjUcEDxpQqZjLYkQYTC/euSN7PsEhr0WNtE5S9lbVPBZBl
         wzWRhENlrrxLPERKuxyMz6J5r1W3tmyT5BiCBsS84QL5fPwm+HcOhF9ohXXBVqyLfVJj
         IYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqX9dFq3TbHCO3fXNUWg7qEo109UoAT3mgIIHP6CIpz4MsacD94ZdjYBtzpPFIaFXJ4RZF+1xcgVcV4RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaINfh7ac1BI7m2YoiCRuwrUHYRMgVwf+bx4qkL5bxGjKaIzJ
	OcKl1UXHY97xG/puXVj8gycQAaWR7kBMF9aznNh3JF6pFxs5iRyTA0Ps
X-Gm-Gg: ASbGncvGEY6mrp7GoVuYFAAXY3jODBYMd1I+bdrfG8X3WrTCDFG1EJCDfPGVUTp64zf
	LbVRAE+BBxDnMlFt89Bs78yp7oxO2e/UDhLQMcAa0ftWBglxfAwK37c0hyKblbifcp1EjnMndCV
	QObjDpMqmyOoyoHMhoIx821nLjTvqfNb5QpYysLX9WZLQwZDTxpq6GSrsy64uxqP7ldhC97+SxP
	sksuKo8Ct9vO77RFRVR1xio2xH7DukNIsAv1wmKJeIuDpdCXA+pTVZ3ordMIqRCPBjmXExDLVum
	B+L8bEIg7UhWCd6aRzJla498l4J+CLse5W5q17dO501ajw==
X-Google-Smtp-Source: AGHT+IG3Rra0nX5NHYF8B8AR9MpR4tQODldF3AUTaKXnR3BDdKdqt7fkp82e4BjwT6xJLYt7lAyJnA==
X-Received: by 2002:a05:6a00:2ea3:b0:748:31ed:ba8a with SMTP id d2e1a72fcca58-7490da69990mr20249511b3a.15.1750743917733;
        Mon, 23 Jun 2025 22:45:17 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::1707])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88548ffsm851518b3a.134.2025.06.23.22.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 22:45:17 -0700 (PDT)
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
Subject: [PATCH v3] perf build: Specify that shellcheck should use the bash dialect.
Date: Mon, 23 Jun 2025 22:44:59 -0700
Message-ID: <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
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

This patch adds '-s bash' and other options to the SHELLCHECK variable
in Makefile.perf and makes use of the variable consistently.

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
index 06107f1e1d42..b03cc59dabf8 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -73,7 +73,7 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(SHELL_TEST_LOGS)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a7..e0cf8db5462b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -252,7 +252,7 @@ endif
 ifeq ($(NO_SHELLCHECK),1)
   SHELLCHECK :=
 else
-  SHELLCHECK := $(shell which shellcheck 2> /dev/null)
+  SHELLCHECK := $(shell which shellcheck 2> /dev/null) -s bash -a -S warning
 endif
 
 # shellcheck is using in tools/perf/tests/Build with option -a/--check-sourced (
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index afae7b8f6bd6..d31a1168757c 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -10,6 +10,6 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 5e00cbfd2d56..01d5527f38c7 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -22,6 +22,6 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2181f5a92148..d6c35dd0de3b 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -89,7 +89,7 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
 
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index f50ebdc445b8..561590ee8cda 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -31,6 +31,6 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7910d908c814..2dfa09a6f27d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -421,7 +421,7 @@ endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(SHELL_TEST_LOGS)
 
-- 
2.49.0

