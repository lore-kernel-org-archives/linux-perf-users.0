Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB502192582
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753296; cv=none; b=fVq4AjP/aEoG6Ss/FtwspNZxGpc4tQ8QSiYdrRtGbbJBYZ4OJRLfQZE5f5ZRp7ONCNvw7EkuNwpn6dcz5ldrB/SYyVKbLfN1cXrVypAkq4gP7gdOX+/qSWhlpXgkBIgMX0yaQcQRupxQv3T5ok/cBFv5VA7+w/EbC4iy3FT4yKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753296; c=relaxed/simple;
	bh=9aJWFFSW3++0fcYdHxr48Xl66D06TUo0DPDdjE5TeyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoOAJZ9N7KfbaRcwQLvH4GE08yA8XoVzB/3KzM5HnlSji00d5HTpgeCiJI1J1WJ1JUno6xn1jx+UFaEV25wsInHwqxYywqekvnYz8fIRgL/sh9SiHY3eECUmWvGRc2blpJf0+UZHwR9FtyxrVMilc1pVNdl+z4zhOEPNUOfXgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hqy5e6HO; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hqy5e6HO"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso50505ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730753294; x=1731358094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQrwd2M+bByYwaPmhFd+hKbI2aI8cuthGBmi+PJaIfg=;
        b=Hqy5e6HOAsFPeKROkXwtIRidruMB+xKI79JU/5yV7FZRYpa5woH76/AkFqHKWsDc+3
         gEidCyB/tJDdrwht5wmWNJGsHc/EF9LAAd/apooMWdm9sMyURrjkGh42sGvPZM9rEFeY
         KVKrZIo4ifHUmV7mc44Yl1DzGGXb6Gs/pXlh8CBatHD9cniSIlydbaA1hVzQjm2UyYwB
         zxaVeKz+sH2BzVpPXhx7TlfA26IbIiV6bSRd5dgcYFqm+1mYCLLfw9wkXOKY/ZX96Zry
         Y+n7yx6xSRzk47alFio0siI9MPVz0XThoHt2ostZCZw8Nfs7iJVp+YM/wm9xji6+tbTK
         NKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730753294; x=1731358094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQrwd2M+bByYwaPmhFd+hKbI2aI8cuthGBmi+PJaIfg=;
        b=e+nv1Qd61YvPhvzmV6KtnRMXdTRl3DpnguvvI1ZvFjtPuSUujDVCncgQKQ35+aS92p
         B4oYpMa17167lTuFvt0fGugoBBq5CMqdcjfG8F7irgHhAJcfCvvt/JtTA8Lq3RmZkesf
         rIwd19imhx9N6gJp/OlVFFFxA1H4AfWU08RCprg+khPm8n2ABk/A/CgTtyuPq+El/0Bm
         nPajTVgdGIGLujKZnfztrewE/5eE1DYOKmQG95gScn/Fk0Bqicbzza/QM8LOm023EEDu
         +lJL9BIlYMbh6YlbtQDFYjAj5puEdxdDf4fMekkex1hc1GxAjQsOKNENvgiNq5MmezHJ
         ihKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCFn+TACLSaYllno0d6iA+CqcvRpTTLKzkvQO5Ws3V2blBKHVoarJemNRzCixhaODJoNZU2iBaR2BJd/qEdnp2@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMmJ2YzB4HoaogmBfVnQsLdn8lPG33koZfgFW0q8muhvswYE/
	OrmRKqWX1xeC1O9VZuJdqGRUoPqan1oIiCXaSv5z9mtLEtMzbqyvQ4Y5AOFw70em+wHP3tBPTEs
	Gla216TePXaDHFbarC01EFDeFvwE7hpOWCCKz
X-Gm-Gg: ASbGncsTpdIN7B7N/TlvX1m8IMqePxh05iWHPlysf3PL6mY7wdKzqZHYSJnppk1j+uI
	cTyySerAjBPOA5P+FSOX3cdWvmuzPCQXX/GsJI7Nw3KSlkl41HAEY8xy2jVlXsQ==
