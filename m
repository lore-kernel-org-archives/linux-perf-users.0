Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743496;
	b=M7xc7YyhI21jJHZsM1HX6XK5t0gX2qjM9120A1KjIgni/fuJ0GK9KNi9+cBkwPBYZBvL
	 VHicGXJwZD01nZh0xbe/HlUsEUA/JQSQcS8E3KSVRU9FopVlBxpnNBsA4I9FGz2fpmEWF
	 q0C2ONf46gkFOPxPBQ2nSLkhB3zAIl2GBFUO437Rk8tc1HWbj07YIw6ZBcHq09pJ287ZG
	 dznNyzgY+WSR7UNvXY4qg7xyht+anqNCBpnSCZPreA/YqItypPYErqh5a8ClCTNdeqLvD
	 v+D0QZQZE94KqOEyDDnfpgkHXMHEBnSwXYHTrS7kSE0brUi2IdOAxdU171ywqqNYfJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743496;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KmesgqD06pyFHnoHVwRqRRNgg5icWRxCmP6myfkZQo0=;
	b=nspjb/UqgXVz/DJT75kIni3EcgeGfaX6+O7E0a7rd5Xbe1FoxVSTd39JnEewQg+xAVCP
	 5U7KKUu9XO7sb1CL6jkYea/6MhRfogoDIWjJaAk/QfBkEdZ8hLX+y981HauT41SDWtXPt
	 eb8KbMY804H+dmuYFVPcFR03OZhfvGlfqhT50WEX19ga9/1J3p6gSkST6lIzqN9GGE1Vu
	 VoOrw6c7VJMWs16Jbh1UeCM8kohOOqWcCvp2qSG3N+kxZ0US25B4HvI5fsfK51hFBGfsG
	 HJKvllvE95xLMsksvUISK+WhCZt952IRgKLgc+BD0b2BHgEiMFOyJZ99oCkfG4mvurw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ixrE/NVY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28551606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixrE/NVY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F591F00893;
	Fri, 27 Nov 2026 01:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743496;
	bh=KmesgqD06pyFHnoHVwRqRRNgg5icWRxCmP6myfkZQo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ixrE/NVY9qKP17h+S9DlMxabQFiUBa51I6psYrqf0VssGk7cUTRCR0Vd6ZXVyUT2X
	 N/WmuiJUT9Cw9wtpjV4wrGD0yzSU6vRSL0eR2X1ZE3JOcVIXgg6hpLaV4HWGkzJEvA
	 Rzjij7QOrtIq1twubcw1c9EefSVxrCxRbyVoKlTNgSHQ6fYEdY8NDer6Zh+VbDg+BU
	 dMCRQp4fX6GKQiTzAvkR0VirBWRH/qF+3KBu1YgpexW4UbfFBoDI5c4vIB2EIGGlBo
	 UuX07Jcb+qSdlIL+LVdtM3tLawyIGk/+pvBgYZ0T0VxWwVD2FCzsepdPUnH/PZuQkP
	 JFWw5UXQpn2mQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 01/18] perf kmem: Use the allocation order when matching page frees
Date: Thu, 26 Nov 2026 22:37:44 -0300
Message-ID: <20261127013801.14841-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The page alloc tree is keyed by the values recorded at allocation
time, but the free path looks it up with the order from the free
event while taking the other key fields from the live page record.
When a page is split or reused the orders differ, the lookup misses
and the whole stat fails with a misleading -ENOMEM.

Use the order from the live page record, as is already done for the
gfp flags, migrate type and callsite, so the lookup finds the entry
created at allocation time.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 8693c6b135cad773..3accb5276bd53e5b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -928,6 +928,12 @@ static int evsel__process_page_free_event(struct perf_sample *sample)
 		return 0;
 	}
 
+	/*
+	 * The alloc tree is keyed by the values recorded at allocation
+	 * time.  Use the order from the live page as well, otherwise a
+	 * free of a split/reused page looks up the wrong entry.
+	 */
+	this.order = pstat->order;
 	this.gfp_flags = pstat->gfp_flags;
 	this.migrate_type = pstat->migrate_type;
 	this.callsite = pstat->callsite;
-- 
2.56.0

