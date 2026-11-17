Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945913;
	b=iNW5bOksPSAhjnYTEVoYLwGbRnJuJrJ25+Q15rfBFsRfINgrAznAcOlL4obo3PsJgYZG
	 u5GO5nja9zLtjjpW+t7eMiQudMB3cksZh2qIiOWxGrc70sno7frbv9afd10ViWeA5d1yP
	 T//EmMpZqHttWhSYU6IBTSh+FxoMRfQTdhJW5f4hvz4H9xbCkWt36k3yVaXvyvIx63wvn
	 qVuPrl99YxphicBmkf/RH/hVrDJ3BHR2JC8HPEeiQA+Hs5LMvYicC8Uqm/qDbdGWTjgwN
	 gtMAl/GIYtpjk/bwwuS1UCdpI5fqaGGM3jRE5mY5byLN7g4FpRM3mK8QnGoNrUjkpKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OzrfJus4TpI/Dko4DtIFFHB/mFoe+XSKLpzuiGZA6FM=;
	b=Xhu3R064lGD/iTEKzgOOWWuZThS5YniheBy5A2oCy3gt2L1iR331+349nAh96mBg8qIL
	 pCnw4nIJnsyAOwflzo0mr5l0qZYG0EKahwhi/mkbS/2PXIcG7XVDoqU4V2Owtmvjz38YC
	 hh7bSfpAZJPcpVCgrV6joSEQnOnoBm1EERXCL+G8lRlSfOmLObUUXheGOoDVZkjmuyuts
	 7PPZyqQetfh25jtYiuydZWgHc5OmA69TYHyxNKXVT0RdEobk1gLCSQurccRSZz33yU1/Y
	 hHsCtE8o15cL710si01x0742aYvuS/qNchkm6/+icZatZlc8GKTkLj88QXYniYUmOIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqpHhJzy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB960A5BCA;
	Tue, 17 Nov 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqpHhJzy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5298A1F000C6;
	Tue, 17 Nov 2026 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945913;
	bh=OzrfJus4TpI/Dko4DtIFFHB/mFoe+XSKLpzuiGZA6FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SqpHhJzy2L8bkCH1dbCR+HxQd7C/+VAa5qAWDbocT8FJY4mmt9bwqpy2znhPf8bay
	 rFLhrfKSarOwykWRuBhB80xamCEmvvcgSxScQtZePcSVrnfHp+SQ6PjN7pK9nUH/ME
	 4VyeDGs0d6K/X1cW3Te07+yxZ3DW70gZntdU0Wb4MNXK6qQxfD90myMLpXQS5+31yI
	 gLpFEqRXi0FzVBzicrUde7dl3Hu7pq2HmKA2RqOadEuBWNoyqfIOwlDrsQHBWrY5a8
	 UJv/5SWRIR+wz8AGYRbroPGhg1ki7jtl6DEhL6DG4sqhvlIB4kyZ5WIw5XZhe90+l/
	 KaQmGAEaAXRMA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v6 12/13] perf test: Drop samples without an IP in the dlfilter test
Date: Tue, 17 Nov 2026 17:04:30 -0300
Message-ID: <20261117200433.45174-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117200433.45174-1-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
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

Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
skids into kernel mode, so that kernel register state is not exposed to
an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
info leak via hardware skid").

The test dlfilter keeps those samples, and the check that nothing but
test_loop survives then trips on their lines: the comm column reads
"perf".  Drop them, which is what the test wants, everything except
test_loop must be filtered out.

Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/script_dlfilter.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
index 88222280f6094fd0..797cd9ae84141f64 100755
--- a/tools/perf/tests/shell/script_dlfilter.sh
+++ b/tools/perf/tests/shell/script_dlfilter.sh
@@ -46,7 +46,7 @@ int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ct
 	const struct perf_dlfilter_al *al;
 
 	if (!sample->ip)
-		return 0;
+		return 1;
 
 	al = perf_dlfilter_fns.resolve_ip(ctx);
 	if (!al || !al->sym || strcmp(al->sym, "test_loop"))
-- 
2.56.0

