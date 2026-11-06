Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962121;
	b=mMso6JnJPbOWpmCmpRnMaTbdluJU56AfpmjFStTfz48/75PETiexveKDtrTw8KOpW36u
	 C8bKOgy97SoeaUswMNWKkvXkKnvHsw8bXmHvxinEvIHKis4AtiYrDEChpjm3TAIzEVmJ9
	 ab1hfX/Yt3aDCQi26LVZS43V8YyHE+EVkw2lcazPG8ac3DJRN+pevbFxR0BPUdT4EjVUK
	 YpHW086OW0d+5UFs6Z6/QIglDuoYeobPTIwJN8gD5Fa7d2OwWOyXgGH5f5FJXfyedZCib
	 IMtNIP0sD9TU0sFvDixvPStCmSyeTvamEAKGPvphP0a+ckLBu1Bfou2HrXNMVZt9H4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/m0V48FJw/lvX4pgffc6GzzQCToF+5niRtdUzDuDo0A=;
	b=2ctNNUdI6rBIN6M4WrBYDcuhg4rJAuFIuRmN/X1TH3hxQ7bB0NFgAjlKFqAFSNMkhZay
	 paCky9Z/TGV6t6kgHKTuimvKs/X/7t5eBiKqDRoATCRLiBwMha4gtCH+wEeyFfkJDLAgZ
	 azJH26rNOLUI/PCx1oh6qkje2ieuosF0VB79bzkP85Z8F+I4ZB3ljVkiq6ETyzYmwkGl3
	 mWPaOYJ13uIlS1LGDnyVxkmpjwa7b3BjqK8F6QyqIRTwtOVWCcxNLw0x27077L5Xj/cpP
	 KVydEwpVZR+vYcfh9vISvSCB0hNX768MqtSv4pBHm1rfIkzSiERELFzvY3etaVRBcOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lux1WrwL;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4E606EE9A
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20E4E606EE9A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lux1WrwL
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso3806355e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 02:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793962118; x=1794566918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/m0V48FJw/lvX4pgffc6GzzQCToF+5niRtdUzDuDo0A=;
        b=lux1WrwLfDYTO8YipNDtfR/K4BOtptm+bnx8+Tjz2wJo5dMEAr8Ic1/h8qE1SIGAo/
         RSR//k13CWg+bZMQDIQeswSIy24ro8dWNRnx0LtnWVb5qaBC3w0hUA3JUyt1rLNwAqlm
         OLLpQKI0OMBFxZIStvGtb3rydH6MgaQpBXM4r0JfpTZNoUAX9ydkCij9TUNuzZDmHa76
         +BGS2vf2uQrCfjVWDcTB3VrROUPG9+RnOpVr6PeoXvfcNDvMd4K4Ady0GgIbyAbx/KwW
         v389A3XM9kea1880biyF1c19n5ksSQsJq81zrYUC1T1ISjzQTPNMm7+1TyW5nFRBtFJB
         k3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962118; x=1794566918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/m0V48FJw/lvX4pgffc6GzzQCToF+5niRtdUzDuDo0A=;
        b=E5joMAAL2xD+Zh31P0dw8tyFdAwjMwFd1/yIdRcOEX4xA3FzXcjer/p+E0AAfFzhX4
         D/CjoGYnefwDAXVKld7rvx/El5+JOvUl2tSUnxfQWh24+8MBBHKp3kt7nlOR2rcbQeYx
         D9cZzZNpHbaywJvTqDp69OAIHhWrDQUGlsrPiOxtojeTaKjRWUITZgsxL8yV2Snk8yKt
         59mXpAjRVb9fu2Ihp76MyvKXSC9B7p2KHUPdbCkaTCa9hJYZejIK/ME13AQHtWVtf/ik
         vlgmwdgnDcWpeTP0ag5srwuVZKK/IoIddsfvSMAYuouXMV5tduROfJas09PN0lPRdAuJ
         NWdg==
