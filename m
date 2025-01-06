Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B61E0B82
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736199967; cv=none; b=QAvjgwgANINiUaovOunJCl4zSrPN0q4qpxISQnPFuWeFZS2qCkPwxZrbYcioaRNjtFU62HU/nxANeGw0wsTjwpTaFZCLIde5lGAAOjOAor8Y3YRzsZeswtKwZwmIN6By0f47IsF6YsPUIEz74lVqlcRRHL6DkazEpNVV1RAp0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736199967; c=relaxed/simple;
	bh=F1sKZwTHiDTNo86eh/r784QGetXHzZDl8w+awG/fwRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHljIiKbsgJ37srCqBv8uxsDYXEdDj4UwJ7G75G/Oyn5WLLPzedLHqQAAEg3QPvSdv9FQBMsMYyVYfKmb2ppcvZ734+NdqePymnGdNu/7lba8sSwLLBFrXIMOiWnUlfqrpAUTnMj1CZiytD/JfCz/aEH+qWMsHK8rTSt6iu8Z88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aly9tu4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aly9tu4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0D3C4CED2;
	Mon,  6 Jan 2025 21:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736199967;
	bh=F1sKZwTHiDTNo86eh/r784QGetXHzZDl8w+awG/fwRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aly9tu4wCMb5SPwgZDehcwIILLimKHfTMEb9Y3zKUBQXb3wRF1zfMpokN2scTX3C8
	 XYkncR/VF/QCksOU21juTror0IkapkMxBOKmLZtBuJ0sB0eh2GZzrZbMOcROjsn/eI
	 0I96c/C8SeLo8UsDA7N2je+PtorgvCFZDBa2UeG2qzvM/tOju3QVZV/sJYGK+wsfAi
	 laa7C6ExZOi5VCQQy9/Y1b2QT7KAxxMuw8LiRx64idGgna/+l5Gdkorzv4Bk2J9w+z
	 Rm4Rca5J24H9fLBynACcbFbJCUhDDLSfMf5lG2t2kj5Up51tpI79+2QwSlOQTGed9L
	 mDfeIuefrKOPA==
Date: Mon, 6 Jan 2025 13:46:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
Message-ID: <Z3xPHSrVInsc6W6I@google.com>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
 <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>
 <Z3bYltoidQpqtyJ_@x1>
 <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu>
 <Z3c4nupM-UENN5LM@x1>
 <5b8ec160-4b50-4736-8012-30ae35c45028@csgroup.eu>
 <Z3gPncBcCnZiNy57@x1>
 <752a31b0-4370-4f52-b7cc-45f0078c1d6c@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <752a31b0-4370-4f52-b7cc-45f0078c1d6c@csgroup.eu>

Hello,

