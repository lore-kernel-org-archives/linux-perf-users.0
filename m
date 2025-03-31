Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD401D63F2;
	Mon, 31 Mar 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406645; cv=none; b=kb5vav163NsdOPZVHd4QH3JwdGcDJHL+eUGwloZKUkLQIU5HHcRViw0sDIPooVpTv2Lg+iTX0ntdFgnk+PAWNWgHZkIHRikG2oyardNQFY1SbCqL1I/iBTlgmlV9jyVFREfMtJzwFORfvFCK3FhwNdv4tjDTRbZirMTjcwSwJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406645; c=relaxed/simple;
	bh=FGQlRy0zRUTKNA+1bPygSP1h5Y217grg79LHT1F5Luc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDWlPrGbpMyURv+XM5VfAaR6B7hMpQKjSM2IPiuMjWSFv2XA8/za07LPkiCa53w6JKR60dp0EPjzQGrTi+INUAyPkU9U8TQyo5d1y7RZcAxQrv6Y7sUEnPeTYm7qR247armggWWDspUXIG1RYNLCXDGA68u6omjLoOAxuK4cOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUBq7jzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUBq7jzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C8FC4CEEA;
	Mon, 31 Mar 2025 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743406645;
	bh=FGQlRy0zRUTKNA+1bPygSP1h5Y217grg79LHT1F5Luc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUBq7jzJud0p164Rf3NDPYx0HUcd+5PubfSmpo6NNeC53L36F140K94kVj7VO6w23
	 34CldD5bhAgotpakGhErRZ7zK9wxk0mTsAywFKQV+OUCLthDvHwY3U4VUjd3axvTLE
	 YIadcjwcWotY4/dRvaCApl6CSH4xS5HdXq22TijOyR14xi4iapsx36F3+w40nUJrHV
	 Fmwuhs0WLGZFYhBnRO38DJ/1i5cbbwzgXGwfMKuiciIbYFxhkcmDb1pHdPfkADGR9o
	 nenDDRFR3B1tOIDVvIxTcU5Q4vcR3Htj2xp79Xp+7j6h4agHLyskbv4zviAbQnAG0H
	 OxoTi84cXi9KA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf hist: Allow custom output fields in hierarchy mode
Date: Mon, 31 Mar 2025 00:37:22 -0700
Message-ID: <20250331073722.4695-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331073722.4695-1-namhyung@kernel.org>
References: <20250331073722.4695-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now it can handle multiple output fields and sort keys in separate
levels, so it should be ok to use it in the hierarchy mode.  This
allows fully customized output format.

  $ perf report -F latency,comm,parallelism -H --stdio
  ...
  #     Latency  Command / Parallelism
  # ...........  .....................
  #
      31.84%     cc1
         29.96%     5
          1.24%     4
          0.37%     6
          0.26%     3
          0.02%     2
      24.68%     as
         22.39%     5
          1.12%     2
          0.98%     4
          0.12%     3
          0.07%     6
          ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c207aaed7ae5fc2b..f0299c7ee0254a37 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1672,14 +1672,10 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (symbol_conf.report_hierarchy) {
-		/* disable incompatible options */
-		if (field_order) {
-			pr_err("Error: --hierarchy and --fields options cannot be used together\n");
-			parse_options_usage(report_usage, options, "F", 1);
-			parse_options_usage(NULL, options, "hierarchy", 0);
-			goto error;
-		}
-
+		/*
+		 * The hist entries in hierarchy are added during the collpase
+		 * phase.  Let's enable it even if no sort keys require it.
+		 */
 		perf_hpp_list.need_collapse = true;
 	}
 
-- 
2.49.0

