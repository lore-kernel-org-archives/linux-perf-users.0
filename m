Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7E3EFD37
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016042; cv=none; b=Eha+mHgbPUou5GSvRLz+Q+W0rsSL3dCtuqFjvWEgMLv/uh4uDeEJtEIs00wwI/YteDI86ekCGUMhs+4DoLFK+LveLKO46WLQZDAS5xRKzwtp5RSMeFW3Sp2dmIINdbO/cDtqaNjIoRBrwm8LjIS3mL/Z8j1UwfTZ6LUabS86uVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016042; c=relaxed/simple;
	bh=zBP33YW94/R1hHZYuHZFRO5gh0N+cAj5cBmAyLWmp6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utADR3lOmmVoSnQMuwK7AjXNV37Oe7lpYOhWkzkrG01cyCVpnbfoqVLkX2A+365l3nYmpS4gfgHt6HQZWEEvqID+t8bOSP029T7Yn2bq2QLsr82dc8mnfT6TWk5YKMvAPzG10wv0PQm8jlvIPFIW6ktghLXgqmH9mq/7T0GSf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ON6/WnuJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ON6/WnuJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cdae130cso15249515e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016039; x=1781620839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2h78YxBKDueLh+9yt6/S9EMI77LVr/N7bEn44d3CK8g=;
        b=ON6/WnuJ+egoWFBEjRQTvWu3qxjBCxHJv3TEjg1K18U7ejrhN1HX3GZ96GNanYW9vZ
         OgsCLf4J5AmfxBRqwj8YOK+CirU1Xlfr+PKkyshS9w24R0TpL8kgTMqrOUVa9oNzPN8M
         YjRDFN8IPjok3sA1aIO8Ia6DE3XN3PFSWTiZEu3L0jSoTQIfGUT3tZa6NL5lNwUX9E7c
         yrNBezgexByfDAYEUF2Pi/JxrTyeYIN5O22ou8bz1oS1tTj9xkfOwnoVFGuSysHA8suZ
         z0652kZm0jk1VF3Q5UXmjzbaMKBHvfVKUVTtdSsH0Y/MkmZiqqndTWuJTflusNLwi7Ir
         frpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016039; x=1781620839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2h78YxBKDueLh+9yt6/S9EMI77LVr/N7bEn44d3CK8g=;
        b=plUx7m4+fVFYpHXN++rcmbMpxhicc93L42ClWH7ewn4eTw5vMaGYT4MthXMt3y5URl
         lKZrmnj5JOphePXi2LLNpzyE6n9v7fMK8CNS9xeFaLjoghJ5gslIjypYvvwFxxfM3Ozl
         NO8Q7DW0qKFmrdf8g6Z1Apw77AhP83R2Wenk0YcxDs+ocYQf9Z1NWDN4wtcb0bWZkf85
         gUMMYdb5zO4I/8xHIMEWcPppvxlQWNSlVTNeZxrd4jbP5wnAwj5E1fbWHYRMgCcknAGh
         fNcRpwzIU8BVxxvewoBK8wUejUhg7Ow5suYXSc8+1qW14WroV7t4DYTFvWzf5JSML4aX
         qhnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wfSlMkyoWg62PikB8kNIoUnscExJ9FVvaAnRkGKCZZS67DG3vQUEQKOxCf94P2GnznjgypHoUm/AGFx3T08IT@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHmij82/HySRGheaqKZtPVUCHiHOUIF030m7qOY7/ORjhPVB9
	uCxuGvwD9K3pQrC5zuK+aOB972JKGQcZpkSsvdmbBv2CcYC8tKq4ga3Pi337fs/caNM=
X-Gm-Gg: Acq92OEQU8mjLZ2anVRwQ8G9+3ApxV8368YSlntR5kT+4ZuL726uuj8ou5qlvJKmgDV
	bdAN3DPIPl+D5suN0Xo10/aYqU+D5w5IL+bxze9b8+q2kc61pMJvCBgnbL9K2BXOCRm2CIHwlhA
	UeSbwHtvFQitED3zysspWrvSqfRSEKWtUq1O2o+23uwEVEsYJPSFY1+V9HPCE4pBP2y9kNhyDVq
	CcqdOQwlYrav9AtF0XQg4NZheQeaGqQN8KiKpvv+s9XdNtOEO/U+t+Acd2reOCkoCXqyKUxG9WG
	5M7SO7oqfrTSGC4KVUNWaOZzWzYbLvl9gGY2dxYGuGfiOl3z4fyU0OoLpRndYjZR0q2l2VBYYq0
	xju+KhAO8K2DPg7fd5mzqvJu3atfgfdwsYT3tEtAWeC9Q5wApMQrhYuSXDAxSsoGgFwDJzSXGDv
	Yd7Qv0YnLHKwjhPP6OzOfeTkr6sVi79Hnj20NUUs0Gs6k=
X-Received: by 2002:a05:600c:8285:b0:490:b1b8:95f5 with SMTP id 5b1f17b1804b1-490c25c2ae1mr347668055e9.15.1781016039067;
        Tue, 09 Jun 2026 07:40:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:16 +0100
Subject: [PATCH v5 11/19] perf test cs-etm: Remove duplicate branch tests
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-11-d53a7d096a19@linaro.org>
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

We already test branch output in perf script mode, but then retest it in
Perf report mode. This is more of a test of Perf itself than Coresight
because Perf uses the same samples to generate both outputs. Also we're
already testing instruction output in Perf report mode.

Remove this test for a speedup. On the systemwide test also remove the
Perf report test because systemwide mode records a lot more data so
running multiple tests on it has a big runtime impact.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index bbf89e944e7b..39553702c1f3 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -52,17 +52,6 @@ perf_script_branch_samples() {
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
 
@@ -123,7 +112,6 @@ arm_cs_iterate_devices() {
 
 			record_touch_file $device_name $2 &&
 			perf_script_branch_samples touch &&
-			perf_report_branch_samples touch &&
 			perf_report_instruction_samples touch
 
 			err=$?
@@ -154,9 +142,7 @@ arm_cs_etm_system_wide_test() {
 
 	# System-wide mode should include perf samples so test for that
 	# instead of ls
-	perf_script_branch_samples perf &&
-	perf_report_branch_samples perf &&
-	perf_report_instruction_samples perf
+	perf_script_branch_samples perf
 
 	err=$?
 	arm_cs_report "CoreSight system wide testing" $err
@@ -179,7 +165,6 @@ arm_cs_etm_snapshot_test() {
 	wait $PERFPID
 
 	perf_script_branch_samples dd &&
-	perf_report_branch_samples dd &&
 	perf_report_instruction_samples dd
 
 	err=$?
@@ -191,7 +176,6 @@ arm_cs_etm_basic_test() {
 	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
 
 	perf_script_branch_samples ls &&
-	perf_report_branch_samples ls &&
 	perf_report_instruction_samples ls
 
 	err=$?

-- 
2.34.1