On Mon, Jan 06, 2025 at 01:38:52PM +0100, Christophe Leroy wrote:
> 
> 
> Le 03/01/2025 à 17:26, Arnaldo Carvalho de Melo a écrit :
> > On Fri, Jan 03, 2025 at 01:40:24PM +0100, Christophe Leroy wrote:
> > > Le 03/01/2025 à 02:08, Arnaldo Carvalho de Melo a écrit :
> > > > >      PerfTop:     524 irqs/sec  kernel:51.1%  exact:  0.0% lost: 0/0 drop: 0/0
> > > > > [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> > > > > -------------------------------------------------------------------------------
> > 
> > > > >       17.18%  [unknown]      [k] 0xc0891c14
> > > > >        7.63%  [unknown]      [k] 0xc005f11c
> > 
> > > > I think I hadn't notice this '[unknown]' one bit before :-\ the [k] is
> > > > there, so having unknown is odd
> > > Problem found, it's in maps__find_next_entry(), this leads to both
> > > map->start and map->end of kernel map being set to 0xc0000000, which leads
> > > to the failure of bsearch() in maps__find().
> > 
> > Right, and since you don't have any module (CONFIG_MODULES not set),
> > and most machines do, that is when the buggy function is called:
> > 
> > machine__create_kernel_maps()
> > 	if (!machine__get_running_kernel_start(machine, &name, &start, &end))
> > <SNIP>
> >          if (end == ~0ULL) {
> >                  /* update end address of the kernel map using adjacent module address */
> >                  struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
> >                                                           machine__kernel_map(machine));
> > 
> >                  if (next) {
> >                          machine__set_kernel_mmap(machine, start, map__start(next));
> >                          map__put(next);
> >                  }
> >          }
> > <SNIP>
> > 
> > So machine__get_running_kernel_start() doesn't manage to fill end with
> > either because it doesn't find the ref_reloc_sym, one of:
> > 
> > const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL}
> > 
> > And returns -1, so that first if block fails, and then start also
> > doesn't get set and remains 0, which doesn't seem to be the case, as you
> > get 0xc0000000 in it, or this fails:
> > 
> >          err = kallsyms__get_symbol_start(filename, "_edata", &addr);
> >          if (err)
> >                  err = kallsyms__get_function_start(filename, "_etext", &addr);
> >          if (!err)
> >                  *end = addr;
> > 
> 
> Indeed yes that one fails, because:
> 
> ~# grep -e _stext -e _etext -e _edata /proc/kallsyms
> c0000000 T _stext
> c08b8000 D _etext
> 
> So there is no _edata and _etext is not text
> 
> $ ppc-linux-objdump -x vmlinux | grep -e _stext -e _etext -e _edata
> c0000000 g       .head.text	00000000 _stext
> c08b8000 g       .rodata	00000000 _etext
> c1378000 g       .sbss	00000000 _edata
> 
> Changing
> 
> 	kallsyms__get_function_start(filename, "_etext", &addr);
> 
> to
> 
> 	kallsyms__get_symbol_start(filename, "_etext", &addr);
> 
> works.
> 
> 
> The following change works as well:
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S
> b/arch/powerpc/kernel/vmlinux.lds.S
> index b4c9decc7a75..b7b2cd7e2a20 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -123,10 +123,11 @@ SECTIONS
>  		 */
>  		*(.sfpr);
>  		*(.text.asan.* .text.tsan.*)
> +
> +		. = ALIGN(PAGE_SIZE);
> +		_etext = .;
>  	} :text
> 
> -	. = ALIGN(PAGE_SIZE);
> -	_etext = .;
>  	PROVIDE32 (etext = .);
> 
>  	/* Read-only data */
> 
> As it leads to:
> 
> ~# grep -e _stext -e _etext -e _edata /proc/kallsyms
> c0000000 T _stext
> c08b8000 T _etext
> 
> $ ppc-linux-objdump -x vmlinux | grep -e _stext -e _etext -e _edata
> c0000000 g       .head.text	00000000 _stext
> c08b8000 g       .text	00000000 _etext
> c1378000 g       .sbss	00000000 _edata
> 
> So what is the most correct fix ? Change architectures link script or make
> perf _etext lookup more flexible, allowing non-text ?
> 
> Looking at vmlinux.lds.S from various architectures, I have the feeling
> several of them are affected.
> 
> Now, regarding _edata, what I see is:
> 
> ~# tail -2 /proc/kallsyms
> c136a000 D __start___bug_table
> c1377c14 D __stop___bug_table
> 
> And in System.map I have:
> 
> c136a000 D __start___bug_table
> c1377c14 D __stop___bug_table
> c1378000 B __bss_start
> c1378000 B _edata
> c1378000 B initcall_debug
> c1378004 B reset_devices
> 
> Should perf try to locate the very last symbol when it doesn't find _edata ?
> Or should architecture's link script be modified ? Otherwise commit
> 69a87a32f5cd ("perf machine: Include data symbols in the kernel map") is
> just pointless.

Let's go with kallsyms__get_symbol_start().  I think it's the most
straight-forward and simplest fix.

Thanks,
Namhyung

