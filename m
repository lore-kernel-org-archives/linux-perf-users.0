Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820B5339F;
	Mon, 30 Sep 2024 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738808; cv=none; b=iioDQLiOCdbf2oKQB76aQfpKJ+YUe2StUuX3bcfGBnBujgZnCtbt9WGY8A/laoNkitHBQ1QxpTNQqBe2fJPKENSfBCnXTaJqAwFHTcMWFrFrHF3hLx8x5nyrUI4bfhwT9x0ADkfR+N1MdrnRS2izjkdBDBneidFGWsju3c2U6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738808; c=relaxed/simple;
	bh=Ay3LjX+CYeiMpsJ3vy95Ooiox6m2LEqUZyh8yRyF4Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3eGjIBHsWd408E9sFRjall09xNEmZCFnjtFuKVUu41yYLR0IoFipD980eFhWATQg+r/aGRR9ixPrSd+k6b3mGki7PrvDdN/5TJ3QSZ0NtV+rtKPZlg/YdPaalycUzPxE/EmPVWi9Cy6CfnGkM5p2btGyA5KWm1aS1EoWjKRyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H74s1FwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H74s1FwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE0EC4CEC7;
	Mon, 30 Sep 2024 23:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727738807;
	bh=Ay3LjX+CYeiMpsJ3vy95Ooiox6m2LEqUZyh8yRyF4Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H74s1FwKnPjI7bq6p8WV8yBI37bp+TVWuMrSmVRab7C9gFakoAXaKDEiJPN+q0Nda
	 i0vmwp7kiHF9rTKSUaczAaVaA+O1f5uoQgIFk9dkC//cFVJzlYunP3hucp/FeMHvXV
	 e5/oXBFniwxg7ZC+luixS9mbUf3puf9/AcMfayvGiy0qg4gkn+59aWn8u02MQdo4fF
	 fzKSsm5wB34llDF0Nhjcx/RFK5Sl7x9DsCUcpKCisEexu6QhFr2gTcef9N1vDh4VZg
	 YmGycaysQuXja02flt+ZoLVGF6SwTEFg1/KnUyXLVmkS3PSdf54Y4EIDSlrwuyKHlx
	 3iS7pAmQImLDQ==
Date: Mon, 30 Sep 2024 16:26:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: perf test 86 fails on s390 repo linux-next
Message-ID: <ZvsztS6wMMFuXjSz@google.com>
References: <20240916125718.3024270-1-tmricht@linux.ibm.com>
 <ZvXjYOWoEIhakz-f@google.com>
 <3b65e3cc-2a9f-4427-a327-7e920ec4d969@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b65e3cc-2a9f-4427-a327-7e920ec4d969@linux.ibm.com>

On Mon, Sep 30, 2024 at 02:30:39PM +0200, Thomas Richter wrote:
> On 9/27/24 00:42, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Sep 16, 2024 at 02:57:18PM +0200, Thomas Richter wrote:
> >> Command perf test 86 fails on s390 using linux-next repository:
> >>  # perf test -F 86
> >>  ping 868299 [007] 28248.013596: probe_libc:inet_pton_1: (3ff95948020)
> >>  3ff95948020 inet_pton+0x0 (inlined)
> >>  3ff9595e6e7 text_to_binary_address+0x1007 (inlined)
> >>  3ff9595e6e7 gaih_inet+0x1007 (inlined)
> >>  FAIL: expected backtrace entry \
> >> 	 "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> >> 	 got "3ff9595e6e7 gaih_inet+0x1007 (inlined)"
> >>  86: probe libc's inet_pton & backtrace it with ping  : FAILED!
> >>  #
> >>
> >> The root cause is a new stack layout, some functions have been added
> >> as seen below. Add text_to_binary_address and friends to the
> >> list of expected functions.
> >>
> >>  # perf script | tac | grep -m1 '^ping' -B9 | tac
> >>  ping  866856 [007] 25979.494921: probe_libc:inet_pton: (3ff8ec48020)
> >> 	     3ff8ec48020 inet_pton+0x0 (inlined)
> >> 	     3ff8ec5e6e7 text_to_binary_address+0x1007 (inlined)
> >> 	     3ff8ec5e6e7 gaih_inet+0x1007 (inlined)
> >> 	     3ff8ec5e6e7 getaddrinfo+0x1007 (/usr/lib64/libc.so.6)
> >> 	     2aa3fe04bf5 main+0xff5 (/usr/bin/ping)
> >> 	     3ff8eb34a5b __libc_start_call_main+0x8b (/usr/lib64/libc.so.6)
> >> 	     3ff8eb34b5d __libc_start_main@GLIBC_2.2+0xad (inlined)
> >> 	     2aa3fe06a1f [unknown] (/usr/bin/ping)
> > 
> > Is it because of a kernel change?  What about old kernels then?
> > 
> >>
> >>  #
> >>
> >> Output after:
> >>  # perf test -F 86
> >>  86: probe libc's inet_pton & backtrace it with ping  : Ok
> >>  #
> >>
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> ---
> >>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> >> index f38c8ead0b03..bc6e2fe1d999 100755
> >> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> >> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> >> @@ -40,6 +40,8 @@ trace_libc_inet_pton_backtrace() {
> >>  	case "$(uname -m)" in
> >>  	s390x)
> >>  		eventattr='call-graph=dwarf,max-stack=4'
> >> +		echo "text_to_binary_address\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> >> +		echo "gaih_inet\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> > 
> > Is it possible to make it this part conditional and only have it for the
> > new kernels?
> 
> I think this is more related to glibc and has nothing to do with the kernel version.
> It happened after I did a dnf update.

Ok, then I'm afraid fixing this would break others with old glibc.
Can you please update the regex to cover both cases?

Thanks,
Namhyung

