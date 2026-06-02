Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459040961A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410455; cv=none; b=Wf+j3on0BhuOMBSYE9d4NwbdLsByY/TESsrvSU/arpCcJOJsqS5TVTmX9454+TJhEDjgoQ8+tJTjfASET7UhQ6+JJohlNsaKeLczlYoPlf4YNunWPwI7JEXqHBavItZvssZXe1If35hue9KmFAgK7pzbzViQgQMqXYuNmhV4eqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410455; c=relaxed/simple;
	bh=9enISHoiXpOz8s2RakEzsEgzydQ2idPEqLuLbBe/Vcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpMKaCVBKfLIGiE6YenaSWdCKJbsk6xWQVgKszk/+k4E4dbsbrLYXBYBfCCY2mSMUNrXT5QLWq2ZOfyxDEZebrmZHBlaghpw2C5HR+ByfXb6MX/TClLpU3MmDUh0jebXCPIeDJr5poXflmWFE0Q6wSdBERD6jxqB9/uUys/jWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=anpQeUL4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anpQeUL4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso3650455f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410452; x=1781015252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LF0PDpNJdViJ4rDQR90Xrs3wAgx6it7cgbXceeXKEJ4=;
        b=anpQeUL4NbO22RoTXlywDuafpuenDkF6/ApG08KELM854ZQ1CZbVJ4nm6RUVHH6mDP
         2zDEgfmxL2OnGmthPRIv3uJGtFGSGn22dKM7R4lRSJjQQLWwZZttWKa/hPLVMLEnPadr
         zV4RDJQV8VXEwqllFiSSslUimgWhk1r1RyBgVqfHQ2HSOHVgU6gbSofEkZ+WnSu0hv1e
         a/YGSnIb5QIMbmxV69W7N7Go0glw0igu69rQT7mG2lAgjW9E7L8MGh2rBIBW5ohXfNoe
         Ro7fQBJD3gsgOm1wnvixOczqiVIXI9stFvPfcHMtR6qxVUT4R+vdFrCw+pNQikxU+qMC
         kSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410452; x=1781015252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LF0PDpNJdViJ4rDQR90Xrs3wAgx6it7cgbXceeXKEJ4=;
        b=sEXZ3CkPAsAAqpf1jDO1wOMDp/ccet/lQfsFPbNv0yg+E1jr/NjYTzLzsoptnAd01F
         3GBo+wgFa3CIybRdMo//w8Ip6UuO7pDIt3jlMLvda13mMNCfY+stwOot16K6cydMqDTN
         szRzB0S65ZT9yd5lYsVj/pYkayGlfKQBsQ6Bv9Z10LNP+lccZTuFXsaYAqX+CZd0f5E8
         ADW6LJBFQQ+sE8oNADNCJDjM5RknBmpEqr1i7MFqg4BYnvhtUaX39DZLQnW3ak2wdMIE
         28ClcFjysJqBBNRQ0XnD+FQA3ItotSplalPrkYnGfkUVEJG3BXETbYLB4OMWqCVoLvo9
         9YZA==
X-Forwarded-Encrypted: i=1; AFNElJ9zid0KITA1HWGA2Vdsal0qPJEGaUCC72ni26mb5UcMd4VJyYQHQ9Kt3vwQ5wgsQnqWIdyWaTg4FWD7B2d8C8W4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3Ox4xQJAH+klFZKP6SHJ7jORz4XlHuvs25tb28kPG6xQfYFe
	GmDQWAsEfzRfK2Xz00FyZCpEtN8nhvr9b2cqoA3TDTj2u/qOgTtxaj3BwpewAB1Z/5I=
