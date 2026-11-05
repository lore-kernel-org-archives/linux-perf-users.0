Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893768;
	b=JfytNuFPFtr5rw8f9g3MrMqz2QdQE2DI39twi5LnvHYq+U8aS92SgA5YLSNtEtLiYpiH
	 UsMatUqEWp0yO815BmquwFmjgqsu73nY7F+vl6UOg5HXk5aIDCffUs/wmS7eee9zBvwQ9
	 2bjOiDfsTGNJ2KI8k9ZxYKn8AY/uXqcKmfY+05NAfPYseVgT2bVqW7ghORJRG2tAXsofV
	 D2DnsghLg2l3x5kAIUk8Q2tjBz3r259bqamhrZyxpmSWrx42QZQMu38TGa/oHZA6tEHCS
	 ZmI4FZbRdG2ykNKOtxDxPCcY7dgMClgXADfuXFfQpQ8ICy1eiCePUQvWMRkuM9KgWhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=z9ZWX1AR/I3jOL5o9kBh6YYdTWJixzoBFDFa25TELPs=;
	b=RVLnr/Vs2zcwHkm2NaMwIidD1jYb/WR3hKQfmPRYBkX0gjN/DYpeBpuW+3lRUA+uBael
	 3ahNh7yGx6PRwBd7Kw9WZVmfhAXUUI7XAcoYSjxdry45zNi/KOZyOZkAx4r4NlrgRCdZ0
	 kIXA8/QYcOWQEfLTGglfpy8f5G5+5W0D/XAlcuY/I3kPNdCDwbk5OUelXRZWO0a09eLRt
	 O94Rdx9bXUcgBNQIiD4sx5Lid2aqcuT68uXiolou28JGhzOVPDsTUJEnKAJ8TJ4SU4aSR
	 wmbOoM+TXDoAToB2ROTLFQw/NbRfXbo0AL4M8CK82zRvBG4W1uLKKXjUE0EX7vq4S3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xiJvYG26;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E4B60A380B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 15:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E4B60A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xiJvYG26
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so18271005e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793893766; x=1794498566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z9ZWX1AR/I3jOL5o9kBh6YYdTWJixzoBFDFa25TELPs=;
        b=xiJvYG26Gk6GQsqAPvh+SQWZFIGO/rHqmstYmlfElJ9iVS5GyH5Ked1Kr9zramjBV6
         aYOxhOzqz1BT7VQRgIxXNrv7LRsTON+oBTDO6HplcKDrUhWSm3ME1iIRDHhywlxjDJje
         3kIPhYntJIdqOzVyAavYTSG1+dkjPmvFn1D/a4B++LYr38pzPLFgKpgLQ6e0/BRszpLE
         vxSgOuP2OLg0EoMeX1/Mlq6QA6wxrJLenD7IU6mQn6lbV4+asp8Rne2AoURo04fW1Zd5
         e5aigVDEZpglDNRo2tHq8WYGXS76OEfV7W7PLM0lSO6gJtlulFu8wHX1KjmfhqJ5gfYe
         jGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893766; x=1794498566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9ZWX1AR/I3jOL5o9kBh6YYdTWJixzoBFDFa25TELPs=;
        b=X+hDoxK6RhMQjJkjRPvKnfLBeXuIN+tG5RjKQF3VUTeCRB3ZcdN59LLuvfjNTofWc6
         MtUpQFrIu8cbPFHkod1rUf9mQBXzE+khLYI3+ptU0lTeDnYyX1yz7v17laxqvFINNOKP
         GQqyRMPs/hHG5NrhGzV+FZslzeVZqxac+g0zq06998qDRTH0t/ZZ5kylLvwEMxXlxc8c
         v0RSa6ryxbDbwbeqjz9ivc0vFOJ7WyBPREGbow8FrTcCEl1BBjUTtdkArZJjodXO+Umx
         Hr69IroxWh2SH5BJP9lzKowK+mWH90LOcFQ7bBPD+KZ4CuN5RzoS5HE7XwSD+Gs/otjV
         dd7g==
X-Forwarded-Encrypted: i=1; AKwUvBz3Z57tbhWFcNWJv2LiqVuDxIJF7SmP3dDZaHSX/sT49XoKixMajFLkKhYaTs+HbBBEquA+y0yBzn0eDKnA/Fjc@vger.kernel.org
X-Gm-Message-State: APuU4Z9VH4SNk00vPTRlSEgR6GY+L7Y6RQAQ+Ig5LJLf05y/0ON4WBP6
	jArCfCGBLLXWVhKcyW3ySTQJl5H/DaQzCHeHr7Ncc4nTzjfS1YSEulIoPHIJWQ6mBSE=
X-Gm-Gg: AYBFou2HvsQ1UqoAPgtfnGHrhq3fBM6rBbt8QM7drE7g7kzKtmEXioyzZMFWm2lqEvh
	Sq8v6xPaLc/zTHGC8/KT5sjFInsh9HMOPhrwXVL5YbMKM5OijBMcD8vIPmCRYqs4gnxLyVFzI13
	a2giRVzQ41r2z1wlTj9FjdwnnLEa3DnjYICxfgZ0Gc3RqHmnyazMK4KHE7WS5EVWkgc9Hgm8DVL
	B4kWYjnAY8vGzECzYDj4Jxa/KuDb8oyMKTW3GtC9inUkLHhs9uqvwbT9+duD5CPhRy03szHAV+Y
	RsjRU9tslJ16HXZklCseHNWdBzGJVWa7Q3ELP6dQ7hOdHWLuz6B+Zdm5PSCfdGeCi1RvHr5Qtmi
	r4gLbp1ewm70786uM41N5ThYtc52kHIxfs2gZ9e5yV3hGl7Byhd/kjcBnuO2kQGsFnOp7U0NUYr
	gs3X51xKK24L3gm3wQD/vsd6dAhXySyFnqJiGngFl45KPM/gE6GReh6XE6k8ppFmqmQPQilu/Vu
	4Db3UC0dddELyf0iKNzcCQczmMuV4DDhip981sULrDdx0KMR8KFCsJsL3kHRZUmJ3DMqK3nZPu5
	kFD2QN8rTzLuDszswvGUfG9H99wsOmmm
X-Received: by 2002:a05:600c:c16a:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4ac16fa352emr435548945e9.7.1793893766216;
        Thu, 05 Nov 2026 07:49:26 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd40csm10650462f8f.13.2026.11.05.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:49:25 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 15:49:05 +0000
Subject: [PATCH 3/4] perf test probe_vfs_getname: Fix missing debuginfo
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
Message-Id: <20261105-james-perf-test-fixes-v1-3-0b279bee5830@linaro.org>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
In-Reply-To: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
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
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 57a59ae7d4ae..1c3af5771bcf 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -64,7 +64,8 @@ add_probe_vfs_getname() {
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
+	# Dry run a probe that needs debuginfo.
+	perf probe -n -v 'getname_flags $params' 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
 	return 1
 }
 

-- 
2.43.0

