Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBE479882
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031055; cv=none; b=s5GoDusk4o2xm9cZw4E6o9ETcsFusBzRk432IXV6+vrfaix18WFEXECtFG1VJzwOOA8FMxjJOcPhdJ/KaNKgD+ht2V+rFf4wfY+Uy4kKOATeaotiVNAi05aBmMMC1OIw5knSk6Ul6rOFLLh9jkYYMyoindOUitWwwCPYiRBb1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031055; c=relaxed/simple;
	bh=GKDEC9ykCqZQ8xqRJnSWHDaw9GzmoFDVLxGDzWYoQps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOT+xhjQ0+6MygYRxSg4A78PO1nJoVS/22QqyRnaNzeO62iCgfB9xkXfSfSqCaxwIbdf7OTuQ0UaW73nvq3cfmGVu/NRRuVUGtqAJY/xFcTt8pkg7uNd1yu3A8yURsiEdF+X1ZTBZ3odOn4zNIx+Y4St4WPYfIuxSgu68+Oq6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VJjXC/HD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VJjXC/HD"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-472d9d69e16so164783f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Aug 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786031052; x=1786635852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iSx01LGDtUbLvOtP7e6amy9nD5EBRmC9uScCxD+3X/o=;
        b=VJjXC/HDUDppYclVS7XgUkwEVXfrLLhvMb9Xjw4ZMW9oss+96LMKelEhifFdyHHEsK
         GewCq++n6dIVRn5iCwVWcdSqdnRCRbSi66rUz1DJb65s0IUOJS3e2PVzdSSET5GXCM6f
         /Wi8t7kgwcOUIY2jAhPiUAIOQtzl2W3JxxmeL0vYuQQJVWR+N9ObAyARlFsZnEB0RBRQ
         hj0I2en2XaHzuT3xOY70I4dfKH3o3/g35rUVaVVaI0UCvRJuGHDtdn/Z84kH1iVsIB+P
         aJRb7n3muxJIwoT52gH2+okspuMLsAOUlcecbcd3+FZwXoWSstIXS/UBkHjRlsEWsN2m
         zK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031052; x=1786635852;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iSx01LGDtUbLvOtP7e6amy9nD5EBRmC9uScCxD+3X/o=;
        b=szMkUUYRkvtxNW/6riSdMrkBPStCaB4s/cDdzuPmRR3nFmY5Q+zmDnibmf/bQ7scFG
         Lhs3FehNVZoeSrxVAS+oZjAs7rfP0AX9a+meZnnYTRc7GE2JIVW6IEy7294V+QyAUvRM
         VWj/ZZM6s5iXCPVDLtjugKSVJbywS3XfPr4KgSoNRlNCXPzIt3ueaUCyk8YcWPW7tNn5
         zfgySs2eswCqgxCuQSLAAgSB6J1zFHJVDEGfgZWZlz6JUen77o7gtGVTXgdljuN7J5bf
         Gs1R4ul+0qrAr38HJP9SRRq4tKu3q4V0YalxbcWRHiUEAR2JMiDZKQ+JSsik4HtD2qzI
         PtlA==
X-Gm-Message-State: AOJu0YwZie9BwmDOASbY/U6o5cwRiOqIusOPgauKL0vEiiPyNDitn5q9
	F3floaJs4bkTHkRhhyONmQ64/XEqUpQAO4VJn3+iDwPez4h5Mrg57B9lfEWTc8Ntriw=
