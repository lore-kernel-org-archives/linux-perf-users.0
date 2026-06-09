Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6643749E8
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041850; cv=none; b=knEOn7BBT2a6/4oeHkIwhwblvSgGLP1M2i7dzDyZxtZ0e/Rczx1JgCs4KFy+rJt0ZKns7BipX1KrDQPczAyIcevgaBWSegR/K2Uh7rUdIR/YCoEzf8Ifqq/+xHrfvMWSd6ZjYRzZkmkcGMxbXepT8mcW/QqtUfvYZBXOwQQ9F/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041850; c=relaxed/simple;
	bh=B2TA5wTbPRxBu+hfRMUE2akbkXfWsY3Zu9rqjtOzA40=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LusqbuTbSvIDzBIXMiFbQmhMGYfft851U9i/U4om32MWNKOflU/Hf9vVDwcVthP72Odc/DJe1g7a8oEFGqQAGl87NljKEkg7zbwYEzB/APg0FyjCYZnoP9ScSayQuOn6q6CdYkhjQGbhoT8yiVWP/XuKJ5f2ZZ/vTRFoBnnXZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXrAt+Uk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXrAt+Uk"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c36f4b76so67379545ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781041849; x=1781646649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fgIXDhL1E/gQo+ziyEHNim/0IDxU/tyO2IBIKTb7Qrs=;
        b=mXrAt+Uk4vM+FkU+vVtNUlQ9eRf6kBVMAf084pqGxeQx1cjqlbDpSksXC2keIkfNHC
         1W1EcJLaQaB+XjR9MpbkFglKDnx9w7mdxJlOvHB6keIcQsthkuPqvU9KMyP0IBJzJFCp
         CyAK9nZMvHeLPiA7gllQop/LA6UoYyuA+qnt81f0hWxr+25MKV8qFjsZDwM/wjd14vRJ
         8cjzelBx9E0oNdsrU+fXVC7NFv0VJIlbobpZR4MweqYQIFezLsrhh57B5TBnOe338MSs
         aL5R7ba5X8KkFDuO8xczPpg1z1zo2JUkAGHdDF8Ax8iCob14YvrE2bkuP5UPBjT11pDX
         QFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041849; x=1781646649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgIXDhL1E/gQo+ziyEHNim/0IDxU/tyO2IBIKTb7Qrs=;
        b=Th4DBLWEWhf4vdNQgSoxQy4XQql70nbJ9d9fvZ5mVYTCuBg7OBIjGJ1B3Dgi1dT2IG
         a7FmCNlbpt46ZFLKVlIqkCHD/mn4lkikWuXYFlcMN7h+aL+8Vagq0FXrjuqiSeO2RYnZ
         fibV07PojkKIxWdYQJV3Yo8+LWKo7vIVpEm7L3F3dtmLIjkvTpwEvDeQC8T/k1w5hGIm
         uQ0cEZyMSkgGxN1yBDhJXxgEMhJ9X/+crBCfoX/4Yl1KPChagaHmIF6nDSzQZiXvVZ4z
         cTyJc4PXbRI8DazwRGHmQjDOJDPdsb8PairteMsuKMdfZ//jKmC1x7jugIFSKG4by2op
         qmEw==
X-Forwarded-Encrypted: i=1; AFNElJ+eAfFKErebM3DKDis9J6WI5fXGYrtdnxhbvBAw8UvsELgW5zuXZC4mJlDPerLdm0ixic7mEdTCZZyL4ODYriWj@vger.kernel.org
X-Gm-Message-State: AOJu0YxspEO63WABYc491PhgYnhXWdl2ptrizI/+ggbss1ysnTAMhoy3
	Q5paOxaT4puLGiBymkZJ9h+qORcIUSFf0c4n5KQqd4o/rVzQgxYcIbF8EmMu/7VJzcSq+iU4sJ4
	bUZ/cQA==
X-Received: from pghr13.prod.google.com ([2002:a63:e50d:0:b0:c86:93b:4970])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3cc2:b0:38d:fad1:cf2a
 with SMTP id adf61e73a8af0-3b4ccd65aebmr24305665637.13.1781041848594; Tue, 09
 Jun 2026 14:50:48 -0700 (PDT)
Date: Tue,  9 Jun 2026 14:50:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609215046.2391903-1-ctshao@google.com>
Subject: [PATCH v1 0/6] perf vendor events intel: update
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync with the latest perfmon events from:
https://github.com/intel/perfmon
by running the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
and copying the resulting json and mapfile.csv changes into the perf
tree.

Chun-Tse Shao (6):
  perf vendor events intel: Update arrowlake events from 1.17 to 1.19
  perf vendor events intel: Update emeraldrapids events from 1.23 to
    1.24
  perf vendor events intel: Update graniterapids events from 1.18 to
    1.19
  perf vendor events intel: Update lunarlake events from 1.22 to 1.25
  perf vendor events intel: Update pantherlake events from 1.05 to 1.06
  perf vendor events intel: Update tigerlake events from 1.18 to 1.19

 .../pmu-events/arch/x86/arrowlake/cache.json  |  30 ++-
 .../arch/x86/arrowlake/floating-point.json    |  45 ++++
 .../pmu-events/arch/x86/arrowlake/memory.json |  18 ++
 .../arch/x86/arrowlake/pipeline.json          | 129 +++++++++-
 .../arch/x86/emeraldrapids/cache.json         |   9 +
 .../graniterapids/uncore-interconnect.json    |  10 +
 .../arch/x86/graniterapids/uncore-memory.json |   2 +-
 .../pmu-events/arch/x86/lunarlake/cache.json  |   2 +-
 .../arch/x86/lunarlake/pipeline.json          |  27 ++-
 .../arch/x86/lunarlake/uncore-memory.json     | 208 ++++++++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  12 +-
 .../arch/x86/pantherlake/counter.json         |   5 +
 .../arch/x86/pantherlake/pipeline.json        |  29 ++-
 .../x86/pantherlake/uncore-interconnect.json  |  10 +
 .../arch/x86/pantherlake/uncore-memory.json   | 221 +++++++++++++++++-
 15 files changed, 728 insertions(+), 29 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-interconnect.json

-- 
2.54.0.1099.g489fc7bff1-goog