X-Gm-Gg: Acq92OEWpHnAZJ/m5sjmdsGEqVpC2ThzDPnmTXmKb0uVXk3nFINkDey29WYojHVDXSl
	W/63q2HSkgJ+xGdiccxA+Bna95V3YXkaP+tLJRyyqptRF6o1hRVyGm95RG+W6FH4eMuuzMenT42
	3YWHJDKm1B+iD1IfN4AWLb5i8HVbiTQhNlDiakWxo3BEmddCinyyrhKV3rDqGY4+SnMvjYIoBRE
	pa+dDegu/Xiu0BljkSDtIjtUiON0WNqW1qjGrLNBiEpNhGJN5LByUNWFNAxDab+rTpJ+9dV9+dD
	sXVDZStuCay87eMuz3GgSKRmEal8XYrBDe10FOuGIayaLQ6RxJT1wVOdtXyvdKdsCb6UO3xHONJ
	Nd2aTIWe4UPNl/MCWIefZD5+pPP1IN64ddLDovTgyd3KeDqWi4XEipX7SoJdT0E8uGZcDDch4Qd
	GDGrvQ+Teb7kWx95KeNP+fm8WHEyjma6jGsZzCcDXX+ng=
X-Received: by 2002:a05:600c:c098:b0:490:50ff:7943 with SMTP id 5b1f17b1804b1-490a2923a87mr247378765e9.5.1780410452040;
        Tue, 02 Jun 2026 07:27:32 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:53 +0100
Subject: [PATCH v2 11/18] perf test cs-etm: Remove duplicate branch tests
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-11-85b5ce6f55c6@linaro.org>
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

We already test branch output in perf script mode, but then retest it in
Perf report mode. This is more of a test of Perf itself than Coresight
because Perf uses the same samples to generate both outputs. Also we're
already testing instruction output in Perf report mode.

Remove this test for a speedup. On the systemwide test also remove the
Perf report test because systemwide mode records a lot more data so
running multiple tests on it has a big runtime impact.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index bbf89e944e7b..8ed2c934c87d 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -20,6 +20,12 @@ skip_if_no_cs_etm_event() {
 
 skip_if_no_cs_etm_event || exit 2
 
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for -C and system wide tests
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
@@ -52,17 +58,6 @@ perf_script_branch_samples() {
 		grep -E " +$1 +[0-9]+ .* +branches:(.*:)? +" > /dev/null 2>&1
 }
 
-perf_report_branch_samples() {
-	echo "Looking at perf.data file for reporting branch samples:"
-
-	# Below is an example of the branch samples reporting:
-	#   73.04%    73.04%  touch    libc-2.27.so      [.] _dl_addr
-	#    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
-	#    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
-	perf report --stdio -i ${perfdata} 2>&1 | \
-		grep -E " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
-}
-
 perf_report_instruction_samples() {
 	echo "Looking at perf.data file for instruction samples:"
 
@@ -123,7 +118,6 @@ arm_cs_iterate_devices() {
 
 			record_touch_file $device_name $2 &&
 			perf_script_branch_samples touch &&
-			perf_report_branch_samples touch &&
 			perf_report_instruction_samples touch
 
 			err=$?
@@ -154,9 +148,7 @@ arm_cs_etm_system_wide_test() {
 
 	# System-wide mode should include perf samples so test for that
 	# instead of ls
-	perf_script_branch_samples perf &&
-	perf_report_branch_samples perf &&
-	perf_report_instruction_samples perf
+	perf_script_branch_samples perf
 
 	err=$?
 	arm_cs_report "CoreSight system wide testing" $err
@@ -179,7 +171,6 @@ arm_cs_etm_snapshot_test() {
 	wait $PERFPID
 
 	perf_script_branch_samples dd &&
-	perf_report_branch_samples dd &&
 	perf_report_instruction_samples dd
 
 	err=$?
@@ -191,7 +182,6 @@ arm_cs_etm_basic_test() {
 	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
 
 	perf_script_branch_samples ls &&
-	perf_report_branch_samples ls &&
 	perf_report_instruction_samples ls
 
 	err=$?

-- 
2.34.1

