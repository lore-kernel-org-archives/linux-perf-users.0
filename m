Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25C1FDE02
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448063; cv=none; b=HTSsCJIh0qa9GkOYHkR62PR10xNPBdbbaKARtoej9j/+o/TWyfyaqn87Dve8V7ZZF+eaSL3GASVZO6ub+XnEDmAS9he6WaXnjsd5hNylRIjUkkIelt7xTHcBv76Givg1o3bl0XiLN3grXm8QnFlgcd8bEe2SKxPpeQZuA14XZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448063; c=relaxed/simple;
	bh=rb3nJ50Qx6Av0jjPKM4BDhZRCZf5SaYdGkra8TgFlyQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZdM8B6kSEMgohBN7HXFeIY8H+YCHSGkhsuzQkNRImxm0b7ksGuU0wgoUI1PsU6DbutSccqRp6k09G+OED/ZHPMPz4U17In9JNMYdfjmEbgXRtNCnGulMacAbQLMqzCdaUo9eQDbbQgCJ9ThKeN3Xehmgef5Yhkz4m+g/8nJkvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1cJqO3It; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1cJqO3It"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0f608b88so2673604276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 10:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736448061; x=1737052861; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XY2zs0NTwgAFtZHHxTu56AgcGBqwz9PeDUjhHd39VYk=;
        b=1cJqO3ItTWH5pTwQeDjCidj6AjbLpsgTdOJC3Zqwm5PrMNoG5QoKWjh4W9kvd48lF+
         Zo/beixUsLlrdZyXTpb39CAzRPlR66RfJL3aQBpPiNpBHUMIUGgMrJFfTM9MmM7Zslgt
         PscC4ZGuYObB6plbIc2sovfXQVx2O0q5497yDZD8/VSGB4OUemEBpU7hO4xjkXEnJKc3
         2qA1bhbw5/Nw9UngR4di1KC6H3Bj6yc4Fz0Rd3HRLenfFAAOVZihM7zEXvNrFRsfbLED
         ibEoohLb7cvpEBuqIB2oAsPN5EfktwWXLRJIpue2iXDnVrPUIfeA6ZICjMoUOB7SSvxs
         SOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448061; x=1737052861;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XY2zs0NTwgAFtZHHxTu56AgcGBqwz9PeDUjhHd39VYk=;
        b=WV4Og05gvr5enHFMfoyptIkGNh72cDLlUsqBPal8I2PPBs0PiHVZ8qAcSKIGh4oEb3
         mMUxmGq2uh21sD4+5sITg/QkxUgwRoryutCXUA3IdTXh0fQ0wjR6YURN+oIIJjVZxJpk
         sqgTM9yLsroAhZT9B9WM8xfTeRwJ6qF9gcp6A+ndqqpp7DSopE0dWWQyLwB9pJopO7W0
         ZaYymgGk6txB7yVVg3SffTOJRqTQtREYZCy5Z8CLSUGi+sC7ufty9wXTZ4H4xBXlFNRX
         wVaUui7vEuGvzSaJaJv7BiV02hKQtvVO5UCANJbB7VccLIkldkTcn2+yZVPO02OEeNhX
         C0uA==
X-Forwarded-Encrypted: i=1; AJvYcCVZf6k2sDMLgkNWcB+AmmBa+0YwrWxdEEdnGCjzrwtwAhm4p/DUcheDKtz8p7tQN/mnOemSmsS+pR/73Gtl7tvh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CXCMT9Xu7yoNcvKcxYNyaShEp6G+nADSC/M/HkUkRgjhbaI+
	dyxdimPbk33Gk7OCgef5bKpLq6kPzyLtxV5wZF7EDOrjYPgVF5saL1UxTzrXGzwVNWkB0qwnMmg
	bw24+fg==
X-Google-Smtp-Source: AGHT+IHNBvMWxanjKC8QS7NH7qsJsOuz65mVwiMf26a4eMkkRLNSflqcdOavXLImDkXTJ2bKRo+CcSYhllmj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:acce:0:b0:e53:9459:3ae5 with SMTP id
 3f1490d57ef6-e54f01d5fbamr17539276.7.1736448060647; Thu, 09 Jan 2025 10:41:00
 -0800 (PST)
Date: Thu,  9 Jan 2025 10:40:46 -0800
In-Reply-To: <20250109184046.193736-1-irogers@google.com>
Message-Id: <20250109184046.193736-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109184046.193736-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 5/5] perf test: Improve verbose documentation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a little more detail on the output expectations for each verbose
level.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 85f868c324ff..32da0d1fa86a 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -28,8 +28,11 @@ OPTIONS
 	Tests to skip (comma separated numeric list).
 
 -v::
+-vv::
+-vvv::
 --verbose::
-	Be more verbose.
+	With a single '-v', verbose level 1, only failing test output
+	is displayed. With '-vv' and higher all test output is shown.
 
 -S::
 --sequential::
-- 
2.47.1.613.gc27f4b7a9f-goog