X-Google-Smtp-Source: AGHT+IEcvyrhsNmSCfDoQdRhpKhe+RRessbk74R641XcJIjVxaTYakqoztiVG1s3RLEv6Vw6oMY7wkwBV5cdBrEhT7I=
X-Received: by 2002:a05:6e02:20ce:b0:3a6:b8f5:7166 with SMTP id
 e9e14a558f8ab-3a6da957881mr784505ab.12.1730753293845; Mon, 04 Nov 2024
 12:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com> <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1>
In-Reply-To: <ZykxD41c6gWQoIrQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:48:01 -0800
Message-ID: <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to browser/scripts.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Mon, Nov 4, 2024 at 12:39=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Nov 04, 2024 at 12:34:47PM -0800, Ian Rogers wrote:
> > On Mon, Nov 4, 2024 at 11:47=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> > > > On Thu, Oct 31, 2024 at 12:18=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > > > > The only use of find_scripts is in browser/scripts.c but the
> > > > > > definition in builtin causes linking problems requiring a stub =
in
> > > > > > python.c. Move the function to allow the stub to be removed.
> > > > > >
> > > > > > Rewrite the directory iteration to use openat so that large cha=
racter
> > > > > > arrays aren't needed. The arrays are warned about potential buf=
fer
> > > > > > overflows by GCC now that all the code exists in a single C fil=
e.
> > > > >
> > > > > Introducing is_directory_at() should be done as a prep patch, as =
the
> > > > > rest of the patch below could end up being reverted after some ot=
her
> > > > > patch used it, making the process more difficult.
> > > > >
> > > > > I mentioned cases like this in the past, so doing it again just f=
or the
> > > > > record.
> > > >
> > > > This is highlighted in the commit message:
> > > > ```
> > > > Rewrite the directory iteration to use openat so that large charact=
er
> > > > arrays aren't needed. The arrays are warned about potential buffer
> > > > overflows by GCC now that all the code exists in a single C file.
> > > > ```
> > > > so without the change the code wouldn't build. The new is_directory=
_at
> > > > function is effectively 2 statements fstatat and S_ISDIR on the
> > > > result, it is put next to is_directory for consistency but could ha=
ve
> > > > been a static function in the only C file to use it.
> > > >
> > > > For the record, patches introducing 2 line long functions can be
> > > > excessively noisy, especially in a 21 patch series. There is always
> > > > the declared but not used build error to worry about - here things
> > > > couldn't just be simply moved due to triggering a different build
> > > > error. Given the simplicity of the function here I made a decision =
not
> > > > to split up the work - the commit message would likely be longer th=
an
> > > > the function. The work never intended to introduce is_directory_at =
but
> > > > was forced into it through a desire not to disable compiler warning=
s.
> > >
> > > This patch does more than just moving the code which can be easy to m=
iss
> > > something in the middle.  I think you can move the code as is without
> > > introducing build errors and then add new changes like using openat()=
 on
> > > top (you may separate the change out of this series).  I think it's
> > > ok to have a small change if it clearly has different semantics.
> >
> > If you are trying to bisect to find something that broke a build,
> > having commits that knowingly break the build will cause the bisect to
> > fail. The bisect will falsely fail on the known to be broken commit.
>
> I'm not understanding, AFAIK nobody is advocating for breaking
> bisection, just to first instroduce a function, then use it to avoid:
>
> 1) Introduce function foo() and use it for feature bar()
> 2) Somebody else uses function foo()
> 3) We find a justification to revert 1) but can't, since it will break
>    2) so we need to add 4) that removes bar() from 1).

Namhyung was asking that the c&p of code be 1 patch then "add new
changes like using openat() on top". That is:

patch 1: add is_directory_at - introduce the 2 line helper function
patch 2: move the code
patch 3: update the code to use is_directory_at

patch 2 is known broken as patch 3 is fixing it.

Hopefully this is clear.

Thanks,
Ian


>
> > It should be unacceptable to knowingly break the build in a commit for
> > this reason.
> >
> > Thanks,
> > Ian
