Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455360;
	b=GvA4VTuQodQQ/rt8oZEiT/cr89Jomnn6IObVol23qTb7qqCxdi5LpAZ4zEhQOfUMP4lK
	 yKJPewuR6pcQbwwtb4lnXbNFQkB7IevnNNmEtMo5WnnWDFZNoKGRkPCvzAD4+kH5sZ+vP
	 J+oiTXdKh/NJGyAaTaHgX8w28rQOBPZoCkbX/3onl8CWt/N8g53zfRGpoSzNogEGEbfs1
	 4CvAbj2nXyY1hXxTdxdboq81ffbL08o2zJXUW4Zmnn1zibS/7Vk0NbuZByIi/YHAlakQK
	 rDAoSyDX9zjBntmKuSzxrfRhzTCR8u3tH8S1v8gNasB8BYtXwKVL1RvI0Bkrc5jbY0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=25tsZUpiQ0lVQNm9JwfGrkVYEdwIvgyagRg9J+KAyDA=;
	b=iQC422Xuj+ISJQC6BzuUaoK3Rt/ra6+IB1tWpTMoqSfsZ/qdJ4cEcxPb8JdyE3UAcF57
	 6GJJiNJk/85zzV48Vbu5OtfsiqL3Dal7N4LittYJePdGflpVLhUwgWrH+plwp2g6golzD
	 oSdBLds7Wt4w9iJNJNmIpEjMqrQRD0TvVKNw6Ze0A7hGYYaS+BXkJJcH6GEKSkrH16wMi
	 QWJ/EbvbfBu1ZwzxeBQoHWpUmcWGKk/vLB3rLdy4xSKgXeuDtvgocMMnKL6jQhwZBRY+2
	 Z6Fro3dTgUt/fbJf0ZnB5RGDijfsnl7qmm5/noKA6QxwhaGEuQbxzUOqfF5o8gAGL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOFGclu4;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A8606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 03:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D41A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOFGclu4
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2317662a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794455359; x=1795060159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25tsZUpiQ0lVQNm9JwfGrkVYEdwIvgyagRg9J+KAyDA=;
        b=hOFGclu4HudCtVI9CQuP8pEykqKRvrYhDMXesAcE3Fu7IzxEMClz7O3PelcWZZ6w25
         eszIQU79C2e3saIwpL3wfee0hRUHfYEr1nchlZtxF9Mq6l4yiFOm0ho0oZsB5kzh6zX5
         AURwc2ibA1EQYPnlQyhV9SkKjg6xsXTBXXzlM4S1Go8b8z9MebhuJdKjZ0by/aWiNIwp
         H1LgIxhVyUjqYNRoYr+k7LjVC5uKyYOtG1VAaYHVZZgar3sopj7q+XzbhnOtKmDYs17k
         xi9j4V9wu3EFFTkag2USrKV1zCFk3NUtSuwSPp2geOlL8/Z64lTkEtG+zxnWYP3dZ89K
         AT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794455359; x=1795060159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=25tsZUpiQ0lVQNm9JwfGrkVYEdwIvgyagRg9J+KAyDA=;
        b=qYUDrNz2o01Fgp0VbBinMlCef/sViL/ItAcHpbckh9YmbDmtKgehvIa8oiqM79TeoL
         2786dAZ+jUOmTAKA60WinDe/Cgfh52Gb/jCsjFbHvtBCgXIYkzrUeuJbXOZdrns6ro92
         lxr7HNg2ebcZ+S1+DLJtpy/dBkO9oEtj65j5xd3eZByAHLbUmpSeM0uHfsTJSRimV1MD
         hohXNmC+gwfaV1t9FIv7oAP+CV6mOv9YpPWDzCp8Nn1ktWgOgPekDcYv6k7ngBIfnDKw
         qaB1qf5NGvL+lKnkJW9y/1u6d9jwVKgpo83zs7KRVkrUdJb67Tx9ppkhJQHVEAOxDVne
         yPug==
