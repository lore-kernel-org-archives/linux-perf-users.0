Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055553BADB6;
	Tue, 26 May 2026 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830329; cv=none; b=PvMI/dmG8SW8DLUPL8EutaEXXVH7jvaJno/Sv2HxQIh0yeF5qP2cFNGG2QBtDNtckCYQL4p1DsQZtYIS1aDkFHPWb/ZlWhRz8qMwHtm279vTxkEsUj3QtrPvhzaMAXg0FAri8/7NNvci7myi5GWCzYCXG7d5Xe1h9U2msemFvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830329; c=relaxed/simple;
	bh=SH0mYYMdGrciBpnXiSaYprMGXE4zE58WFtxSIHwLyfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX3rtT8gaTALZ9I/L/VlIA6E5QWdfFc40iH8LB8RX1oOa9zdTbVFnYT3id6iHUopBt/O5qTosiRpdl9Xd1yBQWpybb/TiHvni/4qRv90Rxw+FdGWelOJrsOsIgHaLkWZrqAiyTv8FD4eS3EDic9MWHI+ncxUHFw1wP+9syIbD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF6O9XSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF6O9XSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACC81F00A3A;
	Tue, 26 May 2026 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830327;
	bh=hpnZa/NuRnZDfrhu8D/hsundXd+0STyIyXSz89U9iCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GF6O9XSqLe9BiHUBklDvCou0MPxLM8xPSkZ/cNYlghwHYjhArAubsyb9Edvh0fRVu
	 NC4JF98Tup0rypARVmBLA6U+lfzrRD0B7MdtQqxYb+m4JNaWrS39wryJU5XPoY1E0R
	 hqGV1BH8Dazg4KTn1GIAToU2LjSZ5AwCmll3pVugzedNyTJ+UzSUq6+JhLruoHwyvB
	 tXCBEBZWXGmeqsSkZLpq22CVm9oaq2EMcgZ35Uf2V0FuB4uYwdRiQzs2pgaLCo6fz7
	 GAGHoDnGs4vzHAEJ7bRRmKZaYfxdszDrOG/JB/z08XfcXwATiVE5j5VwumQ4oP2fOn
	 dqUjstW9F0Ciw==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 09/29] perf session: Use bounded copy for PERF_RECORD_TIME_CONV
Date: Tue, 26 May 2026 18:17:45 -0300
Message-ID: <20260526211806.1193848-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526211806.1193848-1-acme@kernel.org>
References: <20260526211806.1193848-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

session->time_conv = event->time_conv copies sizeof(struct
perf_record_time_conv) bytes unconditionally, but older kernels
emit shorter TIME_CONV events without the time_cycles, time_mask,
cap_user_time_zero, and cap_user_time_short fields.

For a 32-byte event (the original format), this reads 24 bytes
past the event boundary into adjacent mmap'd data.  The garbage
values end up in session->time_conv and can cause incorrect TSC
conversion if cap_user_time_zero happens to be non-zero.

Replace the struct assignment with a bounded memcpy capped at
event->header.size, zeroing the remainder so extended fields
default to off when absent.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d5864e380c1bd52e..3f72b80aac56b04e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1897,7 +1897,14 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		err = tool->stat_round(tool, session, event);
 		break;
 	case PERF_RECORD_TIME_CONV:
-		session->time_conv = event->time_conv;
+		/*
+		 * Bounded copy: older kernels emit a shorter struct
+		 * without time_cycles/time_mask/cap_user_time_*.
+		 * Zero the rest so extended fields default to off.
+		 */
+		memset(&session->time_conv, 0, sizeof(session->time_conv));
+		memcpy(&session->time_conv, &event->time_conv,
+		       min((size_t)event->header.size, sizeof(session->time_conv)));
 		err = tool->time_conv(tool, session, event);
 		break;
 	case PERF_RECORD_HEADER_FEATURE:
-- 
2.54.0

