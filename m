Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94926AE6
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724038239; cv=none; b=LiMLqjdMahS4loALO+9ccq7vQ3ycCe/r0VuqA/uhgE9JeDh1T0nzmUxq7kw3GK/XvK/dPc/BufZpuiJom8j30r9UIqf3AlgOwpYHu8p8jzMP5MwEnRVmRROda/vPX11y7s1uThClRth4u2FzrIZBnOmvfSmloJg0vhDYD1S20lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724038239; c=relaxed/simple;
	bh=smeT7btf6vic+0qDBBQF/BAOYLJRLwA5COk3VUkS1+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kiPWVG1CFwqjIxkV1XXQTR0Y3ZnKAb3Kiz3fV1edwdkvD+MilUTTz7+LBoQqJgBgOjf1dAf7XjqH3zDy/feKkp5drj6bwwUHbRGgLmeCam9gNbLDKNLdUNQzad6IRcQcqplGuvAXyrmJjpHpWEh0U5XULH2bnv7mwXKgJA7h/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CL8Cit2Q; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CL8Cit2Q"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2702a00aad4so1666424fac.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Aug 2024 20:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724038235; x=1724643035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQfYQdhZ8IPGBzuFqvB5A5WRRXptMp84Fb1B8wo1jYM=;
        b=CL8Cit2QdILMRvPsSnb+V9GG5qWTn7zZoAcJEDJVuDH2tlc9HxutaSJK5TeXjOGFV6
         74vLlSsJdb2nr66vXoLvw+6JTcxXxuMcvqzTwX13pxAdsigughM77ntA/lfeclGSBQ5Y
         gD7cXiYrwkvbL9hzSTLJ5jM9z+ZS80A7JlvkHizQ+dwp3q1GJkevz6lHyaiEjXUD+EEA
         QCmnT3qSlbSAkAAUhnVJUj69QlUXjapENz7XsTAsfyM8xiiibfafknxEfgWmOg+/D5su
         tW95yX5sT8ifI7CZHAxqhVuSS/cdyy3rlM548b4POEngMfcUg+Ax8qxSTJ1P61zBwgWz
         F7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724038235; x=1724643035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQfYQdhZ8IPGBzuFqvB5A5WRRXptMp84Fb1B8wo1jYM=;
        b=Fmd6bJsBG3F/Wz1BeWPHnl84D7tY4wDyDEzBITmK5yqwcaqmEaVPCpEduSGcp2F8V6
         vqF7EWYVSxIY4oOh4GGLRTIGH1Ok9AysefB/nVTV+r6+uVkgA7edhWARMsD4Gwo5XDgj
         WfKBPX4mbireToq2PlPF3LZV34xnapQDFottC4dKtcuR6yzxdGus12br/nRHNXejEHhA
         iwATX2/zhtx+rCWDVs4HgWo86G5oKGT8S5YoNxrEpTmMNyyF0IPyH3eEjmLvJaApprLP
         qerVz13Wn5Bldy9KFp/lgjRaLl3ePJBkPlYvVZ7XV64N5ZZXlO7wPcrPU/evpUu0/Mv1
         KHwA==
X-Forwarded-Encrypted: i=1; AJvYcCXjy5ZnVdkwg3N++6q3o11D+ra/jN7EM1rOZSZrDNFkejVAlRWzuR1LM8LaF4Q0pkqApGfB6h8+JXVqfHwps2pTFgTwzQQp+WvTiG05i+bBug==
X-Gm-Message-State: AOJu0YzwtYDOEFA5A5nAy0O+mn3kpUsa+VEfvpNBmh9FmhCkCjBfGGlV
	Bp5AyiA8zGFGVwboTIHtAf/tgAClZnbdu23ZXmynE+IjmaPWwCssWe7ghPdgzQk=
X-Google-Smtp-Source: AGHT+IFHiz8Kjr1wxrSI5Chm3QImFdtCFeaiOJOKmwCFkK1n/m0rAeva4T/VwtVCfeJrGbD5OlqibA==
X-Received: by 2002:a05:6870:3911:b0:261:12a8:5b69 with SMTP id 586e51a60fabf-2701c38ab1cmr10113833fac.18.1724038235353;
        Sun, 18 Aug 2024 20:30:35 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add83bdsm5816397b3a.3.2024.08.18.20.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:30:34 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 0/2] perf sched timehist: Add --show-prio & --prio option
Date: Mon, 19 Aug 2024 11:30:14 +0800
Message-Id: <20240819033016.2427235-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds --show-prio and --prio to show and filter task priorities.
Sometimes may only be interested in the scheduling of certain tasks
(such as RT tasks). Support for analyzing events of tasks with given priority(ies)
only.

Both options are disabled by default, consistent with the original behavior.

Changes since v1:
 - Rebase based on the latest perf-tools-next branch.
 - Enhance documentation's --prio entry, add a description of how to use multiple priorities. (suggested-by Namhyung)

Yang Jihong (2):
  perf sched timehist: Add --show-prio option
  perf sched timehist: Add --prio option

 tools/perf/Documentation/perf-sched.txt |   9 ++
 tools/perf/builtin-sched.c              | 163 +++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 7 deletions(-)

-- 
2.25.1

