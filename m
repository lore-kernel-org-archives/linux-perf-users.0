Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C833282F25;
	Sun, 10 May 2026 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384105; cv=none; b=W3+zbOs9iQiXyCpaR+BSqnAsZKbbETJnR3HlzUYDrlsxqv6svTZ4iam1vQMyOhlkc/dd/vgX/Aj1jxL8zXsfbK6K1MTDc1da6fvhamx5XBHqxX1eEfkvqSQs1Fe/xkSfrTZvRGwDqlYVVm3P3z2tXOEu5YSwCyrZ+heNk+LnQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384105; c=relaxed/simple;
	bh=mDFHP9F/Ds48hmOA7Zbg0QqakHTLZzaOdmIMWu0gr2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgPU9vByw2OjoYlpVv9rJDTLyr8jisVA4evwG2ZHKDXZsOEoGBpbCnR3rMbFNZT6vi3Egg5AnrzliL3KXG3Ig2I+jhmdyyxOeODNOVAC3jK+MD+MJZudPimxuzab+1DJOKovdAEZxTF0BA6Rjy5rEs+Y0z+1ilvKM/ahX+uVstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNHLrTHs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNHLrTHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F61C2BCB8;
	Sun, 10 May 2026 03:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384105;
	bh=mDFHP9F/Ds48hmOA7Zbg0QqakHTLZzaOdmIMWu0gr2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNHLrTHsr1p93aLUl8qHhJO9cMwPLIGBNmvJt8uGtRTu35mH7Wv+vvJaB1maqeSp4
	 uypO2SSNJDNXpqwrOdDzksT4SnJ6CLlr+YGmt6UwqZ1tQItYmdWU4lktXfhJkoqaeX
	 thirlPtgd60RNDD003UKhBPprnwYlrw+4r0+xka5PHPkWlJXPbBCEQj03yU26ZAT9E
	 eMyH2rjL3umew5PixpEuZJK4DvBQB6V5cC/7lpCrwRe6YlztxsN6B7XT71FBc6uwN8
	 bf7Oy3FifLmIhZ+Y6VWM+Qi+vluyzRXFUYUW27rcTTZvUSKKSUYnJQ/lXebuIrR4La
	 cQ6q1hgs/t4Cw==
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
Subject: [PATCH 06/28] perf session: Align auxtrace_info priv size before byte-swapping
Date: Sun, 10 May 2026 00:33:57 -0300
Message-ID: <20260510033424.255812-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_event__auxtrace_info_swap() passes the raw remainder of
header.size to mem_bswap_64(), which swaps in 8-byte chunks.
If the size is not a multiple of 8, the last iteration reads and
writes 8 bytes from a shorter region, overrunning the event
buffer by up to 7 bytes.

Round down to a u64 boundary — priv[] is a u64 array, so any
unaligned tail is padding that doesn't need swapping.

Also fix swap_sample_id_all() which had the same issue — replace
BUG_ON(size % sizeof(u64)) with rounding down, since crafted
events may have unaligned trailing data.

Note: the strlen calls in string-field swap handlers (comm,
mmap, mmap2, cgroup) are replaced with bounded strnlen by the
next patch in this series ("perf session: Add validated swap
infrastructure with null-termination checks").

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 20b70d6fb7cc8ed4..b55c5168ee9f4aae 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -276,10 +276,16 @@ void perf_session__delete(struct perf_session *session)
 static void swap_sample_id_all(union perf_event *event, void *data)
 {
 	void *end = (void *) event + event->header.size;
-	int size = end - data;
+	int size;
 
-	BUG_ON(size % sizeof(u64));
-	mem_bswap_64(data, size);
+	if (data >= end)
+		return;
+
+	size = end - data;
+	/* Only swap complete 8-byte elements */
+	size &= ~(int)(sizeof(u64) - 1);
+	if (size > 0)
+		mem_bswap_64(data, size);
 }
 
 static void perf_event__all64_swap(union perf_event *event,
@@ -585,6 +591,8 @@ static void perf_event__auxtrace_info_swap(union perf_event *event,
 
 	size = event->header.size;
 	size -= (void *)&event->auxtrace_info.priv - (void *)event;
+	/* priv[] is a u64 array; only swap complete 8-byte elements */
+	size &= ~(size_t)(sizeof(u64) - 1);
 	mem_bswap_64(event->auxtrace_info.priv, size);
 }
 
-- 
2.54.0

