Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1201DFFB;
	Mon,  3 Aug 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758710; cv=none; b=ZYi/sCztciPb54QH9jkBv/UkIEHWYBKz2JBrHoAfSobQWrWNLizQuQr1PKKGIy4AgGjToqboIPLMthHHwK+hknierFmf4rCT3WCMshugHhMbIKfX66e09GCh1nzJdYyMmXLWU2MXZ24BELYhTOAVq8OYpWFRs0omkNNnCKHLqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758710; c=relaxed/simple;
	bh=TgmNrZVKTsJZPeF8sFFjK++F9RQGM12rrMnPYs8X7IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3Y9+l1z2xRqQRVTbtamFX9Y7YS4oQa9Nex8oH7kAcxQ+n8JEYmap1vjSfNu6Uv9ZpINed9TNdq5iLdgLI6SqndyBkCOzrlD7gdMXdsywmYws5Hoz4QqAdttcgMp2IQ6aMEDF7yoYf49RZlBL9Z3Gmzr1WkoLbS8WMZ7a22JniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrLlfOCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrLlfOCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0CE1F000E9;
	Mon,  3 Aug 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785758708;
	bh=cVU+1Df4vguu6lR0AYDtPmvt7+NVZ/lINMitJuIUOdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DrLlfOCNpPw8V4Wl49fE6RlHuqJjktF8mqiwadkTGNQxPkigWxWy7GdmJ48i0OwgV
	 xf4BySEc69nQqL+WgjIIOsvmKF8AuGvfxuA5wJvCigw4mlCJecgwBC09u/rw/NNMob
	 SCH9FAfdYWyLtMb3ZIUQZkn7ehIERjqfo1RvvAZ+MCoe6u11ZAd5ZdaqztXlv7l+KD
	 O0Or2USwevryhVF+DTnNRX5mecupg6X7SY/hEf6qLlguXKquicNhE9pgv3IE1z0bny
	 OXdRey+u/NPx8L4bDNSkK+HTHy1NtgW++BaO/OzabWrjj+Ad4pTLChR9sNrGMd9tZU
	 MXvVM27kMS2IQ==
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
Subject: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_hists__init() failure
Date: Mon,  3 Aug 2026 09:04:52 -0300
Message-ID: <20260803120452.181273-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803120452.181273-1-acme@kernel.org>
References: <20260803120452.181273-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When c2c_hists__init() calls hpp_list__parse() and it fails partway
through, format structures registered via perf_hpp_list__column_register()
and perf_hpp_list__register_sort_field() are left on the hpp_list.  The
c2c_he__alloc_hists() caller handles this with
perf_hpp__reset_output_field(),
but perf_c2c_report() does not, leaking the partially registered entries.

Fix by adding cleanup inside c2c_hists__init() itself, so all callers
are protected.

Fixes: 78b275437873 ("perf c2c report: Add sample processing")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 0f2fb13e705e3712..9f6ae3adb7951287 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2142,6 +2142,8 @@ static int c2c_hists__init(struct c2c_hists *hists,
 			   int nr_header_lines,
 			   struct perf_env *env)
 {
+	int ret;
+
 	__hists__init(&hists->hists, &hists->list);
 
 	/*
@@ -2154,7 +2156,13 @@ static int c2c_hists__init(struct c2c_hists *hists,
 	/* Overload number of header lines.*/
 	hists->list.nr_header_lines = nr_header_lines;
 
-	return hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+	ret = hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+
+	/* Unregister any formats added before the failure point */
+	if (ret)
+		perf_hpp__reset_output_field(&hists->list);
+
+	return ret;
 }
 
 static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
-- 
2.55.0

