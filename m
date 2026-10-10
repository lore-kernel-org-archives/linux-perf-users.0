Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577D3DB339;
	Sat, 10 Oct 2026 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613054; cv=none; b=aATsMbLgRIrAY/srxeZ8qly5epOBq1Wd7vOPkJhM509zjXytIapHkZyTXkaHZSdKzE/gsvi2eTgSA6GB2JEl5l+qoixnfBfhyxnSPbhyc4bGDHe2MAf1sCbw//BcG3i960yc/VUzI5p4VahA3BhRGaj2EAE32ey0gBO4uioiChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613054; c=relaxed/simple;
	bh=FHJ4RVTHAL5gluEXvSuk7IeZavIdXwDKFq/azqlRNxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7JqiT7iR25DdXGtVyk+ygezqaE/sse9v4ZQczSdKpNkG/5xAnkDQlZsRH7MDZt8HpWPLZvzfYVxNoVKjsqVKDSWa3xAPmq/ir/FD94RPLwY6LP4hNf0NVdsrKg7jG7mDW1UDWItlYZCcbyNVIIIg3IxW78IbVGhGK4E+WQjxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVv0yOJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVv0yOJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984FE1F000FF;
	Sat, 10 Oct 2026 06:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791613052;
	bh=ZHsF2GeLo6AkCk4gfce6QNZ0PAb0MSQ8P4lbIU6s91o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eVv0yOJwI5tIzQ4PActSEURBBUWga2gke6w75afmjU2GAUHymEVIRMTCD/BXG1RsS
	 z6vIq80pR0+AJxjEbwIVoO6JtgEOukBYAG6E7yIYb0TaJBW4JU+rY4yyREXkEAVO2P
	 MZAzJbihfK2IP/TIkYVjzQtzilz5tndDPy5daekcA8gkLhPimny/nRWrrpl/HloG3u
	 fH0ITRz4uk2SfuNmwbIZ+nsGJrJgDqOD7R+hZ9jOXH58jcNFxxyhXfh31gGDgLko4X
	 KA5iU4Q9Vz/2KR9gtc3doJuc+3y3xwKeBU8SS5t5HOlcU4RCXq5BwMkUy7XWvXpIU1
	 sw5kfuohyIVXA==
Date: Fri, 9 Oct 2026 23:17:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 06/10] perf tools: Factor out dso__find_binary_type()
Message-ID: <asnYe2GTSVTItnkd@z2>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-7-namhyung@kernel.org>
 <sashiko-outbox-162548@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162548@kernel.org>

