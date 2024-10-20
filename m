Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F72A1BB;
	Sun, 20 Oct 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729424143; cv=none; b=LdA3SW7TDp8zZ5N0JMN340H5rPn0ImU6pPCGJH6YFehquvJmhCGETaVozG/XTy5CspzMAMGPuGUAwnXkGarrgadkc4DTraqY2HD8mNtVcg9zsoeAaGaUHAiTuVPFQfoCgj9Jf5EjDd5Fzaaamb8nuHEh2iBaYJ9RZs5pdXUcB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729424143; c=relaxed/simple;
	bh=VaaRuCyBRkIo/n7NWbWKipHspm80+to1MIvlczVbwMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+6gbZF5WRC3QqJ2xZv3h8U4lVEvONrdBwknhzL5HbrlgbhGojY55eTghWYn1VAqWcyFY/7y8R0OoaDA208xqxT3U2ftcAcUKr+c6tZni6Xirbzl3PP7HIgbNSY72tyNsGCW9bcsazFr4WqN5BGpudyRHs2/e9TJ9t9DPdYG7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5882DA7;
	Sun, 20 Oct 2024 04:36:09 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4643F58B;
	Sun, 20 Oct 2024 04:35:39 -0700 (PDT)
Date: Sun, 20 Oct 2024 12:35:28 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jing Zhang <renyu.zj@linux.alibaba.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH] perf/tests: fix record+probe_libc_inet_pton test on
 aarch64
Message-ID: <20241020113528.GA3209400@e132581.arm.com>
References: <1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com>
 <ZxGL1LF9mVzrUGOU@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxGL1LF9mVzrUGOU@google.com>

Hi Namhyung, Jing,

On Thu, Oct 17, 2024 at 03:12:36PM -0700, Namhyung Kim wrote:
> 
> Hello,
> 
> On Tue, Oct 15, 2024 at 03:53:27PM +0800, Jing Zhang wrote:
> > Since commit 1f85d016768f ("perf test record+probe_libc_inet_pton: Fix
> > call chain match on x86_64") remove function getaddrinfo() on expected
> > file, the test failed on aarch64. On aarch64, function getaddrinfo()
> > show up in the call chain.
> >
> > $perf script -i /tmp/perf.data.1PV
> > ping 2588319 [125] 500119.122843: probe_libc:inet_pton: (ffff9a4f7410)
> >             ffff9a4f7410 __GI___inet_pton+0x0 (/usr/lib64/libc-2.32.so)
> >             ffff9a4c5f7c getaddrinfo+0xec (/usr/lib64/libc-2.32.so)
> >             aaaad6d32b38 [unknown] (/usr/bin/ping)
> 
> I'm curious how other ARM folks don't see this.  Does it depend on
> something other?

This test has several dependencies. E.g. libtraceevent and IPv6 (one
of my machines skips the test due to lack IPv6 interface).

This test is definitely a regression on Arm64 machine. I will go back to
check why this test failure is missed in our CI. If have any update,
will let you know.

> Then can we make the line optional like we did on s390 recently?

I verified two distros (one is libc-2.31 and another is libc-2.37), both of
them have the symbol "getaddrinfo":

Machine 1:

  # nm -D /usr/lib/aarch64-linux-gnu/libc-2.31.so | grep getaddrinfo
    00000000000bdf58 T getaddrinfo

Machine 2:

  # /usr/lib/aarch64-linux-gnu/libc.so.6
  GNU C Library (Debian GLIBC 2.37-16) stable release version 2.37.

  # nm -D /usr/lib/aarch64-linux-gnu/libc.so.6 | grep getaddrinfo
  00000000000d4da4 T getaddrinfo@@GLIBC_2.17
  0000000000114260 T getaddrinfo_a@@GLIBC_2.34
  0000000000114260 T getaddrinfo_a@GLIBC_2.17

I don't see the need for making the line optional. And I don't see any
requirement for adding conditional check for symbol "gaih_inet".

> > So just remove getaddrinfo() on x86_64.
> 
> I'm not sure how it works on other archs.

I have no idea neither. Maybe this patch is fine - it just rolls back to
old format for rest archs, before if the test can work well on them, then
this patch just makes it to work again.

However, this patch has a syntax error. Please see below.

> > Fixes: 1f85d016768f ("perf test record+probe_libc_inet_pton: Fix call chain match on x86_64")
> > Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> > ---
> >  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > index 47a26f2..09d7b0b 100755
> > --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > @@ -52,8 +52,12 @@ trace_libc_inet_pton_backtrace() {
> >               echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> >               echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
> >               ;;
> > +     x86_64)
> > +             eventattr='max-stack=3'
> > +             echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected

Please add ";;" at here to break switch, otherwise, it reports syntax
error.

With this change:

Tested-by: Leo Yan <leo.yan@arm.com>

Thanks for the fixing!

> >       *)
> >               eventattr='max-stack=3'
> > +             echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> >               echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
> >               ;;
> >       esac
> > --
> > 1.8.3.1
> >
> 
