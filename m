Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1B78F44
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181819; cv=none; b=uiCtz2Jsv1lFsUPJHd/M4FepEhJcWvKcpQQkpOlhA78+lqdeDzVI0clAfi66AOxrvJw4N/3GCuoEmgG/EI8j4R1qpYyNVOSBrRYyA/aPChaCuZQGedPsojY/vMsfRi5i7tDaVn/H181fZSPSG95WPNFonxId0ccd1pRpul/WWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181819; c=relaxed/simple;
	bh=TtyN2+z5LlFIe10Zsn9B1EQfthxpye3NQhfKkY61Lps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYQ1QBFpclpEtFitg28yXnjGJHHNZG4gIojmtaV4qRtz9aykmPXKKjDZeqbnzoux0FSZG+94+GTyjAB0bEg6q9oEHwhQcNUoHjd6xEBWJsbslKnQ3tWIcCDIFR5fcWYvAcDLzEfKB5zXH651RbTPM1Jb01J84SuQkXug+kjRG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L12dFIkD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L12dFIkD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso145336215e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 08:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736181815; x=1736786615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SMUGHCBb0ppaxEHLWQn7OHwMJlFKEmQAiaAFgySReus=;
        b=L12dFIkDNU8VYkZqG/HFG53zhxkoZu2bTGdiwUNcPnoLf0pxbq13uTZRcpp5CPaeFT
         m+fNsjIiMXof5e1PgYwKHCDN6HXrWB5op1a77bWIBX1bCejhTTiXd1hKPGWBu71SiKnV
         OYDF6EZB1yJKavMz0krYKe/JGbbIxniJRAL4EXwxjOhp6+2kjSAnjSp4ry+E1olK10gS
         Q6EH7/yYVA7LfjcAsyPzNGayoD43yRkzAj+c47PiQr05grIhXY6akU4/kzL+BwY09ATi
         Y3XNgdzpwW5k5yvuYpcLQeEZsAXZCJSFyH0ksmnLqXhRt8rhgy6RQOY/TvJLWQrU4DLq
         sl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736181815; x=1736786615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMUGHCBb0ppaxEHLWQn7OHwMJlFKEmQAiaAFgySReus=;
        b=XolGjtBuxZtgqtliIF5AQoQfYfHHgm4q3G3w4jDWRoFXdZMdnS2ZBpO1eO70MUPdgA
         nD32VouGe5CL3olOYliLZOuj2+B+VmAoY2lVrhm/5geDJ7ZelnN4vXnQ2+/YU+EK5PpK
         DU+TdnXjZ+pWQoVzR5AZndY6odNdak8IapKyBfoWQ3kZxPxKjt3GK3c1S9Hsckz/JaRP
         9LbSkpud+cIuP2i7OrvutBSN7vlSBAa3ti3TXf24iKkAQ2tBOm6uRYWvJhF1wDjx0DGk
         Fh4TrsKpSOtHs6d36SHymgfRv8l1WnxdYm4+Vas5muL2GTs+P8UO07Cw99TG51x0O3oR
         Q3xA==
X-Gm-Message-State: AOJu0YwE9eKLLmQ6tqPSZdLwscrPBoD+lKwkM8dubfXyZKlUp2mRx7Mo
	YNwtLA0ujGYFu8R68Ifa3C0rADyUDdsqb3SNNfEqLlhiSw2kFYestNgBtLYx1cavdaYI5usNg98
	r
X-Gm-Gg: ASbGncu4mubqf1sb8bCK93o8zc/s8QiWs9d3IHE7bASbmdM6NdINi+NsgA6AUkYxMmW
	rO07k2nJZyvVGZB/p+eQxI6Wv0ROfKhdONgt7FnyFUerHBmYR8rdf0PYNa7rvuHN6xJfWzN6h2L
	FYzw5+KGKnj1xuoor7vSgCFA3weLvkJmnhgRKQgLJKOWUe+JYQVOU3sDh0w/0U+PzZLP4/99tUj
	DiK4mm/x0DC/twxRENPmVyTBDUt9BEf4wQ8hjyhLJgKhY2Eke6PYEUI
X-Google-Smtp-Source: AGHT+IFHMZMx9rpG+W22u2mopwgsbt3ogFJyG4r1C2V4APK0buHzshmZEf55ewaupVi3mhJJ5P09Ww==
X-Received: by 2002:a05:600c:4fd4:b0:436:1bbe:f686 with SMTP id 5b1f17b1804b1-43668b48084mr445238505e9.21.1736181815361;
        Mon, 06 Jan 2025 08:43:35 -0800 (PST)
Received: from pop-os.. ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474b6sm48322701f8f.51.2025.01.06.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:43:35 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test trace_btf_general: Fix shellcheck warning
Date: Mon,  6 Jan 2025 16:42:58 +0000
Message-Id: <20250106164300.734202-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shellcheck versions < v0.7.2 can't follow this path so add the helper to
fix the following warning:

  tests/shell/trace_btf_general.sh line 8:
  . "$(dirname $0)"/lib/probe.sh
  ^--------------------------^ SC1090: Can't follow non-constant source.
  Use a directive to specify location.

Fixes: 0255338d6975 ("perf trace: Add tests for BTF general augmentation")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/trace_btf_general.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index 005c93e6c770..e9ee727f3433 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -5,6 +5,7 @@
 err=0
 set -e
 
+# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
 file1=$(mktemp /tmp/file1_XXXX)
-- 
2.34.1

