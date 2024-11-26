Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219CBE46
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638468; cv=none; b=D8SHUjKLitK98+hnF2Kx6Ed00fpKR5cEvUQtUrK7qmjq+hYTMmmEIlA2TLIqP93r0FNtNrouKmOt+G1Uk81HS1wExVLz9kl1hpMVlWvPYZ69CSLIEbs1ucKc/ZZsr04wnHwgj/cmRyeiIIZ0dMy3+y794is9jCM1jwULj5sYc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638468; c=relaxed/simple;
	bh=1YyvtxGhrxW5PWtGGCmDxArLDrYkibGuNpq3TPm6mp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1jLpvGuSuY7nhS2q1F4Z+WStgBdodN80aDsljzb5cZ0eg/XK2s7imLd3DQiaOvGFgTJhYUzYfJ0b2y0azxFEKvc1gixaoutzQRcKRTWYixXZrcT6iJeh/QIbsZmeefCpjX9oR46UQczNPa9uP5xjCAM74nC3VvGe9i52Xm+L5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyiIq0ma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyiIq0ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB55C4CECF;
	Tue, 26 Nov 2024 16:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732638467;
	bh=1YyvtxGhrxW5PWtGGCmDxArLDrYkibGuNpq3TPm6mp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyiIq0mafBIAsWkg/G96vp95//wJPRbql0y6V7YASeryOSUUz/LjuGe269E1zn837
	 bw/h+ZYY2YI6DMTkGSstOrSeYR/D6Zkx4TUtFcrCxv1QL1DNUEAkb2SaxPthbt6slm
	 7QN+b4uYkw6FP1xPxqM6TWXLCTKQKaiNdCCZTiQ7FysBE1gBFbdvFoDCwxNm0KbHtM
	 gbyebdXnSlUkmwumwiSeaQvqKIq8pgk50e0Hk1YTj19Xw9cjWQkpPxrs32RXovPFcN
	 gFePk7tPw6wdlKvaHbsDLbdji5iabRgVwTU7vXh2t3cD0ltzMJ4FdaplanMUm0CCBg
	 Af21C11tLRcTA==
Date: Tue, 26 Nov 2024 13:27:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf test for inet_pton probe fails to match stacktrace
Message-ID: <Z0X3AYUWkAgfPpWj@x1>
References: <Z0D5FDu/sErQ0V/2@gentoo.org>
 <20241124105053.GA812108@e132581.arm.com>
 <Z0R3ySrb8iZQd17O@gentoo.org>
 <Z0VXvySyHm4q4r2c@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0VXvySyHm4q4r2c@google.com>

On Mon, Nov 25, 2024 at 09:08:15PM -0800, Namhyung Kim wrote:
> Hello guys,
> 
> On Mon, Nov 25, 2024 at 02:12:41PM +0100, Guilherme Amadio wrote:
> > Dear Leo,
> > 
> > On Sun, Nov 24, 2024 at 10:50:53AM +0000, Leo Yan wrote:
> > > Hi Guilherme,
> > > 
> > > On Fri, Nov 22, 2024 at 10:35:16PM +0100, Guilherme Amadio wrote:
> > > 
> > > [...]
> > > > [...]
> > > 
> > > This is not the first reported failure on this case, see [1] for
> > > previous one.
> 
> Right, and I'm also seeing the failure now.
> 
> > > 
> > > I assume you are working on x86_64 machine.  Could you confirm if the
> > > change below can fix your issue?  If yes, I will send a formal patch.
> > 
> > Indeed, I am working on an AMD 3950X, and have glibc 2.40 installed.
> > The patch you sent didn't work out of the box, but with minor modifications
> > I could fix it. I just needed to replace nm -D $libc with nm $libc for it work.
> > The reason is that gaih_inet doesn't show with nm -D for my glibc:
> > 
> > $ nm -D /usr/lib64/libc.so.6 | grep getaddrinfo
> > 0000000000116a40 T getaddrinfo@@GLIBC_2.2.5
> > 000000000010c140 T getaddrinfo_a@GLIBC_2.2.5
> > 000000000010c140 T getaddrinfo_a@@GLIBC_2.34
> > $ nm /usr/lib64/libc.so.6 | grep getaddrinfo
> > 0000000000116a40 t __GI_getaddrinfo
> > 000000000010c140 t __getaddrinfo_a
> > 0000000000115e53 t __libc_getaddrinfo_freemem
> > 0000000000116a40 T getaddrinfo
> > 000000000010c140 T getaddrinfo_a@@GLIBC_2.34
> > 000000000010c140 T getaddrinfo_a@GLIBC_2.2.5
> > 
> > $ nm -D /usr/lib64/libc.so.6 | grep gaih_inet
> > $ nm /usr/lib64/libc.so.6 | grep gaih_inet
> > 0000000000115405 t gaih_inet
> > 00000000001139b2 t gaih_inet_serv
> > 0000000000177780 r gaih_inet_typeproto
> > 
> > Using nm $libc in both cases, and increasing max-stack to 4 allows the test to pass:
> > 
> > $ sudo ./perf test -vF pton
> > --- start ---
> > ping 1237113 [000] 18561.204983: probe_libc:inet_pton: (7f7c34d38eb7)
> > 7f7c34d38eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> > 7f7c34d4b517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
> > 7f7c34d4cb73 getaddrinfo+0x133 (/usr/lib64/libc.so.6)
> > 55680ac46518 [unknown] (/usr/bin/ping)
> > ---- end ----
> >  86: probe libc's inet_pton & backtrace it with ping                 : Ok
> 
> I think it's very fragile as it depends on specific entries in the call
> stack.  As we want to test if perf probe (for uprobes) and perf record
> working correctly, maybe it can just check the number of samples only.
> 
> Arnaldo, what do you think?

That would reduce the usefulness of the test as it would be testing
fewer aspects of perf's functionality, including backtraces from uprobes
in addition to backtraces in general.

So I think Leo has a point in a followup message to this one where he
seems to have identified a subset of functions that are present in the
architectures we test?

- Arnaldo
