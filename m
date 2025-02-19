Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E683F9D5;
	Wed, 19 Feb 2025 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926734; cv=none; b=I6hV7WSJYR1rIczR+QrTgyZrc6Oqv1vPpHNCUWDad/3I5a2AFHbblf6vnYUD9w48u/X/Pdl6ZVr84kStZ8rsce29F+h4qOjgAyVDgdGsEKl91SqWCwIKYlOAhnM4iabhXv6mRaUDgu4LfQrFXQxGuArjnp+mCer5ue+3KhOq81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926734; c=relaxed/simple;
	bh=jmhrcWKkHilvljIZMViZu2rF01jndp2vBAJzdVRoh1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/iggX5yX70oxSlHciC/H+FCX5oP5B5YiyJ78LCAPxwtIcSkkxqSqP3Hxs26sLpgMkp5uDC0HsUFJaE+YhBBGmJq9bexvsmOgFTo7pNUvEZzDwp5D8EjXPX/JErXC8Su7Fq7OgdIPfe9BOp/giuR8XQry73TblcT6QvWfx/ADhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXLcW8DP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXLcW8DP"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f6715734d9so54154457b3.3;
        Tue, 18 Feb 2025 16:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739926732; x=1740531532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bJA8YmCnEAodhQF45ajT3K8Tf2jxKNSg9AlHiUTHU4=;
        b=LXLcW8DP2P45u+EwbcVN9t0ANH9FVEVfSGmKOLEHTvclUDNPYliciwo3GH/bAPqJZ2
         nYw7AFJsAWw8w0CWTXgWKJa0gZDcFKV+2tUiQ6g7TP51JB4dle+2RKXZD4ZlbH6NRRNN
         5/u2pi9VQtONqVEZDEz1nBNHYx4LA1YKFpKdfiEtNVPJGVE0EnZwVITpm0nNwCr4M0w7
         W8Rrq8WnIZoplkV3qS3fv4KGyXB0m41m/IzbH6xl2Hqx9aJjD2cKcG30ML+C72BpXLfM
         avDKyyUX5fAvlBKLgDDKBMEsENZMGVtFRvGeFguq3hZoNlPZyWXoyc8NfxaBsdfiheWo
         L+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739926732; x=1740531532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bJA8YmCnEAodhQF45ajT3K8Tf2jxKNSg9AlHiUTHU4=;
        b=h42afGEBTPVsngSljcUqkWKVQiivkMFidugCPFRJ5kDkJqJbw9LpgZsUyDZHfD05f/
         4bw4esrjUD+n2g+B1z+G6hG4Hjwk8/n587xS1K297pyxHZ1WOPvYc9adybb7/N0rDI2l
         BjZZOERMtIIMx0ECWyZ+Cgc1DdW6zNWrhTGW1GuIm8NYaTX0hwbYmINdEN2xHxnT+5SI
         0z2mVoVq5mNX8dJK2FAWU+umCGzLxZtaOQrdneIqm8dwG+JVu8OmPDxdjhyvX1absunw
         VnS8LR7x7hI+/EhKzehLTh6oc7MX2MzRu2dYtjLecIrYWdsWt4JYbh5BmG/IRn0IIc1u
         RWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh0eYu0zHKfOfcf0O8H4TDO6qj3GqJa2FIoZkflPi63lKdCVtVDqPo60lE387Vayq2oaUDe3FRW9TtPXg=@vger.kernel.org, AJvYcCXKGEh7kzwaKYcaA3/FNWuOfHTVmCawTJI3MaqX3CVjKMHn6DL5FyYuGjuQNdzpj7+vWCkqqb+Cl5MY6z7+L9B8nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIL/gMm6zAHgrgNcq6NLGdAFn7xxs+gheD4PGenvuHprP9qtwL
	FYb1C9M6Be9fjDjj8XUNTQVJYHmfsuMqrHNHbHf1CltBY8lPy+aG+U33kR2lqD6jJvH2GJT1BMp
	soSjv7U6kXG4Zr+o47AsidcmotwDP71vxlTY=
