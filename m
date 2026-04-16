Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F63DFC87;
	Thu, 16 Apr 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350616; cv=none; b=OYrbAYbVNB07PHohbKJZtbR0DZo4QH0BcsL3O7kLR/eBKox60gwMfYoCn5I6fSbcrjg5iO0rSC9+kcFRCbmRiiOFWVGZ0eKXRmbM43ceHPyV6AXpgloiqx/kEqTbihwaFIVRofk2T6uqmR7046cGzVdotyXZ6V3I7EXN3b8bkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350616; c=relaxed/simple;
	bh=Nr3kyOY/iXNQ7TiFF686KJx3OJadZva8m6nAJb/lMJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtFK4dqTuvpBOzHUFfYHsVtcQCRAly/Fl+gOkD1MSf9WEFiEpwIgq9nrwhg/I0kifrdGc9IO/8sadD/Sw8f38MiZLyak/4s741BypwcJOlXadFAaArdPaa7s+Rhiv1xTsQTsKY1BwjjNbsvNAyfDDkuHsIhA5BeqCK+ba+K7oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izXKgom1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izXKgom1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350F0C2BCAF;
	Thu, 16 Apr 2026 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776350615;
	bh=Nr3kyOY/iXNQ7TiFF686KJx3OJadZva8m6nAJb/lMJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izXKgom1wLsdJw2Ccn7xwi42Snlj7AsGNtMqRcu2Xe7+ZKY2/Bgkf36SAzwc+Q7lH
	 WpYfc7BqlB2n6sPDwGOYI20vgHSCRVOOwBC3NWzxLusDGMrH4Hy0VGG4UlqlMBm/TO
	 OtDVWJTZNogGYkEjIeECLY8FSqhPVcwFVDJIYjX6Oc2ZkuVTPXJ/37aRh0syFCgDDG
	 iQb1Hpq1rpXEduzw0kB1Ycw+ivfJ0ZI6FAPGECG0POGFbonApN1Kh6s8xCO2qkQEWc
	 fuMil/QdEBzLuBZAlCarYFX055eV+ZEyFRLpm7tVvxgj28+qYgbDQZ47n0av5Gy/Wr
	 7oOBtMr6CbrPg==
Date: Thu, 16 Apr 2026 11:43:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/5] perf header: Add section bounds checking to the fd
 read path
Message-ID: <aeD1k3vd6Thk_NtO@x1>
References: <20260416001424.362797-2-acme@kernel.org>
 <20260416005915.B86DAC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416005915.B86DAC19424@smtp.kernel.org>

On Thu, Apr 16, 2026 at 12:59:15AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 4 potential issue(s):
> - [Critical] The newly added bounds check in `__do_read()` is vulnerable to an integer bypass on 32-bit architectures, allowing a severe heap buffer overflow.
> - [Critical] Stack buffer overflow in `perf_header__read_build_ids` and `perf_header__read_build_ids_abi_quirk` via missing size bounds checks.
> - [High] Missing null-termination enforcement in `do_read_string` causes an out-of-bounds heap read and information disclosure.
> - [Medium] Adding the section bounds check to `__do_read()` breaks `perf report --header` functionality because `perf_file_section__fprintf_info()` leaves `ff.size` uninitialized (zero).
> --
> 
> commit a967949f0160c2901e835f301c2e340a342b95db
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf header: Add section bounds checking to the fd read path
> 
> This commit adds a bounds check to __do_read() to prevent reading past the end
> of a section when using the file descriptor read path. It centralizes the
> check for both buffer and fd paths. It also updates perf_file_section__process()
> and process_build_id() to support this change.
> 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 9142a8ba40195..ca0c9e80345b2 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> [ ... ]
> >  static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
> >  {
> > +	if (size > (ssize_t)ff->size - ff->offset)
> > +		return -1;
> > +
> 
> In perf_file_section__fprintf_info(), the struct feat_fd ff is
> instantiated using a compound literal that only initializes .fd and .ph,
> leaving .size and .offset as 0.
> 
> When feature printing callbacks (like print_event_desc()) call into this
> path, will this bounds check evaluate to true (e.g., 4 > 0 - 0) and cause the
> read to fail? Could this break perf report --header functionality?

Will fix.
 
> Also, on 32-bit architectures, ssize_t is a 32-bit signed integer. If a
> crafted perf.data file provides a large 32-bit length for a dynamic feature
> (such as data_len in process_bpf_prog_info()), does the size parameter
> implicitly convert to a negative ssize_t (e.g., 0xFFFFFFF0 becomes -16)?

Will fix.
 
> If so, could this negative value bypass the bounds check and cause the
> subsequent readn() call in __do_read_fd() to overwrite memory past the
> dynamically allocated heap buffer?
> 
> [ ... ]
> > @@ -2655,7 +2655,12 @@ static int process_tracing_data(struct feat_fd *ff, void *data)
> >  
> >  static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
> >  {
> > -	if (perf_header__read_build_ids(ff->ph, ff->fd, ff->offset, ff->size))
> > +	off_t offset = lseek(ff->fd, 0, SEEK_CUR);
> > +
> > +	if (offset == (off_t)-1)
> > +		return -1;
> > +
> > +	if (perf_header__read_build_ids(ff->ph, ff->fd, offset, ff->size))
> >  		pr_debug("Failed to read buildids, continuing...\n");
> >  	return 0;
> >  }
> 
> While looking at the build ID processing updated here, does
> perf_header__read_build_ids() safely handle crafted event sizes?
> 
> If a perf.data file provides an event where bev.header.size < sizeof(bev),
> could the length calculation len = bev.header.size - sizeof(bev) underflow
> to a large positive value?
> 
> If it exceeds sizeof(bev) + PATH_MAX, would the subsequent
> readn(input, filename, len) call overflow the filename stack buffer?

will check
 
> Additionally, while reviewing the string reading operations in this file
> for regressions, does do_read_string() enforce null-termination?
> 
> The function reads a length len from the file, allocates exactly len bytes,
> and copies the data into the buffer. If a crafted perf.data file lacks a null
> terminator for a string feature, could subsequent C string operations like
> strdup or printf read past the allocated buffer and cause an out-of-bounds
> heap read?

I think Ian Rogers is working on this one.

- Arnaldo
