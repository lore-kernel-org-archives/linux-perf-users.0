Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9D42EEC5
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015504; cv=none; b=OO8GjUPWKVr9gsaBqvAZ3pbSutRRPUzw0EQ9zczyInHMu6A0RYV8LhPuPfVdf3QZCf/4B+3ERiC8X863iXRgkxt2imVwAU6pw4I9PQSE4YZyIPcgqWhiGuWWuK/dffr4xv6kWCcorIR70CRK+fpq8/+shjkGy8HSjfUzwj0FU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015504; c=relaxed/simple;
	bh=ZLOVVoBWIvoSYAEUTNtbgZWHkQY4f1NrccmUuoSiPY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXdXastJTpPM0JfoeSLxVTRFTuEfLuJcsiKJE+I9c29VA2etEkYrJYNOsarPCNsznFEw0EEgsNOorvNN4eyWftxgB65XZK2aV39caK4G41fQiaU18huOzfOgykPvCDENfqoAv7UCwCbzDalGhaTustsN8AzsaEYQv7A6ahcVEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJc4VoXK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJc4VoXK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eeea039ebso2956890f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015501; x=1781620301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95NlgPR4KTlap0RZdRAD+2OgBeEJ40DU9UYZfVmgTrg=;
        b=tJc4VoXKQoN/xSJOe/qI80YcSob57wuDRjVsqcXyKlYHzESwxKgfrj1AW8Vs4yhY7t
         KQi/HfjJWrYGskt8QPsihL2AzPD8wLDEvOoTP+YeJsYCqVUvTX4hb7EUbRcVN9eU43kr
         /9+DZdVJmyHKa7eq6Zc43TSzIhqxdrCIgT3HqdM48z9ZJ4Lw7OkuEZStkLV6VmIDvqMb
         l2meEtc2+F0ccfo1gVppgIGQzUezNC9WUoUoQU0xjUJSW28oG3eoWYXpIcD7a6TyyvXw
         E4eBqouOAr0s6pTNuycvhC7GuebLqoyirmKhdqsJNkem9LQ4XTr7+e2AnVyDQpnr/JTO
         ES/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015501; x=1781620301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=95NlgPR4KTlap0RZdRAD+2OgBeEJ40DU9UYZfVmgTrg=;
        b=jqJNstkoIBmnE9av0ZW96AhXSsKLjfFQcaCccsiNEJKGvOwAUuyF1z55mb1NdkVMF1
         2np3LAAqnTsszhpjXQ7u8LlWfaUAWsY8s6hN0+hX1eB/dxFSJSDuL+HiXA91MA2tat+/
         zVzjxXb+WAj6VdluXyiEJINEEdRcpCWYhbFiJoA3hceOnX/SRyhD+zfc4/9sVFG/77So
         lyLoG4pAE6j4ZjNrJ/MeruUvdtCek1C7FVU1kSHFrn3X783yNnua59NpbA6qV7bHTD0G
         qGNx/uaCl7Sblh6IVYeJUnNxIXieJWIkI3to/yQaG/4Gfrolqz7rh4O+BlrSDpJqnNVa
         7dHw==
X-Forwarded-Encrypted: i=1; AFNElJ+nwcTVWzbKE7H0VnZiQAT2KuZvbMfp9oM3JYQoel5tgfV95cGEKxQevPVfCJMPZgupgLqP3ASHubl/c8gq8e6o@vger.kernel.org
X-Gm-Message-State: AOJu0YyfzSqxSMG5vUuqavOC1Vx9sJsoAJpyphXR5FxwO6hOJsxSmny/
	cfdf42q29S6TMX90XSOFF2eqDLKueQDj2ody/6b2smMUP2oEOKfrhmxKmtFUzQgPVfI=
X-Gm-Gg: Acq92OEvyQxqE0nBdllGT4keYq6ZzmwJQicVBDG+0Bx++RWmCkCYe9EDllR7yPdyHKg
	V0usf5SeJw5ay2fW/dcBcCwedNyE6hQHab1Jxb7FxrRvpoqB/mVEqK8BexvPj6rlcc6NlS9x12d
	x5rD/Tkg34gMXBNwEdVvM2C1jedh/uJewZagBp5EwPhTxFngIC5vqQNG/YMGgecFBmPSXLGp6Ip
	3huN6h8QGl6U5Ew/cevi3oJSH/h9lQzsmWAyHOBHqq/ApXYaGc0MH1yZT6z+cXCb7vSZHn4drA6
	04lPFvBCoHXUAZWgFtoO/SIXNvOHluVI8+ieztyN0s6vV8yRfm4qA4qwanp5h1Fa1gnfap6JKws
	kG4tWe6sJzAZH1DIMtKrLXzRcS+5D/VXzQRbLNgnE46ZaSB90sKg8h85xiHh/QlH9iOaaamb83q
	fnR+MzUAEVIB2RLxK8jG8qfNo62/ZLj8AKHkb9mQp/sTRfMwwJdYBCzQ==
X-Received: by 2002:a5d:4e09:0:b0:45e:ea68:523e with SMTP id ffacd0b85a97d-460304fe066mr25677905f8f.21.1781015500976;
        Tue, 09 Jun 2026 07:31:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:09 +0100
Subject: [PATCH v4 16/19] perf test cs-etm: Make disassembly test use kcore
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-16-44f9fb9e5c42@linaro.org>
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
index 339ae4831868..87797d239f76 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -46,7 +46,7 @@ if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
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

