From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Fix Symbol Address for ET_DYN
Date: Thu, 11 Sep 2014 12:01:23 -0300
Message-ID: <20140911150123.GH10158@kernel.org>
References: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:59821 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755989AbaIKPBk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 11 Sep 2014 11:01:40 -0400
Content-Disposition: inline
In-Reply-To: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tong Shen <endlessroad@google.com>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Sep 05, 2014 at 11:38:02AM -0700, Tong Shen escreveu:
> Hi linux-perf-users,
> 
> It's actually a patch, and I didn't find a development mailing list
> for perf, so I just post it here. If this is not the right place to

You can post it here, but please add the maintainers to the CC list, so
that we can more quickly see your message.

Comments below:

> post patches, could someone direct me to it? Thanks in advance!
> 
> In tools/perf/util/symbol-elf.c, we don't adjust symbol address for
> ET_DYN type of ELF files because we think ET_DYN is always
> relocatable.
> 
> But that's not necessarily true; there are some non-relocatable ET_DYN
> ELF files. For those files, we should still adjust symbol address.
 
> Suggested patch: (HTML subpart now allowed in this mailing list...)
 
> +++ b/perf-3.12.0/tools/perf/util/symbol-elf.c
> @@ -915,7 +915,10 @@ int dso__load_sym(struct dso *dso, struct map *map,

>  		if ((used_opd && runtime_ss->adjust_symbols)
> -				|| (!used_opd && syms_ss->adjust_symbols)) {
> +				|| (!used_opd && syms_ss->adjust_symbols)
> +				|| (syms_ss->ehdr.e_type == et_dyn
> +					&& shdr.sh_addr != shdr.sh_offset
> +					&& elf_sec__is_text(&shdr, secstrs))) {

Please try to follow kernel coding style in these tools, i.e. the &&
should be at the end, the expression on each line should be aligned just
after the opening parens.

If, like in this case, you find something not following that style, take
the opportunity to fix it :-)

But back to your change, I'll have to look at this code further, just
looking at the excerpt above I find it way too confusing, and your patch
makes it even more so...

Can you introduce some suitably named helper that has those extra
conditions you're adding now and then add it to this conditional?

I.e. make it somethine like:

-               if ((used_opd && runtime_ss->adjust_symbols)
-                               || (!used_opd && syms_ss->adjust_symbols)) {
+               if ((used_opd && runtime_ss->adjust_symbols) ||
+                   (!used_opd && syms_ss->adjust_symbols)   ||
+                   syms__some_suitable_name(syms_ss, &shdr)) {

And then add your explanation of these kinds of files as a comment over
this new function, please?

>  			pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
>  				  "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n", __func__,
>  				  (u64)sym.st_value, (u64)shdr.sh_addr,

Best regards,

- Arnaldo
