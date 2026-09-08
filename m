Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD43B5E07;
	Tue,  8 Sep 2026 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903782; cv=none; b=hoxqbaVu5V/yvtIptn2j2PyxbdrgRuiyu4jchcNrES07ZlOa2M1MLgvY6PY81NiCWtKaxp43vC/nkkIby30CY2QljUgiL9hqVM76Le69HEuNwGFdyVdaUJK8PgMFkWb7Rj8mvof37SPzSW1ZFMtaDGGvuuUmwc+SGwwHdWXFibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903782; c=relaxed/simple;
	bh=Xah+2sySx8InBTsnc0T1l5EGSkKk3hEyfjZ158J9qes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGoZkA8QWQY8vnAGS+y6osAoCZtGwuRTDHs3UIlGqL6YkfxeC4k0cLTLrrxdkaK0pIAPFeCRbe0pdqy0a2Z+ogizntpwKf6bybUAp5THBSA/cb3cYIpVxhdC6XXBNHKtlJQSpr+WA0pn0RtAySb72GXo7XXk8Z50zQ/yIofRJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5Oqz+uL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5Oqz+uL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B6B1F00A3A;
	Tue,  8 Sep 2026 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788903781;
	bh=DHDiFUJPU9DpFXsO70TnUUTRvKy0207l/ZV7s11Rb9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e5Oqz+uLp/Q0LqKKN//3rcOqxhlIMkN9nNzINBI261GhN/pF4wGi7toYR0we78D/+
	 LwaZFBX1LHDUmStKqbgJp3YZ7/rrNt5CDusPL6iv1meFBIGMyNxHvu3+375NfFK3K4
	 7vgy9J/OqIbc++T+Hif/OXoUNQ+r5SrdKdtdNA/schnkuiGyl4H4r6NzEOnDpmGcQS
	 hlmHNkWr1vxPRZErstGTI3fNA8yFYFXg4HtGjvHlQWmZ4tN5mudF7PWmzckpW5VDfE
	 FiSx822i/C0Zva084+v0mTBCm3eWSsJphQ2BjxsrnrU6AZNRXqoQNc5K9wJU8nZng2
	 V6aMd7DR09iaQ==
Date: Tue, 8 Sep 2026 18:42:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next] perf trace: Add upper bound checks for
 augmented BTF struct printing
Message-ID: <aqCBYgUdk7BC6hqE@x2>
References: <20260906011132.279321-1-atomlin@atomlin.com>
 <20260906012359.19E5A1F00A3A@smtp.kernel.org>
 <qvftc7cs32spanwvoyh6mgn67tlsuoa76kkgvkt5uaabocw2ry@ohd4ctv5ulyx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qvftc7cs32spanwvoyh6mgn67tlsuoa76kkgvkt5uaabocw2ry@ohd4ctv5ulyx>

On Sat, Sep 05, 2026 at 09:32:27PM -0400, Aaron Tomlin wrote:
> On Sun, Sep 06, 2026 at 01:23:58AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] The patch adds bounds checking to `btf_struct_scnprintf` to prevent buffer over-reads and integer overflows from untrusted `perf.data` files, but identical vulnerabilities remain unfixed in several other augmented argument formatters.
> > --
> > 
> > commit 292e31352e85e8bac1a8cec2bc218077f4783d42
> > Author: Aaron Tomlin <atomlin@atomlin.com>
> > 
> > perf trace: Add upper bound checks for augmented BTF struct printing
> > 
> > This commit adds bounds checking to btf_struct_scnprintf() when
> > pretty-printing augmented struct payloads. It prevents buffer over-reads and
> > integer overflow when parsing untrusted perf.data files.
> > 
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index be19d70eba092..20fffc24507b5 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -1133,12 +1133,13 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
> > >  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
> > >  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> > >  
> > > -	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size <= 0 ||
> > > +	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
> > >  	    arg->fmt == NULL || !arg->fmt->from_user)
> > >  		return 0;
> > >  
> > >  	augmented_arg = arg->augmented.args;
> > > -	if (augmented_arg->size <= 0)
> > > +	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
> > > +	    (size_t)augmented_arg->size < type->size)
> > >  		return 0;
> > 
> > [Severity: High]
> > This is a pre-existing issue, but while this change correctly adds bounds
> > checking to prevent buffer over-reads and integer overflows in
> > btf_struct_scnprintf(), identical vulnerabilities remain unfixed in several
> > other augmented argument formatters.
> > 
> > When a crafted perf.data file provides an artificially large
> > augmented_arg->size or a truncated payload buffer, could the following
> > formatters still be vulnerable to out-of-bounds reads or state corruption?
> > 
> > In tools/perf/builtin-trace.c:
> > syscall_arg__scnprintf_augmented_string():
> >     size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size,
> >                                augmented_arg->value);
> >     int consumed = sizeof(*augmented_arg) + augmented_arg->size;
> > 
> > This lacks validation that arg->augmented.size is >= sizeof(*augmented_arg),
> > fails to bound augmented_arg->size against the remaining payload buffer, and
> > performs a pointer advance calculation that can overflow and corrupt parsing
> > state.
> > 
> > In tools/perf/builtin-trace.c:
> > syscall_arg__scnprintf_buf():
> >     for (int j = 0; j < augmented_arg->size; ++j) {
> > 
> > This unconditionally iterates up to augmented_arg->size without bounds
> > checking against the remaining payload buffer arg->augmented.size, leading to
> > buffer over-reads.
> > 
> > In tools/perf/trace/beauty/perf_event_open.c:
> > syscall_arg__scnprintf_augmented_perf_event_attr():
> >     struct perf_event_attr *attr = (void *)arg->augmented.args->value;
> > 
> > This fails to ensure arg->augmented.size is large enough to contain the
> > perf_event_attr struct before casting and reading from it.
> > 
> > In tools/perf/trace/beauty/sockaddr.c:
> > syscall_arg__scnprintf_augmented_sockaddr():
> >     struct sockaddr *sa = (struct sockaddr *)&arg->augmented.args->value;
> > 
> > This reads fields like sa->sa_family without any payload size validation,
> > leading to potential out-of-bounds reads.
> > 
> > In tools/perf/trace/beauty/timespec.c:
> > syscall_arg__scnprintf_augmented_timespec():
> >     struct timespec *ts = (struct timespec *)arg->augmented.args->value;
> > 
> > This dereferences struct fields without verifying that the payload contains at
> > least sizeof(struct timespec) bytes.
> > 
> > Would it make sense to update these other formatters to include the same
> > bounds checking being added here?
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260906011132.279321-1-atomlin@atomlin.com?part=1
> 
> Acknowledged.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
