Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02713D62B
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893610; cv=none; b=LNYMElHr2yiAJPuBOsdUQS7+htL6Dla2jrHIMtGNt1YVBDUR8eLux186rty9/LbcszQtyWUaY1R/wzXeHj8TyAMmwPtH+sM/5G23DeS+Zi3h5luTWkvVYZshyjDGOP1b7k3FVg8gEbqV3eLbLxRdM+N5y0v0Q52x4Jc+8kiA554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893610; c=relaxed/simple;
	bh=WMiXG5UVLxQ7dqT7HRmR1LceAv7KVX8HDMx2h/1cXvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sV4xdFhC07xgZVYh3VvyzJvcS9zFW2hcvp0sjSlrpNvhRbjLPGaljMJQ/jR09AvmJRKvjAPLmyF60ZYbW8pvilxK23FMagjipHSZYVhSvGw1tO4d9r2RaP03hw+yksWcKFoDWOg62XoYK9IHV53K1rKQ7HceBCXNRcwG6zhKBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NtoKqj7q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtoKqj7q"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa53a971480so266308266b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732893607; x=1733498407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8GWdrWt2EBhjvzgV2YI8PlXuX9R1pC2cNExx3nRNDE=;
        b=NtoKqj7qpLjDL4qsX4lVrg3JKnGLjOtZTujq6f9SftdrR8ieJtNr46aE24LwZOf0ij
         tv8KCX+Uz/Hec9Cl94QCHtE90XCLLvXWzYufiZX/FwD0nFSN72HtXWp0yAGHlBtD9wOe
         J3Rnf6Jr6tEl0/eWPqV3HSrMcYPzN6gwUjkng5+OiHP87gHcipSbbSK+OYfwz9U/V1z9
         UeROEQY2jMvpysCkahubbtu60k2ayHvohl3Sm1cezmrVfyFto0/mHPFzVyxsgYowsLUt
         JU4nMhqkswPeRyCA1DNylnUxOgvK1vkQ0cdWTmqbvzVoYL32hjuzYu1+DRQdnwtMfJIP
         5Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732893607; x=1733498407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8GWdrWt2EBhjvzgV2YI8PlXuX9R1pC2cNExx3nRNDE=;
        b=QVWxTWaKDyRgY7d9+M3ifZ0umDTyF1VMZuvG8sWuWO7xuPQZsmqxY7o3moVLsNM8/H
         I1juK4TQYrfP09AAEv8jMD+yL9g6BL3rFGsS9LpmSFth6whVzy+oE/BYFBb2gS1aMIpZ
         DTxXCHQH9CdlZO1ROKG84UTanSPkqZJRpv+t1ftCg4CUfCoOu3BLNe4uZW9KIXP0Co6X
         nvKSdqTDG/sk4sOeQNm0eK1Do/zlyKTdTM636I9N/GY8rieNlpYMOhFYHgDTXDAGlx3L
         ICfqHIueBL37efQnQbqO81p7Ik8FgK84N93fvBVpSqgxLfHJFC/6Q8IA4eU9wg2Ey6zi
         reUg==
X-Gm-Message-State: AOJu0Yy+WRZh/ZIlKMgc7pQWotGGeNItSXnLIE40yG7AJqvQ2M0ZgUEb
	enyA5ZSlrGHj0pNkNSFEywH5OGHrw9rCM/p/sWANBJbxgGdm+cfs/Dow1MHNAnF5crEBI79xTJQ
	a
X-Gm-Gg: ASbGncvDYmFxz7v4QJTs59vso5Y3AMM0v8B2SgCW2qtVhbGyxmooC81QNoR4XWhcH6Q
	D7OCfRzuZk3mM9dg3v00GuWXw9k/b11KGH2WgM6uHISs4H4JHzghH5Xv+i7DPmZc+YBeDmxB6/e
	qudSR0vJ0nR2LZQOOoGoeDuVQj0qsM6VE6licYpg53wfI9mQlVn2HuHR52FFJGCf55Y3VX39GT6
	X9ZZZdVrjBlJ7s+e+pQEjnui0zTZfsqwDwntJu83V7SgBs0Wg==
X-Google-Smtp-Source: AGHT+IGbDhuF1WYnayVyw4OBx+CK4b3YOmGGAp/ufEmQBQ6AfLGaToXTkRv1wBm7KZ5DSaVS8tWrSA==
X-Received: by 2002:a17:906:18b1:b0:aa5:3f53:ad53 with SMTP id a640c23a62f3a-aa580f6aec8mr880140066b.26.1732893606566;
        Fri, 29 Nov 2024 07:20:06 -0800 (PST)
Received: from pop-os.. ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d4101sm182260966b.73.2024.11.29.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:20:06 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Don't signal all processes on system when interrupting tests
Date: Fri, 29 Nov 2024 15:19:48 +0000
Message-Id: <20241129151948.3199732-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This signal handler loops over all tests on ctrl-C, but it's active
while the test list is being constructed. process.pid is 0, then -1,
then finally set to the child pid on fork. If the Ctrl-C is received
during this point a kill(-1, SIGINT) can be sent which affects all
processes.

Make sure the child has forked first before forwarding the signal. This
can be reproduced with ctrl-C immediately after launching perf test
which terminates the ssh connection.

Fixes: 553d5efeb341 ("perf test: Add a signal handler to kill forked child processes")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8dcf74d3c0a3..4751dd3c6f67 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -508,7 +508,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++) {
 			struct child_test *child_test = child_tests[x];
 
-			if (!child_test)
+			if (!child_test || child_test->process.pid <= 0)
 				continue;
 
 			pr_debug3("Killing %d pid %d\n",
-- 
2.34.1

