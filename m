Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A66218584
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021707; cv=none; b=c/g+ffS2TgdI/pBAL87tmNedx+3c/pLW6xCXIXUOetM58giyEkFB+Fh4yDK2bAOC2m8eHR8WNlyggNTFmfkckVwoGzz9r4q/+0RTAosETbpfa8X6ky1JitCeOgO2wgV1wnZBL+wQeRDrtx2vKBRwsvfK9eC6MVpTqvx/lqB3L98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021707; c=relaxed/simple;
	bh=55edETlaAF/xPDiR85KqrBF0a1nE/Cu/GLA46XFoBBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JsubpSQWakf1BoPXYpa0m0kaUnFHoULCHkAc+4LPB/l/7VxEJ9Es9c8Hww0ZwZflZr8J3qolLWCpLK2Y79mFG9WnyUrUQ60N7TmadifD72ZSGodqyFJ0XhxSvzMDOgIxiFBRvTA68sKniCYMtVRiE/KTvksAatDS2SUPhUI7zqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=cVi9m0D1; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="cVi9m0D1"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b463e9b0so6117855ab.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 15:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731021704; x=1731626504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18ZmDlZAsM7+YsheoYv4XvgwoL+hmIgAgJNB+1lzwm4=;
        b=cVi9m0D1jlBZCVJgliqXqPA19AS+mJmZPgd7qAGQcXg9rQ+ieww4q/HuUj/KHMj4SR
         q4sAX3FA+5WBAv6daiOrSHnNeNN8Ao8r1FbANe3/Ihp/SjeBwW8ngup/X3lExn9jF+Hw
         R1qL++uySTOq4YHVEEDzZvCrKe0bntyRkwn+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021704; x=1731626504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18ZmDlZAsM7+YsheoYv4XvgwoL+hmIgAgJNB+1lzwm4=;
        b=Vk9tD7kymrtfXga2k9pxto8hD2nZOfkAmTnVGXJzb2P52xucsZ2jPVWXtGkxebvHsX
         3SQghVrUpzgpqYXvi/fI/IDHKMT+M/HmHR7uC1juqasCvdQ2QDSeUw9z7qxg0eJ5gBkD
         G8Y3+6ca3vM89tCCYzcrcx2rQmNZXBuSkL5CZTrzw2NCFJY50cUNHkJUaeoO4DcG5KTB
         3iKLIuMGY3W7S/BYkSOSZLkhetfYYinFc07OcvqdX2VVnr2kh3qxnLzkzlE/Z8NX7jla
         oDy2tbGE3xDqzgZpddlJfzffnc+B4srb5cJzFE8BVlG93M5ASmp8vsaoLubldcE9A0TD
         j3QA==
X-Forwarded-Encrypted: i=1; AJvYcCXKCOGAlfXYRN7XT492kwFUiuGK5JLXr98+WPsxxVGNjwhE4zwk1YN/RtqGRhkEULKB48u2ewmXncmy+NVndMbu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm70GOYIaGD3eUTU6bXs7LQduO0vz1uGFLjn2eH9TKJy8NO90X
	ZKqxqQHI4xV7OzV7kc/3RpLuVlh0adnUP88r2zNDZ2z/LYDhyO7w4nXk3dYzk8U=
X-Google-Smtp-Source: AGHT+IHUQFLpQ/7GCV86Hk0Ft/wKn8hTR2qS9H0VxwQ0/lRuGFtuPe/ZodyG1L3iLz6fSNAKkZ/hKg==
X-Received: by 2002:a05:6e02:216e:b0:3a6:bd97:96bf with SMTP id e9e14a558f8ab-3a6f1a4501cmr9435265ab.24.1731021704410;
        Thu, 07 Nov 2024 15:21:44 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-b.c.engflow-remote-execution.internal (93.126.232.35.bc.googleusercontent.com. [35.232.126.93])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f82e773sm533023173.68.2024.11.07.15.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:21:43 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: Benjamin Peterson <benjamin@engflow.com>,
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
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2 2/3] perf trace: avoid garbage when not printing a syscall's arguments
Date: Thu,  7 Nov 2024 23:21:27 +0000
Message-Id: <20241107232128.108981-2-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107232128.108981-1-benjamin@engflow.com>
References: <20241107232128.108981-1-benjamin@engflow.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syscall__scnprintf_args may not place anything in the output buffer
(e.g., because the arguments are all zero). If that happened in
trace__fprintf_sys_enter, its fprintf would receive an unitialized
buffer leading to garbage output.

Fix the problem by passing the (possibly zero) bounds of the argument
buffer to the output fprintf.

Fixes: a98392bb1e169 ("perf trace: Use beautifiers on syscalls:sys_enter_ handlers")
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/builtin-trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f6179b13b8b4..28f61d10a2f8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2702,6 +2702,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	char msg[1024];
 	void *args, *augmented_args = NULL;
 	int augmented_args_size;
+	size_t printed = 0;
 
 	if (sc == NULL)
 		return -1;
@@ -2717,8 +2718,8 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
 	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
-	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
-	fprintf(trace->output, "%s", msg);
+	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
+	fprintf(trace->output, "%.*s", (int)printed, msg);
 	err = 0;
 out_put:
 	thread__put(thread);
-- 
2.39.5

