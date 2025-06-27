Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A642EA72F
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042659; cv=none; b=YQS0ec9tqAi0+rW7gS15HxuXnsL+Lpi+RHVEqkGTN3kZBPQItcM6osN/dOpCjnTrHJvT50JGfHL3m9KCGXaB3PUDrSxFs4EuSZfhf0JvF8+AMLtwY4So7+TF+q7TZQVbNXvqS42zgcxsTp9o0czSpxiTBvbbDcnPy7O8o9d4F8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042659; c=relaxed/simple;
	bh=9s1eA5KwrVKwd9rWss4PkqOIrDE9CSV2z3UbUlBIJKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHZuna9DqYSP33GYU6UVq0RxXAMRJsXsSTNWVzKfsuS8oNVhjdAdjJ5rXq1zjbnsyZKrTk2fI+IfVnsLl1YgG/+TvQj5ktSxcNdQuxX1W5kUV3IqrO5SHEBq1/gcorq7zhWsel+dYl01m7TpxSD1Obp+4ALIGEFtEdtTm1NJG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jq6rD8SK; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jq6rD8SK"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3de210e6076so2175ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751042654; x=1751647454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s1eA5KwrVKwd9rWss4PkqOIrDE9CSV2z3UbUlBIJKE=;
        b=jq6rD8SKGMCuNrME36sTI/KFxTM6BEo9gz10KGTulZJX15CnBpQeqPwEfLgn7UvNM5
         z5eYtyWDfBRa+paGJaoZrIC0+xhm/fixddafEGda+guF9nWAEK3SqurXBqHh99Fx5XnW
         h3OuI80idTCaK0tp9DnCEktDZWr8eRJPpa1S+8RX9gtYeXOw7lk9ofRil0r2suRga7Fo
         JuGNUv5p8OtosmXC/4z0UQ3YZkS3Mmk0ea+XSJnvu20K+8BRtR3hlFxW6QGsTlHzHOUZ
         qgGlHEVwanPmkQBqpnqpH6vRV3S9M6B3ZfqQGQd+fHUu2qROuwUtF5NpJbpI2/ssibdS
         y+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042654; x=1751647454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s1eA5KwrVKwd9rWss4PkqOIrDE9CSV2z3UbUlBIJKE=;
        b=o8db7CBMk5E8BnZR+Ul9gWFFpi3aMDegWz/UxRfOKnF7HZOap05G5j7dhmG7Q5cWnk
         6Wsf/FeDCNhlH7gra+AlitoX4Mmdug7Ik3w77bkRFGGybBOvvD7DwD8+eH/GHnixVp9B
         omkXAPguRajISNDImvonk68OL+4hEYn3YehblLpB4aZPLGSxn7RkYXEfTmw9QbuRCVKK
         bm8cC/we5LyL0g/ZzYlm7tmdHYk2KLHt0ChFhZdeYr7Il4W0pclCPwf+P9DcYx6fWftp
         8DmZVHFqsigPk3VLHBDEBC5HaYQj/Fy67mJz1AGigN44sT/9rk263hQaVJmqAhPVxtfn
         KjgA==
X-Forwarded-Encrypted: i=1; AJvYcCWk7MoctHb84IlCVtr3QE9ieNIAPog3UAHvkQX6phtqidBi4QjEyjKPjMZjbsJUjROAEC0Txq+NEPWeynsYLT1j@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0Up2XEKHUSIl6QzmZf4r89IrswVq28YndfYK9BXsjqgYGTJW
	MEL6rSjxz799Ny1VxS8hEBDtbOshDC1WuhJI4XB52iAXwYniw+EMsRoeAkugKEQH70hhcRtvMOp
	19B0xjirhIDWVA9yWMSlVxA21sTkNVB7TVeb2ItLY
X-Gm-Gg: ASbGnctmTlcjIz8pYr2e8iwTVA0uhOCy86pDVxy3IG7Jz9TI/K5QjOjlkyPonTtEuJd
	2u7HEYm3YyIfyrPeHMQA8yXvraeIKP8Sr+LL1n7rPI20WVGv52em6CR1ACfD95+C2tL5w+XlaeH
	3EbrFO9n2rThLI2PlQYWdTRNdD7Q/6WTVjruXjLuKOmNQP
