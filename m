Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609982E1737;
	Thu, 25 Sep 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812859; cv=none; b=Qt2KNSak5FCswzkNW1LATT/ahsI+GCHULKkIujvG/aGzWIbZowGb6wGlEkjmLYKGd8AqSMhRq8DKaoRrU2xr1r3CjzbjtTi1hhIiCTZFR5qI6jqZRmeq5eXOnD6ncxBVbDMbB6LehW8aTSHLZ2iyDm5vBgXog9qTmY62BHybQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812859; c=relaxed/simple;
	bh=Hn8Nz2QsEgEwXTThIZCX3K9EVu+2yqcnfyaoABTO+Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bea+Prc6a2hCPGSDSLDAxefv5F0jKQHmxFyjX8nwjByukJdFUS8V8zE/MMMviFzbQUuALASqmmiT9/alIz18XRw29L16S5Bf9BXkw7fFyoEPhQhDf7Nz/KmKLduZ0eIFax78Le8dTrdLej/CN0Wacr0s7fFWxYWYuaeK6Qg6KKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eickpeGh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eickpeGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758812858; x=1790348858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hn8Nz2QsEgEwXTThIZCX3K9EVu+2yqcnfyaoABTO+Eo=;
  b=eickpeGhdwq5Ge34R2uvouCMcvsoaXVAUvzXSVbumQQ3erWufhfmXNKu
   wiwLZfYWrnRhDTgWy4Ycuaxd5kj2MqDx8cP0WfSkqipFeDq70wh64cCTd
   32lC1dbwm1bQYE+a/1GXAZdOG+h6ELgMsTUv71X/nkq8+cosLquTW/6U7
   3INaEv8MTp/yE4aPiJARZ9aF/v6aqYvef8plD/FKt1oYKBRZVjfg03EO0
   12IQHfZwDl3G8mKZqFpSX+nLeaxqQ3RaNmsqsR+cBaKCrWB3xj7MZhfH5
   xJ/9E8z7H9NR8oXey6V3c6sAuMSLYlf+5/lHLmRCxFa67r08x+PtyI1Up
   Q==;
X-CSE-ConnectionGUID: 8gRMB2xjTNKTIOiJFlyzkA==
X-CSE-MsgGUID: wQ/0zR/IShamkyczBHqG8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61242848"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61242848"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:07:09 -0700
X-CSE-ConnectionGUID: ZYIn94jwSwWQTrWlb/vDEg==
X-CSE-MsgGUID: ZYMQNOc/SP2Zuv573B424Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="176644501"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.252]) ([10.125.108.252])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:07:08 -0700
Message-ID: <bc8a902f-549a-482f-bf24-04cf5f38a379@intel.com>
Date: Thu, 25 Sep 2025 08:07:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 03/17] x86/fpu/xstate: Add xsaves_nmi
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
 <20250925061213.178796-4-dapeng1.mi@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250925061213.178796-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 23:11, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> There is a hardware feature (Intel PEBS XMMs group), which can handle
> XSAVE "snapshots" from random code running. This just provides another
> XSAVE data source at a random time.
> 
> Add an interface to retrieve the actual register contents when the NMI
> hit. The interface is different from the other interfaces of FPU. The
> other mechanisms that deal with xstate try to get something coherent.
> But this interface is *in*coherent. There's no telling what was in the
> registers when a NMI hits. It writes whatever was in the registers when
> the NMI hit. It's the invoker's responsibility to make sure the contents
> are properly filtered before exposing them to the end user.
> 
> The support of the supervisor state components is required. The
> compacted storage format is preferred. So the XSAVES is used.

The changelog here is looking a bit munged from the last time I looked
at it. It's getting a bit hard to read. I'd probably run it through your
favorite LLM (and proofread it after of course) to make it more readable.

Ditto for the comments.

Also, what supervisor components are involved here? Aren't we just
talking about [XYZ]MM's?

> +/**
> + * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
> + * @xstate:	Pointer to the buffer
> + * @mask:	Feature mask to select the components to save
> + *
> + * The @xstate buffer must be 64 byte aligned.
> + *
> + * Caution: The interface is different from the other interfaces of FPU.
> + * The other mechanisms that deal with xstate try to get something coherent.
> + * But this interface is *in*coherent. There's no telling what was in the
> + * registers when a NMI hits. It writes whatever was in the registers when
> + * the NMI hit.
> + * The only user for the interface is perf_event. There is already a
> + * hardware feature (See Intel PEBS XMMs group), which can handle XSAVE
> + * "snapshots" from random code running. This just provides another XSAVE
> + * data source at a random time.
> + * This function can only be invoked in an NMI. It returns the *ACTUAL*
> + * register contents when the NMI hit.
> + */

First, please use actual paragraphs. This isn't a manpage.

But this whole comment kinda rubs me the wrong way.

For instance, I don't think we need to relitigate the XSAVE architecture
with the "The @xstate buffer must be 64 byte aligned." comment. Even if
we did, that's just silly when you could put a one-liner WARN_ON() in
the function which would be a billion times better than a comment.

I'm not sure what "interfaces of FPU" means. I know it came mostly out
of some earlier mails I wrote. But could we trim this down, please?

We basically want to scare anyone else away that might be tempted to use
this.
