Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32E3A960A;
	Tue,  3 Feb 2026 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129953; cv=none; b=s2TIilw/cvDa/gkkS9WrGK2ncJemZ0Z8+4syJbys2FcV7MB3da+EBP1k8B/HXvhcKaEuev6fhaT5i3rxX/KgC6t2BsPpytg2J/4XP00KfZ64s9bnhUJ8a46kNqYUHv8ymUjLMcBzKKUI1BfMY29JhIRcc0rjMGyu6nZFcTDshMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129953; c=relaxed/simple;
	bh=FYYuxcH6OLwjEn2qd7vwCrKMDV8ggJp80pf9wuewcmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcPMaJpYMNx1zBU6P2bXF9isPWeM8J/lUklipnaAIlbDAl9Exii6DW1TYmsFITIjluwjlsv2ORQLemJz/xVl3qygDg9pItIgWajFZTrh2csVYrnkD7rUrWwsTXEl4IOzYQSWP20irlTHxktpvC4iErnI+cUDttMBmikTViAY9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWvIaDjZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWvIaDjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF44FC116D0;
	Tue,  3 Feb 2026 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770129953;
	bh=FYYuxcH6OLwjEn2qd7vwCrKMDV8ggJp80pf9wuewcmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWvIaDjZ6yx0vyWJ0OInjXLbExSRNKn7tXueRlddE+sn/ml0+D5KMr1RsAk/P21nM
	 HjkoWY5ExYSL7oupIpPxpeQelO7L2j+xyARrI4iVWBujoQFiYdH9K5ZwejDGpxlug6
	 8U46iodKuYdmH54oZ1rB7CJxqJaqQSh1skWP9nqUxywTcoRj+z4YHJVnkpmqOXjOrt
	 psPJQj6hOmB3yP122tX0HHkIVo13MhNqltQrUz+Yfj107Fji0h49xmJyhNk5DeComt
	 9fDsI0tA4Rw1trdbbSQaG1gVZAJs2QuzIT9g1zQZhrHmv2JytLVzhUhBeQE/AuUNXS
	 66Deoc+hpfITg==
Date: Tue, 3 Feb 2026 11:45:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Dmitry Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] perf tests: Test annotate with data type
 profiling and rust
Message-ID: <aYIKHjxCGFbReY7Y@x1>
References: <20260127083030.5909-1-9erthalion6@gmail.com>
 <aXjvF3N5ZGJlZzFi@x1>
 <2frzr2cebxes2qoxofwqshfkb5k3d7jeq72srqnt4ywrlpkz5r@7pzb7cpbm4yw>
 <7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o>

On Sun, Feb 01, 2026 at 11:33:54AM +0100, Dmitry Dolgov wrote:
> > On Fri, Jan 30, 2026 at 09:44:47AM +0100, Dmitry Dolgov wrote:
> > > I'm not managing to reproduce your results, can you please elaborate
> > > some more?
> > 
> > That's most unexpected for me, the test output I see looks like this:
> > 
> >          : 54     for _ in 1..count {
> >     0.00 :   5423b8: mov    %ecx,0x7c(%rsp)
> >     0.00 :   5423bc: mov    %eax,0x80(%rsp)
> >     0.00 :   5423c3: lea    0x7c(%rsp),%rdi
> >    12.28 :   5423c8: call   541f00 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
> >     0.00 :   5423cd: mov    %eax,0x20(%rsp)
> >    10.21 :   5423d1: jmp    5423d3 <test_rs+0xb3>
> >     0.00 :   5423d3: mov    0x20(%rsp),%eax
> >     0.00 :   5423d7: mov    %eax,%eax
> >     0.00 :   5423d9: test   $0x1,%rax
> >     0.29 :   5423df: je     5423f6 <test_rs+0xd6>
> >          : 65     b.data1 += 1;
> >    13.69 :   5423e1: mov    0x48(%rsp),%rax     # data-type: struct Buf +0x18 (data1)
> >     0.00 :   5423e6: add    $0x1,%rax
> >     0.00 :   5423ea: mov    %rax,0x18(%rsp)     # data-type: u64 +0
> >     0.00 :   5423ef: setb   %al
> >    11.17 :   5423f2: jb     54243a <test_rs+0x11a>
> >     0.00 :   5423f4: jmp    542426 <test_rs+0x106>
> >     0.00 :   5423f6: lea    0x30(%rsp),%rdi
> >          : 73     }
> > 
> > Where '# data-type: struct Buf' is as far as I understand a manifestation of
> > data type profiling succeeding. But my environment has slightly different
> > version of rust -- I need to figure out what's going on here, thanks.
> 
> I've being testing this in the same way, but without any rust code --
> just on a simple datasym workload. Surprisingly, it seems that
> 'data-type: buf' marks are disappearing even in this case starting from:
> 
> c31040085914f1188720073baa43d1483693c0a3 (perf dwarf-regs: Clean up x86
> dwarf_regnum code)
 
> I'm not sure yet why this is happening, but don't see anything in the
> commit mentioning that -- since there are no code-with-type tests yet,
> maybe an unexpected side effect?

Ian, can you please take a look at this?

Cheers,

- Arnaldo