X-Gm-Gg: AR+sD12JvrmoRZBRhZQNX3Cv2AmUP3BHZL3w6imfaLzelQ0e3bBIhkUNCCz4bqqRPpI
	ntBr5Oif2DsMjLB8ARUPRfXhhEHjYOunPNj2KA5GGWYrO2icCZ3Q0Ip7BoqkUlyjOORVZLH+UsL
	FsVhP+HC60ASKQWEyqAdCsZ4jkOUyvqOhs8+HBb7EkLcniKMVMIc9YGyM8XDM5dpW8sN2V6P5lW
	/CoXkgIrKKn3g4xFGtoTqBXc5tO5a1750KpGU/5WX+g1rYRJJD/o4KWfvjTuRRtC5pJ2TfTxVPz
	vIobDrifGP5p/ZFD9Hym0V0RREN8476oHCX1oYWpFJmo+b6bowPnp9ggUqAKSgZKonXh6BxaeE/
	lE/bA3NSdYR3WHWie+r5njubZQGtpinrHtwL0lXuBaRoIGyHWesE5tYyVIt2CPBxPVlIsxz4HKt
	e6e8S2j2mMFAg+IJtoqA6UdRH2HuG/slNBXPLPkldZ1XfGKidk2l4qDQPPvS/ZNLCtm0iBpJe4V
	w5mb2pDHYqLisaLFP5urpkQqCYusMCFEMCJ4NZf5bWoMtwszENxrg==
X-Received: by 2002:a05:6000:2892:b0:47f:dfc1:6907 with SMTP id ffacd0b85a97d-47fec62c0d2mr12588910f8f.3.1786031052493;
        Thu, 06 Aug 2026 08:44:12 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b250cfsm7334699f8f.28.2026.08.06.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:44:12 -0700 (PDT)
Date: Thu, 6 Aug 2026 17:44:08 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
 <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
 <ananth.narayan@amd.com>
Subject: Re: [PATCH 3/3] perf/x86/amd: Implement x86_pmu::print_debug
Message-ID: <20260806174408.37b8e232@mordecai>
In-Reply-To: <eedf1d302389327c79a256e8646ac251aba8fefc.1786010408.git.sandipan.das@amd.com>
References: <cover.1786010408.git.sandipan.das@amd.com>
	<eedf1d302389327c79a256e8646ac251aba8fefc.1786010408.git.sandipan.das@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 15:33:28 +0530
Sandipan Das <sandipan.das@amd.com> wrote:

> Implement x86_pmu::print_debug for PerfMonV2 capable processors to dump
> MSR_AMD64_PERF_CNTR_GLOBAL_{CTL,STATUS}, plus MSR_AMD_DBG_EXTN_CFG if
> LBR Extension Version 2 is available. Chain into x86_pmu_print_debug()
> afterwards to dump the event selectors and counters.
> 
> MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_{CLR,SET} are left out since they are
> write-only.
> 
> Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
> Reported-by: Petr Tesarik <ptesarik@suse.com>
> Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

This works great on my system, no more unchecked MSR access errors, and
the logged values look correct. Feel free to add

Tested-by: Petr Tesarik <ptesarik@suse.com>

Thank you!

Petr T

> ---
>  arch/x86/events/amd/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index a787409f5a62..ecd648af81f7 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -841,6 +841,25 @@ static void amd_pmu_v2_disable_all(void)
>  	amd_pmu_check_overflow();
>  }
>  
> +static void amd_pmu_v2_print_debug(int cpu)
> +{
> +	u64 ctrl, status, debugextn;
> +
> +	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctrl);
> +	rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
> +
> +	pr_info("\n");
> +	pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
> +	pr_info("CPU#%d: status:     %016llx\n", cpu, status);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_V2)) {
> +		rdmsrq(MSR_AMD_DBG_EXTN_CFG, debugextn);
> +		pr_info("CPU#%d: debugextn:  %016llx\n", cpu, debugextn);
> +	}
> +
> +	x86_pmu_print_debug(cpu);
> +}
> +
>  DEFINE_STATIC_CALL_NULL(amd_pmu_branch_add, *x86_pmu.add);
>  
>  static void amd_pmu_add_event(struct perf_event *event)
> @@ -1452,6 +1471,7 @@ static int __init amd_core_pmu_init(void)
>  		x86_pmu.disable_all = amd_pmu_v2_disable_all;
>  		x86_pmu.enable = amd_pmu_v2_enable_event;
>  		x86_pmu.handle_irq = amd_pmu_v2_handle_irq;
> +		x86_pmu.print_debug = amd_pmu_v2_print_debug;
>  		static_call_update(amd_pmu_test_overflow, amd_pmu_test_overflow_status);
>  	}
>  

