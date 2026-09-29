Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78422F767;
	Tue, 29 Sep 2026 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642270; cv=none; b=OOCHZd+nj4zworN0hqHb43uTzYT2VGq1snzy1mhqTqFcrfObBc7pES7hiRw2Q+dkHsI+pZ8XbKaGQyfn75YS0cIfu6CasszVmcgtNZoJWpXTiaiQbXfrbv2+VqKafO2zCDxtnxLhO8/j50zCBo10UjlzP10YZ0agHBZQunFzOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642270; c=relaxed/simple;
	bh=yB1MLLdCqUonDrdh0M2r/ZXHyBBJ8wDDaV8fGqrt7Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvv6ybgW7Z0yoIQpDIFoh1Wr/rf0B5NWaLfcKTLS0059o5FaQSC2zPFqeFUCMj168KSUjfrHQSDKTaRqvrkP0m+206XX/6ck7ZTTBjUkixQVw1PdP/mXs1bqQPmPdUMhs1C7hVhohdkTmR7Eb7/hpgUZgD6TiXD284ukP2xynOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2ZtA44P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2ZtA44P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE221F00893;
	Tue, 29 Sep 2026 00:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642269;
	bh=bQdz0KDwrvXOnzJTXF9iR7HnWNXiJKsAgxY8YCHN0oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2ZtA44PyxoH74UFGeTvQ0lfenSaX2Yb0spp4b2v9JWOHIsxfKvHHNzZc4k5/DMg3
	 DzIf2hmbIcOnNbo/FjpQICyuM+7hYhN+7+mf6b5RCAomURoWmzDo35n202p7GfA+uY
	 dWTUrqJhPwj33opp51pe0pFx0jJQEHHaeObzrjt5uDImRIX/VoHaPNRrilcNb67y8W
	 STfZ34LqxdKRLOPuGcP6WTUXUwMtWu3vZphCmVvbGJcfqF+w4Al8LxTHqw6+W5oy0P
	 quaR2u/5TNSJwz4Rg72FYZs5FmzQ4RQs4lpOvbtyDF73QSgpvo33tnD7DBluEQL732
	 7bRXB87HXM6wA==
Date: Mon, 28 Sep 2026 17:37:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 3/8] perf tools: Check system path when check debuginfo
Message-ID: <arsIW-1drTVVsuBR@z2>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-4-namhyung@kernel.org>
 <20260928055956.D386E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928055956.D386E1F000FF@smtp.kernel.org>

On Mon, Sep 28, 2026 at 05:59:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf tools: Loss of DWARF support for .gnu_debugdata and .zdebug_info
> --
> 
> commit 945ce7f07042383e50c7db270f3808ce02dd95b3
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Check system path when check debuginfo
> 
> This commit removes the fallback to open the given binary path in
> debuginfo__new() and instead relies on checking the SYSTEM_PATH_DSO
> type within dso__find_dbginfo_type().
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
> 
> [Severity: High]
> Does removing this fallback break DWARF support for files using alternative
> debug sections like .gnu_debugdata (mini-debuginfo) or .zdebug_info?

IIUC ".gnu_debugdata" on Fedora only carries symbol tables so it doesn't
check DSO_BINARY_TYPE__GNU_DEBUGDATA and no need to check the section.
But I think I need to add ".zdebug_info".

> 
> The new logic entirely relies on dso__find_dbginfo_type() successfully
> returning a binary type. However, dso__find_dbginfo_type() strictly
> validates the file by exact string match:
> 
> tools/perf/util/dso.c:dso__find_dbginfo_type() {
> 	...
> 		if (filename__has_section(buf, ".debug_info"))
> 			break;
> 	...
> }
> 
> Because files relying on .gnu_debugdata or .zdebug_info do not have a section
> named exactly ".debug_info", this check fails. The type then defaults to
> DSO_BINARY_TYPE__NOT_FOUND, and debuginfo__new() returns NULL.
> 
> Could this cause features like inline callchain resolution to silently fail on
> these binaries since we completely bypass libdw's native support for parsing
> these alternative formats?

Something like this?

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 10c4cd35b6d9464b..0b152988d18b60b0 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2130,7 +2130,8 @@ void dso__find_dbginfo_type(struct dso *dso)
                                                   buf, PATH_MAX) < 0)
                        continue;

-               if (filename__has_section(buf, ".debug_info"))
+               if (filename__has_section(buf, ".debug_info") ||
+                   filename__has_section(buf, ".zdebug_info"))
                        break;
        }

Thanks,
Namhyung


> 
> > +	return dinfo;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260928055055.95144-1-namhyung@kernel.org?part=3
