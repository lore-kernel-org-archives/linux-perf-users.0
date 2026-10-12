Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0274D4879;
	Mon, 12 Oct 2026 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834636; cv=none; b=MlTSsLiNjCkViH288GxsFfhmtj311IbiyqGhFfA+pK/ueLW5Dy5X8dW8UAAoyVVcJzLugXlpohdKMUiOizw9eEdQa8A5uCQdiQQPcoXnSZq4tVagQKl1Bdr55ZMKScPaMYxXJXMvoZkBf9G2xI+CTcatzBSXe1h7F5Zub7mohSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834636; c=relaxed/simple;
	bh=BtcSxZtgzs8dzLTXWCjHX40I7DQp/xocpD9GMB5XBn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGBognB4iKsF1JE0ITe74J1yN9ObSJ/ta9hR8trIkEgRAFLXmJPYaUxX/f1hFgpuAHJKOkjMgHl5oxmAvzp9Qqw3cgmrvHyEsMyxIehAB1XHrST8+KZFhBV0erEJC/SqEdE4EX8qKjL/L7TKipI9Ms7PNi1Qm7xQ2GcTqZSyJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+YEu3SU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+YEu3SU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3F81F0089B;
	Mon, 12 Oct 2026 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791834635;
	bh=32iRW08e1z81RtNtipgmG85fqOjjtdiJjF2O8bU1sNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X+YEu3SU/T1mss1KAz3rR8NcmbVsbdSnSrJUQ7rFPVW+n+MLnn55tHeWm14Tfw6TU
	 cblaLV+Zj+gsqavSNdb22T+CCKu2ABi2a99ho21o7x3d4W8ee0kpWVx83ASFKxHOyV
	 wJjztK/Z4OgDyg42tEhAdh9VZ4Ewx/T9Y+LBf/8MlylyX0ltN2WENJgVAYEWHdv9kU
	 jnLJtxCH/NHofLktLWuVW6CFpsA5aujjQSQ4F9oQ5QfMUDNqFHXcl+xtmXNOCPYUCF
	 qZ3GAHq4/2swPxDgk9U71boRRUNhFnvhFFVbYWK9RdqlydXffkT2n8CiYHvFHRKhBj
	 dXJfM4UZzotbw==
Date: Mon, 12 Oct 2026 12:50:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 06/10] perf tools: Factor out dso__find_binary_type()
Message-ID: <as06CQ3EzPXwTvcO@google.com>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-7-namhyung@kernel.org>
 <sashiko-outbox-167683@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167683@kernel.org>

On Mon, Oct 12, 2026 at 05:38:32AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] perf: Deadlock in __dso__find_binary_type retry loop on non-recursive mutex
> - [High] perf: Invalid memory access/crash in close_first_dso() due to missing emptiness check
> - [High] perf: Loss of machine->root_dir context breaks guest/container path resolution
> - [Medium] perf: Stale errno causes spurious EMFILE failure and retry exhaustion
> --
> 
> commit 281cbe5b226891d2bef88be13adaa52f889f6f89
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Factor out dso__find_binary_type()
> 
> This commit factors out the binary type detection logic for a DSO into a
> separate function, checking for a ".text" section under the DSO lock. It
> also introduces retry logic to handle file descriptor limits by closing
> an open DSO when EMFILE is encountered.
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 913877b84b2d4..851b39c63ec86 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> [ ... ]
> > @@ -833,34 +833,142 @@ void dso__data_close(struct dso *dso)
> [ ... ]
> >  	do {
> >  		dso__set_binary_type(dso, binary_type_data[i++]);
> >  
> > -		dso_data->fd = open_dso(dso, machine);
> > -		if (dso_data->fd >= 0)
> > -			goto out;
> > +		path = dso__get_filename(dso, "", &decomp, dso__binary_type(dso));
> 
> [Severity: High]
> Does hardcoding an empty string instead of propagating machine->root_dir
> break guest or container path resolution?
> 
> In the pre-existing code, try_to_open_dso() passed the machine down to
> open_dso(), which correctly resolved paths using machine->root_dir.
> 
> Because dso__find_binary_type() does not accept a machine parameter, it drops
> the root directory context. Any binary types requiring alternative root
> directories, such as DSO_BINARY_TYPE__GUEST_KMODULE, might incorrectly
> resolve against the host's root file system, preventing proper symbol
> decoding.
> 
> > +		if (path == NULL) {
> > +			if (errno == EMFILE)
> > +				goto open_err;
> > +			continue;
> > +		}
> > +
> > +		found = filename__has_section(path, ".text");
> > +		if (!found)
> > +			saved_errno = errno;
> 
> [Severity: Medium]
> Could this read a stale errno if filename__has_section() returns false
> gracefully?
> 
> If the ELF file is parsed successfully but lacks a .text section,
> filename__has_section() returns false without setting or clearing errno.
> 
> If a previous, completely unrelated system call set errno to EMFILE,
> saved_errno would take that stale value.

Ok, I'll clear errno before calling filename__has_section().

> 
> > +		dso__put_filename(dso, path, decomp);
> > +
> > +		if (found)
> > +			return dso__binary_type(dso);
> > +		else if (saved_errno == EMFILE)
> > +			goto open_err;
> 
> This might cause an incorrect detection of EMFILE, which could then be
> mistakenly interpreted as a file descriptor exhaustion failure, triggering
> the open_err retry loop.
> 
> [ ... ]
> > +static int __dso__find_binary_type(struct dso *dso, bool needs_open_lock)
> > +{
> > +	int ret;
> > +	int retry = 0;
> > +
> > +again:
> > +	mutex_lock(dso__lock(dso));
> > +	ret = dso__find_binary_type_locked(dso);
> > +	mutex_unlock(dso__lock(dso));
> > +
> > +	if (ret == -1 && retry++ < FIND_MAX_RETRY) {
> > +		if (needs_open_lock)
> > +			mutex_lock(dso__data_open_lock());
> > +		close_first_dso();
> 
> [Severity: High]
> Is it safe to call close_first_dso() unconditionally here?
> 
> If the global file descriptor limit is exhausted outside of the perf DSO
> cache, or if the EMFILE error is spuriously triggered by a stale errno on
> the very first DSO parsed, the list could be completely empty.
> 
> Looking at close_first_dso(), it extracts the first entry from the
> dso__data_open linked list via list_first_entry() and dereferences it
> without verifying if the list is empty:
> 
> tools/perf/util/dso.c:close_first_dso() {
>     ...
>     dso_data = list_first_entry(&dso__data_open, struct dso_data, open_entry);
>     ...
> }
> 
> If the list is empty, list_first_entry() resolves to an invalid pointer,
> causing a crash upon dereference. The pre-existing caller,
> check_data_close(), safely verified limits before closing.

Ok, I'll check the open count first.

> 
> > +		goto again;
> > +	}
> 
> [Severity: High]
> Does the goto again bypass unlocking the dso__data_open_lock?
> 
> If needs_open_lock is true and dso__find_binary_type_locked() returns -1,
> the retry loop executes mutex_lock(dso__data_open_lock()) and jumps to again
> without releasing the lock.
> 
> If it fails a second time, the code evaluates if (needs_open_lock) again and
> incorrectly calls mutex_lock(dso__data_open_lock()) a second time.
> 
> Because perf uses standard non-recursive mutexes by default, acquiring the
> lock a second time from the same thread could cause an immediate, permanent
> deadlock.

Oops, right.  I'll make sure it's call only once.

Thanks,
Namhyung

