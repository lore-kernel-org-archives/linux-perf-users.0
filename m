Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0B1C8FBC;
	Fri, 11 Oct 2024 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673575; cv=none; b=HXmWKQrE00sYR4M9vGihNA2RYljie4jkSGvnSmrkJW7i3pja9m0lmQ0hn7a4MJRJvama1PIw3F1zqrjSHw3mv8uZjBY6Pfww4LS8Gv3E7foKzMyjRCJAMu7hnxz1GrltBNIYwojDULARrVlHxi58WTqthnVzVhdLX+wBtGOZIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673575; c=relaxed/simple;
	bh=Y8vciS4w8CNS5JknxHT9uB8xv4bvavSHUYFEFQvNuSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaBQZcwZrjbNPg+pVWNomn9JpGs5PsyHcPjHyNEMLuozPpofGM1FCjWyiibSmAPSIr2iItQIhnpkPZ4ky4kZih37u5kj+hZ2nfrwNQrjq2FAloXXZH2OS0nBnFjLnipxXNVOxXKrO/XyncnEHvrU9IX5mcW8GD0nSJRvzRVd8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIjMVL/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIjMVL/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD84AC4CECD;
	Fri, 11 Oct 2024 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728673574;
	bh=Y8vciS4w8CNS5JknxHT9uB8xv4bvavSHUYFEFQvNuSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIjMVL/DCsRu9zYcVEDv5fHM/0KJCnjVZiADzglrzGerY/pmhu2xYxUdNLgyp3fQ2
	 MW1WIdoh9mJdFCHfNoOUV+WRV0GfiaSX60Jnd2euGq728L5XwIf+GXtKzYYhIcYfZq
	 JN6VtM00QUm3mVmVrVRQSutjNG/MAYGP9nQxAE83hXBItXs2WHXfJpG8BzGN8rVR2z
	 fAUZLEspnQs8UOlCi48CzGvs1sLB1TJ6tPKS0IpGggY63csEWG4PqjZUIPlEUalIXK
	 Qp6obI1/6/z0tJQ7lwD8GNMyvqNXGVHLSfANojCMRu78Fz5+VFavxZK3S06zeUjL7y
	 8LFaFh1AbtbJQ==
Date: Fri, 11 Oct 2024 16:06:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
Message-ID: <Zwl3IsgE3drp7mLo@x1>
References: <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
 <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
 <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
 <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
 <9bbfe425-1f2b-4846-a5a3-a31618742e9a@oracle.com>
 <CAH0uvojJ1rME4hb6NfrA4NPj2XmGMDLOLP3wEbHh8B5-qWGvFQ@mail.gmail.com>
 <CAH0uvohW7_st0i=ek8rc_SucuQEQUgs+fWt12cc3jqiYfxAjmw@mail.gmail.com>
 <ZwcnVKn3wVSSMcaL@google.com>
 <CA+JHD93JgJL_4GJFcFUNu-FpNfFOoyDRJ7QuvO82M8G1EwM5pQ@mail.gmail.com>
 <bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org>

