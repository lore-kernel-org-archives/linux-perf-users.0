Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAC2D061C;
	Thu, 21 May 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325873; cv=none; b=ite0vSCUBBM/6vKzopSAxIIbvlJKUgxf5V367vNa4WDsDN1e3/urPtTauholZfB09ZU3b4v7A64C8rcBwnRMHZgx79SIox0rEVxciET/FwXXJ/gPQLm1btt3032lO+lbHTG7PMMzIVjtlpKQ5BDWLlYEAQ/zSA5fCYC7p5oJXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325873; c=relaxed/simple;
	bh=bMb/y8mopZKJnCnZxdXlS2lptWBWt6mWs/0Zm+oNDzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BljMRSz8zS/hM8GAMVX15bv+OCY3u51hDa8deGTHctzEey8hno5yIF+oiIQgpmv3pg6UEuK4jzE6wXfU6ZeNP/mDn12nIN+t9Lm9m21m9TDuYSoaRhmPy7IB4UIvz4lGUNfmX2OOnC+FmcL8jbdIqYzVuu8Tq/vCX3f+/kmzBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpWFWbPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpWFWbPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518D31F000E9;
	Thu, 21 May 2026 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325871;
	bh=Ql7lFw0ecD21nu8/w1VLWdfmz6yi+4QCdEXB++Y7Z8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CpWFWbPlaaZpl7fuC+cLIryf5A4bu35AjbpSrnPuof8WkEWBDMJgadd0qxpt9uJqo
	 lX5qIy87Ej5+erPOhwScaA7MB7elo+UDt3MmRL1cYlnqdmZbsk7uRjp80hmvg0ZngB
	 Tg2je2vKj8TIAbAfYQeBkjHYATQyxSpAQx0swMMeljlK5GcUwcrZGfkYYA5eMKJGN0
	 YJhVdKAeef45dr1E7SYeCCj0byNrEf8SiesU1Ro7wtGeY05CJ/rRvuxUh3PlMDLCe2
	 l9E78mDVo7JPxqcxrc9wUx1DbazLY10H7MvT6jDsZiao7YJpicyoPvbFozqFia+R0Q
	 StodUannGn4Gw==
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
Subject: [PATCH 08/27] perf session: Use bounded copy for PERF_RECORD_TIME_CONV
Date: Wed, 20 May 2026 22:09:53 -0300
Message-ID: <20260521011027.622268-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
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
index 8c5b3323d0ee0823..d14d8055b2d10556 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1887,7 +1887,14 @@ static s64 perf_session__process_user_event(struct perf_session *session,
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

