Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722F26F295;
	Wed, 10 Dec 2025 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334023; cv=none; b=ucEpmTllikXwRS84gDKktIzn/0As/i7AssWKofGbAOqO45uSrveBotLafLxeq+k1isaz7GzP4p/i/W5hP7+1UKWnWKx+M9SkW9q9v6ii0gyyAeqgzGLA09aJZz/t4stM/oZbDGTS6WpDVJEljTDjg9+OZF0Y6BFNRcrnpKMewVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334023; c=relaxed/simple;
	bh=86swnSN0s+bEaL5SN5EmJNGgj66dgkAauWCfVuExFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZGeV3/AxoPboOV+d30Q1PHpQbicLoMKkZzSf0U9jr1j/XPAYhPGl6VXEmKpLTqKMo78JGOOwrghD6635JljPfK7ARGQbUW15LIsR70vcNwSJs6HMXZkD2Id/57jZoW6LBDQfkfK9BK4O5/eEk0R7yHqOo1dv5VODFOybUvE7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N33KXB0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N33KXB0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05A8C4CEF5;
	Wed, 10 Dec 2025 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765334022;
	bh=86swnSN0s+bEaL5SN5EmJNGgj66dgkAauWCfVuExFvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N33KXB0EFlQo/dHTHzvlLXsqHcitkWOrhsQIiNlpEvCsOsOiZjT5sD2O4IzzFmo3/
	 fEeGlO6Ml8GqUIfRtEYC4exZTChH5ZovLInao3qywJMz/OQXJqe8J+qvnrzq3U8HQo
	 LTtwqav2Je9qURmfya1m6QYC11Ywv7dpz96G8XxjgJnhJo3ixhEZTyaMK9+u7bnbIa
	 osjVtfIc5NvfuZUcAXmokjrkHtfeKwYKCA+aE37+BncvYcaExHkYM7scYh5Xmml/IO
	 R230XFKlZLrER8AV7yvx6R8pFcV9MnnF/HoWJa9+KEIHSJainQXXZe0ytHrkcEcBfk
	 Jbw/qezW8OKeg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf report: Fix histogram entry collapsing for -F option
Date: Tue,  9 Dec 2025 18:33:26 -0800
Message-ID: <20251210023327.1669863-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
In-Reply-To: <20251210023327.1669863-1-namhyung@kernel.org>
References: <20251210023327.1669863-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can use -F/--fields option to set output fields and sort keys
together.  But it missed to set perf_hpp_list->need_collapse for sort
entries that have se_collapse callbacks.  So it ends up with having
duplicated entries separately.

For example, let's run this command first.

  $ perf mem record -t load -U -- perf test -w datasym

This will record samples for memory access (load) to struct 'buf' and a
loop condition ('sig_atomic_t') types.  So the following two commands
should have identical output.

  $ perf report -s type --stdio --percent-limit=1 -q
      87.80%  perf                  buf
      12.17%  perf                  sig_atomic_t

But using -F option didn't collapse the entries based on types so the
result looked like below:

  $ perf report -F overhead,type --stdio --percent-limit=1 -q
      23.31%  perf                  buf
      22.84%  perf                  buf
      21.26%  perf                  buf
      20.39%  perf                  buf
      12.17%  perf                  sig_atomic_t

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index a0a5c1c40af0c318..c51604eaae0a4b90 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3578,6 +3578,9 @@ static int __sort_dimension__add_output(struct perf_hpp_list *list,
 	if (__sort_dimension__add_hpp_output(sd, list, level) < 0)
 		return -1;
 
+	if (sd->entry->se_collapse)
+		list->need_collapse = 1;
+
 	sd->taken = 1;
 	return 0;
 }
-- 
2.52.0.223.gf5cc29aaa4-goog

