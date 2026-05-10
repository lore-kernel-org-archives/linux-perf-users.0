Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC824677F;
	Sun, 10 May 2026 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384116; cv=none; b=mF3AqqK40U2rFe9NCzPWnTUXpXKekW/wOZhgmCR0mi5BUpuh3CzH9HzLI+Bqi996YpXI99YXF/D2ADN5JPgiDP/e8pbvOhHnuBP9u/l8TrKCWK8ktGaGb85LfMmG5B4tLngqIvcdCbNeuvVU5aC3U9ntpGEeUcBUc2PyL4+JNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384116; c=relaxed/simple;
	bh=VtIhWKBfyBo96hch+CwO3Q/k0Fh9v33JHcaLu/UJ9ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt4wmXEUL9G9tSnQQet0MXcoNsQasZ3aXOlQO+Qil69+kwuYXOUB8crhjl3je5aML+DhX1DBcM67w766ystKqUROOlL3y0HBySWVFcpbcjP3JzrcbAQNmNqKxb9QXfBu/z0dW9H5KlO3FsnVTOjgVQEr6rd1Vbfx4qslA9IL858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0xNIi+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0xNIi+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E857C2BCF6;
	Sun, 10 May 2026 03:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384116;
	bh=VtIhWKBfyBo96hch+CwO3Q/k0Fh9v33JHcaLu/UJ9ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0xNIi+HN+Ql3JHYZAnGNy8BH0lwZRP/RMAIyzsimaIrxWVb3UXEpqXsvLsBLiCei
	 6UvShERI4oJa1vaIIiYXXQFJlAhvLPbqwEfq28oJoSpGekWchUCGoV6SU53aXuL+Og
	 EHdOXFULqROEeUyvd2cLmql9hVHIGMfslG7N2dM0BazOyzKoNJVvzu2u7usDES+uAX
	 VDc/J28km5zbiPyyORXBjeTgp7H1FktrNEGig4/NsCXSQQSgqvoqwOLsNMqGPobR2S
	 OYoftcqHnwGe4XCFMDqLQo8E9lJZa7nN/FXDhfKKsWD2z+zMVYAHGaGtXxg6OYzcLZ
	 bVHUOO48qKJ8A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 08/28] perf session: Use bounded copy for PERF_RECORD_TIME_CONV
Date: Sun, 10 May 2026 00:33:59 -0300
Message-ID: <20260510033424.255812-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
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
index 18e60ccf6829f05a..776061afd568858a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1894,7 +1894,14 @@ static s64 perf_session__process_user_event(struct perf_session *session,
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

