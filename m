Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB73EAD0;
	Mon, 19 May 2025 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747697798; cv=none; b=T41QQdCWGO4JvjxtVodjdenZtGg2jZHYAiNNyxp0+TWWeNg76/9p/owO0mQ4Nm4DSodcvjn+CEdp+jgWKYwhxqBwWW2tg/W1+zKqm9AhWliT8dq2a04CUPuHxehUju5TRz0TIzv9yqzfKepuroY17k2uvPWGWwb0P5ZEHwgvv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747697798; c=relaxed/simple;
	bh=iPRCPezxT+jmDmQpfLs9yGlHD+sXQaWLQDI7MKQDc1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anmxMSgwc5sYNi2uAeLfQ1WuwryDQBMgfcdjJjVKbYkmoUQbgT+L2z9IKlILGOvg+sqeh5nmfW//rZwUXjulFzeWvcJZO/urcPdsU9RmHRsQWJ/YKlEnVkSejbfxFFm5lwob9IzJHjakYkavpTSoM9b1xo12/2tKDVJUYfV/H0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxyah871; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxyah871"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7b97c6159aso1630367276.1;
        Mon, 19 May 2025 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747697794; x=1748302594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvjSm8qw8fd/yWF9kTzhyjMQtCviyI3exNpPmhUcywY=;
        b=Cxyah871qnohUTm1Y4xC3NZ4w7Q7AMDuHREV0M5Wii0QIGSHbd4vGdzmU6YXeEdnut
         6sPFAxrFx8QiQnQ45QyofZp+/c2a1UOgNCL7pyyEdbLUpKvYWZ5Op7YEK2fXBkpHCO95
         qlqzKslWz8iHsul/X5Bpa91DMn3Ku1jlY8xtYY6hYPS5gROtan8ZzSVg7I+bYAHJp3er
         gq8hKKOaY/sJnScqIsCd3/MkxtBBOVWQA2SPBkcLKofNnNgfhtL87L4/xNngXcOxDGuh
         fd02XliLsV8XMrUsJUwn666WgQfotW800AfInKHs4MbpOILoOqSYxlc6SLQZuqrt1/kC
         RKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747697794; x=1748302594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvjSm8qw8fd/yWF9kTzhyjMQtCviyI3exNpPmhUcywY=;
        b=CLTB8oezbAEX0l3soV+WwfKfyU5v/+x/PuIBxu8AuTsvLUD94Zn7WISfgMiqXjq+mz
         sUJ2rSbFMSOMHcP6usgXaemxPkcrl24PcGDm9xHqGgGJAsn/P2SWmyJv4bgBU8Jo8zZy
         4i5SK/35hK1Xr9Qx+CXLoyvVOrQjmsPJNoDAdKvBIStb+FLE0Qt5Stpav03qisxCTh62
         +j4Xuios5QE/7IIFx5/ba+OnvCJDMOJNfgFMCOkdNKVyAIJg6UnzCmbuBB3uc7ifhNY7
         paszALdJ8LHy9zVRsfJtZWYUsv/E3mV3EecfyflX29mtpSFSr4FnUbYvp+VoGF0zLM6k
         c5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhappzQtxRF8PskgzCyEWR8rp7iG8nkA9QEsaat0AiM8tkDMIsv4Mzbk62GUerzdiSE1vWAG7M4RfyIRxeK1QXjQ==@vger.kernel.org, AJvYcCXe9MPPdzAJlvpGIeccitpOzdTUhLjYL8A5N3/LIj0oPjLfG5XNL+y+v5dRZUWkMRwl+Hktcb9Ga+useTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsL8+belPAFIEcF+7YmxlAAEh6EKMAosbxt1WnRzS0RYK/ccbJ
	xYaJjPqfXa6k0nWBxqLW4bzaqWNz7JQ6mgmG54Gp3vfM6uHokXoYoS9svtXacM5O+A3A6ZKf/zz
	Aub30NnnJu0mV0NzpZr0+Gd/UsRSTRI0=
X-Gm-Gg: ASbGnctzcf387zWuTWcN5fyld8mTpJ/rDUT0M5f9JgtSUKKc8Ulr+pE/eByTm1JUklR
	A8rT+4NlsG4rmEYR74ZD8jWZXNFrVFaleipXvJAy1HT2ip0nQ009s/iaXvvO+IbFWQEM+bWrioN
	w+4jpMgFki5w3ZLqknIo6zjLOWAzC5dOdNZGkVd6Ygdw==
X-Google-Smtp-Source: AGHT+IFsAHkt3nDGtHBCXjB1RxXoeX/IP6JddvYN6SguLzmkuhqahMCAcsOEyqx5bMbfJIKG/5l+ZpLNxjbqTdV6rOI=
X-Received: by 2002:a81:be17:0:b0:708:25f1:3eea with SMTP id
 00721157ae682-70c8fe022f9mr210629107b3.12.1747697793982; Mon, 19 May 2025
 16:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org>
In-Reply-To: <20250519232539.831842-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 19 May 2025 16:36:23 -0700
X-Gm-Features: AX0GCFttU-N_RalRj5bFXZeQYgJZk7prgpY0VvZAST9tsEoSk3TQvcBbspklqtA
Message-ID: <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c has
> max entries of 512.  Usually syscall numbers are smaller than this but
> x86 has x32 ABI where syscalls start from 512.
>
> That makes trace__init_syscalls_bpf_prog_array_maps() fail in the middle
> of the loop when it accesses those keys.  As the loop iteration is not
> ordered by syscall numbers anymore, the failure can affect non-x32
> syscalls.
>
> Let's increase the map size to 1024 so that it can handle those ABIs
> too.  While most systems won't need this, increasing the size will be
> safer for potential future changes.
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
