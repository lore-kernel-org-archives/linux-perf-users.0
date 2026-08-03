Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B19427FA9;
	Mon,  3 Aug 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780455; cv=none; b=g8DRumYf3FGidE+rLvoFzMjsUn3xEFkXBi0rORn8Kn3mE9NotlJA0iYI8xYCaErs7SMqAIvtbLTs+kl0RU6H7gGEyJo5CPzXXWJnZ5wVJVt2J7UtpNM03bnu/DKm5H02TTRCIU9Ox/z9r32X5cfMoYbXsH85wkdscKhCc0UF07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780455; c=relaxed/simple;
	bh=zAjimA6Trcw3EqzOi0vwjGuqftPX4SstCy+0hlzDjbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hbmv8ZzDmJc9NygOGgi6RyI3nnhrrTKO0G0uzgJizoQZdl5nobBVVzHuXblFZrhJMM38daW3G9OhL2omcmb1H/nz3in0BBUFwUXRn0NVKMvRnKJdMLlkpw0u/Efyzl84s274cvGs0H5vCEPD0vuZNFiwWw7oR6SGuoKdwiDcpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmBf8eCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmBf8eCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093001F000E9;
	Mon,  3 Aug 2026 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780453;
	bh=0ehPmiJpOZutdmChC9Sogk1V8uhHxMhK0Monni27duY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmBf8eCI9aXPZl5sxJn6f7QoPXFWTvV0kXAPz9ygkmVUljYjG1AFMbxoS4Oh1XUwL
	 5WaIYN10VBuGEVv/XJUK/mVKC5LMDHR7tXqdJRwS9FqRwa3dTe6dZ5S1SebL6zmeN7
	 YVdLydPGFVv08VvfGJEQcAfimDtG0pksznBb71lcioDwG2UxeMf26akuAlscHkZm+z
	 2Jwzy19C4ngCgJhfrsomiqJmpyoDqnzhRDAs4oObBK0SCYBzaAGKPYnjxdrA2hksGr
	 v1HxDVj9xyENPloPjCK707uEbhdpFX/6xO4pViAE1eLMu53Ir3JLAm/98bcHThYqdW
	 Ynbt3Bau+4PFA==
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
Date: Mon,  3 Aug 2026 15:07:03 -0300
Message-ID: <20260803180703.194916-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803180703.194916-1-acme@kernel.org>
References: <20260803180703.194916-1-acme@kernel.org>
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
index 160b82694d391c50..a01fa1655569cac9 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2147,6 +2147,8 @@ static int c2c_hists__init(struct c2c_hists *hists,
 			   int nr_header_lines,
 			   struct perf_env *env)
 {
+	int ret;
+
 	__hists__init(&hists->hists, &hists->list);
 
 	/*
@@ -2159,7 +2161,13 @@ static int c2c_hists__init(struct c2c_hists *hists,
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

