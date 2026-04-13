Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE51A275
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113753; cv=pass; b=ncl6szXNqb4JtT5InfpLjFsdgSvnDFZKUxKm1GpuuYorDEuLpMwkroyHFsT0qFCVlZhKP8hoafOT14HgBGuTubbCyKXFveosI5GAi2CHJ6DCKb4OvFT/kI4Y8QTvLOw/GdqNzzdqLwEutIxrknPHZfosOCg7IsBDTQlR95CEL54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113753; c=relaxed/simple;
	bh=33VXNofdiyi43FNtTuA2IAuJpHev5hByegY7dlncJVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUzKz/4A3GpjjeetHjeig21ACoHiPjmLBD4T7TKMRxtd7jknDiPD/X+brkST0W5U8hpqBiS0nROzsp4V5mEDUwEHnCailjUTewpwBa160MXGpYju66krAuP9hU+V3pbM6NyqQ0f3UJyeUM8plsfbHL27h0tdC+h6+XUfeTye0lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUwI1rnz; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUwI1rnz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b243198058so414365ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 13:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776113751; cv=none;
        d=google.com; s=arc-20240605;
        b=MsfwxD/oQlNCl5ltkLtfnc2Fe7/Bml7D1bC6HrIDnS0WFoXRO8Fmre+hEFUyDa2aeW
         /OumhO5XQTRIUe5ZLMAgdPB3QPbOdJH64nRGXvOAoImiyhvNHU33f+7/HZr8lDIkYBF9
         GV2v5U4pbDUk4a/vO6Mn3sAC6sgKqKLQY1CiQ7+3aiWPmCH/7588UOgp7xI6tF+4jDtP
         +kJ38mg+uWgn75SpqT5AzWXUbgHjyTc5JbkJiv/agjPCjb4VuhQX6tyESCDEM5ZJL2Vk
         +bv4YTXTOZavoELF6l4eHcU81PoFoZdFgN3QqX5FtYmu7034DibwJysd4kQjfK4SBr9m
         WwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KpAgBjOPxxaIv5Hw7x6OTOEyZpKVo4Wkqvp0L0s51Ho=;
        fh=SBXKqv65Gfgvp/8PwOvoxWY4+0yN2qg2UyIzxD/TspY=;
        b=dPd8KTJuKpynVlWnDQxfZs+3Gdh4o1oQ6j7jucPFpnkfKOdqR8Mcmixno7d8AMj5dU
         oeD2BLnic/eObCGcKl9fwepBD1MeMlQZW2xg17uoeSvwTHhxX2StoPXOtUMbdWBAK3sU
         JicWsXMYNp0XIXGUmlTq8TB6Rh3Q2zQY9VgGhIZTKqHiqpDjaWW7GorXPpvTvT5po0OG
         lciOBIKgeIRTBtAyN0WLaOROEHXOoybzc027a4N52XYuhdR1qww8xp1lOFCygTyS7qzQ
         4QCUFFwAoKT0R7d934bXaaquxiPI9ufZmeL61rcs+DOjK7QizYPFcPhOCDXbienRfnSS
         XIcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776113751; x=1776718551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpAgBjOPxxaIv5Hw7x6OTOEyZpKVo4Wkqvp0L0s51Ho=;
        b=BUwI1rnzSDB+DbJrW51Fhr3xQVD+NDFasgnM3dU2aQPt9q04jCrni4X2Ae9pQ4Iw98
         EHOHfZ9zHKDBl5UmvkG2WeZ2FA7oT1EBPhF6yToBORpzgsQE7cROIcc2eZuvxe6wakBs
         nencsG+sg/Wnxk+0KA545pOpbBMtQy1oDZVoFJf32L2o/FILpj9NZ/5Suimjgn8+ZHSH
         8vfpBqLqBPj7HTSJ8Hift1KRgBRzO/j+y8uvBUg8lYSnBVNX6IvwoxLZsWgUC/GU5Ujv
         5tMZeGwmtlB5JZvaYdwnq608RdCVcORwlFc21VZAmdJ4dx1ONnVXayzdf0Tj0rD1qynt
         KW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776113751; x=1776718551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KpAgBjOPxxaIv5Hw7x6OTOEyZpKVo4Wkqvp0L0s51Ho=;
        b=ZUljqpi6T1GxdPAMQtPSvUiPVJLeYV5uZSR9ztVZeJMdBRVnh4na2QySf3qame0jUZ
         gryXwzcbJWiSnlHlKKjjCFB0gUiFMAigqScQxbory87AqrigK+rotifd3H2q8UwR8FWJ
         uw21UJLTYBcVYmiLGjO3TJ1VD+TnslvRanNX4VMvWN6sAQAEvz69sDkLP92J55Orur+f
         2Xlmt1HMoZVxUrmd63LWqk17CxL2rZSsJFFumxTBXTIymeffs9gxZi0Av1wrqy2dA41+
         cbU/QbU8laWLAqvldGZlnKbrs7Xu5YhEr56sp26rqsssrAxI6FF7qQpVlpavScZBXn5r
         Iuag==