X-Gm-Gg: ASbGncv44xS7e6U5tRgaZuEdQN5jRBbG8aBAzDz17D5uLJY2q8qC9BSTbtOaXDYVZno
	H2tr1znOCZh0ZQ9ipjmMgPHcwQNIIqy6O3FvH6p/gCPEJCKy94QAwWNh5Hv87rqnQt9ndmGc=
X-Google-Smtp-Source: AGHT+IEeP/YT/u4I+5++spTx5STaz32WAdkPHQ0r6pEpxbcpGKMYWXOONHY3D8IgkB4l/Re67bza7kdwVs/5ZbJ1/AI=
X-Received: by 2002:a05:690c:9314:b0:6fb:5f8f:1d13 with SMTP id
 00721157ae682-6fb5f8f2431mr85409727b3.8.1739926731672; Tue, 18 Feb 2025
 16:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213230009.1450907-1-howardchu95@gmail.com>
 <20250213230009.1450907-11-howardchu95@gmail.com> <CAH0uvohY6fBaJvMZNi-fcHEW1Dw7Zp5Q_+ZxNgcaaFary-3sWw@mail.gmail.com>
 <CAP-5=fXae_851WezB5rNkv6cp2DfAWobJ-cbehKy3eiFe8F9Ow@mail.gmail.com>
In-Reply-To: <CAP-5=fXae_851WezB5rNkv6cp2DfAWobJ-cbehKy3eiFe8F9Ow@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 18 Feb 2025 16:58:40 -0800
X-Gm-Features: AWEUYZk51OITA1PnUtwP2-sCogR1IFXU3FVw0TaqLn9NcCVaKH6bgdGxvZlLvPI
Message-ID: <CAH0uvoh7dcMN7BjzHspEdd3+HgQza1wgNxctGvxFKmOjVCrh7g@mail.gmail.com>
Subject: Re: [PATCH v15 10/10] perf test: Add direct off-cpu test
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

Thanks for testing this patch :).

On Tue, Feb 18, 2025 at 11:32=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Feb 13, 2025 at 3:04=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Hello,
> >
> > On Thu, Feb 13, 2025 at 3:00=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> > >
> > > Why is there a --off-cpu-thresh 2000?
> > >
> > > We collect an off-cpu period __ONLY ONCE__, either in direct sample f=
orm,
> > > or in accumulated form (in BPF stack trace map).
> > >
> > > If I don't add --off-cpu-thresh 2000, the sample in the original test
> > > goes into the ring buffer instead of the BPF stack trace map.
> > >
> > > Additionally, when using -e dummy, the ring buffer is not open, causi=
ng
> > > us to lose a sample.
> >
> > Just noticed that this commit message is wrong, should be:
> > """
> > Add tests for direct off-cpu samples and --off-cpu-thresh option.
> > """
>
> Tested-by: Ian Rogers <irogers@google.com>
> ```
> 121: perf record offcpu profiling tests                              : Ok
> ```
> I'd be tempted to keep the comments about why 2000 next to the actual
> code rather than in the commit message. In the code the value is 12000
> and not 2000 though?

I actually deleted the --off-cpu-thresh 2000. It was intended to fix
Namhyung's original test because I forgot to enable the off-cpu event.
Now that recording the off-cpu time of a task is fixed, that
workaround is no longer necessary. The --off-cpu-thresh 12000 option
is used to force sleep 1 to produce an at-the-end sample, as only
tasks that have been off the CPU for more than 1.2 seconds can emit
direct samples, and since this is recording an off-cpu period below
the threshold, I think it makes sense to put it here in
test_offcpu_below_thresh(). That being said, if you=E2=80=99d like me to ad=
d a
comment or two, I=E2=80=99d be glad to do so.

Thanks,
Howard

>
> Thanks,
> Ian
