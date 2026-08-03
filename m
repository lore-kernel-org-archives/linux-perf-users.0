Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C579403AF0;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762363; cv=none; b=UOgnCml0CC/cXaNHtWzTlPEfgV+VkM/w2F9oOgbRUH9JriZAySgUJOANvTYToxrfZsx4Rz9ZVayOI9SooZX+XwYdKAnRy5fr2NOFQZvZHIpwkH/d8scY8/mUHnrIgklocSuDAjjeE2TWd1Q8NXSXSqxoyh+bofoNNjO62c+owM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762363; c=relaxed/simple;
	bh=9y4LUF+bbsCRcc5va/yO6KlPxfcpaHDzeMpXdNvJF8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojGWTPSMUlK83pAe4QleKS/P/tp9bRyseBW2K+vCvCoElrbQaeV0IV45dd3mTJ9SKf73NvDQFoaWOCsz846gv91uPidqOSI6ELcnyWmF+dvLJespZLf/F+KoBZg41vCWBmVNSlc7K63aOl1jd5IZrDRkJBDPSTyNN6RSAdeg7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5gd+USz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5gd+USz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30AEAC2BCF4;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785762363;
	bh=9y4LUF+bbsCRcc5va/yO6KlPxfcpaHDzeMpXdNvJF8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e5gd+USz+TPuxByKAxHpeDO5Zd7KGpqyL8rD6KESwdZ1IPNwmR0WgKbXrWS2uwTrI
	 ykYa7UqWJwu8znMdg59gcHsl/OKIl1apqNE5ZjY2q7DN0Px55sJSLOLpxHgydsHyh4
	 TCpywl7PZBmdKAEkG0ZCTeX+pMiy1qzjzvyy76Qv0A9EvbCH77CSCRDqtc1A6lZA+b
	 rrPktbpHf0+n/rhSct5IH51ntcqkOIG9w57CPmbXVbamL9P3okfZgrrXaK7eZmhumO
	 OVRpXQ89ByXaAbiC3gRjHJA9wkbgsX5rmXwdLJoLT+n6rLxDGEbscJfHYCUnxXkvSb
	 Hra5zJ36fV3Bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126EAC55182;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 15:05:41 +0200
Subject: [PATCH v2 2/4] perf tools: Fix double free and memory leak in
 kvm_events_record()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v2-2-1b337189fffc@gmail.com>
References: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785762361; l=2074;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=O4wX5Z9XY/f99VY/L+7vtzDWIkAT23LI4gDz7eAJLVw=;
 b=AGVv+jzerEN8qKo06dvufUIJ+fTvE/22TkhBdPTa0G/RDASZSKG8MeBmjIcFKttgr1s72JDVU
 REleaOY68BmDwHxULGkwN3JCkCBZWEh1tySaV75zcaCZ9Kz7XqibSMu
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

cmd_record() reorders the contents of the rec_argv pointer array, so
its entry order no longer matches the order in which the caller
originally allocated them. Freeing the contents of rec_argv by
iterating the reordered array results in some pointers being freed
twice and others never freed.

All the entries of rec_argv come from literals or pointers that are
valid for the lifetime of this call. Reference them directly instead
of duplicating to remove the need to individually track and free each
entry.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 44c6998f2ee5..45c92ab74fdd 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1681,18 +1681,18 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
+		rec_argv[i] = record_args[i];
 
 	for (j = 0; j < events_tp_size; j++) {
-		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
-		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp(e_machine)[j]);
+		rec_argv[i++] = "-e";
+		rec_argv[i++] = kvm_events_tp(e_machine)[j];
 	}
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(kvm->file_name);
+	rec_argv[i++] = "-o";
+	rec_argv[i++] = kvm->file_name;
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	set_option_flag(record_options, 'e', "event", PARSE_OPT_HIDDEN);
 	set_option_flag(record_options, 0, "filter", PARSE_OPT_HIDDEN);
@@ -1717,9 +1717,6 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 	record_usage = kvm_stat_record_usage;
 	ret = cmd_record(i, rec_argv);
 
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }

-- 
2.55.0


