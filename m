Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002942EACED
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092358; cv=none; b=O41GHsu8To0vIXExn/507XpwMTMjkX5AGuexiHiwqIsl1UtvJUHisSMFfS/kdwDMKIAPW7jXysvLcYthcPXUrZmBAtQzS6Jj4N8Ss/Nihalc3TEiqGyXjlET2wQtIOJo0lT3c7AzEBLBl0kbUhmgoTtBhgdvqw7GcHdrA7s4Rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092358; c=relaxed/simple;
	bh=8IXJ4w8szgydeEsRIezTVodOHdHqDxt5F6vslQDwrEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ub4TA1wfQGEt+qlDhc7IdxhmwJdbUfskscgBTksoHIWMb4eF4nPeWUTvpHeRGtAvhJCINNYgi+fQiCBh/KaSUQ7I0XwB3YIFn32FoDVOEe3DwWkBNgGwvn47atOMm1kUILsPlLXMPBkGTkL4ls8y+Cwx9vHEiOXiCxhTRoS2Ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iq2gnyUl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iq2gnyUl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so59508125e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092355; x=1755697155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeStqnXaxy3QngS5Ia1n5mO+f7KQZ/BhVH2TpqaUklY=;
        b=iq2gnyUl7mkM8N3tauhLn3H9TxWZkUvQqwVokbMrY6m1U4y9QK0tj3zsYuQUpVTr2e
         xjwg/ff8rET2OAeCpu56SPzCmv3rLTl2Kk8oaNQRVcXmC3iGvay2XzebnR/lm4niBZTS
         B9ZHR5UKvxhTBwVf8TqG+xmCDe501++IzzQebMG8OP9FMcSd++Uw5N+531ZC2Itmv3Al
         Jd8jV5FzuTwh7xygFYfQ/rHdhpkoYzC+e34T2+DtipIzzyDVNwCGXfgRlDSVGOfL0ZKQ
         8ip9+q1cslA4CUq4o9flnh7f0Uc97tTmAGoq5LMQuIDwxSt1Kv5O73dSnbdWfi8tFuiz
         juTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092355; x=1755697155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeStqnXaxy3QngS5Ia1n5mO+f7KQZ/BhVH2TpqaUklY=;
        b=PXjKTWtVYoJO5cN/PN/0Ebj5egAMrzHnyYN1ETLskDN8EVnuds9LN5abHwKlzgv+Tg
         xhAm4ds7Fji5BNj3EGW4PYSs7d0mrk46e8K8gRmCdfFYpSjwny5MmrCAmmfRVomsN1K2
         WO8uHkqEk9Ec1ipxNjBj7LT5JE9U1YmVhqoPZVHriv3Yk7X43Z4C5wH9x0ksZehxYn0/
         5M+YBQw0kW8lGmAlSFVmkIyXMlxXVWMb8u0ZvzjPwCH7EOs6dXPgJbxVVtcqYG3ZIBno
         so1/z945UpFO4y9dyUIxmiWA2RMsjoJWTENvoANhtVNZXVPq+tvJL0cPKrbtCLQALqzk
         lG4w==
X-Gm-Message-State: AOJu0YxYnlD2lr3g5OU6J/wXJYENSYREy2IDPHRIruoWRfjQXOwZIOKB
	kwgeT+09ONxHcl5GOTVJX3Gi1yWRAxTou7NGtfilIJKbEKBdo85BR2aOA0awZlJhfso=