X-Forwarded-Encrypted: i=1; AFNElJ+Xi7BHD1Sy0g02tnnPnTL9ccIBTJdFm6SDA3cC/4V3PdIX+jcHnJOXuUaWIjGYmrQn29D9XLgEX1Tloi/hFzIj@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1TvJ9sKb1o+ugRjN0GFYH/y/NPyNjhFa+HTxEwCKlNUxUaUE
	kOD6nBZa0hYbXU8IeflKUeYhJ6K8OS/+9p3jYqXA0f5qqQx95lYJMlGlvOvXoOGIMFJMaPxdZ9x
	6HGcDgqBB+lcmGmLR32Uyfy+ldKCcCTCavLnTtKfZ
X-Gm-Gg: AeBDiesiBxxj2xXXmvqErkG/fdbM7UDf6eAgcgPv75y0y44jK/qgXbdc1BaXLjQqV4/
	Y0caYvnlpbgCd8yNDpI0zwmfKaxXkssRvewWcwEiDuWP3u9bH+MyDswiO2jmzGhlMQjRz6eSRmq
	1z4Yql3FICdNdtWI7ghl5HH5VkOp5JK5Azi/kA5BeErLEjBjv0ErerFHQKK9zvHqao30MlCJ93k
	171Q3t/1iFIGVph5eJxyKR3q8CG4tcLgk6kb/T/Be2QUvsTtIxC5SY15CHXtnQN5f08S81+vVL6
	b6YXPFuSwg6wnfBJxbny2iz0FVnlhKKIR7+V17DfBnNBfMaC
X-Received: by 2002:a17:902:d58c:b0:2b4:60e6:44bc with SMTP id
 d9443c01a7336-2b460e648c0mr3010805ad.13.1776113750970; Mon, 13 Apr 2026
 13:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com> <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
 <ad0cfz-gUKea5bI8@google.com> <CAP-5=fVs9vhofGdgE6MjAY6QND=VvfEmj1j8jz5ytC5ehAwYog@mail.gmail.com>
 <ad1P8ebyCyfKwXH6@google.com>
In-Reply-To: <ad1P8ebyCyfKwXH6@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Apr 2026 13:55:39 -0700
X-Gm-Features: AQROBzC85fpCTmAm9d59T0yve-x7tjO9ZS_zhPWRpnGzM7HB9ovd0tUBfPIeBwQ
Message-ID: <CAP-5=fWC7JT4mn-JwBpZ6YvUm4qBFp=wOb+bOj8AM79gxHK0_w@mail.gmail.com>
Subject: Re: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 1:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Apr 13, 2026 at 09:57:02AM -0700, Ian Rogers wrote:
> > On Mon, Apr 13, 2026 at 9:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Sun, Apr 12, 2026 at 05:52:57PM -0700, Ian Rogers wrote:
> > > > On Sun, Apr 12, 2026 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> [SNIP]
> > > > > I've picked the first 23 patches to tmp.perf-tools-next as the re=
st
> > > > > still has some issues.  Also I've touched some commits to either =
remove
> > > > > some parts or split them into separate commits.
> > > > >
> > > > > Please take a look.
> > > >
> > > > Hi Namhyung,
> > > >
> > > > thanks for doing this but I've done a similar clean up. To totally
> > > > separate the evsel refactoring from the rest of the changes, to fix
> > > > the address sanitizer issues with kwork, etc. I'll incorporate your
> > > > changes and then resend the series.
> > >
> > > Thanks, I'd like to merge what's in the tmp.perf-tools-next unless
> > > there's a serious mistake.  You can rebase the rest changes on top.
> >
> > I'd drop what's in tmp.perf-tools-next. Otherwise we're putting fixes
> > on top of fixes. Looking at v12 the sashiko issues are all minor and
> > the progression of the patches is more granular and natural.
>
> The goal is to reduce the amount of work (including review) during the
> merge window.  Also I don't think there are many fixes in the tmp
> branch (have you looked at it?).  I think it's ok to add fixes on top
> in this case but I can drop non-conversion patches if you want.

While I'm glad the patches are landing, since the changes depending on
the refactor haven't been posted and won't make the 7.1 merge window,
I don't think there's a huge rush to land this series. That said, I
think v12 is in a good place regarding both the shape of the patches
and Sashiko happiness.

Thanks,
Ian

> Thanks,
> Namhyung
