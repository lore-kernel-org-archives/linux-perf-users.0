Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380053;
	b=oz54QOI2IENF8hnh/Ai3LxeSTAldK4yyKsPtnHmRacelb74pvOtGZrbduo30o8uAl2sb
	 o/AGh+MNDAdP0GLbeXAuBSSQu4g6VV6112KmueXSrDd1io5Mu9eQ8tOb/fheuoGHNjPM3
	 S+LyRrpS1V3Tf1ftKsz7/QStY+9VoZo+6RaatMF8ylJz8rN6cGi7FaajlxctHcbDf9COV
	 OnUaWsd1QD4kqM+5DGwCMVWCyzjuS2+mYcEjLABkYj3/WC6kHwmlyf1o5NBX6rkqiDMZR
	 R/SFKjELPvW3mztMogvY1chbXxhZtbFZqElsYoDzcDE02w8P1DFyKlX7H1l9JRJa2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YpkwVa0e5p/3HxWr1XgWTgZwvj+qnPlEkzILctELff4=;
	b=M6YYhD6UI7Kjbe/LjIoM04ACSF3kuzivGcYlxXxUgSV+fXB37l0Kt8Og5Szzr5xsf2Ir
	 Kp6OMtGz6fccpkGQ2JXJu+e6sdaF9GXalF19H37il7En25p1XjQgAlDdeKhpk2eb+AFlL
	 YkXCDTYp2I/Lc069fRxFFZVY9CFdEzMuYzfpby7Aa+QX74atFxQ423PMBpcUj9Epmv9bk
	 XUCTK9Rk9K95OJ2N0PUbA5PY6dNOizO4D4LE35314Xvr9EzP8jdd+MoxD2CHf0V11upT9
	 zMuiILWyJiRqj07B0ySnofEzEXxEp7kIMjaqvAbKCCuZTsS5v0zHSdUUjrP4Ia8QEEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FwJd/tP4";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AA606A32E
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 06:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69AA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwJd/tP4
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37000e7234bso657122eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380052; x=1794984852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YpkwVa0e5p/3HxWr1XgWTgZwvj+qnPlEkzILctELff4=;
        b=FwJd/tP4RrafDENe0B717GJUY9vAgtkGGu8Bd+k5XNzYY2RVCU9JqWlqclrbOElg/X
         lI5/anXjEr2CKTJXixAkW3SgQm5vKbq8WaLEcDLEhG5cAB27Y3HW6uDa/BMDlwtac8Gu
         ScimaUZLfi4upcrx10w2YsPvAux3KgpuVzM00khjnqG33j9ofmhCWD9D6jncaufHgiR5
         Ff5dlC5ag9ugx+HfEbOTZRTTUK5w9idX9TS0kJGhYIpaDsJ1dNG0vjy0KNi2X49tJtDB
         mAkqne8U9m+AMgimImEM7sZmF3GRqMBe0Mi19OVQMPg8MnOJY76PxChD+Emq1wadmkLO
         XKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380052; x=1794984852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YpkwVa0e5p/3HxWr1XgWTgZwvj+qnPlEkzILctELff4=;
        b=xwmhxBQfmlIg/u7c44pQ+ccH3h54tw3qNb4rdyJ6RjwcH2eAb5MQKWsJhl2zQCw5Jh
         vZOsCNj7b0UwDOSoFq2pUEjN/6KfVxmJz/Dtto6iDh5o4G76A/PNpIcqmk5MIS55W2Pz
         pX4oqPdZjuIBqY2P9z4Bqgqcg7UnhE2vOBV7ljv19hleECD0XdwtLPSsGL2zLs5j1TB9
         Adr14Xpt+R+w10UjUWHsVw1UJClgoNBuUMSB3QFAV6J9hnxu6UeGnxyYkOrkAdHt4wVv
         Yt0HQtkS+XQ4pJteQREpmhTeJgPnMZ080qdR3On/NDkTUpDwQATDOFUcQi2BHbSyQIgQ
         yTUw==
