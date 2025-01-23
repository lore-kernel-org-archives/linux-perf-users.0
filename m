Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CDC49625
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648484; cv=none; b=vANEnPgLst78o/vltIq+oj1nhnyHSPaShr9Z7F9TULLJCLjv+Wqlikv8ebcGqq1gXJmxc2OUMstgu4FpuTVPT+z9cUThFyiz8a4AJ0BilVMokzN70MH6s8Sc+CEOMH4XTgxxoSt7ZZkJ+qK8eDBC5gTcp/MBwlWe44O+S1au6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648484; c=relaxed/simple;
	bh=VJiHmI1djOKKK9qlzui7VcEj1PKh0CYZs7jRjQzcX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiRyjHK2Le5n/bne1zDOB3/2XFQk6QzXbI/9f1L+Sx0wZ2tIxjbdvxwmtuIL7jBrzksU9VE0nOE4w2R1T0/xx0kHJPM9DJFUKV0fdIq+t7zyuiTFMkyYU6uRd/DYDOl80jL/TMBifK0+epLsAqR5lwBdmQGdqTcAAcgdS/FDKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYSJHgm3; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYSJHgm3"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so155535ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737648481; x=1738253281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQDmKPoAbR7c0QGvmjmPxwpkQvGXQ/s6fxXQ9ADc7Og=;
        b=XYSJHgm3cc3R2UGLhWX2N9y1R3bs6iFC7+FaNBXCuI9S8aq2N8IJMCOdn2DlsHzi7z
         xwCBoobW+e/k9r8lO+Zfwdq8PMAnnUb4Y5FM4ZBqP3fVF/J8yva0mdAomIFVozd+eCku
         UjiGwfW603/B/hBbIHxm/WyS47fie2gf1URuQ8ckPUcNOg1WGShAzbae9HV17G02uD1c
         kTuzbPwHz/6EgG2S6fPQBgua+vtCyhIVS8Z7Em3QT3WZ+2sJ5cAhg7IEdMaYY/lhk0vx
         1xDJs1rqK+AnF7AoYrxDt+S26NZlnX9ggG8xyF+yo+ISXvxeZPmY7aLMBPokkqOQVpKL
         mNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648481; x=1738253281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQDmKPoAbR7c0QGvmjmPxwpkQvGXQ/s6fxXQ9ADc7Og=;
        b=TYQ4MVH0JY/YicBMsSy/oM+4hpf2+j7mPr2tO3WVCPRYhP8sB7kq/prrmbv/KejBEh
         GWF2k+f7zqs9m+irdq7BK5mRMc5ELg4dIKYSoTT0PNRlICzIe5o5gqRTvn/K4bVFAIXa
         YxFsLjnpNFJFUu3VjhvLxtZx2SVboH9lYz6+0B8JM0XctyD2yyTooq9cZ1AU8I/ya5Pd
         W4hfOpEP/yS83z5f5dscXAzoEQnZZMjfKhmd1ZB4ubBHf7L+aliqTf84BfOYyS+zF/yQ
         bnetLR9ENFOTAPSitVJJrWj1400BLB0NGf+IvVf0LNoqV+baMCQEieAU1Rs0NXfrkH3d
         lX5w==
X-Forwarded-Encrypted: i=1; AJvYcCUMzxJxeEz+dFFqWV3MSs2Ig4akn94c8vkhZEbsixDio1HmBwUWxV2cIO189bVKmqq91usSwpuMzdviDtvgDWjC@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9U/PhSK4FieBojMgYGFFbzWMiKCb0lQTi6HyUZl/Rl26jSZT
	GI1hSR/zo6K0kdb93QPmO4DBkvNRvRHeoaC5Lr2KvvIecYQx9A+QZETamF/7xAiRBi7QBbQ9kV9
	bsI+gsvVciKQiJxHYNaaUXiNVx6KPLGuvYgHr
X-Gm-Gg: ASbGnctVwAie5BROx2TYMcQc6ojTZ9LpovkXBz1+lpGiU7t6ttfKpNZOuld5Czo27cp
	Riw9W1TcxEIITVCvNXAJnGB1Ki0/TwdqUfgZhM4VAkmFTW4q1lR1tHI0XvdoqccBnjeWkGVLX5K
	xjVWXp4Mngoz+DBQ==
