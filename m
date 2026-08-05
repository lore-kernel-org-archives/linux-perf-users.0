Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20269472795;
	Wed,  5 Aug 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936733; cv=none; b=rJ1NpziNgQbXN1V5pBHagtBCBdghRDpZcP2EbUjlctknbm3tmLu0czIGVexj/nA6y3t9SnG7XXkyqwGP3TraSeLHMLtgtFt339d8NSMfDjZXA2ilZuIkolhh/VGneF3MB8r2onqcL2mrtWw2k6Vu9k3Vhk6ZcHQcbCYParTlJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936733; c=relaxed/simple;
	bh=HTnHt8qDEbGHfbkkfRXglCVlsHIhPAOEO/9676Dk6D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpzHLxulYF9T1rrqPxYoTR5KBww3Bup9D4SPMzD417/HuaJdOY2h6v+ISfy1i0vhH/WFz3G/k46I7jJ/srsE+iAtpFPIyF59OYnTPQqr3D6FI9hoqjDQxn4fqiMPMgLMGXuYQg0MIsjaoksLFEnZcRmBdfEGOODajjFYtdkr00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk/dt4LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk/dt4LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87911F00A3A;
	Wed,  5 Aug 2026 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936731;
	bh=sYtXTN3C/+goSEj0OlgX2fHRZYMewH2qDu7nAKAo7Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uk/dt4LOkbvE5YpPVQXRwmDWYzc9BmgAvnY0Kx4Q/tMJk005KH6SLOPwEvAfZV15Z
	 zrfYWG+F415FCfyt2h+/ZPNsHUB4vf7jlueLn+lrjRwlOSxT1GSo3Np35Lt3FmslWG
	 OgtmkVjyIKPsEUuc3AXcY3QMKDE8u2VZECfkuoe3/cq+hwflDTX+J59DRp6wulpkGZ
	 sfVWi599hjvble48Jr2bpaE7KKAZyflG7jjVEKYgeaQg5NHvhD+Tv6ebztvBSRdVCo
	 B5Wd+350kyn4p9JDbqrGD+Zk2r1VU3vz8dxVE+MYHaLOwzGCX9S7WJVQM9fg6C8BP7
	 hEbJqka6kX0kQ==
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
Subject: [PATCH 11/12] perf jitdump: Validate sym string NUL-termination in code load
Date: Wed,  5 Aug 2026 10:30:10 -0300
Message-ID: <20260805133013.235016-12-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_load() computes sym = (void *)jr + sizeof(jr->load) and
passes it to jit_emit_elf() which calls strlen(sym) via jit_write_elf().
If code_size equals total_size - sizeof(jr->load), the sym pointer
aliases the code blob with no NUL terminator, and strlen() scans past
the buffer into adjacent heap memory.

Add a memchr() check to verify the symbol name is NUL-terminated within
the region between the load header and the code blob before use.

Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 87612ef3e232598e..5f3a53f818c29f58 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -487,6 +487,13 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	sym   = (void *)((unsigned long)jr + sizeof(jr->load));
 	code  = (unsigned long)jr + jr->load.p.total_size - csize;
+
+	/* sym string lives between the load header and the code blob */
+	if (!memchr(sym, '\0', code - (unsigned long)sym)) {
+		pr_warning("jitdump: unterminated symbol name in code_load record\n");
+		return -1;
+	}
+
 	count = jr->load.code_index;
 	idr_size = jd->machine->id_hdr_size;
 
-- 
2.55.0