On Thu, Oct 10, 2024 at 10:00:41AM +0100, James Clark wrote:
> 
> 
> On 10/10/2024 2:20 am, Arnaldo Carvalho de Melo wrote:
> > On Wed, Oct 9, 2024, 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > > On Tue, Oct 08, 2024 at 12:27:24AM -0700, Howard Chu wrote:
> > > > Hi Alan, Arnaldo and James,
> > > > 
> > > > This problem was solved in [PATCH 0/2] perf trace: Fix support for the
> > > > new BPF feature in clang 12 (Link:
> > > > 
> > > https://lore.kernel.org/linux-perf-users/20241007051414.2995674-1-howardchu95@gmail.com/T/#t
> > > ),
> > > > sorry I forgot to cc you two.
> > > > 
> > > > Alan's thought was correct. Thank you so much! :)
> > > 
> > > It'd be great if any of you can test this change.  Now I only have
> > > machines with clang 16.
> > > 
> > 
> > I'll test this tomorrow.
> > 
> > - Arnaldo
> > 
> > > 
> > > Thanks,
> > > Namhyung
> > > 
> > > 
> > 
> 
> Tested with clang 15:
> 
> $ sudo perf trace -e write --max-events=100 -- echo hello
> 
>   0.000 ( 0.014 ms): echo/834165 write(fd: 1, buf: hello\10, count: 6)
> 
>                                            =
> 
> Tested-by: James Clark <james.clark@linaro.org>
> 
> 
> Unrelated to this change, I noticed that with older clangs or with
> BUILD_BPF_SKEL=0 that commit b257fac12f38 ("perf trace: Pretty print buffer
> data") changes the buffer address to print nothing, and the '6' return value
> is missing. Not sure if this was intended or not:
> 
>  $ sudo perf trace -e write --max-events=100 -- echo hello
> 
> Before:
>      0.000 ( 0.009 ms): echo/772951 write(fd: 1, buf: 0x58c415257440,
>         count: 6)                           = 6
> 
> After:
>      0.000 ( 0.009 ms): echo/760370 write(fd: 1, buf: , count: 6)
> 

I noticed this with fedora:40, and bisected it to:

⬢[acme@toolbox perf-tools]$ git bisect good
b257fac12f38d7f503b932313d704cee21092350 is the first bad commit
commit b257fac12f38d7f503b932313d704cee21092350
Author: Howard Chu <howardchu95@gmail.com>
Date:   Sun Aug 25 00:33:19 2024 +0800

    perf trace: Pretty print buffer data
    
    Define TRACE_AUG_MAX_BUF in trace_augment.h data, which is the maximum
    buffer size we can augment. BPF will include this header too.
    
    Print buffer in a way that's different than just printing a string, we
    print all the control characters in \digits (such as \0 for null, and
    \10 for newline, LF).
    
    For character that has a bigger value than 127, we print the digits
    instead of the character itself as well.
    
    Committer notes:
    
    Simplified the buffer scnprintf to avoid using multiple buffers as
    discussed in the patch review thread.
    
    We can't really all 'buf' args to SCA_BUF as we're collecting so far
    just on the sys_enter path, so we would be printing the previous 'read'
    arg buffer contents, not what the kernel puts there.
    
    So instead of:
       static int syscall_fmt__cmp(const void *name, const void *fmtp)
      @@ -1987,8 +1989,6 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
      -               else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
      -                       arg->scnprintf = SCA_BUF;
    
    Do:
    
    static const struct syscall_fmt syscall_fmts[] = {
      +       { .name     = "write",      .errpid = true,
      +         .arg = { [1] = { .scnprintf = SCA_BUF /* buf */, from_user = true, }, }, },
    
    Signed-off-by: Howard Chu <howardchu95@gmail.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/r/20240815013626.935097-8-howardchu95@gmail.com
    Link: https://lore.kernel.org/r/20240824163322.60796-6-howardchu95@gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>


Just did a:

⬢[acme@toolbox perf-tools]$ git checkout b257fac12f38d7f503b932313d704cee21092350
Updating files: 100% (12326/12326), done.
Note: switching to 'b257fac12f38d7f503b932313d704cee21092350'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.
<SNIP>
HEAD is now at b257fac12f38d7f5 perf trace: Pretty print buffer


make clean + rebuild and the returns are gone, if I do:

⬢[acme@toolbox perf-tools]$ git checkout b257fac12f38d7f503b932313d704cee21092350^
Previous HEAD position was b257fac12f38d7f5 perf trace: Pretty print buffer data
HEAD is now at cb32035214b9a09d perf trace: Pretty print struct data
⬢[acme@toolbox perf-tools]$ 

clean + rebuild instead I get those returns back:

Now staring at it...


- Arnaldo

