Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7332ED4E
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016049; cv=none; b=iUTfiYWFBgttr+iOt/6pMubf1C1Ta3VymX7DSW+xp0IXVHVHHhTUU5lO2AMN0k/CRzYgWmfr2Rc742qnU6QZsQz5dL5ZRtv1iSEqUUYetVIvXwdVn5UNVg4PeVCk6CAr8r8qwS0sEOs7Wwg1UbD2MBuJ+BTg53Fbei0zdvzIqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016049; c=relaxed/simple;
	bh=ZLOVVoBWIvoSYAEUTNtbgZWHkQY4f1NrccmUuoSiPY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+w9R5gvdVogbCYEUM/QO99Wcd5HzZXFvncKAYrYFjw08qDtNLQgBSNDmuZWwhX4r/PFWfXq0BmjpE1ltfblHEujJ13Cu+2BuNzMt/gGMJaFM4vJFxgY9laXc+jKxH9ERzbqYFsXriFwYFkCHAexXO1PAc83d9wURM9gh9n3fto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RXiuRRIJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXiuRRIJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b64c8311so62877235e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016046; x=1781620846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95NlgPR4KTlap0RZdRAD+2OgBeEJ40DU9UYZfVmgTrg=;
        b=RXiuRRIJFB27yKNIWrzQg3UUHsV62VowcDfsm5th/B/dWC31LkFsgUKiEmX8mW8bUX
         p4/2EvohxxTtzXMIxh81pdApmnQS9MN0y317AyN2vMA5+qoX3P44pSgdQqkpbTH2owS5
         dkbzFk3hI2oHktfwTy9HnMjlqjkcF5iy2dNfeqHcVcXErMUec9DDNqzPNmIcJeEG7vOT
         ZBZhLJ3pesRlcnCRL9roDcS757fNqF3USYDpSQsNJUD/ySx7xw1g4Sxnjk5Rj2vGdJIT
         TTV3CNrbLO5j063hjt7PIS6kW9/CdZxq0Bo5tqXCeCn1l+di9NqEGip9oW8JKf0GHcmY
         8h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016046; x=1781620846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=95NlgPR4KTlap0RZdRAD+2OgBeEJ40DU9UYZfVmgTrg=;
        b=Y+zV0jYMVGR8rH0Ps0KHxPmpKbCEZ4GhOG8dyCIbRsM2ypthxyPZ8G+qU6Wv+u+2wE
         AN/wMpVE34eVvsnkSlNa068QV72NBEOoao63Q/SA9JPTql+lSRDQcDfgUgfZ4C+SWVjJ
         /JIyZv1XA30vUdjCCQh2F3JyYvOMA/jW2VlzyWtoiwoIKXTdUg6+5Uo/tYBGxxr4H98Y
         5EyTetowlk1zQ3NMZnfJ4JU2EOZFVKRvImzL/6Dh724IHpRqI5TdHUbe840ziVuzK5ZA
         YcX6vBWIR2HUjmblmw9VhtVuqZzY07Oa2h5+0536QJGwwYpxsC7xskljnz9FnYq4WeU0
         jwKw==
X-Forwarded-Encrypted: i=1; AFNElJ8YPd5Sd5R7pT7joYIrzQKckIiF2JcQiW+Vz2CgGZb0EatPQzlMt98kfzhR84L/aESqQ6s62Hqpb6FY2Y7tT6vI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UXWqdSmGRGzfangPaTF9BI7OFthZK04A/a6Q8xRTXuh/YZWk
	I9rf83dbIfJtNrjFSWMYQyAAOuw8QPdEmPDXHzy3WmYk5QqX5h6SSVD7dV4r5aHoF/0=
X-Gm-Gg: Acq92OEVOvYqlAkF8WWySDxoQde8wwKPCyu/Or23h64FBl7AYicpJUWykAtZbSJOPcr
	4kNvF8wo6wWA0yniRi3xt2gYEb+MgGvQEei4gp1gavJc43O5A5I8FM2tREOp8f/1cdy65iY+rwo
	c5cQoG81DGcsCRrkI9SzI5Q6pHLUrUtVGHkoPXKjRoDkL9+Y8ZVsW0dPD43mFY03bxG1xlbVYWv
	SqiyQo5eIBXpNyiL6RjYvX7eOhUvWKkkHsPJK/6lvkLP8KV+olaVmxG/DjoLlk3W+Nkr28o6mnP
	NnGhg1MDyHcq9+Ajtp472nhHRVdFGMHRwlYjPJz7Va9atzZZigxiX+0gQ1a6YQVuvPiuK/njV9k
	wiCorlwZHeVDL2KSlyYrPjmyKB+XCn9prR6MgZf2Gvdp/Odqw6+jfOKDh2k3kPmhy+s2ItA0CO8
	1jfKt38T2xMBaRPswNWYbJ59EiffoXT58r6//xGRx0kW3wjjBPuDEeMA==
X-Received: by 2002:a05:600c:3e0a:b0:490:b724:dbe3 with SMTP id 5b1f17b1804b1-490c25a07c4mr317921875e9.8.1781016045935;
        Tue, 09 Jun 2026 07:40:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:21 +0100
Subject: [PATCH v5 16/19] perf test cs-etm: Make disassembly test use kcore
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-16-d53a7d096a19@linaro.org>
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

