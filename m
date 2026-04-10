Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901582765F5;
	Fri, 10 Apr 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781628; cv=none; b=tDQVUfPTN7cnC2U94UAj4+Up1oC17y/Mtmff+R6qAAmUe77hb68+4gy2EF/fJPaFLJc/11v+16MDAvjyyaKMP67ZBz97mAcvs8GLXdRWeFgdY1/1z2RTRi30UcbwQuPdhJryfaK5PHFwwqvoGf4q8NgCillAZavmif++1pGKzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781628; c=relaxed/simple;
	bh=lIJO53dz/dU74xR+TJ0mkJip/iMvG3Hy7+2H1fVOxzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWxq8k7kNBHubb18O2TQ+Bds/JluMp2Av9d1+TLbdT3jl7R49ijscqplPQo0zg3wwiRaGqdrUyYMm4Z+mVw3txMJdy4MsTV/hsGDBxbCFcBu8QfwhYv45izr0IrrbHNe4A75KxUhBtoNps7OtNTKwZ7TY9p6fiU9o7cnAjiNIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTVMxaP1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTVMxaP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8741FC2BC87;
	Fri, 10 Apr 2026 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781628;
	bh=lIJO53dz/dU74xR+TJ0mkJip/iMvG3Hy7+2H1fVOxzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTVMxaP13l00gIBW8vf7eHtgfRRHYUiYK6E/R+GjwpTGMtp9wF1hUXgBjt8cofRfr
	 ys1ua5qU6SKj8Hoh6YaPE59lclJ038MSTtMJ3G8MXEcTL5t+hF22hhPvirQypGZYOd
	 V2h+SmHRM0QG/se4BKAaGLulDsUbNeUvlW9vUCQDqo47qXjuO8m6NPs168C68goPKC
	 xYtu1HFWOe5o+XmcxRmw2VAwJN/0D2CWeV2xeo5kiMhE7LA0JxmH7ffJpf+jFYz8hh
	 icG/RyvWCyUdoi8xFJ7BzDqeFOWUhOxcVspM0OmQDWPJv7F9piMYz5vTOlcMlyWbo3
	 YXhfcaUW7ASqg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/13] perf header: Validate nr_domains when reading HEADER_CPU_DOMAIN_INFO
Date: Thu,  9 Apr 2026 21:39:48 -0300
Message-ID: <20260410004000.148138-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Further validate the HEADER_CPU_DOMAIN_INFO fields, this time checking
the nr_domains field.

Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c6efddb70aee2904..a2796b72adc4d908 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3731,6 +3731,12 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 		if (do_read_u32(ff, &nr_domains))
 			return -1;
 
+		if (nr_domains > max_sched_domains) {
+			pr_err("Invalid HEADER_CPU_DOMAIN_INFO: nr_domains %u > max_sched_domains (%u)\n",
+			       nr_domains, max_sched_domains);
+			return -1;
+		}
+
 		cd_map[cpu]->nr_domains = nr_domains;
 
 		cd_map[cpu]->domains = calloc(max_sched_domains, sizeof(*d_info));
-- 
2.53.0

