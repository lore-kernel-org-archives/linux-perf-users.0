Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080841F03D2;
	Wed, 17 Dec 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996769; cv=none; b=sMkTdK5MNYzgJIW0h/zTpbeIsZ5zAf7JclHJfYMVXrNtFvp+1PSszNZhccyPa2ZuGKuhFvISPh1jkVG/AY0UFd/3A/5HslXlcV+qrG5SqaqOFkaRcmDOkQw0QmC9VsHSTq9tTNpwok7wMqYqGC68g2UGY8q/CW3DzguhR9/LHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996769; c=relaxed/simple;
	bh=lXtIObj3UlSPRSiIaKOELtdFUyaEfz8S9Sd4fagY3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BizGIULDHh3e1vZOSEEcjN1HGvBbGjLMjvXgIcY+//bjUZMxJATMJPeBPGXAbYt6R6o7eNFXue9NuhU/asqZPLbF2E69J9xRGM3t9Wt/FnuX0qTXU5BmMIDpSFzQR8fKO6aAwzbNrbgUz2Jy++TLU9AOD95etB1PR+vk6nNzH0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/sTFOec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/sTFOec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19802C4CEF5;
	Wed, 17 Dec 2025 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765996768;
	bh=lXtIObj3UlSPRSiIaKOELtdFUyaEfz8S9Sd4fagY3qA=;
	h=From:To:Cc:Subject:Date:From;
	b=j/sTFOecUkU+uyP1e8HqMCjICadf+H2FkmvvUW253ToiEpsQ3pax/w9aY2h1Yw72H
	 lk/DPjBkkIBxeWwCwH2fXvr/VNocXnnmau+OyKlruLg0KuhTcBLSCcPgt2OdyS63a0
	 GzOXqk14btCn8B/eRh9mKVYOQglc3HJjqjBieC12Ap06364qqsXs69YHa9lbbiTSgQ
	 flB7lgSQtzN1Hgn8Ul1A788Uw49HUNfYd5JyMfkdfB4nIqV7paFDukh9IWl1fntcLU
	 E0RJxKzt9JBmms+RlpYtjT3cdsbE/TEoay3dIpX7k/4CmqHKXILrHcxA+TW8lcDIgR
	 0Um6M0tkOshEQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Gabriel Marin <gmx@google.com>
Subject: [PATCH] perf inject: Keep build-ID data if no option is used
Date: Wed, 17 Dec 2025 10:39:27 -0800
Message-ID: <20251217183927.2259237-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.313.g674ac2bdf7-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keep_feat() determines which header features will be kept or
discarded.  Usually perf inject will add build-IDs based on -b, -B or
other related options.  But it lose build-ID when none of those options
are used.  This is meaningful only when --buildid-mmap is not used.

The following example shows the impact of this change.

  $ perf record --no-buildid-mmap true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.037 MB perf.data (5 samples) ]

  $ perf inject -i perf.data -o perf.data.inject

  $ perf buildid-list -i perf.data
  08cccc2a9388d5247ccb3e864f3063b975b0a15d /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
  fd5c4d5673256cd6bda51725dba048dabb0f854e [kernel.kallsyms]
  97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]

  $ perf buildid-list -i perf.data.inject
  97a36ce1140071be5c36b147fa0bed173e05a602 [vdso]

With this change, perf.data.inject would show the same list (of course,
you need to run perf inject again).

Reported-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index aa7be4fb5838fb99..6080afec537d2178 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2022,7 +2022,7 @@ static int save_section_info(struct perf_inject *inject)
 	return perf_header__process_sections(header, fd, inject, save_section_info_cb);
 }
 
-static bool keep_feat(int feat)
+static bool keep_feat(struct perf_inject *inject, int feat)
 {
 	switch (feat) {
 	/* Keep original information that describes the machine or software */
@@ -2050,6 +2050,7 @@ static bool keep_feat(int feat)
 		return true;
 	/* Information that can be updated */
 	case HEADER_BUILD_ID:
+		return inject->build_id_style == BID_RWS__NONE;
 	case HEADER_CMDLINE:
 	case HEADER_EVENT_DESC:
 	case HEADER_BRANCH_STACK:
@@ -2108,7 +2109,7 @@ static int feat_copy_cb(struct feat_copier *fc, int feat, struct feat_writer *fw
 	int ret;
 
 	if (!inject->secs[feat].offset ||
-	    !keep_feat(feat))
+	    !keep_feat(inject, feat))
 		return 0;
 
 	ret = feat_copy(inject, feat, fw);
-- 
2.52.0.313.g674ac2bdf7-goog

