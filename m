Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8512EACE1
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092359; cv=none; b=HCJ1DpB9rGB6b2q+++IcneZQpPrbNgLqhdK3riEWbTipA6HPgqLPpFiFP5xgppTZOLsSOKfaTlKcbiQGK9uEa/DD2snX/Cm9DNAND10v4lFR2NPAklvxrQSfMfloxSZMR9B6tslElYtqRNKdRdF/NwXG9SEvGCZHlKUbKd89SYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092359; c=relaxed/simple;
	bh=eMGWrGU1Pq3EgL3IsVL861cKyUJJW8JuQmi9Pj8xfdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THjDJL7CuqYEq8QbtVBmmM4hHgWHJ/akgFoJiuZ1uXaLMle6d9MATG2qELK9G7ylpUOvD7vZ780fsdrUjH1QyQNbEh43YKb9EBwgB+VTWvBQb33J5xLu7lN9obQ8JWgT0cup/nKM+K86h2RXCc/1VycAAjVh66AD3ruF29eGN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVhG9ttr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVhG9ttr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so59507855e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092354; x=1755697154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsrMomRatGKoksxv3BcDep0KoaZwE6tn7JLahTJYPlc=;
        b=jVhG9ttrNOaerJo1gcfZkxy6iWNVmEWW1XjJIAVY3C6Fd8z0YF++boZtlalneAslIC
         LzrNEkQ9R8vgVlfRdhadlNz+/UwHzeRgGv/RQICjS6oxa4aiSjTb4Kyy2hZ2cCWbzATw
         K2IKDTTaRoSb672nD/QbNPmpbSgVT09mKECd6xbp8ZuvM3qBhmWP1Fh6Mqe2lQuQieqP
         H7qYc0dJoglyFuAfVFbexUbmPwGoxElmYcWm5S5L/iL7zvORHR2MwrvMyAXGQVwi/AWC
         IseY1mQSrXT5gbzVx5LchhW5DLV08sDrDX2LFvYz+ZHd6IiMZ05FudUtKZ0FYumnZZT1
         AzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092354; x=1755697154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsrMomRatGKoksxv3BcDep0KoaZwE6tn7JLahTJYPlc=;
        b=wVjQDDpG3GySnDagoWcU2N3hfXm8YsOSygtbRxaLqKUMp0IYWbsZNukMA0Cu0uLmdM
         Qpni6fMM2BftQlakBGtVU9FAcYN720A15voHXkUK+TXOBUjDySEEH8Ltt7N3aQvO0kq7
         Lph+6RAZZTYntaA9QbNHueDQ+w5MlXbhRWKvwC1eHkCtuUOKrmAwYFnAZCk5rRilH8f7
         HVxL2+bHsFY61T2Tu0C/nylhKxsBe28/VRZRbPkyceFEHnS6xftnBE3+FBKS30xt9I4Y
         MT1Dx8R/X34to6V+gNDt+VdL2xsG5+eHJ9v8JleyzMfxhnIq30RM3kRI7wT+qzbAZgGJ
         IJPA==
X-Gm-Message-State: AOJu0YxNv4jjsU/a8lRg+7PraWsMWJFkkfvdr5wQij00vYiAmGRxuO4I
	n4k6ayZt2ez4DvfSw0aRFFKYctSpTq66snLojUM09HQ/bELR7qklyXKbczaZqKStW5A=
X-Gm-Gg: ASbGncvJyJkUooe9zCWxroc7857Y/+n4VqAtOmIqFl6y865oDPkqT2pdHyZgOirLLBb
	UZyzQ1JAFFvUDoxliviffX8hR4twzzPyTEm753Zw/P5tmuAxs5UeUnvtogRQ/S9MBLFwZrAfcz8
	rg547JELK1EksgVZKfwq4+zROyg4etz2JEjOhuQrGx6NLVFqWUmRJ9jHljxP9n6kaO2Eae6c0gM
	QieXEM8gpSieQGGvgUSaNvEafBbInIcy8Ac1G1d4jQKuACUNZZ1GksfEmQkuw4CWoHqMKJPcvzN
	CXkS6VP8fHjvpU1F4XGMfpVo3Cx3rNWxqXoAmZqmrn6c5piGrcwDiwfPU0UOpla/ZA7LUThprTk
	jvDvdorMgf+rsYfcujYM70HXL+SH47Xs=
X-Google-Smtp-Source: AGHT+IHVIhli+aqqVXI0G6Xjd/ZZnNQlJsxxmc5F7uroaQCRzsfsyiSwoF8oJK58CA523uRNRDvk7w==
X-Received: by 2002:a05:600c:314c:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45a17258921mr16333275e9.2.1755092354124;
        Wed, 13 Aug 2025 06:39:14 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a596280sm2559145e9.28.2025.08.13.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:39:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 13 Aug 2025 14:38:49 +0100
Subject: [PATCH 1/3] perf test: Refactor brstack test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-james-brbe-test-v1-1-76a0144b73fb@linaro.org>
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

check_branches() will be used by other tests in a later commit so make
it a function. And the any_call filters are duplicated and will also
be extended in a later commit, so move them to a variable.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_brstack.sh | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 9138fa83bf36..46e5aa9ce8ee 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -34,6 +34,13 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+check_branches() {
+	if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"; then
+		echo "Branches missing $1"
+		err=1
+	fi
+}
+
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
@@ -55,11 +62,7 @@ test_user_branches() {
 	)
 	for x in "${expected[@]}"
 	do
-		if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$x"
-		then
-			echo "Branches missing $x"
-			err=1
-		fi
+		check_branches "$x"
 	done
 	# some branch types are still not being tested:
 	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
@@ -101,14 +104,16 @@ set -e
 
 test_user_branches
 
-test_filter "any_call"	"CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
+any_call="CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
+
+test_filter "any_call" "$any_call"
 test_filter "call"	"CALL|SYSCALL"
 test_filter "cond"	"COND"
 test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
 
 test_filter "call,cond"		"CALL|SYSCALL|COND"
-test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
-test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
+test_filter "any_call,cond"	    "$any_call|COND"
+test_filter "any_call,cond,any_ret" "$any_call|COND|RET|COND_RET"
 
 cleanup
 exit $err

-- 
2.34.1

