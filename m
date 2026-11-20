Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197532;
	b=Mde1LDmdVgB6mLx7HHMb257EmhRh4YmjBjnXh23qNSY9U5mUwrnO50u+5wjK40ITfpol
	 exX4QOuWmTC41O47W1NfjSirvSj8QGRovaLsjuPa2OoIic1i2WwUlswn1h6rTVg0kIGAA
	 ANXF90QEAsGHB4E+2xihbpHa1N3NPlP/QpqRBVfFq7XoTQRroRkZJNERGnZDxXjj1BsvN
	 nECDp+FJ73bkLCmsSmu3UiovYzq0ZycGmMj7DXGJWbl5MytjfIkBD3Ip6u1lseCfdrlGm
	 I07RLXXHp+yy6Lfue95tx2RXxZVVO5XAEDkna1MHmZHXQbBlqvl4Kk0X3VrmiG4irpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7nDRG9zrad8XZYWJ2RuZhWhptkwYw+WrRQqA28jZw/k=;
	b=ED5R3XlJgjcVMcWQfmnsOdSIGHjJgphLBxZC0YyGclFg4hHk/g3eMrEgn6kGDkE+1qIF
	 goJVVMm4hGHicqtUB8eROaCnC/EI/LMwIoan7qIfyERsx4StiWdzJ8006MS4NH0DhyAhy
	 Sz1Xqu71BdnZel4XNN0Tpqedcy/EVdTBiU1V5/P5ktRHVrXtgwqP8sqOmfnJCVptdSKg8
	 yX54I9HtVByadb+cTr81n5gxhfK5UWJu2WQ4/IgXrxUWHf26T3sF1+N2CW2rQHzY6PJU/
	 RcotOMyyyX67CMUc5sKKoae7H1JMd+Qi8vD0a9L7PdhMpPWjnsIlPlKKpcIQMBNGfsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDjDauzO;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57F60A261D
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 17:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B57F60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDjDauzO
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14394530ec6so1852759c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197531; x=1795802331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7nDRG9zrad8XZYWJ2RuZhWhptkwYw+WrRQqA28jZw/k=;
        b=uDjDauzO+yHPOyuhPIgIu4Vcr9VVJ2nIRKVnXWsaY9sfg5H8TdEVaDvbbblBMl/Zq8
         6nvKrf9RcDf1QOYEbsNUXI5ErWFO2RwWulx3OATD1nvKMgoSKqBN+f9wyjhNiDi4SqGi
         X1U7rqovWvdWuUTztQdoXVMy99Fga2+gegb9H+joOirHQwazISwiOCv7lFrnFsH7wNOv
         kBli1uX2dux2yjS3ZqtLqvYrVnoQtxWwXrS8qWjCr8kquCzCgviidUL+C+Zn447B1NWt
         RfNZFU+JLuE18vrJyt/EjboNzecmx9cNJ+AU1cseCTDIwFgt8ySqqjr4gR/84RJGbxqo
         GVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197531; x=1795802331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7nDRG9zrad8XZYWJ2RuZhWhptkwYw+WrRQqA28jZw/k=;
        b=X8xxirwqdh9UFplSwGQz741WD56rUa/GeiZkbrk4UGgUq7gGTEGuD3+RQGDQUL3Iv8
         O2WkLRzLRxCueRgmExzXtXDLucJV8geYueqeRuPg9mCbwrgtz6oOB1JunjxrnVnB3xFW
         Bi2Fc8PGKK8/cDnOqgzKNrprHYhJiS0UTZ0ElfgT5yDZVcyDKPl+GJpsCVpbbXB0+1AO
         b37dydwK0sdtykXsiJMTrm7MCMNN1Om7VqKHs/5haTpbcbKI+JbS1f6L7g5yQJt9XnGF
         HIRNJmMTI/9zD3aI92FH0YlOMoojubEo7uximgPTigf/gmwjnoMENBmzcWKrB5Z75Qpe
         Ajmg==
X-Gm-Message-State: APuU4Z8/QhGmyZzzOaT6fn8i5WfEGHH5ekjE8L4t8Hvn7ceAV6dWPY+y
	x0/DwEY1uxZevhGVBaoVveWhCWmDmFSV2Fj8gc6YP4PFP/XYs6Ddg07PSDcz52of
X-Gm-Gg: AYBFou3XI7/iOwvG6ALWArVX4t2MJwdTS5fZyjr9Shczr8i2E00u/ylwu9416pTYjMT
	iL7dlnMbmOR1DeKkNn86w/yFLZoNFmaVZ+ciU2frDvcYKVzIeEKxhe4ZFHfAeNttCNJCQ7M09dX
	sGtGk8Qc4OyMrKn1E0d7qQ8dKNbGmamm0OChntDT/wzqpzSO1EdLM78R7i7AbfxbeqFAG0xCVBm
	3QBXk8hSPpsY7ZOT1xPeQHO79UYKU3RR1pdQbXcQyxzPrAxPC0IS5SiRIL1eWADK2H7zTXq1Mb0
	VA+CPtoUrsFDv5VvaxCPalDlzTgPxWOXC703ShOy9mUOi+02aVM1yearkRKZF7bfVHeJeckXBEm
	gZ9x+0wXQaYdy/vC5r9Vlf3HY6L3DWa0AqOgxqbdf3VphTTAtnfFxzLRhVhJQBGfePBCxX8y1nk
	V1vgCYdvQvsqjtjbHmoStel4e1mzNSzerMvYagsbFpyxiTHvjI2btirtxLXm9b6I/92wg0RiRte
	9iWVK8zlQcpCJavHJE//9qae/KEqGjp//BYXJb5Bvx7T5LW+o8xis0X7T/dKFO9IlkECsG9Xdrw
	dRYo8R0WjhEOMcX8o9WM
X-Received: by 2002:a05:7022:c84:b0:15d:fb47:4268 with SMTP id a92af1059eb24-1b5568c9b56mr3220926c88.21.1795197531216;
        Fri, 20 Nov 2026 09:58:51 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm681084c88.5.2026.11.20.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:58:50 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 3/3] perf vendor events amd: Fix a misspelling in the amdzen3 table
Date: Fri, 20 Nov 2026 17:58:40 +0000
Message-ID: <20261120175840.1274637-4-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120175840.1274637-1-takano32@gmail.com>
References: <20261120175840.1274637-1-takano32@gmail.com>
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

One word is misspelled in the amdzen3 branch table: "Instrcution" instead
of "Instruction" in the BriefDescription of bp_l1_tlb_fetch_hit.if4k, so
`perf list` prints the misspelling as it is.

Only the description changes.  Regenerating the tables with

  jevents.py x86 all tools/perf/pmu-events/arch out.c out-str.c

leaves the generated table and the string table identical except for that
one word: every event name and event code is untouched, and the string
table does not change size.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/arch/x86/amdzen3/branch.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/branch.json b/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
index 018a7fe94fb9..a3b53845ca19 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
@@ -42,7 +42,7 @@
   {
     "EventName": "bp_l1_tlb_fetch_hit.if4k",
     "EventCode": "0x94",
-    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. L1 Instrcution TLB hit (4K or 16K page size).",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. L1 Instruction TLB hit (4K or 16K page size).",
     "UMask": "0x01"
   },
   {
-- 
2.53.0

