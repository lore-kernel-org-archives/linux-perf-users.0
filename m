Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053048663E;
	Tue, 13 Oct 2026 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925162; cv=none; b=EKxZxhNNTqI+rbyJQEaC8+A4XkvpZ5i8qP/JwvjjikVX6G71M/s4rLyD3r5LBFWMyThxT0YLE3jD6bksOUQoOBF85e3SPNedh5Ltcm/5z+TklOC8qKDWfZvzZyi3Dh8bPcMd02xnKDY1Ra1ftAJpfU/8/tc85O8UP5iEIIDDU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925162; c=relaxed/simple;
	bh=nN2Mw3MkYM+Ufl/ZCR8hREwPPKJwTVFQU1HVr7u5gpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPJVAZSyjh5Gb/PvvvhjPZt8tmFmaXiyuA9Wfpn2Z+iM3LIBfGhzitX5F4IH3XMwIKPCi2CDzKy4FYgz3vMSaFDrvlK8pLP+GtWZuAqpQasVMIRWkbUO9yEFefJ9gk1UxgSe52FhzIrA+mat+cvAMDmrlGXnIk+q+0cbf7B3gBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvethXeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvethXeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDEF1F000FF;
	Tue, 13 Oct 2026 20:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791925160;
	bh=h9+B3H8DbXs2WE6Q2dd7O0bh3Z8eqB8w1jkQFMHi5kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QvethXeAp+uWp8xYkCX6ryVkGZjSN7FqTK+NrKE5REi21s9D1otLAbv3WiKwXyHUQ
	 u6YO+uUUo0WssMgpQbUpUZ0qY4R89V05Zaf7a8CAc7fw1+JfYhhWsRm7BG/MliMFFa
	 zygD2yioGj23+QwuF4WVsVigtJhDXS+/WbOC8kQH1uCTG6G6aswBYwiOd3dALCh0Ys
	 7kfx9ESMsQnzusIEe160i2RpedsOHZgdMlVsnBfRODdLoyZKY2nOhCFOJp5iuIYDYO
	 PoViuOBb3PuLHN8SSO7bFsHo4uwX2B4VqP1FIBYjnhYkJ1NhxMIvjIjD2fwVixsuGh
	 uW0k0UjpLpzCw==
Date: Tue, 13 Oct 2026 13:59:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 03/11] perf tools: Try linked debug files for DSO
 debug info
Message-ID: <as6bp9RN5We7fquf@google.com>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-4-namhyung@kernel.org>
 <sashiko-outbox-170238@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170238@kernel.org>

On Tue, Oct 13, 2026 at 05:34:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf tools: DEBUGLINK debuginfo resolution fails for containerized binaries
> - [Medium] perf: Uninitialized stack read when parsing malformed .gnu_debuglink
> --
> 
> commit 58954c9ee50dda18b6aba714c1a631c8845bc3e0
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Try linked debug files for DSO debug info
> 
> The dso__find_dbginfo_type() should try DSO_BINARY_TYPE__DEBUGLINK so it
> can follow the .gnu_debuglink and find the debug information in the
> separate file.
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
> Will this break debuginfo resolution for containerized binaries?
> 
> When DSO_BINARY_TYPE__DEBUGLINK is attempted, dso__get_filename() calls
> dso__read_binary_type_filename(). That function performs an early check
> on the host namespace:
> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
> 	...
> 		if (!is_regular_file(filename)) {
> 			ret = -1;
> 			break;
> 		}
> 	...
> }
> 
> If the binary is inside a mount namespace, is_regular_file() fails and
> returns -1. This causes dso__get_filename() to abort early:
> 
> tools/perf/util/dso.c:dso__get_filename() {
> 	...
> 	if (dso__read_binary_type_filename(dso, type, root_dir, name, PATH_MAX))
> 		goto out;
> 	...
> }
> 
> Will this bypass the subsequent dso__filename_with_chroot() fallback logic,
> causing the tool to miss debuginfo for containerized applications?

This is a known problem and I think it's in a broken state.  Let me
work on a fix after landing this series.

> 
> 
> [Severity: Medium]
> Could this lead to an uninitialized stack read with malformed ELF files?
> 
> When resolving DSO_BINARY_TYPE__DEBUGLINK, dso__read_binary_type_filename()
> allocates an uninitialized stack buffer:
> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
> 	...
> 		char symfile[PATH_MAX];
> 		...
> 		ret = filename__read_debuglink(filename, symfile, PATH_MAX);
> 	...
> }
> 
> If libbfd handles the read, it copies the section directly:
> 
> tools/perf/util/libbfd.c:libbfd_filename__read_debuglink() {
> 	...
> 	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
> 				      section->size))
> 		goto out_close;
> 	...
> }
> 
> Since BFD does not append a null terminator, if the .gnu_debuglink section
> is malformed and lacks a null byte, could the subsequent snprintf() in
> dso__read_binary_type_filename() read uninitialized stack memory?

This is a pre-existing issue.  Let's fix it separately.

Thanks,
Namhyung

> 
> >  		DSO_BINARY_TYPE__NOT_FOUND,
> >  	};
> >  	const enum dso_binary_type *type;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261013172155.160869-1-namhyung@kernel.org?part=3
