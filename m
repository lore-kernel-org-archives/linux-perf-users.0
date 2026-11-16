Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872855;
	b=pLjML1yxeiiJba4/mPPdjEX6HFpilOnHLNc86fTMA1rIv8ornVCZ4k/pXBYSsRkY+JPg
	 edao85Lr0fUwMIJ2mkEW6vfk9cFwLK6hTcXo3DK2yj6lL1Yw7Di9T8yF7e2T5ZirDBgBM
	 miWOoskOzQIbifFTIEBRXyMjcov0J1W5P3B/U4Qq1kGi2mf+5jpvS7388EIBclsQSwjN3
	 4r0Sfr1bU0JjfRi+AZoyww61JM7ph9EYlB59ahLFI3SYKRnlu2OVIpNSe1MQKI0eKg3PK
	 Jv69bmzGWgQPagqG1jYjYMTJ52btIxAvsfFL4Gliieg3bp1wQcaZbCjimkBD3bYrCbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=44M5CZ0ALtHmaz+dPQtDVPPyPJdEq+3uVAhgHrI6l7U=;
	b=VIJ5Aqgt/KH08OOfSTgJs5HnIR+blcyjgGa4fdk0lCw3Vliam9fpGcLdHCE2XfWeBvkQ
	 zYX/G/tOzc9QZP1B8PRYTU4lTQyU9qtiKTP37S9Z8s3ITY5SgPnTiSkqg0HaWYp8TnCLQ
	 JCKwlP9lj2F+TmDA0cH4sCS352hYGnIafi/WSgoHU/bk3nYunEtQcPCCkoCSlUbC2VHUT
	 mpknW3eQvyLJuvIPfi/ApCZ5lpR8aUWjYcsaI4ZKoIIBHbG1ztpm1RSYWdAeBMjQ37yVc
	 HRo9hCufgMyGiJJfaopyBIrZNPAIxMjE3iFLf3qHIkA/IDSJBD2GEvnETAvrjx0fFqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uyps73ba;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0183606A882;
	Mon, 16 Nov 2026 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uyps73ba
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9E31F000C7;
	Mon, 16 Nov 2026 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872855;
	bh=44M5CZ0ALtHmaz+dPQtDVPPyPJdEq+3uVAhgHrI6l7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uyps73basFqklNEGsEqiqY7GbHBX293KZFg0SWwu30bIuYYFisjI+P4Hc2mhW4sK8
	 vV2iXPEPaYBl/mh/gjXcHZzAkEcfdhXY/eoQoztp7E/fJF6++/IOe+kV3DxpfS4CLE
	 NgHzJEYzy8W7DdcNPhS+FI3iAnRbNg+nAY6I6N2ByO09F5/jd7vIUN+vhgCc6zgupc
	 G0aLSWqv8dxs8nCqsagcaEgMNaGKq9pDE7aFbGgzzjt+5dewy9hjP1m+UOZEwHq7VZ
	 oOo8vJ4DfKrId92PD+/ejuolbDbmjx7AyPVO38UYc3js9bveo8KWOTaNI3JmIfij09
	 5EVlFsg18FwEA==
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
Subject: [PATCH v4 11/12] perf test: Drop samples without an IP in the dlfilter test
Date: Mon, 16 Nov 2026 20:46:57 -0300
Message-ID: <20261116234659.3950531-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116234659.3950531-1-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
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

