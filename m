Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35D372B48
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359822; cv=none; b=u6cSzQnJbE+guYnYvko8q5Jkl/R604BdsRfmLYD9Lz7uSCnVqgFyLtBAFunANHNrgA7MknGbo2+KGCGKptubhDgBG2AmuHNaqq8avlyoTjH62fUTjnzPgLbYK7l+e9PF4ydYZS5JCYIJT69wyqZnOKPEgu0F6e3Ab03ByoV02ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359822; c=relaxed/simple;
	bh=a3FHbULFSioPc1VUsnQY3aDXW836CZLfzHLuElorq08=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nTBR0/f9Qe+QPvyzchhr9AtYqzZI0z5LSIYckw79JfCXuhUzQrd7oRAf2CyQv65vPaBtojIPAvgUhA3Fzg24NkfjWdrcFIH9sgp3FLXvOdmDHzq1cEEveqK/qPlqLI12EOCU/XQE1h9RbySjPftwYZwWM19eUPMyf6GFluFVCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BO42Msx9; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BO42Msx9"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c91ef7009so33020389c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777359821; x=1777964621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kYF520iODnaUIO4hP9TXJ8u459DTej3831DGt2ZAOHA=;
        b=BO42Msx9gF2E99+/2m/cu5kmf9K8NtfXGz+adGGvmirWBRkgXXEmFEP+KYNyMpS/dM
         a4qOj2ZtrUDzpjiDxQkyTcjiZ6k1scbNziZwdp4Aa5Bex4316PJNXR0Gg4+9RsIFQbXY
         L7sp6CrYXr8T1JI8kYErXkyVp62pyzq4EH3LXDXW6ICV3+sBjSfZzHemcbKEBbjYwQSL
         5jVoN99zl4lHLc7133mDW1QagmhbBXvqEZnoovbCAiEWUyO0ooyzJSp4GAdagkFfJzXE
         zdcGLuKXVMi6KnDuKogI6aarXOa4F2KUQvMkpUimpmYgKcyjEkoeYlccmaqDd8mk1DUs
         Rpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359821; x=1777964621;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYF520iODnaUIO4hP9TXJ8u459DTej3831DGt2ZAOHA=;
        b=mJEpOTckfE58/NvTajeKZ7XK/QbPvSF4iLHu4JT6u1/qEMeCrR5UTWgjBTX9/WNWmb
         CXHAF9t+w4B84fCyWrh+18GcpzoIls+czZSyyzqK2qUUCycJPXfeBgCWBE+jiSIzjTPr
         ege0dN6MLFYDnzRUBpPetcxv2Z39SsQjCxNV8BYbTEi2DZQSKj9UtWIa+yW9OIV8fRo2
         29sGQEyBlsX+9a7QUfR1TH78w4soX6m5FubysOROBkqiy6NvzD9a/Vqrqcwg9bSwixxG
         veBJkzttm8lyOPHBajx2cRU1cYqQcZDr8PlmxjBQBLKe15eLD5QfFwwWLUMin5i93pVa
         5IPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gJTTq29BvTM9ghhMQbYoQIaqrujvsmVHKmuBBEZNcfJOZzam/ZLjHctr5GqOfdkSRipuZVXOYEbwtnUbJqGz/@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJ4UPgb/FLxaf76u7M4ZXo91ok31Ve2QPD+ALlhte+dT0pfGZ
	JxtAjvjeEgULriDkZpyRfQaMohef69hhAj0QQOfpjLfhYwjErRKYH6iudSbPUruL1Dx38JoBuMB
	S23MCCPVR6A==
X-Received: from dlbut2.prod.google.com ([2002:a05:7022:7e02:b0:12c:8ccc:748c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d14:b0:12a:9b80:8a1b
 with SMTP id a92af1059eb24-12ddd9b1c95mr1032415c88.34.1777359820560; Tue, 28
 Apr 2026 00:03:40 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:03:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428070328.1880314-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf inject intel-PT LBR/brstack synthesis fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

An intel-pt trace can be turned into LBR events either in perf script
or perf inject with the --itrace=L option. With perf inject the
generated perf.data file failed to be parsed as the sample events were
out of sync with their perf_event_attr. A range of fixes were
required.

This patch was separated from a large perf script refactor that
highlighted the breakage:
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/

Ian Rogers (2):
  perf event: Fix size of synthesized sample with branch stacks
  perf inject: Fix itrace branch stack synthesis

 tools/perf/bench/inject-buildid.c  |  9 ++--
 tools/perf/builtin-inject.c        | 83 ++++++++++++++++++++++++++++--
 tools/perf/tests/dlfilter-test.c   |  8 ++-
 tools/perf/tests/sample-parsing.c  |  5 +-
 tools/perf/util/arm-spe.c          |  7 ++-
 tools/perf/util/cs-etm.c           |  6 ++-
 tools/perf/util/intel-bts.c        |  3 +-
 tools/perf/util/intel-pt.c         | 13 +++--
 tools/perf/util/synthetic-events.c | 25 ++++++---
 tools/perf/util/synthetic-events.h |  6 ++-
 10 files changed, 135 insertions(+), 30 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

