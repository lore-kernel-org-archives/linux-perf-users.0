Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941361;
	b=qtQ1cOSzUJZd9x5mgTQy141FnwPX0zs1c/rUJhM0luTfZzhptuc8YIO3t4Cns5fogbsy
	 YfcXn8vByJJDT3m39VyET5J9ufMtTf2PvyE6jeVdAFYSCbiR9/7X+F+0Xo708vJRaox68
	 BazMu9NAmHTWwSBRGKRlJ14b22DdnpPTmO18FJL5WUVAsnC6GHkqO+5sUszDSLu8qiloP
	 CcdLrRAJPqkToZTnvCZ42g2uj7GzlpMaAuo1J9iiyH0ouIcGOyZMEA0y1CUdUKPFm8WvH
	 BlJ/MGckApzInzXpJOYGpcEXspkBUhuaoh7Ayg2i45ppaFUfn0EOrcTPSLVT4qlIjTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eeTG4TqTHeCP3y4cQ5EWaophStPtsy5e25rUv6vANm8=;
	b=FKXGZZ6yVtHg6b8spgIkJpGwEBkb63UoUpPBeovnb6bekulyfIfM3OW96teMSMulDKXJ
	 0NdjcFqmm/8aKBuS3PSTzVhonYRfhvIj6W8r+Y4fvedY2WwFQKWLy27UoCwzq+xytPwoI
	 L8FJxgVP6liCJ0l/hvUGoaLgUcFEBA5c7KJFE2RF86T5T7Ii7TFnkT048o5lT040O+k1I
	 LmFCnK824DV0OsKzXaHP8uAVTuHlhzfAeJ9KdxJ3F15QRUrNyHmCAbMRWmLdqiSPJGKVF
	 sdD8TkzdGrMph0rFbHPmO8F3q54loE6UMCP5Wuho5m0ega91JB1um14v42vrSbziOpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cKNjeJ9F;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F2606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 343F2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cKNjeJ9F
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso269490eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941360; x=1795546160; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeTG4TqTHeCP3y4cQ5EWaophStPtsy5e25rUv6vANm8=;
        b=cKNjeJ9FvSE+77axmwTQSvSkn4XafyNGQ7u0Uo/fT7Jv5GhUL29FdIYSERWVZhZioP
         /6dVv0fEa+5Nq1fxN/d/dMCbhSrAPE99rhiWvaEMyZiDjNNlhaJ5oS9HmQBit7/zatgx
         YU/0swQ6p8IPKmegVRhjuDFP/fe9g3tTPuBuqMiKmSO9Yl1iQMWRABxHhcEzNSeZAQyp
         tvwIhWFqv/CRLmWH2qTIZIH7/GWbcSpMC4/cQEzMK5ZCyeGl2Artx4Swt6PLzb+XUr4b
         mpGENit2MWjeXualFtfti2MS15e4MTBAH1r9pO5GidLzDZ7oNquWURyAoMkkcGE/zhgj
         Z/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941360; x=1795546160;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eeTG4TqTHeCP3y4cQ5EWaophStPtsy5e25rUv6vANm8=;
        b=UIJyLW+fn60XlBsFPOGfwnMdt+cTOBIwF2JEZj44VRlEezCJyQrfETeJ8sifPsydOd
         bmb0ClNjXSisg5pEbvTO2JX8YmHkfxDvdQpYJS82Hl76qYHOycLXtTDBSLhTbIaEDzPH
         XNVWVEmcLTK/Yk+qoYgQI9OEPqpPJgSkNGx8lkNGPSEMQPpA/oiGuyYxAtrINdCfGOB6
         txmB75xpfwla4kL7MKXuMZXoQUJzGXdTGEtzCQh1VRwCtbNUYuRhrVO47jq1WQYU5Fc/
         G4uPBD3eyX25iMfTqIApboDe5Y8ZFgosGRVZjWMcxyV2XrKUwpOL27+FHHka6x2uCCvY
         EQlQ==
X-Forwarded-Encrypted: i=1; AL+hErGbz7T2VrLrY8z7q8mLF9Gp9IOj54kWHIKE2yGR5wwqIhltcpcYexjIlEKtaTE17mU11LCft/rcQ8OU5YFZKrXY@vger.kernel.org
X-Gm-Message-State: APuU4Z/doxuryLTl1JbvBDJZ5w8HLGIMHC/Ta/NTdXw45j2JVcaTMVaP
	BFMO28QGNhXpHbFyODtQUDSP/Y5yTUDlDdB7V7a0j3+P1YLFTJseHS0EKu2ADU90UgFKIHUAdd6
	WFCh+HRsDKg==
X-Received: from dlbej6.prod.google.com ([2002:a05:7022:c46:b0:1a0:100d:fd6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2409:b0:1b3:b833:6565
 with SMTP id a92af1059eb24-1b543cd7213mr493110c88.20.1794941359867; Tue, 17
 Nov 2026 10:49:19 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:29 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-9-irogers@google.com>
Subject: [PATCH v14 08/23] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Factor out dso__is_bpf_prog() from __map__is_bpf_prog() and update
dsos__find_kernel_dso_cb() to skip dso__is_bpf_prog(dso),
DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
In machine__process_ksymbol_register(), also check
event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF before setting
DSO_BINARY_TYPE__BPF_IMAGE for is_bpf_image() symbols prior to inserting
the DSO.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h     | 16 ++++++++++++++++
 tools/perf/util/dsos.c    |  3 +++
 tools/perf/util/machine.c |  9 ++++-----
 tools/perf/util/map.c     | 14 ++------------
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f6c60bafcde1..009bd3001ace 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -1022,6 +1022,22 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 	return is_guest_kallsyms_pid_name(name);
 }
 
+static inline bool dso__is_bpf_prog(const struct dso *dso)
+{
+	const char *name;
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return true;
+
+	/*
+	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = dso__short_name(dso);
+	return name && !strncmp(name, "bpf_prog_", sizeof("bpf_prog_") - 1);
+}
+
 static inline enum dso_binary_type dso__dbginfo_type(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->dbginfo_type;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1574c8885d78..a7f6a98acbaf 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
 	if (!dso__kernel(dso) ||
+	    dso__is_bpf_prog(dso) ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
 	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5b4550e97172..4a3461d79593 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -791,6 +791,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
 			dso__data(dso)->file_size = event->ksymbol.len;
 			dso__set_loaded(dso);
+		} else if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF &&
+			   is_bpf_image(event->ksymbol.name)) {
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
+			dso__set_long_name(dso, "", false);
 		}
 
 		map__set_start(map, event->ksymbol.addr);
@@ -802,11 +806,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		dso__set_loaded(dso);
-
-		if (is_bpf_image(event->ksymbol.name)) {
-			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
-			dso__set_long_name(dso, "", false);
-		}
 	} else {
 		dso = dso__get(map__dso(map));
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d5319ffa88a7..5155c95df85d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -248,19 +248,9 @@ bool __map__is_extra_kernel_map(const struct map *map)
 
 bool __map__is_bpf_prog(const struct map *map)
 {
-	const char *name;
-	struct dso *dso = map__dso(map);
-
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return true;
+	const struct dso *dso = map__dso(map);
 
-	/*
-	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
-	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
-	 * guess the type based on name.
-	 */
-	name = dso__short_name(dso);
-	return name && (strstr(name, "bpf_prog_") == name);
+	return dso && dso__is_bpf_prog(dso);
 }
 
 bool __map__is_bpf_image(const struct map *map)
-- 
2.56.1.703.gf848ed807c-goog

