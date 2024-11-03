Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080C157A59
	for <linux-perf-users@vger.kernel.org>; Sun,  3 Nov 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730666923; cv=none; b=hypA60LDciU5EX/OqYY8E+VCi2qpG0nvqx9JP6VpzneXz5CfCjVXEu714/MH9R4KkfvL348omCYHa5G6lzC09cUskUEsbRJBKbPbacglXh+yDL+TrjghS06IPXgIM8CjFFNTEPmATszzlSyPWpFAf7wO0cFzcTm5rWiK4Ad+yO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730666923; c=relaxed/simple;
	bh=SaPPFw0i2Jm6LqIInQrwnloT+7hSRv+2il3t25SfqpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGPaO+RBhIGhn6Qf0YZGUbIp5mteNmSNOt3azS/2LMeDCpXDVtDemadlQ9pOb7Ps35YP/ffAz9N7ufVZ9bCQ4LJjsQs9Ma1sCrGKQbuHQi+i5ikV0FfmU5ZjPAehhksprw6JneGDHuabJ8uRzNTBhDbY/E5USzILN98U423p03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=lt7iLfuH; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="lt7iLfuH"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a6c1cfcb91so4850245ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 03 Nov 2024 12:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730666920; x=1731271720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlm2PLrARUKeIopTjkk7MtdiLDlLWS0aLomBZawMdaI=;
        b=lt7iLfuHm19mw4aHvOHsIfChsyPN4Gw3zj0/g2sFIOrSrCe6n5604A/ku3c3fmO184
         nxt6kWqPlWOl5i3Ocn5J1OILLA7FvmbM8HoE6uoT9foM5kf95IlaYUrTQ0JCo7DtrEbr
         RNQVRzjfpOngNHRFr1+4ehiE+/DO8h707N0Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730666920; x=1731271720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlm2PLrARUKeIopTjkk7MtdiLDlLWS0aLomBZawMdaI=;
        b=RGbEgQXv/jo4pdST7viBA6MARu8iLk3QOWTBCWixcISgxJJS+HUnQCXTcU3jFH1OzL
         5v5RExSBCk3cz17A/tl8KzMH/CdlJ5/sVxXyMzMnK+IPKFc+ABvi2ZI/uMFjlXeUqOxf
         n4Hi/E+QpLHh8JTW9usYYsrY/wf5awna7HIWsEeLKfZYOdwKubXVGABBYDQ0t/X0hytO
         tXJToYaSBqmToP2s6tDXDfIKMKWAc4d65ZRn3LS5Gv1uKt4lbMaCJwlwCV52YFWBy4WJ
         6IBRaMf/xE/ypxjj4nKhsjkjatUOKqC7h4uhakrZBBzKfbfVSS5W5lcGEJO0tJJ9c0d9
         zkng==
X-Forwarded-Encrypted: i=1; AJvYcCXc24yKhxJYfJEn9U7GxlqyYtNzvJ08LfITO47I5vYUOBtQX+rQJ6JRZojObNZrnQpTYqQPfK9X1hgWqEisGSyE@vger.kernel.org
X-Gm-Message-State: AOJu0YzStyvNoWA1srA7/eJO2/2YsrfAJfydwZ/hkSqo/017wLyiBfQ4
	neHEfgLo+bu+rnzpaCIhHqp0EdR0BaAkxbthdtbB0q4hQ/7O+FEj3+ptNU8rW6s=
X-Google-Smtp-Source: AGHT+IFmKEKqEcCrPchJyXh14BuWWrnIOqGLmqLcDn3M5t5a7ymNpnzwMlZRzh4NhnPRabIqTcXQcw==
X-Received: by 2002:a05:6e02:3992:b0:3a6:c97e:75cb with SMTP id e9e14a558f8ab-3a6c97e76b5mr25594865ab.23.1730666920050;
        Sun, 03 Nov 2024 12:48:40 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-a.c.engflow-remote-execution.internal (132.155.121.34.bc.googleusercontent.com. [34.121.155.132])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a491csm1661468173.155.2024.11.03.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:48:38 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	benjamin@engflow.com,
	howardchu95@gmail.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org
Subject: [PATCH v3] perf trace: avoid garbage when not printing a trace event's arguments
Date: Sun,  3 Nov 2024 20:48:16 +0000
Message-Id: <20241103204816.7834-1-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ZyV0a6e_46R9pmQw@x1>
References: <ZyV0a6e_46R9pmQw@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if the
argument values are all zero. Previously, this would result in a totally
uninitialized buffer being passed to fprintf, which could lead to garbage on the
console. Fix the problem by passing the number of initialized bytes fprintf.

Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
Tested-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3f11b90d025..5af55f4192b5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%s", bf);
+	return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,
-- 
2.39.5

