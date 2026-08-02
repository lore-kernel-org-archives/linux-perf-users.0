Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12E33B6D9;
	Sun,  2 Aug 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706691; cv=none; b=fb+Ty7HALCf1YpWr6ChMlbbPMoxYaB8TCQDnWVLyveoVrG22BaXo5pjB/LNji1YVVb4HdsAn1sWt0MB8AS06Gk4REaYyzmhZcLarLkSOk8e8IBiN6GC4sgaEp16h2sGC66hZZcbTx1u+tw9jCZzhuu9FHlG9IsJW/UvefkpkOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706691; c=relaxed/simple;
	bh=f9tZuXhYrS7qKoz2KTv5h0FOfiF5F3RmMxMttJsEcFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNPFRzzm+QtW0O3LGK4+c5/Xpnn481lezH56Xw6I31w6X2SgF8lfEkTaXxcuIkp08kAUNyWByZEX9CHevahPkJbdAq2T5mJGWdwn/PaXsVCfCCc6yRpTftIhkOjSdwcqtBXRgPY1vkG2IhYl5LgJFXQcUOPapZdYsBnYVxEsYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK3UdwZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK3UdwZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA36C1F000E9;
	Sun,  2 Aug 2026 21:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785706690;
	bh=GeBJuiurAH769eiU+AHBVrL8F8Y9zNqEi9Uo08xakoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BK3UdwZy3LJDGrkmRpPaxRF/pZE2kCJWbQFJO/DTxfEogTs3X7Yx/Fydf+uoQzoGJ
	 6UmIbI60fihY5f0a53UiJaX2fzkPDiUDZFwkL0merRMJxx8bWL/thk5tknCoMkAefx
	 p8jh9mc9na8BxOFjNOqGi4BewkyrBWTP/3m9dUNut/6uQICMO8oZlOENp3S6U/S3XT
	 SmC+8XuW6Jp8UGuBPwfPYf0Q5Crf+U3tyaV41WYQCv5nmB5mwXHGorG90HJR5KTJha
	 Rzcb5yo0Hg10WH9aeXFVBizqIJEaveOtN7iIx4O+5jeRHBlTr0KpW8V87bLNX4COuP
	 pqYwO2tYZxqow==
Date: Sun, 2 Aug 2026 18:38:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/5] perf dso: Guard against errno==0 when
 dso__get_filename() returns NULL
Message-ID: <am-4vxQSTAj0nve_@x1>
References: <20260802142022.154219-1-acme@kernel.org>
 <20260802142022.154219-2-acme@kernel.org>
 <20260802145829.439EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802145829.439EC1F00A3A@smtp.kernel.org>

On Sun, Aug 02, 2026 at 02:58:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Incomplete fix in `__open_dso()` causes error swallowing in callers by returning negative fd without setting `errno`.
> 
> Pre-existing issues:
> - [Medium] Data race on adjacent `struct dso` bitfields leads to corruption and a TOCTOU mount namespace leak.
> --
> 
> --- Patch [1]: [PATCH 1/5] perf dso: Guard against errno==0 when dso__get_filename() returns NULL ---
> commit db31953321ccfc3f2f28e5db31230d5fef57578f
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf dso: Guard against errno==0 when dso__get_filename() returns NULL
> 
> This commit updates __open_dso() to fall back to ENOENT when
> dso__get_filename() returns NULL but leaves errno as 0. This ensures fd
> is always negative on failure.
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 2309196d8df31..e087a89066bdb 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -643,7 +643,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
> >  	if (name)
> >  		fd = do_open(name);
> >  	else
> > -		fd = -errno;
> > +		fd = errno ? -errno : -ENOENT;
> 
> [Severity: Medium]
> Does this code need to explicitly set errno to ENOENT as well?
> 
> Callers of __open_dso() appear to check if the returned file descriptor is
> negative, and then compute their return value using errno. For example, in
> file_read():
> 
> tools/perf/util/dso.c:file_read() {
>     ...
>     fd = data_file_open(dso, machine);
>     if (fd < 0)
>         return -errno;
>     ...
> }
> 
> Since errno is left as 0, callers like file_read() will evaluate -errno
> to 0, which incorrectly reports EOF instead of an open failure. Should we
> update errno directly?

Agreed, will fix for v2.

- Arnaldo
 
> [Severity: Medium]
> This is a pre-existing issue, but can the adjacent bitfields in struct dso
> cause a data race that leaks mount namespaces?
> 
> Looking at the struct dso definition:
> 
> tools/perf/util/dso.h:struct dso {
>     ...
>     enum dso_binary_type symtab_type:8;
>     enum dso_binary_type binary_type:8;
>     ...
> }
> 
> If one thread calls try_to_open_dso() and locklessly modifies binary_type,
> while another concurrently modifies symtab_type holding dso__lock(dso),
> the concurrent read-modify-write on the shared memory word can corrupt
> binary_type.
> 
> This corruption appears to break the namespace exit check in open_dso():
> 
> tools/perf/util/dso.c:open_dso() {
>     ...
>     if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
>         mutex_lock(dso__lock(dso));
>         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>         mutex_unlock(dso__lock(dso));
>     }
>     fd = __open_dso(dso, machine);
>     if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE)
>         nsinfo__mountns_exit(&nsc);
>     ...
> }
> 
> If the bitfield gets corrupted during __open_dso(), the exit check might
> fail, skipping nsinfo__mountns_exit() and permanently stranding the thread
> in the wrong mount namespace. Should access to these bitfields be protected
> by dso__lock, or should they be separated to avoid sharing memory bytes?
> 
> >  
> >  	if (decomp)
> >  		unlink(name);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802142022.154219-1-acme@kernel.org?part=1
