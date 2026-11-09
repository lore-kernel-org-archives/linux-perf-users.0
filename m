Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219454;
	b=1BG7oA6edWbG432zcm++mG7hqoku2JoMit5oFXIIc1bBc7s3yhBwqdsrGCNeAAxC0zox
	 nH9miATyah0t3LRC+gvCJiDPWwq2Xog09wk21Nz+ZJAjuIvp4HMsW/aLXHjSLT0PRcNEF
	 UHJMwHtKmpNTBTIkSOVUcO0xHZGbcsFCXpG2AOXM/B4B2v/DKpAGZcOdVOWn1rmxa6ZFP
	 h5l2PFJzT4aeJrhy6H3g2R50OdargQW+sUu7F9h5OAsQ4hXgjs2iBiskyaXXiPU9H16/f
	 bn9k9heRSGrMk6ayi9kVYxnXEn2Xxgu/AO1JIUn7o2WuJ7vjqP4cDhAOVTEO1AQ+DvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/m0V48FJw/lvX4pgffc6GzzQCToF+5niRtdUzDuDo0A=;
	b=ZtQ3iu88OL/dZxd7gj9gCw6VlBE81lDVaeRsVsd+HVk9x1WImsIpjIoBHAL+10/rLBlh
	 9o215GMnKG8IFcTRKvb42oH02uCd9ZRa6tkehhLIezlvMzNA2Dk7wyyLur8+DBF0hNbkv
	 xEuAsGMoKT7meRWsvbctm8BCjknE8ELNERQn4/3iHeL8DNNMeY1br44r4Bw+ycGiMkyCQ
	 pyoLSUywYjpuaPiGH8VEPFTU9TjmzPwktowu5ys8gzFqsSN9p5uRYYiZP6lTfn05E+lcS
	 h/Xh84V3NTpMBxudYYcqGQnsuws5AC+4gKSY5U2Ou0vVPUGBUEj3VgUnc7zC85WSDNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TNjSNAmM;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE1606D823
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2BE1606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TNjSNAmM
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso594099f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 02:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794219452; x=1794824252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/m0V48FJw/lvX4pgffc6GzzQCToF+5niRtdUzDuDo0A=;
        b=TNjSNAmMMXzyJZhRIK6HYeF7ws9vWkYWs2aRf7ten1rvXKOs3cFYN1l1goHadFmrg6
         xrBfugzoxf9roNUed5ZbQDyg+Syc0oMiTxBsh0NbAHeHenfFdElEp0QtejvTv38eTHlD
         OvjvlA68nvcttVMxhhZY1U1SsHm87wjaK6Nrj6FjK67RVx2+C8pXtv0UCY7acmsC1nLh
         k2jcrE8/zb/HzLFNPlg7KU2yqdDrcjqdo0JKHeVUDV4uUY/SeneRiTwvxl+o0cyssaIP
         6PTwNvZ+xDMF4Pb8XWT7FsiGg++TJseUI88CZXGTWJwFT+RSLIzxEv1e7UQChNuQzZrO
         J9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219452; x=1794824252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/m0V48FJw/lvX4pgffc6GzzQCToF+5niRtdUzDuDo0A=;
        b=dYNahLgQONwJNAO+CdsIGUTDfLgHE8ZLFhrft3f9XNYDNYsKCD8WsIfJ+sAyWgfpqF
         QRN5qIkx7iWwxsMqDlyvgjRrxk5ldwhKG3ddSJk1SiGjiPrNKfwDiCU2/8ynR8mBpM/B
         ImuFF4Kb/pGoNZ/x52nRzuW0Q+E5ZUAfzfhDS1ZIdq0M+/M7qi8jFW+YiYHqrGuD7L08
         7dSHxcMKqSsDkXn55J4D60vcVMB5vteFtp1nc/KXG3uIPwySA/+9xPEdQPQv5fK++stN
         oxaLMm80+feUZ6glwJ2lGPMraf0Rpui9ItYzSEcUcR4TMwJLxMfrszKVOqrQi9czw/5u
         ArMw==
X-Forwarded-Encrypted: i=1; AL+hErGLh6MM0CuHAHDe/SiYU4A6/LqF3gpWUP296kHEbvceMRGa1rS3UPgDfWMe56+pcxqSn57+e4xnNHjtrDCwnyof@vger.kernel.org
X-Gm-Message-State: APuU4Z9/3TSzm0Zo7CLD9pOYZ/F1KJIteRnb2pzqSExyCffd9mfypUV+
	8hNu6L5Dv8JRCTFSdmW8lYuTb2/gpUeiargrMycAMkSjITgfbJIamHkL5J3PfM4KWwc=
X-Gm-Gg: AYBFou3XuOZNUZa/RHrqG0dLbdvoh0YGx0yr9KPNYLyaXgR/bbz0Ve0I7QQMRmm0ZeG
	P6MxPfWN7QnYdAWJ/ExztjryRsSrzX26G2PX30F6VJnXZa5hOup6ppvNrnOhZoEythJQkOn5UkC
	gipZtRaD0K56id+FELg9VHkZoWyjQI7Gi2U6rvUg3UAQ0OgeGuxU9a3ML5iHQy8KYpX9p+GM+YD
	Urj2azogC63Bf1BYB0ktARZFDjFNtgq1VMnpOTasHoKnOoAdN7swzrwITO8kSkbypFMSEURtD5P
	7fIZC7NjSrhaUGM0ZCAZqQt6u2OHBr+xF55kJWD7hwAxbtL/5dWHlqqb6fQWGXKJ38PRyFTmPiU
	dh1oAfvsNtJrr1QVgrDX/rjiVFw0E4b5mB37Tts9AKqj0LzendK7xVB68gxTrJjiwhrOEzIUzZI
	bLucZOP2sqV3JyFeDOH8duUSe0C+ai+iuAWUwdIKM+BvgH9fu0rF2SheDv0hT+NneDuthYZJudm
	tbyBUKqVYmvG2K5nSCLfHHH6Kj0ihBo5L65xSHRau9GWMzc7UXsP7acmeMduO8zhK2TjtFaEkSs
	gMq4niHleNIm9Sp5XgnyAPuLPBghPk5F1w==
X-Received: by 2002:a05:600d:19:b0:4b6:bb67:bb9 with SMTP id 5b1f17b1804b1-4b963c9be07mr46813785e9.29.1794219452257;
        Mon, 09 Nov 2026 02:17:32 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee1de2esm121575795e9.5.2026.11.09.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:17:31 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Nov 2026 10:17:03 +0000
Subject: [PATCH v3 3/4] perf test probe_vfs_getname: Fix missing debuginfo
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
Message-Id: <20261109-james-perf-test-fixes-v3-3-e8d0a65e618a@linaro.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
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

