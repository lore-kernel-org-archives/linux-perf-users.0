Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815113;
	b=UU+B1D0HWqw7c3QChwqYnhUylriBpZYZrmxID02FAW4UOkgndEcrTW2rNJ1zgHpnUVVq
	 gpwBGvwY6rWQYaM1SSNG63IRUgMYw3ZyecIEP8gYL9XrCEXLs0+nIjI/C6dh7Gq5yzyJa
	 9hT6vO/thtaoN+fEgoWX9K5dEm00m5eNSLqPjnOn4wh666y+SJPc9UvD9CyQCdbwiacZa
	 ogKB2Of3kzVWo2tkhHh9XTJpMB+EQmwIMoewRKIcZP0DQC/t8Qm+bG0GNdDWnFsy8iwTe
	 +G2el1Qp4HfVm3AEFo9z8B25NtBgvA+0mSQdq9Vbj5ak6rpRT9kkvUP3VH7uGteSyAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fi+3u17y7wvoAtVtKo+5P36PWlBbkMmWpTM+zRtf1CI=;
	b=fwDvpXJ0nkJftLPLSEnHa/aheucRRuCjWuy1O3GQZoeWubxCXYRMdAjNQbsqZ6Rg/zCu
	 yAeLv1kQNZQ3VpTwHTbtQEmpKlc4ybhmeUPE+rLMQzEfbMziLo92dGMWPKoEHXn2zifF1
	 zyinYSt/7H+WowuWySmmP1M9XvGJy6yIagWFQ3JNmYoI7XxDtMQas1ZSQsP/nxQ21uGfJ
	 oDMqC4j+9l4r8cZOZwQNC4FcjYQ7GRFAl3o8H0do6ZztYhzxlq98Vl48VGtbtYBFncymm
	 OAU8/DqkiyUjS+WjCgCvJiN14Gm8PfrgaB8ftMnBzEqJbOwD5EV8TOCGM/NVhr7bK0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L8gvW0Ia;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BD606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E41BD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L8gvW0Ia
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36efb506f29so2359383eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815111; x=1795419911; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fi+3u17y7wvoAtVtKo+5P36PWlBbkMmWpTM+zRtf1CI=;
        b=L8gvW0Iadb94iA+kpPaV1ebIqatTEoVLO/aSaAvQihWHzsFQbgZVUbs68KH2FCvL2J
         mvztilRzHT6GgNAwMRWm8I6AnwhwRRU5/N70QXVIKmYGBYFEpWECMBh6fAz79nTIamv8
         xPA7es+6x5frYqRdMc0mrsQ/81jyurduyHj64zPBdUyk4uS4ygQLLkBtlF38vX+WtMR6
         ojfjuSzAVLA54i92t8oXTKdkLI3rDaVbgE6KGGZWCPLuPP/d5Cp6Yj+6xytnFPor1IaJ
         b0LouXpX9wzyk5XFDlXeebDUcE0OCa1t436du7eF9UTffN6s24G2rIZXGKPEqHD90nEn
         B77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815111; x=1795419911;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fi+3u17y7wvoAtVtKo+5P36PWlBbkMmWpTM+zRtf1CI=;
        b=oMj5l836Stm2h952bP8rkNUmma28AYqozgTkbtb1w8g4KDDX/CO1ztPvy86SoklnWe
         0H5mh1HbBD2BF/JrpG09wCiWoXiGkzIFXTh3gXzj2h0Rsv6IP3wFIMC7O8YI5ToC4Bee
         4F8CF+8QuPMwSU5fqyyRsnD7SIjGGw8X5YuJo9nBgkiqSgijuBmHa4oS1M1i/spSDZ8c
         RosSdOwSRUgvVGV8JxpTBglwdbikNB0cX7EDKDbkmyEdZi0/LsYZ1IpopTr3WI63MRLR
         mHDmcK1gWx8V1TXne5+sretrWqa3sGUYwA5uHIhr62k1d0JPIrX0MPe9/AVxWF59ZprQ
         CNVw==
X-Forwarded-Encrypted: i=1; AL+hErGd4MUVJKRwlBNLVOpf+Zf7lpqVughwYuVLiR6P9IHFmVvduucZBKJeCRHxljmjck75lZPlIz4qEcH+WfspX+F8@vger.kernel.org
X-Gm-Message-State: APuU4Z9RSDv+fzDWMv52JZZJADGRHiLoj7asGgrG52zgg96BzoLPMbp7
	mjQexZxRgepiZS6PGGFd0LF0CZ73qiaGN5wwEjU/mr1fepz1OnKNZ+eizQEgdqWYviD3MfUKrdX
	VFhbSn/nNBw==
X-Received: from dybrp12.prod.google.com ([2002:a05:7301:460c:b0:355:e5a8:715f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cc9e:b0:372:2ed7:8f89
 with SMTP id 5a478bee46e88-3796702a36amr9735755eec.34.1794815111073; Sun, 15
 Nov 2026 23:45:11 -0800 (PST)
Date: Sun, 15 Nov 2026 23:43:57 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-3-irogers@google.com>
Subject: [PATCH v3 02/19] perf/uapi: Factor perf_build_id out into its own
 top-level struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document struct perf_build_id as a top-level structure in the perf_event
UAPI comment and add it to the PERF_RECORD_MMAP2 union comment so future
sample types can reference struct perf_build_id directly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c49fc76292f7..deb7c42d109b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1099,6 +1099,18 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_SAMPLE			= 9,
 
+	/*
+	 * Build IDs may be present in a number of events. They have a
+	 * consistent encoding of:
+	 *
+	 * struct perf_build_id {
+	 *	u8		size;
+	 *	u8		__reserved_1;
+	 *	u16		__reserved_2;
+	 *	u8		data[20];
+	 * };
+	 */
+
 	/*
 	 * The MMAP2 records are an augmented version of MMAP, they add
 	 * maj, min, ino numbers to be used to uniquely identify each mapping
@@ -1123,6 +1135,7 @@ enum perf_event_type {
 	 *			u16		__reserved_2;
 	 *			u8		build_id[20];
 	 *		};
+	 *		struct perf_build_id	bid;
 	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
-- 
2.56.1.703.gf848ed807c-goog