X-Forwarded-Encrypted: i=1; AKwUvBx+jq3/DR3F+OMHO5yoAHFDKt9pe2nnYscV941mBcE/gtB71kJcm02izGmyAMDN6C/EJTPHT0/EY6KPViwwdM8N@vger.kernel.org
X-Gm-Message-State: APuU4Z/gipRdPlEJznAXSkg7izQHqsMQ9vTZu4nwHJpseSmu7EEsVMXT
	HAf+jbrufBAxYJQLDuhOwSwyXOADivHAV0Rz/T2XIdHkGVPXCPG241X5bpQrUCvIBkwdDodraJO
	QgDDrnOw=
X-Gm-Gg: AYBFou2QwPxYQrwlS/zDQcYBRsILGNfWC4T446rhzoqOwhmrgq6aYvHrwWaB1mz0PBo
	Swck7RlWcWIuK16Xi1Qfkrl93LtBU2nDuaCM+UuUjRfRhYKg0oFq5RukG156skicSyQfDI6mXcl
	Nl68bbYOYojdcGGq5WEHRaFHT3p21wIbs8rkH/xrsKSIiDcvPDLh5K/VhBXhq7kN6gKS8Jclg5S
	nXlVzpfDszj4H/6uD2mP2xmCDSWqYinx8OM+KQYyYa13YDsCRWUX/YHt7wMqH2iyuRnMujSeyGA
	lKTys0eIa4dgq1VP8vLpuG0HLkURqYLG2aooTRsUNpb8E26cVvqni4FCDrqMAhef5wVq0JWipEY
	ZYh08O3NlCITXeTsbePPV5sQ5zd2gndmfV6jFU6KBr+dZHw7btv/hSrJYyK6LRvxWKWvPQvTvG1
	mceMCawgT31l08IYjtNkpkmaLLLjd8G4BbHaIj7w9QQsHE12dE8WlduYW5O+m+28GAklNkoD2xv
	Mi8H0TQQARloQUlmtTEzrMop7CtWdseR4H+q/NKx8VF7RnYtEaKtUJCD7i8Pv8bGA+VN4MDPxgu
	hRppyTfYX8vLynVapnmzaJVgaWMWg4xk
X-Received: by 2002:a05:600c:3104:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4b6e054955emr38404285e9.28.1793962118487;
        Fri, 06 Nov 2026 02:48:38 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm3232248f8f.11.2026.11.06.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:48:38 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 06 Nov 2026 10:48:09 +0000
Subject: [PATCH v2 3/4] perf test probe_vfs_getname: Fix missing debuginfo
 detection
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-james-perf-test-fixes-v2-3-9a912662f822@linaro.org>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
In-Reply-To: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
there is no debuginfo in the output of add_probe_vfs_getname(). But since
commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
line detected"), add_probe_vfs_getname() returns early without adding a
probe if 'perf probe -L' doesn't find the line, which is also what
happens when there is no debuginfo. The error from 'perf probe -L' is
discarded, so the debuginfo errors are never found.

This causes the debuginfo dependent subtests of the
"perftool-testsuite_probe" test to fail instead of being skipped on
kernels without debuginfo, because test_adding_kernel.sh calls
skip_if_no_debuginfo() unconditionally. The other users only call it
when add_probe_vfs_getname() returns 1, so they aren't affected.

Fix it by doing a dry run of a probe that needs debuginfo instead. This
works without libdw too, where 'perf probe -L' isn't available, and also
avoids adding a real probe just to check for debuginfo. This fixes the
"perftool-testsuite_probe" test:

  $ sudo perf test -vvv "perftool-testsuite_probe"
  ...
  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
  ...
  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
  ...
  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
  ...
  ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
  ...
  189: perftool-testsuite_probe : FAILED!

Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable line detected")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 57a59ae7d4ae..98cfb02cf7c6 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -64,7 +64,11 @@ add_probe_vfs_getname() {
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
+	# Dry run a probe that needs debuginfo.
+	perf probe -n -v 'getname_flags $params' 2>&1 | grep -q \
+		-e "^Failed to find the path for the kernel" \
+		-e "^Debuginfo-analysis is not supported" \
+		-e "file has no debug information" && return 2
 	return 1
 }
 

-- 
2.43.0

