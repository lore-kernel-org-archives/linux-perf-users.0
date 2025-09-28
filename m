Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205981C5F10;
	Sun, 28 Sep 2025 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759037521; cv=none; b=bkR3NsGjjAHJ8LO8K04S1zRWq9U5mm7zo3TkO4ya3gTrGphILNDv0FThptOrSJ3F6xFeJqC+Vo6+gzJx9bG9WWYkH+2UHhIaWFZNDrtHwg5l5BxVFy7SMqcJczZiJd4rlFs6l2QEDZ9EOp1tKEH3Z4AgVwVISE6KgyeXhtmXN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759037521; c=relaxed/simple;
	bh=ucgroTDJSm6qX08whIWfAvIq4GU5IY/Av8vzyBCPrCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tl1nXiki7ckkBdRZQXVPmnZIpnEOF1YzueHWUXRvNiQxaxloF1zZ2GOcsfxnlljZOaQ+6z9M6EJ9R87YuQDCgazqQ/IeBXriQKywKHL3UswAHe7UpptpQ7NnpJE4gXtiylqG6BJrUJF6LzOcVQZSUNrC46KgbbagbrPo1BJ+9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfgmSxf7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfgmSxf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759037520; x=1790573520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ucgroTDJSm6qX08whIWfAvIq4GU5IY/Av8vzyBCPrCY=;
  b=FfgmSxf7X4hD0TWzn0ushfuvFb1isqa5x4cIpf3HF4pWvskfjtGf0+16
   90/atzmPqAFYe5Vj/r58Fl/SGT8ZEscCyR/fqdobk5IpHLK6eREiCfhwQ
   AWOS6aYHdLghq8g0vfZ/FXn4vXK6eqSOvmHo6d5owj4jiZgLELMztquSz
   hwBn44Bi3u8xZMI+0ba7DWR4MP8GBhE74waer+YkNk5jnAkXuC4NPMzfI
   a+yjqJ95uZmwout57bD00G3RsmmDlRTXSGMT/9HykIgj+iB8zxDNOT/8r
   thk2GnlAAVg77E8x4qlLEcmU2GdlLx+Nn7efKTUTP++OkNKOv2Dw0svLL
   g==;
X-CSE-ConnectionGUID: swWLsHgKSTWrTo8ZIgBDtw==
X-CSE-MsgGUID: Gl7PFEvLT8qORrsqjYABiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="72748757"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="72748757"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 22:31:59 -0700
X-CSE-ConnectionGUID: 8i6h/zTvT4STyuqwIoredA==
X-CSE-MsgGUID: mnzAlVQKRA24JFoMuKXPzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="182354486"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 22:31:54 -0700
Message-ID: <8476ee65-546a-47ff-951c-5b2a24995ccf@linux.intel.com>
Date: Sun, 28 Sep 2025 13:31:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 03/17] x86/fpu/xstate: Add xsaves_nmi
To: Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <bc8a902f-549a-482f-bf24-04cf5f38a379@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <bc8a902f-549a-482f-bf24-04cf5f38a379@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/25/2025 11:07 PM, Dave Hansen wrote:
> On 9/24/25 23:11, Dapeng Mi wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> There is a hardware feature (Intel PEBS XMMs group), which can handle
>> XSAVE "snapshots" from random code running. This just provides another
>> XSAVE data source at a random time.
>>
>> Add an interface to retrieve the actual register contents when the NMI
>> hit. The interface is different from the other interfaces of FPU. The
>> other mechanisms that deal with xstate try to get something coherent.
>> But this interface is *in*coherent. There's no telling what was in the
>> registers when a NMI hits. It writes whatever was in the registers when
>> the NMI hit. It's the invoker's responsibility to make sure the contents
>> are properly filtered before exposing them to the end user.
>>
>> The support of the supervisor state components is required. The
>> compacted storage format is preferred. So the XSAVES is used.
> The changelog here is looking a bit munged from the last time I looked
> at it. It's getting a bit hard to read. I'd probably run it through your
> favorite LLM (and proofread it after of course) to make it more readable.
>
> Ditto for the comments.

Sure. Thanks.


>
> Also, what supervisor components are involved here? Aren't we just
> talking about [XYZ]MM's?

Besides the SIMD registers [XYZ]MM, the CET_USR (only SSP) and APX eGPRs
would be supported as well.


>
>> +/**
>> + * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
>> + * @xstate:	Pointer to the buffer
>> + * @mask:	Feature mask to select the components to save
>> + *
>> + * The @xstate buffer must be 64 byte aligned.
>> + *
>> + * Caution: The interface is different from the other interfaces of FPU.
>> + * The other mechanisms that deal with xstate try to get something coherent.
>> + * But this interface is *in*coherent. There's no telling what was in the
>> + * registers when a NMI hits. It writes whatever was in the registers when
>> + * the NMI hit.
>> + * The only user for the interface is perf_event. There is already a
>> + * hardware feature (See Intel PEBS XMMs group), which can handle XSAVE
>> + * "snapshots" from random code running. This just provides another XSAVE
>> + * data source at a random time.
>> + * This function can only be invoked in an NMI. It returns the *ACTUAL*
>> + * register contents when the NMI hit.
>> + */
> First, please use actual paragraphs. This isn't a manpage.
>
> But this whole comment kinda rubs me the wrong way.
>
> For instance, I don't think we need to relitigate the XSAVE architecture
> with the "The @xstate buffer must be 64 byte aligned." comment. Even if
> we did, that's just silly when you could put a one-liner WARN_ON() in
> the function which would be a billion times better than a comment.

Yes, thanks.


>
> I'm not sure what "interfaces of FPU" means. I know it came mostly out
> of some earlier mails I wrote. But could we trim this down, please?

I suppose the "interfaces of FPU" should indicate the xsaves() helper.
Sure. I would rewrite the comments and make it more accurate. Thanks.


>
> We basically want to scare anyone else away that might be tempted to use
> this.
