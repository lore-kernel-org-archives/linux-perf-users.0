Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38973769FD;
	Sun, 13 Sep 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789266944; cv=none; b=LMB1OuSaARP837H4+JP2M4i/y4OsKNtH9E0UGijkF2bxDz1cWMWNQ8Nk+mQbgrrClZqJTQEfTGc5zgmUhGBNpTmMih/H1n8au2pIoloch4aWOpTnSi7EfPqUQbnaZjilnBHgq42HNXd8iqI7it1wAEhk4zIXkumMYgfUlsaCWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789266944; c=relaxed/simple;
	bh=apH6VZyAnmLAyezMqL9Ah7ks15w3tPV5R2LG2bJnac0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFw8ACq9QMKNtwr3tYvRN/n6XgrmZ/6jH6t4tC/7/AzU/hZgc+42SGqIiQ+sYvY0e4fqSAhuHq6LT5yI2LmBVTkCOs5bEOQoEKtlxMdJj31Ij1HTayyXOSZuMitsxRnVVicfj5Qtw9UVnyFDnY2fNqCP0iH6KNOcVxicXUVlJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aikoE2nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aikoE2nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5069E1F000FF;
	Sun, 13 Sep 2026 02:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789266942;
	bh=TqR2Opoff9JKJPpDA+/gIuMlr5T0eNpJWAK21U2cxek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aikoE2nrG+Bn8C/isHBg5WxU0wrlofxLL9xmLT/3fMsSRsGVmKPyXcffIKHiqaXnV
	 h1MjdJDspRD92IrWzi0sU2QuVn4nzbeUsmT323k/YP3FRrC0aMyXfGxU6nOCpEZXd9
	 aBYGwdJCIDcwqnCTR/4Kn6t173XTTRIBSplTvtTIRjgcvAY1+Oe/5GBNm9paG3QRiq
	 cagklcmML8JfpGog3eIBhvVgcjU/3cd7Yatz2Np3Kv8Toi9ClBjEBXWTiLQ9rTCbXd
	 WuLNGDHeaam65HZwHitZq0Z42dw+WO8AdtQDH0mQtHXQpvd270FfFRAcyIcss2WraY
	 TfyWsw/R478Gw==
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
Subject: [PATCH v1 8/8] perf mem record: Request PERF_SAMPLE_CPU by default
Date: Sat, 12 Sep 2026 23:34:59 -0300
Message-ID: <20260913023459.112654-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913023459.112654-1-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The data-type profiling per-sample stream keys cross-CPU contention on
sample->cpu: without PERF_SAMPLE_CPU the cpu field is the (u32)-1 "no
CPU info" sentinel, documented as such in perf_session__deliver_event(),
and same-instance reads and writes from different cores are
indistinguishable from same-CPU traffic, so pahole's false-sharing
detector cannot tell them apart.

builtin-record.c already defines --sample-cpu and 'perf mem record'
forwards unknown options to the record parser, so passing it explicitly
works today; make it the default, next to the -d (addr) and -W (weight)
the command already requests, documenting it in perf-mem(1).

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 4 ++++
 tools/perf/builtin-mem.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 4d164836d0943119..fe51c5e3333dc4a0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -14,6 +14,10 @@ DESCRIPTION
 -----------
 "perf mem record" runs a command and gathers memory operation data
 from it, into perf.data. Perf record options are accepted and are passed through.
+It also requests the address (-d), the weight (-W, where supported) and the
+CPU id (--sample-cpu) of every sampled access by default; the CPU id is what
+lets per-sample analysis tell reads and writes to the same data from
+different cores apart from same-CPU traffic.
 
 "perf mem report" displays the result. It invokes perf report with the
 right set of options to display a memory access profile. By default, loads
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 6101a26b3a781e69..a708e2549bae4ce7 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -135,6 +135,15 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	rec_argv[i++] = "-d";
 
+	/*
+	 * The data-type profiling per-sample stream keys cross-CPU
+	 * contention on sample->cpu (PERF_SAMPLE_CPU); without it the cpu
+	 * field is the (u32)-1 'no CPU info' sentinel and same-instance
+	 * reads and writes from different cores are indistinguishable
+	 * from same-CPU traffic.
+	 */
+	rec_argv[i++] = "--sample-cpu";
+
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
-- 
2.55.0

