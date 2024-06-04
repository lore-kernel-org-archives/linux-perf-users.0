Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717CEEDE;
	Tue,  4 Jun 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509221; cv=none; b=iXmAyrlrHHI5LzO0pnVluiJv/2feEqERH451XzeQk7hakwI1A2TwdtCDWCWXmyfVKuOWkUnXw/YInHp4j+88bZba/wVBENKR2eFV9f4qOi9F0XsBChe2EXbrT3Py9gqMmsBTM3xEqU4IxFnuxSSQaqHhIaaXclsiT5Ty8heBIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509221; c=relaxed/simple;
	bh=dAdEf5iipnPjArof0V7dG1ouqn31Kn9Bdd1WpfRQNFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siphmZzh+a6dv+gbB2KqFDuDubumwXsNFMF2erRPPDuwoouEOPGr2lGDYF1geCn42Q+9w20uRu1Hp+/4TuBt+S1hSXjnJnBkrlic/AOtdNT5NixeeI6UK+9Wp/9eFj8UFxLtzVvC3gkNr1dlVt15Q6NU/GKKSslX0POm2GSxTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7jyrp/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7jyrp/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A219C2BBFC;
	Tue,  4 Jun 2024 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509221;
	bh=dAdEf5iipnPjArof0V7dG1ouqn31Kn9Bdd1WpfRQNFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7jyrp/3ULWpnKgENVcFSYA70gLRAUJL/XAAqbHw4B8jzqqXqcZHk9ILF7+URqfw+
	 teDJoP9F0h9SV58H0hem7JJ95q0N/L0e3pj1yH/xh/lcoPJgo32Ev8I4uYclRRvqnK
	 CFtHAgKnF3O3YRLwuXkgFo3n3+cqxR4illnikPsKuKmIvUltV08bAU+rS8h1Gla27t
	 ogLLiPA9kLj3Uc6FUV4HaGnI+yFVR/w55X8Rbtd75zahgSmbEiAl9Pd3d6y/bjXfLh
	 eQ88nglNvCgK7SfvTI4Y+CpCTA/H7XZi7jOUlHFkfEP0ibmVCavxnNcwBHOUDWQEjo
	 8TVGHt7z4zSHA==
Date: Tue, 4 Jun 2024 10:53:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>, Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Message-ID: <Zl8cYk0Tai2fs7aM@x1>
References: <Zl4MYzhP0NB-Z1DW@x1>
 <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl7aOk2h4_73JmUu@J2N7QTR9R3>

On Tue, Jun 04, 2024 at 10:11:22AM +0100, Mark Rutland wrote:
> Hi Arnaldo,
> 
> On Mon, Jun 03, 2024 at 03:33:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > To get the changes in:
> > 
> >   0ce85db6c2141b7f ("arm64: cputype: Add Neoverse-V3 definitions")
> >   02a0a04676fa7796 ("arm64: cputype: Add Cortex-X4 definitions")
> >   f4d9d9dcc70b96b5 ("arm64: Add Neoverse-V2 part")
> 
> As a heads-up, there are likely to be a couple more updates here
> shortly:
> 
>   https://lore.kernel.org/linux-arm-kernel/20240603111812.1514101-1-mark.rutland@arm.com/
> 
> > That makes this perf source code to be rebuilt:
> > 
> >   CC      /tmp/build/perf-tools/util/arm-spe.o
> > 
> > The changes in the above patch add MIDR_NEOVERSE_V[23] and
> > MIDR_NEOVERSE_V1 is used in arm-spe.c, so probably we need to add those
> > and perhaps MIDR_CORTEX_X4 to that array? Or maybe we need to leave this
> > for later when this is all tested on those machines?
> 
> Hmm... looking at where that was added this is somewhat misnamed, this
> is really saying that these cores use the same IMPLEMENTATION DEFINED
> encoding of the source field. That's not really a property of Neoverse
> specifically, and I'm not sure what Arm's policy is here going forwards.
> 
> We should probably rename that to something like
> common_data_source_encoding, with a big comment about exactly what it
> implies.
> 
> I would not touch this for now -- someone would have to go audit the

Ok, you mean not touch tools/perf/util/arm-spe.c, right, can I just go
ahead and update the copy of that header so that we have a clean (of
build warnings) build?

Thanks for checking!

- Arnaldo

> TRMs to check that those other cores have the same encoding, and I think
> it'd be better to do that as a follow-up.
> 
> The relevant commit was:
> 
>   4e6430cbb1a9f1dc ("perf arm-spe: Use SPE data source for neoverse cores")
> 
> Mark.
> 
> >   static const struct midr_range neoverse_spe[] = {
> >           MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> >           MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> >           MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> >           {},
> >   };
> > 
> > That addresses this perf build warning:
> > 
> >   Warning: Kernel ABI header differences:
> >     diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Besar Wicaksono <bwicaksono@nvidia.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Link: https://lore.kernel.org/lkml/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/arch/arm64/include/asm/cputype.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
> > index 52f076afeb96006c..7b32b99023a21d3a 100644
> > --- a/tools/arch/arm64/include/asm/cputype.h
> > +++ b/tools/arch/arm64/include/asm/cputype.h
> > @@ -86,6 +86,9 @@
> >  #define ARM_CPU_PART_CORTEX_X2		0xD48
> >  #define ARM_CPU_PART_NEOVERSE_N2	0xD49
> >  #define ARM_CPU_PART_CORTEX_A78C	0xD4B
> > +#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
> > +#define ARM_CPU_PART_CORTEX_X4		0xD82
> > +#define ARM_CPU_PART_NEOVERSE_V3	0xD84
> >  
> >  #define APM_CPU_PART_XGENE		0x000
> >  #define APM_CPU_VAR_POTENZA		0x00
> > @@ -159,6 +162,9 @@
> >  #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
> >  #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
> >  #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
> > +#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
> > +#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
> > +#define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
> >  #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
> >  #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
> >  #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
> > -- 
> > 2.44.0
> > 
