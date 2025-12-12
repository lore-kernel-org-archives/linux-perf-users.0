Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A414A01;
	Fri, 12 Dec 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765560309; cv=none; b=mHGc5SdTBK5hpkV0oAdI68iObqWzbwp6OfYd3B9njK/aZeAWD4oliIIrnvUonSo5qNW5I4XXMbSVsUm/eRbq5p1sC7AzSq1AHPljcrYlvkXzXDDqTfHvgr6/u0qpI/i3FarBY7NgZxbGRTgvEpYCBE05l1J7KmJiHepMpfo6LGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765560309; c=relaxed/simple;
	bh=VHPA5CePVpOmtBBO1bxsa3hYXFTk8jI4b2guvtB4iN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DNIxdlTiskX9CVgNM9fDJonzYbeIDuLlsgid077vPCmnKMYk0LiBD7SviSyWzrp//5QHP3cULIOxvhT247gYMDEQnMm/Lp2OAT/VQc9JH0pZvLLyQ9Y7TQqRIBHKsPM5L3o9XDs27KY7eG/tYzwhwvM8OXtCENw3DBuyKAs3ozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D23EE1063;
	Fri, 12 Dec 2025 09:24:59 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D0A73F762;
	Fri, 12 Dec 2025 09:25:05 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/2] perf arm_spe: Minor event configs housekeeping
Date: Fri, 12 Dec 2025 17:24:58 +0000
Message-Id: <20251212-perf_c2c_update_event-v2-0-27df9a6cb1d4@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOpPPGkC/4WNQQ7CIBBFr9LMWkwZaxtceQ/TEApTy6KUABJNw
 93FXsDle8l/f4dIwVKEW7NDoGyj3VwFPDWgF+WexKypDNjilSNH5inMUqOWL29UIkmZXGJDbzo
 yhiaDF6hbH2i276P7GCsvNqYtfI6bzH/2XzFz1jIUCns9KNGJ6a7CetbbCmMp5QtJIEw+uAAAA
 A==
X-Change-ID: 20251212-perf_c2c_update_event-76d4eddebd23
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765560304; l=972;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=VHPA5CePVpOmtBBO1bxsa3hYXFTk8jI4b2guvtB4iN0=;
 b=PJz78MF8JB/eeUwBubR0HKFxK0GMyDwsAK+RBMGlszataYma1u3Wl6cVBS999utJyv5utrMJY
 X4ODgVEGpShBvlDGbvmbOQ97oXZqRfZhBnJSDrOpNH4aWG9NHMK9iy+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series is to clean up event configs and update the doc for the
memory events and related options on different archs.

A quick verifying on Orion6 board with commands:

  perf c2c record -e spe-load -- test
  perf c2c record -e spe-store -- test

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Updated document with using table for memory events (James).
- Link to v1: https://lore.kernel.org/r/20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com

---
Leo Yan (2):
      perf mem: Simplify Arm SPE event config
      perf c2c: Update documentation for adding memory event table

 tools/perf/Documentation/perf-c2c.txt   | 51 ++++++++++++++++++++++++---------
 tools/perf/arch/arm64/util/mem-events.c |  4 +--
 2 files changed, 39 insertions(+), 16 deletions(-)
---
base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
change-id: 20251212-perf_c2c_update_event-76d4eddebd23

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

