Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F9441D;
	Tue,  7 May 2024 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051549; cv=none; b=XEOwY+890VjvZizTdSO5p1e5jgYYp/gXGImjzrx4vsN5eCopTBZi4ZCSxTIR2za3ZsWON9dYstmJ12Y0jlgX9loiuWIFRFMJ3OLBaA0rWoe6uM67zT5YRkISy5/I6NuWVtKGaHGE+oDD70r4M1NhL0lvyOr+FzPKGKkkf9TeNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051549; c=relaxed/simple;
	bh=pvlcwt643zOzwEXI7BQOtxjXGNgcPW5iawds7hOyeCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gr+PNrumBHzOxQgMouYl3A30oqdh8vU8oWE/PehlP/EPSwKurGtkuYRc4+ey7q8soiiFDN/sQUiVgn70eOX8EOlVUj2T5rTpxt/IAChKyknto/dxVQ/VHtHHyGyESN22T2hVCQ2e1J9dPeMY6qfwRjD0PmO8FQXZ0/uwfp6nTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUcFPAPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUcFPAPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1066BC4AF18;
	Tue,  7 May 2024 03:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715051549;
	bh=pvlcwt643zOzwEXI7BQOtxjXGNgcPW5iawds7hOyeCw=;
	h=Date:From:To:Cc:Subject:From;
	b=pUcFPAPxdSmXRgaH5gJ8llhHF3ZQ3RkSPw6c/PhlGHCMkw5xiTgt2gfyCe/ft2yEu
	 HD/WeCumDy9g8+FYboAO8oGWkziCRskU/Vc1geb5DJAzNW3E4Hn/5Vem+rWvowqcBm
	 0qOUYklhwiRKwRmTRBFed4Xp+xLzj4Dq/NSxDWKoHL8PfXyD1ZG7eefJbdShkEoKUd
	 enj8o27nM5dF14jc7a3z/wdLoMz392k82TolaIMd7zBqcXClCUe7RHKv5AdqI1kGej
	 1qxv02T+evYrnNiF4ppiHFJxclIrzO9ikzgIEXn0fbpAUxyaeS0+b6kwvpKro2ZICu
	 TlBt2X9zC29iw==
Date: Tue, 7 May 2024 00:12:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf callchain: Use zfree() to avoid possibly accessing
 dangling pointers
Message-ID: <ZjmcGobQ8E52EyjJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When freeing a->b it is good practice to set a->b to NULL using
zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
pointer is kept somewhere, we can more quickly cause a segfault if some
code tries to use a->b.

Convert one such case in the callchain code.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 68feed8718096f78..1730b852a947400f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -606,7 +606,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 					call->brtype_stat = zalloc(sizeof(*call->brtype_stat));
 					if (!call->brtype_stat) {
 						perror("not enough memory for the code path branch statistics");
-						free(call->brtype_stat);
+						zfree(&call->brtype_stat);
 						return -ENOMEM;
 					}
 				}
-- 
2.44.0

