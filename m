Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939449;
	b=xlg4G6d4ANTaUPGb4M5agFhZc5//ufbGNQLWqfCto0ItJapUs+E4cB1e4UZvBAy7jeX0
	 4gDBhKl69tYLYw4bsxv/fYEOTHgWnTLa0zWv52S8oddp7Vs4ot8xzU0CExr8haBAsibhq
	 EqJfriTHDKBaF602W/gzQnXMRq8QKqPUih9xATeXSSagaQu1k7sw+/PeUYU44iTZwYXHT
	 D9kUeG94MKRuouZ2spki/F4GbVK6QdH/gHGtquNRfYafrYJeKG8mPf7DN6fqZj5/kyT0m
	 hlsygjsRhtB3HeKKbbCI6aj+R4gm/CSj2HTgYoaa2iQwYgFvVUSb88vNRYJ8d6V1llQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zCfYxQAheTWR5Y9HsIisj2LG7OC+BVkrgHxX7TuYPA0=;
	b=HXRPwEtoA95oncEHjWtpBgP1g/Y4SYoZFnk6DIDNfDV0k35pNVJTxh/sRsJzxBCQWuxZ
	 RslPkwTcDWd4vh2+6c9uW/ZhsnmrQsfbT/jvZuLpVUz9Z0Hj8LY0RK+t0Tp4mB3dXKv53
	 FHQtNKrXYi5o8HlgoJPBDsWRivWrPhbrAB9gYSCVqrU4o+iGta1b2QV2kt4fL18kqRheL
	 PrMAoolLkFfpQipTSZn0cSwsPBqCJCOanKm0AOWwuk5p5YgGjp4qOwaejUTCfoUDGHzlP
	 BWqGpDCu2udMlprY6B3VB+p0ZH5kXwbUZYwEXSLeMhN+mdEeU1q3HXRRb7M9g3gXH3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcDsm+VA;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5D606A33B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE5D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcDsm+VA
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b2d14968c9so1485257b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939448; x=1794544248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCfYxQAheTWR5Y9HsIisj2LG7OC+BVkrgHxX7TuYPA0=;
        b=vcDsm+VAacda4WMMIBvGmabG64SoZalKQ1ot9HyFp/FRSjTijhu1U6U+0GuDnL7Rjz
         qmEeCzdKWs+zmOir4jCtzPQOTFabNUFTSfv2GlROSW5Z1ARynIJopsd0PzLOjPA7CGlK
         dptD3Gu+dOVpMaouYydiptvIJjgeub+yw1cXbvbDGW85iL0v0ci7/2h8os84JR7pLInO
         CDuv/bkH7s4aXz6LRzPonmj3ca3EHygtadh3V7DH+9tcy96QUqEj5opFFkf/KdMFZPz9
         BHGkF87gg1QWsUUhAwvzDUXxGbN9QUzKbDKkafm9IULopk2Oey3Db/7sU0bgzizf1PTo
         p36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939448; x=1794544248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCfYxQAheTWR5Y9HsIisj2LG7OC+BVkrgHxX7TuYPA0=;
        b=tu3kykPYV3Kq9cBEPxXSh/1G6rbMWpBjN73qSKqV3u5+ZdfKW8dPd01QL7VUy/97LL
         pHHzF82xNczhY82Ga8td8J/1lg56LwA2WMjV4uCoJEJyXJDHurcCpp1toGF6v1d78ZO2
         Dnk0dqA9GLGxKJr/VzPs8L7aqpOb/zKICAJ4MOln8iN1FjhVwkkYfTE+YzkxEP4OprNe
         YNatqZTDQFDU8NKUo4SaNBpGBhLEcV7p8ZWdNbdDg12Dbr2kxRplCyAhflJP0CBnDuaT
         AykmMgYlyHi3WN0qAlm6quq3pPXiQznYjbJ+mAt9sl9wU67WhmZrXFkc9lAFj6BfYw9H
         kPkw==
X-Forwarded-Encrypted: i=1; AL+hErH2uCroFt6lcRI3+N+tOpvMYyHj1M8dY3+c7RW/zgVqy7iAKt71Wj3Bk8lF/mvJmW6/9BF5Qu7bryYuqIa2130o@vger.kernel.org
X-Gm-Message-State: APuU4Z9+YeHwjEamESs9jQa3OyYx1Vx/dgj/M1YPAC4U3bvUHHtQcQUc
	/URV7WQ7g2eI9qjt1NlH80ghkmvPKTf0I0BtUSLnpSAKKpAQdyku313h
