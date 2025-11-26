Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEB271469
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183675; cv=none; b=XWu/r0hhu80i1oyzMQ0fQmQP/4eLG+1g5aYSYNtAJlo6AfhuCxTQr1Efrrx5BuHY1DSAI2md7SYByvx83uiU2AxKKPPaubIhoPmcR1VTMwA9QcA4t8OoBdRchH8BY3jfl7wwrowOcJPC7tfpZqDORv8X6U+qMRkTsEuRjCPHUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183675; c=relaxed/simple;
	bh=NL34pD8T4V00Vzzl+/Qr2PvsfK2RCcscZu3ICWTHDPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg4xokXjGomQAbdr4NeW6FuAL3kmPpWAQB3Eb1jYgep+01azI0u8w3fFeyxAk4tDChtX5tiiPEh34VW7hFjGrmrXsRcZtVbkcb7IkCyWnVhY7P/WfQDMTKzD6VhNmsXUoKLTnzKPoUWUC1MrQvC6vWlMi4wh1ylhwvuhtQGmCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loaQ73Lb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loaQ73Lb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b3016c311bso7872585a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764183673; x=1764788473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9olSEKmUg2DoH3BJkC4PHVJmILXcxuZR8suDptjbXkg=;
        b=loaQ73LbPfNDbbyWUhxsWaccrEL98o4Bk9aKPs5BJ/jPYOgYteY51gmmjxYrF1teK3
         qbqTNjjhkgDCQ2iMeR2j9hasQr4J2z6JQ3W86fq/DLQY29WFEmuzUmfOJoEYMUtOxzt5
         lasjsNIH8OVBMNYFJe4ETx6icKZRu9tJWrP81nhxew0HMy7kon9SFz7AJy8njUgzNM01
         jJnzjxD9LpxL1kZgwC1rhoVoVlRL0Gvs5HOzq3+LmHpNitInfjdVPUSZBlql1Hsy7MYS
         izMLHFBDTdZUOkm5sz6Z6L4oZ3EOaaOTqEPsjMHa6QBqflwAW8zpzYv4sMPvOQzoCBOF
         nG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764183673; x=1764788473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9olSEKmUg2DoH3BJkC4PHVJmILXcxuZR8suDptjbXkg=;
        b=Wex6v12c4l7L5E5HW9TsEi2aEo0Oox3UulMGomq6HTvGUF+ENKmo/upfG6mKBExn1s
         7WtuDdF0W+WS5eZxeLs3YfpH3FfQ+k40ArB0jeOUinMxLYKiNkiG0eJnzKZmim5H9vTc
         w6xWtnfFGPvuc9VAU/gW/68t5jFtkbAS/w3P28IP7Jnxx4hBadkSU3jfnK4iEH0zNR50
         5xTmZoWf++nS0J/x8frPiL4k2Sn9GBiDMSzlvnXcuy1SpTq2wdLsK62zqM9tfLK6bG/X
         dn+Rsl54o5vTA6UAHQbPaPtC644osdAx6XIHl9v+Lhm1uLlvClorbfRiY3YQ2xBGWp/+
         H5nA==
X-Forwarded-Encrypted: i=1; AJvYcCVs6086owqQQaHUp7zbwahzuCtEFteqczJ3FpR/DWV5eygmcO1mn3rQ2B9VCbfB+bHYJt7L9FvKZjGCiAVlzgf9@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZQh8vfE/plp9MRcvHvPDiXfQLYsygujH0CJ38P4ue/gw44mB
	0LcSNDxnzq5l76SL/w/oGwloDlvHw+zONXKruaEVoP6WFXATSPBUrDNtwiEZ2e0iW1fvIC8ipfM
	bE4OCQ+PJ4RRGpZpi3T+tXpUTLY5Pa4Q=
X-Gm-Gg: ASbGnct3Z8575LtcRqoRaiN+9GdzIRVxQTfaYz6N8RPMEtzqu3+RSx0tWzscI3OQqiW
	uhzkX8j17RpbRv/gzjF3/+23JSDo1oB/iubgAdYd08pBNM9RIH42Za0y8c5JbzItQrPv22gOBRl
	tp+vTtdwhHMbqIKMVBtWr7QT057BGTLI0y9dFidV2MnvxxzXdoP5bor84oRdeNBz3/W0dw1gF+a
	dPaTjfd8ub+TDyinCFFUKBpp6Wv3y5yM5wIbAoNG6fILuNh+IDECEUkO3krDMSHGy3SJ2k=
X-Google-Smtp-Source: AGHT+IG4lMOCibB3xzn94c2hznIJFr1UtmXTtjH3mj3s4ig5rqGWjzJDEXka6fS7dx4D8DrQHjiL2yRwRkQGSbtzW/0=
X-Received: by 2002:a05:620a:28d5:b0:8b3:aa:f61d with SMTP id
 af79cd13be357-8b33d4a77famr2884287285a.49.1764183673026; Wed, 26 Nov 2025
 11:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRvSv03cqarM5dY9@google.com> <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
 <aRwVifZ_-7puFUVC@google.com> <20251118132451.29a35127@gandalf.local.home>
 <aR1JXlhJ8rC8Ujb3@google.com> <20251119125903.417f595e@gandalf.local.home>
 <aR5mTLRWA-SLAFUM@google.com> <a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
 <20251126102401.37af98bb@gandalf.local.home> <20251126121229.0638407b@gandalf.local.home>
 <aSdNiF2VZMtjQnUQ@google.com>
In-Reply-To: <aSdNiF2VZMtjQnUQ@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Nov 2025 11:01:02 -0800
X-Gm-Features: AWmQ_blDXna8aYwwz0QjzlA-7bZ22wVZAwET2gWg5CMksczKVoPZReS2q9UbnzA
Message-ID: <CAH0uvoiB4EFu4x_87cdoU5DezKcGXyT8OEhrs0qNYW7aDktgnQ@mail.gmail.com>
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, acme@kernel.org, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

On Wed, Nov 26, 2025 at 10:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 26, 2025 at 12:12:29PM -0500, Steven Rostedt wrote:
> >
> > Arnaldo,
> >
> > How can I make perf trace not confused by the extra fields in the syste=
m
> > call trace events?
> >
> > Ftrace can now show the contents of the system call user space buffers,=
 but
> > it appears that this breaks perf!!!
> >
> > system: syscalls
> > name: sys_enter_write
> > ID: 791
> > format:
> >       field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
> >       field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
> >       field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
> >       field:int common_pid;   offset:4;       size:4; signed:1;
> >
> >       field:int __syscall_nr; offset:8;       size:4; signed:1;
> >       field:unsigned int fd;  offset:16;      size:8; signed:0;
> >       field:const char * buf; offset:24;      size:8; signed:0;
> >       field:size_t count;     offset:32;      size:8; signed:0;
> >       field:__data_loc char[] __buf_val;      offset:40;      size:4; s=
igned:0;
> >
> > That new __buf_val appears to confuse perf, but I'm having a hell of a =
time
> > trying to figure out where it reads it!
>
> I've discussed with Steven and concluded that we should change perf to
> ignore fields with "__data_loc char[]" type in syscalls.  Let me take a
> look.

Thanks, I'll also give it a look.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
>
