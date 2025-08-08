Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF427C84B;
	Fri,  8 Aug 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659512; cv=none; b=UM8oeQFyeRrxBd4FcPRcN/wKSnycO/H5NCB3eIpt4lLqUo0BQuQB9ikc7cj/kvhK9NzFhJmRklFePw4vEOyQ/weE+SM7QiEW9ULqSkQ1XhAG9iRymuDvHm6j0LfhVJgVC/ZfLMvgf9USfjDnvBwX0GiWveBR6ZOYHZahkjUiWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659512; c=relaxed/simple;
	bh=9il/YFwucsd5AXhtijDUkzIq9D/CKrWCtYvY1pTNTJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uE+Nj4yTvECckjL14fDkMLaZL8+2EGVxzXujP0T2QMkYDj58Ph6Eq8D9juIOWMCCE6gvrYJghdaKmG7IBnShSWVE63q2UV3sQypYRlyrxOab6U7OSC93wtsxgturd2yfrVv5FE4EMNO1XSbSexgVTMgMmMCIzqX/TRAPeGnoVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D374016F8;
	Fri,  8 Aug 2025 06:24:55 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F0223F673;
	Fri,  8 Aug 2025 06:25:02 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 08 Aug 2025 14:24:40 +0100
Subject: [PATCH] perf session: Fix handling when buffer exceeds 2 GiB
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-perf_fix_big_buffer_size-v1-1-45f45444a9a4@arm.com>
X-B4-Tracking: v=1; b=H4sIAJf6lWgC/x2MQQqEMBAEvyJz3kAMKMGvyBJW7YlziTJhl0Xx7
 w5eCgqq+6QKFVQampMUP6myFZP21dC8fkqGk8Wcgg+djz66HcqJ5Z8myWn6MkNTlQMOIXLfxsU
 wk813hWXP9fi+rhtScfP1agAAAA==
X-Change-ID: 20250808-perf_fix_big_buffer_size-e28f618df61c
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754659502; l=1455;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9il/YFwucsd5AXhtijDUkzIq9D/CKrWCtYvY1pTNTJk=;
 b=m/49s2wopua+Pj+MZvXWgaGVAfvKClRDW+VezrEaHdvW2rP1H21SSttn6LFUUAyhqlTi8X0dq
 c2QaUlpa6dYBasawStzCoJpoR8C8Z15oOZA/dhS3Dg9aWU/YPpyk1of
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

If a user specifies an AUX buffer larger than 2 GiB, the returned size
may exceed 0x80000000. Since the err variable is defined as a signed
32-bit integer, such a value overflows and becomes negative.

As a result, the perf record command reports an error:

  0x146e8 [0x30]: failed to process type: 71 [Unknown error 183711232]

Change the type of the err variable to a signed 64-bit integer to
accommodate large buffer sizes correctly.

Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
Fixes: d5652d865ea7 ("perf session: Add ability to skip 4GiB or more")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 26ae078278cd67fc5894c01cbb44c4b8fa81321a..09af486c83e4ff82e74f17f3da08d3bc3989768b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1402,7 +1402,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	const struct perf_tool *tool = session->tool;
 	struct perf_sample sample;
 	int fd = perf_data__fd(session->data);
-	int err;
+	s64 err;
 
 	perf_sample__init(&sample, /*all=*/true);
 	if ((event->header.type != PERF_RECORD_COMPRESSED &&

---
base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
change-id: 20250808-perf_fix_big_buffer_size-e28f618df61c

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

