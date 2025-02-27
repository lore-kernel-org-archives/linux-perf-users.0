Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487E1DDD1
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637250; cv=none; b=Cz6qANpLGDoISaFYBBN/85k0x9ZgK8/AXExi3Y5onR7lljLgPBtpe1vLgUQn4F9eEv/3CtQOetuckemKtLtQ3+TN2k8binctfUxGuXe4MZaWDastyDGT1RC6I/G4U6xdUMh5YpWaCdhMAKwx0V6IgIq/6at6nJTfhyV4dr3ZG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637250; c=relaxed/simple;
	bh=WLrZ6UcPbJVjrWmzvaD3wu5SEFqavsc6nlPmJlG4PWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLzAlsQOysnUuP6gBMCoWf4plSryBnASrZC1Zx5JMIXXsSadY6NxRR+0rZwuJB9xIeE7AH61ilDIz/iFWSDuWfOIPWDasFwfwNOrGrPFof+f7kTz30A9CworERxrZK1FBi5ODMzLeGvJHXHIwwgk6azxJqs3oHs9RN1WIFXtLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnoaE9Jo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnoaE9Jo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221ac1f849fso73315ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 22:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740637248; x=1741242048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLrZ6UcPbJVjrWmzvaD3wu5SEFqavsc6nlPmJlG4PWY=;
        b=WnoaE9JonqpZmprFGoujrikSa2DoLDVe0VD2n89QEcJxtYE+9qQnK4FAaqzT/v0Dgw
         tHHtC0zd/8w0jAFArd7CdRuWq64myvI5jDm0iTkXtDUYOzYrQT4yVkAWo99+ZOAs+aaD
         1U8pjyKlR7xlJdvebzHHfl0iKAQv28NWdEFfoPtzNlLCwtZLPg2aHIu9nnq/2nX5mc+Q
         lzEE2l9rs7Y/Tbgxz/DpZGsdRtyk+30LFr2YASS6Bc7Khp08sr/4sysF8eMorJXOd1p1
         w0rPIZ0RtfoS/xsSC+VjGTmc0HTn17rZp7msimn1G6aXK7oD9poV3S1pRJkqQhZ5rkYd
         Vp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740637248; x=1741242048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLrZ6UcPbJVjrWmzvaD3wu5SEFqavsc6nlPmJlG4PWY=;
        b=Ix6B7lES/l5YznZLb+GBDuJL8ZPeOGDff7/LawmuCfpetVkyNFggt6xRWxY5m6HdpJ
         SlBatdKMD3n3RK0nUnKQ1lz9HTKQRy8Nx+MJhdUbIy+q4XCHn77QP6VmXvd4aArDIYAq
         4lloJcl3JrlAb/p+yGOSZWP6aPuknZfysgztYp5jcteQD2gPVxiqvJeMp1mhygKI4xFn
         Ol+xNJccPCveKQ2mINprrt+PuD3e5R87G+/1+cD+cmlMOK1anlt3f65+DW0v5H+SbllX
         pQ+SVc9MwM+cEsUpv8XG+szmMrY0A3I+J009XtkFdN493mO15BuY7u7ywAHC45kRLpqT
         fCfA==
X-Forwarded-Encrypted: i=1; AJvYcCWN8u1obnjC+9gz8x+JGWmSppd6BTX06BUjMvrpbhhEK8tp06hvQYKoh5HsBfi2QSGmMq9YC0QftsNWksgEWZyI@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLks6mlxuO+IavKxK2cdQbbOKGWhsp0IzbQvr+O+H/5Fpe8d4
	saSitUIKCwV9neocTMAQ2M0XJyfi7kK4jx62WCgv5+j8/qRr9R8qCSNRRq28s8pQmM6Atsyf+Ml
	aNBJ5Rk1VckcjZBC0j8IvVc2aeeuzciEzq+7x
X-Gm-Gg: ASbGnctYJj03NLFudalM+7zZlfonQmJH4MmQQ36mf6FMG85cSOr6EU2WKyROMttIxWU
	M6JIDHsoE4T8y1d12lJomECSU3SgZyYTLippkqhcVFBWgkgmbMHzHpa3nO16wbFzbwyqyPQSEw5
	0MAInqstYO
X-Google-Smtp-Source: AGHT+IGWdTsjnNh0jvb72T9x8Sr7SE8t6FOt9DonXZW94PRF9kuZCf+jYLdiAC+H6QpW0xl74NslSGi1AKxbAeAHFY8=
X-Received: by 2002:a17:902:ce8b:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-22351753476mr1195355ad.19.1740637247911; Wed, 26 Feb 2025
 22:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com> <Z8AAcZXtuD7O3TAV@tassilo>
In-Reply-To: <Z8AAcZXtuD7O3TAV@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 22:20:36 -0800
X-Gm-Features: AQ5f1Jpr4a2BZhNUtWT9jhoDoUHEh7E9i7XEn4hL2DIo6HcdtdZc_Tj2IMANX7E
Message-ID: <CAP-5=fU4rVkTS07Uq8g9roO4kXq_z2R0CgMX55YFXFWMHzWTGw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Andi Kleen <ak@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	dvyukov@google.com, james.clark@linaro.org, christophe.leroy@csgroup.eu, 
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:04=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> On Wed, Feb 26, 2025 at 09:34:06PM -0800, Chun-Tse Shao wrote:
> > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can caus=
e
> > asan runtime error:
>
> It seems pointless. Most architectures have cheap unaligned accesses
> these days.
>
> Just disable that error?

The perf_event_header in perf_event.h is:
```
struct perf_event_header {
__u32 type;
__u16 misc;
__u16 size;
};
```
so it is assuming at least 4-byte alignment. 8-byte alignment is
assumed in many places in tools/lib/perf/include/perf/event.h. We pad
events to ensure the alignment in about 30 places already:
```
$ grep -r PERF_ALIGN tools/perf|grep u64|wc -l
32
```
Having sanitizers I think is a must, if we allow unaligned events we'd
need to introduce helper functions or memcpys to workaround the
unaligned undefined behavior. I think the padding is a less worse
alternative and one that was already picked.

Thanks,
Ian
