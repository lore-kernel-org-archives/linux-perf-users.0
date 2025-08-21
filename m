Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179F22D7A5
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794310; cv=none; b=JDjywwpAARFw5NSYw//Va13X08bgHZV8OBspj5mbclLFKbKya68mg0BT0bgdcPOpMWH+95jnphBG4XtWwIOg2DEV9I2KmCjII5PzidD18yx+VnP/+SAotZER4JfAvqGvzQxvQ8AjZzMI3WunlNDEmB2ESWAm4Ez9pHokvZ/0j10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794310; c=relaxed/simple;
	bh=FmSZRX3koaRc5xVjwiZ4Y+oDfi8L1Fq1v8ZCc/U6jCU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=T4qTJ6gblAwpFPVTfDbR1bEM5gZbK6kfeAORzPzyGVdx+k8adADHp7UaZP9uo2TGvhKIvLX7ml4wV8IkoJkC3OYFK33tIFbOZP1Lfx2CY409tuJZJ36veChJGOGP1R2TdLqWotApIqyQjbp2TmR/8RTJy/Yalp05dtDkdWTTI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8ENoNUY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8ENoNUY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-245fb4c8789so15511975ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794308; x=1756399108; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1pc3BsmB+4h6SdwgDkAJflcNWhD+GOK23UuzPvNCfo=;
        b=t8ENoNUYCyvfeTkHktjan8UghEpjFqsHjjwqOyc1lTCusMWQYl5TUB97nByIfHwd2k
         8pygEpEU45RIaAn3SWy4SLqa7cnFh7qCH9fKcmsKvf7Zg4sjIz8t+s8gJwrQlXKtGCzm
         6g8uqWyxd/8EHDCLQE06oH5cfpmCAplyRHX2ywD4g4jusaW3wFFR7E/jTpfjdkJPd3RO
         h+hUhn8G8MBKzq6WEkTTPsq227ChYqRHRxyiQ1TTqxuHLV4ufN4Dl4SO/OYFiJ/rmzGc
         5NXQjaQ5Wo3D6vamw4y+5reEAvwbz9JJfEflA+kdXJcXd0ZsLdMwlISnU8JiYBSkkpCa
         5EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794308; x=1756399108;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1pc3BsmB+4h6SdwgDkAJflcNWhD+GOK23UuzPvNCfo=;
        b=TPlq6f1Rs2fF9IJWXzuuk2uumAYS/oDbrh2LHrmJgzfyDlvbq5g22uwMzMiEWPFGDF
         GaEXOBxrGVYMgpptFmOW171ywCRFzvI9wBx/U0igzWAZ65/LK096vksHhijQhZjZgTas
         j1L9kzJUfwAaTJ71CS+YohNDEsQEqJTJJFljGVLGXtpb2aAbQlVDozAex20SjL7yP8EC
         W9wpiF3yFGaSWMDKBAWefk6OzhXajwDITmMzlYG5yUQzYoAvvif1RlTgynQHDuk+Ex59
         8mbQ5HuKt79vVdd8qKAa+OM4w1/l1fd6ByAkmL9TKXmcTXXG3cBd2qvRfqZeHmNl39rw
         EnNw==
X-Forwarded-Encrypted: i=1; AJvYcCWlhxUEeHX4UlNqD0jIb3ZJ8C4NRg4xcFkCLNarMKdTAsLjT1WWuz22CnqcROaXrS+EIZuapXHyYxGAN2BqOZgo@vger.kernel.org
X-Gm-Message-State: AOJu0YwC17UQLnU+TLU/SDZSe3cs34oYsPZkdb8lHAVMYDj0Gnb2EoIA
	w7PT2RBagerBDqloS8j03NzP90hPzYBdjF3UqgyhzksKA/o93MB93RCccnUOWTnr62/qyZHlV5h
	tYmjyqncOUQ==
X-Google-Smtp-Source: AGHT+IFt9Ngz+QPPxTxk9IR/2Mz2ApN9qOA4RZARGm+TgXKmf7I0vyXwgMSWF8q54fYHcE9PdsXwH0d1Xdwr
X-Received: from plge17.prod.google.com ([2002:a17:902:cf51:b0:246:500:6de8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c9c5:b0:240:41a4:96c0
 with SMTP id d9443c01a7336-2462ef21b46mr1155ad.29.1755794308363; Thu, 21 Aug
 2025 09:38:28 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-1-irogers@google.com>
Subject: [PATCH v2 0/5] Various fixes around undefined behavior
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix various undefined behavior issues, improve tests to make them
easier to diagnose and add assertions so that problems don't recur.

v2: Add Namhyung's acked-by. Drop container_of assert that ptr !=
    NULL, to simplify the series. The bsearch UB fix was picked up as
    a patch by CT:
    https://lore.kernel.org/r/20250303183646.327510-2-ctshao@google.com
    It seems this patch series fell-through the cracks as v1 was
    sent/acked 9 months ago.

v1: https://lore.kernel.org/lkml/20241213210425.526512-1-irogers@google.com/

Ian Rogers (5):
  perf disasm: Avoid undefined behavior in incrementing NULL
  perf test trace_btf_enum: Skip if permissions are insufficient
  perf evsel: Avoid container_of on a NULL leader
  perf test shell lock_contention: Extra debug diagnostics
  libperf event: Ensure tracing data is multiple of 8 sized

 tools/lib/perf/include/perf/event.h       |  1 +
 tools/perf/tests/shell/lock_contention.sh |  7 ++++++-
 tools/perf/tests/shell/trace_btf_enum.sh  | 11 +++++++++++
 tools/perf/util/disasm.c                  |  7 +++++--
 tools/perf/util/evsel.c                   |  2 ++
 5 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.51.0.rc1.193.gad69d77794-goog

