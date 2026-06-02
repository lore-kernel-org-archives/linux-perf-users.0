Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9D421F1E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410459; cv=none; b=O/PXTBOhnz7nLgVYjPSI0Fd7j7VF48EaHtvI05YxaVIuq1tSjc3lwksFn1QI9wd2Jc3sJHvtcPTEPIIIsSmpwPZxtuuwp2FrmLRm4rE3Y9Yg5Gf2kAHatM7glYayyuAZ7V4g1JFXxr+g8iuSh6190lS18TAHThYKp5XNTfJ1VP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410459; c=relaxed/simple;
	bh=Vebm4GlJiLVnJYDjVjznOc3fuBf50TfDyVZ1u6hrZBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJUkW7pdkW3Rhanlx4a6acY/b0eC6+9C0CA4XK2GJf+Y9Ev2wYKMusawU35yeDkWVSwUhRa/buwGiWLvJFDt50Nx7RhgsNpr2GeNzexNZbQW+6csYJqJHFHogKPI2Eeo21XRNqIuJGxmdgIjYcsQVjcmvdcrie2k/lLm8iF0ozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gn/1KSMp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gn/1KSMp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so6021785e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410456; x=1781015256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+iZ6FY03jm4PeAHyOI8fNsNwbPR2PmNKt6aEgZZmgI=;
        b=Gn/1KSMpfaPFib1BMtiNIAq5FWuujj/a+uqMvk4FPZ1k9GL29Jm5SHO6ADyjzrc/j+
         Rb/C4LiCfnUFSEjDM9KThFdK4MVVb4nqRB8xe8y6tMEOiX5NmK16IsRtet+5kSvXnxhh
         2QnEqoKGLEbnWiCM+XfSxMk6R1bOt9rJ02+qHY7e8Dzp4hwZCYIfU9dg5bZYDnFGF8KU
         riUCqbZvA6otwRzjjZh5UBFjE5AflaScTyaHplThFgOqP9m3lHNpzxMv9RBgaCsrz6Xe
         +UhjAIx/nnD/651SD1pmPyv6UsamylvSMpvMPrnKsx67LCbdR6MhrewGjjNujMfdg17j
         QAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410456; x=1781015256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+iZ6FY03jm4PeAHyOI8fNsNwbPR2PmNKt6aEgZZmgI=;
        b=Zl/zm4m8pE3WJ1fz7AvFpDnmW+t5etTcW9Ff9rfDCe1Al4u58PTiFop9cXAZSh1DWj
         xtG2+Z3FNjyUJoCzs+JlIvmoi0yn5UV8Al734LDN9WvWXlW5gz1gdokWPX8HHkciaML+
         H8vu8GhiTxWTisVXNYW8oZm7vVSJlgSNLTpQ3hVCm3DPjTAQQu7cSkwUA9A4I/JxmykE
         sh9KgEPDYWYGRb2RnrLR0Alx7MCeGeOCiAqJuN4uZeKNpkKhmMqtFEnRYvzLpojY8U+V
         K6Jh3gNOdsWI99Nawl1xCts69nSPlLX0go7vl7MECkgUaoVRPN+Ddn312vcg0wigxf6C
         E70A==
X-Forwarded-Encrypted: i=1; AFNElJ/Cp63WxsoWCrfdRC7v5Oy+RDzSp5wcHudW08sZqncWmc9oG3LH9A1FiwGpNvfPPJhT5bJJZmrYyweZgAswB515@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcZZUcmTbKvwCsZhKI+yZ4wss6dE0Fr1Y47UOc09+JJDgQcdq
	lT4B3Er/p3gGZZT6cNvhCIwqUvNF0tM9vPAtd6Jbw/sRskXFOu5huOvv90J7B1iABSFwVuR0oep
	Gc+C/gt8=
X-Gm-Gg: Acq92OEG1JCn0RkhG+sjP6SWafmgUROEFhWMeKGbVJJDgM6QumO+ThkrrsQG+McVMze
	KBxRVLBeBhvxplB51QrW9/ivwZdBcn9dJS97EbTPNRyVtFHOtHH1n19GXYYcpN6NB784GYn+Glb
	4EIrzpsf3QHxgdFRKCuFL+LDCQYwCcZPBBjneKzczn5E/gn8OMDfvQPLwu/mMZTYkSn+aX1oIx/
	1IZ3cRzH/inTXmLScEnKCMx7238to5rP98IZVTYNxdP5yxNGu+49fNd4i8HIjfCnxKE89SgXo5k
	iaSvGTSeCqdChrFFPrUp8U6Jllp5zjUhYD9Ud+E4obM0IoEYXOdSbjlXWM0WYWHpxZ5GCuLBQDs
	koQsWgOG43DBZ1WoO9xvR6K6dg2Ul3VG1Yl4Htcq0H6AF8VJZcvzuglPzhy4C0XfnoleUIYKqRM
	OijH0bVAlCy0shu6F2zzODI6kP8sGOGRgizZdVLcFm/X0=
X-Received: by 2002:a05:600d:848a:b0:490:9d1b:f06b with SMTP id 5b1f17b1804b1-490a2943afamr206045645e9.26.1780410456096;
        Tue, 02 Jun 2026 07:27:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:57 +0100
Subject: [PATCH v2 15/18] perf test cs-etm: Make disassembly test use kcore
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-15-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
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

