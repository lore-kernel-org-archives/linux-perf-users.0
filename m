Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584E285412;
	Thu, 24 Apr 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511108; cv=none; b=IYO2P9xtshSAfX+5/+TNHRnzg/+1IYBlgH+bGEPSRe4Jzp4XmCxonP4CmCvXihH1uHd9g1oWXK6ShCrx6N5dK9w4VsS9IakVl6bNXAPhYVO9mePTwk8UrJA+B+0xfB+qOrK3B4uihkAEQh1Yd6fKZk9htGoozQkQN0z2V6/757c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511108; c=relaxed/simple;
	bh=DyNbIMm3t1OQosHaL0SdDU7894u7I6YldwA1DhSvZII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAesvNRtSmUM2R22+8pJ+BkVK1XB/cD3p6MTuiDaj9bQrj+23jHYmAnCh3FEAJKa8x6n0pXPle2SEnOoaSwcq+6BVfVN8hYfGUASKs4PCLb0ajtpmvQgItYKQ++1WKvibpxLQLdJXGoSoJpGg8ykNq5lbksK6bmASpFxRhZDQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFnuii9a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFnuii9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0899EC4CEE3;
	Thu, 24 Apr 2025 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511107;
	bh=DyNbIMm3t1OQosHaL0SdDU7894u7I6YldwA1DhSvZII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFnuii9aq5fTzsXM0BwraDE0WeCM4/xjUCeQdF1E3wj9U1jEIrmxwQHUL4hpDN+Qa
	 8c5LQ+iTuX499/BsntY8R+1DBQZQvPRI/f9ONW3dPzNrLJ1HvXMWlJOnpnqOx+hjFA
	 uskP7OeNvdFhlgEkIKOn87MklG+NpTZqrSn5sTPNSyIi38LMEEuuyK/7gNwFUwGZB7
	 t1vpjaikuLu0zGMAIuEBclEuBhvRZS1ETJ2ZgL1y0L5efFq1KOyyGLke8axGOkPyIX
	 TF1IoPlusbU0JIwA7YNTBJ9OMwuUkn0GotBqKXLzrOHnFc+q6yggpbxn/AlRRoMpSs
	 ftsquHYDh77Tw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf: Fix confusing aux iteration
Date: Thu, 24 Apr 2025 18:11:28 +0200
Message-ID: <20250424161128.29176-5-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424161128.29176-1-frederic@kernel.org>
References: <20250424161128.29176-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While an event tears down all links to it as an aux, the iteration
happens on the event's group leader instead of the group itself.

If the event is a group leader, it has no effect because the event is
also its own group leader. But otherwise there would be a risk to detach
all the siblings events from the wrong group leader.

It just happens to work because each sibling's aux link is tested
against the right event before proceeding. Also the ctx lock is the same
for the events and their group leader so the iteration is safe.

Yet the iteration is confusing. Clarify the actual intent.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 968a1d14bc8b..0d25bde536c9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2171,7 +2171,7 @@ static void perf_put_aux_event(struct perf_event *event)
 	 * If the event is an aux_event, tear down all links to
 	 * it from other events.
 	 */
-	for_each_sibling_event(iter, event->group_leader) {
+	for_each_sibling_event(iter, event) {
 		if (iter->aux_event != event)
 			continue;
 
-- 
2.48.1

