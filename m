Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17661175A9A;
	Mon, 27 Apr 2026 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256934; cv=none; b=FlyC9pp/4lzTysFb9/E9J73eKZvtrGlxnhJdOrWDbOC9P8hMGIllzW9l30bSxWO4mGWhmovo2rpiwdp2n2BPqxxdEiEwJLLn0iSXSnxLSUTxgvuEKQxPcTZJRJV2rWDHSCEnh17pylR+0LsyhwE2CXJOFWCWTXh2HeISfIoASSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256934; c=relaxed/simple;
	bh=i8gqAuFNUK8Q6Vx5zHl08vt8VAdZ4gaMq0NwUSuJVVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxzG6BGm4PNCSAHIpfN399ZSLk/TQtwz3YGUdF2KO8L8k4vre/JLscDZv3y/K9P8EcGdnYRYC0GKHr7VtL5cUIKlkaaHJjxs0yC8rqtz8IkgcyCoaCvTnq20pHK47m0IYcVodkvhpkNN4gr4C2SjOrNx4wAAPNoloYIkPPupZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY+qMloK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY+qMloK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777256933; x=1808792933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i8gqAuFNUK8Q6Vx5zHl08vt8VAdZ4gaMq0NwUSuJVVc=;
  b=VY+qMloKeYUD0MiZTQpX62ZwPp9tLRDNzLuobdHdTZpFg0YDlm3viI9y
   TlQT95NwVHEPYOGSaOZyU9UBUtelRzPpxdNRAQNH3tQI8Rb8j/Wmpoiwb
   xcgBZYxxIMM3Q0OIg49OMLzbsvxK3KeJIdG5Iyu2jaCHRyyDFNpT+nndb
   1BGFZf/FZaPH+/PdPKpLvR43TqnoSrUHRsU69fz5sYiFzOjzpz5PWGUr5
   WIpiJ8yZ76dipm0xcePEc1XUK2X4ws0Fr2Lmks6CzxJGJUPfsHx9b9K4f
   vwj3Lh1KkhtRIOIbczSq5+QENFAXadysSTfF9QSW7U76N3spXPDxBkoXk
   A==;
X-CSE-ConnectionGUID: sSyNj7hFT6WYEwvSAH1T+g==
X-CSE-MsgGUID: 1SOSGcvXQUq7r9YfRpdKeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78125377"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78125377"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:28:52 -0700
X-CSE-ConnectionGUID: yr6Yeo8MQpu4oQxzgqtObg==
X-CSE-MsgGUID: RshLQUYFS1aAsYKp28qf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="257025239"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:28:48 -0700
Message-ID: <72db96b7-a71f-4570-aaab-b5c3956b98ad@linux.intel.com>
Date: Mon, 27 Apr 2026 10:28:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] perf/x86/intel: Make @data a mandatory param for
 intel_guest_get_msrs()
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>
References: <20260423150340.463896-1-seanjc@google.com>
 <20260423150340.463896-4-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260423150340.463896-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/23/2026 11:03 PM, Sean Christopherson wrote:
> Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
> MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
> pointer, and carrying code that suggests @data may be NULL is confusing,
> e.g. incorrectly implies that there are scenarios where KVM doesn't pass
> a PMU context.
>
> Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to support guest DS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 407fd392fd46..7403ca721b6a 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5038,11 +5038,11 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	}
>  
>  	/*
> -	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
> -	 * guest, then there's nothing more to do as disabling PMCs via
> -	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
> +	 * If the CPU doesn't support PEBS in the guest, then there's nothing
> +	 * more to do as disabling PMCs via PERF_GLOBAL_CTRL is sufficient on
> +	 * CPUs with guest/host isolation.
>  	 */
> -	if (!kvm_pmu || !x86_pmu.pebs_ept)
> +	if (!x86_pmu.pebs_ept)
>  		return arr;
>  
>  	/*

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


