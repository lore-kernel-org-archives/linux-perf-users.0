Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333046;
	b=qJX19mHunqADKkxUfQrZLaurAzTHt+lcw6SEehg6d5gI+ehzeZd8tFvBMP2jG8fyTEBf
	 k7O+N8JDzfqwDA8WN/z5Ofv1txR9+khfquZwLWC+jePDYmSTvXvMfAh+I1hVBqKBaGtFm
	 OVFduFUjXIy1Ap/buGKuVFTSDnCJ88b6DYEgLu/0QtuYyiaWqW2YgacjUpYxkNF7gcmU7
	 NFQL0zoDyNtPEYJvpgWhiaucvwg3rrxS6YX/fth+nwUPS74RzJY/t1uPc6LWFMfyLFT0L
	 XrtYFokOjiwwB+6MBwP5tgVJLcsxdZExfHHU7s2IIkMg5q8qitNQQtE0mrSAcOEM9ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8JGmzBUB1ieFXJKy/CxNfd2X1JHTYzvohjQ9M74SDtI=;
	b=Ketf++rFiTaQDHurXaAjGCUfZc683zf6Q0WSy9+RZyBAZgZ1lIEYNyAdqpGoj1DaF8Eu
	 nI2mo5ThzNNgW+nOj3c+AzoydVcd1zaZbzRcSRD4LqC0BYuF2TtF2M+fhxURHtdZgtWwo
	 oj5p5L7ritupuUJ9BwyP5tPk+Bs71IuxmYtWmbn5vPz1PE2Ayy1ck/TI87QLIS+NKAwZc
	 rOC3p8ukfbWxZ3wSlsO6aIGqj5JTM1vej1im0wQTtX2MyIHQx7iQz+9E9kW6mEqW1yLrz
	 w3lgdUjBlQyE8RjewZxcMLplhbUhl5dlvQ1vBphHlJTwLCGcuqNuUVkvIU/7/K8ScWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oUeX8hNE;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B6D606A329
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B6D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oUeX8hNE
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0d91601bdso11921057b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333044; x=1793937844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8JGmzBUB1ieFXJKy/CxNfd2X1JHTYzvohjQ9M74SDtI=;
        b=oUeX8hNEFlszWHqeZFFJ07oNfpJ8o+iaQfi8sU5+RQ0eAVwcOeOy4Gn9pTeIbsuX6/
         8+46kGCOC23qKX3jgEKWVKH7BOFmHPuHT79Qqo7bDNBZvghVUOxf5kYXmAfWqTHtSWvg
         FcwHJjepkeXrgJiEMg95a/uweLdSZOO4oKsgrRRNY55FznKp6idfwEnLUUQZim9ib+aD
         RsyoQ27/NqCTkSuCgBuVzgPW1y42OI2RUeaN9qWvQ8kbHlthJ7Bg+iS247pQAylxp2NL
         ea3Kf8hCkw8sXqW08207zW3g5CbKp3mD+ofzrbnBv3oyF+L9V820N62lTbA8goV/OLfH
         u23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333044; x=1793937844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8JGmzBUB1ieFXJKy/CxNfd2X1JHTYzvohjQ9M74SDtI=;
        b=GaZUKB+3xUD8Bm+Vn7x+i88/IydDqqkMylhQsDxX0BALmSklUTiSFg0u9fHUdhhi+F
         4/Hu1RiCm8+DSH6vEJr2nlLCLWZqyXwwPgD5SFR7kRvakRAJpQbj1G4LhLG7VpSt6wi5
         PYlGIeMsF6hLyzJHkbkdTAOJ2QeNK9TPufX/mSN4SnF8c9t6Q8Ix1rFQdw00VDML1xjL
         eMLG41PZhti7kKK5HsekMiRnCKkdl36Ra20xNdWS97lA3sZHdotF7wkPFS93NX1v70fe
         JpjGX+qpEyZ0f/Y50zjlAyfnjYgnq5z9BPiO1Rqd5xAPPwiXYRrZ85V3HstVcy8yTa04
         0wAg==
X-Forwarded-Encrypted: i=1; AKwUvByxq918Q0btKjtDJV4jt+dS/bSL64vcgs7bmm8cSYAIWg6biMUioL6uAZr8vuAuzwbByT2dvK/wIBWHVtjqHZ4d@vger.kernel.org
X-Gm-Message-State: AFq9FYIdg8r1JFI0BsJDFDzQU2oClwTHiHELjpT9h+FwSwFakTw8FoEa
	tCPnOwIuJiwocJdeyDg7yc02HmVy20/drT6i9aG/9YavSKsPWy7iQGXS
X-Gm-Gg: AYBFou2+NPAbeSkgEEPxwTvlaEtsziw1PgGoL8gYLVThRxb6DjXXsfNQMKQ0tNRPwED
	uoPqmXpALxHLqBmHA7XirucB/qWLwnGjzWfmJevlKwq38jeZr25bDptx9omItxPylxh+EZsWM1m
	O/UqFsPc+ORVLFkNxsArlDG0lG7vyBQLviykpYjJgS8iljbJYOLg/0oF4pfYxikViILDqNOhLag
	E7hDIbAxjqSiklM+cFkguW29DlalFwJ0Vk3YTHvB6co2hI4tExEn4+5AL5EKDEPl/B2Kit6KKtX
	Q63tb5bnSdJcmTRompSKkYVUnQxLkiCkoXZnFyWAr7XIylA71MB/gTApBTaIszdWf7hJSw73+83
	Z60Dd2ZnHompl9clBzCv5tPho9UE6pgiDxM+qaDwU68jfLdgb3u4oWGawmpRzaEfoIHp0saXrmZ
	d+R98HzPfrC7XwPAjFSqmapvHYFPynKcW/UO2CwGlg91IVBiMOowJ2F6ouTJrqeIFDg25eDOAeC
	zIJ7y7DyVEX2xrpQgKVio09RZ23YjrcrjdsgPxtlXp5uxZqtKyqPJ+TrMo6LnitUMK8dKz2hBGo
	0hY6BWzhkWwGVlq73sHK+9G3Wqx3/i+AOS/xmR267uLxxYXou1LhIt83mEuDet3Qe1fyYT+CqIl
	ZVe0SxzQ5SQ==
X-Received: by 2002:a05:690e:dc8:b0:678:fa71:2ff0 with SMTP id 956f58d0204a3-67a8d4d24b6mr3128247d50.38.1793333044059;
        Thu, 29 Oct 2026 21:04:04 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba756be52sm296744d50.21.2026.10.29.21.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:04:03 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 00:03:59 -0400
Subject: [PATCH v2 1/5] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
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
Message-Id: <20261030-alpha-profileme-v2-1-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
In-Reply-To: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=449u5jI6TVHJ3jSiAT+AZJsNh6aRV24147OMwgzJp9U=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeiOtvbdtflBS3ydQ66N+y5L7E2Lz09y/lxdr8D91O0
 3HfceZcx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFwzZzkjw+kKhbTSmw
 s2uuW036rgui17X6V415rb7uen3Dm62P4AYyzD/6R+4TXpou+WF3Tu056/5urh51tussxIfjGnq
 1fV5YDoUi4A
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

