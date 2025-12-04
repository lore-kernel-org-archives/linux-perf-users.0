Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84E2D5950;
	Thu,  4 Dec 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867238; cv=none; b=WUqzyrIFW7rMJO1h3VOqUqqrbIovyDLzsY7CChBkoz9nJ2HylZ+NGts9Li674XCLxovUYGHHu5IodmZHGyEsGcQuXUQ+TigrHyNKihzzAn3XaASKMxrPoielpMy9AEAgU9guhKO6ZcEchOk9ifWFgfJ27hEWPQfyLs7OBPjsr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867238; c=relaxed/simple;
	bh=BhtLrRJksViZCVJBbVVT7HdbfU1WgRqFsLQrjCOtIiI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mJNKJesCf8Tv6xQYEsggg1MCvhlzX0Hdgwk8aIwZd7svgpeBk7F/9ThoDYbS4FCcfCBvaA4hDRnUOMu+UgomJKy33JnWXyRO6U9y/uQfTTpAAkNvNvVHZ0KraF1tM4MMVVBsr9Eqkhk4C3MQnqJdlnem38drN6yg3xtFVQVteQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7BED339;
	Thu,  4 Dec 2025 08:53:47 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADE423F59E;
	Thu,  4 Dec 2025 08:53:53 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] tools build: Fix arm64's unistd_64.h dependency
Date: Thu, 04 Dec 2025 16:53:40 +0000
Message-Id: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJS8MWkC/x2MUQqDMBAFryL7bSCJFtpepUgI5qVZECu7UJTg3
 Q1+DsxMJYUwlN5dJcGflX9rA9d3NJe4fmE4NSZv/cN5O5gNkkPmPeihc1yWUBATxMA/bY6vwaV
 xpFZvgmbd5890nhc0kbWdaQAAAA==
X-Change-ID: 20251203-perf_fix_syscall_header-e280fa931d44
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764867233; l=1413;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=BhtLrRJksViZCVJBbVVT7HdbfU1WgRqFsLQrjCOtIiI=;
 b=yhNaeDVu+gqnZT50RValRrj2Gu51+AvkdK8BHnkM95duovC++g/yVX2oyHXOByAgSgKd2OMNI
 cxMdKW3md8ZCI3RA+SB2lnamp6Ly1gsHzrIJpx98vMc+Wcw/DJNqu2o
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Arm64's unistd.h is included in the tools build, but its dependent
header unistd_64.h is missing.  This results in only a partial set of UAPI
headers being available, forcing tools to generate unistd_64.h dynamically.

Because unistd.h is widely used across the tools directory, relying on a
dynamically generated header is fragile, especially when a tool builds in
multiple stages, each of which may include unistd.h.

This series addresses the issue by adding a generated unistd_64.h
directly to the tools tree, ensuring the header is available from the
start and eliminating build failures due to header dependency.

This series has been tested with Arm64 cross-compilation and confirmed
that the BPF feature is enabled in perf.  It also verifies libperf
in-source builds with applying this series.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (2):
      tools headers: Add arm64's unistd_64.h
      Revert "perf tools: Fix arm64 build by generating unistd_64.h"

 tools/arch/arm64/include/uapi/asm/unistd_64.h | 330 ++++++++++++++++++++++++++
 tools/lib/perf/Makefile                       |  14 +-
 tools/perf/Makefile.config                    |   1 -
 3 files changed, 332 insertions(+), 13 deletions(-)
---
base-commit: 267c2e633af6e9461477bed91e428993f8b36ee8
change-id: 20251203-perf_fix_syscall_header-e280fa931d44

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

