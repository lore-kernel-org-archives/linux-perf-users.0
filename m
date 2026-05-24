Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20721292B54;
	Sun, 24 May 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593300; cv=none; b=nFFajgufT2OcALeMb/lyhsUXpxUnQu9uRMG7In1HwhDwgcPhSIuNwVcYFT8bkgiyfvNqxSM3zEMIIs1dEb20bjXEOmmsy9t6GHIWUi8t4vvi/2orlRdHr3m3jj5J1iU2W90Jp7/mqHKihpNkqoub2njzpNltVbNDX9qNFCiVj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593300; c=relaxed/simple;
	bh=SH0mYYMdGrciBpnXiSaYprMGXE4zE58WFtxSIHwLyfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGpVpdO1AMGyyfYD46twRqKYWcsIC5Be+wWyl2EjGgptJleDW4qVE2hM4KSBoIJLVWAlApPqG389sT6mOjjcg/pO1ALbKjRZyUMoquq/1A0zjc+nOjTI9MmbgQEtm+hG5Ml8FEiJeKsxVtyCMHBvV3cX8yL06l/OTmYgUy1CZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkvmuqQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkvmuqQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CE61F00A3A;
	Sun, 24 May 2026 03:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593299;
	bh=hpnZa/NuRnZDfrhu8D/hsundXd+0STyIyXSz89U9iCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkvmuqQqTrTdObFHhFQvpDW7BA5b5ISszTAsygBEmZgC7LrbgO7I8adoZw199AYdi
	 dNiafZiL3W7Cudz23rD1p1WD3tCjF1BbHyp39O4/INPeMKnhwUknPy40K33rTJzboF
	 6g2Xct+Hy0TCZQbXUfMaKksS4wSBEmDfJqBavCiyCUCQyiZUoJ6dXsSiDUd/SYDZFa
	 AHEzyS8sXEnLonzo2mSPDAalPE6uI5pTKoM8KiII4IKOKfCPIdwforbfcPQN70FGfZ
	 c7URBqiek7YXnhFTSc7S4yCErOWn/UGcycME+CVs5X0rRl998z6Ywd92VGet9+zdLG
	 TwO6tfLpKpzQw==
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
Date: Sun, 24 May 2026 00:26:43 -0300
Message-ID: <20260524032709.1080771-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
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

