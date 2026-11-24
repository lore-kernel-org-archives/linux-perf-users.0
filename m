Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795557161;
	b=Qn7cRv2mFHVsFo2vo4Ve+4KoulyVThiJcnNJH//L1Awv8iNWxdTsEHidFpyBxZCvl2/k
	 Llor2bV2m032CHSmXcUAhsuFdBufE6iHWfMq8n0sRWR7rNmD40ZW+e7TiQJKKz3E5J1l3
	 cp4T4n4NT6i1wW05vTkcSnrV1noovY8ioOuUcQFoYA7RyF6PZCWdU8FzaHZHFb36VWuXm
	 qF6zASvor7LdWybIQeEyq0qyOQ7ULUB7TVqZ/6skJgM877s99opwVqXZNQZiEP0g7brOs
	 m+ms36Nzk3wECOK4E+ZiZaomOmYxTYJl41fWzat2nYUyx0PUoLt3TwmBHzu+9+0d9gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JpyjFKSMwkjcx41RVuzlrbKMavoMvN+HJXNIGpdwKzQ=;
	b=TNQVKUYaTfQ9hQtW0RGql9056syoHANgkCf6iTJtu2xLnQupeizFvGCeAIPtk0kOuPuK
	 RPpwyekv6WkXmI5YsevIIygVZwQMdQ5zuJx+WqJSABm/dGmWS2EtWOuHn/jKTBrIsoS3G
	 mvRuXkC6w6GrPGjwMHo0onVT3tk04tjVUVzsKJuECdhIZVKvML8UXKLSb6vp3BbVPfvq6
	 7qu7Tmp37hDhOw0VBz0LDwHaWAJpPh/v0WDZfDg87eaGbkOZADW/FnwDYZT7Bi3QvZRDQ
	 zhw+H/o1AQvBCn1XQCWddDaIb98m+pjm8nmtaHO48vorJQYmWFkQcxktMZTg9lnX/RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lezf0COD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6626606A69F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 21:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6626606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lezf0COD
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533202fe429so1070471cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 13:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795557160; cv=none;
        d=google.com; s=arc-20260327;
        b=MicC8DQ9pOTx9akSeWZJHP1VYwT0LcXuQFEf3Z30Kag9tcYAc6H2IuBdsdeHC3olRH
         imZJY3QFeW6loWxGOk84MUj+m2EIaOHFFgaA0c13xaDGjq6q7127FieTJbk6tJkuy+RX
         TB4Lxb0/MqFMjVe6OciJckg536gwsVBVez5F+vkHH4SzGXLJIm0efaIPj1mjy3vwyI8V
         Gfp3CkYnB+GXCfY8O+wsSsJ1nXXF0tA/lHB79S0hCexpyjsiMqGdFRtMfejxtH/wahjA
         maLmiA1qwnf40vWy301MMTK+yhXbhOw7ddtnMdF9sKxeBkwe80x5oilcuwAftIPxd7CH
         V0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JpyjFKSMwkjcx41RVuzlrbKMavoMvN+HJXNIGpdwKzQ=;
        fh=9BrXyip7DwNN7/gk04kcsZxD3MjHmmebB0zp971BzWM=;
        b=BNDMtrFMjCwuFdqZqDPhOauHYjVQuk4FMEnmd8RASCT1WLpA7Mst/q0xoW83COfyYx
         eCwG2pJD+kwgvn9X7cJHBp6xHPTuao0xk5bxFRctwc0z9M9FwqNu0kM8z0tEJ9uRaFza
         ovpkKE7EaHD4yOo3+1JSWQnWKBbt1BYNkAXjbeq0QRsnUkjIZopgCAI4DRFIeNpoHdQ9
         5kUy3P7cnqAhMGpv2ju1vH+VzrvB7yhpZnQgEcQBqVfwgU4zU4ZIG6LmdqpXvs8bG2Js
         mDWIHdyyOkhbL4rhTgq5whCn9/rM4lRVlLB/g4CBYs3sCoEgwMHsViRbnczaPXxek+Kn
         SWxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795557160; x=1796161960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JpyjFKSMwkjcx41RVuzlrbKMavoMvN+HJXNIGpdwKzQ=;
        b=Lezf0CODIa1dN25ZggrWjCbhYVBJMXsZu5R7WATeS4xcozO2zog/Z3H/fjWE867ZyY
         h0Nn93XA0VnwoTc4VOOBbYVpywSyvoGHKiLGAquIhYxb/dNogFxHCP90/NXbmLOFIbs3
         U0pTjrFo5ZRfevn0rlfUC3CAYkftLtUKKscRsyklU4nd6Y2nMUyQOqmP3EoRkEQmjpqK
         cJZg0HWuZILjJHIVLVjRLRP9Z8/3ttP3OcO7CuflsYklPdIG8ldebae40P/ptj7ysOn2
         malZGHsiitpstbF6dJd0+4Z5W3tcW192RCgaSn8n+d0E90vdHdhRR/nfqWrEhmWr2tVE
         d8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557160; x=1796161960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JpyjFKSMwkjcx41RVuzlrbKMavoMvN+HJXNIGpdwKzQ=;
        b=Wwh71nkoWHj4NzTbT1M5Ny2Zi4qJZsnGGi3UyF5Bh61DjZ+FSPCyd6DyOXquKg2dzK
         apmOIz8MEcdK8Pw87OWmSLbg+1aTjSbRq3SbINp5Z5crl7rK1QGtn7m05LIsVyIfvrjI
         Q84bHS4rQtvLeWHYFZbwU7MtVdmwDH37xBlJ9G5icJNrRyNIMEatRo1cY+t100FYTqyd
         ZwviMFI9RYfLAyvNAjTNuTXqEEtLpqo86Psh2jL39up+leEnWGaKpqpWoZpp9Y7Cyt8P
         Uk5EodR9aOS2++8UEtu4HD/fPlqxALF+34pQzuJraKhrf9XFgAX1wmg6DULWB2xSy5aw
         joJg==
