Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148293F4DFD;
	Tue, 29 Sep 2026 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705890; cv=none; b=SFKmzJ/USX+BVBPnRUJSXv347FQuRtEMPKjUikdJMg58D7EVvHtAsq6SC34YzpFwekm/wetzUDofsy7TQYyGz2yfRPESrWCucSz7Zz2YsVAkUy3yd1Nz6fFUV0H0Qbq4GAjP/qZb/XBTYkQ/CWRFRH48pH8veh+YSVjbYhNhS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705890; c=relaxed/simple;
	bh=n12k9jNsYiO+U6abYZvef3xbXUa5cRFZDIkdwGTxhsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR7RlXJMXVlxZpeLGkw2G3bVGFMdp6qXME2VyaY4QPjKkKNOMcyZq/WPNukyOZxYP+HAb7MfdOYZHJ0CjV3qw7LzCFzI/tuPFsRWLzoZrchQW0RP8U1kiECt2ykDOpdesGxX0L/WKTYkOLT/jXWtihVDsr5PDyDAEtOvazsLg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3RYSjUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3RYSjUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2121F000FF;
	Tue, 29 Sep 2026 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790705888;
	bh=1deIQLdniB3DEjDBonBvuKnJ1ThGGhE7olhOycWsIF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U3RYSjUYJtyya8PbpFT9gT6KlpaxNI+IZdM1U4mgvD6vM9l+uJ+nmy0/YVcWL/8A2
	 tFEFjBpgVYu2I/l/NRhdo/HYX7AlUMzeh0BJ85OANE9wEhfJ/cE8ad0ujVvWz6wpGY
	 TzFncNJgDpKwASGOQsVKUkUMYAqY6vLnzP/qgr9d9k3dUMnK4i08611Cs+Hjmip+kq
	 ElsZ33FpCJ5Yvm73KxQQZLdCT+P18rMO//I761SJpvbcdMszFpXkPnLMqiaqHkxlag
	 iRR/l5HjxpthztODwDlqejTWjqCoS0HrGLjXsM/Rp5Ud913NkFqIq0MvnzetnPyJIA
	 ITDN9X3IBCjfg==
Date: Tue, 29 Sep 2026 11:18:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/8] perf tools: Check system path when check debuginfo
Message-ID: <arwA36u1stwk0rkg@google.com>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-4-namhyung@kernel.org>
 <20260929012302.984D51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929012302.984D51F00893@smtp.kernel.org>

On Tue, Sep 29, 2026 at 01:23:02AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf: skipping libdw fallback on stripped binaries breaks debuginfod
> --
> 
> commit b8cad86bb3e8eff20f4bbb18f568843350d829d9
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Check system path when check debuginfo
> 
> This commit refactors debuginfo__new() to check the system path via
> dso__find_dbginfo_type() rather than using an explicit fallback. The new
> approach adds DSO_BINARY_TYPE__SYSTEM_PATH_DSO to the debuginfo types list
> and removes the fallback code in debuginfo__new().
> 
> > diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> > index d6bd0fcc22648..2669d5f5ee612 100644
> > --- a/tools/perf/util/debuginfo.c
> > +++ b/tools/perf/util/debuginfo.c
> [ ... ]
> > @@ -114,18 +114,12 @@ struct debuginfo *debuginfo__new(const char *path)
> >  	dso__find_dbginfo_type(dso);
> >  	if (dso__read_binary_type_filename(dso, dso__dbginfo_type(dso), &nil,
> >  					   buf, PATH_MAX) < 0)
> > -		goto out;
> > +		return NULL;
> 
> [Severity: High]
> Does this skip the libdw fallback entirely for stripped binaries, which
> could break remote debuginfo resolution via debuginfod?
> 
> When running a tool like perf annotate on a stripped binary that lacks local
> debuginfo files, dso__find_dbginfo_type() checks for debug sections:
> 
> tools/perf/util/dso.c:dso__find_dbginfo_type() {
>     ...
> 		if (filename__has_section(buf, ".debug_info") ||
> 		    filename__has_section(buf, ".zdebug_info"))
> 			break;
>     ...
> }
> 
> Because stripped binaries fail this section check, their type is marked as
> DSO_BINARY_TYPE__NOT_FOUND even when DSO_BINARY_TYPE__SYSTEM_PATH_DSO is
> evaluated.
> 
> This causes the dso__read_binary_type_filename() check in debuginfo__new()
> to fail and return NULL early. By bypassing __debuginfo__new(), this
> prevents libdw from invoking dwfl_standard_find_debuginfo() to remotely
> resolve the debuginfo.

I think this is what Arnaldo wanted to add.  As we already have
debuginfod support, I think it's better to check it explicitly with
introducing DSO_BINARY_TYPE__DEBUGINFOD or so.

By checking sections, it would be independent from libdw support which
may be useful for minimal systems that only uses external tools like
addr2line.

Thanks,
Namhyung

> 
> >  
> >  	dinfo = __debuginfo__new(buf);
> >  	dso__put(dso);
> >  
> > -out:
> > -	if (dinfo)
> > -		return dinfo;
> > -
> > -	/* if failed to open all distro debuginfo, open given binary */
> > -	symbol__join_symfs(buf, path);
> > -	return __debuginfo__new(buf);
> > +	return dinfo;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260929011139.53242-1-namhyung@kernel.org?part=3
