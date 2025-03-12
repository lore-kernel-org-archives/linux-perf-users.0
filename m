Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB451F03FF;
	Wed, 12 Mar 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811529; cv=none; b=R/QtDZIfowx5nyh1imvk2Am9X8JAh98KqrvDmsw2A3alErkW31STubWHwCXv6xjUMxLWIaULBXhXdCMQePnUp/+qOW7s25jr+m30mUhL5YnXGu37d++UjrKJhWelUhncTMZe5yLxeNx19PY7SBErXcxKy1/arlBAAFR1e1hbr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811529; c=relaxed/simple;
	bh=bG71zNV61ysbJQuURYe3/BCP5KtjkN8yw4XRMtq78Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYTY+C6K9buwhbH31UQkghk+gRhDeIEYpOMlytF5IIw0VN2L7msllqajZGi8utZ5TZaqtqAWbnTL8LuCmTygumwlya3uFECW59D7EJTxTPO0EOMxM1d3xtKeW8dbHkN+yMcfuLS8LFUw7BEqwLrTAvy/uOW3bVb0SLRsT6v+T24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHDSJj3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHDSJj3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998AEC4CEDD;
	Wed, 12 Mar 2025 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811528;
	bh=bG71zNV61ysbJQuURYe3/BCP5KtjkN8yw4XRMtq78Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHDSJj3zi/nSzuPfr8jlE/wePR9231Mcm/brkDwpA7bmXu1Fgj3KZ8CkXGTzrod5W
	 +c9VOmAa1C2YYgv6bSRWQ1UnU1I92FskAtu0ImEBKGWkQB3rgjFiVPoLcZAo3kbLoV
	 zGPIhS+TdlUK3vpX1CFyFXR3ufyYS8xFilWmrV7KKw+RH93u1PKcNILb2FTSxVlwr9
	 KgJr3KkFVJ1OUWFybsjLByFIEB7U0ETzE9oyRzO4VSjH3dofi6yE0uxIAgCU2QJ9vD
	 Hf9wjnQ7hs+J622Q/Z5SerSFZJsr9t/vQosPmwU9JIXS4v2rLxGRH1/d9Z0cyjI1Ob
	 /bhNFmIqPQm5A==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/6] perf python: Check if there is space to copy all the event
Date: Wed, 12 Mar 2025 17:31:41 -0300
Message-ID: <20250312203141.285263-7-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
References: <20250312203141.285263-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The pyrf_event__new() method copies the event obtained from the perf
ring buffer to a structure that will then be turned into a python object
for further consumption, so it copies perf_event.header.size bytes to
its 'event' member:

  $ pahole -C pyrf_event /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so
  struct pyrf_event {
  	PyObject                   ob_base;              /*     0    16 */
  	struct evsel *             evsel;                /*    16     8 */
  	struct perf_sample         sample;               /*    24   312 */

  	/* XXX last struct has 7 bytes of padding, 2 holes */

  	/* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
  	union perf_event           event;                /*   336  4168 */

  	/* size: 4504, cachelines: 71, members: 4 */
  	/* member types with holes: 1, total: 2 */
  	/* paddings: 1, sum paddings: 7 */
  	/* last cacheline: 24 bytes */
  };

  $

It was doing so without checking if the event just obtained has more
than that space, fix it.

This isn't a proper, final solution, as we need to support larger
events, but for the time being we at least bounds check and document it.

Fixes: 877108e42b1b9ba6 ("perf tools: Initial python binding")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6a03341e17881337..f3c05da25b4af8c0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -476,6 +476,11 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
 		return NULL;
 
+	// FIXME this better be dynamic or we need to parse everything
+	// before calling perf_mmap__consume(), including tracepoint fields.
+	if (sizeof(pevent->event) < event->header.size)
+		return NULL;
+
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL)
-- 
2.48.1

