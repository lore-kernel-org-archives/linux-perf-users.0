Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582395;
	b=maCSb3wRNCDPPrP5dl4J8QKhd/cJa6m2Coy0ihauDfFa1seO5l37yizIKUfTDnseNjHK
	 9YIpdtplAjxQWja6gYyleSHOXfL9nZWZPIPmmhvmrps2+OSBgLWgZRPuw/1hLOfgymLun
	 e+c1BF53vX8dz7/myIRKpXKeWfnL9DQwf5Q4hzJNZVy+aY5+EDcYH0aIB0S+jbz0qJYoM
	 fgnjUDWKrTmMmqEs5OvkKQAMxT2zSx3cH95RB7WWlmQeQLL6yFN0rrys5vgowze/shp2Q
	 B8ZCsv6W3Q46oL9mqH4MJ2GbqvDb/d51iAi+CfTNKV71JCasAEHF0+U5MEF9NSeYpkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qWqP6GH0+lTFhGRwW5v8zsnl97feZAdLfKOy9amw9ps=;
	b=Y2pl/WWVqGvRf/i8hj4vrLGjin+vCbwzGiIlYb4F93w6M1mf0BM41I4uhpfeznt+0GQB
	 p76OVCFWehPnqjosvm9pPAb1SjXCc6iN+YWTUYAJtV6ic/H6KWRSJ19Ya8fPYj705KMTy
	 Sq8or4rhrjg+MnyPwuj+ri7Y90QclL1lChtjfve1AiKuQ9pAdt6zlfC3SUtyGXip+rthx
	 pC/oOXo5kn8C0lB4nIggqe8mp8cuBzZl0htAGRL59cvzSQ3IebtYu59c9QgLuBYft9zCp
	 dOS3cPeRK8C88KQitrfNodQKDDnjRcyFYKqFsv/q533Dm5o8Rs52pU7UfqX1+9LP5oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeP4fifY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E360A5BEB;
	Fri, 13 Nov 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeP4fifY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0341F000C5;
	Fri, 13 Nov 2026 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582395;
	bh=qWqP6GH0+lTFhGRwW5v8zsnl97feZAdLfKOy9amw9ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeP4fifYuwLPlRIKiXspg+lmrP2kbjQLR2i1XfLkYHKJvCX/peAD1ay1+qJZ2LMjl
	 KCUNUcuu2UApegpO0q819pizBZJZbePl5W15nFta0VeCcCI9EUCm9fLtuF1D+OMDXM
	 ZCmH1wqH78SgHqTXRHjFkMDVRk4VLbDytJLU1qYqwUUKi7KA0jN2hZH/S6/XmRaI7n
	 GYAo03OtEmju9z9gDiMQTAcBIViZPzGBiv1n/kqJx6KC7vNH/wDANGL55DUUk8n3Ys
	 MTb5M3e8wX6dDqQUDNZaIt5oZ2b9nC05qpzBGM0KwagbMAwK82FVKVSEno6eYMAPLh
	 v6i0oKZNynizA==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1 11/12] perf test: Drop samples without an IP in the dlfilter test
Date: Fri, 13 Nov 2026 12:05:52 -0300
Message-ID: <20261113150555.1163049-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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

Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
skids into kernel mode, so that kernel register state is not exposed to
an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
info leak via hardware skid").

The test dlfilter keeps those samples, and the check that nothing but
test_loop survives then trips on their lines: the comm column reads
"perf".  Drop them, which is what the test wants, everything except
test_loop must be filtered out.

Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
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

