Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE463093D3;
	Mon, 25 Aug 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146115; cv=none; b=Frhrevv+wSnDeX3cjlBJF3ySB5V3G4muy0LHdUGjqBZ9QdqZirpqqkYY/oPEvr5v1Tfsaf838QES5lJsjvdsajwRWowkiMOckcA7aY5zZxKQhyXr2znBjYYazE0zG9YDiDmhlhDdL3KAyLivjmFUnIurN99fidE3cpicWEouN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146115; c=relaxed/simple;
	bh=3ZrmaJQHNqz7zB3hYmPFkkTgMYcKXhVHt6LgmcyEGLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHa2JAgkwY3ZvpGtK3ME/L+o4JIXFHuJ1Tn8t5f8aVFCWfYzb4A0aloE5J68CLSfUPBu7uc3duZIoox6xaiT/86opt72efoszMCf4k57dZ5haQI/pEDQQL59gl5LTZcDY+MHmeiev/qzq1gi2QGOtnXbijdQ01FgT1Bn4AftQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPsz0+wy; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPsz0+wy"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61dc69c02d6so568957eaf.0;
        Mon, 25 Aug 2025 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756146113; x=1756750913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBWcU3cSWIrOv8SEdohQlNa+9rh4cGJiQvp8mNokO0E=;
        b=PPsz0+wyO8q3NLTkfoSOUGGoXKvLRMX6NFpw2K/Ub7gffZyH0P+BtaIg6nuwKQ64TO
         mslfRTzIuS7VQdlIJQ92YJ1i2eYa0HeN4FwTzgnDCIjzbjkG5+25yDeCZyiVirGUG8+F
         EMDoR6XuyTMizpBjUIXlNYdGB6NB2oGhg0c88/a8sq33jDa5nTi6+Cid/vRnMTuedPDJ
         zUJm9yERL9dS9/4pQ11D0OhoDvmXRQpMWM3CPT0s69GxzgkvsMLAIn48qd8kTYREH0Bs
         ay7V8NmB97lB3UvKSPOr8ioRiNTNn2XnkEvJL2q2PicH9Zh+teQ+OByjodM0xdpNb3zF
         hN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146113; x=1756750913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBWcU3cSWIrOv8SEdohQlNa+9rh4cGJiQvp8mNokO0E=;
        b=BdltmXo7yj7FAsDlaQPf8uo/AdGujxVb2dvILXIceWEU4N4NN+wkt37EWVqGx+slp3
         WiQNd63FFv/nlB6kVDKYID0GKHBqHPFiIMX6lUbwmhriXzdqnHztoM4Gk2yWrtuAb6Xi
         iOeO6+Qek7MqooJik8gZJr4aI6Smd5npFcaG3xiZoQX0dGq2HkdCWjbtYtSI4nqtrPe/
         5cZ/nqhDhPJhJ445FsiAxLEyUot5cPs63u6w2pddumUCnzL8XGK3/7Y+6p9e9+TRmXck
         uskiRFIB7BTYyTMmC1/1EMXhMnX0JURhZvapQjjlXkxbnzUhnhHLmeZJJoU7dzrKN3sb
         Ijjw==
X-Forwarded-Encrypted: i=1; AJvYcCVvk2SY1M4pfkAQ4lf9nq4IhBP0giG/GSwHFWleZUuFO4aCCrw55Ga+prCt6VK95b++dzS5AduKcgFeY6Bn@vger.kernel.org, AJvYcCWirtriPOos+45hm53cYN3TPxCuINL3qXwt2g7/KXzUAd9GzuHBkoL78M5BeEnxmjXjqvCdlBed0xOKrr7pcXy9lQ==@vger.kernel.org, AJvYcCWmREIckjYmgBFAOdeI6/+yeBYDyTJ8/QRaQbBb9Xudjo0PACLHho5wLQA6ar1HPupjDBu/dBktr3ay@vger.kernel.org
X-Gm-Message-State: AOJu0YwMixQmsHNYEA7zQLoOfoepV0O4odV4a0SvHXqq72XayNuN+Rax
	G0SLmDpJ1Lp6OuYqryUyYM/lQmSTVMDLLMYhQpxRZ710AA7afn0gFVQrP7O/bMJxGnZFRAznpv+
	2aRPnUHS/stkNUIqiOhPrkxmqRjmsfuw=
