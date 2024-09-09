Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574471531C4;
	Mon,  9 Sep 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909570; cv=none; b=lr9sEB0ywdEhoO4ABhxfq9cwrp52n+DCd9eW+g1flaYmhnqnOXyPq7NXLxC+5QBGw3g7eubRLfAJVGpm3kFdiUZtJmalvLPX96pbRfi11mmvLwLUZKCSizoa5HXh7Vy1qOPRTt5DFqBo9XJGaWr2k+Jj0n49bJMfZrytDPz8y/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909570; c=relaxed/simple;
	bh=RmbH3WEk8oC13e+QXEcbPOiyLAz2B7STUA5EBf+zHh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0w8mO7Y8enCbJkX4OD0ghqDea1LedgqDB4jf0Fy75GnKfl58kk0GQypfz0Q7O/IuPh8KEgJLgugHb+ckNYC9BwUbONrzaPgwNUsJHCJJv7tvORgdIWxuu5zbXKW0p64JrsvXc6LpOSQ29fhXxQW7rW6Z+xD0yQDrT1SQmxFj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSkHeCly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSkHeCly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F615C4CEC5;
	Mon,  9 Sep 2024 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725909569;
	bh=RmbH3WEk8oC13e+QXEcbPOiyLAz2B7STUA5EBf+zHh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSkHeCly1TvoU+ImTsWCRqPh9bCjioYB7ebSrnhkRWugyez+Kq4hLlHRKsZMw9wZw
	 lp16LC+rLwzxDxxsqboJR+8ugtqTiF5+p/vbb5Mc2BYX9AJwtfNfuviT0r9BmSHtoA
	 i+fdQ/6khjOCQczbWpd6RHWkNd1WU4XD8fMHJtF4025hrIPbF4VQYpIHYRIFhWYvnR
	 T56ipp4ibMi16w955NwB9cnhzCKQIEa2O5a6x6SBTc8oEK2zaiMnqE6C+aCT6WyL9l
	 dPO5IK1mfCQXR4sIHFioX1TQ4YPBTHqICM3tGGWKKlg0k2VoukneN8XJefxFGJF9+P
	 5+4jdYo3aMeQA==
Date: Mon, 9 Sep 2024 16:19:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 5/8] perf trace: Pretty print buffer data
Message-ID: <Zt9KPvONtmlTWdmm@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-6-howardchu95@gmail.com>
 <Zt8jTfzDYgBPvFCd@x1>
 <Zt8mMB7rkgSY1VSD@x1>
 <CAH0uvojsnmgj-55ftARr9=6vPv55tvEtQtNp1yvUr7q46irY7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojsnmgj-55ftARr9=6vPv55tvEtQtNp1yvUr7q46irY7Q@mail.gmail.com>

On Mon, Sep 09, 2024 at 10:17:34AM -0700, Howard Chu wrote:
> On Mon, Sep 9, 2024 at 9:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Mon, Sep 09, 2024 at 01:33:17PM -0300, Arnaldo Carvalho de Melo wrote:
> > > >  static bool trace__filter_duration(struct trace *trace, double t)
> > > >  {
> > > >     return t < (trace->duration_filter * NSEC_PER_MSEC);
> > > > @@ -1956,6 +1987,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > > >                 ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> > > >                  strstr(field->name, "path") != NULL))
> > > >                     arg->scnprintf = SCA_FILENAME;
> > > > +           else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
> > > > +                   arg->scnprintf = SCA_BUF;
> > >
> > > You can't really do this for things like 'read' as we would be printing
> > > whatever is in the buffer when we enter the syscall, right? As we can
> > > see testing after applying the following patch:
> >
> > This is also valid for the struct dumper, where I'll have to add some
> > indication in the syscall_fmt table when the pointer should be read in
> > the BPF augmenter, and thus we shouldn't bother to get it in the
> > sys_enter if it is, say, fstat().
> 
> Yes you are right, problems with read buffers happen in structs too.
> I'll get my read family patch out soon to ease your pain...

And then we have things like prctl, arch_prctl where it depends on the
command to see if the arg is to go from user to kernel or the other way
around :-)

But lets leave that for later...
 
> Thanks,
> Howard
> >
> > - Arnaldo
> >
> > > root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
> > >      0.000 ( 0.004 ms): cat/291442 read(fd: 3, buf: \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0, count: 832) = 832
> > >      0.231 ( 0.004 ms): cat/291442 read(fd: 3, buf: , count: 131072)                                     = 3224
> > >      0.236 ( 0.001 ms): cat/291442 write(fd: 1, buf: root:x:0:0:Super User:/root:/bin, count: 3224)      = 3224
> > >      0.239 ( 0.001 ms): cat/291442 read(fd: 3, buf: root:x:0:0:Super User:/root:/bin, count: 131072)     = 0
> > > root@number:~#
> > >
> > > So we can't really do it at this point, we have to do it, for now, by
> > > doing it on that syscall table initialization, for instance, for the
> > > 'write' syscall:
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 5f0877e891c2047d..1bcb45e737d830bf 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -1379,6 +1379,8 @@ static const struct syscall_fmt syscall_fmts[] = {
> > >         .arg = { [2] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
> > >       { .name     = "waitid",     .errpid = true,
> > >         .arg = { [3] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
> > > +     { .name     = "write",      .errpid = true,
> > > +       .arg = { [1] = { .scnprintf = SCA_BUF, /* buf */ }, }, },
> > >  };
> > >
> > >  static int syscall_fmt__cmp(const void *name, const void *fmtp)
> > > @@ -1987,8 +1989,6 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > >                   ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> > >                    strstr(field->name, "path") != NULL))
> > >                       arg->scnprintf = SCA_FILENAME;
> > > -             else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
> > > -                     arg->scnprintf = SCA_BUF;
> > >               else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
> > >                       arg->scnprintf = SCA_PTR;
> > >               else if (strcmp(field->type, "pid_t") == 0)
> > >
> > > With that we get:
> > >
> > > root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
> > >      0.000 ( 0.005 ms): cat/296870 read(fd: 3, buf: 0x7ffe9cb8df98, count: 832)                          = 832
> > >      0.268 ( 0.004 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, count: 131072)                       = 3224
> > >      0.273 ( 0.002 ms): cat/296870 write(fd: 1, buf: root:x:0:0:Super User:/root:/bin, count: 3224)      =
> > >      0.276 ( 0.001 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, count: 131072)                       = 0
> > > root@number:~#
> > >
> > > After the following patch is applied.
> > >
> > > - Arnaldo
