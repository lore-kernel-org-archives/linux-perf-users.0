Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9917083C;
	Sat, 28 Jun 2025 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751082111; cv=none; b=X+yMYOML6S4LOGdoYiwDinTgQexhYBfo/DOL2GYp0XCZV5lzg3LJ6UOT8Y0vq6mEo8SoRmhWroVacNMNHHqVZ091mzZ+O2ZiYF7lTdAQa1kL/YZ02H61+hObRb2Q2THrqwlQhBIq9ZXljJ71TIO15fy+KwyvyIlKkh7Ofh8Lvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751082111; c=relaxed/simple;
	bh=GvB7lXPZ3/uD7ikZ3m67zGjjXQSFyq4II/d2dF4Iwp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh74CZj6+w9EMpKVc5Xbg6Wz2NMzd7cswIZJXbwgpWbs1H+OdSH94Q2Gnyw9+WR8lF6qst4dh3UU8UaKRBQsrjcdETt85KrR6YF9qQ6e71WHyMyf3AaihqOiJAIHBn/llW9WkfvkcL5sfMd25a6x85K+fNtMbeV6AudG+GvRHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYPv1tDT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYPv1tDT"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so153629a91.3;
        Fri, 27 Jun 2025 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751082109; x=1751686909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITI46JKoYa9kNACs4xK7L8tapUmB5qutTOhPb1kBu58=;
        b=AYPv1tDT4L4JnxDvJwOLvXDBJ7prNk/Azq2cKRZx2Cx7jGSV0pqTf88JnEBvKkxRQ6
         EQJ3lnUxZcTDl4IlAo9lAX1x7+IpEO1BH0kPIzraR0wUZGDExifLuO553UtvbNcZonc/
         VIWZW8GqugKr2PkRh75fyhuT7wHDHOAmBCPs/XBU1jc8GWP0uAIIInba5UEWbQsvPyMA
         H/rIiLSD94ecv66qj63ZfXY5RccHLf6eBzdDQMV7iUsK/PFVQ2Wv2FPaNY71pytBw4QC
         uicOohpWveoAdI/I8f7JsRMwWYR/DDflxgfIJOSZCjZatIjx2GsIao9tsB2e9aHhcsyE
         Yhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751082109; x=1751686909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITI46JKoYa9kNACs4xK7L8tapUmB5qutTOhPb1kBu58=;
        b=OleBE4xBioyjfB6Ord7AsrrWIEXD+jZ7Hk6PMlxmha6hr8pp5KSCTAG8j9qvi3rpS8
         FzcMu9VfUD7XXi8joT3Ig0WDE8ppghC9L33UR4gtk1N9kHZFYVOVpLVaiP8qVN0Gx6WC
         bIDAmpvZjWhUsxDKxM0h+85xiFT/K1xEE3tG4jGMdgGPGnvddiyQ9aU3h5QGjR6NOXI4
         1MqFbjZSoRtS0tc2s7AFUUBFZHAUkwBE+omxKxlwyrtpu1mpxuPYR3IGOeNqXk6wqUcv
         xdWLwLHEURFODc4GlDRns0YdRlO1R5eXP+6/7BvdxJCgsejD1/ey5pUPlKNmEAWDn/U+
         z3FA==
X-Forwarded-Encrypted: i=1; AJvYcCWcA03qG+c2KDoN5I+euXVxd4cpw/+Tp9hhYZHsLU663nJtokUM++oarciBufPZNlcT7yV0ZXG2Hiz6FCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7v02LEc11LB+/OaENz5Ci8b5LmqX6cfkTpYKdeil4F0tnO5x
	pAuJhW5uhrOyNVEf4146uAWJ2DtoPIadJQCGM9XQWNrYdDgUlgM77w58
X-Gm-Gg: ASbGnctZf6kmt5BCf3Nid2OMYd6FIFjRJ5reW40wFLwBflKTku+IL/pf4v2YBVEFHcV
	JCsYom5o+LMxgv/vJgYaI9ZWgeZwMhKK0WAvS5EWzEgfMXUWOTSCn61KpjlcQqAG3ZLQm2vfpaV
	ISlNgyOygTkuKmNWcENN/eCFjPKyuIWUgB9AhuhT6ttTPpl8VnVsAcmNDCvOh+8ehIqrNKfOgie
	m2WPUXf0XsgidM+m/bXox6UnmJOBnXwsMjwOTQDz19Nl1GV+zLkpviVebyqylkPuwnRQuNI4tPK
	tKdZV5WWIqsFz1DOlKNE+CE33r9QlWih6A+rM1HHmCM=
X-Google-Smtp-Source: AGHT+IHOjIlhy5OfnUvSmB05mm9Jab+FHEn58OQ3IkXlkLmtL0NQNxuMpU4fBkNpTizWNSQ5obwjVg==
X-Received: by 2002:a17:90b:17c6:b0:311:fc8b:31b5 with SMTP id 98e67ed59e1d1-318c9225e5dmr9255204a91.14.1751082108670;
        Fri, 27 Jun 2025 20:41:48 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::fd7d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5426be4sm8251150a91.32.2025.06.27.20.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 20:41:48 -0700 (PDT)
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
Subject: [PATCH v4] perf build: Specify that shellcheck should use the bash dialect.
Date: Fri, 27 Jun 2025 20:41:25 -0700
Message-ID: <63491dbc8439edf2e949d80e264b9d22332fea61.1751082075.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
References: <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
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
 tools/perf/Makefile.perf        | 2 ++
 tools/perf/arch/x86/Build       | 2 +-
 tools/perf/arch/x86/tests/Build | 2 +-
 tools/perf/tests/Build          | 2 +-
 tools/perf/trace/beauty/Build   | 2 +-
 tools/perf/util/Build           | 2 +-
 7 files changed, 8 insertions(+), 6 deletions(-)

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
index d4c7031b01a7..5f76c82e0aec 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -262,6 +262,8 @@ ifneq ($(SHELLCHECK),)
   ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
         sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 060), 1)
     SHELLCHECK :=
+  else
+    SHELLCHECK := $(SHELLCHECK) -s bash -a -S warning
   endif
 endif
 
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
2.50.0

