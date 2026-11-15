Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749684;
	b=EfcDe6JXMrvW8+0z03c09ssZwPM03YtS7/+JzeXhsENJ05DGiuGEKFNhPl4/SWegmlv1
	 IP9aLXKG4m3paQsiOPDUn5vK9qZe37k/kiIIx9923f0Q4mrmsFtG6Ap9Yad5ejHCkzmJ5
	 khLcKvH2XBH/8zOnWUrP9HR8UAsSGQiB+lbvUIZQPKb5K9F/fFTfGb2Ts2mHvAl0Ustlv
	 Z0qzj2BRktq8iSo8mNacXZBcrHbl149j+LHqfYCEND92LGPyt0yPi7VgRyaE6x/REAJoI
	 KbMYIWzw+M7ZZDVsU1XEv5kdoUH2/QRF3ZYF8ZJDm6e4RwHWw0+7ss8lk8ep/EpEDZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749684;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7XQkJByGVmKomC4rZFM3MteR1xcoMFq5ysFoR+rflmw=;
	b=rR+G43/rRkIvyptnLR0FQEM+SqWX/8TErNrFWyQvbHlTRxiIk2UjOCyF96W0Eol2m9UH
	 bOYvfF5xr+f1m26j6MDUeXMCwW1lxGVXmM2hmcT3HXEdDLUpVrBe6YlfxJ+qw9w+rjwLX
	 4yFYMjE+qw+q2FOANzXr/1ONT44UJQxcCh32KAS9Lb8Ov5+puhTgifjClCM6118mFG0CL
	 tDPKLkLDZZhxlFoLoQjlkvp5+3uoUDP5nRwsSAMc4ahRIar8OUpjaH+3Wya9/EGMkzci3
	 WuUTfkHNg6dYkmU1hnsYV6KILz53rfK2TObKzWKPQJUMFKW+Y0ZbM9M6PVRTXeh9J6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LdOLrtr5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C1606A31D;
	Sun, 15 Nov 2026 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890C1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LdOLrtr5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 088651476;
	Sun, 15 Nov 2026 05:34:33 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5D53F85F;
	Sun, 15 Nov 2026 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794749676; bh=TTmXZPTYRIshcG7w5xvEfHPttAQu8TmJ84SVZqjJsD4=;
	h=From:Subject:Date:To:Cc:From;
	b=LdOLrtr522F1h7rhPknHm4793s7CgA26WIik0z3N/o6Zj+s+kLVfsHoTVtJhDKsuH
	 wZ8gDyVKSkmOMyj/BepL0tCHDQN1s/sRYBem7GhJM8QWX7zkg1r4TkACwxNDXXF+yh
	 aVdP52l9J7gBbYGLGyideYusLzrivj4c+fWLu7W8=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/4] perf: Support thread maps larger than one record
Date: Sun, 15 Nov 2026 13:34:18 +0000
Message-Id: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANq0+WoC/x2MQQqAIBAAvxJ7TkjB0L4SIZKrLYTFGhFIf086D
 sxMhYJMWGDqKjDeVOjIDWTfwbr5nFBQaAxqUKMcpBUncnSRHrd7TuiujdGHIqKRWhtvlTUGWnw
 yNukfz8v7ftHeDVloAAAA
X-Change-ID: 20261019-perf_fix_large_threads-f81558a92988
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794749674; l=1570;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=TTmXZPTYRIshcG7w5xvEfHPttAQu8TmJ84SVZqjJsD4=;
 b=QD56r1ktj6yhfQCOHFq1MVUuK59ADOFppV7fUWI/R+kk+65EkGqxWiTH93xOFdrN6Mr47JkwN
 pR6vm/hjvcvD76A3W2El+Dk/KgFqkL1FckwGSCd4g7LIigILC8tT+rt
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

PERF_RECORD_THREAD_MAP has a 16-bit size field and can hold at most
2,729 entries. Larger maps overflow the size field, producing records
that readers reject.

This series splits large maps into records with a continuation flag and
updates perf script and perf stat report to assemble the complete map
before allocating per-thread counters. It also adds boundary tests and
documents the format.

Maps that fit in one record keep their existing encoding. Split maps
require updated readers.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (4):
      perf synthetic-events: Split oversized thread maps into records
      perf: Assemble split thread maps in script and stat report
      perf test: Cover multi-record thread map synthesis
      perf docs: Describe multi-record thread maps

 tools/lib/perf/include/perf/event.h                |   8 ++
 tools/perf/Documentation/perf.data-file-format.txt |  24 +++++
 tools/perf/builtin-script.c                        |  21 +++-
 tools/perf/builtin-stat.c                          |  25 +++--
 tools/perf/tests/thread-map.c                      | 111 +++++++++++++++++++++
 tools/perf/util/synthetic-events.c                 |  46 +++++++--
 tools/perf/util/thread_map.c                       |  51 ++++++++--
 tools/perf/util/thread_map.h                       |   2 +
 8 files changed, 256 insertions(+), 32 deletions(-)
---
base-commit: e8b3879165c74999b15e918b14ece7564cb09c59
change-id: 20261019-perf_fix_large_threads-f81558a92988

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

