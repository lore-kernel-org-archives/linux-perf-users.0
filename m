Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A291FAC31
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754409; cv=none; b=ZG8gBhBLL6JzjGOlMnTrCDmpNU3Dcj4pkSsqLFFifZNonBuSpB+oKDtn5+kbh2q3d511a2Ht75jeafvXIvJ+sEmczyZhjI4VXjMy3Ce5p/NRqEaNWNRi5SMpMzM++NFeyVAr45hud/KNY2bEQBvhuy5hcwXjFnfFAXtA3K/9H0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754409; c=relaxed/simple;
	bh=p4I8egqMIvs9Mt1ZgPAste4N0lCFUZnjOnGlLdeA+l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Se9iMUb+bMo1AsYR986AEwEzUb//Yo0GLQSFzgTMgdo92QG2G5pcp325M8H+7acvSvJTv1l4dCj9n9Oh6ChkYRsqPeCvfa7ZfbvfRtk4sAp/qMifVBPrpb15jA1Yorcz23cM8ctt9iS455jWgtrrTS9G8wLCAQ++tXUgqAp32eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecA/RaIY; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecA/RaIY"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so45905ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730754407; x=1731359207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X8h3w9ARspwQBdqBvA6URma1cvCX4zBiK/RBU29C0g=;
        b=ecA/RaIYxU0GjAJNjzCWNvFTz2nsdog1ue3KyWkiPXMoo3mIx764LL2h+TjaF/+yVs
         5uw05noJWpimMPbHqTVwx5LGW4ggHqiFeEA+uc420bsl+NRbVhSvw+5FY4Sryn661GYl
         qfTKPjLZeU2RNjMEMMhlHOvz/WCcPvb70ArosIslkRxTKOyMYgmAsV8jxIi0Qr8Z4ufI
         Lg0l8MzZMmqpj2ClYLFEcW2jeoVVzbg/lVmeocJV9K9972PkLFtQ96ppzgVJs7ypcDf1
         bqwwVlz4/Ag794dc5eTW2/po4j0Bs+yzNNXOTgo8UFIgfW7tXcW0U9eyyrMiuHHQG4gg
         gsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754407; x=1731359207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X8h3w9ARspwQBdqBvA6URma1cvCX4zBiK/RBU29C0g=;
        b=oD8ZGvzTpunBsqQsOHXiLL8fzIIH1oCBgtHeK75jxJAYN7JI11CYCbKqcZwTxDiSmF
         ACfaMMwKUq7YwkfhhM1ILA3emxK9zzSijEnb7N85/UKMHGjSpVMZGjP39UDFTG8i9hy9
         IlP4xTUORiTSehcf/0wgbZue4g3t8ZW98zo6s9w2RDCGTgG7DPWvqAfClFlbJ8iHj+Lq
         NAaKTZGxuoGxUX5FuaWM983EPzdYzqBHzn/0DJF8SZGN1tu/URqC1WCglK7fHm/vV+Wv
         SPEHnpWweejIVwohXDUaUrqxvaYy7h3GQWQ+8RJC/fulh5hxAav31IlTOYIMFgu0cH9p
         rUcg==
X-Forwarded-Encrypted: i=1; AJvYcCUTgbNm2mbslSl2HuFqjWst5cLazY3gdn97yJYQldzjB1BCtZx/w31cwkdsiCOq1fOd+MTPXVPpLx+25TX6vrIR@vger.kernel.org
X-Gm-Message-State: AOJu0YweEldxQ+TmQGulEOjSWUbp8LpQkVElPe2vvFxHNL5t1LsIBe0s
	NVahnCL2GOgLZYaDif0u5cWY8vEPYDQ6NndJbjAcv2w+yXenSTqUfHzf4rmLC7XWqWObIQnj8E/
	Dj+8ODP78VwHszgqHkGM7ukqYRsrnpht6qlj9
X-Gm-Gg: ASbGncvQoiczMjG0MLKm/QbCrMes7zjdzv8jqsh8ToTjqWNx3dTASjB8XHx0jfTAjba
	lspmFjx2MiymJa9e2QCNGhqbtFidrN4rWP9RCD72HPK4g+uX7v/pc+XlbfcEoYDo=
X-Google-Smtp-Source: AGHT+IF/DUYBoiOfozUGmZtvuCTaqwIGsVuJkSkhvnEO8q4dU3jkpIXU2foqX4/8PGuJz7DzFpbk+Mu1jhtW49HcMkA=
X-Received: by 2002:a05:6e02:1aa5:b0:3a0:9ffd:2b7a with SMTP id
 e9e14a558f8ab-3a6daa96453mr755235ab.9.1730754406481; Mon, 04 Nov 2024
 13:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com> <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1> <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
 <Zyk19KgzI7ybPkQ4@google.com>
