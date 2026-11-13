Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552031;
	b=B60hf4lrMQHmqix/eWu1wtluRItPtP9dC6Gwkz5ysy0X2Iw2NVuKT/u2oN/7Ma7diRof
	 /OSPQrW2m2QdHaiBOvLd9qoPOu95JuoRk/V5C6m686efnNIjam1IWg2pVDEDwdj8JPbgo
	 IxIMfxUfwH2y4Vj2qPuf9ESVxH21l2fLlug2fqigw+GrGBahVAwx9sdigYDFy1ntkN6fU
	 mvMOEYj2XwD/HCbqlgC4U8/0nj422Ya4RyYWjZ9EzqGRFkvosxb/KaniuXf43CAs3I3Hj
	 98ok19rUt4xukYX5+wBFVwak0OcjPUNnEUOlHlyfkUadqpZRKxtMMSAeMt0hPSZw88w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=t6Jg07tsLCsIeZZ/dxjj77HUXiYcwZwtBpyyogJ2quQ=;
	b=ySg3IshAALcdLyaICQIBayX7rIauCrJLH68KikDJBdKuQOrHrvyl9G1Rs2X74F0zw9HC
	 sD86eixJwztGa33hPtEwfmMfgp/nG0WF2yxB+VOrt7pzYpJBL87lt7pGqH1eBmq6OLJwd
	 SPIbopi6Jm09uE5xg5WxNrdRMMY1bPumnxV99d8B/oveg+LjMu26uSHXF1S4NZ5ETE4mm
	 79NPtfBJSQFjkuZDnNp/FnB9J9oqHBB/JL6CdVfeYcLHKOrMiQ7lx6TpkpFxhetCqcA5E
	 4vDsrcOtVn0YOST3/Mu+81ZDenZVhj9BDnBky2n/rLOO8WoQ2t2xea4SrsWpIaoG5hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HlQfVMpm;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CE606A321
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 06:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 804CE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HlQfVMpm
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-170135e43c7so1786926c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794552031; x=1795156831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6Jg07tsLCsIeZZ/dxjj77HUXiYcwZwtBpyyogJ2quQ=;
        b=HlQfVMpmbEDTrNrrWd/Agx9fT8zq0CquQIgQG7OCVqMCz4pwt8aCl11JUKU2nH9JGx
         NrKPF7dgqrnQfzH2+jbuvJtItlMZ2kMDxO7mFnEAwa7FXJBiSf7a7wxZg4Bhih9EJ3k5
         I/Dlyasiiy8k5Crd6FLmJqbOZt/IC6kvl1y3Vz4gf1vwzNdt7jhtbo1aGWt3UN/DcQ0k
         DQbYZIxnrmTfPIV8UFcLXzr1DJNWnYVK5WeAZW99K0i9nox6EZy7tmA5NXAea+sAxBOu
         QSUn9TsBncc4x2UAKHwIc7SVg+Fmex3FVLffjJ3Ssdx2ICfL4h1bwwABg9qNs1Oe3OHr
         PMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552031; x=1795156831;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6Jg07tsLCsIeZZ/dxjj77HUXiYcwZwtBpyyogJ2quQ=;
        b=HljMgUvpMZRaSk/xJWzZZchXhX9Pnc8mSz/kc2JjkIshdhncqIrYGWlZGVXIneVOJ1
         MD7vhlBwem4VqMMRlvAKbv1QGt1l87ggQbhHaZphWVUzZ/KFHPq4skRjXDoXOt1mErQ4
         4M/7DtWkf3XfeVaH1VEoLK6iAC25BSZDgQHwaINb82HIuagG49QWF+mED83eYgb1IrVT
         V7gg0HGrLxJEjVRAYSBrAvlxTyESFAzcPXSlQ+CzcyxfBs6DLyK1o2R202/gGOhYZelH
         ca+jsN12pLgzjB0LgdD1jeq8Ow1rnDn1gGhap0rLlQz7yGOGZzjGDg9iafjjnrRRJw71
         cSFA==
X-Gm-Message-State: APuU4Z9O7kE2DCq1JHzx54zO47/0q5npbKQXba1jXODSPSchRU3eqAIq
	dIeYnnBQq0bYecBBjPZ7BKwH5Kby0Kuqx96UMGIxyBxPQxk1ZGKY1UjG
