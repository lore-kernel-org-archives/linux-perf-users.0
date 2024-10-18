Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DE20E33E;
	Fri, 18 Oct 2024 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290394; cv=none; b=NB26uINroqkCfYY98VJsy9yo3HYbyNn89VhziVGi+2YFo6Tr31DGf83Sqyu3utsxu6vd2z6dQtKcP+E0RiAZARgvV65XIbM6KLCOt8vcBW8czuwrlVPS7OCB6O+Mp7EJcartSzf26pAh3RwLXFoICRwqJVpsZuNbWR8HMBdpXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290394; c=relaxed/simple;
	bh=/E/9e58Y9Bu5v5d8vFHuqTDsMqT8vO+kzYyBZB6p9Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGP76YrYJvY+sU/aZRzDd7bn1Rh7yPjdcgcFBEOMozAp42TBBpUqGFaePP2kR1C7nxbo4CvVafclv8AfwGqkiFgtOKIJeq8FuEd1UR4rhlvR0MuFJX4BtIZEcEcJ4oOIK8/gu5dUhNcEoP9X0a0I/x/gDAH1DE/8HRwJ6sg0RAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hofiPLwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hofiPLwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78ACC4CEC5;
	Fri, 18 Oct 2024 22:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729290393;
	bh=/E/9e58Y9Bu5v5d8vFHuqTDsMqT8vO+kzYyBZB6p9Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hofiPLwCwcR21xLWrbcPu26yoX2j+wb+o9V2cdvvJJsDF0ydvvKmkAx1myVpNXinZ
	 5AHwEgoTpINs3ayBUL8cpBQN6yQdCHxQ+lA7xwEMISsKZ0paPQgHd3iJOGpKSA9AZ9
	 sLUmDzVH1wGHzkPH9mtAQaO9FQvibVSqsMtvlF7xLtPreEZw8mhaBv/+tOFb4z61Fl
	 9PCeNF/RFL3ZxL6FM6paW/VBuIQnsQ+VBn5ueJ678uZQ4NqeziXWRP1II1RuD7xqLU
	 o+sQX+bvOSFkGw4cgxGc0GWnOUUwMeEXU/QtncEAb3G0XjKDnIlt5Zb8krg01ihkn9
	 NoZc3ROsptxfQ==
Date: Fri, 18 Oct 2024 19:26:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <ZxLglVIivPk05c97@x1>
References: <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
 <ZwgAzde-jVyo4cSu@google.com>
 <ZwgBenahw7EImQLk@google.com>
 <ZwhA1SL706f60ynd@x1>
 <2a91f9d0-8950-4936-9776-7ba59ab1d42a@kernel.org>
 <ZxLeS7CQFIR8lTmo@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxLeS7CQFIR8lTmo@x1>

On Fri, Oct 18, 2024 at 07:16:49PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Oct 14, 2024 at 02:19:58PM +0200, Jiri Slaby wrote:
> > On 10. 10. 24, 23:02, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Oct 10, 2024 at 09:31:54AM -0700, Namhyung Kim wrote:
> > > > On Thu, Oct 10, 2024 at 09:29:01AM -0700, Namhyung Kim wrote:
> > > > > On Thu, Oct 10, 2024 at 10:22:12AM +0200, Jiri Slaby wrote:
> > > > > > Subject: [PATCH] perf: fix non-listed archs
> 
> > > > > > Suggested-by: Howard Chu <howardchu95@gmail.com>
> > > > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
> > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > Also with,
> > > > Fixes: 7a2fb5619cc1fb53 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")
> > > > > Arnaldo, can you please pick this up for v6.12?
> 
> > > Sure, probably the safest bet now, but just in case, Jiri, can you test
> > > the following?
> 
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Subject: [PATCH 1/1] perf tools arm: Generate syscalltbl.c from arm's syscall.tbl
> > 
> > With this:
> > +++ b/tools/perf/Makefile.config
> > @@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
> >  ifneq ($(NO_SYSCALL_TABLE),1)
> 
> So after merging your changes (thanks) and finding an arm 32-bit system
> (ressurecting a raspberry pi 3), I can build it, with bpf skels, etc but
> then...

But if I uninstall clang and build without BPF skels, i.e. no BPF based
'perf trace' collection of syscall pointer args, I stumble in some other
problem on this debian (raspbian) system:

root@aquarius:~# ls -la /sys/kernel/debug/tracing/events/syscalls
ls: cannot access '/sys/kernel/debug/tracing/events/syscalls': No such file or directory
root@aquarius:~# 

Unsure where to find the config used to build this kernel:

root@aquarius:~# uname -a
Linux aquarius 5.10.103-v7+ #1529 SMP Tue Mar 8 12:21:37 GMT 2022 armv7l GNU/Linux
root@aquarius:~#

normally is in /boot/ but I'm no debian user, ideas?

But at least it builds, would that be enough? I don't think so, I'd like
to see this working...

- Arnaldo
