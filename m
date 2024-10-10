Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C551CDA2D;
	Thu, 10 Oct 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577743; cv=none; b=ZnXE6Qe254YI/EbaE4Ipv6ZeypaoA8M7LD+fCDOXPm6eWYiqrc0MYf6eqT42ZB/fH7ApwsruJb/zZwyJAeR7WvUx+P/m1qBxkoBZVXhBpUIy74B8dAqHKiRQTP558gv0aA8pPm31v2YDYM6UMFBB2+jCgAvklhMYxQFLyuhMiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577743; c=relaxed/simple;
	bh=TBrdXowLoa11DStapwBu65uGuW9V8kKketKK1/UBAec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABOusXM7OVsnf5qK7DoPn/T6O3N6lpCHiVzHYBgnbxUkXvD2ovLZTBEWQu+OU668uws78tU+IJ+HoJl/9pKs+BIEk9DCp94sLBGHQGHYrnwzBclxVlSTff5TKBLeVEx64e9EPXHUmo2RBabp3jf7Ruf6Mw3Zr+gy3O2ZiLKROYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgbzjAsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgbzjAsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A28C4CEC5;
	Thu, 10 Oct 2024 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577742;
	bh=TBrdXowLoa11DStapwBu65uGuW9V8kKketKK1/UBAec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgbzjAsUNss8bWUCOKBn7kiVSDxj4vRjeFdl1AO/X6yicT6kdmbJ0vlNIzf6+KjNd
	 YY7dixR329oSSUTZ5gxNEUvT7ZfOu95H7jrGxDMuJ4j56jz/eBth5ImZtpeiBtiKzT
	 e9BH8DUmNmJV+89q9G9bDb9InjJpV61QDJPdeFvCFaSUkE/nJyADE+qT265EvF7qTZ
	 MQwtZnoT43H2Ft+hPadt9KbgKg3poPw65MJ4dAsxNv+AckdXJRjUjPygIoZgLTmWnw
	 foxJjANWiOLXAB2ZQlupsNXxPlmSaC7Pyc6+bKb6HblIUffFe4G/lCVCq/WdVZ//Vx
	 L4RK0PpO9PXlw==
Date: Thu, 10 Oct 2024 09:29:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <ZwgAzde-jVyo4cSu@google.com>
References: <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
 <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1>
 <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>

On Thu, Oct 10, 2024 at 10:22:12AM +0200, Jiri Slaby wrote:
> On 09. 10. 24, 8:58, Howard Chu wrote:
> > If Namhyung's fix alone does not solve the problem please try this:
> 
> Hi,
> 
> it obviously did not. But this one indeed does.
> 
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native =
> > syscalltbl_mips_n64;
> >   #include <asm/syscalls.c>
> >   const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
> >   static const char *const *syscalltbl_native = syscalltbl_loongarch;
> > +#else
> > +const int syscalltbl_native_max_id = 1;
> 
> This ^^^ should be 0 IMO. Look:
>         for (i = 0; i <= syscalltbl_native_max_id; ++i)
>                 if (syscalltbl_native[i])
>                         ++nr_entries;

Right.

> 
> > +static const char *const syscalltbl_native[] = {
> > +       [0] = "unknown",
> > +};
> >   #endif
> > 
> >   struct syscall {
> > @@ -182,6 +187,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const
> > char *name)
> >           return audit_name_to_syscall(name, tbl->audit_machine);
> >   }
> > 
> > +int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
> > +{
> > +        return idx;
> > +}
> 
> This looks somewhat familiar :):
> https://lore.kernel.org/all/739001a4-4df1-4dec-a141-926c78c5c07e@kernel.org/
> 
> I am attaching an updated patch.
> 
> thanks,
> -- 
> js
> suse labs

> From 3d4f06d79c949a8f155c20652b4f685540899ad4 Mon Sep 17 00:00:00 2001
> From: Jiri Slaby <jslaby@suse.cz>
> Date: Thu, 10 Oct 2024 09:57:07 +0200
> Subject: [PATCH] perf: fix non-listed archs
> 
> Suggested-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Arnaldo, can you please pick this up for v6.12?

Thanks,
Namhyung

> ---
>  tools/perf/util/syscalltbl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 7c15dec6900d..6c45ded922b6 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
>  #include <asm/syscalls.c>
>  const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
>  static const char *const *syscalltbl_native = syscalltbl_loongarch;
> +#else
> +const int syscalltbl_native_max_id = 0;
> +static const char *const syscalltbl_native[] = {
> +	[0] = "unknown",
> +};
>  #endif
>  
>  struct syscall {
> @@ -182,6 +187,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
>  	return audit_name_to_syscall(name, tbl->audit_machine);
>  }
>  
> +int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
> +{
> +	return idx;
> +}
> +
>  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
>  				  const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
>  {
> -- 
> 2.46.1
> 