X-Gm-Gg: AYBFou2ysZQR9kinuYzQDFlFODypVB7NcrZJ5VTGGytoIlsEwudkLZ0EYcEpZTf9KV/
	tJ9jJ9Y0XMCLSv72rj0B2AuNbGBTsjE5e5JtBr9fit4od9ylKiPSZNRTMv8uaMX1YD8uOmHY3lx
	yA8Huf3cYUhnwey0xh0PA21HGGSdIyaoytSUBsiO8uXTUdeu/jvXUvX30kSwVuRIUnwbpF9Fxto
	jQ9i26Hyvp6CMdCdwK7jH+mAzl2VFC75+ixU8sXURbvLkMwwc5m8sovjOnJniPAcC612IP+VBAX
	MRYbP0gsW9eUxwsrRKlbPKuZYHqBQ8QlIrpXxtcPRLVLNflPYG3XhdSI3NUahBWBFiQd24vY6e+
	+WBMq4IaIG+ZA1Z0e1iEY8AswBr5xb2VeUwEOyaTlqHJMSwdHZk9WncEFLnLCXhQ/88huCDFPhf
	lBhNLjrgN6pYMdpCFrI1GVqIh0ZYX10kE4Y6sqDv7b5t5k62EDPYStbEfHaIcmYi5RkjLh+yxhL
	zqLf5WkUW76NGxYW1zhB9M9iqCG3ci/JJb2WDH/hYqIpiD8ehTxRZLF/3KJ/31nh+FsPhuUT6NI
	5++Z+KCP7iMwUQDbg/kXHfj7sYjmaJlbv3GeWnHfzh1LORE=
X-Received: by 2002:a05:701b:4248:10b0:1b3:b455:93db with SMTP id a92af1059eb24-1b503131b06mr1869718c88.24.1794552030463;
        Thu, 12 Nov 2026 22:40:30 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm6321205c88.9.2026.11.12.22.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:40:29 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled PublicDescription keys
Date: Fri, 13 Nov 2026 06:40:27 +0000
Message-ID: <179455202729.738309.5850348519213838978@gmail.com>
In-Reply-To: <1e5907fc-40c6-4025-8d27-a92b3cb2845a@linaro.org>
References: <20261108183846.3804875-1-takano32@gmail.com> <bf6925f6-613f-4e20-8491-2a99183f34fb@linaro.org> <1e5907fc-40c6-4025-8d27-a92b3cb2845a@linaro.org>
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
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

On 2026-11-11 14:03, James Clark wrote:

> The linked patches seem like a bigger change than what I'd expect. I'm
> not sure that's necessary for something conceptually as simple as
> "validate the json files".

Agreed, and that version is gone.  What is posted now is one patch: the
list of keys a table may carry, and a walk that reports the ones it does
not.  No schema, no similarity, no metric-name check, nothing wired into
the build.

https://lore.kernel.org/linux-perf-users/20261113032927.634183-1-takano32@gmail.com/

> I'm also a bit lost about the relationship between "[PATCH 0/3] perf
> jevents: Report the JSON keys that jevents.py never reads" and "[PATCH]
> perf jevents: Check the JSON keys that jevents.py never reads".

The 0/3 was the first posting, and it had collected two unrelated changes
on the way - a report for a metric expression with no event behind it, and
making the arch argument optional.  Both are dropped.  Since v7 it is a
single patch, and the only thing it does is the key check.

> Even without jsonschema I can't see why a validator can't be written in
> less than 10 lines.

It can, and that is what v10 is.  The check itself is

  for path in sorted(Path(root).rglob('*.json')):
    if path.name.endswith('metricgroups.json'):
      continue
    for obj in json.loads(path.read_text(encoding='utf-8')):
      if extra := set(obj) - _TABLE_KEYS:
        print(f'{path}: {sorted(extra)}')
        bad += 1

plus a directory check, the 51-word list, and a shell test that feeds it a
known key and a bad one.  On today's tree it reports 19 keys in four
tables.

My earlier answer to this went into the other thread by mistake (wrong
In-Reply-To), which is why this one looked unanswered.

This thread is the data half: the 16 keys in ampereonex/mmu.json and the 3
in the AMD tables are still in the tree, so the check reports them today.
I can post the corrected table as a v2 whenever you want it - the check is
not a prerequisite for it.

Written with Hermes Agent, an LLM assistant; the author reviewed it and ran
the checks it describes.

