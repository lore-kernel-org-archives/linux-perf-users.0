Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D657213E6A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474310; cv=none; b=BHWDxMg4fnB/siqyUOowgaYvqzvhRnDb6CDHGgzsCszENP6u1blzHg9DCILcVAkCk4N2xY5Ti+mpenLZecfbnPkCNLTnDR3HqKB7LLNcLMA/hAx+qAABOlaX2KBVDqsEOpG1ytN0++uaS6AY1aYr6Soly3dySxnlLJMmFC5Orf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474310; c=relaxed/simple;
	bh=ZgE0DI9a9mTY9wmrJHg8S+HRBGUE/t4iMybPPy30adI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/UW/9jwe20kk80/BcE69nWQMCCXpm4zTqCEoioFWjCxe0k4u7VMPTWz23jx5bU562iT3VRkv4/XJp/D0mjPsk68zvaCp+wuJTRwDc1aQAg0LuUFj7X0xWSMEXTFRXvi7KPzePafZkRuZVtl6SEr5pnaM9VPStm1/BZR7JIn6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AnOrid3; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AnOrid3"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso41325ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748474308; x=1749079108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr2SmmHn7WpXqUnHpYTLasaORThVlUKjDBWWjtMe31g=;
        b=2AnOrid3KwYZJtnHt7Q71iBpsHKtT231WkQ8UB1OLgCsp+oXwAbncBNBtBQsDE5B1X
         bqxchIWC49BprnQxc43zhQT/eu8lY00PWJnxaqNjLbpsHmATMi03iR754oBPptPqx+TZ
         oYThZgQrieHoEfHrOF/46zwE8wkrV6/VMg1t7O7CgFseBDT0XLumfcyVGD9lWysNsElG
         ezoZJ2qx5McizubuanHteESmTWidAJV0oG1DhdkO1YqOVu1XzU0/SVASCINQMS3K8JeM
         o6v3lgJ3xEndiF7Nwb0mpy65PiYeruSqqM3qlA8c+HAxnAVc76l9Ssm/vDU1KbjsrFLE
         gIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474308; x=1749079108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wr2SmmHn7WpXqUnHpYTLasaORThVlUKjDBWWjtMe31g=;
        b=ODkDULEzz1nh+76P3PquzepofZ0GmREBxcbCRjm+kECfN8ExVgjxQ+oXvhV9SNZIl+
         H69xhxcibSjh86YDwfQXBxBvIYuvUaXXkEUllsiZT5GD7KeNWiy4tl8Brm3qUDW7ctxV
         jLXcYSrk7QInLnwigBUzQR6snftGL/s9cXYMiRjVKux8/EofrHWZJWttsGdy02p27BIF
         pGzJ0oCW2mwDXY1rmhxaMihHTgdbbbiWkRhRANKysb7BpnmMGmqI7w1ph1KT7W9atDt/
         B1WQthkVlUx5h9XR/l+VyKxaSBpXIwNtpkJLBSLttYpUAGZh0Ur4bF7WxFWEGnmwbElg
         jLgA==
X-Forwarded-Encrypted: i=1; AJvYcCU4I207/SMOFZ00GHhcyoYmvfOCMx+a7THIWxgt4mK2540atqUYLiPQDdzLVtb31ieo4bFpLdZXEptYLxC4AA8f@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQWpPdWTnrO3Nx9Cgr7jHWcymnTu+0BKfXKSUn7ntgsIvrAhW
	MQOnZLgAqRPdeLuAM8PE2ggYL4xtScH7LsWTqUMeVBgYMdmzLaU7RfdrnjZnqpequEVbPqlW6CW
	M99TBoRrGZs+p9ebfFuFFZ13MbutiXu62jHLMhi/Z
X-Gm-Gg: ASbGnctcni7AVJk7IYakAHZFiRRA9u9/3r1yvYapuWkhsVCD2GKqeAUxTYkGcWP0pi2
	TIQKMKQXXb+EfKSZ6jhbHrVwK9GrIg4Ta50B6sLBjwjG9UM2ULPo7wrJ9gtZ09oDQNxq6M90JhA
	RTCqOxiMk6H+pQgtZ4cTsP+EAeVLMiVNJv47HMWMmXN3ChctKtGjxz1nPTdaJLFfqKhS6DmluT
X-Google-Smtp-Source: AGHT+IHrQWnT1aoYjY0oeHltTf6GRFTqzvL9Q6WkxaAVD9sE+2fe2FKMHZRU2QBoTogMaiGikEG1uch6LTDxqqo2cNo=
X-Received: by 2002:a05:6e02:3cc1:b0:3dc:832f:61cb with SMTP id
 e9e14a558f8ab-3dd9190accdmr1484855ab.0.1748474307353; Wed, 28 May 2025
 16:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410202647.1899125-1-irogers@google.com> <Z_mK9BVv16MT7shL@z2>
 <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
 <CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com>
 <aDdU1npHL2Vczhsa@google.com> <CAP-5=fUycjUUWW=hoSSvxfUVPXcqAk5KHnknFuUDOr7+Zf=M2A@mail.gmail.com>
 <aDdqcfuAuk78eKXD@google.com> <CAP-5=fUX-gSv0q_j59bG19=dnaCPMeATtFgM0bPMSP8DKZWRJQ@mail.gmail.com>
 <aDeHN4DeYS3i-5jY@google.com>