X-Google-Smtp-Source: AGHT+IHvztp7L1kXPm4qHzp2aVdvq9iPLHibmjsOFDZjxgx47/40qOE255pl9PfqbsmBA2gt1yngKEvvPvtuRKfJNak=
X-Received: by 2002:a05:6e02:1a68:b0:3dc:88ca:5eb5 with SMTP id
 e9e14a558f8ab-3df53bb8ab1mr524965ab.1.1751042654180; Fri, 27 Jun 2025
 09:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com> <20250417230740.86048-7-irogers@google.com>
 <aF3Vd0C-7jqZwz91@google.com> <CAP-5=fV4x0q7YdeYJd6GAHXd48Qochpa-+jq5jsRJWK36v7rSA@mail.gmail.com>
In-Reply-To: <CAP-5=fV4x0q7YdeYJd6GAHXd48Qochpa-+jq5jsRJWK36v7rSA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Jun 2025 09:44:02 -0700
X-Gm-Features: Ac12FXxK697QImT-ty4XbntVKcoV6r674s1RbV5RKCu1qYoOEhu-OUGYgs394-o
Message-ID: <CAP-5=fXLUO3yvSmM4nSnNV_qQGGLP_XTcfPgOhgOkuaNnr3Hvw@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:53=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jun 26, 2025 at 4:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, Apr 17, 2025 at 04:07:27PM -0700, Ian Rogers wrote:
> > > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT=
,
> > > support dlopen-ing libcapstone.so and then calling the necessary
> > > functions by looking them up using dlsym. Reverse engineer the types
> > > in the API using pahole, adding only what's used in the perf code or
> > > necessary for the sake of struct size and alignment.
> >
> > I still think it's simpler to require capstone headers at build time an=
d
> > add LIBCAPSTONE_DYNAMIC=3D1 or something to support dlopen.
>
> I agree, having a header file avoids the need to declare the header
> file values. This is simpler. Can we make the build require
> libcapstone and libLLVM in the same way that libtraceevent is
> required? That is you have to explicitly build with NO_LIBTRACEEVENT=3D1
> to get a no libtraceevent build to succeed. If we don't do this then
> having LIBCAPSTONE_DYNAMIC will most likely be an unused option and
> not worth carrying in the code base, I think that's sad. If we require
> the libraries I don't like the idea of people arguing, "why do I need
> to install libcapstone and libLLVM just to get the kernel/perf to
> build now?" The non-simple, but still not very complex, approach taken
> here was taken as a compromise to get the best result (a perf that
> gets faster, BPF support, .. when libraries are available without
> explicitly depending on them) while trying not to offend kernel
> developers who are often trying to build on minimal systems.

Fwiw, a situation that I think is analogous (and was playing on my
mind while writing the code) is that we don't require python to build
perf and carry around empty-pmu-events.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/empty-pmu-events.c?h=3Dperf-tools-next
It would be simpler (in the code base and in general) to require
everyone building perf to have python.
Having python on a system seems less of a stretch than requiring
libcapstone and libLLVM.

If we keep the existing build approach, optional capstone and libLLVM
by detecting it as a feature, then just linking against the libraries
is natural. Someone would need to know they care about optionality and
enable LIBCAPSTONE_DYNAMIC=3D1. An average build where the libraries
weren't present would lose the libcapstone and libLLVM support. We
could warn about this situation but some people are upset about build
warnings, and if we do warn we could be pushing people into just
linking against libcapstone and libLLVM which seems like we'll fall
foul of the, "perf has too many library dependencies," complaint. We
could warn about linking against libraries when there is a _DYNAMIC
alternative like this available, but again people don't like build
warnings and they could legitimately want to link against libcapstone
or libLLVM.

Anyway, that's why I ended up with the code in this state, to best try
to play off all the different compromises and complaints that have
been dealt with in the past.

Thanks,
Ian
