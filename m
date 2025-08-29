Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE118BC0C
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445568; cv=none; b=fUuub3jmub0cyquHIJAyqijjPuGuX1Fi9g3XZfHfs3H3+jM+mus15qscAqCdjO5F/oDtTk7E7R+OMjKLlMEHrF92PQesNwfIgM78jsKUtPIP08+N5zyofPsVgGq+HyrwT8MX6U0dV9qS4MerBa0rjSo5cITJz29OCmjxOnBqXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445568; c=relaxed/simple;
	bh=I4QACpBICmQCZ3S3+6kNYNVqT3g7uhIV3rIB9wDjn0Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=KxLA4x2cJ7cS4iJLnfiAxTEOKvpUA2s0CzxgDomBZnPBLweFOyG2FUvN/rxh86/0ujzsTytLOS+FUplBDJX26vyrr9o4wER7WVx3vsntToZm/YpTUNZJdarcJLWbqLQhwADhkOxzRg00CWhUQHaeVku9FWySR1PXow7FshV7XAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0NtR0LG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0NtR0LG"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248fbfc35ddso16829225ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 22:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756445566; x=1757050366; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJ7X49u7UEhmM6SEYeosieinrxfPKdIK7XnxPLDzBZA=;
        b=U0NtR0LGRb8KcGgWj2uwz9LbuOkP1NkmYc/0Q3Fs4hTa7djhwTtMPnLwD75Zbcysun
         HPID4RvDEqu8MWEBlF95Pc0CILKU+HSoSyddkZLfQBZDnmuzmlbR6t23lXB+90nYPoMQ
         jkL3ozjQRt/EJ0XU5633H0UVOecV2Vpwxo+WXxCtNRoYnkwUY9uBu0swCkNhO29iHwi1
         MPUXhh4Cb2Dy/LT/OoGJ0FWHALYO2510OrDeyTPpRdqNpUQXZVrBjyW7+P1e1lid28u8
         FSoYq7G0V1z77gGBtHRSlODNJkoFScuATUDPcRTWUfnGVm7yfZjRv5ap07h1HgjANuQf
         8Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445566; x=1757050366;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJ7X49u7UEhmM6SEYeosieinrxfPKdIK7XnxPLDzBZA=;
        b=C3ZP9bFkhj+ei5hjyWbt6Dsf6BZJr9vETdApqyB4FQv5e0EtiSeTNgMNWnhBrvNkTL
         lRGjHZqeUAfdpfoqbT3xVEbTqgD2r2BiYERV5XJ1pmAO6qRAHZN9HM2NnHVy71ySJUvO
         ynRiFqP4KD0KeiX/WwWhb3aK5jmcXRRfjLgZJGcxgDkY1yrFbXULPddMTQhuEIFF877+
         pkgFMo3NfOc6V0duzD99WPr7RPPhuevdqQP07hzpA34gpUm2Tgp6/rNatuRfR2itlMF2
         kNJI+bbG2OcAS3XTVDJp8h7LcZ+v4TcwRDzQrcOBRe+R80PGCglWZRp51TIsTl5JBe9w
         qUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxUKuxKjXWRjTWR6V4kuW/G970xQ5mkhSkh1IJtmip8uVWkvJ4BJz1pu57X4fJp5q20HwQkdFQl5Zf+dnnrlbn@vger.kernel.org
X-Gm-Message-State: AOJu0YybfMZY5QLL0XLyuC54VjLSxPZNoN1j8zT+PCJSyUQ5xqo4Fnho
	XsVvVm4U7FnI0FHXDeY/qFhdpEa3SVzPD85OruHs6nKNPOYHdS4B/BuVcWAnVFKqoXUoq2Oab5G
	SBCOaqts1Rg==
X-Google-Smtp-Source: AGHT+IEN14rLTCmLlMH2oT9k8izuGJ0QZ4GViZai6MMVnBcx2oVyIfxAYI54jTZklbOPpkrCRBszj6EDXpzq
X-Received: from plha14.prod.google.com ([2002:a17:902:ecce:b0:248:9ee8:cee5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a45:b0:246:ddd6:f8b9
 with SMTP id d9443c01a7336-246ddd6fd04mr238874905ad.43.1756445566290; Thu, 28
 Aug 2025 22:32:46 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:32:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829053235.21994-1-irogers@google.com>
Subject: [PATCH v5 0/3] Python generated Arm64 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250829041104.4186320-1-irogers@google.com/

v5. Rebase. Address review comments from Leo Yan
    <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
    Linux Perf Metric) so that python generated metrics are clearly
    namespaced. Use cpu-cycles rather than cycles legacy event for
    cycles metrics to avoid confusion with ARM PMUs. Add patch that
    checks events to ensure all possible event names are present in at
    least one json file.

v4. Tweak to build dependencies and rebase.
    https://lore.kernel.org/lkml/20240926175709.410022-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055801.1973422-1-irogers@google.com/

v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.
    https://lore.kernel.org/lkml/20240301184942.2660478-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@google.com/

Ian Rogers (3):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
  perf jevents: Validate that all names given an Event

 tools/perf/pmu-events/Build             |   2 +-
 tools/perf/pmu-events/amd_metrics.py    |   3 +
 tools/perf/pmu-events/arm64_metrics.py  | 150 +++++++++++++++++++++++-
 tools/perf/pmu-events/common_metrics.py |  18 +++
 tools/perf/pmu-events/intel_metrics.py  |   2 +
 tools/perf/pmu-events/metric.py         |  37 ++++++
 6 files changed, 207 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.51.0.318.gd7df087d1a-goog

