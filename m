Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879148;
	b=zD5qSwR0knxWUTmLFjQXg5n4POxxNAJaBCxevj7jR6vqoMjvEuoF9ISy2TwIGuMVT7Q4
	 +Xs/eWmY+7gbc+1SF1Tr1Drs13C+U/rTmLwk8/MkSH6DF5kdkK8v74mdPAgKRpPf3zwYJ
	 wnrjDZibCdtyMNucXFDSsrkdXsoEm8Mck3WQR0OM3e10pzkeSeXE5LyPOFIfQjK05HGb8
	 6SvqDSahXy8odoGI5dR106K8rLqZan5UEB4Z3Df2fjYEx0HmJJKHPiyTj7tpw+3hk3qEo
	 APlGorILlseIxO0PZm3d3stmY35ymYhZAkvYxQMKXaqB/ujn3OlY7oZ6w2anyMypYxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PU/EFB+VchMZfy9q7Y3QQl5gRcVp9NfFdbFPAQA+Sio=;
	b=QfG0gytTK2s9okoVqXDNQNpxmh9t2FrisfNsRL+1UrANlwumIG1GIEk8DohJPuuc/iMh
	 Mceu3K7Hixv6ETU5kSX3WP6YUc3lkZSQ6Fzh0OPoURP43r6EsgWlFwfXK996X/anlC4tZ
	 Z96aSANVUbhw72/pPhWfkbsc1FcUNBLFRKQjTjfhrKRFTENbYaAktrXwNTVhrCF/wbgiv
	 pvOUVeeVcry5NKPzai1hN84fFOsqzo2opAK/nK7I9lXWhQHT1TXMXlUxoreMtBLMrUgUy
	 MNvFup+n7gu5O+WDT/4Y8kDMf8jITmwQ8bZj6C86WvUp9N74Zcm8pSpSzAm9iEd6/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I7oinnSI;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFE606AB07
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BDFE606AB07
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I7oinnSI
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a208d93758so20024745e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879146; x=1794483946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PU/EFB+VchMZfy9q7Y3QQl5gRcVp9NfFdbFPAQA+Sio=;
        b=I7oinnSIex9WFs6wfj7U4/5LTijkW/OBRe1wgdWSEGSuNIJLRIVB4EeDFohVHeRWpy
         DqjStibRNJH3jsN5HSVGk7cfRqcBC0AarDaLs87TQiySozz+SD8cF4F5KLETWWs+i1/F
         pGKhWou+u9v3gqQpJ/US0ijSsGmaebkIse965iixAd/5gRXaE0mk+DF4acZr0o3eyAKb
         MqvRpNMTk4evk4WBlWlHak1egOjOCXK8HBjPiwKrraYDiX0ZXZzuH24f+1DcKNCEHXNW
         mzhQ/NsZ/+5HecrctE5PiYjZlAxqDhEeqRyWa5JuagiLVzLPtrlz1/sL5nMLEqblRmdL
         S3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879146; x=1794483946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PU/EFB+VchMZfy9q7Y3QQl5gRcVp9NfFdbFPAQA+Sio=;
        b=dPVjjmFlgcS6i6JUUCeK3kk/WLW3s9chKGzxkWmFlE39igOVGTKeKrltZMKFIuHLF+
         L4ie8HxcDo7nQ0u2I7WxwJGOPDwqC4HnlwKwp2iMBoN/gXAVGRXXtOpuuPs7EBRSflI5
         aIf+ll5MvEFOXZnu7DGmEnFifC1EowPzyd1hM/9X3wv2d9XLulswX1Ujl0fY3s8myJv3
         kBJbgM6MuNKOUlTwL8hTIVZK3+G+TWGuwdbioQAVvEh/cv6RqjJ7a6N+hyRtF5HzDOtk
         KbNphfGX6yHRSBlHbF89/p7tfDp6DyNST+RYPrHGHCXybWq/1dcehWo03qptAPCah2p6
         aLHg==
