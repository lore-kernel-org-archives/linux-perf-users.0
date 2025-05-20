Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932A23496B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753551; cv=none; b=BBlGgVzQ7h/2LhiuhIhqm53U0n4Mcqd7ckYYhYlUAS3C6AQMYr89YrXwPECP+GO4UyaBSkpZv11S5o+2/9JviYzCGzlr/KE2GaFDASxBjeInIusimvfnYivucEEBkbri2fEnU/UDUUbjSvM3po2WYF9lzmxOMLSOVS2V1/NqeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753551; c=relaxed/simple;
	bh=W1Ywpvi+v/a7g4kdwj6pb+fMIlj0AIEcfL2WdrFRUrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9af6JtQbpXa0I3okzM+LmBZ77kkTNRvt9zCIPAdEMUd7BzOcDawLXXMbYL7tboIVgd8ZF1FbgJ8g5PE59fRL1mgHJUI4kSH3efeXtKkU0m8xMnRehwiI14tGCVlIPOjs6Dy7yXyVhkF+CDJrnYudpwAUbRTWY1vY+rEIhN6kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLmtnMVI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLmtnMVI"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d96836c1c2so760415ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747753549; x=1748358349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibUebolwEMjE+Z6pNyKEAzbDAGWgUPaEEHNdhnwyUZI=;
        b=qLmtnMVICpNbCcvqeayzfllQ7lJ6wDA6OMRaO1oKAIEbU8NgVl19mp4kbLe8yzJoj8
         KWnaSLAIV65nIZvPIeWfeXZmDUDRnBfPKdO/5fscq2vauabmRsdTk0qL65L5hl0Af7oE
         LCUKXjhIT6eDmk5pekSHtTp6R1flXEevUh3wiv5bU/WgSJLCRb0FNvmGn/zSpImUgCLA
         NsOfJAqF78QAlelmZiAte+zG8weF5tCA/wxzLi2lHyUvc9xL00ixzfk5/83m+n4PEnVo
         JIQdXal73QyyC3MLJ7ANip3eAFZHoN0c4PSP7wIpx+ntz2iZg0AGuijq8s08wkTGkZN5
         m1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753549; x=1748358349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibUebolwEMjE+Z6pNyKEAzbDAGWgUPaEEHNdhnwyUZI=;
        b=ZXhEWRYHv9w5mevv6KFFFue+SAla8cpeZSD5f6OS+pi1dOtj5HgFc7chrrbSbWnhKz
         Q7NdHXwbPKWHXYwvCbUCQH52AiU7tPUT+pH0WyMWKkgPkxiV3QOXr7xmeW0JUEIE5JWl
         AL105VO2DX0IsA131XkXbK7zAcrq+2fzMXgR2+UgfEsDLwgBkkSzgnXoHFbfV1IDh2Px
         6lDsygGT8G03TOygo/oUcUfiLwpeEQWggCXmEAJT+E/hxN3ZcDqM4JKTE309/MOmyU/+
         OMk6AZO2IF/nqfvqOyMYzh54e8Ied0ddTNdZac6AIeNpcAtvnoZRp7K2IIh0b2ceqwls
         V24A==
X-Forwarded-Encrypted: i=1; AJvYcCVMwWH+5IdU9pVRrDm1zTpWaN/zPJAu3TwBpIntKW4zHSfBfZpxaMCkZE4EaNNf//r51V2LRqrHkNGowyQc1Fib@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCSLoRynVOeBJSzQcf+hpc1wnM7jRnThEypn5UPVoP1DH93u7
	aP1XRe/FXeLvoz9ofndX3mBTtQwdtFYj8ZpbJQW+fd72WRmPjW9kDqXIVOFSbkYH1x0p5QB9zPJ
	Qg+OpzFAYxV5XUSkiqzxdPpSTo6qywZtPeVGMIZ8L
X-Gm-Gg: ASbGncvzv3cEENuwuM/vV8ZoJaV8WcUbj10NKqZ3tlBHAQlX2eWGGy/NGSY64Rz7beJ
	ndR1TDGfhSMQ4sVhzpaXFgKEKMm7onZqaL1kHXHOBy9ht1tfV2ab80eqEuV7yuti1lwuzOY59y3
	RYU4aTSC5UFlbTgEhJWiawktxIBsWh5xTV3GUMcutxe2yVX5lgAhrB24cd0/23j6gF0jjREsjSe
	PRhanXYaDk=
X-Google-Smtp-Source: AGHT+IHxc+QAaZDsoEVzK7lyUBIQFVHn9l84Ub1SvqyC4el96AVxFd/31UdI3Oyx/y0B+oiTrMcQitooDGBhR0ZsUBI=
X-Received: by 2002:a05:6e02:12c5:b0:3d8:18f8:fb02 with SMTP id
 e9e14a558f8ab-3dc5e611675mr9307455ab.17.1747753548588; Tue, 20 May 2025
 08:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
In-Reply-To: <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 May 2025 08:05:37 -0700
X-Gm-Features: AX0GCFvJjeIxiP_mev0L_EZph5roMRRNCNBjF5sRRQXzYAlUWj18t9TZo-lt6m8
Message-ID: <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Namhyung,
>
> On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c has
> > max entries of 512.  Usually syscall numbers are smaller than this but
> > x86 has x32 ABI where syscalls start from 512.
> >
> > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the middl=
e
> > of the loop when it accesses those keys.  As the loop iteration is not
> > ordered by syscall numbers anymore, the failure can affect non-x32
> > syscalls.
> >
> > Let's increase the map size to 1024 so that it can handle those ABIs
> > too.  While most systems won't need this, increasing the size will be
> > safer for potential future changes.

Do we need to worry about MIPS where syscalls can be offset by 1000s?
https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastm=
ail.com/
We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
calls of BPF_MAP_TYPE_PROG_ARRAY.

Thanks,
Ian

> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
>
> Thanks,
> Howard
