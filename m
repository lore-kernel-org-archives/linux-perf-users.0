Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558321E5B71
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272705; cv=none; b=rRsKnQQwjM2oUX9Q83eIfR8B1MDhjuUM8f7v2Ga0MH80uA/gqK2iLhopI/WFb6zGohRv/b7WveRrzFVwmWxVfOSs66fWewAebYeBJf3kLg+vmBLNPleJXwo9J/twBOSOaPGyOJuHyIroj9WMTPkQ5AajoywC3UvrqzdtAp8n4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272705; c=relaxed/simple;
	bh=TUniEey555dR2Zs0ROb9G8zAga9DvLrWYk/kbGgv6uw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ep1DLOxx8759sae3XGV50AeM50IE0DYXDGR3FN7oiEO+GIN3FntuarztvMcaiWWg9VBuCbb96s0U3Whx886GdCT8UVxYV2CB+ncrJhsOKNHCGddOsyn0xMLa+w7TQZNhzlhkrpE/v318pAb10KPlnatdrG8ZhkUbOLkcasnNaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTvzZup8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTvzZup8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff68033070so3929400a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745272703; x=1745877503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WIjf7BkD7nF1xQMvzfauJl53Yp33HFYTRxCjMYRCYg=;
        b=PTvzZup8EKHOc0VHKcdSQRejPI/FAzjugNa59uNgjL+dHizPynB9y18fDrukUV9HoA
         EOym6Oe2tmTIFv51ELMthErxlB/OFxaVQeZUPLa3bEgTHHiaQhV/TTHmPBKfo0tdOFLs
         cznExelRcuUR4gBIBQLB5ULxrWNnyTR74IrTy+0Mj0dj/Zhws69Vxxb/arqN5Gb7x+G6
         dwC6Bw+nTYfh1AMa4A9GLSVt37lOxYOHzNhVVYmPmbrsAbEA1sUiVrruR94C6cGWTww2
         Tf6lgh4LvgN9kaFnZYvo0f7bDJoZfejCND88TGvZqkSD9bNY6v0UFxYBBZMQoDJVGWAz
         A12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745272703; x=1745877503;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WIjf7BkD7nF1xQMvzfauJl53Yp33HFYTRxCjMYRCYg=;
        b=CcPDw+uN+N4xrogGSD3BydxR1Uzxrdkpv+tjEqtDw4cVVk5wR/A3YbdM0otXO19bwV
         d+sW8MDlBlSS0o5nivKlS582Saik0NRtqBBG9zJcPTaBAXyGcxb7LRJnN4/JcBFQzJgp
         i1OgaZNBz22ujl5iQo7flJeoKx5M4oznakZ/ixefm6m2w3MepBesZhiG7gfE1/d7bEnF
         JlvhCn26WIcB20KxEO77NWLSn0CI9+fYSXMbwaptBBfLutlm9az4miXXZ8BdtySsAEAi
         KK1UOuEPYVVOemHIDvzcrsi0+wtG3JOaclUZZ86HXPldfKxJIKV/ee84hosTxLqPAwDg
         T6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWbaqkMVU2z4/BcRnaIRvdExT16qSeGuKuohU8ai1zJRqDIc9fc7hxGMIP5zLZKZaLVX8yxQWsCRrVpm+XhFFOP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21wXp8aZv9p4Ad554GS27w8hnmvIlzmp//jRub/Dn2rif9H1M
	brVCEvLiItz/8PFrKGbypMDS7/8B8Tw4GKVWlyr6rN4JdklkE0Za3qaOJ0qRh2vp/P89qkUWTE4
	O
X-Google-Smtp-Source: AGHT+IHuM0mA5XfdIhg4YKjkwITQgbzYeag35JCsv00DyyCQALInFDgRHAl/8y1gCJY+fgx5/v9L6p9bDQg=
X-Received: from pjn12.prod.google.com ([2002:a17:90b:570c:b0:308:6bd2:720])
 (user=yabinc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540e:b0:305:5f55:899
 with SMTP id 98e67ed59e1d1-3087bb48f40mr19194057a91.11.1745272703594; Mon, 21
 Apr 2025 14:58:23 -0700 (PDT)
Date: Mon, 21 Apr 2025 14:58:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250421215818.3800081-1-yabinc@google.com>
Subject: [PATCH 0/2] perf,coresight: Reduce fragmentation with non-contiguous
 AUX pages for cs_etm
From: Yabin Cui <yabinc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi perf maintainers,
Hi coresight maintainers,

This patch set (2 patches) addresses memory fragmentation caused by
contiguous AUX buffer allocation for the cs_etm PMU on Android.

The cs_etm PMU doesn't need contiguous AUX pages, yet perf always allocates
contiguous AUX pages based on aux_watermark. So repeated use of cs_etm
with large buffers leads to memory fragmentation, negatively impacting
other processes.

This solution introduces PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES to allow
cs_etm to request non-contiguous AUX buffers, avoiding high-order page
allocations and reducing fragmentation.

This aims to reduce memory fragmentation for Android devices when using
cs_etm. Your review is appreciated.

Thanks,
Yabin


Yabin Cui (2):
  perf: Allow non-contiguous AUX buffer pages via PMU capability
  coresight: etm-perf: Add AUX_NON_CONTIGUOUS_PAGES to cs_etm PMU

 drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
 include/linux/perf_event.h                       | 1 +
 kernel/events/ring_buffer.c                      | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.49.0.805.g082f7c87e0-goog

