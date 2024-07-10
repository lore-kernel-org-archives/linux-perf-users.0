Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FF190044;
	Wed, 10 Jul 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613502; cv=none; b=fjKjtEWYDdJAwcjQlsn70ELXIVUMQK8Fq1TETXmt6DEBWLLcyibTwdxZqrb9ofxx4uvbZX4Oq2cpzcBZ9Wg83Xu2GWBHclbAwjAug5yx4+FH8TFOuRKFV4r0fdluWh/L25Sccnu916pQMA74g1gjWsrpJE8ABP4upkrsBwZeS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613502; c=relaxed/simple;
	bh=UurvNuYtwMtcWIKDARRq2Bnik8U4B3mY3wKPG7xV4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd0U3KJLGukqAhvUXBq0x8kmwHKzVFRl3sQW4iQTmir3/s11SadaXIvYud9DA4vzfjzt7Yv3Ma2uG0Jj445QzBpSE0rWnPcdtfk/B/KvHkol1nUpZmGbyBJZmFOSRx4/+X4kfMBQPtqPQEryfXBFOrmP/DzmpnOI3XoF6yOfdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6NZWUFu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6NZWUFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28241C32781;
	Wed, 10 Jul 2024 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720613502;
	bh=UurvNuYtwMtcWIKDARRq2Bnik8U4B3mY3wKPG7xV4pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6NZWUFu/No8NTOvvKb9LYVm32TiEC6YfZzQ9rP66+C3t7gEebuNCb3g5czsNx0Ad
	 d1O30QXUgaGuUYzLpkwAoDbQILVIBFAGKjEpFQpTXmnXd9cwkfqWO3ZNa/1dciMmaH
	 8MbuG4EA+vrFHpnTouhbDTdYyzpk6si8juUcPqS/sVjIXdLVMz8ThDvevCcDlncBqR
	 MuCTxJ9S0mZnJA9H7CPG/DYoy0Dh7FF0DPtJzf8mEHaRlMwA1B4oA8c1BnTXK6dwKD
	 EjyDoFRhPdMLRczBYepjDVr0I2YSxxmNQmrZN+VcdXeaDcPCg8g5IUNOTm3PUi/ww7
	 32Ku/8xQDr+lQ==
Date: Wed, 10 Jul 2024 13:11:36 +0100
From: Will Deacon <will@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: hw_breakpoint: Save privilege of access
 control via ptrace
Message-ID: <20240710121136.GA14080@willie-the-truck>
References: <20240709095506.9691-1-yangtiezhu@loongson.cn>
 <20240709095506.9691-4-yangtiezhu@loongson.cn>
 <20240709100515.GB12978@willie-the-truck>
 <d72a04f5-7894-af6c-dd4a-c6728e936f73@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72a04f5-7894-af6c-dd4a-c6728e936f73@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 09, 2024 at 08:07:50PM +0800, Tiezhu Yang wrote:
> On 07/09/2024 06:05 PM, Will Deacon wrote:
> > On Tue, Jul 09, 2024 at 05:55:06PM +0800, Tiezhu Yang wrote:
> > > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > > index 0d022599eb61..3b37c4a2e0d4 100644
> > > --- a/arch/arm64/kernel/ptrace.c
> > > +++ b/arch/arm64/kernel/ptrace.c
> > > @@ -309,6 +309,7 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
> > >  	attr.bp_addr	= 0;
> > >  	attr.bp_len	= HW_BREAKPOINT_LEN_4;
> > >  	attr.bp_type	= type;
> > > +	attr.bp_priv	= AARCH64_BREAKPOINT_EL0;
> > >  	attr.disabled	= 1;
> > > 
> > >  	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
> > > @@ -352,6 +353,7 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
> > >  	attr->bp_len	= len;
> > >  	attr->bp_type	= type;
> > >  	attr->bp_addr	+= offset;
> > > +	attr->bp_priv	= ctrl.privilege;
> > 
> > Wait, so ptrace can now set breakpoints with arbitrary privileges?
> 
> The ptrace user should make sure the privilege is correct.
> For example, the privilege is set as el0
> in aarch64_point_encode_ctrl_reg() of GDB:
> 
>   /* enabled at el0 */
>   ctrl |= (2 << 1) | 1;
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/nat/aarch64-hw-point.c#l135

We shouldn't rely on userspace behaving correctly when dealing with
privilege levels.

Will
