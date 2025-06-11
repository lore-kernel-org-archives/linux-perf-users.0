Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6BE2857CF
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653846; cv=none; b=BuF2Sh3895VESACGP3FO5P4i8Mf9GIgJmy8pGaOeuG50FvOsWwL+dcOVuyhKwqp5Y1X5lzd1qBqRRV4iKeuF9tMIbIZA4GKOErTQj11avYyRvpe/YBiuBUiNuz3/WDpXsgFWr0fjrRqxeN6SBjyyeUHxRPPw9NFzKPb3036h8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653846; c=relaxed/simple;
	bh=ELj3Eejh8zZB55e7jcM1QY1zMfyaK6qINNEc1hne0DY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B+3kTxkoB6oUeeGV/tLcMcTXVJWM19l2AOUapYSXwC2BY+Lr8+I7kCc+FSKvdNk1qFDXbkzePcY4R/cTqAF/WJIUcEgsaRLESOyiesPAJ+Nhc8g5ejHR99oT9SzXHhz2Lnzw47DhUou+cgwKmG+eA40WknayCg/MXy9Y1N/ZAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=ej6Gkzlf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="ej6Gkzlf"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fabb948e5aso69507196d6.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1749653844; x=1750258644; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6Qz0T1i5QiFEXMgdpN0GXNYPbCCjSkcApaqYIRUnfk=;
        b=ej6GkzlfIdRRSDfsQfLzR4KXe18v0X/ORZ5BvP4vzItPvpdFGt5PAAnYyRlIVMGhC5
         OaWDVEvuFh94f+qsJ5kafar2qbDvPRvzsHDFTeCaEdvolzPg+uhJ04Qp938kBY8NBvSa
         fBl+5l/p9FcojlgI+r7xdZ9SJ487ZHEJrrah0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653844; x=1750258644;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6Qz0T1i5QiFEXMgdpN0GXNYPbCCjSkcApaqYIRUnfk=;
        b=clL9tY2qgSsQlkvqTiLzkSD+azSZoMMrZQ/UkKIRf6Pbnsletu9Rheb9D07wZLuyjZ
         AiPWVFLaZLdUNa+hXYtnR2T35kHEvp2K6NMGVH6IMDmg6TL32nmb9YDMcE2n0Tx0JUo0
         PrWi62BUCxUS2nf89vFJPTkzwSm9exFwE+ddp/bplwaQ0/WF4Z5CB+7aLb/sznsfCSTE
         FshvXD/7x3fIbRgT/+T9o/OiXdXnaolOpub8UQfgNMjDRURvXxbl4Sp+WaeaSKXq9LXH
         6WIMv6z8gINxApcsVDpl3Sc8XzRnkHGY+vTiCzEm2EacgDWDRDj5xePcwDILC1Ma7IZR
         U90w==
X-Forwarded-Encrypted: i=1; AJvYcCVGQyBOHeuHmepVhor6/goPxwBUh6kHGkiKCOtQDqFMEJatD9qgw3iywRi/s/LqS8Yv6NzALkwWQ4JTnXM6RTBX@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqXy0lo2sfPuMT/2yu5sEve0h3N1/aQO6vd6sXPRKyosKEzfH
	zpT/g1DJWfJZb5FSVOEeuEf36et97BsVgFxzlbLM81POwR1l99K28RUplmh1P5IyWg==
X-Gm-Gg: ASbGncssYTtkJ0NvGFtQ0z+cu4ottenLakHruoz8vg7VrKYzKS0YMc2peoVGIehgyti
	oysojBx2AS8UxW149752xFhbKEs5IJ+5VuZ6yIeXT7oLVNw0rNnlzt7bIhJwlpbE9XzyUCjW0zi
	dI0ZdlD4hqhBhvEPR4+PTlcP3Shg1gHs9xfzUH2/DiBprHlcgsC+TIZO/M3StzyiPN+E+iIA78h
	x7AxwiKNYw45gccr0SIp/rx1cM/8eVgFYOPmWrwjaRkPHQU2Izu96UVs+nRf+ZqBnNXq96dfMZn
	nKv2GuhxIwBBL+Hy6yJw74N3zMYibKIunYLzdVGdJbcG/yGbYLmhPvpENrrqF3xBzQzMhmP9BBM
	ncUZ1ug==
X-Google-Smtp-Source: AGHT+IEw7wk+RzMxqv25pZXw2YGIKgdnXxzz3CvYscPGSpMRH5hHiPD652+vsvjKuc+tm1+2B7BIiw==
X-Received: by 2002:a05:6214:2626:b0:6fb:25f:ac78 with SMTP id 6a1803df08f44-6fb2c386dd3mr44270966d6.40.1749653844011;
        Wed, 11 Jun 2025 07:57:24 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b36647sm82322106d6.113.2025.06.11.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:57:23 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 11 Jun 2025 10:57:22 -0400 (EDT)
To: Vince Weaver <vincent.weaver@maine.edu>
cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] crashing bug in icl_update_topdown_event
In-Reply-To: <352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu>
Message-ID: <080706b6-ed21-540d-dfae-ae27d130d796@maine.edu>
References: <352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Vince Weaver wrote:

> Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
> CPU: 23 UID: 0 PID: 0 Comm: swapper/23
> Tainted: [W]=WARN
> Hardware name: Dell Inc. Precision 9660/0VJ762
> RIP: 0010:native_read_pmc+0x7/0x40
> Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
> RSP: 000:fffb03100273de8 EFLAGS: 00010046

one additional note that's probably relevant, this is on a hybrid CPU 
machine, so CPUs 16-23 are atom cores that don't support topdown.

So the crash is probably because for whatever reason the kernel is trying 
to read topdown events on an unsupported core and triggering a GPF.

Vince