In-Reply-To: <aDeHN4DeYS3i-5jY@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 16:18:16 -0700
X-Gm-Features: AX0GCFsZnSL7nf1_A2btN6O7rfFVnUd3sZXE1H_YbANsSDeLH4pIccP91VNCf3w
Message-ID: <CAP-5=fW0g_bhmHm-uyVRja7dhkw47K-PLAx5iubQEm4X+vTSAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf build: Fix build for clang's -Wunreachable-code
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, May 28, 2025 at 01:32:10PM -0700, Ian Rogers wrote:
> > On Wed, May 28, 2025 at 12:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Wed, May 28, 2025 at 11:35:00AM -0700, Ian Rogers wrote:
> > > > On Wed, May 28, 2025 at 11:24=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > >
> > > > > On Tue, May 27, 2025 at 01:53:37PM -0700, Ian Rogers wrote:
> > > > > > On Fri, Apr 11, 2025 at 3:14=E2=80=AFPM Ian Rogers <irogers@goo=
gle.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 11, 2025 at 2:34=E2=80=AFPM Namhyung Kim <namhyun=
g@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi Ian,
> > > > > > > >
> > > > > > > > On Thu, Apr 10, 2025 at 01:26:47PM -0700, Ian Rogers wrote:
> > > > > > > > > Clang's unreachable code warning is able to catch bugs li=
ke the famous
> > > > > > > > > "goto fail" which gcc's unreachable code warning fails to=
 warn about
> > > > > > > > > (it will complain about misleading indent). The changes h=
ere are
> > > > > > > > > sufficient to get perf building with clang with -Wunreach=
able code,
> > > > > > > > > but they don't really fix any bugs. Posting as an RFC to =
see if anyone
> > > > > > > > > things this is worth pursuing.
> > > > > > > >
> > > > > > > > I'm not sure if it's useful and don't see what kind of bugs=
 it can
> > > > > > > > address.  The proposed changes don't look like an improveme=
nt.
> > > > > > >
> > > > > > > The goto fail case was in OpenSSL the code from a bad merge:
> > > > > > > ```
> > > > > > > if (...)
> > > > > > >   goto fail;
> > > > > > >   goto fail;
> > > > > > > ```
> > > > > > > Meaning the fail path was always taken and checking on the no=
n-fail
> > > > > > > code never executed. Newer GCCs will warn of this because of =
the
> > > > > > > "misleading indent" but  clang won't. It is easy to imagine s=
imilar
> > > > > > > mistakes creeping in, so using compiler warnings to avoid the=
 bug
> > > > > > > could be useful.
> > > > >
> > > > > It doesn't look very convincing to me but it might be valuable in=
 some
> > > > > rare cases.  But the proposed changes - basically replace exit() =
to
> > > > > __builtin_unreachable() - seem weird.  Why is calling it a proble=
m?  I
> > > > > guess it already has some kind of annotation like "noreturn"?
> > > >
> > > > Yep. The exit is incorrect (depending on your notion of correct, I'=
d
> > > > go with clang's notion as they've had to consider this for a while)=
 as
> > > > it can never be executed. I've added the __builtin_unreachable() to
> > > > document that you can never get to that statement, as otherwise it =
can
> > > > make the code readability harder with the code looking like it will
> > > > fall through after calling something like usage_with_options (which=
 is
> > > > noreturn). In unoptimized builds __builtin_unreachable() will fail =
if
> > > > executed, so it is a bit more active than just a comment.
> > >
> > > Oh I see, usage_with_options() calls exit() inside so any code after
> > > that won't be executed.  Hmm.. isn't it better to remove those codes
> > > then?
> >
> > Not sure I follow. The patch does remove the code but it replaces it
> > with __builtin_unreachable() to basically state that the code here and
> > below can never be reached. Do you mean remove the exit from
> > usage_with_options? Then we'd need to fix all the callers, which would
> > be a larger patch. Perhaps it should be usage_with_options_and_exit()
> > to make it clearer that the code doesn't return. I was after doing
> > what was minimal for -Wunreachable-code but while trying to keep the
> > code clear.
>
> No, I meant we may not need the __builtin_unreachable() at the callsites.
>
> Would it complain this code?
>
>   if (some_bad_option_use)
>     usage_with_options(...);
>
>   /* normal code path */

Right that would fix -Wunreachable, but the existing code would be:

  if (some_bad_option_use) {
    usage_with_options(...);
    exit(..);
  }
  /* normal code path */

Letting you know that "normal code path" couldn't be fallen into after
usage_with_options(...). To make the behavior more obvious we could
rename usage_with_options():

  if (some_bad_option_use)
    usage_with_options_and_exit(...);

  /* normal code path */

What I've done is:

  if (some_bad_option_use) {
    usage_with_options(...);
    __builtin_unreachable();
  }
  /* normal code path */

My reasoning is that usage_with_options() doesn't obviously on the
face of it call exit and never return. To make that clear we could add
a comment:

  if (some_bad_option_use) {
    usage_with_options(...);
    /* usage_with_options never returns as it always calls exit */
  }
  /* normal code path */

But my preference is to use __builtin_unreachable as that is the same
as the comment but is also something the compiler can trap on were it
not true.

Thanks,
Ian

>
> Thanks,
> Namhyung
>
