Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884025;
	b=wQ9yTtBF127Us8VI9QISJ7o4aJg95YG+9Kqhwfh7tfz72/MJIZnv1eLa1WQfHOvsCcDo
	 CSf2XOMMMHmGtsFSdwS5rEcVYbDfLyrbPg1rU0AZXRXfdI8xlx7lZ5I7iEx4+IosnF+Mc
	 O4lzN7fOd9q9it07jvR1GyieIXouaLJwCkZwGt2WAl+5VtaWPfbAapKiCS8Jmu8UfD4z6
	 eo/KzhQyQyePTs4gC5CtKCoRu1UZ7V8HD1OuK13txZhiWNNUd6gb8jGH6igJklKv5E3lV
	 QRfFNql8URRLplKPP+8MMEX/GWPONKaSFxI7/u7VIpDbxNQAQjFzfp3pshQo5HeNezQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=44M5CZ0ALtHmaz+dPQtDVPPyPJdEq+3uVAhgHrI6l7U=;
	b=JINBSYIrHK/d4PV7k8ZeBGFB8QDelSrMGdX1BBefzIkAjEdl1buPhD0ZoVdcT4rXNYIi
	 MXv7vVar0YgRVQBQEdo1zrBkEpf41xrIZnUQL2tUqVbQbLPRK2U+VrT7kQrrSp6lEwSvl
	 0R24Yvmo3quQDImu/0z4ABfjdOD/kPR3EatPhVXL4CfrWKb3wa6xPO7qUleCOGebxBmKI
	 0RBa+zqeujaKDaA4RybbnaUdB8ipPfEwtxe5b9FCc3cOwNKBIj7i20whFZjPKapp2x7Dj
	 kvtDOYIPP0GVMVfZn/wWIx0wOkuyBHLgoD6M3c0JNoGWYs6GWNU5B4elqban6woctmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMe9hK4A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DE606A323;
	Tue, 17 Nov 2026 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMe9hK4A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1501F000C5;
	Tue, 17 Nov 2026 02:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884025;
	bh=44M5CZ0ALtHmaz+dPQtDVPPyPJdEq+3uVAhgHrI6l7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMe9hK4AKiYKxUofJN5o8aEtXvMKf/mpr3Eae+M04OW0wMapWylhkJvEtATILIpQo
	 qzJhgXqryIXkEz6XoS4m9Sn9bwfP9jZ2VIUUmA32AvDYBClx4SKvl5JjuSE//wcx3S
	 /sake7Bw5zFL2//hT2WXj3KjmC5UkprRgZIlzGtE2NYn4tqX6xfm5Brk4BqTzKnj34
	 8DtAh/8Hwmk3kilWTuWzuqDRsHRyK4onqgtyFiW9RtB74I5iAK0dDg4OMFjvyZj9pk
	 wx3bb4PATc8JRJMxk+FYGsJW7cBErye1ZM1nABVKIf1KJ8V0Q3ReAUMPszWGeZzZar
	 e6Ivg1iRtYWYA==
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
Subject: [PATCH v5 11/12] perf test: Drop samples without an IP in the dlfilter test
Date: Mon, 16 Nov 2026 23:53:03 -0300
Message-ID: <20261117025305.3958882-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117025305.3958882-1-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
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
Cc: Ian Rogers <irogers@google.com>
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

