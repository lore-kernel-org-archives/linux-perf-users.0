Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC926AFC;
	Thu, 10 Oct 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577916; cv=none; b=HBAn7qWe90rVxkqtqM/AylZWIb/fYe+xTqn/5t+hHNWX+bBudB/906pH4GNab8mvAtzSYKZL7BKKE0i5BA23Qtlievy2nxd22KwOz8Sd2StB/THKTSXOz4A6aQ+cZma7u+6g9WtjV0nx+B777BC9nt3Cm/knxMZ6aBHlvsDYtqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577916; c=relaxed/simple;
	bh=ISMg2hg05B+ooD5IxBVrLLWhhuz9hf2nRGppEGJnpSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elVDjaVh1sxPWSqUgOVglVOkUsr5fEO9A/2GVvSRRVPcNxvCKWgbPgo0ozp6crxixQpK5+PF66CwxuVjrgCZBaIX0hI7XccJNlF+UI5yrHuaBhQvhdBnJnF84iYnjsJqF6YCA8qp/p1P6CK++GGEc/jmTzwX0Z8ZcxP7/0pADIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFmGEv4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFmGEv4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95A3C4CEC5;
	Thu, 10 Oct 2024 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577916;
	bh=ISMg2hg05B+ooD5IxBVrLLWhhuz9hf2nRGppEGJnpSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFmGEv4CSUPv+/iN9dxYJZpRvvY3XTdVtztb2t9+gC4DyKnJm2eNnR3HT3hTcpfdm
	 wIA7vdfVueibSQLFxNBy8LneDggdPv5Ig/NEPWOH8ghO2715ERPLcDMT+X8MPPwF9B
	 2Tej5WED9MCzRTmu/7iS3sqCs7j5X+CL9TvJ280VmhWc3L+luq6yCgHluYzLGoGwXv
	 ND1KQ5s2dJLo9HfG4mmOZtfo6SD74KqDme3lEm+CYU59JW/wmX73RBl6z/kSWa51SP
	 fXFMQW8OyZ/sbA5RG/e+kEGceOwrPMDP2QJOwN3O7GgNY/kVwEO6O9PtdKmdk1u01p
	 4gYyKCiuDz6dw==
Date: Thu, 10 Oct 2024 09:31:54 -0700
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
Message-ID: <ZwgBenahw7EImQLk@google.com>
References: <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1>
 <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
 <ZwgAzde-jVyo4cSu@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwgAzde-jVyo4cSu@google.com>

On Thu, Oct 10, 2024 at 09:29:01AM -0700, Namhyung Kim wrote:
> On Thu, Oct 10, 2024 at 10:22:12AM +0200, Jiri Slaby wrote:
> > From 3d4f06d79c949a8f155c20652b4f685540899ad4 Mon Sep 17 00:00:00 2001
> > From: Jiri Slaby <jslaby@suse.cz>
> > Date: Thu, 10 Oct 2024 09:57:07 +0200
> > Subject: [PATCH] perf: fix non-listed archs
> > 
> > Suggested-by: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Also with,

Fixes: 7a2fb5619cc1fb53 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")

> 
> Arnaldo, can you please pick this up for v6.12?
> 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/util/syscalltbl.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> > index 7c15dec6900d..6c45ded922b6 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
> >  #include <asm/syscalls.c>
> >  const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
> >  static const char *const *syscalltbl_native = syscalltbl_loongarch;
> > +#else
> > +const int syscalltbl_native_max_id = 0;
> > +static const char *const syscalltbl_native[] = {
> > +	[0] = "unknown",
> > +};
> >  #endif
> >  
> >  struct syscall {
> > @@ -182,6 +187,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> >  	return audit_name_to_syscall(name, tbl->audit_machine);
> >  }
> >  
> > +int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
> > +{
> > +	return idx;
> > +}
> > +
> >  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
> >  				  const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
> >  {
> > -- 
> > 2.46.1
> > 
> 