X-Forwarded-Encrypted: i=1; AL+hErGTfZDnylhnGiBQRd1frcb6Rnpbi1GUpULHtuzKSr11sH5MIssLfmikoFEipTt17TxlPfgDGFskIWarrfnTXUKZ@vger.kernel.org
X-Gm-Message-State: APuU4Z/cCt0YvjcxJSRqclL10hvKeLTBpouDfCVl1wNHx/wTUNGAm8Ir
	OzrfHEr/2DIQ8FNrVdGQ2XrWJAmkEImw2TXdfSDqyg9LZCgcPoORwAKoBeIm/Q6W
X-Gm-Gg: AYBFou2pUtESIPojzLYV2lB8EVypDcTx9KdXMq3+O617CY6GMS9laNmEkxBgYOR1V3n
	5fyOo+4G+fw28FMpjZup7A37hrwS55F0C1w065C/s3AP2wzBbReMWZYodZN0IM0xGy14EQwJa62
	A1LAXJ2LRfLIh/W0pIJ5WTugVddN/cpaghxtwflGUSLt74e4/v4VxN0vuzZ+qqbuoBAQxHoBPgL
	aYVOTDcpFjpKK6oddiY4ANYbgV1cOjG0TwZ/2HUqIn2IVWglSrbAzcUeZpjWnnNq2e+EUneWjLw
	8/bGU6gT0kjIPJbG7GwcIE+QB62gKkEurDJPuJ+zwqeOqaAVnNR6OJ/fRvN9R3RjhfIuePu9BE6
	jPkQsOTgWguW8uX7Cq5KXFU4TrFvVzc4g0KE0sMNeDqD/mNQxMoHvEpVKDjIgBG0Vsci5ofN0b/
	vPquJtv9P1VgqJto/p2BrgZR+LCFJt6rE1pD/oPZxdSVy9gzOAuWxiHJAFvl4+jObFkmH7fe+L+
	KPK7b5XnX8XH+YSiOHVqcAeyQvqTcDq5U+IT8fl5cTjqiwHGTeP452GKCW9wGcwO/xfJS93K0T6
	LSQ8NVoJCjTIvrO+7Go/qdxitCQrXD+8S8LYf/WnRHlGrqg3b4I1Y0ydIg3SevvGvo0T8rlLK7A
	gBtD06WUN
X-Received: by 2002:a05:7022:170a:b0:1b3:b3de:9232 with SMTP id a92af1059eb24-1b3c02f06bdmr1500507c88.9.1794380051342;
        Tue, 10 Nov 2026 22:54:11 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm11879272eec.3.2026.11.10.22.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:54:10 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd: Avoid double-decrementing n_pair on failed transactions
Date: Wed, 11 Nov 2026 14:54:03 +0800
Message-ID: <20261111065404.3428684-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109111909.31712-1-zhaogongyi@bytedance.com>
References: <20261109111909.31712-1-zhaogongyi@bytedance.com>
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

On Mon,  9 Nov 2026 19:19:09 +0800, Zhao Gongyi wrote:
> On a failed PERF_PMU_TXN_ADD commit, x86_schedule_events() releases
> constraints for newly added pair events. The AMD put callback decrements
> n_pair, and x86_pmu_cancel_txn() then subtracts n_txn_pair for the same
> events.

Reproduced in a KVM guest on a Zen 3 host (Ryzen 7 PRO 5850U), kernel
7.3-rc6, with a trace_printk() in x86_schedule_events() and
x86_pmu_cancel_txn().  With four pinned cycles events on CPU 0, each
failed attempt to add a pinned '{fp_ret_sse_avx_ops.all,cycles}' group
leaves n_pair one lower: -1, -2, -3, so gpmax goes 5, 6, 7 on 6
counters.  With this patch n_pair is back to 0 after each attempt and
gpmax stays 5.

Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>

To reproduce:

  perf stat -C 0 -e '{cycles,cycles,cycles,cycles}:D' -- sleep 4 &
  # three times:
  perf stat -C 0 -e '{fp_ret_sse_avx_ops.all,cycles}:D' -- taskset -c 0 <workload>

(Analysis and testing done with an AI assistant; I reproduced the
n_pair drift.)
