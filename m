Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F951F5846
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752501; cv=none; b=ju9EWNdElug1q3PJSrIpNfzN3BgngZn5bGMgPRqTB219i4rUcCh9CkL+Igp86iG3LmsKIBOVf7Ka7g4u5InOyEyR5ylPoVVhg/dp/DFceWStepcueawFd2n9aR6f+Qs/aD/SY10xbGOg50z0Y70bcj5kDSPKsskznKqUIOTfFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752501; c=relaxed/simple;
	bh=fCXm53AZpLvD3mlG5kaIz/uCWSEGjcylvGsCkXzMLrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTXha5K1xyySQf3IIsAFZn+aADjVeIupkRFKS4mUlIHf+Eqv9CRFcmBJLXrLZVU2eMiWqwAAZ99+BloYqS8ivNPBgp/1da0kauO6hGfTVAnkA5YmrZ32gZELAnJmD+TB1gnmPnIUKoYmw6htw99YIxNMFmqkDS1omrsGr5BwV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SX5sEeHz; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX5sEeHz"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso2905ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730752499; x=1731357299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTtHTuauzkyyFaQ5FOERKTQGUplDXz7vVkQVmXIkb2o=;
        b=SX5sEeHz1a5qcc8B1kpCYbJuLVH9cymsFjoIIl53YcwGm+gm7sKBr2d+27Pn//50oi
         6sjUcNW95hjlivMOEV66hAznYcSF7SS04Ga/6ALGpxYyCwB0WOuH9XfSdeD1NCiQeahz
         g/G3ZGRrbuzOhImtGeDmLDGw8+HcOlpNKEXF0EF760qP5N881eNbMxbuuo0MNaUWght1
         InjVdy4rUFid4dM+JFRt5kulK4XYAhMU0VYw55lxecG+2CfBtR8b0JBKT7g4vhxBvvpU
         wyce1SKul8O/mlE+PPW8mMAt4j+XzCu3FtJQQ45nWMwGk+bmLOpxIGC6DAa3yQkZM1EJ
         S+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752499; x=1731357299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTtHTuauzkyyFaQ5FOERKTQGUplDXz7vVkQVmXIkb2o=;
        b=nwKN9iQrNrtJSTWR3WDB7Y6Rp+teaRkKPIeo6HBfKlasJt3SCZct8P1gF6XD4OwuVi
         H5vYxZ+XLB1YufUcYXkY7nmv57sFGhjbHeS+9hJnjoo/cfMYgy/+fq9UX+H3jHnkSBpy
         QZSviRy7jLWP5+rku0dcreRUZorTm46ntTH3lVCX0uOng5wydoc51J5CztsBTp5Gp3Gu
         vH4z/bBACJZhqE6kIWddtHQDjCwWlVG5+RgT+fcfKOb3F9DqvA/DBDElFI2xw4uMtq3q
         XaButSg5GV+E6QAfZOr3R1nqGvBfpvg9EUyMa77Uvi/3USk/e1j/LWPTiv7lC3T4LxwT
         ql5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYD6fIGiTFek2o+Ejmh+VJU+D4IWrCOb8BQi5DFpH+mimUbYXvNAudLciw9TucfD/2Hm0hXVoZdj5s/LYf9PMi@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQhvUO7NlNqbDaPlRAzqYx7iwLKRm74ZaxGFgrL0/lkq0i0iB
	EYvNo127QP8bceBwe2dIo/Iljd/aScXxt6YMPW/oo+IiV45sjoQjPxHWbaBKc7JibyPCc5jfszZ
	Qo2PcoKYg4Lp1AOim/HpI7WI1IqLi4nb+QZ5X
X-Gm-Gg: ASbGncvOJrAti1HvwyDyNLxKs+fZnc+9Z81JCUujIwuqNO1Hm4IYo0QxMWwnFwxsofV
	kCbM2X5zberaVznVT1XrlpMhFvdWC1caZggpjjkQB2B6F7OIetrnu56kAphrCJw==
X-Google-Smtp-Source: AGHT+IF2RG8jMIhbr3G3wIVER0dIaBDxrGWf6Ov4CTuuI8RTqGpMnA/hqfSnwPEmDAXRhsf/y2Q0ha81fWR+0ujBjJg=
X-Received: by 2002:a05:6e02:1a87:b0:3a4:d2ba:2011 with SMTP id
 e9e14a558f8ab-3a6da8bd59bmr676595ab.0.1730752499214; Mon, 04 Nov 2024
 12:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com>
In-Reply-To: <Zykk2MJ4REGCaqVw@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:34:47 -0800
Message-ID: <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
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

On Mon, Nov 4, 2024 at 11:47=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> > On Thu, Oct 31, 2024 at 12:18=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > > The only use of find_scripts is in browser/scripts.c but the
> > > > definition in builtin causes linking problems requiring a stub in
> > > > python.c. Move the function to allow the stub to be removed.
> > > >
> > > > Rewrite the directory iteration to use openat so that large charact=
er
> > > > arrays aren't needed. The arrays are warned about potential buffer
> > > > overflows by GCC now that all the code exists in a single C file.
> > >
> > > Introducing is_directory_at() should be done as a prep patch, as the
> > > rest of the patch below could end up being reverted after some other
> > > patch used it, making the process more difficult.
> > >
> > > I mentioned cases like this in the past, so doing it again just for t=
he
> > > record.
> >
> > This is highlighted in the commit message:
> > ```
> > Rewrite the directory iteration to use openat so that large character
> > arrays aren't needed. The arrays are warned about potential buffer
> > overflows by GCC now that all the code exists in a single C file.
> > ```
> > so without the change the code wouldn't build. The new is_directory_at
> > function is effectively 2 statements fstatat and S_ISDIR on the
> > result, it is put next to is_directory for consistency but could have
> > been a static function in the only C file to use it.
> >
> > For the record, patches introducing 2 line long functions can be
> > excessively noisy, especially in a 21 patch series. There is always
> > the declared but not used build error to worry about - here things
> > couldn't just be simply moved due to triggering a different build
> > error. Given the simplicity of the function here I made a decision not
> > to split up the work - the commit message would likely be longer than
> > the function. The work never intended to introduce is_directory_at but
> > was forced into it through a desire not to disable compiler warnings.
>
> This patch does more than just moving the code which can be easy to miss
> something in the middle.  I think you can move the code as is without
> introducing build errors and then add new changes like using openat() on
> top (you may separate the change out of this series).  I think it's
> ok to have a small change if it clearly has different semantics.

If you are trying to bisect to find something that broke a build,
having commits that knowingly break the build will cause the bisect to
fail. The bisect will falsely fail on the known to be broken commit.
It should be unacceptable to knowingly break the build in a commit for
this reason.

Thanks,
Ian
