Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879150;
	b=G+ENdNOD9JJ6p0X7oc14gc2P6wSJqBXWACzqdOb/PXLgDruADKAzsC8/fubcnqfjBSWS
	 rABb0YiVS/iibuLoeQt+hY7BElXBGglQb/8u6L8LheC7j3vpogSVkL5ziUajYomjuOTF3
	 ex7S06ivXtVftQBCoRFuA+rtWyTxeySBjsQpTTADU0WlVGF9CzTAvViBCggu4CfbMkv2p
	 xL3FDYnfS+Os3LaSFvdhAIxI5JWlnZeN7kDvXUvxkNuRtZYbNYjDi2EJlpiNMNWuAVWSF
	 foXS1Fe/qHKfS8v0yGlFAQ1fBl9C/t1AVWMKc1dcpWKYiyAfz7Q1llhuW5fp7NxEJ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=K6SaFtQqKwsgNERxw2YHc13oEMre1Ry8xi3YCZpxsYU=;
	b=DLx17+hCO5il1R/Q1nSjSKp61pY2XzVaTYDRnOBNqxoi+Q9oCP8rJf9cBIWbMaSBfVOd
	 8v5tr/V5Ds1AZkgvzcz8AtooBapiN8HxsK25fkeghg24LbV+PJD99DVCjCVGp6+PjGIQb
	 W2qcrd6anOWNORPWT3ETLQLq84OtAOnj/O8x+C4E/408P6MdEp6KDRAksPacrwE+n8bkx
	 QzfwH9LVKezZFKQxQUU4ObTvrsWj5ljECtZdgdoXqvOJEDsY+R/MLZcgZ1tOqobl/UFCn
	 YmsRmyb59Q2ImuhluFWRO5+P1zU5UlA+kvMmxnsnpYcYLthLLBEvm35Ji79bFBOX+PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ex9MeRvg;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC5606AB2E
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EACC5606AB2E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ex9MeRvg
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so2949115e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879148; x=1794483948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6SaFtQqKwsgNERxw2YHc13oEMre1Ry8xi3YCZpxsYU=;
        b=ex9MeRvgxf8OthR+ykcSraFjQf2M1WOA86U2Fyr8z/S/bLhwMNSebNL2K8bhaHn9Go
         BjkkSM0e5+zsm2UFf+xBByJOR9siue/+yqCJH9aelxgYEznoKWP3rg8CflugEMzk5h96
         8i2GSpmycaB1kcqQXKQMAfD2XYU2eStmfOp7L+Jgr2fhiG0vioIcGaUH9ZP6rePGZB9U
         OgEaUR2KuIuTq4Fl8Q0AgcdeE5DXUVGmadz8eGW/ndq6JY9iViPlXbDI+Igyd0KugMXO
         YogmN7vDE4ufq2kBuv1aFznTMoLBD/g4bIPKm20fNOZWS58AMkDLrnPIUIiV+WPshWtA
         +4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879148; x=1794483948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6SaFtQqKwsgNERxw2YHc13oEMre1Ry8xi3YCZpxsYU=;
        b=lGInsNbTQwOssg9n64x4iaJJieDA5IzyAoUOi4Bdx+rfJMcgirNx0KeeveaIuDickG
         3Dr21tMKpxvVrg7oASXfzioVi8zLpr0HNFCC/rlMxZnKYHKFAYHTXoW+g4BqaFoE+JUg
         +bfrOdgbghO2YaRmIHGg4MZ1BUL6x0bfhr/UHEIgKfYsN3VaWGYUsEPpnLtlOzsWc2AS
         gMN2FKw/yMJZVW0kgk6rMw5G7ukRGUCtOeyvVT61xyrU2Q/K2LXSZQ/xUfd4Twxnsp7a
         eFNnF1rCrbZhWURwJq+a8/rz65FnRe8SS/XEljU/lx3gaKHZYPkWm9A0BdSofbxheo4D
         qXIQ==
X-Forwarded-Encrypted: i=1; AKwUvBweTuUL+i8F0Ok90HzSS796DP+wFVaJ4ehP3Uwd+ADOay0HpJHk4+V+22tf4dCTRAwOqz7QeLRe7opHFXDWABXn@vger.kernel.org
X-Gm-Message-State: APuU4Z+O2VCMRJ1S53FMPFLmKdtmdaVXg5vMKzH5ifvkMxjaw0wI2tTk
	UZuPW2LUHOaBHF3lfwUpvNPcnbfKmHjk98lNTNfM3RC//4ExSNdkhsxZvljdnxZqano=
X-Gm-Gg: AYBFou3QxuA4sWppBaoM8KGjhqR1jGuUCHGhFtCoOyWt6LQToyjXyEvSBqCMagPmRUW
	ID/KMpAR/EPTfkOoJBw9s0+cbbyojjlnAmzXAGWbKJy+2WHkqzN4DZhEFlR7O/2gvPwpeyafbdp
	wig4nLfIoQa8E/iNKsyIypnAdA81hH81q9rfww2qvYCFTqkkZOcGCcxJedNO5GKMacM03an6PDY
	mOcRUBW58exyAXGxG+2Sv99RmQWhRy1TCQt3UBDmpt/+Ocsqz8R9T3dd9M//KwoGWdZCXrRw7am
	ZEcI1Esm17+QDWkahUA1QHBPK/2CJpRL5p9HdwpygqhDv4SiVuFqOI5WaRsKkVMvxGalxPtBCCX
	DUq+IIYg6EYiUPMF9Kef0Iw1X8iuxjuMiUXak3RhOwoYDyKo+RM2zWlJB0FcPo/lDw57ndyBfHM
	qQ9LvF3N00VeQ9Hui1xdXZEOMGtYSUF1S2a1zZg1QZ6pa4ip5dTE050lOfT48o0AsxzpavstUis
	qmhbUwdODL5rW2ohFRlzZX7KXxdV9Ecu8oBKBw4KMwzC0XOc06diLDXhh2qIC3Cll1aq4gypK3b
	gt9jyNQVuF2jJGeck229O9GJAsJR/1iT
X-Received: by 2002:a05:600c:e556:20b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4b55e07fb14mr25741525e9.17.1793879148405;
        Thu, 05 Nov 2026 03:45:48 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:45:07 +0000
Subject: [PATCH v4 19/19] perf test: cs-etm: Increase snapshot size
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-19-7759e0ce2449@linaro.org>
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

AUX maps require at least two pages, so for machines with 64K pages,
128K is the minimum.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
index 236c4160e480..404317c2b96f 100755
--- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
@@ -48,7 +48,7 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
 ## Test kernel ##
 if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
-	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
+	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,128K -- touch $file > /dev/null 2>&1
 	perf script -i ${perfdata} arm-cs-trace-disasm -- \
 		-d --stop-sample=6 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
 	grep -q -E ${branch_search} ${file}
@@ -60,7 +60,7 @@ fi
 
 ## Test user ##
 echo "Testing userspace disassembly"
-perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
+perf record -o ${perfdata} -e cs_etm//u -Se -m,128K -- touch $file > /dev/null 2>&1
 perf script -i ${perfdata} arm-cs-trace-disasm -- \
 	-d --stop-sample=6 2> /dev/null > ${file}
 grep -q -E ${branch_search} ${file}

-- 
2.43.0

