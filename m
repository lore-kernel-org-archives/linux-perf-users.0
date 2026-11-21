Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231302;
	b=pzVYCoOdVmTr4672GFhcQALvqftsV390+0sQfsjVAzX8uiUbZY4733XoRPnIY+AVKl90
	 wOZkb/UHMTaKYbzsyAtNfwsm3QHNgZv+nQaAzamQcsqmTUYCO34KvHqCRd5YrPEUSjQJs
	 xsmUkab3XdVnNaIdBGS6nqI3GAJ99w9DiyV5tuL6xFfSUI7ywB7jWy/GNKrSngvA+Q9R2
	 z3FB4bMAAJfkRieQjPlgNo3cjNy/DUCuZ5jTdCu51iwBbexrI6Ce8d38lF5expPWcp5im
	 L3c2kOS0ooNQ5cmsjd9ekpoloJahSfIqW/V4Nir4dGga331Rx2TmA2385adj3XdFEOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r9rkywW6iZzLXO5O3QcBEmkBRS6pLSLATvMPp7gmyB8=;
	b=wnyYmkSEPDixv4shpszUYr2UDVg1D3uhgDuH/oigDmwwaxl+m2oZXt8A9pLfiD4Tcjk6
	 yu7bYG/d1AjCWoTCzANq9Lrlami91ouoYMC1mFL+wBEfm0fRpPHIyobUR0woX9FNSbuJl
	 n1K5vAHNnfvCqpgHqYIdoFRd2/xqsCU36HbxrgKILggPWeoPB1DaCM3G54vKrd45OG0c6
	 ErcyAVBCJZpwJVEatgV+3koo9Ny74SF5xyumoaEaYjMznbguzbxGpY7bSE75Xi2zeS7dc
	 DlamaMNcpWaarVriZJ+nQNrVnAO2jYT3g4by/31m/Iw34YH1qYq05peRNDn/kY4q7YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHUOJySL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAD606A6B6;
	Sat, 21 Nov 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHUOJySL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D51F000C6;
	Sat, 21 Nov 2026 03:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231302;
	bh=r9rkywW6iZzLXO5O3QcBEmkBRS6pLSLATvMPp7gmyB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHUOJySLoeKRMCsn2fl6tU79F4ti60OKujbXFBSZSUCMCVtea06YQRsg8KU0NoIBe
	 HeZZZeESw061qd+PMvKYfYTM2cRsWxU8WBtMUlX4J9PDQ9/h1ThRzFEys5SlA3BsTA
	 8ZRH9DdfmM4ONcucYZCP3TRgrXA4a9s4gHrdOzn31v3LWdoqwBR77jPLYWMdOwPPqE
	 MhWASiqtQ6ofZCJwrR6RCzIfCjTAg2OraHvwhRxZhKvRS2fGZ+G9eDHPlkUaZkDiGs
	 bMeOYrXnjWNbvakKISUib9OFIyqEzlXIeyP1qBp3i0Qvo+vh4mFisIe2dFZd1iDX5y
	 pGHbj2kMoeuwA==
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
Subject: [PATCH v10 13/16] perf test: Drop samples without an IP in the dlfilter test
Date: Sat, 21 Nov 2026 00:20:49 -0300
Message-ID: <20261121032052.1392234-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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

Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a user-only event skids
into kernel mode, so that kernel register state is not exposed to user
space: commit 166f10836a653dfa ("perf/core: Fix kernel register info
leak via hardware skid").

The test records without an event modifier, which is user-only only when
perf falls back to cycles:u for an unprivileged user, which is why root
runs never saw it.  The dlfilter keeps those ip 0 samples, and the check
that nothing but test_loop survives then trips on their lines: the comm
column reads "perf".  Drop them, as everything except test_loop must be
filtered out.

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

