Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68746F485;
	Wed,  5 Aug 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936711; cv=none; b=S/8BDFKwajKFXPUXSVdBiJr8kl3rX/ClKPze+AbI2y4sRXSrtrV3uVatMA8B3H1M50ZjX8DTdb21fgqb/eZDxKpxLfcf7+0m578TL/RPeWD6Kcy1XucfLYDplHsKg/QzVS77X5NPz0G9ajGsQNFLRGkobbWPyNwVuPHJTZaf22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936711; c=relaxed/simple;
	bh=pW3uCAG3vsiuBF2sw9z/uSPSTEDAboYxHg1CaOEJbbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIRwPTH2eioQ882nmVq7cB+sobSLqVp/Eho/Tik1F2+8q4lGQN/ilRrbdSOLOl2vMV2oOxSAT+kISQhLjB2Rojf1+6DRPLKgh5j5IBq3bcTBcUNyoorO0ZFQsgvA/8nnz+do1VG6vZIPmjmiAcMoNnGbVNBfmioaQGpn/oVMhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5wgdlTG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5wgdlTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3271F00A3D;
	Wed,  5 Aug 2026 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936710;
	bh=IebGWcr1gbp+6aNhwdRln7VWAiSH8dm1KYaLctFflwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U5wgdlTG7nmzSVfXkG4sa0aY5m8UlLK068YMK1oJ/+trZIyyfQCkDiG3Z/Gj4EwDj
	 UbGGWEQBn+N0iKWf+nv8BpAY2WLsaFbblASwPagVMcjS62lvLyZt4FvHxpvrm1jeGo
	 hXEFzmkIhLwdDfELCNrUSzE83EcyLINyYO3gGMr17pOzEWvGcA9TEQtygqSAr38iic
	 XjnVrXSAu/lQm8RN0BkyTOOfvMwVNeShkM9Grw+zZxcJdr4zcGx29D4arWJu+IFXTh
	 /pAtcOYETECQrj2h524dafJPoMT+se6IQQu7JEDX5mwI06dkCYxti28ioc7wGO6lbT
	 ilcWBar0Ev0/g==
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
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 07/12] perf jitdump: Free event in jit_repipe_code_move()
Date: Wed,  5 Aug 2026 10:30:06 -0300
Message-ID: <20260805133013.235016-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_move() allocates a perf_event with calloc but never
frees it — the 'out' label exits with only perf_sample__exit().

The sibling function jit_repipe_code_load() correctly calls
free(event) at its out label.  Add the same free(event) to
jit_repipe_code_move().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index c3f11d1c1d76d6c7..4f52b143cd0da296 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -683,6 +683,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
 out:
 	perf_sample__exit(&sample);
+	free(event);
 	return ret;
 }
 
-- 
2.55.0

