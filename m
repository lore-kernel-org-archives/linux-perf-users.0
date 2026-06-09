Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921A3BCD23
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024254; cv=none; b=JwWUHRvvO1rCiFlaDIzmjga7VK7OO6AecJAZQmJedZT2qRtv7O5n+jq1YdlKgTr0pjQcHQkHsIfQIk4WjYQfmqTpFpowS9xsqn7TalQNSu8EN3NTLHtC1MJuXAWiI6JUik7z1yeIPW8T22efjdCIFXnApbIKk76e5dk1qrOlTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024254; c=relaxed/simple;
	bh=j9rAu2ch3U0PopGp2J2OtpKMyKPvVhnNhyR4tZXXCII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJia4zzGUo4ibc1WB5bZwd5qPFpFcLFYtYEDuE4EeWuBGaFsu7Yaas61JOOCELa1q5DgQvIZ1uvqRAek5iiP8pht7yXqXz2cIYrMm1GmjmLvCgnmjWuA2MK6rah0Y7m/ZUDxmZLSUnluy2wmn9j5CDtOWxOHeqYSp+LdMMsR/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXYNsfiq; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXYNsfiq"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d8613efbso5862049eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024253; x=1781629053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MaddhjZSLJjQwBreN2wO4fD/cwTQ9BQwJgEVkkOTsM=;
        b=aXYNsfiqhrreXKHQ48e4kRTZXBQgQrHPsHrrk5bbC086gbaPMT41yRkSCpY+OzIp/U
         Zz2NPyLIxvNUptLKnocAIAKcRumfiU29RUa6KT/6TnTkEyZnE7aHLeWt69/6oYCqw7PF
         ODcScB9Rpc8Av7K1gLNt1WA7TxRUgyAWOlUbJ4jRXvTDJimD4BEbAjlUgQ8zrATCWsCe
         TjXCo7jh3dmlWNEBcV00sRu80XTZnojSdh6lfIs+5EV2yt8G6RtG/EuYsMg1tTRVvYhY
         NgaiJs+ctKrYQBOjdMLafwDTg9IZ2co8fwbe9qyeXVz+GMomVpGkMnlBoLJ0jYSbWD9h
         q0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024253; x=1781629053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MaddhjZSLJjQwBreN2wO4fD/cwTQ9BQwJgEVkkOTsM=;
        b=rt09p281vc/3ShuOmXjcLgOA82iz3cX+JGlWlSH1R5D6jl5vHUU7aICGiCanoYx1da
         RzaqiPC8uWG9PMJ7+LZga+lPkfhb6q52Gn+duWQ4W5zo75BNL638nOWcC3d4df8eX5Ay
         IBEJOBVsu1eAcJ6gBPfu8zyD0YQ5J6k3P6X2kBNNbmumP2xo9zdbWHutYAmdQkxgPlhS
         LS1dmA8Ss+UhEpU6xZQSbtkhmUqLJoPge53bHbCBQZ6Cs3WxvnZphtd5Z4k2TLFv7Kvp
         q3W3073HeE0GynT/lDF8/Y5qi2cnPs/lQqUASZ9anFItOl8ue+dibENnuNqZLiqOUr3A
         sF/g==
X-Forwarded-Encrypted: i=1; AFNElJ/TeYEfkfu9uIzKwJhUzo5drA0wrDOU9MTZ1QfD2aUkezBVsAyumWx1N7RxnaJxWLJ0DrNr1C0l+/6JuWH9YWKw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5LQgYDFJzDq/Hn4ODHMOwaCczsplAziS/vZJ0S3qxlk4TSN2
	AFLvyV8jv0qNt/qQsDTBcwRzqr5k/WKTxrZkOd+mg8hkyq+VcgBcer6C/tw7v+7UmvltH+42141
	sKeVeUreRQQ==
X-Received: from dybpk17.prod.google.com ([2002:a05:7301:4291:b0:303:c230:ac8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3b06:b0:2ed:e14:e954
 with SMTP id 5a478bee46e88-3077b8014d6mr11298822eec.30.1781024252274; Tue, 09
 Jun 2026 09:57:32 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:57:23 -0700
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609165726.786694-1-irogers@google.com>
Subject: [PATCH v2 0/3] perf pmu: Add tool-provided NVMe PMU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, yuzhuo@google.com
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, ashelat@redhat.com, german.gomez@arm.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, mjeanson@efficios.com, 
	namhyung@kernel.org, peterz@infradead.org, tglozar@redhat.com
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a tool-provided PMU for NVMe devices to expose
various hardware logs as perf events.

Using libnvme, the new nvme_pmu extracts metrics from standard NVMe log pages
including:
- SMART / Health Information (e.g. data units read/written, power cycles,
  temperature)
- Endurance Group Information
- FDP (Flexible Data Placement) Statistics
- Error Information
- Zoned Namespaces (ZNS) Changed Zones

Changes in v2:
- Fixed feature check: added test-libnvme.c to test-all.c to correctly
  propagate fast-path discovery failures.
- Makefile cleanup: added libnvme to FEATURE_PKG_CONFIG in Makefile.feature
  to ensure correct pkg-config flags are used during feature testing.
- Alignment safety: replaced strict-aliasing pointers with get_unaligned_le*
  accessors inside nvme_pmu__read_val() to prevent crashes on strict-alignment
  architectures.
- Heap safety: refactored evsel delta snapshots to use a new 'nvme' union
  member inside struct evsel instead of clashing with evsel->priv, preventing
  memory leaks and heap corruption with active tools like perf script.

Ian Rogers (3):
  perf build: Add libnvme feature detection
  perf pmu: Implement tool-provided NVMe PMU
  perf tests: Add NVMe PMU event parsing test

 tools/build/Makefile.feature       |   5 +-
 tools/build/feature/Makefile       |   3 +
 tools/build/feature/test-all.c     |   5 +
 tools/build/feature/test-libnvme.c |  11 +
 tools/perf/Makefile.config         |  12 +
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   1 +
 tools/perf/tests/nvme_pmu.c        | 176 ++++++++++
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/Build              |   1 +
 tools/perf/util/evsel.c            |  13 +-
 tools/perf/util/evsel.h            |   4 +
 tools/perf/util/nvme_pmu.c         | 537 +++++++++++++++++++++++++++++
 tools/perf/util/nvme_pmu.h         | 143 ++++++++
 tools/perf/util/pmu.c              |  15 +
 tools/perf/util/pmu.h              |   8 +-
 tools/perf/util/pmus.c             |  31 +-
 tools/perf/util/pmus.h             |   1 +
 18 files changed, 960 insertions(+), 8 deletions(-)
 create mode 100644 tools/build/feature/test-libnvme.c
 create mode 100644 tools/perf/tests/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.c
 create mode 100644 tools/perf/util/nvme_pmu.h

-- 
2.54.0.1099.g489fc7bff1-goog

