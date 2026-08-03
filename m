Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67441B8F7;
	Mon,  3 Aug 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768107; cv=none; b=ZRtG78RqhCIBsRhOw/o+h92gV8K0nz1By751aQMa/9DbwfGV9fRLAwWzv1Ci17bGwg9ZrVrW9SsNn49KaJxVVoHosgSOrPysGApj+BaKW4ptNbmYEAmQNWO3MEFw39Kj0Orxjt7tVZqqg5Ntgh/TLtTUDx9nLSjMdxi+2Wlre00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768107; c=relaxed/simple;
	bh=Y6vuqrhQbmGQWSuYzfuKKxnnBww4ZZCFVRBhyT7j5gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqO8jeVAdSES0mhhN3rHMK2755rNfsKLGH1Y8PAW2JQDGnvo9nIl+9iw4HdlfiWoPmWr1uN8z7KAC0wHrNXp/9cGtp5sSlxN/cXQWrK6YBTtvL0hUp61hchT2iZrxYpX8IFjTk0aqHm5ilRN78SSnQI8VkCBQYOhFWNRmVBrm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FojtA5b3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FojtA5b3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7841E1F000E9;
	Mon,  3 Aug 2026 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768106;
	bh=OfVWbXj1OyVDsuO437AUap4y4lwETZYY/FcpnfRqg5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FojtA5b32xb3C3PGrtyaKZbLlzYFzaHdrynMM+8frhZUfM4vqIdD8PIJBlKXyRMVO
	 9MnmB2jjY5FMeGZSTN8JC0d6bu5WakBGpzyHCxS2uKX52N3SVDNVs4w3je+pW7uk7X
	 xpT2vCZbaxW5H1lPoaLhiaWoZedlLB4IHK2nJdM9m4VTE/xHgPmT/uoogpukIQPLci
	 boQgkVLf5+BrY6JIENbbhSYOUfKcdR3jYO/hNXsPDKpvU8ENgerEQgLlQWPNY3mjZT
	 DjBJT/pUY5co5VwAgl22G67niojZLAjIlcScZmUQyI4NEx67HUMRbgvpfnP3y8PM80
	 fnLlWjzEjpE8g==
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
Date: Mon,  3 Aug 2026 11:41:19 -0300
Message-ID: <20260803144119.185637-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803144119.185637-1-acme@kernel.org>
References: <20260803144119.185637-1-acme@kernel.org>
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
index b0f2ba8318304914..e66e9ca8618dc927 100644
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

