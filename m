Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF06E225779;
	Fri, 12 Dec 2025 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543458; cv=none; b=ZSagPyQ4S1WCUbFyUQlARnCThuAuQTACPp8Cd09zKY4WIJt7aGiBb2dT9V+hj4RUGUxwynighYuLmnM/APt6B4B4Y7O63urcmfGyt//YO62tWJQtUpWWE6hTFv+nCNiQmfybWA4JfmIBWW4YF6O5BeV5rSI8UIKcEoQqPdCGd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543458; c=relaxed/simple;
	bh=j2J6G4h5/xgYN8qh1XhHEBhu1T1EWy/waavIZ/ivCMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OMb7sGW2OUsH3YHojTMWXgPCQJ2af7CRv3q7uXbmF3t2B+LnET6E3VSGlnNfRZvUuKPNk+JVqpaVmju7Dfk0j9OLRhQJXCDu2qs9zKMoGdGV3gFRP5GDefIZhSD3oOjFuYQn88kokVY3COPHH0FH85n9pubBoIJ9DXKc7x+BRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4249FEC;
	Fri, 12 Dec 2025 04:44:07 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30FA33F762;
	Fri, 12 Dec 2025 04:44:13 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] perf arm_spe: Minor event configs housekeeping
Date: Fri, 12 Dec 2025 12:44:02 +0000
Message-Id: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABIOPGkC/x3MQQqDMBBG4avIrA2YaWvBq4gEm/ltZxNDokEQ7
 27o8lu8d1JGUmQampMSimZdQ4VtG/K/OXxhVKqJO35Ztmwi0uI8e7dHmTc4FITNvHt5QgQf4Qf
 VNiYsevy/43RdNzXcE8NnAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765543453; l=722;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=j2J6G4h5/xgYN8qh1XhHEBhu1T1EWy/waavIZ/ivCMg=;
 b=fseEbbqaILVNnNB1p6gJZ9rDWdwuwYqW+79S0PHHd1aHkBMG+k7DFq5k3n+RIU4RTWinUa6t+
 CYj0WSNtBOgBLmWUCpCH4Oae7MzhX+i1Rmz0DksSMpnlJD2kEioRuHm
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series is to clean up event configs and update the doc for default
events used for Arm SPE.

A quick verifying on Orion6 board with commands:

  perf c2c record -e spe-load -- test
  perf c2c record -e spe-store -- test

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (2):
      perf mem: Simplify Arm SPE event config
      perf c2c: Update documentation for Arm SPE events

 tools/perf/Documentation/perf-c2c.txt   | 7 ++++++-
 tools/perf/arch/arm64/util/mem-events.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
change-id: 20251212-perf_c2c_update_event-76d4eddebd23

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