On Wed, Oct 07, 2026 at 12:04:51AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> - [High] perf: Guest kernel modules fail to open due to hardcoded root_dir
> - [High] perf: Strict .text section check breaks data-only DSOs and NO_LIBELF builds
> - [High] perf: Concurrent Read-Modify-Write data race on struct dso bitfields
> - [High] perf: Use-After-Free of dso->nsinfo in __dso__find_binary_type due to missing dso__lock
> - [Medium] perf: Explicitly resolved binary types are unconditionally overwritten
> - [Medium] perf: Bypassing do_open() permanently caches EMFILE failures as NOT_FOUND
> - [Low] perf: Redundant double decompression of compressed kernel modules
> --
> 
> commit 8b41de1355b0e2f1d37b604c80238237fc833f0f
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Factor out dso__find_binary_type()
> 
> Separate out the logic to detect binary type of a DSO.  It checks if the
> candidate file contains ".text" section.  It should be called under the
> _dso__data_open_lock.
> 
> Introduce bintype_searched flag and it accessors to prevent repeated
> (failed) search.
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 913877b84b2d4..f5054c18a2e93 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -833,7 +833,7 @@ void dso__data_close(struct dso *dso)
> >  	mutex_unlock(dso__data_open_lock());
> >  }
> >  
> > -static void try_to_open_dso(struct dso *dso, struct machine *machine)
> > +static enum dso_binary_type __dso__find_binary_type(struct dso *dso)
> >  	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> >  {
> >  	enum dso_binary_type binary_type_data[] = {
> > @@ -842,25 +842,103 @@ static void try_to_open_dso(struct dso *dso, struct machine *machine)
> >  		DSO_BINARY_TYPE__NOT_FOUND,
> >  	};
> >  	int i = 0;
> > -	struct dso_data *dso_data = dso__data(dso);
> > +	char *path;
> > +	bool found = false;
> > +	bool decomp = false;
> >  
> > -	if (dso_data->fd >= 0)
> > -		return;
> > +	if (dso__bintype_searched(dso))
> > +		return dso__binary_type(dso);
> > +	dso__set_bintype_searched(dso);
> 
> [Severity: High]
> Does this code introduce a data race on the struct dso bitfields?
> 
> The dso__set_bintype_searched() function modifies the bintype_searched
> bitfield under the global _dso__data_open_lock. However, adjacent bitfields
> like debuginfo_searched and long_name_allocated share the same memory
> location and are modified under different locks (dso__lock(dso) and
> dsos->lock).
> 
> Concurrent execution could cause compiler-generated read-modify-write
> operations to overlap, resulting in dropped flags or memory leaks if
> long_name_allocated is clobbered.

I was hoping it was fine just to grab _dso__data_open_lock but it seems
it should take dso__lock anyway.  I'll update the code.

> 
> [ ... ]
> 
> > +	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
> > +	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
> > +		/* We don't expect these are set; fall through */
> > +	case DSO_BINARY_TYPE__NOT_FOUND:
> > +		/* Let's find it out (for user DSOs or kernel modules) */
> > +		break;
> 
> [Severity: Medium]
> Does this fall-through discard valid binary types that have already been
> resolved elsewhere in the system?
> 
> When symbol.c successfully resolves and sets the binary type (such as
> DSO_BINARY_TYPE__SYSTEM_PATH_DSO or DSO_BINARY_TYPE__BUILD_ID_CACHE),
> this switch statement deliberately falls through. The loop below then
> unconditionally overwrites the previously valid binary type.

As I said in the comment, I don't expect for user binaries and kernel
modules to set the binary_type before this function - I'll remove one
in the dso__load() later in this series as it may not be correct.

> 
> If the fallback types lack a .text section (such as data-only DSOs), the
> state is permanently left as NOT_FOUND, preventing perf from reading them.

I'm not sure if we have a use case to access contents of data-only DSOs.
If so, I can add a check for ".data" section later.

> 
> [ ... ]
> 
> >  	do {
> >  		dso__set_binary_type(dso, binary_type_data[i++]);
> >  
> > -		dso_data->fd = open_dso(dso, machine);
> > -		if (dso_data->fd >= 0)
> > -			goto out;
> > +		path = dso__get_filename(dso, "", &decomp, dso__binary_type(dso));
> 
> [Severity: High]
> Does hardcoding the root directory to an empty string break path resolution
> for guest kernel modules?
> 
> When the fallback logic looks up types like DSO_BINARY_TYPE__GUEST_KMODULE,
> it passes "" to dso__get_filename() instead of machine->root_dir.
> 
> This causes dso__get_filename() to construct an invalid path missing the
> guest's root directory. The file cannot be found, filename__has_section()
> fails, and subsequent calls to open_dso() will fail.

This is another concern.  IMHO we handle guest samples poorly and
there's no good way to access to the guest DSOs.  Only perf kvm command
has options to access to the guest mount directory where it assumes
sshfs is available under a pid for the VMM that controls the guest.

This code is not touched for a while, and I doubt if there are any
users.  We need a better way to track guest info.

Until then, I don't want to make the APIs complex unnecessarily and just
use the hard-coded empty root directory for now.

> 
> [Severity: High]
> Does calling dso__get_filename() without holding dso__lock(dso) cause a
> use-after-free of dso->nsinfo?
> 
> The new __dso__find_binary_type() helper executes with only the global
> _dso__data_open_lock held. It calls dso__get_filename(), which invokes
> dso__filename_with_chroot() and dereferences dso->nsinfo to read the
> process ID.
> 
> Concurrently, another thread could call dso__set_nsinfo() (which acquires
> dso__lock(dso)), replacing the nsinfo pointer and freeing the old one via
> nsinfo__put(). Since this read path ignores dso__lock(dso), it can read
> the freed pointer.

Ack, will grab the dso lock.

> 
> > +		if (path == NULL)
> > +			continue;
> > +
> > +		found = filename__has_section(path, ".text");
> 
> [Severity: High]
> Does this strict .text section check break data-only DSOs and NO_LIBELF
> builds?
> 
> Prior to this patch, try_to_open_dso() discovered the DSO by calling
> open_dso(). If the file existed and was readable, the open succeeded. This
> patch introduces a strict requirement that a DSO must contain a .text
> section.
> 
> Perf commonly profiles memory data accesses (like perf mem or perf c2c)
> hitting data-only DSOs. For these files, filename__has_section() evaluates
> to false, forcing the binary type to NOT_FOUND. Furthermore, if perf is
> compiled without libelf (NO_LIBELF=1), filename__has_section() is stubbed
> to unconditionally return false, breaking user DSO loading entirely.

As I said in another reply, I think it's ok to ignore data-only DSOs.

For NO_LIBELF=1 case, it didn't implement symbol loading.  So I don't
think it'd need binary data access for a DSO.  Since the primary use
case is perf annotate which works for symbols, I think it's ok not to
implement filename__has_section() in util/symbol-minimal.c

But it'd be not so hard to do it anyway.  We can add it later if it's
really needed.

> 
> [Severity: Medium]
> Can this bypass of do_open() permanently cache EMFILE failures as NOT_FOUND?
> 
> The filename__has_section() function uses a raw open() without the FD limit
> (EMFILE) handling and LRU eviction logic normally provided by do_open() and
> close_first_dso().
> 
> If perf hits RLIMIT_NOFILE, open() returns -1, and filename__has_section()
> silently returns false. __dso__find_binary_type() then assumes the binary
> is invalid, sets bintype_searched = 1, and permanently caches
> DSO_BINARY_TYPE__NOT_FOUND, breaking data access to the DSO for the rest
> of the execution.

Good point.  Maybe it need to save the errno and restore it before
return from filename__has_section().  Then the caller can check the
errno and retry as it can be called from dso__data_get_fd().

> 
> [ ... ]
> 
> > +static void try_to_open_dso(struct dso *dso, struct machine *machine)
> > +	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> > +{
> > +	struct dso_data *dso_data = dso__data(dso);
> > +
> > +	if (dso_data->fd >= 0)
> > +		return;
> > +
> > +	__dso__find_binary_type(dso);
> > +	dso_data->fd = open_dso(dso, machine);
> 
> [Severity: Low]
> Does this result in redundant double decompression of compressed kernel
> modules?
> 
> The call to dso__get_filename() in __dso__find_binary_type() decompresses
> a compressed kernel module to a temporary file. After checking for a .text
> section, dso__put_filename() unlinks this temporary file.
> 
> Immediately after returning, try_to_open_dso() calls open_dso(), which
> ultimately calls dso__get_filename() again, forcing a second decompression
> of the exact same kernel module.

Yep, but __dso__find_binary_type() would run only once.

Thanks,
Namhyung

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006234315.920817-1-namhyung@kernel.org?part=6
