Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABE125A3
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAWQyKUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDC9C36AF0;
	Thu,  5 Oct 2023 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696512582;
	bh=eKVQkVdvM1LQ6mdxoEN/45x8ioQAGbo/3OSjYqGT/r0=;
	h=Date:From:To:Cc:Subject:From;
	b=aAWQyKUh4zUic5w8JBKR8q7LW20d07MjI5VXbf1ZNy1lm5Ck3Dat2QYjvA4xwfbh6
	 26SCzaTVtVL3YmmU0temuuhTrpvaPygIvxS8CZx5tdXKano1Prdgdf5GEHKLGNS4zv
	 rQcRIu68EyVNBFmpPxMI8ARH9pd23Do6Ek+twgfZ0h5FwkQz00ki+B+j6SnzmTiKZ2
	 TcH2QiBxBb6hF7djVLFHd4mNemkWrO25oRWaR8LY6WvN7gstiUSrjsIsJnC+tIIzPT
	 cTQAKDEhMkiqWJkfzABR9m8Qmlqbe3JkSUyfV5IgNG0Ne1kW9WMdLQL2PPnpGNYrBu
	 SZcrbTCr0LXzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 693B640508; Thu,  5 Oct 2023 10:29:38 -0300 (-03)
Date: Thu, 5 Oct 2023 10:29:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf symbols: Add 'intel_idle_ibrs' to the list of idle
 symbols
Message-ID: <ZR66Qgbcltt+zG7F@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url: http://acmel.wordpress.com

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is a longstanding to do list entry: we need a way to see that a
sample took place while in idle state, as the current way to do it is
to infer that by the name of the functions that in such state have
more samples, IOW: a hack.

Maybe we can do flip a bit in samples that take place inside the
enter/exit idle section in do_idle()?

But till then, add one more :-\

Cc: Adrian Hunter <adrian.hunter@intel.com>
cc: Frédéric Weisbecker <fweisbec@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5b54d2639df4740e..3c7f483bf85bbdaf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -718,6 +718,7 @@ static bool symbol__is_idle(const char *name)
 		"cpu_startup_entry",
 		"idle_cpu",
 		"intel_idle",
+		"intel_idle_ibrs",
 		"default_idle",
 		"native_safe_halt",
 		"enter_idle",
-- 
2.41.0

