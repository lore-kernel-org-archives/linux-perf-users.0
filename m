Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C62D781B;
	Tue, 13 Oct 2026 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871740; cv=none; b=hKw/aXgav6+GqTmrVMqXS1QAW1lXmVI80yKlUw27YBKNs3qLWL7sXOj/uQvb6BPnBsvz7P0c4DUDu7uBPO2yGx5cLSGR4oE22S0Agufi/92le2zPwpgx6YKiRU9y5XWmDTdTilh86IWh6wa/jwNKyMR0FClVXqEi8JsIT8OYCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871740; c=relaxed/simple;
	bh=V7qRHE0sOrWr4VC7L91xmtp55pEJEvWv0LKfm+CCxcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl75Fir+jeBS67a/J5zUPEV27IxnDJAyH8d06vSUb6OtWI+H6dyOiUtZMWcm1OUYXnLStcemfKmhe7kNV7Mfgb1o2cFFE9v+MYtEm5h9CJivrZ0xBA1cXfFw72bHDXWWNkbQ2YJl//vOcFDx6iQ7ss072lMU1AtLNZNIoL+VFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QksThlLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QksThlLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC61F00893;
	Tue, 13 Oct 2026 06:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791871737;
	bh=IFA7dz2BYrwwtS/JAKMCH+rnVUO2VvT1RVtokajLe6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QksThlLwfZISNMtKdB9MQrilm7oAJLI0+/mcPr7gBEce5dLYqdQ4G74IPUggufjWU
	 Ad3fbFvXsKibKdHDJr/P1QuEFKXm0qxOtzXaKG3gK6R8mkecFdvatsYO7EvdOQJBAl
	 4RA0rVvBvwIiO7XIoEFjPWmDZh137Hyv5SG5e0G8vRgEl8xis418Cye0CGHTYB8YTs
	 ov+u/7hRzEIlcZi7N82zUN8662ytSCYL/UXKwzVY1qE0amPkwUkO3CrZysnlWKKfei
	 Ww4jufZw6QKIAypmbGLlVBpV6UyuxFk7xOGS7tGV30wIDBBTKsB+Ip1MTqd8Fwk2I3
	 odOotBdqdskBA==
Date: Mon, 12 Oct 2026 23:08:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 02/10] perf tools: Try linked debug files for DSO
 debug info
Message-ID: <as3K-Pf9thcqGknr@z2>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-3-namhyung@kernel.org>
 <sashiko-outbox-168757@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-168757@kernel.org>

On Mon, Oct 12, 2026 at 11:56:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf dso: DEBUGLINK path resolution flaws in dso__read_binary_type_filename
> --
> 
> commit 0c61bd07a4d26ed6f7bfc347b3ec0fe6ffc13ca0
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Try linked debug files for DSO debug info
> 
> This commit modifies dso__find_dbginfo_type() to include
> DSO_BINARY_TYPE__DEBUGLINK in its search array. This allows perf to follow
> .gnu_debuglink to locate debug information in separate files.
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index df03f84c97235..913877b84b2d4 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -2111,6 +2111,7 @@ void dso__find_dbginfo_type(struct dso *dso)
> >  		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> >  		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> >  		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
> > +		DSO_BINARY_TYPE__DEBUGLINK,
> 
> [Severity: Medium]
> Enabling DSO_BINARY_TYPE__DEBUGLINK here exposes path resolution regressions in
> dso__read_binary_type_filename().
> 
> If the filename lacks slashes, does this logic create an empty string for
> dso_dir, breaking relative paths?
> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
> 	...
> 	last_slash = filename + len;
> 	while (last_slash != filename && *last_slash != '/')
> 		last_slash--;
> 
> 	strncpy(dso_dir, filename, last_slash - filename);
> 	dso_dir[last_slash-filename] = '\0';
> 	...
> }

Then it'd be a separate, pre-existing issue.  Will handle it
independently.

> 
> Additionally, does this direct host filesystem I/O bypass the container mount
> namespace (/proc/<pid>/root/) fallback context?
> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
> 	...
> 	if (!is_regular_file(filename)) {
> 		ret = -1;
> 		break;
> 	}
> 
> 	ret = filename__read_debuglink(filename, symfile, PATH_MAX);
> 	...
> }
> 
> Finally, does this inject the symfs-prefixed dso_dir into the middle of the
> /usr/lib/debug path, searching the host filesystem instead of the symfs
> chroot?

Also this is known, separate issue.  Let me handle it in a separate
series after this.

Thanks,
Namhyung

> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
> 	...
> 	for (i = 0; i < ARRAY_SIZE(debuglink_paths); i++) {
> 		snprintf(filename, size,
> 				debuglink_paths[i], dso_dir, symfile);
> 	...
> }
> 
> >  		DSO_BINARY_TYPE__NOT_FOUND,
> >  	};
> >  	const enum dso_binary_type *type;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261012234654.60666-1-namhyung@kernel.org?part=2
