Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F5380FE0;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753206; cv=none; b=P1Le1GSJIbq5ZnTV9v64RAiONOBT+sljpWDEPFpy8v8SobKSGffO5t5JreS4lJTaTAjxUBjmZYz6FWtjs9yBkDDs0oLkPREloHhfJWW29yozjJLxCBMe1XL09zGCDb6Z7wUFlp5S/X7xdL1vTx5qkDJ938HCS3kk8hMvjfA9qMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753206; c=relaxed/simple;
	bh=BrttYSDCZ3UPdyXCnU0naHlWRe3etFk1gvV4ByRhCIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOX2i9+ACqx49BjAtBr6g1XOSiTbIPek8PJmNun3Di9pKFJfc9k7Blw6i3fKMg6Yk60BHvGAqZa0xKSSqvLA4q6Q4ECdmA9o2cX0BbFCUzszD9XVBnXXe6a+dSgXMLrKbV+o1Yk7rzDxrKv27IkpdkGVBwD0cPfS+EV9+jlTV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbsPfO6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbsPfO6a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA833C2BCF6;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785753205;
	bh=BrttYSDCZ3UPdyXCnU0naHlWRe3etFk1gvV4ByRhCIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mbsPfO6aZarcXg+qNfWL0PtzG30Hd5Qyt4E2mqcbwEzZ1EIGbYZnt8VWu1jAHEAR2
	 vOwIjm7MTdLkX2eo97M9mMu2HlC8z4QwrSp91aY0chH+8KtniTgQfM9Mvc94iCW2Zb
	 VIg4hoDVKx3ugT5iWD4Qvdt505yrVqFAzJwRg1hZ8JD39cx/Id6JETFrh+Ig2svJU2
	 2Biex0vzfH7HCWSCfs2+ybElQuS1JJxnheB/hxqOM/ZnWTlZ/6hEJf+RvM40Cb/AQH
	 At0j0RZ04KSUY0E2LQtoKnJDPjUPVQbFy7yShU+yTYDchoAbLcCPskkggd8/facmBx
	 VJQbflNEKwO5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885DBC55184;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 12:33:21 +0200
Subject: [PATCH 2/4] perf tools: Fix memory leak in kvm_events_report()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v1-2-a5db849ac973@gmail.com>
References: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michalis Niarchos <michael.niarchos@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753204; l=761;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=+xGD7FspTyvyggckeT50Nwqu43WI7i8N4AYpJ8estqw=;
 b=AdZ2NDsuv585bd+dL1dq8Z6u78WO7LwJ50KwamPaKemrMj3ZQDmMM4oB3Ot8YfkM7/YVw528o
 XgrkQSZEBeID61nF3k/9x40UxpiivbdVB4ZmP5KlpbNNa1GM7zFp6pL
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

parse_options() calls parse_options_subcommand(), which allocates the
usage string. Free it.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 44c6998f2ee5..1a013698cae3 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1755,6 +1755,9 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		if (argc)
 			usage_with_options(kvm_events_report_usage,
 					   kvm_events_report_options);
+
+		/* free usage string allocated by parse_options */
+		free((void *)kvm_events_report_usage[0]);
 	}
 
 #ifndef HAVE_SLANG_SUPPORT

-- 
2.55.0


