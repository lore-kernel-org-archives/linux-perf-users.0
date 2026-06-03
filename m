Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9F4534A7
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481863; cv=none; b=N24bOcmkdVEKOKJS/Sxzz0RND8QdtXeI2gTUIiy8BpoTSWELDpLg4hYy3OC49fCUJmEIM/ZteqG+gBtDZBvs8TueRcbs07sRBladGBQADCPRdfGB6aghOYdiC4nr0+7hBZEeaKmxstp4bSTYakV5VdbUlpElGxE6SIgoHQ4Yn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481863; c=relaxed/simple;
	bh=Vebm4GlJiLVnJYDjVjznOc3fuBf50TfDyVZ1u6hrZBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVR4DpAbSUmDyvzns9mvxu7TrrTKX4Jz8jfrTqBv7uP2GOx2wxfNGYNesAEKQrSDD8vDqQ6XfDl5nCm4mqf3Nw1wHC+O1EeJQK/rUeDKSLB+4lQJytH/fWEX8yqt56Zg1NFEmHkM2JU5th95RhfERzwE16tqul4jnnfrNLMO9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/ftEwW0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/ftEwW0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso116635885e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481859; x=1781086659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+iZ6FY03jm4PeAHyOI8fNsNwbPR2PmNKt6aEgZZmgI=;
        b=T/ftEwW0pEl9jLnRfSiTjheoJsYaybkAD4Uc85R7oX26Fb4CC2j5+lGx9t/k++xmlD
         8uDStFHufFOj1xMdp4ugPk71FpBwsHBZ1J6XB1RrmR3SMqAP5mu/SU5j5nQ6YXEf8/6j
         gMg2T01bRrbnEPK4C+lam8v1p+OBeUSZdHX2Ehyzgpk2PN9NLURK5PjX/N8+KNQ4Zh08
         jduB8ScMgdrXltlQJ4/gK+tkFi4/fo6Tu8Su8rxKI5fvxrX3ReZahxMrFqCnELSoxWrx
         N/3LgsYeomoOGu9xa7EN4dXqlxpE5Mgt8gNeHJfQbQSrXMAosR7g8Y4CniqKhGJgZB7i
         q9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481859; x=1781086659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+iZ6FY03jm4PeAHyOI8fNsNwbPR2PmNKt6aEgZZmgI=;
        b=ZUTt2XVArjudJj2DAd5hyeBHRgNqI5NbNwTGqFk6q/24ZGxiBdXlQgFfkV1ItGtMI+
         7ESeiSMLwi4BD+rx+5rf0t3jDPuImJdJMVytcIlks0+Pfvw4pbIDevINeNExQA5UWUx/
         skEpjc9YOpqbydsbEk66jfPOuLS7+pDj2cFYBo9Gk13ej2+VEIsPXjo6w9YskmnpeHDL
         eIFMdyHk0nC1m5cTJZjyAjlf9j8wrZKYPA+OvBB+zMmT8buHpUmbbmVHsJhJKoSg5LaK
         TKqo0e0QDGcdXHmhnpmhnpccZHHdCSmyLb4AU8xRK1X+XsVe7AqYMszq600j2TICgMeo
         7plg==
X-Forwarded-Encrypted: i=1; AFNElJ+WYVAA3iTC1hoWkNUHYGpgcBM9E6TcuKmxrIL9pE5LrSQOA4mIXbXHzivSTq6mLaatJb2v5b0hbNl0O+WmmjHj@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMmWG0XYKK9lpiaqQJcQYcOCSrb1w8QyinJ0oQpjDUkl3nso7
	7DUa1eQehHSlX6rqZZC1DaORsbe29BVkNJKZwdXBqlDeSYdewWEnvWujE91ym+0ljU4=
