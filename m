Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706901;
	b=QxtDUzu5bqP7bq0prxWbXSBNqN3QUcuKSu+rMLB3q3qFTcpwEoEaDpPEHQKy7cCEUkzL
	 kcNXjl9tW2/pgltK8/PH1ZUvexxLYTPp9nRQw/4HvCzyFFpeLoI8JxIfUYAydKfdNMMBM
	 F4Bjg1IMR62r1xaXueqFusJO+deA/lw5EZJmxmn+qg/8SuQvs5EKn5DypqZW0mP4phpg0
	 CZhkDwiWQDUa+Z0q+5KM9/49gI4FkSeeMO5MQcNE1PgEfh5TxaA+d2bwiVLeoq5+KP7UX
	 jyB/YUtvU2ZMHAl1kZoM8/ErWvOuHAXuJ/K1qcRsb/sCNUPYewkt8PI5s+ddmik2hWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0PIPnyJIvseeQ6XOuPnOZUKIrcamrQwY7xHmagsqP7Q=;
	b=Xpfv13pK7z00W0/A9nNCq7hJQP7ZNgweD2p0lWYtQmNF9EkehCGU8e7wvLk7OnvtBttd
	 fIgEs0asQUO7cnKwk0O6gMCJyoFNCGsMRch6EhJXVM2T6wKCI+LDDPYgBYlKT5d2wVBE3
	 Z1T1I8M/UzcJp8BExGYnS2UVo/4ljvqhb137M+C6MUcGOD8OebrAgPy/FRLNx/4Waq/zk
	 ANw2WPFxME4jnYfm7/n18hI+oeVyxe0l+keKd6qShBvs3ehTobeMW86w2wWy5mlH0RTfz
	 vSazwmWd3eUNT317VPr0sW/WJs+IxQwqLimOM/FCg6NUFRIUkGP4AEDII8fOkKWIfhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYPF+Ywd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6973606A327;
	Sun, 15 Nov 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYPF+Ywd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC68E1F000D0;
	Sun, 15 Nov 2026 01:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706901;
	bh=0PIPnyJIvseeQ6XOuPnOZUKIrcamrQwY7xHmagsqP7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYPF+Ywdm/eZYyKWfOn/ABCzjgSQ57WiO5PSTaVaHcooK0kPdzR8y6sVSejedHowX
	 AiiOGPT6M6Vk+WF7MmFn9sl9gN+3Fa6KTz5VgSuuVIgSJLjJ3qqFprH9zjKUxvfGV3
	 tygnG4fUJfBRCS8S6YE9yglCc1KdYYNDaJ4w4LqtJ/jMW8hgxkW0aI2AEJEDEMiQTj
	 TRl1QeeYUa9BOqYrtw6K88pXbsKb0AkaPrV0q2HpwnoxeeKoITUCstnOu6f7z0Jvdx
	 AjaaqxxFXfuA0avJ4QUKvzH74KP9NyzoU0/SWHQq2b9duH2IF9MQut6XmtH3rGyotj
	 RdGTID4DqdR0w==
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
Subject: [PATCH v3 11/12] perf test: Drop samples without an IP in the dlfilter test
Date: Sat, 14 Nov 2026 22:40:59 -0300
Message-ID: <20261115014102.2879372-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

