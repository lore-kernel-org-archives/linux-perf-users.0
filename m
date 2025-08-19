Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C227F736
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567642; cv=none; b=jkWBNUSYPNBui6FVH3Ia3UXeijeKfKxX4/HNVFJ6IdlPc04MSn44lcDN4StpEYDNC8upuphqzDZOXYeWwY7jpH9vzxV6OtKowdVAreT53B2e3SOK5GI5HBh4IQ1JwXX6cWrliJxkFIeg3qGXMsQn4K95Fiujuugq4NJlIY0bZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567642; c=relaxed/simple;
	bh=dReP5xDSocTLXuE6lV+2jz+6UPBQqAGaaJLrbMKD+n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IN9fLicjRwY/bIedL0Pah7ilzQMwL2TZNVes2+ow9AR7bImgFRw6yy5V59yCCuFQZZ6Wdc8sh1GafmjJOEjm6c7wLSyzlkr6oIHQQXOH+wj3PFxQeOTBbKPKCd7/esbJShQ6YBt5jIMpAY5rE6WGdb2bsI2rKyryQeS/OoINnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOOMkGGg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOOMkGGg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4716fb7f2aso3838683a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567640; x=1756172440; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fecVTDRHORXkJ+Si5yHb8EKxcHl1U0RUsg9Sl2Llew=;
        b=VOOMkGGggulRxLX6vQEihLq0JZJIKWUPwZXJ9UfjbdW56FBdjQkXyBH4mxvGZSgYBR
         0NDE49XQu/kFsi9z9p/9SfSqITNZhZdGVeBmi89vC0BaV5uLKW3jc7mbyozyCZ0oTkKz
         sPGNU2weCB2ZqVZSUNTodteAbLrZriRDnwDG51CWpuV26stj02l83jKNq8AJFJ+2+S1V
         HvIvpqCeynjtBtu6cDmaS6p8xRneOK8lYd2KUfbSt7bMgalgATrASdMKgV3bBmqUUZzq
         ikX57M/FWJM/2T565AlxXnNrzsSyrxKh3+urIgqVDBAqMgZtmXupB91+FZYkMXOTbg8u
         xrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567640; x=1756172440;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fecVTDRHORXkJ+Si5yHb8EKxcHl1U0RUsg9Sl2Llew=;
        b=O0iZMbX2+Oso0Y34m/JwesLO46zXG03Nlp4C8vZS78i3sHaIbqGRmk/pjTmkzCZlVX
         OV1zXAedIIhF392cHBsY0nr1YEMzxaBziNAESVH3UfetBLpSvZZDV5FlfDk5Cq/AHaLF
         7vJw//NxgBaOaQIbk8e2/eOlNQ6hgJJXKGfaAfZGi6TORs1tF9oIGNdeGmi83NOzCeX7
         ubLcGig6zwn/vPms+wUCdDzO9RlB8pYWe7MUZC3wOCMu/oqHTcp1pMNTw/jcCpZ1DFOr
         y+DU0Bu3kLSLow+EgjRjzde1i9MWrkmYAOCks5BhBG/Iw4qIRvu2Qj3jmzBp98W0cthP
         XoNw==
X-Forwarded-Encrypted: i=1; AJvYcCUh6QMr87/0fL+v49jXZLp+exyepEproflhhOJJjLTya1nLk58oeHpjn8f6ww+LCxq6Cpgwbycl4fr4Q+KyKpDm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4W5GLJfYKnT7Sjb0cGAJfKCDZ0/kd2ADkSXchRmhS6vr49iQ9
	JM4JvrMABfITPSpUp0y4KfV8g8qLWS20ilOs1huWXZy7wfJmXI4dL7PKHLOpgLL7p427sW7X5FF
	QthrvDbobBg==
X-Google-Smtp-Source: AGHT+IGMkP+UAP1J1Ztwnt5lueLRrYAM/WwzRYwBr/B+bGN+5hlJ2J50How5Xyv34FCbbgUYfCBsooiLdK1D
X-Received: from pllw7.prod.google.com ([2002:a17:902:7b87:b0:234:9673:1d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f86:b0:240:72e9:87bb
 with SMTP id d9443c01a7336-245e04a417fmr8203565ad.42.1755567639941; Mon, 18
 Aug 2025 18:40:39 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:41 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-12-irogers@google.com>
Subject: [PATCH v10 11/11] perf tp_pmu: Remove unnecessary check
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The "if" condition is also part of the "while" condition, remove the
"if" to reduce the amount of code.

Reported-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tp_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
index e7534a973247..eddb9807131a 100644
--- a/tools/perf/util/tp_pmu.c
+++ b/tools/perf/util/tp_pmu.c
@@ -88,8 +88,6 @@ int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
 			continue;
 
 		ret = cb(state, events_ent->d_name);
-		if (ret)
-			break;
 	}
 	close(events_dir.dirfd);
 	return ret;
-- 
2.51.0.rc1.167.g924127e9c0-goog

