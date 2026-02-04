Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD02BAF7;
	Wed,  4 Feb 2026 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241941; cv=none; b=bbXTXidEc/8k7Lyl7V9gRl+Um0eAph7ALNpzmgPHK/TyH+T7iLJoqq5pOkgZYz/hdP1pm0B+KRsONn8x7VXTQ2XgFaqiHORs6ZDUBhhck3Gw5MYPLHKOUl1OoMAcf6Mf9p43qG/TYEQaVjmZ9b/v5/hioylwqHQFRhrctCqLpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241941; c=relaxed/simple;
	bh=p1omfc2PRfYECNmNbAHncDiuOq8nZPSc7uXqqZcOsW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW7q7Wbs2sY657pVMdd0LEFR7JEtPiUv1fDC6U1BeOW5BZ9Kewu5QVJAbkHpxk3bL5Ic62d0ut/1vf12CjvLnn/my4qiKENeEmzq8XJOE+OXR1QOdASZt2Hh7jZ85euqDzpzLED9GhUYkspSjHy7AHeSp/AfC+pzoP//7LiQC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7nhESN4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7nhESN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDEDC4CEF7;
	Wed,  4 Feb 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770241941;
	bh=p1omfc2PRfYECNmNbAHncDiuOq8nZPSc7uXqqZcOsW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7nhESN4c4Wyq2VHEghI9Vp6SOINZolZlJ528mu3NRoFtTxyXe0G8bt1WCORcOESZ
	 YVDqVJ/5ApFXLsdy5phXZ9lch/WA0RNd91Y2DHoujMvw1BmVh9dyPNyjyP2F58rt4d
	 M+24nSE9rKUHM9pTecx+euDPpFIwRvVGpupmV5S4VJldQmQZbz06A2y+B9rNRxi7zK
	 dJdnDjSuhnkPRjnpfA14jeA7iX4vAWGtTUPJbq/5HOPJi6awMQjFEz45mQFxs+TsN8
	 kG+ZvJQwkBBn77roOfnAuXfo5GNRtjp74+DDXnSPjedtRbn5vkRAUpsFHlleadiyG7
	 PB+J/P54lceWA==
Date: Wed, 4 Feb 2026 13:52:19 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Dmitry Dolgov <9erthalion6@gmail.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] perf tests: Test annotate with data type
 profiling and rust
Message-ID: <aYO_k4G-iF3CUY02@google.com>
References: <20260127083030.5909-1-9erthalion6@gmail.com>
 <aXjvF3N5ZGJlZzFi@x1>
 <2frzr2cebxes2qoxofwqshfkb5k3d7jeq72srqnt4ywrlpkz5r@7pzb7cpbm4yw>
 <7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o>
 <aYIKHjxCGFbReY7Y@x1>
 <CAP-5=fU-aJYKAcbFeFYcgMfpvt8oY4BTxEgczP_rvUAiJt+U-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU-aJYKAcbFeFYcgMfpvt8oY4BTxEgczP_rvUAiJt+U-Q@mail.gmail.com>

On Tue, Feb 03, 2026 at 10:15:30AM -0800, Ian Rogers wrote:
> On Tue, Feb 3, 2026 at 6:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Sun, Feb 01, 2026 at 11:33:54AM +0100, Dmitry Dolgov wrote:
> > > > On Fri, Jan 30, 2026 at 09:44:47AM +0100, Dmitry Dolgov wrote:
> > > > > I'm not managing to reproduce your results, can you please elaborate
> > > > > some more?
> > > >
> > > > That's most unexpected for me, the test output I see looks like this:
> > > >
> > > >          : 54     for _ in 1..count {
> > > >     0.00 :   5423b8: mov    %ecx,0x7c(%rsp)
> > > >     0.00 :   5423bc: mov    %eax,0x80(%rsp)
> > > >     0.00 :   5423c3: lea    0x7c(%rsp),%rdi
> > > >    12.28 :   5423c8: call   541f00 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
> > > >     0.00 :   5423cd: mov    %eax,0x20(%rsp)
> > > >    10.21 :   5423d1: jmp    5423d3 <test_rs+0xb3>
> > > >     0.00 :   5423d3: mov    0x20(%rsp),%eax
> > > >     0.00 :   5423d7: mov    %eax,%eax
> > > >     0.00 :   5423d9: test   $0x1,%rax
> > > >     0.29 :   5423df: je     5423f6 <test_rs+0xd6>
> > > >          : 65     b.data1 += 1;
> > > >    13.69 :   5423e1: mov    0x48(%rsp),%rax     # data-type: struct Buf +0x18 (data1)
> > > >     0.00 :   5423e6: add    $0x1,%rax
> > > >     0.00 :   5423ea: mov    %rax,0x18(%rsp)     # data-type: u64 +0
> > > >     0.00 :   5423ef: setb   %al
> > > >    11.17 :   5423f2: jb     54243a <test_rs+0x11a>
> > > >     0.00 :   5423f4: jmp    542426 <test_rs+0x106>
> > > >     0.00 :   5423f6: lea    0x30(%rsp),%rdi
> > > >          : 73     }
> > > >
> > > > Where '# data-type: struct Buf' is as far as I understand a manifestation of
> > > > data type profiling succeeding. But my environment has slightly different
> > > > version of rust -- I need to figure out what's going on here, thanks.
> > >
> > > I've being testing this in the same way, but without any rust code --
> > > just on a simple datasym workload. Surprisingly, it seems that
> > > 'data-type: buf' marks are disappearing even in this case starting from:
> > >
> > > c31040085914f1188720073baa43d1483693c0a3 (perf dwarf-regs: Clean up x86
> > > dwarf_regnum code)
> >
> > > I'm not sure yet why this is happening, but don't see anything in the
> > > commit mentioning that -- since there are no code-with-type tests yet,
> > > maybe an unexpected side effect?
> >
> > Ian, can you please take a look at this?
> 
> That particular commit is largely adding an i386 to dwarf register
> number mapping table but it also expands the x86-64 mapping table:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=c31040085914f1188720073baa43d1483693c0a3
> The code to search the table is largely unchanged so my guess would be
> that the new x86-64 entries are causing a dwarf register to be
> returned in cases where previously this was -ENOENT. This may have
> broken the type profiling, but Namhyung would be the expert on that.

Any chance it can get an invalid e_machine?  I'm not sure if it handles
EM_HOST properly.

Thanks,
Namhyung

