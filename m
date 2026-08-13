Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA623B6BE5;
	Thu, 13 Aug 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633926; cv=none; b=isst5VacGzf2E92DOlWtKOQ0OQSljmjyj0nnbbXKaHTueP/lT/EvTAPa5wqEoqiQ/kkWqtl6F7N4uco2kgI1CQFkr8dB6r5rJ7uZCahpWqFzxGyMt3iIy6uNm9fUyOK+TO3ixLMt66Xet7tKfCnqTEoJI2LnG/p4LGb2r9lApvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633926; c=relaxed/simple;
	bh=LCOo1iRSXOwVGYcLMl/phBY+fYn56Gcsb0KxeLjxy9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvNLcC0oB17YCppkXM6uYrlra2cbw/fOUB8DSMk/SrozrZg9c7Z7Cpyq25cYPe6alDynYSQy0N0KEWlkja2cVzbaEAcT/ye916CIz67133c0Ju/DuZ4kPR8cIXw25/JVLOO1w/gjsvkc0HEKelq+AmE6HrXzaiTZkuZEksTnda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVgg4n+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVgg4n+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC7E1F000E9;
	Thu, 13 Aug 2026 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633924;
	bh=5/3QjbKl+HrIXMVxHIqO5+5iknGvkzhHDhC4auX3+Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aVgg4n+iOuY9SKvCdBXR/+nphrlk6jm4aSfNeK7xaQJDCbu0GBV/aqbVo3Pkh6Nky
	 DRUP2v8C9Yq3Btjer4ZO0hb4TxlGcmSCegzX8lorLDFIT4r7W8Z3U+eUvzr+bliOu0
	 Qmd83GLaJIBmRVJVEjuz56YOhwiLSJ7EavDMKSzrbzIhTWFIjZBKm39HKcDEd6YB3R
	 8YoTdsQAmQoubgGyLfY4EzzDmygf7eyM8iv2l7Ykg199UKBOqPSAne8yu3+W0afCgv
	 L8ELceKCFmDgd+BdxEsP6qh9p9LLygnwvEW1bD/0JwChZTSRv/4RAMf0Jq+MwrtET3
	 sMgqJAkiW+R/g==
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
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 3/5] perf dso: Use stored fd error instead of stale errno in file_read() and file_size()
Date: Thu, 13 Aug 2026 12:11:44 -0300
Message-ID: <20260813151148.23169-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813151148.23169-1-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

file_read() and file_size() use ret = -errno when
dso__data(dso)->fd is negative after try_to_open_dso() fails.  By this
point errno has been through mutex_lock(), nsinfo__mountns_enter(), and
multiple open() attempts inside try_to_open_dso() — it no longer
reflects the actual open failure.  If errno happens to be 0, ret = 0
looks like EOF rather than an error, and file_size() callers like
dso__data_size() would then report a zero-sized file instead of
failing.

dso__data(dso)->fd is always negative on failure — -errno from
__open_dso() when no filename could be built (e.g. -EINVAL, -ENOENT),
or -1 when do_open() itself failed — and never 0, so use it directly
instead of reading the stale global errno.

No assert() or comment is needed after the assignment: the enclosing
if (dso__data(dso)->fd < 0) already guarantees ret < 0
[Namhyung Kim review].

Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 41bbc8f994e41a3d..60aa77f7978514ec 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1038,7 +1038,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	if (dso__data(dso)->fd < 0) {
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
-		ret = -errno;
+		ret = dso__data(dso)->fd;
 		goto out;
 	}
 
@@ -1160,8 +1160,8 @@ static int file_size(struct dso *dso, struct machine *machine)
 	try_to_open_dso(dso, machine);
 
 	if (dso__data(dso)->fd < 0) {
-		ret = -errno;
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
+		ret = dso__data(dso)->fd;
 		goto out;
 	}
 
-- 
2.55.0

