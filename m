Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4524DFF9;
	Thu,  6 Aug 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019817; cv=none; b=IpuPFndcm0aKPgZRyelBVL6LvxnFT3Vm7qegPiOJ/XNdCtTCE9q94jyg+55dN2Ftis0UTvc9hS5GCxvrBDdGHL10mc3Rqjja68JIb5a82730QF4/7ha4aOC+5COn1LxprxMuNASiZpSabmQS5h9gG+E+hvR0cd6hu3c2iAOLEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019817; c=relaxed/simple;
	bh=OLE+kfWsYBXHwKS9jCVJiWVrON8POOg2LLckCnx1WjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh+ZalN27kCxiGhfADStTuhHUGWG/Gtvl6VrYgvlS3pDFSnFznSC8qVPr6JyrO6D2DwkVwnDAcoksuxphDHUmziE+Bo/8eTM6VLv+pGx6I9HH46A4twrBN4QAQGFNce3Q7gyiDdoPGXR/Ls4JpoRRFPuOtXDyGCisPFHajDx2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ/6vZSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ/6vZSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0961F000E9;
	Thu,  6 Aug 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019815;
	bh=eN9S5ZHoWuKMzVLeKazGTDHy6iIEOvjet1utFvcBteI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQ/6vZSpDl7hBJe2XwnQ3O5MDAWchITs1lyyd5YzZC+jc8erg5mOJpuixpDL0sBNf
	 PBe7vEssjVn3EMCRjRBswu1UlWd/is21EI7Bh1TMaWi/4B0oMoQB0NgyjYwdGyi4iV
	 XXtPRzUqZw8T0Kw+KOTVjW5Vf880nYgrBrRy/iSYNOJS1jULfK/dvvupNWDSnpISkS
	 7wOaVN2rowzCxlDacRDqKDvZC4yJGoLURqx1eCgsaAXC3TLer2RD/dvVlTHy2MkV4L
	 DbV3ymGBOLLcQpKAyJrWzz815cfngAM70LCcNDZOHJtQ9b8fu41DgpmYmtH6Z/a8qu
	 3MEyizwhsSy5w==
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
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 08/12] perf jitdump: Free event in jit_repipe_code_move()
Date: Thu,  6 Aug 2026 09:35:59 -0300
Message-ID: <20260806123604.271277-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_move() allocates a perf_event with calloc but never
frees it — the 'out' label exits with only perf_sample__exit().

The sibling function jit_repipe_code_load() correctly calls
free(event) at its out label.  Add the same free(event) to
jit_repipe_code_move().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index ae63366b86c6d765..91aa1eea8229faac 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -685,6 +685,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
 out:
 	perf_sample__exit(&sample);
+	free(event);
 	return ret;
 }
 
-- 
2.55.0

