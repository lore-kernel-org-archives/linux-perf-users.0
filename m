Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697608;
	b=qlaItCOViJMaDc8xXfspqJ79UUVFoQsNqaRL/+DRF9hWfnxrcTKKY0hor0LR4Rjus1Bi
	 QC2zoqgWIP0WMazO0su8YoMwBE9XkMqqNGm/sdZdHSSWyes1LOeabBfBZfmyRjixLgFOY
	 lBuiRIKrwLRTAABwGTjYZu60UHOO1YBSE8r2/K3itgplY4OCnrAHSPO5TsoKf9LY1GnmN
	 vEMplgpy0u/vcS0GyqlcXs75Iwr7UjKJxUVPooUDHsfXcZUzpqON0/7fiwxyt2qJttWce
	 l1vyNddfU8t1aR8BbImT5QttVLRRaS11oSV389MZGgDYaBzRdeg6b+xO7HrlZAtOaRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697608;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=mCLgkUSjfiPQ2Z/7aDng4XXocalO4USE3TUieu+yZLc=;
	b=d46PZZPakSl+YosG0tvoHSnEoUxLE5dEqJ3LkGXx2G5fDg3k9tkoWgLrjksk89F0WwQN
	 0a4t+nz8HmrgSzdohDrQAz16sE2O4G7crTz458KErjDybOkxxov63Ir3Tz72IDv/HkxqS
	 gaY0sCxHHjEoyKazc5RxYjyUFTaW0wX1fdgxGPub14gVcjn0nj/N+kPIEJgvcbq8Un5Ay
	 ExxEXmqq1xpmz8gMloOoIEJeABsfHukU6p6A4i9XFM4XzHtUCz0hL/jZePjeULaik3+oS
	 rPDDTFSNRDYF43R5HymBXiZg9JKIU8CF1VpCqUyrkAa4W7Qdj78jbrCtIAIygbZJW1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZqPT3x0k;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907C606A319;
	Thu, 22 Oct 2026 19:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7907C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZqPT3x0k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mCLgkUSjfiPQ2Z/7aDng4XXocalO4USE3TUieu+yZLc=; b=ZqPT3x0k+CkPYo13D5zgsJ31Zh
	JSJ2yQy9T2F9ZvFcBhY+Z/TsYvx16xi5yE85WvpB2WwilwZxtPJ172IuYZAlhKM9hBKf8xUo001L1
	KcTkOIdULCe5RBTRqtRCfz9nTJTrvqdnAA0jvDHlsZdkWIbYSA8CBt3y3Jlck+YFtCCpf8Kj7c0hb
	Rp1BprJM9xy8SSEPfotOjGut3et+hWHK00vTkqsylvvHEIpK9lniM1vm0xEQAAbmKmzsr4CmZZq5H
	qio3WsXzmjQC7G571OtOw+iVIhxTRPBYODRQA5oyszhf8Yi4Xf3IFUljEFquZQ2s/kCNk0eiKG7TO
	G75+oKiw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJyXT-0000000EpQv-49dK;
	Thu, 22 Oct 2026 19:33:24 +0000
Date: Thu, 22 Oct 2026 15:33:16 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	oleg@redhat.com, peterz@infradead.org, mhiramat@kernel.org, jolsa@kernel.org, 
	akpm@linux-foundation.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
	vbabka@kernel.org, hughd@google.com, kees@kernel.org, mingo@redhat.com, 
	tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
Message-ID: <dabdsge2cphfoulqobeswzj7xxkvlq2qyyi3iauqgmftfj6vg6@hbmosdt6t4bd>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
 <CAG48ez0cG532aaXZF_asCDk+fsnQmE9L5PA9T+JN6OGdx6yjGQ@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0cG532aaXZF_asCDk+fsnQmE9L5PA9T+JN6OGdx6yjGQ@mail.gmail.com>

On 26/10/22 07:56PM, Jann Horn wrote:
> On Thu, Oct 22, 2026 at 3:57 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
> >         if (IS_ERR(tramp))
> >                 return PTR_ERR(tramp);
> >         ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> > -       if (WARN_ON_ONCE(ret) && new_mapping)
> > +       if (ret && new_mapping)
> >                 WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
> 
> Not an issue with your patch, just FYI regarding this preexisting
> WARN_ON_ONCE():
> A failing small GFP_KERNEL allocation could theoretically cause
> do_munmap() to fail; the VMA tree has the ugly quirk that you can't
> reliably _remove_ elements without memory allocation.

During munmap() we may need an allocation of one or two vma(s)
(splitting a vma or punching a hole) - and those may have anon vma
chains that need to be allocated, we may need to allocate for uffd
reasons, and we may need to allocate for the maple tree.

That said, this path exclusively uses GFP_KERNEL which means we will
invoke the shrinker.  If the shrinker comes back unsuccessful, we will
invoke OOM.  This either succeed or it does not matter (we'll kill this
task).

The other two possibilities is that the OOM is disabled during
hibernate/suspend calls, or error injection caused the failure.

Thanks,
Liam

