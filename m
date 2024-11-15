Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF517C219
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701585; cv=none; b=rC9NlcugdQuVncvl4mezfUwzwDFl8roIrAv9Yp9zCEo706ZPW12BSNwQr5ILe60IggkPB/rqycLcWu040NrSCvaZBdHjXffsoRFT0xOyVQv7Y2sT569k9gioZjK/QVuMzkGWUJsLH3en4bpspklE9ipmLcDq6Ops0M4N335/Z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701585; c=relaxed/simple;
	bh=m+eHtXIYesv3NRRKMiKERalJo0Iwm0wUOlfkAFkwgwY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YY4wGws0E2AB4sZukgDaZvaqL9KO6n6Ysn1JmdLz6uxbX9ZKCjdczj0z3RuSLHKRCGIwO9vVQdGXq51Ud/lBB+8Zd1N2XkiqAc34ew53i04FEw5WI+aidN0C5F/gHDBhfXS7FFe9ZvLC+diMItb1PTnhfMkxtDbN4h90243njgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iawZBEvo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iawZBEvo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso43886177b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731701583; x=1732306383; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y7jHK+GbETyp0OO2qXYbTg1usBpehhjzisVMru6QF1g=;
        b=iawZBEvoKXe9bUJHdvxc9Nu9q8fzczw7GS9JP9TwpJIUf+oU44Q9gQxtWC++fsWxEv
         ibPD1e2bQ5nVZrf0lNbwAeMKUrXzTbREBIQwX9aNyDC/LMW6hq05+StfzGaj3BCAfUSg
         O1FiLQyvtOm0l21cGGmQPA+1+vsC/+tUEEgsHfWfq6KxOwaZ9m9OvaHyffLD87DqU3DM
         IqdSNc1mhC7tt/3jN9i5EXsdXONOH+lWhHvsxl9ltF2aeIrESBK1RnX0rC2CWEqxtkMx
         mUGH1D4PzeS3t8mz2lk/h7EnqGz8m4NFBtO9XtWdC0DYN8wk2aXxwPy+YRmOvkX/c2qi
         VINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701583; x=1732306383;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7jHK+GbETyp0OO2qXYbTg1usBpehhjzisVMru6QF1g=;
        b=j28sBl+12J/ZnAFFQAhHgRb3tLwgYRfUUQUE6juwd8Rtal8mpi0sOZdpKEEzDqY5ut
         2mYihZmHahyCpdqkuSq8AOdHYYH/q/wGi1HoEEVvlqLX2JzLnQz5DvWKyM2swXbRIvuR
         NaGtqxKwb1Ik8pYUZSVj6wk78f3fcVbem1eV4NYm92G88rnC12hftWjn532/yrZnE/VD
         GL/t+2skW3dhFmFCOjJU6k0nWM64gBWStVduxtlHtHQ0YjWMSSwYo6YYJ3sdcta84mAY
         7Ezx7X6Os5TuA6bSMwEWvYSuH/sauM7i3P8IqR3DeMEch67edCXIhZXN+W1QrQY56a8q
         Eq5A==
X-Forwarded-Encrypted: i=1; AJvYcCWDgpzud+VA1aMYuLn9MVblD/uvnzaFkh8GUhVBUico+JlUgEdIzfttNX6VwRW5a67J5rOZgqnYgwvFgIulj+FD@vger.kernel.org
X-Gm-Message-State: AOJu0YxRo94t4US1WtALe0HeBgnoYjENg9RGxav3JMrtaUk8XiEyIQy1
	iH3JGVBkndx0p2vycnceP47caS60L5+Eg05nTHyZIDpMmgY/JuXY4bXtQqj8EZHUPETFBeQ2iSa
	9EaohKg==
X-Google-Smtp-Source: AGHT+IGbA4tPec7D04ekbvWRX3ylNEsk5f4b15tsIirX/ilzfd3WQGhYbnxgN37YxuJ3mxH3LoIA4miKdtWe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:126f:8a1a:a007:1ce6])
 (user=irogers job=sendgmr) by 2002:a05:690c:5b4f:b0:6e3:1f46:77a6 with SMTP
 id 00721157ae682-6ee55b8356bmr630007b3.2.1731701583288; Fri, 15 Nov 2024
 12:13:03 -0800 (PST)
Date: Fri, 15 Nov 2024 12:12:58 -0800
Message-Id: <20241115201258.509477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1] perf test: Add missing __exit calls in tool/hwmon tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Address sanitizer flagged the missing parse_events_error__exit when
testing on ARM.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c | 1 +
 tools/perf/tests/tool_pmu.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 5c4114354c65..9f44093f18df 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -194,6 +194,7 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 	}
 
 out:
+	parse_events_error__exit(&err);
 	evlist__delete(evlist);
 	return ret;
 }
diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index 46896b485abf..187942b749b7 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -66,6 +66,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
 	}
 
 out:
+	parse_events_error__exit(&err);
 	evlist__delete(evlist);
 	return ret;
 }
-- 
2.47.0.338.g60cca15819-goog

