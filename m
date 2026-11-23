Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410437;
	b=LYKadTDT1Xv79nGHC2NDVppf5GElK6NgkUhCBxPcOl3dqWPeLdEWANFoFK4hBp2WpWu1
	 o4OXCnRLGgHE8K++Fr3VoMRfgvlkd9/jezOoqQcNSnMxAml/l/zR4arkCO6d5Prz7Kc/s
	 XeVlmi103V/0F5gPYzRDL3KFm9jf60UpDVxiexilQisme+HTGbUAVZtiqRNNxc0mHX3jg
	 18/emkU/gwzMzM/h81CIJKzxB9IJx9SFtc/7mXfgbHp4x1DPQ1fmz28h1sGXTl3rHpssL
	 6WVGG3NqMvjYfSDsHa6JEiM/lyrNGC6YBy2K6sqDd7UT70HuZrf5owxbFOICvg89ClA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DvvWMG387UA/sN7rd1/UF8ygYenjSP4bEmKVrnnLJjE=;
	b=xCx798FDpHOafJERsx9/zmDE/CFLH1O+3LPXRg2yONkIcs53eG+ibpkDiL0EPK21v4C/
	 fRUDPGs46JUKU2SigNOlZIpnGCXq8QN/yw4jUf0g2jsvZU0+QG3X6QYiJl+8BOgiMb6Zx
	 Vj5yZZhNTolB8/EElnlOZFi7eIwSnUfNSVQ7tDTkNa1VQPTwWIyLM5jMYBsOY/QnDse7a
	 NgkC7C+8EBD2GfeK0fpSjx0OQPkb5k1yLOstd3X9azzNnRrNXL1pa9fUvFZNb4ZDhX4gc
	 h3a254vr/cCHG26504mXv0PNJsEmFzEGBuIfgn7d22vkXBUu2imCltRt+HgEGAQ8DAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTkxqM1m;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10278606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 05:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10278606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTkxqM1m
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b3d125637aso544387a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 21:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795410435; x=1796015235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DvvWMG387UA/sN7rd1/UF8ygYenjSP4bEmKVrnnLJjE=;
        b=mTkxqM1maSg9x6wasCbhWlTbN360fasItLYFFN6lCaNr+eoh1yKUPTz9T8R2T0Vaov
         WXYXInL1rN++dZxE8AGCQhv4yEI+//Ua8k7VyXZl1ILd7pq4Uy2IlU0aTZWkL/Gqf7YC
         a8jUeQew7nNjyYzDT/2Y+hX0HK0Fke0kYCYGW/eS8x20yT91r4SdPjQHv6wffyX5kwhf
         vD904eiENpF7Xoe8oZdIFlup30iWpu/6b0KZull+x26ZoMj+uSikDcDbumcZcIL0/8e4
         HXCpQag+FDj2WLQirPUIH7xJNtiPO6JzzsdqZktIjeUEyYzf4nruNMwL0fz3EErteZbH
         dufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795410435; x=1796015235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DvvWMG387UA/sN7rd1/UF8ygYenjSP4bEmKVrnnLJjE=;
        b=ESPI6p2hG2Vpw9O+BIpQzIPkcR7c91IjLUWYbZl2/x7056TpXNrXy/VY8iL5LpzyeF
         h7ABrGe7cGT4iQBttQglfgYDCaK8yuBjEcRcw82nXvcbDWuqcfDv7sojMBbjL4v60cOz
         cULKRtgahG/qZtgdjYlNVaoPmSzjHa7mWzZpM4WI6daF548UkpqmqKyL1Hy9Zy3eYKLA
         w+sdMhyNYP9EtOOD1aD9PxislfKao8bM6sopJeTYb1u/U65MBIRyGJ8vjgaYUy6YslEN
         0O9tm2BjJmC3uiHvCmhRBpa4POLbVxnW//P7UyCttWco24kYrt7MqsL0L5CdgDgG64Rq
         b7QQ==
