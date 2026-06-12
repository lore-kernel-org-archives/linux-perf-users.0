Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00305314D1F;
	Fri, 12 Jun 2026 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224550; cv=none; b=iprJNVP08S6/MFyBnk+GmEyJ2X6rlhZssFieAe4FGWJ+sOlbzgpUP47glZLYQS1j1ySjnjEaZPs5v6kRLy9zf+QlAfMnV7fjng3wsbxvDZNOhGbfB9+gCHTYENy4rN2AS/pBpcvVFz4tBSU8DFSW0urjF0wicEzXaHVasT7yOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224550; c=relaxed/simple;
	bh=Nl1djylyOIEP5OkTtFMerubFW+2NEVceyxXR/vhJynY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISULGYALncmwT1OrAhxB5Rac662aWEU4mSBl6y8z+6W+MXe3mAPayLjgE/Nx/+A+JiFsXuO1GS6nEFbuoi9rsyS1y4QUx1RXn/iJcmNSI0RS6HsHZCPwJVwsme8255Vo/0r1OY7VDU8nlHUEDpS/0XBgFlaeqsDyhB1AOw5Pj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHz5bwZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHz5bwZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0761F00A3A;
	Fri, 12 Jun 2026 00:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224548;
	bh=Tp65WxPEKvMy0EMVyndBOE7srR8LwXCkKUGjqxDrZ6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HHz5bwZlqtqDDdApKVuxe+Jf8VPC8qiDNBWY+BR/DaeFmzIkWY5HI8bIqQJgA6E9v
	 NQ4NH7dNoTT7U4P9AkywXrXva75CpqlzHismfaKD2a9BRydAyVL4qMvr91H7FyK07e
	 1TOMpJWL2ad4Tv+V2vajM/qTN+4CZE+azIwc+boxOlBLmT+xD8vIxRxpjYqZMKm1qy
	 gQ7+kijK4EDesnrWglVNMY4juUOwZbmDby2uSxXL+lkO6eJ386XtpJzPRGI0k1WYg1
	 QAJArTU54C4HKPGpv1JXqF1UtQcJkeskVSv4qMbw2JiqEvaLcHXXcgrGBdjI9vmBU8
	 CX1QjkkRcyAFA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	James Clark <james.clark@arm.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 15/15] perf cs-etm: Reject CPU IDs that would overflow signed comparison
Date: Thu, 11 Jun 2026 21:34:43 -0300
Message-ID: <20260612003444.50723-16-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

metadata[j][CS_ETM_CPU] is a u64 from perf.data, but the comparison
with max_cpu casts it to (int).  A crafted value like 0xFFFFFFFF becomes
-1 after the cast, which compares less than max_cpu (0), so the queue
array is never sized to accommodate it.  When the value is later passed
to cs_etm__get_queue(), it indexes queue_array with the original large
value, causing an out-of-bounds access.

Validate that CS_ETM_CPU fits in an int before using it in the signed
comparison.

Fixes: 57880a7966be510c ("perf: cs-etm: Allocate queues for all CPUs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/finding/2
Cc: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5e92359f51a7cb87..d8876b8362056c98 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -6,6 +6,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <limits.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/coresight-pmu.h>
@@ -3468,7 +3469,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 			goto err_free_metadata;
 		}
 
-		if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
+		/* CPU id comes from perf.data and must be a valid index */
+		if (metadata[j][CS_ETM_CPU] > INT_MAX) {
+			err = -EINVAL;
+			goto err_free_metadata;
+		}
+
+		if ((int)metadata[j][CS_ETM_CPU] > max_cpu)
 			max_cpu = metadata[j][CS_ETM_CPU];
 	}
 
-- 
2.54.0

