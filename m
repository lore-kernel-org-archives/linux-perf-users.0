Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294E357CE0
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294510; cv=none; b=SOJMhqJdnFb9jwP5FVwfrg5v0QEXkWZPj6UDA97F8xiP5BXZMHSPyKPoWYVQs6cz7xv80+v+gX5hyQPqsBqdvQvqW0e5U7JxEwJi8pkxreIy/4qWoWmuLr9OQ7GU+CfC/DUfutOdZveAQn11rSNRIrBmAMGVjLC2m6+O4P6xff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294510; c=relaxed/simple;
	bh=8waMYaO+HJEdf4Jsh7fOhLGsToyK3/iv8rrPaQu7dUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lwXF+BVmj5DJXRODw1ltT0VhOiuS6b15+zqIC94oUtyyjbj8ovVSP0ro3RKOex9LPZoWI2awPG4t0aC582XK4KzHhIWcFGzuN2jGon8S5tbqdZ7P4JPfeeEwBUYr4x9GjUrbEdJRqhKQsYE9e3tBgqWAmIKU034N+l3ZhvRoKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFZtXcUq; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFZtXcUq"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e7fc90b1so2938611eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294508; x=1780899308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLEPpLWQzQYXyEDs9j46jC0xi/4l49hyU3bhvVE8/NU=;
        b=cFZtXcUqG5GfNTzQegSEKi9T/pVNlpWY26WIe4JL4X8uixqI33hxJ0GLHOk38PDDto
         f3eEhjaj7y6DsbPwcMbsqCe3nyyO/iTO4NvEyabjkVtoOvADbzyrDmxp5A01y/Xsli8o
         xbuBLetn+kA/gH71eaCD7JrtgyroVgGJ6wA1Y6AnfPdv2cx6nh9eiC2qwiheyqKvGxz1
         gq6h1yTBqGJmQ67OC5rm6UzpgB4ZagDmzARAX2Re4RFZDwMb5aPKia8FbIoQDffdOd25
         KHu7GsWN6OzVxbZGndWE7SMoNGfawBx6oJ6JMnZjhME+jl75So72Q8uDss86skVIVlBQ
         wk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294508; x=1780899308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLEPpLWQzQYXyEDs9j46jC0xi/4l49hyU3bhvVE8/NU=;
        b=Xao/AMPQql7lLZ8ltnlMrAqaipLBKnU6pGTLof+CnwTMslZkRQx9DUn6On7obQgoQi
         TTdoVxm+ILc22stAm0J7mX/vsCxAKmLVnN9E2DEBcjOD23nOVasK2hWMPbChnIFIdOzj
         a/iouQTUWWdfjwsJOyK9l64brlxveyW85kn4yRYAHACmTXQu61Vlosr4yJltocseuZxo
         moYy1k9EIvNSv7E8ddaOn4fsZcPXY4SUEpDnnnbaZK/ruZ4aEyairyOYWkSZKpkcg1f7
         +//qpNHePBYe4cF6Z64mC+iXkEf2UCRcFdbeZhMe5PlQkqlfjPDXNquQ7GhH9N0+f3Sv
         49IA==
X-Forwarded-Encrypted: i=1; AFNElJ+i7dSqlU4fmnRI5RssZ0qWlskYo63PZ/wu8sjhBizdG/6q6mdcAR9Iw8Q3WfyT0Kyvt7jpTusQ/HQ+fqlh81L/@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaPYHT2clfs0LQf+isr9Rd94QYkVvrD3YPTDvKWzuPMg/ylXm
	y6XSjMvwzB3w3WMH70oovkC8Xz1NxrSpaFMadQmMMzCSSz1/8GudaZNOGaW9es/1CHQNb0+A4bW
	qTIJwRZukdw==
X-Received: from dyay11.prod.google.com ([2002:a05:693c:62cb:b0:304:eefd:96c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7495:b0:304:dd1c:737e
 with SMTP id 5a478bee46e88-304fa5a84aamr4700818eec.16.1780294507717; Sun, 31
 May 2026 23:15:07 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:56 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-11-irogers@google.com>
Subject: [PATCH 10/15] perf test: Fix subtest status alignment for multi-digit indexes
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
index 5d319b9da762..e4998a4472ec 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -376,10 +376,12 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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

