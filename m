Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936A3750D6;
	Wed, 10 Jun 2026 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121234; cv=none; b=q6xEuIilSigjq2tyR+7CI/2u+3wdg/2afbwiUkY1ApIK9sMws/azh1evaNzOdpt4S3uwL+MjLQdw8pMT0a4Olg3nqrAbtTWpbzu4Ov0S1rQ7hcA7u93sEocmg1ekb4JFrEWCURlFKMY3P2S+tac3CWx67SX1y6GY5XunB7k0Lok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121234; c=relaxed/simple;
	bh=XkUbtpmhgIrKAaFmr+zisFGY+SK/KapOLub68V/gxXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK+1tyKQysivBvc6FVgvMQe76daIRKMgIbhc5X5CKh+6V6jvbFEug5BIioC9lmGwaOh7F5vXQZ/fd3Zs5n8QASTxbJZvmA3G3IouhfSl0X4uN/e8vfrY/6ffePAD3RzbyEqx182wvkXehY4s0p4zAgsUsx9ksWpqDUprY4q77mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0whxfXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0whxfXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E5F1F00893;
	Wed, 10 Jun 2026 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121233;
	bh=U9ZzVr/BRlqUkpTSH+uAhYhw/5veBXmgMpUC8SCcl5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C0whxfXgqv+3r5nf2J13fccznNFUgGl/749kc/hRv5WrPl2V7jpCrCwiBNjM72I6k
	 pQlIaHsPSNiVtyQRc1kAc9uFiBptdTtWT/+SI3MkBpuH4GVpFNt6YoneFNupCYVXlf
	 Y3XZ5LVcE9H2GORcngUwWKepdMa7+R1/goZyWXE3NIvQo0jpInQ7zmilrLUaXgicG+
	 QPB+YID5iyFurJmRwwBvOU06Z3T/z6DAH10PIqrxQKZNE/wm0uQTjCgU6na4OhiRAH
	 4uNkjv5rrH9DuWTMs2aKY0nJU2xjA3QBvX12ecV8zUh8W1RvQuPpCH0MctH5rZaDz7
	 WnyvHhjgcJkmA==
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
Subject: [PATCH 21/23] perf bpf: Fix metadata leak in perf_env__add_bpf_info() on duplicate insert
Date: Wed, 10 Jun 2026 16:51:54 -0300
Message-ID: <20260610195157.2091137-22-acme@kernel.org>
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

When perf_env__insert_bpf_prog_info() returns false (duplicate
program), the error path frees info_linear and info_node but not
info_node->metadata.  If bpf_metadata_create() had succeeded, the
metadata allocation is permanently leaked.

Fix by calling bpf_metadata_free() on info_node->metadata before
freeing info_node.  bpf_metadata_free() handles NULL, so this is
safe even when bpf_metadata_create() returned NULL.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: fdc3441f2d317b40 ("perf record: collect BPF metadata from new programs")
Cc: Blake Jones <blakejones@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index b65ad28cd950fc64..c4594969d7677238 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -873,6 +873,7 @@ static int perf_env__add_bpf_info(struct perf_env *env, u32 id)
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
 			pr_debug("%s: duplicate add bpf info request for id %u\n",
 				 __func__, btf_id);
+			bpf_metadata_free(info_node->metadata);
 			free(info_linear);
 			free(info_node);
 			goto out;
-- 
2.54.0

