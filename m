Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E418A6CC;
	Wed, 13 Nov 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536719; cv=none; b=Mu5dY53AlZBtjLGSv57+X8I3n2MLJMfT3xN8BMv3kSmZdkSsByFewD90BMArhMXE0rwQWX3ytN2MunAPOJQO3+QssvMvawN+aZ9Xdyrnby51J8uxLoYekN2RsR/qScT2KPCPtjOC8JRjBfpG49iTbrd0aw+HuI4sAA2AxLZ5g88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536719; c=relaxed/simple;
	bh=1dafTU3Arp/csBfvx15CA6zVMhj2igN4Giir7HUNKdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz+iorY1/loQ1jmCqlLRFH/J/6Sv9oQL8lyqX96b1K4tb7/HytE9y2L7bfPi5yJQ+L2Ww1q5nIrPNJmqWCA51QB9zl8lOCqA8u0ZVhCRUXg5Izayp92al5NKVqSKVTWi50uQ7ZOdA09XGBYQEt/kcCx3nVKoDO9nfq6adQjAghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F4DC4CEC3;
	Wed, 13 Nov 2024 22:25:15 +0000 (UTC)
Date: Wed, 13 Nov 2024 17:25:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Indu Bhagat
 <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241113172535.7af07f61@gandalf.local.home>
In-Reply-To: <20241113172118.6db57c42@gandalf.local.home>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
	<1f83be89-b816-48a3-a7ee-9b72f07b558e@linux.ibm.com>
	<20241113155040.6a9a1bed@gandalf.local.home>
	<20241113211535.ghnw52wkgudkjvgv@jpoimboe>
	<20241113171326.6d1ddc83@gandalf.local.home>
	<20241113172118.6db57c42@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 17:21:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 434c548f0837..64cc3c1188ca 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -842,7 +842,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	int first_pt_load = 1;
> >  	unsigned long error;
> >  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> > -	struct elf_phdr *elf_property_phdata = NULL, *sframe_phdr = NULL;
> > +	struct elf_phdr *elf_property_phdata = NULL;
> > +	unsigned long sframe_vaddr = 0;  
> 
> Could not just save the pointer to the sframe phd, as it gets freed before we need it.
                                                ^^^
                                                phdr


> > diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> > index 933e47696e29..ca4ef0b72772 100644
> > --- a/kernel/unwind/sframe.c
> > +++ b/kernel/unwind/sframe.c
> > @@ -73,15 +73,15 @@ static int find_fde(struct sframe_section *sec, unsigned long ip,
> >  		    struct sframe_fde *fde)
> >  {
> >  	struct sframe_fde __user *first, *last, *found = NULL;
> > -	u32 ip_off, func_off_low = 0, func_off_high = -1;
> > +	s32 ip_off, func_off_low = INT_MIN, func_off_high = INT_MAX;  
> 
> The ip_off is a signed it. I wrote a program to dump out the sframe section
                         ^^
                         int


> of files, and I had:
> 
> 	ffffed88: (1020) size:      16 off:     146 num:       2 info: 1 rep:16
> 	ffffed98: (1030) size:     336 off:     154 num:       2 info:17 rep:16
> 	ffffefe1: (1279) size:     113 off:       0 num:       4 info: 0 rep: 0
> 	fffff052: (12ea) size:      54 off:      15 num:       3 info: 0 rep: 0
> 	fffff088: (1320) size:     167 off:      26 num:       3 info: 0 rep: 0
> 	fffff12f: (13c7) size:     167 off:      37 num:       4 info: 0 rep: 0
> 	fffff1d6: (146e) size:     167 off:      52 num:       4 info: 0 rep: 0
> 	fffff27d: (1515) size:      22 off:      67 num:       4 info: 0 rep: 0
> 	fffff293: (152b) size:     141 off:      82 num:       4 info: 0 rep: 0
> 	fffff320: (15b8) size:      81 off:      97 num:       4 info: 0 rep: 0
> 	fffff371: (1609) size:     671 off:     112 num:       4 info: 1 rep: 0
> 	fffff610: (18a8) size:     171 off:     131 num:       4 info: 0 rep: 0
> 
> The above turns was created by a loop of:
            ^^^^^^^^^
            items were

No idea why I typed that :-p


I can't blame jetlag anymore.

-- Steve
