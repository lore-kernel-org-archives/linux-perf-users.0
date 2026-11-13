Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600565;
	b=uS4A/hML4YIt+cbmwJiduloLMXbeIAmUc1UHWsY4gWMf0kX18lwqGDWnknBnthd/wd9D
	 isp9CjAwWA8Teibzn2rSh89TUZIRl+hny0FHkzSN/fniQEgXzm7QfH0eM7nvWq1gqSUUO
	 wl5MzpjH3FrgiCRqhyjVEA4OhKHvC75UsCOPzO7PDRoEmderdOS0o8WtygHUzWANGjMz3
	 RtyJ2SyDay2d9NayNg/8fFOWZflRmFkXO0y67La6yTMsUmGQ9ZSbRz52giojNbixLAyOk
	 Vw9bpeSj7BG4zC1nzMS6BL6Xyi2dMLnJ7W5QulsZRAi0Fii1ELLTISkqtjOA2FntLBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qWqP6GH0+lTFhGRwW5v8zsnl97feZAdLfKOy9amw9ps=;
	b=WuhOrnbHABOUzzzuab1sH5EBmE8cfzEwcY3QI7QgzfmmIqulttiIemKrHdPF5wv0jNBu
	 5V3Zia4MQrxqJyB/Y299VjxYg3w6CvLsFQ60LXLRt/v5KA9CUhadbxDHupZVjv22VptgN
	 ffnAzDFQnERvlJ81lAE9Ac85oUaAt/MrbUcua3LKhS1F/+Ykp+TmaVN98uL9DpP6MIXLq
	 ON9SiJmPoaUtaPPEL1HHkYwFKtH/Nzicf43i2CKdh/SkNaiFZ0jcP1vhubAUsopGgQrWe
	 d1A2qUPWVjPnstQI18u7NT/zMkGOTUQL7c/zGIFfMVKyq8OgaOlZDLZWLlBi19jXueg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NR6KjrRE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72060606A8B9;
	Fri, 13 Nov 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NR6KjrRE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7547D1F000D1;
	Fri, 13 Nov 2026 20:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600564;
	bh=qWqP6GH0+lTFhGRwW5v8zsnl97feZAdLfKOy9amw9ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NR6KjrREgfWr9yP7DdgMNClL5sXfo5dv56425dqylSK0ckDPr5FIzYm6k1viL7DrR
	 nkqKWs/+cYwjCaCOFNq5Hyq6NlWKRGEq4uSxmAJClIZzKbHsF/WofNkSkuOtA+VTEH
	 8W870aobFoM3sRDXJ4GzGXEbawAPF2TAPh4iKJ0G+pH5zkBp/QhgyG+E19y0bCSDVs
	 ZV/Hu2aDjgboEFsf/DVCQ97F0pNTdJzADBOWXzvS1SAH47o1bq97TMWv1Bt+b8v5Bv
	 oGYwHMjO6SlEWC/GEmL+IrNYigvYcISaG62qaWub+926Y09CMOKxuVNziYQvQ6a3jI
	 6JuGvwcocEVdA==
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
Subject: [PATCH v2 10/11] perf test: Drop samples without an IP in the dlfilter test
Date: Fri, 13 Nov 2026 17:08:48 -0300
Message-ID: <20261113200850.2803460-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

