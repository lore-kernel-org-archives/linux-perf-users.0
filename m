Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA9BA33
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847693; cv=none; b=GtasmQzL/lMlJ/J/hx6hkeyIj2mXaMJHhpzkPIU44MaDsCt/TgFttt0b5VBLZlLVOWBGLLJ7+J+A239Kk9hoisI5uKb/EFmRXvGc3kQjIHM9l598NJfwk7ViV6j9pkYG+UIN5whn27vU5cY9msyktLWB9k2zhGW/GftcmLNX8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847693; c=relaxed/simple;
	bh=RVEKqhhBKz26Ixzd01LWmI9O2b3jW/nlFLWhczStbsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf+kpsLj2h28w2mRrvW1I1oCP8bLB+sFTkaq8Ov86if4BqCOB6tSkwk/ZP9hWJi2CWf7IkHi+und8x7gCj4zq7nVtpfhBQX33VUqV+76BHctaxXBuqUhxQFeS8BoBT+yr8nBMk3Z7Lma0pFv68nSKM+dPSEw+mtLcp86JXWpfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=semiaXch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="semiaXch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1921C32782;
	Fri, 16 Aug 2024 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723847693;
	bh=RVEKqhhBKz26Ixzd01LWmI9O2b3jW/nlFLWhczStbsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=semiaXchqkeNtLk3QAENX/6pCbK3NVlRovN8xt4edaOpw3UL8fP/vamLDFU6EpEoL
	 tJ+YrPwDnJERzDYjVQQqcKyHGbspWeyg9jqlAofwouwbeKue6lmwkQsRe1OnQPGpvF
	 iwa/c19wZwR2wKnn30+6UFCK/IdS40zvoRuTlbr1KqED/1Toxg/yxwwR9u4FIOkGws
	 xwbCDcH8teCJpjK8vBZzX8Bl0asLpLS1L+JDiTcQQhT0urGVrNFZqKmAU3PV9XXwfd
	 n7W/lfwnTLGJhNaqY5gaZnu/Zp6tDzEYkDP42S+VpZ1DjvT8EgPZ2g1i+RDjhS7zCU
	 A0QhRpyrsp/0Q==
Date: Fri, 16 Aug 2024 19:34:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, mark.rutland@arm.com,
	mingo@redhat.com, peterz@infradead.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxarm@huawei.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, hejunhao3@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH] perf stat: Display iostat headers correctly
Message-ID: <Zr_UCv3HaMhLOmg0@x1>
References: <20240802065800.48774-1-yangyicong@huawei.com>
 <Zr-Npc3oKa5juMr3@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr-Npc3oKa5juMr3@google.com>

On Fri, Aug 16, 2024 at 10:34:29AM -0700, Namhyung Kim wrote:
> On Fri, Aug 02, 2024 at 02:58:00PM +0800, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > Currently we'll only print metric headers for metric leader in
> > aggregration mode. This will make `perf iostat` header not shown
> > since it'll aggregrated globally but don't have metric events:
> > root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
> >  Performance counter stats for 'system wide':
> >     port
> > 0000:00                    0                    0                    0                    0
> > 0000:80                    0                    0                    0                    0
> > [...]
> > 
> > Fix this by excluding the iostat in the check of printing metric
> > headers. Then we can see the headers:
> > root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
> >  Performance counter stats for 'system wide':
> >     port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
> > 0000:00                    0                    0                    0                    0
> > 0000:80                    0                    0                    0                    0
> > [...]
> > 
> > Fixes: 193a9e30207f ("perf stat: Don't display metric header for non-leader uncore events")
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
