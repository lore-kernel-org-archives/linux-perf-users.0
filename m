Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313192FFFB8
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205285; cv=none; b=WJ6MR9PKuzmPYKb1XVqhtRDm2Gtawqk091h2HCX7EXKr74VgaT+qTVoPQfvhXREZPXFE/9+7KTDyNqZN5BXyD0jhxIWss2cYNncUhpPYEFduaqVT50Klns/q94XLXg1JXiXd1LFHMo5iPYsdAPRlzuPl/IadtMCgg4tfB/PNHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205285; c=relaxed/simple;
	bh=MTzl0LsD0hZmLmhnLJ6LwPDwGkvWlX5Lk6zfIDkOd2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A25pb3UUWCBFuQ6woXNVWC1Uauc+rBKUZUX/O1l0S+Blsf38GVmqy6E1r2D0eJxk1IuTV2gUR7Z1pc7o5+eCJY9BaWnO7dg3CxIBxY9aKJEqchkZ3MnuMG4OBu5JNMjQLE/Opei3DjYormP0dQawPT83YhiY9z29xOhA717OUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8kVLmS1; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8kVLmS1"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso3730198eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205282; x=1780810082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNYbOzJjfvtMV+kuTZgU1aKOkGRuELSNl5OCDJwbhdY=;
        b=G8kVLmS1trHRxtTXxr7eXVQCKfxd7JAOHs5Tcw2a8RzL6J028writuSZaa4OTPmFQo
         pTHOxM+OxHFUfTTKLaiqZ42KKrisqCF8EZFuOnE3qQnfi76wmIoaGrDS0T1cDduv9WXW
         jmP+ZgH+QoURS3wuXgnsK/WeM6o3/8MDg1rXcs7JZcxq5Vk/24xREebwgP99hWir6lCC
         2EM5jZIhCHqAMIdJYCtD/A+jvVyhEM4Z/O3JRJZMSQYf7vQfhxc/3GlQy+jKokYtZ79m
         bmDFSQyKTebJlgnqNF1AXWjVazmBuUnKg7sy6sr3vka3NqVNo3xFxHgHFL1LAMAg5ZGt
         nDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205282; x=1780810082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNYbOzJjfvtMV+kuTZgU1aKOkGRuELSNl5OCDJwbhdY=;
        b=pMh9r4peWdZxf3Md3WujWfVxBhQMQ780Lx1iQS8unK5eXYBnQb5GcE8qz+6JbNOlaC
         z6IYxk2x1u8Ax61yIOKMIZ760mHrG76FRJ+c/C1NBljvBNBw5a2b5LIu4/k0TrJfTLJ5
         CqW8kWFseO8v2aKKOSpL2qlljGrF+Cck+mk5len0C8OESZFHl6IZ24kcIH/APnpaSrNW
         LcN8YANvn+mmLk3nFaOTGtnwwLysIa0jBrfh7tFpb+h4IQ2gwNXWz/HsbTXfoaNlErew
         N9JUbteFqomQY0HLWMj7stMi2Be4NtfZ9jU7NalJa0Ktn7lQ+HRl/dy9v/p/VWoe0ok5
         PLwg==
X-Forwarded-Encrypted: i=1; AFNElJ8c6zf28ClZf7Ofw4uADVnAm6Ll9bXAf3iXdaB7/6L+SbSacIYomUAl58LLiBFy5+atpkMYB1wfrOfKPJP72DY5@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBNlA50rSKeVSHyrLU9UUwQN+dv3B6YCzuOIaPgdVw1tNqD/F
	WsU782dWUJjW4Y2dt7zIr84z5iDT5FenGtnwaqYkJ+ItaweZwtqC5AodD1obg/HumhnrIuMBFLe
	nVRHj5UXuyQ==
X-Received: from dycok22.prod.google.com ([2002:a05:7301:db16:b0:304:2d1f:6ca6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c84:b0:2d9:6373:ad24
 with SMTP id 5a478bee46e88-304fa67bcafmr2561329eec.26.1780205282206; Sat, 30
 May 2026 22:28:02 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:35 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-10-irogers@google.com>
Subject: [PATCH v2 09/14] perf test: Fix subtest status alignment for
 multi-digit indexes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running perf test, the status column (: Ok) became misaligned when
subtest indexes reached 2 or 3 digits (e.g. 9.100 vs 9.9 vs 10.1). This
occurred because the subtest description field width (subw) was statically
fixed to width - 2, assuming all subtest index prefixes were exactly 7
characters wide.

Dynamically calculate subw based on the exact character length of the test
suite and subtest index prefix. This ensures the status column is perfectly
aligned vertically across all test outputs regardless of subtest index digit
count.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index dc04d3f60384..fb4dffacf406 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -371,10 +371,12 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			     int result, int width, int running)
 {
 	if (test_suite__num_test_cases(t) > 1) {
-		int subw = width > 2 ? width - 2 : width;
+		char prefix[32];
+		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
+				   curr_suite + 1, curr_test_case + 1);
+		int subw = len >= 4 ? width + 4 - len : width;
 
-		pr_info("%3d.%1d: %-*s:", curr_suite + 1, curr_test_case + 1, subw,
-			test_description(t, curr_test_case));
+		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
 	} else
 		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

