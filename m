Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6069202C44
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750029848; cv=none; b=AZKV9mOpcJTKZGrAd/CA7s4TYaCHZlCZVIBa907D4nt7wbT6ibg9ulnmpqFMmWJt8EvAskGpB/0b9SNNhkNrOqA/NNywll324dFhDru7srRXKV2rv+rEMWAuILqBogEoLL8ust6xhDL/W8VU3evtwwXVWc2UJ1fn6pMXiivliAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750029848; c=relaxed/simple;
	bh=vwMIuAyKRi8rXG370bSUkcKGMyY5VS4y4IUamLISfv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im9mp2uYmX3FKLQvXkz49/HBWBdu0vDq5VBIMc532of4pjvEst0DSVcbtnJa+V6emG4oNFClZsqUKc27/bNWeL71COropt9tJ6dOjTEgz0UhlV+5IHnm50Sm+HpP5LSVD/4xEpYc/V2rpX3oxBSQlJrGbBZLNHiSbXC6JgSU1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKrUHP30; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKrUHP30"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo222335ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750029846; x=1750634646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwMIuAyKRi8rXG370bSUkcKGMyY5VS4y4IUamLISfv8=;
        b=kKrUHP30Y27YwUqqSYSYgnzG9HJfJSl06Lg6zvcTSpmWmyO0qUBZJnzy04MzxORr0b
         XAoBPf4U+yEK9lrd1+31xPjOcnl7QLadePdf3Yv7/Vh/wxA0y+B83c31+HhMUWluw2FJ
         T/D0Vms75xFuC8T5ZS8YdGH0DAluYWgyAIc9Ndr/UDDfUamgyz+NyAHagE6LKTvsYkT5
         rnKC9WP8XyuoTz7zK2znIBaHBslBwLFH60ktZJzjRNrN8IDq/kru06ZX2jpNdDdySbTW
         reAgMxufHkVFq5S91OVmGDfbyppDolpg0YX0rXVJ8nrY4/nKw+zYaZwuTceZJhZpR4sT
         LZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750029846; x=1750634646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwMIuAyKRi8rXG370bSUkcKGMyY5VS4y4IUamLISfv8=;
        b=KUgbtxiz1dUBjNCJ+LUCKP9Z7y9szTIZH4zv7UX6ZN9y6LtCAJfbUav+VpkcmM9aQ/
         T9fsxKtpFiODP/JHU3XEh1KUryMgXxmVzKadvwpYNeldXoK4D6m+ATHwzI+ftXFpD/il
         oguatEClRe9EWeiZ8xYMWZ+USnDauC9Z3h7FsghL1VC/APzEissEC70ObyOCn+ijbsaV
         DLgdycFa/tZrIqaQbnN0FVVfEfTBNuSxz6RH1L8R6ptOfkDsq5IIAmVZ4GqzV6GrNdMs
         9TNuvcOYEeOGA36bcMN89SrRyyWAK0qSDwt9emkpiJckjbZXcgue8ZCij/L33qayc3bz
         gx8w==
X-Gm-Message-State: AOJu0Yw9iFK5EHvf4Bg+uuPdP9geJtOLLPHBku5dA8eR3gs+gOAtcqXw
	iOdOHqc/q2BrPtBFlECrMXiaAMSZql/cP1yf0KjR5QoqxLFLDMUrXkG/0FQ79w7wpWoh9CwegI4
	rNECe5SBJD0eysM/agT8tNap6HKqreo0yL8jR+dp/
X-Gm-Gg: ASbGncvVzEzIm1NNpi+dvCo+b1IpqAvcojvRjZ71zfxalf3m8iQt2xi5xXL649gEKLA
	9IwZHpUHQY4+y3MXDZgJ4IobyUOmBcuMPlKKcW9nMLGkukSmIHT4aToxqiw/IZX+kzk/e/XxX45
	WMyBz2q52mJeHBhj2LKmjskRHnIQIVItYkUab08zEjBEoO
X-Google-Smtp-Source: AGHT+IHu8qLD9HEoOj18ibGhNWjSZBHX9s4GQO6x40yzsPKDfCevdhx+NkMo0Wyi6FCsrSuva8xYXMP7pqXkBOO8AIs=
X-Received: by 2002:a05:6e02:380a:b0:3db:854b:9f52 with SMTP id
 e9e14a558f8ab-3de09fa69e3mr3029475ab.7.1750029845412; Sun, 15 Jun 2025
 16:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu> <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
In-Reply-To: <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Jun 2025 16:23:54 -0700
X-Gm-Features: AX0GCFs89st61cBzkl-ZMUZMQghK5-hsj_Ja7ha9KZv9FAVR4jDiUgtCHueqE9E
Message-ID: <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
To: Vince Weaver <vincent.weaver@maine.edu>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:57=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Dec 4, 2024 at 2:06=E2=80=AFPM Vince Weaver <vincent.weaver@maine=
.edu> wrote:
> >
> > Hello
> >
> > so the PAPI team is working on trying to get Intel top-down event suppo=
rt
> > working.
> >
> > We ran into a problem where on hybrid machines (Alder/Raptor Lake) topd=
own
> > events are only supported on P-cores but not E-cores.
> >
> > So you have code that is happily using rdpmc to read the data on P-core=
s
> > but if you have bad luck and get rescheduled to an E-core then the rdpm=
c
> > instruction will segfault/gpf the whole program.
> >
> > Is there any way, short of setting up a complex segfault signal handler=
,
> > to avoid this happening?
> >
> > In theory you could try to check what core type you are on before doing
> > the rdpmc but there's a race there if you get rescheduled after the che=
ck
> > but before the actual rdpmc instruction.
>
> Perhaps this is a use-case for restartable sequences? The current
> logic in libperf doesn't handle this, nor hybrid:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/lib/perf/tests/test-evsel.c?h=3Dperf-tools-next#n127
> which is a shame.

So I spoke to Kan and posted a revised perf test that works on hybrid:
https://lore.kernel.org/lkml/20250614004528.1652860-1-irogers@google.com/
Basically on hybrid before doing the rdpmc instruction the test now
ensures the affinity matches that of the CPUs the perf event can be
scheduled upon.

I do think that there is still a race and the race is there even
without hybrid. One thought is that an event may get scheduled on
fixed or generic counters depending on what was previously scheduled
during sched_in. The mmap has an "index" value described as the
"hardware event identifier":
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/perf_event.h#n632
and this value minus 1 gets passed to rdpmc in the rdpmc loop (as in
libperf and shown in perf_event.h). If a pinned event were using a
fixed counter on certain CPUs and the same event were being used by
rdpmc on all/any CPUs, then the particular counter used for the event
may vary causing the index to perhaps show the fixed counter but on
the CPU the rdpmc is executed the generic counter was scheduled with
the event and should be read instead. I think something similar could
happen if an event were deleted on a CPU between the read of "index"
and the user by rdpmc. Perhaps I'm ignorant of the inner workings of
the user page and scheduling, but it seems a restartable sequence is
needed to make this somewhat atomic. Even if it were in a restartable
sequence I think a remote delete of an event could cause the
counter/"index" to change while the reader stays on the same CPU (ie
the restartable sequence needn't restart but the counters changed).
Perhaps there needs to be more "buyer beware" language around the
rdpmc instruction in perf_event.h and associated man pages, while the
perf tool should avoid rdpmc due to the need for at least thread
affinity calls.

Thanks,
Ian
