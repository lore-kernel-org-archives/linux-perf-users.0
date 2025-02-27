Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7327129B;
	Thu, 27 Feb 2025 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693327; cv=none; b=aNluhgLkKByQsmPcJCwK7DqvpvfGfp8iA4VB7cjF9F59xdPQ8mpxHEz4rn9wfqZ5yn/GF70FFhFbPqOHEnN6oKHDL0/COmE+cL+PS+WrhU35yCuiZbuJfoLkBS2RuZU9hhGgZE3hZMryciZ0PuvapSaDcRjBbZ9oy0otKW6+fwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693327; c=relaxed/simple;
	bh=dVkSwrO9bTxiAns+EuNEGFekp4a/+02PboKlbwgKvcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZzkuvLDlWrkEITjzCSE3MAF7280g4MjFso6CzBHpRgluTHIQxXoNr89dTX3WhTMp8I0yz9ZidnUkZ89pePyWMZ74KQVWmfZxQB2VpyzAwvaP08BvGOBilY0vOIVd8F8PEcg1WRA4VM/yq9k0PLJ9/mfE76cek4bfT+0uEbSvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqqnoNdl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqqnoNdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D267C4CEDD;
	Thu, 27 Feb 2025 21:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693327;
	bh=dVkSwrO9bTxiAns+EuNEGFekp4a/+02PboKlbwgKvcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqqnoNdl7vz79QlA3ijr77jounrRbCrdbVegaxnINXDNfv7VCJOZdaGlECquMJ0Rj
	 Jjlfd5kO/83T8GbLpTG+mAAgsopOEfKGTdQ2UFAim4wWeOOUG2kU9mcoR/T4fLVjUl
	 iItiDFwpGPJgJbWo9twLgyRu+MEQOgnEz+a+m6juoeYa/jMCvA/OqVAUfqMyvCnNhm
	 COHDbHc8IE6crgRsJbWwNoxnZJl8ZGTAmDYOBgg7dXWgTLaNEhzDBiKDT+U5Jr2s0c
	 2p+sQXfyk1Ketf6A3cnFUaeuiM8OEhOB/2vNGv7MT3EjvXNMGqsm9IzdSCmToo+cXX
	 jzsENbyDozD2g==
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
Date: Thu, 27 Feb 2025 18:54:55 -0300
Message-ID: <20250227215455.30514-7-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215455.30514-1-acme@kernel.org>
References: <20250227215455.30514-1-acme@kernel.org>
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
2.47.0

