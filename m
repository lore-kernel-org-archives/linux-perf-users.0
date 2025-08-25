Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F23002A1
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142672; cv=none; b=D0PqTdRsfYHhYYKOIaWakn/HVF0/LlaRhqS9NEnhaRfcH1tus36AKKcmLv5Na2HZKz2IekB0PquesNvBkrexI+Ly6Q1xGQEwJmrLPNbjSNrN+368U8VxjdtwYbcA3NBJ2MEwfdfiPG4dxyZkzRpe6RLQB+jIxHhSN132Yi2Lj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142672; c=relaxed/simple;
	bh=XhWDg/JIuuCQd4L0mouLCvJf2fOoYTh89nNKKlrcIks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcHoFurxhAI92ot3/0+GUDy9GK6+42OYOPsV9x0p/WLjf2ABzaeSz4KYws4r/l7/1M0dl5BHdiE8F8Rx03Ik6ebgDi7vf4arstXHSif8k2IbjdZpSLLJIshfjjwN5BMZtI8D6AaWqQj+gyTzp0LFI+9dQ4jbNMonPJycsBPDNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqBMoMH3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqBMoMH3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24611734e18so11465ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756142670; x=1756747470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ORHuStfojgrwK2UdFk3EZ3mv0VOd3rvM8MRoO+GpXI=;
        b=ZqBMoMH3S6ZPuEe9tUZqj9lkCppXU+moJ8aXG/BIvG60yjE13UlCQJZqmZye+0gWVH
         7nfK66BmihQigXkDOnC6zHV4hO6mx6qP2wzRn0yidrywrVie9YRC7JyalSL8T0bTBZrN
         xj79pgBrMz7rhK7J9YziWgsuKcz2FtJHZYvpnaFGYh+jfjlnR6vLaq1Ko+CQ3gnY59d8
         uI/0RayazQ2adBsLnVZXVrmWpJlNSolShOGXJm3nyUXKCjWukim/q0IcKAPK9y6bKj50
         JWieqEx+gv4V9aIZh0u71elGBIurRNPEhg7HROmL6/lK4SGrHqg1zIdf4x/xiLd90ODv
         +6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142670; x=1756747470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ORHuStfojgrwK2UdFk3EZ3mv0VOd3rvM8MRoO+GpXI=;
        b=GC20XSiJWHNUMSs2SVi1+Tu3E2fXAT7TyjgDQ3kZpLVYcfLegfx+CirB9VytEp6jbr
         4rpxN3LXjeikMfhI1HIWLknjnr87O+ZKAgDnJIxhhctkwEcy39RL6H2qRKCbo9Nrodf7
         KCzyOLqirvig69u/VHgf0sTzQXf4ow1bp6u/58wgqudah2PewQzhBrvxfZlmaWm/IkXb
         /vLdLS4r4i8010/3oL1yNDF1IaEWQVSim7AvFpvbx4viKapYHYV/IXHGwX6UIGBFJB76
         MO7Nh/6T7oT8f3bYQtn7ZvhANRKFJ76ciNEUji+Dw6kFgQu8+I1kHsbd5eBJ2LAg8rD4
         wKYA==
X-Forwarded-Encrypted: i=1; AJvYcCUNb46RcP7E5alZ9LJCQu5gPEwziFqmCEm5FG0c9Nwum9HdqSgQV56aky+CNyuVKjmugp6cCbFA6IHxSVShZDlz@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfpP7/c8k9Gcijg8h/gF0SB8SFqWOkw3SSP61HVNLWnH91Eaf
	tpi09GVPOPynjYG/Q0HrcJnMAHyQWft99uhjZBKE4ZmEidKEFAlsjIZK6O5SWQA0C+kh4qfF+Bt
	O6h9XI/mUYJ2t0TU/gn3vywrJ4jyLnmPM1K0yjs/H
X-Gm-Gg: ASbGncuQQJxjNaJymG3Jum+BhbbdeU2s6hYUjRuH4jmYFCaUdoPc5tHgYA0Of00KnwQ
	1s8aJvcBHQcl/teCaPWxiBai+ceMZ2fuFU1MNTRBu4GR8+3f/Qp/7q6szyUT1bhQxSchlagGf5G
	7kY2vXRdy8ry1o3VgcOfSGK4CqksfxAvt76SalC6liZNnmSJUjla3sadhxKrVuYxnxX/BR7IFRI
	fShNrz8zx68TgBpW305x67xPBYnTQXj7JxJuR8R8c3v
X-Google-Smtp-Source: AGHT+IFDSFCq0edWCtHzT5OvxvY5tWpWD1aTjc3Lol46yrNUvieLKtXYNl0Pa+8dgZxjSHXFJ/lZHYpA827qlGdI904=
X-Received: by 2002:a17:902:e548:b0:240:6076:20cd with SMTP id
 d9443c01a7336-2467a3cf14fmr5726415ad.15.1756142669923; Mon, 25 Aug 2025
 10:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815182742.45541-1-suchitkarunakaran@gmail.com>
 <aJ-ScOp3ZCG6PQmD@google.com> <CAO9wTFj7S7G2bqbiuKbR+o7Y0u1EkYY5GsHasJZLmAo5ZuCx9w@mail.gmail.com>
 <CAO9wTFiJmi7YzeukT0VtnpqcJcE3sSueO3owYUAd+H4wjcYZeQ@mail.gmail.com>
In-Reply-To: <CAO9wTFiJmi7YzeukT0VtnpqcJcE3sSueO3owYUAd+H4wjcYZeQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Aug 2025 10:24:18 -0700
X-Gm-Features: Ac12FXxRIuAN942liX6eW3sy6FarCbSuSJ3avU2MB-V3vtAsi5N_-7cGnerDC44
Message-ID: <CAP-5=fWCGa+R1O2sL1anJGznkprQyP2RrsUZfzmrPJ2y-WsEvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf/util: make TYPE_STATE_MAX_REGS architecture-dependent
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:17=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> On Sat, 16 Aug 2025 at 12:16, Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > Hi Namhyung,
> > Thanks for reviewing the patch. I'd like to ask if there's anything
> > else I should do regarding this patch, given that it's supported only
> > for x86 and powerpc?
> >
> > Thanks,
> > Suchit
>
>
> Hi Namhyung,
> Following up on this patch. I would appreciate any guidance on further
> actions needed, considering its current support is only for x86 and
> PowerPC.

Can we just make  TYPE_STATE_MAX_REGS 32? There's no reason to assume
the architecture the perf binary is built on matches the perf.data
file being processed by perf annotate. Given 32 is bigger than 16 then
this can just be a maximum value (a comment to this effect in the code
would be grand). In general, the use of the arch directory and things
like "#ifdef __powerpc__" are code smells that are going to break with
cross-architecture profiling.

Thanks,
Ian