X-Gm-Gg: ASbGncve/iEXP9ngV0or5SV22bHxO1bupGXG4kHI2oOhKF5pK+953S5rG3RUk2E5UuM
	53o6jwZYqjmeCxKh88MUeGRG4/ORZCApB1IDUESNmdrxyi4Xkqf0oR2mmP5u2Bvu+34Sab4zCjR
	V2KzMP0PcWGMw0TzFk3j3BcBE8uCgtdP0zfCGCvvoICzaXOJfk4FR3RB9KzYRQFgtqg3p7LTEUS
	pl/hz34FZhUXUf3wyRhV4qprxdC+G7S/Kh/ZKDo3F8t862cODoawdX2+trP2nOYTe26U9rh5R6r
	9ScTj/rzM2zCb12TQRi7/CYU0DSUls5wQSFWLRN4MdJgN8NDfV1RJvl8QzwgDwazjS5o07JkzAw
	54e0uTlzDZZ2p/qAIg1XxxhaD77ve3UY=
X-Google-Smtp-Source: AGHT+IGiXArFsCsvNs28Mu9JVgeBLPfa1rYnkKC5It8U74TbonupuIcmTSAjOYs57oxdgF9sCrSLQw==
X-Received: by 2002:a05:600c:4750:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-45a165b7b22mr32838755e9.4.1755092355313;
        Wed, 13 Aug 2025 06:39:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a596280sm2559145e9.28.2025.08.13.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:39:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 13 Aug 2025 14:38:50 +0100
Subject: [PATCH 2/3] perf test: Add syscall and address tests to brstack
 test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-james-brbe-test-v1-2-76a0144b73fb@linaro.org>
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
In-Reply-To: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
 Adam Young <admiyo@os.amperecomputing.com>, Will Deacon <will@kernel.org>, 
 German Gomez <german.gomez@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Test that SYSCALL type branches are emitted from the expected 'getppid'
symbol. Test that when only 'k' is used, sources addresses are all in
the kernel. Test that no kernel addresses leak by checking for them in
the 'u' test.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_brstack.sh | 61 +++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 46e5aa9ce8ee..252d22d39c7b 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -64,8 +64,50 @@ test_user_branches() {
 	do
 		check_branches "$x"
 	done
+
+	# Dump addresses only this time
+	perf script -i "$TMPDIR/perf.data" --fields brstack | \
+		tr ' ' '\n' > "$TMPDIR/perf.script"
+
+	# There should be no kernel addresses with the u option, in either
+	# source or target addresses.
+	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+		echo "ERROR: Kernel address found in user mode"
+		err=1
+	fi
 	# some branch types are still not being tested:
-	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
+	# IND COND_CALL COND_RET SYSRET IRQ SERROR NO_TX
+}
+
+
+test_kernel_branches() {
+	echo "Testing that k option only includes kernel source addresses"
+
+	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
+		echo "skip: not enough privileges"
+	else
+		perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
+			perf bench syscall basic --loop 1000
+		perf script -i $TMPDIR/perf.data --fields brstack | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		# Example of branch entries:
+		#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
+		# Source addresses come first and target address can be either
+		# userspace or kernel even with k option, as long as the source
+		# is in kernel.
+
+		#Look for source addresses with top bit set
+		if ! grep -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+			echo "ERROR: Kernel branches missing"
+			err=1
+		fi
+		# Look for no source addresses without top bit set
+		if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.script; then
+			echo "ERROR: User branches found with kernel filter"
+			err=1
+		fi
+	fi
 }
 
 # first argument <arg0> is the argument passed to "--branch-stack <arg0>,save_type,u"
@@ -100,9 +142,26 @@ test_filter() {
 	fi
 }
 
+test_syscall() {
+	echo "Testing syscalls"
+	# skip if perf doesn't have enough privileges
+	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
+		echo "skip: not enough privileges"
+	else
+		perf record -o $TMPDIR/perf.data --branch-filter \
+			any_call,save_type,u,k -c 10000 -- \
+			perf bench syscall basic --loop 1000
+		perf script -i $TMPDIR/perf.data --fields brstacksym | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		check_branches "getppid[^ ]*/SYSCALL/"
+	fi
+}
 set -e
 
 test_user_branches
+test_syscall
+test_kernel_branches
 
 any_call="CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
 

-- 
2.34.1

