Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D6BA49
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Jun 2025 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861673; cv=none; b=mnhJrf0hzE6xy8Vo6xVVbFOFrS6Zl0p0u2nw8EpaJclos/GeFjrjL7A9+uzMsT6gUnxCtY3f7zjZNY3u79Pe7LI1hudK9FgBep0VEyNRXWtRz0NLRUREFdMrfaJqCZrlIBej4l4hnljcgaB6t8MXwcurdYZYGMKxoZq1BvX4bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861673; c=relaxed/simple;
	bh=hH5vIPdTCQff8gwOm6etCU6s/IbLP6xIsPkR6QvOXa4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LhYBcCzpn+Z4Etjz34l+9YsUh+JlJUcErrJCohgo+MBDrhcYjk9I1+BJuRFkOfcpjjJOm0YcuffmjBePfav8zPrruNvUyVtI+eX/bxSJVbmZSHo8HOrT4age1XL3xUQWM0r1YBbifVxwlCkHphxDe9zmBzVoeXdBxQaVJDFEX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIXnpKci; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIXnpKci"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740270e168aso2253706b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 17:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749861671; x=1750466471; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gIpeoLgx1K21dRmhAOymx8G2jElFSvxUENOQocYBfZ0=;
        b=MIXnpKciWfQvwDzJ4FRhGgZ0P+wkbarV0BbGJBjozrysu/jlXCb423kMNuYTLk+RG1
         te1t3KtzCAOZXQv+tWeuFo4avAEBgu85ISXPGo7Bzs6fXklKF0PZpgownx1sxi2aBmiU
         0pshQ4jiqZYy73zT8wgeJfj8VXtcgfaavB920ISOTe7QQ3/OXsslmTaLp1uvShrlr6jd
         U9NUWUNJXllbMESPJQk6chuAoZiubgwR7DNEnDkg9Q5Yrr4fArkpYMqcGgHkDWVVWjGs
         0LaxcEYLgyxkGFE0ucGurzyh5rwzNejA8+4TiHzKYoMGBG+SeqUxndLFUjwCHEmk/GsN
         QYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749861671; x=1750466471;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIpeoLgx1K21dRmhAOymx8G2jElFSvxUENOQocYBfZ0=;
        b=Xwr+klMZcMclAa+OtmfF1CruU8LUKaP0Fv/AuySAocV21Dwx3wXpIJAj3fGCqZzitq
         P8GQcEGMXTJMxFUHTdfj03C7qj9IcmtLGMaltzNLm4FoJVSu8zOvhm0uHvUdJpQzfbbI
         Mt8grU0EkOddr1AZKSylPNCPpcUsVVjnRtHWbZNhdXtVtsO5i++z1ODLgf5GGcf9Qq/y
         C4ATOq5zxw60juq0mOR3N64/IunfTGc/hG+1/sYGMC+FZwtYW71ZVfqEaf9eXDuLQSd7
         uoVtI2OvlW67oaNkfPhDx+8gvRvapRNsB1C0LCshd86Bfu9LJbQ9KPKSt/Z+Z35IZb+v
         LACQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8A03c/o4Fe8lNlnas2lWTjl/AXO8sgITR+ueZTqXjxUo1rAxt/vwIdvVMH0XRM5wTw8rawVs3Bv6pCXMNGmTS@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvcujUt9QHtm8zHMqd+MZ7ArDBzTHL0G8Ml+CLqe3h4FPTH1O
	hzM00/fWSn6IRZ7S3w9eH1LBdFeDg/PqVBiE3U30GVFfwZUCjOhJ7im7mlxiZ7EMJhgKaKRAssE
	5Octc/DXSyg==
X-Google-Smtp-Source: AGHT+IGmKPJfsPCnvNpuOKHgItgWUFCp+xTyjx33g6KS/Q9Z5ioZMSCkxxEO5LmKd1BvAO1c4Fp3J/S/dn0R
X-Received: from pgbfy9.prod.google.com ([2002:a05:6a02:2a89:b0:b2c:374b:9e48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:158b:b0:21f:994e:7355
 with SMTP id adf61e73a8af0-21fbd668cf5mr2044481637.36.1749861671333; Fri, 13
 Jun 2025 17:41:11 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:41:04 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614004108.1650988-1-irogers@google.com>
Subject: [PATCH v1 1/4] perf test: Directory file descriptor leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Andi Kleen <ak@linux.intel.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missed close when iterating over the script directories.

Fixes: f3295f5b067d ("perf tests: Use scandirat for shell script finding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/tests-scripts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 1d5759d08141..3a2a8438f9af 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -260,6 +260,7 @@ static void append_scripts_in_dir(int dir_fd,
 			continue; /* Skip scripts that have a separate driver. */
 		fd = openat(dir_fd, ent->d_name, O_PATH);
 		append_scripts_in_dir(fd, result, result_sz);
+		close(fd);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
-- 
2.50.0.rc1.591.g9c95f17f64-goog