X-Gm-Gg: ASbGncusXVz+w6qlq9hGeDMj/Ul1HIyUfi+l+qGiecd4ODsB9qShVMC0u+bUoXWS7Vr
	gLzRxgJaUP6ZeoAdVODBpz1pePRzDOP08A3GneZEIDRz3GXyRrz6R98NgKSApAb8vcGdmSwPIJa
	7c6Ta/K+r4zQv4A9R/0RqRWs07YjXEBjd7+xJ1X7s5oWBK56H+kx1GgDP8AoHGdNCvf8s1zio62
	rbjuAUiqA==
X-Google-Smtp-Source: AGHT+IFskHmvwXj8mMcFosVYtY+vw+7NM41X2/qi91Cw233062th5AEOuPmRoCdCeKroHQKACJ9/26YoouKPLyTBfJI=
X-Received: by 2002:a05:6808:a586:10b0:437:b094:383c with SMTP id
 5614622812f47-437b0944231mr1150598b6e.2.1756146112878; Mon, 25 Aug 2025
 11:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815182742.45541-1-suchitkarunakaran@gmail.com>
 <aJ-ScOp3ZCG6PQmD@google.com> <CAO9wTFj7S7G2bqbiuKbR+o7Y0u1EkYY5GsHasJZLmAo5ZuCx9w@mail.gmail.com>
 <CAO9wTFiJmi7YzeukT0VtnpqcJcE3sSueO3owYUAd+H4wjcYZeQ@mail.gmail.com> <CAP-5=fWCGa+R1O2sL1anJGznkprQyP2RrsUZfzmrPJ2y-WsEvA@mail.gmail.com>
In-Reply-To: <CAP-5=fWCGa+R1O2sL1anJGznkprQyP2RrsUZfzmrPJ2y-WsEvA@mail.gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Mon, 25 Aug 2025 23:51:40 +0530
X-Gm-Features: Ac12FXzIW-t6fPYcoU6IlBmEWamOsApUN_OzhHIIlmzKU73aQg7rHJYgARuUrvY
Message-ID: <CAO9wTFj6o=ESbFUZmk9xAoMfGfUcCX7rQmaBzLyaPr6wNEotfQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf/util: make TYPE_STATE_MAX_REGS architecture-dependent
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-csky@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Aug 2025 at 22:54, Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Aug 25, 2025 at 7:17=E2=80=AFAM Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > On Sat, 16 Aug 2025 at 12:16, Suchit Karunakaran
> > <suchitkarunakaran@gmail.com> wrote:
> > >
> > > Hi Namhyung,
> > > Thanks for reviewing the patch. I'd like to ask if there's anything
> > > else I should do regarding this patch, given that it's supported only
> > > for x86 and powerpc?
> > >
> > > Thanks,
> > > Suchit
> >
> >
> > Hi Namhyung,
> > Following up on this patch. I would appreciate any guidance on further
> > actions needed, considering its current support is only for x86 and
> > PowerPC.
>
> Can we just make  TYPE_STATE_MAX_REGS 32? There's no reason to assume
> the architecture the perf binary is built on matches the perf.data
> file being processed by perf annotate. Given 32 is bigger than 16 then
> this can just be a maximum value (a comment to this effect in the code
> would be grand). In general, the use of the arch directory and things
> like "#ifdef __powerpc__" are code smells that are going to break with
> cross-architecture profiling.
>
> Thanks,
> Ian

Yeah I agree that setting TYPE_STATE_MAX_REGS to 32 is a more
reasonable approach. I will send a v2 patch incorporating this change.
Thanks,
Suchit
