Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674921;
	b=OQ+pkokf1QZFY3/8lkLdIIO9nuyfKDAKKX4e5ovUawhHNW2CNjBeQ3aXbbzJOs1jlu/4
	 2PIg0/p0gGDaMd3WTFNqp5IyoA0Wo3gJwFmtvhUiZI08UeFwhkX2ydTmS2ZfOt9h540jX
	 0ygIA/LxXUCcIppqYkcM9LH34b3BdOsGD8MQEAKlg8n5fs1ya/SOsnzbrATyaeI/9mUJL
	 LEoprUIwH1MYwk3AeqcFALU/LDC1g1w02diHAwQvM5a6WdpaSvJkfMvQv7cgopJxI6jjd
	 0mvaOP1hl2YKv20Ibn7OZiucRJ6VnBHWj/Z16ANhK5VfaNVjz9VISATmgcdxObPXzGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=dosiBfQauFJU+WqcvxLeUWiXahPtDKDMOxRNRzp0hBw=;
	b=g37Q1weHLMu1SWW4NPHdF2YiB/nyXA+LkrScaV9PEOPe/MlTsSgwq0SxAMcsg80QjxrJ
	 7SFTd5h9WogI2qv1ljBkxgMAzreDTIp7CvG0QafvhVmLRygJcl1JezQTyUH1okSC/6GIm
	 Y65qmj9jYQHQ0y3I+tx1UxmbXUoQnyszczwsBsz4rn5X+cU99oT/JRUbsT09VnCFEsLsp
	 4ul/Bzoome1GvZ7RXYX0KuthgcAAtRVFJ7trXvjldA09lydKrQVHUt3f9L+dZDUBi7SHz
	 j3MtS+4VDm1YTPnpDfHw5fZdlzlfli2mAMDBGFmEs6OE3jl8QnIbfViOh+zeB3SAT1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOYl4ogd;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB13606A33B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB13606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOYl4ogd
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677af43eed4so2794924d50.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 19:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674920; x=1794279720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dosiBfQauFJU+WqcvxLeUWiXahPtDKDMOxRNRzp0hBw=;
        b=TOYl4ogdb19rrTANhULj+eFN1j5OWn/vev6rwdTNBzNkBSfH8SmL0aFxsrTDTjvKM5
         Ql5a14gxo2XfSne196JqzBJyTiOAUOlvPY6Jy3vG7jagqQWoWK4dhDF77N4cJE1TWmdt
         eQAEmWFjRzle3VIt+5an5Vgv2U9cTcMXnJ6epIOUBnLYrWNWZ0WNYs0listXU+3PbrIv
         Q91rbui3HqYJpn2WCbQVNIAyP9K7PWsGtSa4FwvLNiVUH7QaIO8BQ4KbcjKc7lqtkWAD
         MxXbiC5NRK9I+/W4tSciCrrhTchsjw4x6cp7V4/syYSI362SA8AnxHN6hNs8OXPfQh9D
         jUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674920; x=1794279720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dosiBfQauFJU+WqcvxLeUWiXahPtDKDMOxRNRzp0hBw=;
        b=0jvHUxCKlICKzleUKTVIoxEf9yWrPcuPWxZqeT9kE+JkDf/2asldUvlTNag2PUu0Kr
         0gcqV5t6ITzkJ6Le3FDqQLKFXAp3KpWqCCUXt9zIEdCGXVOv0xDp/v2PQuwDDL/Nf+ZZ
         o7XxIqW8Wi9KRWsS1IxRSAFQup8wp0EW4nHC8DS8ewxzwwKknQ37npZtqduj/GmrkRbv
         tpA2kp4qxAqcE95NlR02fmCOEUFXzl7R29EH2IrL/JThsJdL1A4Y9JVfldA5aQiRx4rT
         x93WR5EnoZiUuDrIiulJ09qXUZM9cy9Ygn79m+5T+2cjeoCChElmja2/iQhP6R96rSHZ
         3UXw==
X-Forwarded-Encrypted: i=1; AKwUvBz5Ic0mexOsIPwNBWhBkcUr268tTvinU41olgU+Dgep5xaeV32ck9nq5L/fotmmH6s9Jcdq1uMlPxA1Osd58hr6@vger.kernel.org
X-Gm-Message-State: APuU4Z80I2OZnS/XLPF9Bs06lOU0zrhwCUFAb9XhyUFZ4tFqiek4K+Rt
	G2knl30IGTfM0Sc1kTBjTXUjKXY0SPqD+9EUc8ouXIk3InBrGrlKqVaSCDTByL97
