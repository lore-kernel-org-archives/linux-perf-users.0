Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163517BA2
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313610; cv=none; b=uP2jDY6GI0h4JPfNy4IgWMAiWqnQ3om4+37zEUJIv2+OjYOzUXQhpM4bk/wdTHL7M/FAFu7AR1kLwD9gAJ7a+vRqUc/FtQNo6703cfHsuuQ8uk51LcPrY5BfO2uHyAzhVtc/irQ1m7xUUY2YQ4rP2kbxeg7vmFtutkoCNNxCfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313610; c=relaxed/simple;
	bh=yJpYZGOXHq4VARxKkRiZQwJlC97N+gKPnvN4RxqmM5k=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GQDz2fqhN9MFD/rfgLqHghFnVdjX38uBtVNMI5bAXs4QoXRdmFqO2caaDjcGeKjDfc4I75NAdoDV2ALKrzXy0MhyVmsgj1OjcmL7IhtjU6zsCLmwqj88+UDnIO5qJmoCIt9df1gJb+ezMcMXdjfOotDXxx2jYqOSaIse1Cn2fo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbKCUYq9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbKCUYq9"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ef812f43a8so34640057b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Dec 2024 17:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313607; x=1734918407; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vurgNUDFdScpRn1TdwGFyPhlbG8QwsO+PcyluWaJkUA=;
        b=LbKCUYq97zMEvu8ZbUZD9ddCvzVfJlv+durNGi7hbejs6jFMfib7wGr7fkUsNuAi8w
         KzmFz68KUjGcP5sf3DMcjrtH+sWV7auwwCiDTla2XVDPNMLkdcicmQRpLgLzss4k8R5I
         yNoCDhAy/CVjK9XuuW5Euod9qHIRBhvv+ixNnoj/mpyJfR/41b14BeuGx01TMaEJJlCc
         leCOQXkRNjB2+mGsQdOp2383kt+ttGQh0d/vYIguCLgtNQL2K4PXXkmMEcMqG1bBagsL
         Z/mK92A1Y2QpVS5W7NAsXVHWOdqoMK2D20eSajzm/ooIY7XJcMgRVt6IWZhhHIZS8mer
         3MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313607; x=1734918407;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vurgNUDFdScpRn1TdwGFyPhlbG8QwsO+PcyluWaJkUA=;
        b=X6ZbRTQtN1pB9faHJcn78b+HsFQxATkz2E5lahMrK3LfPh/OgG/pZgJwrQpQQZXX9K
         16siXCmBlQKrEyhoDe8jUxu96rBeoEFsgMFR/fJbGxX5g6LOaAsdcNSrSjLGPjGkNtyi
         iejwy+0L8J9rDeaHQPqut8+OVPRKFS8lZqiFQE9+2ks4PSVf00W10OMxHRyqJ9scSyG3
         uXIk17OP2jUScA+1g182xFr52VT4zCAu+QabrsTP1OwBVcoC8J4Gh48+fUZmQigP9lS4
         czGfBdqOTmvzfle1lmzB17crBK3wha5QOMyhCyCckuxqLv3XIt7y5AE9QlVe9HaT/t3J
         Yelg==
X-Forwarded-Encrypted: i=1; AJvYcCVe9vsNPV44EdH3l9fTtQrycNJuOdS2yfrT1VWxFk8zlznCR4QgReNCroNH8tYsIrrJjCGevR+ATNBfbQs1USYe@vger.kernel.org
X-Gm-Message-State: AOJu0YypLhUSpJoun8U/ghSwG4eUFDwvFKRR2YsT2dp/9iFE4LQUTDTf
	Eu4ODP6gmu5c6v53EeHDVGdjT6RxDSPx0tO8dgy0qZOe3NTEbAIUKqIgJyBj0YPWJnpGOtCVX4/
	ki9T61Q==
X-Google-Smtp-Source: AGHT+IFmAlVoXvHPrxiHPIjRrV3D22hGqmGSknS7ig9MfnLEFSQ4AjnOdberj0uqKxJzkSNTokeHTGDsfByZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a0d:d142:0:b0:6e7:e493:2db6 with SMTP id
 00721157ae682-6f279b7db76mr69787b3.3.1734313607540; Sun, 15 Dec 2024 17:46:47
 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:33 -0800
Message-Id: <20241216014637.304761-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 0/4] perf file align features, avoid UB
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Features like hostname may not be 8-byte aligned. Add padding to make
the feature aligned to avoid undefined behavior (UB). Modify the
writing of the CPU topology features to always write die_cpus_list
even if empty, as the size could have been aligned and not allow the
missing list to be detected. Avoid UB also in machine where a NULL
may be incremented.

v2: Fix CPU topology as described in replies to v1.
v1: https://lore.kernel.org/lkml/20241212080530.1329601-1-irogers@google.com/

Ian Rogers (4):
  perf header: Write out even empty die_cpus_list
  perf synthetic-events: Ensure features are aligned
  perf machine: Avoid UB by delaying computing branch entries
  perf record: Assert synthesized events are 8-byte aligned

 tools/perf/builtin-record.c        |  5 ++++-
 tools/perf/util/header.c           | 10 ++++------
 tools/perf/util/machine.c          |  2 +-
 tools/perf/util/synthetic-events.c |  2 ++
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

