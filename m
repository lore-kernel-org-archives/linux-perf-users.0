Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC933A6F2
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839476; cv=none; b=R1aCOSqYljZxgIYNUsagxr4DSWUmTudcqC/ItjJLO5VwI7VGE07U+0LoItF1wG13OkMEln0cECrmxmmf5nEQAa3/wbd/XMdG9T+BziO9TLjXMCz+eL+odaRYUFYO5Z31gJMATAp7uEwgOfAgWr3BkESnzi8kAdM/sHjAn7B5jTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839476; c=relaxed/simple;
	bh=3wOzLj8Dr3Yx00GeCxniqQO6HXLniX95ht8a85EYofE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WY54Xt1NT5fJkrRtdRHzEKJrsfmRzYPnkoeUSGVOQOtNkvNLuWS8rVvuuYvNxlEPtBDeId8KRmY9RxlXdklAsc6L+aLqZQngph6U0Ovip61vt6e5jWD/xubugKSeUharXQ90mSAZUFl+3HhoLDUj1y0GO11wj3RSMNWJqfv6IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eYjxfrlz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYjxfrlz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so5210265e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764839473; x=1765444273; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mkrkTlTgzXOforILOdQtyqUhxwqK/CVsXU8Rb+kTuY=;
        b=eYjxfrlzSrtbUS83LRlEesP9kV/McjFmPzC99dDJqre4m38aKMkl9OSeWc2bLIi1N+
         rUaC8Y6vukXQEUygAGZgusyVSKprjgns+c2hsCjgK1QvPESt5SATzim/dqaJCOvAZ7OR
         brz/ojt5J5fBc6Lz+7AkYDZQ9HGzi93jugmi9nt/XTAB3G8APW8eNXXLxM673cxDDg8w
         RtFSzlPpCLY6FiJAyW+TqR9dTHr00HPIXuIUsC9yJRqZn7CfVaRvFwivqAUPlcjYNK81
         bwUhhMThCMchliRUwK+OEMOQO7VYp8+mxeSisldHZc4O1YoOzGFciQlMZvV7UdhHA4Cs
         ItyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764839473; x=1765444273;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mkrkTlTgzXOforILOdQtyqUhxwqK/CVsXU8Rb+kTuY=;
        b=M811quJB8UrBrU1wu/5Qq3KXTyWv1g+HjRlJI5PAJfNABHYAoX3r2MDwjVYWYUqSHT
         CebuR7kbxW+rDqxkQC/CZu5qFvSnA/ggGoQaQCZ2nft7Hhnl5NIjZu1rCTrtTacE0fAp
         hvzqw1Oh8N33R4ZG5vDqbyglqxqw/xA1F8IB2U4mYnBuhLpXnoWIqNfw/DSxaMradGwn
         SSr3QFbyXF/M2m/OLd1rgkYyUxyaqKrYLJpp2P4dmdEx1p6/UqcRq+B8/JHQ6CQAERQc
         Hp3EeNV/p0LBOoXgZmyH6HaQej7DCVUtQVc2vx/4Fvy7UgNLTPuKQmL/vsqExMx7x8My
         C1Ew==
X-Gm-Message-State: AOJu0YzkIhOKoyBvfsHqUmyL/KjHvWJaewMYkWQKKa1FE4guZJaMYjRh
	7mHxglaUlsxljNcx94KSxo8t0kN0+8pZLpo62MfRk0TXWjt7ZKhyDnLWHVc7/mkG3EK2Kt29mkv
	rQtt/
X-Gm-Gg: ASbGncs4Qw5EpwBuuKlElmg8X3uREZaqArrrdpATYsuSz9vq/RIDx5WntikVYCgwVip
	la2HxcpuHGyxlV9/WTLjtToEhM9XczrBPzIwLvuBDy980PzdA7prZGzvyAiHUm1bbK5dUkv3oXL
	AWaufb7H/S/QgVD4DXiboukHGhKMB0se9z+XXazccdKlnSx2R6RVkOvubcWgIGvjzs4cAsKqi9T
	1+1hSnLnCoITpZgEUmj7VR+IzqchfNBnWwhMHXyVkI+9CLNjyI4aYSp19ZAyQ+ASxA5YpUL0dLU
	BbywOJLjgYmLuVvZsWTbWj9bGaXNnZ/JQLbXdfHVZCkUlNzOAf/X0270gQODmcHn3M+/ZokKo5R
	jytIXBA+Q2Ii53/iOsyXP+pa7J4FBxAjz5q0P+lgy3xifYOrFPaMWp1y0Lhx2/IyzAD+n3kjPy8
	ABK17f0OO1N8kRWNRK2pY9vG58974cfHA=
X-Google-Smtp-Source: AGHT+IEyxJcDSUpKKNbq3TmwHngIwQdNEiyuv6p9WlVhdTnW/VxpE93iUX8XY1iwxJroWVu//RfSgQ==
X-Received: by 2002:a05:600c:a07:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-4792af4d463mr54090155e9.30.1764839473204;
        Thu, 04 Dec 2025 01:11:13 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b157783sm38720515e9.5.2025.12.04.01.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:11:12 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] perf tools: Always uniquify event names
Date: Thu, 04 Dec 2025 09:10:52 +0000
Message-Id: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxQMWkC/x3MQQ6CMBBG4auQWTvJUFHEqxAXBX91SCyk0zQmp
 He3Yfkt3tvJEBVG92aniKyma6hoTw3NHx/eYH1WkxN3aZ2cefFfGG8+GhgZIRknWOKpm2VwN+m
 vnVCtt4iX/o7z+CjlD5GJdB5pAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The commit where this test starts failing is commit 2e6dc3b9334c ("perf
test parse-events: Without a PMU use cpu-cycles rather than cycles"),
but that commit is only a test change, whereas this fix is a code
change. For that reason I didn't add a fixes tag because I don't think
it's worth the risk of backporting a potential behavioral change just to
fix a test.

I'm also fairly unconfident on what the impact of this change is, other
than there's no change to the test results apart from the mentioned
failure.

It also brings up the question whether we should be running the tests
in both verbose and non-verbose modes by default. With a non trivial
amount of behavior being affected by the flag it seems like it could
catch some issues. Although it would double the runtime, and not all of
the tests will ever be affected.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf tools: Always uniquify event names
      perf test: Add missing newlines in debug messages

 tools/perf/tests/parse-events.c | 6 +++---
 tools/perf/util/parse-events.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 267c2e633af6e9461477bed91e428993f8b36ee8
change-id: 20251203-james-parse-events-test-b4c092807640

Best regards,
-- 
James Clark <james.clark@linaro.org>