X-Gm-Gg: AYBFou39gy1xI0t+ZuK4sSkde+VJA4AHbt2XT7iMXadJzbLCVXCxNCGMzteR+ntOdtp
	I8UjVfAh4LFU7MdDXApSiwJhX8kj1lYdWwIXUesbH6dyyXyNiMe2dHv7+cL3Wy88lOos5t8Cdk9
	4r5vjxdkgoLM6YB+vG5JDbrrlHeObu/f4OHWMW24d+bPmxdVT1prbduOV/0n1iwUpGUohPLckGD
	ZSvi9jsQfQU9rHuiGFCCFNKg+N6a8gMwGFrQlblyAKj6UndH7JyxeVFpcN4qDov2bAeQoo+eoxc
	u0plt6su1FSxAyRpNK0Fj0UtuYhz9Y/UkAzI5XCJWJzycb7+TudxBHR51ecHt0pT6CqLvsY0Pxi
	H2oj8t3HEdxNWxWjQ/hJqlmY1ppSntAkIKYxdYUtmr8/AJ6ZnY2qNJXDbXbN7u5UlsIC+aiZHbV
	okHPcK5vTAAm/QHe/Z4GeL56uDHMLK2+TqAP6qaF73/N8wUbJLWT96t1FHlE79ducCus7g575g2
	8S8wIiuwzGF5gQCWaEzvuXkba7n9D5vt06jYqzrxrkJNAKJ8kIdYIzWMAyvJnQZNk5yYApfHGEs
	PWP00xs/j8qeCh4lDwVmPh4FgOgmgk1NrJ3Pm2NJeribUpOWb2+3A2hkMJoqkah9EFYmGuDIzxB
	VP+zgQZh9og==
X-Received: by 2002:a05:690e:4399:b0:679:cc49:55cb with SMTP id 956f58d0204a3-67ba50628f4mr7001226d50.99.1793674919694;
        Mon, 02 Nov 2026 19:01:59 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf26d91asm6227179d50.5.2026.11.02.19.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:01:59 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 02 Nov 2026 22:01:56 -0500
Subject: [PATCH v4 1/7] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
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
Message-Id: <20261102-alpha-profileme-v4-1-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=IGfq8dWu2iMEFoz3MC34tYu6sOJyy2DqaUpgqZ45fio=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe+i2WrHbee/vB7LPJ3dovXkyYGH9pM2v+5y8RCbOS6
 +78TMqx6fjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhr9ncwMqzbOam3NY
 QnSNto4YqX7Gv50+z9XT1+d77n2RbjUPy/JJqRod9QW0rOu3GC6uxDX1e81rd2bPrH/DwnbOpHc
 fmnLBtd2AE=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
logging options call takes a flag in bit 0 where 0 means "count all
processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
0.

Table E-18 of the Alpha Architecture Reference Manual gives bit 0 the
opposite sense, but the PALcode in the ES40 and ES47 firmware agrees
with the above: it sets I_CTL[SPCE], which enables counting for all
processes, unless bit 0 is set. Linux never sets the PME bit in the
PCB, so if 0 meant "selected processes only", nothing would be counted.

Add a name for that argument and pass it instead. No functional change.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/wrperfmon.h | 2 ++
 arch/alpha/kernel/perf_event.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/wrperfmon.h
index c97b82a1f7db..1fa9bc813263 100644
--- a/arch/alpha/include/asm/wrperfmon.h
+++ b/arch/alpha/include/asm/wrperfmon.h
@@ -23,6 +23,8 @@
 #define PERFMON_CMD_I_STAT 8
 #define PERFMON_CMD_PMPC 9
 
+/* PERFMON_CMD_LOGGING_OPTIONS arguments */
+#define PERFMON_CMD_LOGGING_ALL 0
 
 /* EV5/EV56/PCA56 Counters */
 #define EV5_PCTR_0 (1UL<<0)
diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index a3eaab094ece..2d9383425357 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -728,7 +728,7 @@ static void alpha_pmu_enable(struct pmu *pmu)
 		maybe_change_configuration(cpuc);
 
 		/* Start counting the desired events. */
-		wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, EV67_PCTR_MODE_AGGREGATE);
+		wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, PERFMON_CMD_LOGGING_ALL);
 		wrperfmon(PERFMON_CMD_DESIRED_EVENTS, cpuc->config);
 		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 	}

-- 
2.55.0