X-Gm-Message-State: APuU4Z+2Uc/oe1Wb3IwCWVsDzPgGWjfi0Nk2kVjIknF0j3Jk/DX0Q66x
	JCOfsYGZAUgaR93YeIGHrxfHOk/AEy+zt29cqAcuSfJMpkgNzdNNu/mG
X-Gm-Gg: AZFdTZfLdj+AEFcCb0OMejkCcYx4vhT/pBjYUu7bW9hZhXmt+2T6eB9dTGOB15v/J+R
	8yNeY68KWvdceYGcXq57iwLl3GKkGEABhpyrejfVowLbcP4Usn3FMWvIAhQcpzUaYoq7TxdNon6
	c2GMYoqS6Z5CQx9eM2qKcGZBFVxmEpL0e29fLPJTe3mcBYPm0r/1glGO0XoyyQWK7r2rsBeUpq1
	4o+GYaubOh99QyaUtjxGbxKui23U2AOkfIA5wbfOgwTHrfACfMUNazK93EJvSQymbEQM8GkY6/q
	RNDFqbH1a2e4vVFouoKzi2FrCmfMN7W/oy9Zlowp9vncej06mrvxJVjfJ9/Ezk206Hr8MfqMgY0
	zbGceG3KGGWWb+4buU88oV+2xJxXMb0UPcX3efgDxNAcuL+21eOd7XJbKLxHvz/Dfh5Rbp4beN3
	dRSmvc82xKwT8UNQzaVrEkkvJjaHbSXGNjx0s/KHKX8+bOQVa7bDWFIkjPH8G2Gdn9rD8QMJfO7
	Wirbif7AOWdpSkYv7qjMWDjLcYz96qcWZC4CUcXtai9NF+9/gb+aOyiPSYFfAtcVR2XbI89nWLw
	aHhpRyLjHoAXKLE1/TK0w6b1oSnN10oj53rCBrJOHK6+vA==
X-Received: by 2002:a17:90b:2cce:b0:3b0:a7b5:c046 with SMTP id 98e67ed59e1d1-3b41c9759cbmr9934421a91.54.1795410435349;
        Sun, 22 Nov 2026 21:07:15 -0800 (PST)
Received: from nixos ([220.191.54.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm6438713a91.3.2026.11.22.21.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:07:15 -0800 (PST)
From: Thaumy Cheng <thaumy.love@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thaumy Cheng <thaumy.love@gmail.com>
Subject: [PATCH] perf/core: Preserve the hardware index field for missing branch stacks
Date: Mon, 23 Nov 2026 13:07:06 +0800
Message-ID: <20261123050706.18428-1-thaumy.love@gmail.com>
X-Mailer: git-send-email 2.56.0
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

PERF_SAMPLE_BRANCH_HW_INDEX selects a branch-stack layout containing a
hardware index after nr, including when nr is zero. The generic fallback
for a missing branch stack currently emits only nr, unlike the non-NULL
stack path and the layout expected by perf's sample parser.

Emit an unknown hardware index (-1ULL) when the field is requested and
account for it when preparing the sample. Events without HW_INDEX and
samples with a supplied branch stack retain their existing layout.

This makes the fallback consistent with the ABI; no reproducer for reaching
this fallback with HW_INDEX enabled is claimed here.

Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
---
 kernel/events/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12c3ad8..9c51c7a1ae80 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8499,11 +8499,16 @@ void perf_output_sample(struct perf_output_handle *handle,
 				perf_output_copy(handle, data->br_stack_cntr, size);
 			}
 		} else {
+			u64 nr = 0;
+			u64 hw_idx = -1ULL;
+
 			/*
 			 * we always store at least the value of nr
 			 */
-			u64 nr = 0;
 			perf_output_put(handle, nr);
+
+			if (branch_sample_hw_index(event))
+				perf_output_put(handle, hw_idx);
 		}
 	}

@@ -8837,6 +8842,8 @@ void perf_prepare_sample(struct perf_sample_data *data,
 	if (filtered_sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		data->br_stack = NULL;
 		data->dyn_size += sizeof(u64);
+		if (branch_sample_hw_index(event))
+			data->dyn_size += sizeof(u64);
 		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 	}

--
2.56.0