X-Google-Smtp-Source: AGHT+IEXJE46BE9oGbt739cbBwHASjUpEeCbviM8FWa0ovSaM4CyC+OI2+kR+M4VbAO92iS1fs/qHZrGKmHuWnAJN1o=
X-Received: by 2002:a05:6e02:1d14:b0:3a7:7d6e:fef9 with SMTP id
 e9e14a558f8ab-3cfbdebdff2mr3008595ab.27.1737648479856; Thu, 23 Jan 2025
 08:07:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120173208.344231-1-irogers@google.com> <20250120173208.344231-5-irogers@google.com>
 <Z5FwusFZ_bYlu6aK@google.com> <CAP-5=fX4vtKzMtrEbZhqH0dmKpXY3Ke+pVJ-ZbnHnAVuto7Z8g@mail.gmail.com>
In-Reply-To: <CAP-5=fX4vtKzMtrEbZhqH0dmKpXY3Ke+pVJ-ZbnHnAVuto7Z8g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Jan 2025 08:07:48 -0800
X-Gm-Features: AWEUYZmuYzja_lRDXich0Xw56IxoG1_AoHvfnNjTcqKJp9HAh_UgwJL40-V3vys
Message-ID: <CAP-5=fXx=q-LHcb9BtjE1AFZGmV55NBWy3HvfWQaABo-YO=4gA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 2:42=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jan 22, 2025 at 2:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Mon, Jan 20, 2025 at 09:32:07AM -0800, Ian Rogers wrote:
> > > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT=
,
> > > support dlopen-ing libcapstone.so and then calling the necessary
> > > functions by looking them up using dlsym. Reverse engineer the types
> > > in the API using pahole, adding only what's used in the perf code or
> > > necessary for the sake of struct size and alignment.
> >
> > I think reverse engineering the types is fragile.  Can we simply change
> > to dlopen if libcapstone is available?
>
> The current behavior is if HAVE_LIBCAPSTONE_SUPPORT then we will link
> against libcapstone and can assume the header files are present.
>
> The reverse engineering of structs and constants I agree is brittle,
> but these things shouldn't change, it is used in this code when the
> capstone/capstone.h isn't present. If capstone/capstone.h is required
> we could change the ifdefs to indicate:
> 1) capstone is present and we're linking against it (this is
> HAVE_LIBCAPSTONE_SUPPORT today);
> 2) capstone is present but use it by way of dlopen;
> 3) capstone isn't present don't #include, don't link and don't dlopen.
>
> My thought was that this is less good than the reverse engineering.
> (1) relies on the builder having libcapstone, which at build time is a
> warning that flies by. (2) also relies on the builder having to have
> libcapstone and to opt into a dlopen behavior, they'll need to read
> Makefiles to discover this. (3) gives a less good perf tool with in
> the source lots of __maybe_unused and ifdef-ed out functions all over
> the place.
>
> With the reverse engineered values if you have libcapstone then
> HAVE_LIBCAPSTONE_SUPPORT works as before - no change. If you don't
> then you will be opted into getting something better than objdump -
> albeit it could break if the reverse engineered values drift from
> those in capstone/capstone.h. Less build options also is less
> complexity and cleaner code.

To be clear, if the header file values/structs drift then libcapstone
will need to version values/structs, we'll need to update the perf
code to use these, etc. Otherwise a tool linked against an older
libcapstone will break when libcapstone is updated. The code handling
not having any libcapstone, dlopen-ed or not, would be significant as
every static function will need an #ifdef to avoid a not used warning,
every parameter will need a __maybe_unused and the overall code
quality in perf will be worse imo because of this. The no libcapstone
default when not detected would be crappy for users. The values/types
added here are fewer than 20, and so are not a huge maintenance
burden. I did a similar thing for the LLVM C++ symbolizer code and its
maintenance would have been a burden and so abandoned it in the
llvm-c-helpers case that mainly affects addr2line and not disassembly.
Hopefully later LLVM C APIs will make this unnecessary.

Anyway, because of this I won't be changing this in later versions. I
will be carrying these changes in Google's tree and think ideally it
would be carried in the regular tree.

Thanks,
Ian