X-Forwarded-Encrypted: i=1; AL+hErFLH3jp9h7u5xT3sQNLQAgcBLHl+eaSndXXFe8fPxu9NCbjW2OKMAcOLTf9wPVpPeplo9x4PlHz3ywq5mvZV2xt@vger.kernel.org
X-Gm-Message-State: APuU4Z9PAr89DCyQvQYFR0uYoUo96/b7+kt6MmTLZFJTk4YyXUXcl9eB
	0nCtdKgqdQHz3/hgT7giu7u7M6IIwBRcMH4SBVmAfplX6VO5e+U77+s4G/qfmTFuN2YbcFm9rTT
	pTucqOl9MiZY697+Wq6p1XJCGJDPcZwc2r1dtikDF
X-Gm-Gg: AZFdTZf7cwojyp48/ywTyXJF05qVJ77cATJJhj8FLEghlOBLuHi5mLLtaSwnwuZT1mb
	OKRpDrFbCROvP2kO4FXW3kwk5Ltspg6dyeR3czQB/5OmX96R3AQzjQLL64MghukZOEPrzxldBCC
	5vkedED09mIfQQVxrym4V591kHnDBTm9EVBhlawEoVjRwaM+mfaKfo6OI5sY3wfOmCKtuwoziYU
	i6CLNZ/G7eNhUwDYlccqEgHPfxTGF1ctmwsxskhRMLeuF5rmGXYFYzRCsijG/9cMC5qAsA9lGXl
	pXbPvhgYjtnrkgRoyX5cJI11d/FoZ/DSkKjgbUxEVNRLfUD3dGB1ILE2B/T46ZAKufMXkJtOEFW
	q3w/neDoADMnguKpWu/n3iAmjkwGu5HVq9nZrcxj7ZQ0fAUOvbPpNtXtXRzhW/BYYIMcB
X-Received: by 2002:a05:622a:124a:b0:535:bb33:6351 with SMTP id
 d75a77b69052e-55d87fcff29mr71826261cf.1.1795557159257; Tue, 24 Nov 2026
 13:52:39 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116070038.2968725-1-irogers@google.com>