X-Forwarded-Encrypted: i=1; AKwUvBx3qq2tiCXK03y09+Hk9/FgwFs4jLrXRX/hUIBf3S1TLyHFlXyZ7AUpqzn456A5uYH/sy+iaInYQtfZybWHPfy7@vger.kernel.org
X-Gm-Message-State: APuU4Z8TSjyK3lFerJf6RXyp2a+NkMKZ6padYjeK7kreDXSS8mqunNcf
	eY30TpeHy5nom8ZQjE/JPjPgFh0o4J10JRuXcP0Tt32f584qKMnDif3YFyU0r+t4vds=
X-Gm-Gg: AYBFou03abzzPbItthvvu+i4I600D1SJWrEWmfgWEqXuw3EjXbn7PHJsX5aIY1AwOG3
	3cVDaDinGfG0/qabMxnT91DHROjZYmUR1sLTrEyR2WJ2iJHYG5HnEFtrybDqgOSNfUKgN30/lrx
	ctbWhi55+RIbQ08jOqkZSvgEL2XJwbFzxssTcwjI5+OTifglb084NqmYoMk56xAvU1siMMM6S3z
	AekxbRhQwLl3cjHnHK4YsETULMPHTqXhm/MtduJ6Tftq1t9AVFUdBKlwnhlznrx+yHGY9PJlhnF
	9RjJL8y1pZd1uLdSu9jwf5cw1Wb5pDEwcacaQNxxMd7RgpB5Rw8Kyzp5K1gEC3yj18WRmCuOgd3
	XdBagVG2n+9k+D3fAt8+pKX2TkMFIJEznU6tNvmz7nvA+5GX0z+kARVuFXTtfXBIc7D20dJW/Oq
	LJEH7HnZ6R1ys9+OittJwX0i1lPV6ni39cVuHlWRX23Ctwca66JkWDcKc7kTlME+U1fX9iJEweM
	PBieGK8Q6WpeQ1ubIAZmOcrwwKwoKJsYXXCl1LPghJkM0pX+cLy3Mc/y/0e8HEu1VfMDR1R3TiP
	s2IArNEubSjiWoafroVUzWrIFvnpwfse
X-Received: by 2002:a05:600c:1f93:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4ac182dbc34mr397731085e9.14.1793879145713;
        Thu, 05 Nov 2026 03:45:45 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:44 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:45:05 +0000
Subject: [PATCH v4 17/19] perf test: cs-etm: Add test for per-thread mode
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-17-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

Test that per-thread mode works when the process migrates across CPUs
and that the decode happens in the correct order.

A TODO is left in for when support for decoding in order with Perf
records is added.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/per-thread.sh | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/per-thread.sh b/tools/perf/tests/shell/coresight/per-thread.sh
new file mode 100755
index 000000000000..8a1ab9d8f1e7
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/per-thread.sh
@@ -0,0 +1,48 @@
+#!/bin/bash -e
+# CoreSight per-thread CPU attribution (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+if ! tmpdir=$(mktemp -d /tmp/perf-cs-per-thread-test.XXXXXX); then
+	echo "mktemp failed"
+	exit 1
+fi
+
+cleanup_files()
+{
+	rm -rf "$tmpdir"
+	trap - EXIT TERM INT
+}
+
+trap cleanup_files EXIT
+trap 'cleanup_files; exit 1' TERM INT
+
+echo "Recording..."
+perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -- \
+	taskset --cpu-list 0 taskset --cpu-list 1 taskset --cpu-list 2 true > /dev/null 2>&1
+
+echo "Decoding..."
+perf script -i "$tmpdir/data" --itrace=b -F comm,cpu 2> /dev/null | \
+	grep -Eo '(taskset|true).*(\[[0-9]+\])' | \
+	uniq | tail -n 3 > "$tmpdir/script" 2>/dev/null
+
+# Check that the decode says it ran on CPU 0, 1, 2, in that order. TODO: The
+# correct result should be "taskset [0,1,2], true 2" but we don't decode trace
+# in order of the Perf events yet, so everything is associated with the last
+# exec.
+cat > "$tmpdir/expected" << EOF
+true [000]
+true [001]
+true [002]
+EOF
+
+if ! diff -q "$tmpdir/script" "$tmpdir/expected"; then
+	echo "FAIL: per-thread output doesn't match expected:"
+	cat "$tmpdir/script"
+	exit 1
+fi
+
+exit 0

-- 
2.43.0

