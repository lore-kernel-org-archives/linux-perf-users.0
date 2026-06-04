Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944240961E
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590994; cv=none; b=YNW8kOQkBQ9QvKRXBWZ6ItXTb147qhqTw1mqFiZl3VDbX6RxIzGKIgYO5cJdLrz8TdFc/AMpHQyqzz0BL+U4bMv7rMnxannX7WelxN7rmu5eDU4hw9Y/k3ciT3a3z0SlJqWKdUq9qI70ArArrQThdrbPd+KpsxZw/iana7BA8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590994; c=relaxed/simple;
	bh=8KMwVDloRJv3u7zQ1QoYLXuBk6F7DA9qXzQl2C1aT4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PrwAFlafpHONCOfIghQ4q2Ztq2YX6FWIRr/wPipnr5BRWtKN3TJejdv2A5UWFibVa1kZK834D1/UJVluEScNVOGru/gtrqsHxRk2AiA6WKbf7ArQ/LnlZj6Ej9pgj0teMMxuxHzu67yeCg4o2Zza7v7d+m3b0mPqW0m9xvk/qkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ph4WULqR; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ph4WULqR"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3074d4102a9so2909724eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780590993; x=1781195793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzNq6Wpskn2PvTG/URY7scuiN0ETAqqQYLor0Df9R4k=;
        b=ph4WULqR/vPjogD6n2415ytXF0lXsrMZnCkz1LnfzwWQTUW5bfzKTjNahiD/FkIxKI
         DlumGT4+jWZkML8958Kc20BqrrrOSAjiGPj0L9HwzDkNxBjD9fMbKnGI0P6j3rQkFUva
         Ka/wu4rNB3dMvlmM46DYoqlRNEkg/0xrPUQHrfwHEreGCaT32m/DN8VJ75ivrORNEcYr
         2y6sJdaxGVt1EpplyvtjWxryGCecPGcXKOQ8IqIUFbzfgJ9Exzd1MlzksE7JKevT3Y59
         4F2lYiK8us5tm06MG+yqGZi+9GHuA2qHoJkLYaiyjrlgrtpY3snXzIVJwkD7cUTD4hpe
         B6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590993; x=1781195793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzNq6Wpskn2PvTG/URY7scuiN0ETAqqQYLor0Df9R4k=;
        b=Yrpfeozh0sKVxNMaeDRN5JUQoCJcn95Ee1LO++BLdQzC4+ZR/3Evkojx4ugS/iE3Td
         H6U6l05+uoJ155L+6xE39EzAqD+HUldmlc5MFTz5mVlNGCSsBlO40uaoNdf0QOKv7zTb
         4MSF4nhcTa7Priy+rdmECus5a+rGCJFosj9MUrzmyLZgJ7Nw2sh6FY9Gze1GpEfDK0jT
         5U+MRZNeGk2g6KDu7B44x6gDH8wQ+ZdGgrQ+lriZW9qtCOu7ljpcFUH7CyoJW1z+RD9F
         k7IChIQyIcotzE2Dwckfq08mELFFJmrPoKnu/H0LoDak/ulMfrFfPLUEZ/6mkM70v8YA
         jedg==
X-Forwarded-Encrypted: i=1; AFNElJ+aSlX/yZEGJDTTW6LAlJNXKHicK4fWng9uiWNpGknmMTI1khMbXwo+AFC28N57GdMJCozd2EH0lFU1pIFcsvWO@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7ENppa824VBsJS/mEJyFSl8fUXs3jHjCRaWnzmtb513vPHTV
	0C4BjLn4TEqJaK0gA7gaqk5197IjipzpIDtYDUEqeAv/VyCT09EkdMzVqdRS3JcZRZ1kZcw4g6I
	EU0Cx3+sEJg==
X-Received: from dldz16-n1.prod.google.com ([2002:a05:701b:4190:10b0:137:eece:fed7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc03:b0:2ef:8b91:212
 with SMTP id 5a478bee46e88-3074faa0516mr4758558eec.14.1780590992391; Thu, 04
 Jun 2026 09:36:32 -0700 (PDT)
Date: Thu,  4 Jun 2026 09:36:25 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604163627.501078-1-irogers@google.com>
Subject: [PATCH v9 0/2] perf test & PMU metric resolution improvements
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This series contains the final remaining unmerged patch for the perf test
improvements sent as v8 in:
https://lore.kernel.org/lkml/20260602174129.3192312-1-irogers@google.com/

v9 Changes
----------
- Patch 1: Resubmitted the "perf pmu: Recognize 'default_core' as a core PMU..."
  patch, but this time with a squashed fix for a metric resolution bug due to
  its use of is_pmu_core.
- Patch 2: Added explicit clamping for max_desc_width and width based on the
  buffer size in format_test_description() to satisfy GCC 16 and prevent the
  -Wformat-truncation warning reported by the maintainer.

Ian Rogers (2):
  perf pmu: Recognize 'default_core' as a core PMU and document matching
  perf test: Truncate printed test descriptions dynamically to avoid
    terminal wrapping

 tools/perf/tests/builtin-test.c | 70 +++++++++++++++++++++++++++++----
 tools/perf/util/metricgroup.c   |  3 +-
 tools/perf/util/pmu.c           | 19 ++++++++-
 3 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

