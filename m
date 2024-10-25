Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00952F76;
	Fri, 25 Oct 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862433; cv=none; b=lsYc9URyVbPf+W+bLc8zVK8pYYOiwNhivTfOy8JDZ9D7nym6Y4Eq5UX61CezmMYrDM9j7YfYr84ZVi3svkrfFkdjyCMFebITWRGcUM4g+yWvTogvH6RY1MzNT+QcQOyXg/xVKDoCRl8CnGeOnXnJbffWxdxSZCZnp/eTWy25XPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862433; c=relaxed/simple;
	bh=Eudzm+dYRXS5yMi3FTODqWIFrwzENn5t60Or8yh2U6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2RyIZ90KtQjx9psncclnBSfV1LiqbxKRnxAoQlDBYE8t4OoxhtRIkbfGEglNB8b2g6ruO4oQNcDq2uiZ9StuUJWtUhPajIvlsqTBh1uDCdGoSy0qkISjviFGEq+lK0a9XaE3iYNfwnYUIWyo2TG0FCDTQICSapgdKGKaKIQg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60CAC339;
	Fri, 25 Oct 2024 06:20:57 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42D3F3F71E;
	Fri, 25 Oct 2024 06:20:27 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:20:21 +0100
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
Message-ID: <20241025132021.GB359792@e132581.arm.com>
References: <1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com>
 <ZxGL1LF9mVzrUGOU@google.com>
 <20241020113528.GA3209400@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020113528.GA3209400@e132581.arm.com>

On Sun, Oct 20, 2024 at 12:35:28PM +0100, Leo Yan wrote:

> Hi Namhyung, Jing,
> 
> On Thu, Oct 17, 2024 at 03:12:36PM -0700, Namhyung Kim wrote:
> >
> > Hello,
> >
> > On Tue, Oct 15, 2024 at 03:53:27PM +0800, Jing Zhang wrote:
> > > Since commit 1f85d016768f ("perf test record+probe_libc_inet_pton: Fix
> > > call chain match on x86_64") remove function getaddrinfo() on expected
> > > file, the test failed on aarch64. On aarch64, function getaddrinfo()
> > > show up in the call chain.
> > >
> > > $perf script -i /tmp/perf.data.1PV
> > > ping 2588319 [125] 500119.122843: probe_libc:inet_pton: (ffff9a4f7410)
> > >             ffff9a4f7410 __GI___inet_pton+0x0 (/usr/lib64/libc-2.32.so)
> > >             ffff9a4c5f7c getaddrinfo+0xec (/usr/lib64/libc-2.32.so)
> > >             aaaad6d32b38 [unknown] (/usr/bin/ping)
> >
> > I'm curious how other ARM folks don't see this.  Does it depend on
> > something other?
> 
> This test has several dependencies. E.g. libtraceevent and IPv6 (one
> of my machines skips the test due to lack IPv6 interface).
> 
> This test is definitely a regression on Arm64 machine. I will go back to
> check why this test failure is missed in our CI. If have any update,
> will let you know.
> 
> > Then can we make the line optional like we did on s390 recently?
> 
> I verified two distros (one is libc-2.31 and another is libc-2.37), both of
> them have the symbol "getaddrinfo":
> 
> Machine 1:
> 
>   # nm -D /usr/lib/aarch64-linux-gnu/libc-2.31.so | grep getaddrinfo
>     00000000000bdf58 T getaddrinfo
> 
> Machine 2:
> 
>   # /usr/lib/aarch64-linux-gnu/libc.so.6
>   GNU C Library (Debian GLIBC 2.37-16) stable release version 2.37.
> 
>   # nm -D /usr/lib/aarch64-linux-gnu/libc.so.6 | grep getaddrinfo
>   00000000000d4da4 T getaddrinfo@@GLIBC_2.17
>   0000000000114260 T getaddrinfo_a@@GLIBC_2.34
>   0000000000114260 T getaddrinfo_a@GLIBC_2.17

Update a bit for Arm64. Without this patch, we do see the test can pass on
Debian bookworm (with libc 2.36) but failed on older distros.

On the Debian bookworm, it prints out the log same as above. Seems to me,
these symbols with suffix "@GLIBC_2.x" are legacy functions for old libc
compatible but is not used by the new libc.

So we need to rule out the case for the symbol with suffix. Please check
if below change is suitable?

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index f38c8ead0b03..2079c9375af5 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -54,6 +54,11 @@ trace_libc_inet_pton_backtrace() {
                ;;
        *)
                eventattr='max-stack=3'
+               # The new version libc (e.g. libc 2.36) contains symbol getaddrinfo@@GLIBC_2.17
+               # which is not used. Do strick checking for 'getaddrinfo' without any suffix.
+               if nm -D $libc | grep -q 'getaddrinfo$'; then
+                       echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+               fi
                echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
                ;;
        esac

Thanks,
Leo