In-Reply-To: <Zyk19KgzI7ybPkQ4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 13:06:35 -0800
Message-ID: <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to browser/scripts.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> > On Mon, Nov 4, 2024 at 12:39=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Nov 04, 2024 at 12:34:47PM -0800, Ian Rogers wrote:
> > > > On Mon, Nov 4, 2024 at 11:47=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> > > > > > On Thu, Oct 31, 2024 at 12:18=E2=80=AFPM Arnaldo Carvalho de Me=
lo
> > > > > > <acme@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > > > > > > The only use of find_scripts is in browser/scripts.c but th=
e
> > > > > > > > definition in builtin causes linking problems requiring a s=
tub in
> > > > > > > > python.c. Move the function to allow the stub to be removed=
.
> > > > > > > >
> > > > > > > > Rewrite the directory iteration to use openat so that large=
 character
> > > > > > > > arrays aren't needed. The arrays are warned about potential=
 buffer
> > > > > > > > overflows by GCC now that all the code exists in a single C=
 file.
> > > > > > >
> > > > > > > Introducing is_directory_at() should be done as a prep patch,=
 as the
> > > > > > > rest of the patch below could end up being reverted after som=
e other
> > > > > > > patch used it, making the process more difficult.
> > > > > > >
> > > > > > > I mentioned cases like this in the past, so doing it again ju=
st for the
> > > > > > > record.
> > > > > >
> > > > > > This is highlighted in the commit message:
> > > > > > ```
> > > > > > Rewrite the directory iteration to use openat so that large cha=
racter
> > > > > > arrays aren't needed. The arrays are warned about potential buf=
fer
> > > > > > overflows by GCC now that all the code exists in a single C fil=
e.
> > > > > > ```
> > > > > > so without the change the code wouldn't build. The new is_direc=
tory_at
> > > > > > function is effectively 2 statements fstatat and S_ISDIR on the
> > > > > > result, it is put next to is_directory for consistency but coul=
d have
> > > > > > been a static function in the only C file to use it.
> > > > > >
> > > > > > For the record, patches introducing 2 line long functions can b=
e
> > > > > > excessively noisy, especially in a 21 patch series. There is al=
ways
> > > > > > the declared but not used build error to worry about - here thi=
ngs
> > > > > > couldn't just be simply moved due to triggering a different bui=
ld
> > > > > > error. Given the simplicity of the function here I made a decis=
ion not
> > > > > > to split up the work - the commit message would likely be longe=
r than
> > > > > > the function. The work never intended to introduce is_directory=
_at but
> > > > > > was forced into it through a desire not to disable compiler war=
nings.
> > > > >
> > > > > This patch does more than just moving the code which can be easy =
to miss
> > > > > something in the middle.  I think you can move the code as is wit=
hout
> > > > > introducing build errors and then add new changes like using open=
at() on
> > > > > top (you may separate the change out of this series).  I think it=
's
> > > > > ok to have a small change if it clearly has different semantics.
> > > >
> > > > If you are trying to bisect to find something that broke a build,
> > > > having commits that knowingly break the build will cause the bisect=
 to
> > > > fail. The bisect will falsely fail on the known to be broken commit=
.
> > >
> > > I'm not understanding, AFAIK nobody is advocating for breaking
> > > bisection, just to first instroduce a function, then use it to avoid:
> > >
> > > 1) Introduce function foo() and use it for feature bar()
> > > 2) Somebody else uses function foo()
> > > 3) We find a justification to revert 1) but can't, since it will brea=
k
> > >    2) so we need to add 4) that removes bar() from 1).
> >
> > Namhyung was asking that the c&p of code be 1 patch then "add new
> > changes like using openat() on top". That is:
> >
> > patch 1: add is_directory_at - introduce the 2 line helper function
> > patch 2: move the code
> > patch 3: update the code to use is_directory_at
> >
> > patch 2 is known broken as patch 3 is fixing it.
> >
> > Hopefully this is clear.
>
> Actually I don't care about the patch ordering.  My request is not
> to break build and just to separate different changes out. :)

So, patch 2 can't be separated from patch 3 - are we agreed? So we
squash patch 2 with patch 3. Patch 1 is trivial and fails to meet the
bar of a meaningful change, so we squash that. We end up with this
patch. If there's a later revert and a dependence of the 2 liner, just
don't revert that part of the change. We've never had such a revert so
it is hard to see why we need to generate so much churn because of it.

Thanks,
Ian