X-Gm-Gg: Acq92OEKyc3El+0zg5zmglVchtyXLiRXIx5BQ0tkO3hAQBmyYLqFa4BpUnWfUx1wNf3
	zYoQSe/C0HR/3yeYA+Ql/Zamd+qMmt4WzN7ED9sQiCRQIjjBilTrv2Fq0rngAWLCBD6U1amTmrQ
	oTiUVTF2jaG4z8W4967yN428qxk26LLFLgOB29R3fev/e9nbcw1XfzSQH0kfdYuNQL5rQs4GgJz
	TpjXW07p9GxZ+wCGB6n7hUTL1bpzaW4410gI9988/uQEcPm5ElcHSkn0N/D1t6Zwk/oNiYNCKqR
	zzjhgMg9xcaD/lLh/pa52Ydt/bB7C+aySsaQKSzMKXryAes9TnkQ/G3e0lZxbv8T3d2Sf0oPU2K
	SZNiRmQjBjM/hA8MbJ1DjdTQ79v6XVgqUCKNHufQLpyQ8YLExngW15VyUfLpJ55lioJDos8vg/x
	wuxZ/74I6uawh4Hno9NdyOj4/M+izWg4oDJkfyebO2vDE=
X-Received: by 2002:a05:600c:1c1e:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-490b5eb137bmr45865975e9.16.1780481859388;
        Wed, 03 Jun 2026 03:17:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:20 +0100
Subject: [PATCH v3 16/19] perf test cs-etm: Make disassembly test use kcore
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-16-c392945d9ed5@linaro.org>
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

Hits in modules return empty disassembly with vmlinux as an input to
objdump. Make the disassembly test more reliable by always using kcore.
And update the comments to say that this is supported by the script.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py    | 20 ++++++++++----------
 tools/perf/tests/shell/test_arm_coresight_disasm.sh |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index ba208c90d631..8f6fa4a007b4 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -18,29 +18,29 @@ from perf_trace_context import perf_sample_srccode, perf_config_get
 
 # Below are some example commands for using this script.
 # Note a --kcore recording is required for accurate decode
-# due to the alternatives patching mechanism. However this
-# script only supports reading vmlinux for disassembly dump,
-# meaning that any patched instructions will appear
-# as unpatched, but the instruction ranges themselves will
-# be correct. In addition to this, source line info comes
-# from Perf, and when using kcore there is no debug info. The
-# following lists the supported features in each mode:
+# due to the alternatives patching mechanism. In addition to this,
+# source line info comes from Perf, and when using kcore there is
+# no debug info. The following lists the supported features in each mode:
 #
 # +-----------+-----------------+------------------+------------------+
 # | Recording | Accurate decode | Source line dump | Disassembly dump |
 # +-----------+-----------------+------------------+------------------+
 # | --kcore   | yes             | no               | yes              |
-# | normal    | no              | yes              | yes              |
+# | normal    | no              | yes (inaccurate) | yes (inaccurate) |
 # +-----------+-----------------+------------------+------------------+
 #
 # Output disassembly with objdump and auto detect vmlinux
-# (when running on same machine.)
+# (when running on same machine.):
 #  perf script -s scripts/python/arm-cs-trace-disasm.py -d
 #
 # Output disassembly with llvm-objdump:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d llvm-objdump-11 -k path/to/vmlinux
 #
+# Output accurate disassembly by passing kcore to script:
+#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#		-- -d -k perf.data/kcore_dir/kcore
+#
 # Output only source line and symbols:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py
 
@@ -57,7 +57,7 @@ def int_arg(v):
 
 args = argparse.ArgumentParser()
 args.add_argument("-k", "--vmlinux",
-		  help="Set path to vmlinux file. Omit to autodetect if running on same machine")
+		  help="Set path to vmlinux or kcore file. Omit to autodetect if running on same machine")
 args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
 		  help="Show disassembly. Can also be used to change the objdump path"),
 args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index 0dfb4fadf531..8b5c60a09012 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -46,7 +46,7 @@ if [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
 	perf script -i ${perfdata} -s python:${script_path} -- \
-		-d --stop-sample=30 2> /dev/null > ${file}
+		-d --stop-sample=30 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
 	grep -q -e ${branch_search} ${file}
 	echo "Found kernel branches"
 else

-- 
2.34.1

