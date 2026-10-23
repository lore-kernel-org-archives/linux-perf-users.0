Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764427;
	b=syX9h+O+uhO0PUK8jFrz5DkjGOVp9/x/IWnL/MtngWU1eOFOzvrAHbN+0IJ5E2MDsbqB
	 o9i1ZhL4GcVSyzXRlxxl9pltySiTB4LAOatfxKLADjiBIajMZX6DLU/nEPCtZs0yyx7d7
	 HEcmyyVcqlcDZ5lvi/K9vUebfBC3pAKogzAKU/cXOeJYFBotyjvmRjA/omLSSGlai1t9j
	 Dmu2TKha+3Ko7cHk82B6yWqH37IyonzMesrQOfb/ueTIb3gVT+M6R89QETnahbZmygDoL
	 shAB+lOV2E86G50fZQaUr6qmTjZ+xW2A6Znf0pG3rntCe2GSg7Blp4e5P5NjU7EH9DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764427;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=e+5avhVAYzoklRMOevcq39Nv/JRuzKbPDrhcz4Dvwt8=;
	b=U5zz91FJOgQe1cUbPsOXFYcGa6qJOjFTZmRSTYmN6uMhcANMHq5DniTSZZNymzUidMbv
	 CkjvFI+ZxztzY7FVTaVgUDC8GNOQ/5Ytr0yXWkxlyrR8CIsVj1vdUpLLlAkpGnyE9fMdZ
	 GWrDyR3bWRFz0dM1ajDTwm71qKJ4/pQWWGx6UKybPXIeBa0Dm3qPjMlB95CTXv9GMNAfT
	 6sAHOTBOYJBqxCkP/10LKTQveP2kXTnSweFRLkCnbmsqm0fkABs8Vomi/BCbUmSLxQKEj
	 zugNZ62dpInP8drnPdaCCwV+2TAhoJLx6M/HkaWdZWkHCfYKRWl35dk9IL2KUWZT19A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2nA5oC3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB6606A326;
	Fri, 23 Oct 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2nA5oC3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56781F01825;
	Fri, 23 Oct 2026 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792764427;
	bh=e+5avhVAYzoklRMOevcq39Nv/JRuzKbPDrhcz4Dvwt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m2nA5oC3gMeQOgRPik05P2p9Mv7ORwhnttE0a0GpEYExkRr7AFe5ALdq58c8EXJ25
	 +9vCqZIMQl8ekvWVTglC3nmPVOOvCs2V7ZX0tdla+MxYfMpypXTHm/QA8NIR8UNak1
	 B6Zo/XvPz/p6S6S26Croj4+rcApVimYjYMVf7U/8gXdxL4CYXwvtq+eM10as+txo5T
	 pwaRtB9IV6u8gSSjTqAdfzecCKpBpNTgtd/oDjukjEmrshMuPDPK/KhssFSzC0al18
	 BudOCjltCEmwgO//GXBgA89E5WLtxYmBnha3Dn1gVKRFTC0IkAYeRfvmfyL15EZGRU
	 U96D5Ogl7Ge3g==
Date: Fri, 23 Oct 2026 15:06:59 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Jann Horn <jannh@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
	mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, surenb@google.com, 
	david@kernel.org, vbabka@kernel.org, hughd@google.com, kees@kernel.org, 
	mingo@redhat.com, tglx@kernel.org, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
Message-ID: <attpuy6TvlOgB7yJ@gremlin>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
 <CAG48ez0cG532aaXZF_asCDk+fsnQmE9L5PA9T+JN6OGdx6yjGQ@mail.gmail.com>
 <dabdsge2cphfoulqobeswzj7xxkvlq2qyyi3iauqgmftfj6vg6@hbmosdt6t4bd>
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
In-Reply-To: <dabdsge2cphfoulqobeswzj7xxkvlq2qyyi3iauqgmftfj6vg6@hbmosdt6t4bd>

On Thu, Oct 22, 2026 at 03:33:16PM -0400, Liam R. Howlett wrote:
> On 26/10/22 07:56PM, Jann Horn wrote:
> > On Thu, Oct 22, 2026 at 3:57 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
> > >         if (IS_ERR(tramp))
> > >                 return PTR_ERR(tramp);
> > >         ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> > > -       if (WARN_ON_ONCE(ret) && new_mapping)
> > > +       if (ret && new_mapping)
> > >                 WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
> >
> > Not an issue with your patch, just FYI regarding this preexisting
> > WARN_ON_ONCE():
> > A failing small GFP_KERNEL allocation could theoretically cause
> > do_munmap() to fail; the VMA tree has the ugly quirk that you can't
> > reliably _remove_ elements without memory allocation.
>
> During munmap() we may need an allocation of one or two vma(s)
> (splitting a vma or punching a hole) - and those may have anon vma
> chains that need to be allocated, we may need to allocate for uffd
> reasons, and we may need to allocate for the maple tree.
>
> That said, this path exclusively uses GFP_KERNEL which means we will
> invoke the shrinker.  If the shrinker comes back unsuccessful, we will
> invoke OOM.  This either succeed or it does not matter (we'll kill this
> task).

But you'd still get the WARN_ON() in the 'does not matter' case right?

>
> The other two possibilities is that the OOM is disabled during
> hibernate/suspend calls, or error injection caused the failure.

Fatal signals too?

Might be some other cases too there.

In general I'd say this WARN_ON() is probably not helpful.

--
Cheers, Lorenzo