X-Forwarded-Encrypted: i=1; AL+hErF0u3ER0D2I39C7/sdklMss/JSJFyLLOCctgevERh9I1+XrIfVrZEzzoa+SnW5PLAN+5JztQthL919g1pBO6ti7@vger.kernel.org
X-Gm-Message-State: APuU4Z8gwcF3+gZX4opzYWNQ0jE8bZ66nZrihiLVpYr+27410BsEXjbJ
	LXGeYAO85lT55qtaDUJDYjqBbJSRxmv1sOKkSbe+N3VELbaWNz8ufTvx
X-Gm-Gg: AYBFou2MRB6WNhOa4tG+3KHGi/PuFfQQ+8Es9hGqhVw7I2c5qncLu1SyZIjQdwntEPT
	vUnK91JZzQhFzvYhVgbOuC9OAwL7psf1BWl5B9ylNkSGaVIa/aY1e/8Gj3VC0s9WmH+2u8qPCfg
	+XiEjf3CT/SMHuK+Jz/yH67iGsHhSGm9zzffvCN0zW0V4PnN1g2Vv5wl1mBq2EWDJ47t25dg84Z
	DabguStB7nqEXJOB8P/JFdnwMweyQYox9HRDGWYkeAJJaamfK7GLPiZMEvA8Yxkaj9l4iaPEkyx
	gzGRopJP6CPkOjYjd1JEzQSFs0kYMM3/eJRt+G9VNQeytR5CGCMjoOFDSsfhHqAHTjpaCsv6lxI
	mF9f0mWXezWFe8CPJKfF56qs+qzVDtXC2/hPyHhowUDNqdl//Y24lBOBr6Z2gqpSIYGtOCd1pQ7
	aRFEXm0A/q7GrZq4vCCz0o8nJij4ABrGpuYQN6YYQf1hk2VCTLyJRRcEeOzuQZXdFvNHI+Sylo/
	hgogF9FtLkNB1Jcu5dy3ZM3DPoZIVtjmBxTIToctx3oC0nr71tyVNLx0nZNHo/TA/LoD6T0R1/Q
	SaNrfpezWoSSiPmThKEqvhKlOGBMQ+sG/cTdfjeoReWOtsZQgV2qNLchPJdXKCwKRr2sD05k4ij
	w0VGKhnsk
X-Received: by 2002:a17:90a:da83:b0:3ac:4e18:2390 with SMTP id 98e67ed59e1d1-3b182defb03mr4367944a91.7.1794455359061;
        Wed, 11 Nov 2026 19:49:19 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c4eea2sm2135404a91.5.2026.11.11.19.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 19:49:18 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: TAKANO Mitsuhiro <takano32@gmail.com>,
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf stat: Count kernel events in a group led by a tool event
Date: Thu, 12 Nov 2026 11:49:13 +0800
Message-ID: <20261112034914.3704801-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-208886@kernel.org>
References: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com> <20261111110616.2249764-1-takano32@gmail.com> <sashiko-outbox-208886@kernel.org>
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

On Wed, 11 Nov 2026 11:33:19 +0000, sashiko-bot@kernel.org wrote:
> [...] leave tool event members enabled during -D / --control and
> leave tool event leaders disabled during exec workloads?

Both happen without this patch too, with tool events outside any
group (perf-tools-next cc905a18a647):

  $ perf stat -e user_time,system_time -- dd if=/dev/zero of=/dev/null bs=1 count=300000
  -> user_time 0, system_time 0

  $ perf stat -D 400 -e user_time,system_time -- sh -c 'dd ... ; sleep 0.6'
  -> user_time 173 ms, system_time 137 ms, though dd ends within 400 ms

The first is what TAKANO's "perf stat: Start tool events when
enable_on_exec is used" fixes.

Thanks,
Hang
