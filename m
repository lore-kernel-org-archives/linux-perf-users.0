Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C53BCD0D;
	Sat, 10 Oct 2026 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610738; cv=none; b=HSubY9CGmojvS6l4P1oKnaJEBiIqpkZXpMbaCuviRxr9GusocDpfKolbh2Dkx+H1L4OI+dOBY9g3mvIVklCtu3Jh1g0/igCp4mXY9Vtj107X8VkaT85ECU+ZjLzKnoJNF6aw/+VxMGOPjcjTvTx28tg8WVJ0hkbR2XCZgCQecsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610738; c=relaxed/simple;
	bh=1VGngVCGrJ1LQmogYLQ5US6Mgt0OyPOp1sMNSxtE6F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImlkXO3M+h3/TiZZVb9ove3svyuKl5eNKvbaoke4D2pZxzUSrt/D/6APMuZQUOYdkaAWB+NXsdnL3AO3nl7wlmL/w0C6g+EUOeDbxpNq5dMVtj8Z2W+VDG73/ws8cj0hWf387qWrfamOESCAYxdWCQ/DjuuRMJfmzWsQ1w8Itlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blyA3hWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blyA3hWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01A11F000FF;
	Sat, 10 Oct 2026 05:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610736;
	bh=H/S3BsVVOt1I1rUyCmzKrKen43y4VuP0WBfIyxvla/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=blyA3hWm/gcx4Lo9bnr1WwiwKKI7OhjhyqV+yYGiRlrN2/Qys2/KRZPiYRBZc3vdF
	 vy+n2hNt/EkrsjMt/s5cVeJAPm8EYvSYVGcVGxyM6MTIAYU0WMsfbQ5cV658AZFBRk
	 sWiRhCt+KIpD73VB+zDxv4BsZ8BapHDArr+riFE/wqULnG/41M/O8pv36MWcDM1B0H
	 4+ZRWO2bbJ5MEY+MTcfcbcjyFI1GfBUDgAaTlBcSw+ZBLI7BvvGv6p+J3s4jSNFdqo
	 bO+upmzIJVRL1zP5f2elTYq1PwMSM6cTRLEbzbS1yNTubsEeYZ5xguSFlNfm1Ym93K
	 1hq5USt8uJqVQ==
Date: Fri, 9 Oct 2026 22:38:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 02/10] perf tools: Try linked debug files for DSO
 debug info
Message-ID: <asnPb586pI28Ltxs@z2>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-3-namhyung@kernel.org>
 <sashiko-outbox-162537@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162537@kernel.org>

On Tue, Oct 06, 2026 at 11:54:46PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf: DSO_BINARY_TYPE__DEBUGLINK bypasses mount namespace fallback
> - [Low] perf: Incorrect path formatting in DEBUGLINK resolution for local files
> --
> 
> commit 8a09d3bb34892b4472de63b4949a0752ebfa1103
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
> [Severity: Medium]
> Will this addition bypass the mount namespace fallback for containerized
> workloads?
> 
> When dso__find_dbginfo_type() iterates through the types and calls
> dso__get_filename() for DSO_BINARY_TYPE__DEBUGLINK, it performs direct file
> I/O on the host path:
> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
>     ...
> 		if (!is_regular_file(filename)) {
> 			ret = -1;
> 			break;
> 		}
>     ...
> }
> 
> If the binary is containerized and not present on the host at that exact
> path, this check fails and returns -1. This early error return causes
> dso__get_filename() to exit via "goto out" before it can attempt the mount
> namespace fallback logic:

I think this is for chroot, not mount namespace.

> 
> tools/perf/util/dso.c:dso__get_filename() {
>     ...
> 	if (dso__read_binary_type_filename(dso, type, root_dir, name, PATH_MAX))
> 		goto out;
> 
> 	if (!is_regular_file(name)) {
>         ...
> 		new_name = dso__filename_with_chroot(dso, name);
>     ...
> }
> 
> Can the early file existence check in dso__read_binary_type_filename() be
> adjusted so it does not permanently bypass dso__filename_with_chroot()?

Anyway, I have concerns about namespace and chroot handling.  

It assumes live analysis and gets them from the proc filesystem entries
of the matching process.  This cannot work for cross-machine analysis
nor even for post-analysis on the same machine where pid may be reused.

I guess it didn't matter as most systems don't use namespace and chroot
much.  But it won't work well on complex systems with many containers
that use namespace and chroot.

Probably we need to make sure if it's the same process and machine
before accessing them.  But this is a separate issue and I will think
about it.

> 
> [Severity: Low]
> Does this code incorrectly format fallback paths for local files?
> 
> In dso__read_binary_type_filename() for DSO_BINARY_TYPE__DEBUGLINK, the
> directory component is extracted by searching backward for a slash:
> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
>     ...
> 		last_slash = filename + len;
> 		while (last_slash != filename && *last_slash != '/')
> 			last_slash--;
> 
> 		strncpy(dso_dir, filename, last_slash - filename);
> 		dso_dir[last_slash-filename] = '\0';
>     ...
> }
> 
> If a DSO is specified without a path separator (e.g., a local file like
> "vmlinux" in the current directory), last_slash remains equal to filename,
> leaving dso_dir as an empty string.
> 
> Later in the function, debuglink_paths[i] evaluates the formats:
> 
> tools/perf/util/dso.c:dso__read_binary_type_filename() {
>     ...
> 		for (i = 0; i < ARRAY_SIZE(debuglink_paths); i++) {
> 			snprintf(filename, size,
> 					debuglink_paths[i], dso_dir, symfile);
>     ...
> }
> 
> When evaluating formats like "%s/.debug/%s" against an empty dso_dir, doesn't
> this incorrectly generate an absolute path starting from the root directory
> (e.g., "/.debug/symfile") instead of a relative path from the current
> directory?

It seems like a pre-existing issue.  But I think filename comes from
dso__long_name() which is normally from mmap2 record and it'd be an
absolute path.

Thanks,
Namhyung

> 
> >  		DSO_BINARY_TYPE__NOT_FOUND,
> >  	};
> >  	const enum dso_binary_type *type;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006234315.920817-1-namhyung@kernel.org?part=2
