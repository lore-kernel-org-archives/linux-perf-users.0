Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8832E69B
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857292; cv=none; b=ivrfUgSpW88whxUike5qu7RSoE87NgN+tou1KLlFbBoOoHofVGzUeBOG6ZVaHPaPJ6DK2MCn7jqwjki1ipQ4zRHtIiZwD3QOsNO74Ilpx0Eb9ZckYBEGvV67+TLQOuMyyNGrWShDC9OCMtEZRgHgON5rVPhBQzsx7qiNfnHiDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857292; c=relaxed/simple;
	bh=Fz5PXbsNrcSaKnNALENxX8MfnuZdWTAdB2j4iUi4yJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl88brIq8oVv2vlemuf3C43pZxhXYX+sbzdI3I3FNy/ihwgSHwdrkWrFY2waUhgteBcSWejpm3cAGY9Yn6uQRr6uxctukDaE/qz1vnClRk5Omy6q0AvHAFc2SyPYuXbFqhN/u3YIh10mXD5rXfNqiJZxccSMCzkQVJebOOQXOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iglJxxgx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iglJxxgx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eeafd4882so56785ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761857288; x=1762462088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhQQ7zOAq6MhzCKRAcJwq7qvtQnnnWF1CQoqWqCYdV8=;
        b=iglJxxgxkBV/TCOnMqRI2i6sStNm1aESmgUF5R4eFsza/TiP38+B5N6gjsAlpRzsx9
         Nk5e6ct90vZ8V6cMMxeFrqLwdWZk9LrbPgMSPSJrHpm1y8lqHsQP3vIuTHmLB4Iw9lEH
         on+8d7aoLA9NCjQUKIc6GIQYA6pTVhRGYd9u1Ktgq1Jcjw7DhneDi4pqdhB3nKnjNOnJ
         rlruaNxgufr4i06tpvxMTgPyde/QhWYIadYqhFdOaKBahnfuqK+F0Zu3bGc3AdBYv/qO
         6d+x+Z8Z8+aqd0r52Cn2eJIMpmt7OEnIytwMAmPYaOwfZBqWGQYPvVUX0U8wvlbs8u9U
         TFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761857288; x=1762462088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhQQ7zOAq6MhzCKRAcJwq7qvtQnnnWF1CQoqWqCYdV8=;
        b=KNC6qbmNeCevHKt34aaRjN5o/dTe97kVCuFvQxzfdmei8Z/O1gxg7ndt7pLPOYWB2T
         Fuk+hSwKik6cF/p4FIkNBRxiyAnBOhFdmOl4ScYu4aX+50v2dPebdg2K7JnwlQwqndav
         R50PS3scoAhOzBNz8TcJ+Kb0ABaJXvpSH+VVw0vAOyWxxiVD1SEz3lpRYVEnC/NiLMH3
         R9QzA2Uz+p4STMoBx6A4V3mx8RxxQia8P1c+LZKktZuWg/aMBbIhdQxwninHWoi5NgbW
         54Q3pvA7TKUo7kXI/uz3h7Bjv+hJJouhznLHl70rLwe0UDGymyrl7/GhKd0NCqHsW16x
         j+FA==
X-Forwarded-Encrypted: i=1; AJvYcCV+2unSOlcSpuZ7wNxd0eoc26hNCha89Ml2PxQAUHKGE85TyUXRL8qqBlDTIL78OpzcExW4oVV/QXrgq+ey5ukk@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPRmiqEj4M0N992TCDhX82mQp1chRUXCHZv2a8nRE9lUMpVpG
	NQlhR9viNXPU5oNpBaCvuqfE2RjXHy0oEhBIoe15SOBPClgXUBlrzanDRnCCvUj2SJIFRgc4kPq
	GVv6TE3suStEz/PIn2zizpMUSzc0xzZSxQz01AhS5
X-Gm-Gg: ASbGncsEeDj02n74JqGndIcfQjUoS96H8gnD2Ll9Zh6GAoYBkqvw0COd0OzZ6BkFHZM
	RhlbIAqFl19HsCRUobGqgy6nHDdnudot3/HOFjZiplrPmK5tDJEXwSeGzYnF5BOaU8hBCSz8nL6
	ZuGLXPrMMbqu020W7zsqH+eTv/ZzhydwEEICTq5R5Ny8Aj2Uo5IPqVf5vM76ywn7Ptb8PBWp5aJ
	0HNtqTt/AdDSJ4xvJmsjCHxUkYITpGhwirGXTkrdS6PqqVioAN1Hrw6c1Uwc0OT+AzudPUVplwe
	DPgKzji6bepTPZCRg5yVRFV4
X-Google-Smtp-Source: AGHT+IG7DYT6OKhAgWj/D9qPmgJi3LlzwZ4lb9oX4EL82poH9qsGt6wZSc55m4UfN7seDtJR27dorjECISDHYLslg2E=
X-Received: by 2002:a17:902:e887:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2951e61f5a3mr1155985ad.4.1761857287361; Thu, 30 Oct 2025
 13:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
 <aCz-wD2Syq8mj2_0@google.com> <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
 <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 13:47:55 -0700
X-Gm-Features: AWmQ_bkd44FjAB5SigD6PjGDXSbK6BSfXlpCgpsX-KWWmt8cQFNDhZMfuF4fPug
Message-ID: <CAP-5=fVBXUeEH2oi6NU2Hs5GCBUqW7BMVUJ6=LDTBfmb=xoL3Q@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:22=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Aug 21, 2025 at 9:45=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, May 20, 2025 at 3:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > > > On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95@gma=
il.com> wrote:
> > > > >
> > > > > Hello Namhyung,
> > > > >
> > > > > On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > >
> > > > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf=
.c has
> > > > > > max entries of 512.  Usually syscall numbers are smaller than t=
his but
> > > > > > x86 has x32 ABI where syscalls start from 512.
> > > > > >
> > > > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in t=
he middle
> > > > > > of the loop when it accesses those keys.  As the loop iteration=
 is not
> > > > > > ordered by syscall numbers anymore, the failure can affect non-=
x32
> > > > > > syscalls.
> > > > > >
> > > > > > Let's increase the map size to 1024 so that it can handle those=
 ABIs
> > > > > > too.  While most systems won't need this, increasing the size w=
ill be
> > > > > > safer for potential future changes.
> > > >
> > > > Do we need to worry about MIPS where syscalls can be offset by 1000=
s?
> > > > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@a=
pp.fastmail.com/
> > >
> > > Argh..
> > >
> > > > We could do with a map that combines BPF_MAP_TYPE_HASH with the tai=
ls
> > > > calls of BPF_MAP_TYPE_PROG_ARRAY.
> > >
> > > Right, it'd complicate things but I think it's doable.
> >
> > Should we merge the x32 fix while waiting for the hash fix?
>
> Just a reminder that this is still not resolved.

Ping.

Thanks,
Ian