X-Gm-Gg: AYBFou0C+DhsGyZ+jz4roqU9CEQfIAsgdFGXegsMFQ7YkuZdam9mh4LSZfkw0kNsk7n
	Or105cdx9IYnMXcM5bfKoT/LednrAXe/6VegJvfbUcZXZUqOo1lEliPRlT9UiJoww0tlyVK7XDE
	zAMCyLzBx7bOCjKpJEIesYNHcIj/Jvy3lCH/QDDnDiYYEGkH3AxPja3gcHJ2y+MeqbYYlIzuo+f
	iOKp8+pBwcvVky7wGNsPSy5pqwKGUR8HciOUhjNpqSU0ZonxBymPZZawRnNdknhB0zCRAMKKHho
	a/l0CDxIVK/+iKIBnJnKgb0VrpbtEug1DjNOr/7OknpazOUYlj8VizmjPuAwLepru4rBnQwu3u+
	IICvCbNagHnSk1twmw5uI6CGug24n/Hj+0myDgJ5IIyHnvwdde+Sb/CVc2stM238yQYlY1zexI1
	QCj3DFmXqmr7Fs9eiHd5A/mNdDn7NvDwg/6qQOKdZ8ZI7R2T6WNMlrKUO+iPQP6azreHbzawW9e
	sFe0kXCCnPlPEYvqHxwKE5Zsf/P6amHm7Jq2VEFuUM1AZNkoQ4FDtHe3xfoU8oeU9pxLYrgjnUS
	KM6q6QbytOKPPghcLTYyKukz9Z7Lr1mIck4xA4+zSgpt6Nf/svX+GkEyQWboEkKKlAuoG+02oDG
	91Tp6L0+3KF/QLzL0uRUxiWW6ZdWaM2w=
X-Received: by 2002:a53:de46:0:b0:679:a420:a07e with SMTP id 956f58d0204a3-67c145bfd86mr457741d50.112.1793939448142;
        Thu, 05 Nov 2026 20:30:48 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c13540451sm1159685d50.10.2026.11.05.20.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:47 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:29 -0500
Subject: [PATCH v7 10/14] alpha/perf: report the ProfileMe window count as
 the sample weight
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-alpha-profileme-v7-10-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=6ziHAOsxKu6KcQK97NLAB0loeeqz38ewKY3TZVSjLAE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht+1VttirDrTe62vdW50ku4qlbqOV3tcS4+dZ7ujk
 LpkJvPcjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnGqorhD8+LpYViUg
 92Lt6i+Pi09ak/D9M7lULzfD31pxi2PBJ868PwV6TyWaPkovTfptlyNfLJ305F3e/88IDjviC7R
 ab35ChefgA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

What PCTR1 counted during the ProfileMe window, the inum retire delay for
cycles:p or the window length for instructions:p, is only available in
the PERF_SAMPLE_RAW data.

Report it in var1_dw of the sample weight, which the weight and
local_weight sort keys read. It is 20 bits, so it fits. As Alpha is
little-endian, this is also the right value for plain PERF_SAMPLE_WEIGHT,
which is what perf record -W asks for. Samples that fall back to the
interrupted PC get no weight, as it belongs to a different instruction.

Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index b5f7112e822e..529186ea8873 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -1079,7 +1079,7 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 	struct perf_raw_record raw;
 	struct perf_sample_data data;
 	struct pt_regs *pm_regs;
-	bool pc_only = false;
+	bool pc_only = false, exact = true;
 	unsigned long pctr_ctl, i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
 
 	pctr_ctl = wrperfmon(PERFMON_CMD_READ, 0);
@@ -1126,6 +1126,7 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 	pc = pmpc & EV67_PMPC_PC_MASK;
 	if (pmpc & EV67_PMPC_PAL) {
 		pc = regs->pc;
+		exact = false;
 	} else if (pc < TASK_SIZE && !user_mode(regs)) {
 		if (is_user_task(current)) {
 			pc_only = true;
@@ -1134,6 +1135,7 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 			pm_regs->ps = ALPHA_PS_USER;
 		} else {
 			pc = regs->pc;
+			exact = false;
 		}
 	} else if (pc >= TASK_SIZE && user_mode(regs)) {
 		pm_regs = this_cpu_ptr(&alpha_profileme_regs);
@@ -1167,6 +1169,15 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 	};
 	perf_sample_save_raw_data(&data, event, &raw);
 
+	/* The count belongs to the profiled instruction, not the interrupted PC. */
+	if (exact && (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE)) {
+		/* perf_sample_data_init() does not clear it. */
+		data.weight.full = 0;
+		data.weight.var1_dw = (pctr_ctl >> EV67_PCTR_1_COUNT_SHIFT) &
+				      EV67_PCTR_1_COUNT_MASK;
+		data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
+
 	if (!alpha_perf_event_set_period(event, hwc, 0))
 		return;
 

-- 
2.55.0

