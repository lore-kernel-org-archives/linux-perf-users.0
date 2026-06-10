Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407493563EB;
	Wed, 10 Jun 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121229; cv=none; b=Nk8ftL/15qPKKXXbya+CUoIFjwTstKkQp/poIAybstQyxf+aply3bBdSNI5OeT4V/jhZD4HIJY3tydLKZ1DjxI0V4KvOUmhCxsrL2Xa3+yIlCGSUj1zcUkJUa4WSt1ATymnwuXSnA1m92sO8Qkpz1Nojtoss586808Ep/Wu20hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121229; c=relaxed/simple;
	bh=SaZE6ErcHnimcEVhvBKO4cAl8SqYRtCBgGNYmKK3ZoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZf3dWvaI2wJJxJoaJfJT83089HvMLUIEH8lpQu5l06RqnyCehe/ry957+cd2vJK46fEp933UdpYoQyrfWL0+0zSwBZXobXcbcuG6DHHfScsNWtkg0ybrKwmC38x4yTTwWnOooiXaXUsDKIN1s1sIkA61EEihqem9Fok0a/6FCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZOXwQwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZOXwQwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156701F00898;
	Wed, 10 Jun 2026 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121228;
	bh=8h1NZ9fygwyxLmnH5W7Adx/qe56rz3NOd/fUl757vdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZOXwQwEXHsmxytK6GY71RaOWNkL63jyWak4kJ+kDvPsBZu26PsFoWD1b1QbvaPD0
	 A8umdw+tkLwpkdF7BzvLYwBSHdfFg4dFYR36sbx8nCmP8SjmOAW+7Y5Hv706sCACsQ
	 j68tE5T75lHQH2YInc1vcfkKQ0x3X1oH7VJwEG/5YDtl3a3QZ//Dn0/Nw02gr6nnu4
	 YZYuLYxyVXY/6WJz4DWU6Jv8UdYU9r2fy/TG9aEurP13drxyfz0GFJuqCHFmznGHQM
	 LN+HmlSs1yOgexTC4vB51lAk5YTWwGp4ZTgDu00XLFUptwIhodnRp7OlqXH3NVEqTv
	 e4HFv7QuaomQg==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Blake Jones <blakejones@google.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 20/23] perf bpf: Fix map data leak in bpf_metadata_create() on alloc failure
Date: Wed, 10 Jun 2026 16:51:53 -0300
Message-ID: <20260610195157.2091137-21-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

bpf_metadata_create() calls bpf_metadata_read_map_data() which
allocates map.btf and map.rodata.  If the subsequent
bpf_metadata_alloc() fails, the code does 'continue' which skips
bpf_metadata_free_map_data(), permanently leaking both allocations.

Fix by calling bpf_metadata_free_map_data() before continue.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: ab38e84ba9a80581 ("perf record: collect BPF metadata from existing BPF programs")
Cc: Blake Jones <blakejones@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index fe01551dc3e6cc29..b65ad28cd950fc64 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -395,8 +395,10 @@ static struct bpf_metadata *bpf_metadata_create(struct bpf_prog_info *info)
 			continue;
 
 		metadata = bpf_metadata_alloc(info->nr_prog_tags, map.num_vars);
-		if (!metadata)
+		if (!metadata) {
+			bpf_metadata_free_map_data(&map);
 			continue;
+		}
 
 		bpf_metadata_fill_event(&map, &metadata->event->bpf_metadata);
 
-- 
2.54.0

