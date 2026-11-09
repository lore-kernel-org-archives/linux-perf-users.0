Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232108;
	b=eaxVdutyUxt9ffiLmZNSW3wUMK/XB8jSyCD+56EOV/zPGottMjvseYfvoScuKb/tdcbl
	 ey9Uea34O1m2Ug9WHvpw3KVYw8tutAQeWPN7/4Q0I4tu7WK6a9+yuAyFIHPW0J7zpORYl
	 oK2LNmTWjvd4d+NcPnBTX3PrSMP4sLpxCs0t8YzPKc7wBWMpkZxMoV0pa/wBAUMXHmiP+
	 oRxzOBROwRHcDiyqO7DOiJ/GaDlrSx5Rz3ud35HRD3jJPtLzbtqqsZ9645wLvyHlatQ8P
	 uMXBDD4X9KjC6e4XYp+h91yFI94QESQKl5sizWWJkTLEpqP606dNb8UC/Emh7Wz7LBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AASYYYdB1Pn2NzJax5aMjK+QD0+VSp5X1qY7y17uZnI=;
	b=2/OvfmWFGTlIdI+NnJ2JEt6Rp60ZXjeXniq+EPumcaRE+6OTkwLnxSS3stubOi7e+tRG
	 ccGmPLC95bg+UlAZSC7Ty8/bLZOIrA9qwb3pyYqRmqMug1Z20Jc3YsVo9f1SomVeCBc4w
	 xJLvmreIcOVbqGRm5RJablTtyq6fryllaKC3M9oQbT+D4qp94YNPI1x644q+Jm0Hta3t8
	 03ye/uc8oA7tcxSmtm9Wj9xJ0d48eLzja8yKpw72gTkF/TcD9yue+ezymxhw3YS0Lim27
	 o2srBCPQGiYKyObMA5yf9yaqaabnI3L8Bo+y2yb6Qhr4C1hd6JvvzIBpH9eGQvUSHwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZpxuU7UQ;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB6606D819
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9EB6606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZpxuU7UQ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so9295395e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 05:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794232106; x=1794836906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AASYYYdB1Pn2NzJax5aMjK+QD0+VSp5X1qY7y17uZnI=;
        b=ZpxuU7UQZNVDV/kb5KASzh7bP+AlR42b7CNOnrEjDvd1gmmQE/o+xIXA393TcOSMr2
         kqXYGE51sPnLetu8pNLSdsPI87PiwmIEE5QBnWll8QQrI4UJwwZIjg2qRC1W/i/qVIZX
         i2VUEjUOzkqnnDUUfUBDFQuU+v9SkiygqhyRPAk8O+o4mG0OmKEikOJkDR6buCry3p6C
         Hh/sFh6PMNFxqCX2oqgWS/6XEeNOqndgXb8KipxKsyaSFRvxg/fx7GN4/QTJKpbG6k06
         FTRT0UVHRGmWdWYqLM3DSCJLvvfDayjFIDSG4pLm07ogna6gcpj95vaOg92axbkyZhGp
         v/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232106; x=1794836906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AASYYYdB1Pn2NzJax5aMjK+QD0+VSp5X1qY7y17uZnI=;
        b=ivIQKWOWAbwolAF4R/zJ99u89Qa1hSA5EF4Z6pLz0D12gs54u0A/9IaRL7V8SOZtJ1
         CpnPsvXkgbUB3DKbTh9Upk07jnSrOZTwBTgXTIC6s3xnLVX/p4IxuCh1LgrBpfdYUt6r
         dgeC1Zz00La1/4lm6+nKajPX/askdMNTXWctxP6tW6fmPeuk3SgW2i2S4iW14Jl7qQCp
         PveM7OsLj+4DgPIlvCWo7UvK/tFyHgH7xWgzfUkvMx4w8eR5mC4yQagfSW+48o2g/YLM
         rtzT7Lbl6ZKhl+soWAqojcYaCBq986irm17NxwiEM9P2/dlb+Tulc3I2Yyg/NXpD9bPg
         xX8g==
X-Forwarded-Encrypted: i=1; AL+hErE8yK6+BrfJg0qvh+C12hIJgqHt/cW8WZQZ5J1jcJkFhF6mSc0c/TGhnx3ytKIM0yqSv/jzwv4G4nqEPujvuM+C@vger.kernel.org
X-Gm-Message-State: APuU4Z8AcY9mB0jcPyZPGeBPkAC7P7KQ8cwUx/3NBSXYwrpwuBWRESq9
	zG0LttebhZWdW4eWTODYzqmXfEHXWniWD6zK7/st4a06ReoPjyaf8U6y0NK9JulfNBU=
X-Gm-Gg: AYBFou2XcEgDVRSzEBT9Lo1l6lbV8X6pPVSjCbDysKa+J16EFhF38l8Q0F6tDshD67O
	ubMPn37qwYaT+gjahKren3G/6fV1A4tlqWEtMZQl/puMgzfJh2lLxT/H8ZS1DaaZn2OedSFwHYi
	TXKmEJv1CsXuxvyDPH3rCvKyBLAja/Zn39P/16OrGeLLUM0zRx5Ls9TMKYg5ukplGCLbuSSTdwd
	sDcjS15y2N2BJUzOrS5ngVQAsKTTtWoMpc0FxO98g2Q3tVt24xFdTHMtU4Q23T2rN4URH2hy5jZ
	T7W80xawNEPKBGrQb4zgOMZNYLP/NrdiigKzS2QyWjS2nNTXGmOzDq/CS6q1IgoBYBDVOaw/xbO
	QPp1DwLySxUxcAhb0xtjDO/EHqoTOLRp87/All6sWLtRV5ya5+DZB3t60Q3TPD4u5on0CYd9CqJ
	Ie/FcPAFrCyhCtpDcINeEhLWtEodMxv9T2IAn3/BLdZyCbvejn+ae/G1/l8+PTZkGwoK8ywCCvH
	3YCCRA2xpIF1MalqYZxlN1d1mCdSQi2xi4DFL1VdySQhNbInPonzmPWM9HClv6r3VH7AZmDEuEu
	KyqNm7mJSr/hbZXWg4WUwDEkaWGBo4iJ
X-Received: by 2002:a05:600c:3b93:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4b963c76714mr97886875e9.11.1794232106186;
        Mon, 09 Nov 2026 05:48:26 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7bb101537sm98522045e9.0.2026.11.09.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:48:25 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Nov 2026 13:48:10 +0000
Subject: [PATCH v4 3/4] perf test probe_vfs_getname: Fix missing debuginfo
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
Message-Id: <20261109-james-perf-test-fixes-v4-3-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
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
avoids adding a real probe just to check for debuginfo. No more
remaining users of add_probe_vfs_getname() pass an argument, so remove
it to fix a shellcheck warning. This fixes the
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
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 57a59ae7d4ae..d13b8a8e3b18 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -28,7 +28,6 @@ trap cleanup_probe_vfs_getname exit
 trap 'exit 1' term int
 
 add_probe_vfs_getname() {
-	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		local func=getname_flags
 		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
@@ -59,12 +58,16 @@ add_probe_vfs_getname() {
 		fi
 
 		perf probe -q       "${vfs_getname}=${func}:${line} pathname=result->name:string" || \
-		perf probe $add_probe_verbose "${vfs_getname}=${func}:${line} pathname=filename:ustring" || return 1
+		perf probe "${vfs_getname}=${func}:${line} pathname=filename:ustring" || return 1
 	fi
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