In-Reply-To: <20261116070038.2968725-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Nov 2026 13:52:27 -0800
X-Gm-Features: Aa3M54rYRZBKT1foMXt2hASolNTM_CvbdeVAXxgHLAXXAYapg70_UNTO0Lvi-AE
Message-ID: <CAP-5=fU9C5BTqgHXLvXMzo90a2+LA6PmXbvUkXsrjJ2A_mMyWg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] perf jevents: Block-indexed string compression
 and default JEVENTS_ARCH=all
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 11:00=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Compiled-in PMU event and metric tables (pmu-events-in.o) currently
> store ~6.9 MiB of uncompressed string data in .rodata on x86 alone,
> causing JEVENTS_ARCH to default to $(SRCARCH) rather than all and
> preventing out-of-the-box cross-architecture perf.data event/metric
> resolution unless explicitly built with JEVENTS_ARCH=3Dall.
>
> Compressing big_c_string as a single whole-table stream would force perf
> to allocate and decompress megabytes of unused CPU models' strings on
> startup just to resolve a single event, whereas compressing individual
> short strings suffers from poor compression ratios and per-string
> framing overhead.
>
> Instead, this series introduces "block-indexed string compression":
> sorted, suffix-folded event and metric byte records are packed into
> ~8 KiB blocks without splitting records across block boundaries, each
> block is compressed independently (sharing a single preset or trained
> dictionary across blocks so ~8 KiB blocks retain high compression
> ratios), and every uint32_t string offset is encoded as
> (block_id << 16) | sub_offset. An ~8 KiB target block size sits at the
> knee of the compression vs. random-access curve (smaller 1-4 KiB blocks
> pay 22-128% more .rodata for per-block entropy headers and index
> entries, while larger 16-64 KiB blocks yield <15% extra savings at 2-8x
> higher decompression and page-fault cost per binary-search probe). At
> runtime, pmu_events__get_string() uses a lock-free atomic block pointer
> cache to decompress only the touched ~8 KiB blocks on demand, leaving
> untouched CPU models' and non-host architectures' blocks compressed in
> .rodata at zero runtime CPU or heap cost.
>
> The series starts with a standalone BigCString raw-byte fix for
> describe_metricgroup() binary-search ordering, prepares the string and
> PMU table layout, adds the zlib, lzma, and zstd block compression
> backends, and switches the default JEVENTS_ARCH to all:
>
> - Bug fix, string layout, and hot-path isolation (Patches 1-4):
>   - Patch 1 stores raw NUL-delimited UTF-8 bytes in BigCString instead
>     of C-escaped strings, fixing suffix folding and describe_metricgroup(=
)
>     binary-search ordering on prefix-overlapping names (such as "Bad" vs
>     "BadSpec"; Fixes: 66c6e0c10027) without changing empty-pmu-events.c
>     so it can be cherry-picked standalone.
>   - Patch 2 partitions non-folded BigCString event strings before metric
>     strings and sorts entries lexicographically by their raw UTF-8 byte
>     sequence within each partition so identically prefixed event names,
>     encodings, descriptions, and metric expressions cluster into
>     adjacent ~8 KiB blocks, improving block compression ratios by
>     ~20-23%.
>   - Patch 3 stores PMU names directly as const char *pmu_name string
>     literals in struct pmu_table_entry (only 68 unique PMU names / 536 B
>     across ~443 rows across all architectures, already in .data.rel.ro)
>     so the compiler/linker merge them in .rodata.str1.1 and hot PMU
>     wildcard scans never touch big_c_string or trigger block
>     decompression.
>   - Patch 4 encapsulates big_c_string offset lookups behind
>     pmu_events__get_string(uint32_t offset) across pmu-events.c and
>     pmu-events-string.c.
> - On-demand block decompression backends (Patches 5-8):
>   - Patch 5 packs big_c_string into ~8 KiB record-aligned blocks indexed
>     by (block_id << 16) | sub_offset, adds lock-free thread-safe atomic
>     per-block decompression on demand, and adds --compress=3Dzlib using
>     raw Deflate with a <=3D 32 KiB preset dictionary.
>   - Patch 6 adds --compress=3Dlzma using raw LZMA2 per block with a 64 Ki=
B
>     dictionary window.
>   - Patch 7 adds --compress=3Dzstd using ZSTD_decompress_usingDDict() per
>     block with a once-digested shared 64 KiB ZSTD_DDict (~26% smaller
>     .rodata than dictionary-free ~8 KiB zstd blocks).
>   - Patch 8 wires JEVENTS_COMPRESS into Makefile.perf and
>     pmu-events/Build, preferring zstd, then zlib, then lzma, and falling
>     back to none.
> - Testing and JEVENTS_ARCH=3Dall default (Patches 9-10):
>   - Patch 9 adds prefix-overlapping metricgroups.json test coverage and
>     an 8-thread concurrent event/metric/metricgroup stress test in
>     perf test pmu-events.
>   - Patch 10 switches the default JEVENTS_ARCH to all. Bundling all
>     architectures (x86, arm64, powerpc, riscv, s390, nds32) with zstd
>     shrinks pmu-events-in.o from 7.16 MiB (x86 + none) to 1.11 MiB
>     (all + zstd, -84.5%) and cuts the stripped perf binary from
>     13.32 MiB to 7.28 MiB (-45.4%), with ~3 ms median wall-clock
>     overhead on 'perf stat true'.

Ping. Sashiko reviewed the patches, and they are clean:
https://sashiko.dev/#/patchset/20261116070038.2968725-1-irogers%40google.co=
m
The series adds a small decompression cost but yields much smaller
binaries and cross-architecture JSON event/metric support (still
optional but defaulted on given the cost is now minimal).

Thanks,
Ian
