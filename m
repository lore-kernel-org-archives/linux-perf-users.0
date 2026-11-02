Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621767;
	b=WRWmYIPrdJLtvGHpKeTtpGoTX3JGs/pBul1gQhAELOxL4E0WMmmodxSXcpefb6qncNx+
	 9IppYV+Y6fdLGUGLVpQupYx5zBghCgLxUhaDNcEMK4JzjKPKgVAU4CZmhn1Wnzxd8xwso
	 nZfXLgnX6UZF7zbcFGCFYElrQkSjM99FzNf5dbJttjGdEPXnnLo248HDuPrld4m6mqcMt
	 s8iypHXQ+LdIG8iiZ2PBWR7jFOeyKNZI66v85hFzfc3zELCaYtu3m9HHI4ecOojeQccHg
	 dpcepTvhRsuwYjklX6mPPaUnXJo9cgHFsnezXAB7+eLcbCtxVb0EeU+IACcGB7xA4oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PwLKLb7Ybxb7dpIE4IVyJShyxd5syhw2GQeVgctsT8s=;
	b=rZKO1D3C3RpeHFBOhinDccfVnppuxnBZcBlovRd5FR88mx49XJkcliqDyu7puaZzjmDb
	 HrcUaWcC5zi7ZYCFHQNjpTx5dMxGJK6p3pg9MXuubvRY3uZzNfRBbTwFabxbqOTWWm2i+
	 eBqazMiG4xXf6sbC2uiY6qtNtmp/lhj0nogcsl2oeIu1ne90f0gg8x48JiFKm7NXgRH7k
	 7clfTI2MNJLFJoOpZYUvsE9VySf6Wj2I9xmnTdiYvg97Ru6y78thZpoXIHbS0n+cJ2UVy
	 y6v5woCuU15A0gR4UkqgjgEZbvegiTqh3tW76it3fLOmoxCB+xXOzdaLFfwBh7kSDLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jieUG7Ks;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B150606C4CA
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B150606C4CA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jieUG7Ks
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so19076145e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621765; x=1794226565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwLKLb7Ybxb7dpIE4IVyJShyxd5syhw2GQeVgctsT8s=;
        b=jieUG7Ks7kdYI+f8jpTkNEJQQ+zYp1cFDMASZ4g6OACLyUF3o7oEQUYMEPKLrU+aDY
         RdEuIgZpTfNDMfIciRMQ7Xn06H9V00Mz5vAJ1lxsztA/dxQ7iuYTI7rD4zI7WvdlFoIn
         iyPZQossTRsCPEWZaqf54tCtiYNDm2GLeOalF4JpemLGP18nXWNJ3QAfJEcIzraNNmTl
         YxSWyruYDOE6GykxA1MFaRo08tPDFWsL7sBf8XQbHTYuh5Avkh0N6vtk+3la2/G38/dZ
         ifZWPRTQ/qQhPFMMfB/ogczA6vkUgloZOsOKXTvYU6RZQqkSegrKM3g24GnJL+ixF85F
         b1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621765; x=1794226565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PwLKLb7Ybxb7dpIE4IVyJShyxd5syhw2GQeVgctsT8s=;
        b=runfOhQZPR+98TwUqpHN05XhO4cgRmGBAP9SyNREEMKoArrTWyfnvq8c0DnB7FjJ6J
         u/Rhgch5Zt2Ksbryfr55HulDihrbASk+kvP9WwDaApHkljodLixqG93soNZrXVpUUpAZ
         9Xf0EIzOK75XtiJunLrYSDOmqFCwjQs21zb5jc+rTORM47t3ETbSwp+b9L9JdhwYSXAz
         gcpjI+6TbZIKnuHIFa9vw/J6/N7yqrWhCl0BBysBqa4NAmzj1P6PcCIX4bfCimRCurU6
         SQ5TGc/4sX578CalzmyZcrW4oQfzMgXuH4qdhEe3WVnPkfJgZVvKdBGgQCPGb+0luSAi
         u4/g==
X-Forwarded-Encrypted: i=1; AKwUvBw+CUKENjw+fg4rHSeTN3SsHrXUHo9W9pveHrpr1P913j5mV9UdbXgjvH/84KPugRWkAlZ9b1xQUBQ1PBAgnw+t@vger.kernel.org
X-Gm-Message-State: AFq9FYLF1vH7tMdBR2wYuj7PZq3HGMFuZq30fopK+d8gwRbmGZwi464C
	VeIlLDiugbjmkjJ3udyeLai04IcUqsNkArKGyAw5c7AuXQbetTwkgkUtayRpwjIG9jY=
X-Gm-Gg: AYBFou1t5KBHwFNzefmo7l8MEEWE+FzWPM262SHLFUkAeRYEv54q9tYHCenrSZCQ+70
	sWjJXvELM1hYiuqffmNgw6YId+XksEtWmvhieioW0gIUWrWiPg6mk7g7G1HFsFr8a/KmQjr/PZU
	oe7YRyLGqER1uBUnUSAIEdxVbGbqW3MY04FQWmSk+Mt+vS61UUkZeZev5gbQiu4nNXxnQAq0ane
	+VZ3N8XHPVU2QahQ7fkCBYxKYZbJZ13K7CJt4JB9JeeqaYT0SbL3YaAsAd6EV+zhSRBLyZpTLXS
	eOZI3pQxnpmd0D749Lq+1jB+CYgyDLK43mWDCWcBfNUerWDE5XGp4AS4B0C08LILsDbLDtNFYIc
	fLg3o/sUE7JHDOryMtn1iUGZHeeIDjpFvAFnABw+AKHO51BVg16xmIkY5vHVE6J2SCeXG4xmLjH
	Uz95Y21yEP5Zw1TH6vXBv/2qNOCfgrL9nl9lxX0TKFLN26OFU6qbA3qEnm8DN7UCWp38oImvJSW
	JmXcvTOTSVSrZbdcQy3PGtqTtBlCsMHxLTxr21rF2NoCAQBtmDt3UjM8dMJchSeT3OGeC3CUgmI
	nXViNXj+C46BACuV9BhBWa/vxpVKlyk1
X-Received: by 2002:a05:600c:871a:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4ac18d68babmr201378935e9.29.1793621765487;
        Mon, 02 Nov 2026 04:16:05 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:16:05 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:31 +0000
Subject: [PATCH v3 17/18] perf test: cs-etm: Add test for per-thread mode
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-17-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
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

