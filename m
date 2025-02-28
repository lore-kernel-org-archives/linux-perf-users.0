Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78B1DE894;
	Fri, 28 Feb 2025 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777485; cv=none; b=vC3rjgcXpH13noSn2Q/oiwDL3lQU27gVW68A45fLaRSVvboRClFIOBNXis+g0VGulCWZmshEyV7vWj3UFGklvE/Oe09kySpUXB9/fWqmN+u3RDLYsmKQbMrMYVPsA4FcAP6FzNRR5TGGTHD+l9as2gvAFCOTNJyk7EY6Qj9Jvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777485; c=relaxed/simple;
	bh=7QuwcONiFjBvgd7KcWu7hsE6a/J1QdNgA0OLlDjYQgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqk5gJEOKR2Fn9qBjutWNPgAxWGF22Ip9IZ7kwLE4ZiTBZ6LeV/yd9AezNCwZuLXSa0mFqb0v2p37RRp38TZCO5ZRgGW7XRMVA/CWU2PfHOeel7ehF0xQGQ3Cv0Kdxu8V7pIVfasxfgspheSXUu0qG9WzEIwhbwihr2CoV3cUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXm1aFVy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXm1aFVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8CDC4CED6;
	Fri, 28 Feb 2025 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777485;
	bh=7QuwcONiFjBvgd7KcWu7hsE6a/J1QdNgA0OLlDjYQgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXm1aFVyjcpZtzGCtgQznnxl36xZJNYmbLYKlTSOWL9/hVG+8J8CIGdC68fK/nTjk
	 IWr6pneS4rI3VBsA9iI+MEs8rO9fWvjoD8CuQTfC+mBu+in0aTxNVrmOBTgrTVx3PB
	 geB3OAG/Gf4jywmJATdCr7qGJKJHkAFiXfD3b8cb5k/pIAJkJUrhWecZUQiLrq/yQU
	 y82iIsdYIxfI2oRKLe/uyWqjvgUNG9qD76CDSbpoaqI3RGYnWSO3SzqWSjWEFoUsPR
	 cBa/teRB6kYkWEaJmXYKjhpT+HYqi6b1sI+0YTJfl8/sMsNTJXKSorrEIx5UjwsZ0H
	 t5wVfNqwnPqGQ==
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
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 6/6] perf machine: Fix insertion of PERF_RECORD_KSYMBOL related kernel maps
Date: Fri, 28 Feb 2025 18:17:34 -0300
Message-ID: <20250228211734.33781-7-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228211734.33781-1-acme@kernel.org>
References: <20250228211734.33781-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

This was detected at the end of a 'perf record' session when build-id
collection was enabled and thus the BPF programs put in place while the
session was running, some even put in place by perf itself were
processed and inserted, with some overlaps related to BPF trampolines
and programs took place.

Using maps__fixup_overlap_and_insert() instead of maps__insert() "fixes"
the problem, in the sense that overlaps will be dealt with and then the
consistency will be kept, but it would be interesting to fully
understand why such overlaps take place and how to deal with them when
doing symbol resolution.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Suggested-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/lkml/CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f7df01adad61ceea..a81ffd2d1a054d60 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -718,7 +718,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 		map__set_start(map, event->ksymbol.addr);
 		map__set_end(map, map__start(map) + event->ksymbol.len);
-		err = maps__insert(machine__kernel_maps(machine), map);
+		err = maps__fixup_overlap_and_insert(machine__kernel_maps(machine), map);
 		if (err) {
 			err = -ENOMEM;
 			goto out;
-- 
2.48.1

