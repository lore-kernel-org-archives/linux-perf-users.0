Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB94C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442E66113A
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbhIIUeW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343998AbhIIUeJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 16:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 187266113A;
        Thu,  9 Sep 2021 20:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631219579;
        bh=Od4Fq70WNP3iP34ZfifIEzSkTAKKdivcDjSccTDCtpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1EtcmenQYwvmsjH0Bj9pNuSkS12U9UghOifQEe0cHCbkMi1tefTN7yGhHc2zUKTj
         NJRcuICrenALQ3hEUiN2AVL1/PJh9wH+UPZCQhi9LD4fMrxNzq97J05WATCXT13Q3Y
         QVfGGR68cPq932RsX6h+NxgJ412EIPLak9fOsYPGjX4jhpG4qUaP6FVCUPcr8h5DdK
         ATTkmmhJhXJDareS/2bjVlSIpxVU4BdrCFXgu1G5UY3tENRUQC/aLW0oM62GuRWusT
         4tiFVd91Hm8G2PlJ0JCgulVbO97gesKU2biSAfMGDU9f9f+76O/bmtvuOyJFoajKo8
         cUH7O1wEBu5OA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6EAE74038F; Thu,  9 Sep 2021 17:32:56 -0300 (-03)
Date:   Thu, 9 Sep 2021 17:32:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, yao.jin@linux.intel.com, namhyung@kernel.org,
        kim.phillips@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf annotate: Add fusion logic for AMD microarchs
Message-ID: <YTpveO0qqKFTaxTk@kernel.org>
References: <20210906105640.1040-1-ravi.bangoria@amd.com>
 <20210906105640.1040-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210906105640.1040-2-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 06, 2021 at 04:26:40PM +0530, Ravi Bangoria escreveu:
> AMD family 15h and above microarchs fuse a subset of cmp/test/ALU
> instructions with branch instructions[1][2]. Add perf annotate
> fused instruction support for these microarchs.
> 
> Before:
>          │       testb  $0x80,0x51(%rax)
>          │    ┌──jne    5b3
>     0.78 │    │  mov    %r13,%rdi
>          │    │→ callq  mark_page_accessed
>     1.08 │5b3:└─→mov    0x8(%r13),%rax
> 
> After:
>          │    ┌──testb  $0x80,0x51(%rax)
>          │    ├──jne    5b3
>     0.78 │    │  mov    %r13,%rdi
>          │    │→ callq  mark_page_accessed
>     1.08 │5b3:└─→mov    0x8(%r13),%rax
> 
> [1] https://bugzilla.kernel.org/attachment.cgi?id=298553
> [2] https://bugzilla.kernel.org/attachment.cgi?id=298555
> 
> Reported-by: Kim Phillips <kim.phillips@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 37 ++++++++++++++++++++-
>  tools/perf/util/annotate.c                  |  1 +
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 24ea12ec7e02..46d7124cc4e1 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -144,8 +144,31 @@ static struct ins x86__instructions[] = {
>  	{ .name = "xorps",	.ops = &mov_ops, },
>  };
>  
> -static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
> +static bool amd__ins_is_fused(struct arch *arch, const char *ins1,
>  			      const char *ins2)
> +{
> +	if (strstr(ins2, "jmp"))
> +		return false;
> +
> +	/* Family >= 15h supports cmp/test + branch fusion */
> +	if (arch->family >= 0x15 && (strstarts(ins1, "test") ||
> +	    (strstarts(ins1, "cmp") && !strstr(ins1, "xchg")))) {
> +		return true;
> +	}
> +
> +	/* Family >= 19h supports some ALU + branch fusion */
> +	if (arch->family >= 0x19 && (strstarts(ins1, "add") ||
> +	    strstarts(ins1, "sub") || strstarts(ins1, "and") ||
> +	    strstarts(ins1, "inc") || strstarts(ins1, "dec") ||
> +	    strstarts(ins1, "or") || strstarts(ins1, "xor"))) {
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool intel__ins_is_fused(struct arch *arch, const char *ins1,
> +				const char *ins2)
>  {
>  	if (arch->family != 6 || arch->model < 0x1e || strstr(ins2, "jmp"))
>  		return false;
> @@ -172,6 +195,15 @@ static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
>  	return false;
>  }
>  
> +static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
> +			      const char *ins2)
> +{
> +	if (strstarts(arch->vendor, "AuthenticAMD"))
> +		return amd__ins_is_fused(arch, ins1, ins2);
> +
> +	return intel__ins_is_fused(arch, ins1, ins2);
> +}
> +

Can we instead make x86__ins_is_fused be a pointer and instead of
storing arch->vendor we set it to one of amd__ins_is_fused() or
intel__ins_is_fused()?

I.e. here:

>  static int x86__cpuid_parse(struct arch *arch, char *cpuid)
>  {
>  	unsigned int family, model, stepping;
> @@ -184,6 +216,9 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
>  	if (ret == 3) {
>  		arch->family = family;
>  		arch->model = model;
> +		arch->vendor = strndup(cpuid, 12);

		x86__ins_is_fused = strstarts(cpuid, "AuthenticAMD") ?
					amd__ins_is_fused :
					intel__ins_is_fused;


?

> +		if (!arch->vendor)
> +			return -1;
>  		return 0;
>  	}
>  
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0bae061b2d6d..88326bb990b5 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -77,6 +77,7 @@ struct arch {
>  	bool		sorted_instructions;
>  	bool		initialized;
>  	void		*priv;
> +	char		*vendor;
>  	unsigned int	model;
>  	unsigned int	family;
>  	int		(*init)(struct arch *arch, char *cpuid);
> -- 
> 2.27.0

-- 

- Arnaldo
