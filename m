Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA93AE184;
	Mon,  7 Sep 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764352; cv=none; b=rN6vVcpQmkISCpGPpNe8eKjKN4Vmv0hufJYbXnf/dPLM/buSMIyLL60PT9uRbFiWPfzKy0VMKFkgJw5mi/zlJvbFE39QdoYAIZTCPy63nDD6HKBOCu40TqHVb5a4EEw4IkaoVgVehtYXy27y7jCiCzLq/Al7sPtr19FPBpePdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764352; c=relaxed/simple;
	bh=aYg7IqzT4yNFRQ02whBuskucpE8cxisvtwrPlIGJKJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euJw23ZjqaXlbI0pHziW7ECX4Fedr3z7kTkTtj9/OFxe1JmTus264MgBqPL/BP9oLxP0Ob+VOCxrNCMW73+zHDCcHEB85vqhJrEv3kzYeIwEvr1OofzKq4LinC0Ejxq3IkKhuEgCIpmsFhWmeQMeGrg+3+2ybACLPWAJuqqXgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STDdpSLE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STDdpSLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788764350; x=1820300350;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aYg7IqzT4yNFRQ02whBuskucpE8cxisvtwrPlIGJKJA=;
  b=STDdpSLEnmQVBgi+ojNAmLs8YbM/edXYDmxN/RZn5cfV1bO/RRaXxseD
   wz2+obwzsh4u9cexk843xbOJRLVzoXWRTwImUTnM6V35AidPp+bz+YUjZ
   AUkeSv4tgrRisKt4FDVzhgdz4Q7tB45VGGES/8ZB8yQhjqceeJ1+3HfvM
   DzvQxF/EUe9GWIPyOj6RMeQefSseChPHvWzRTdyLzh9oQMviyzm/7xYx2
   8HJUc7eYCjc6ec5NYFyL6Fn6TgZo2HRcqnRvN6A2UDC0zw0MCINFzz8kP
   PrwNLa/S4K5O5pesUoOFCwqMtKBZxDm6wpcZgJaql575EOOfQYIC2OwKa
   Q==;
X-CSE-ConnectionGUID: 5YrkCqjUQoes3MB7qq49Sg==
X-CSE-MsgGUID: AA1H4MWBT/GINyR/osXB9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="111938280"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="111938280"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:59:10 -0700
X-CSE-ConnectionGUID: imVVpEEmSmyOaBfoyY4vjQ==
X-CSE-MsgGUID: b5fm6a70TkuDFZQngDmxRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="268051901"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:59:05 -0700
Message-ID: <3e7e23b1-4352-4dba-8b5a-b01119ff5db6@linux.intel.com>
Date: Mon, 7 Sep 2026 14:59:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Annotate x86_pmu::hybrid_pmu with
 __counted_by_ptr
To: Ian Rogers <irogers@google.com>, Thorsten Blum <blum@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260904141659.224248-2-blum@kernel.org>
 <CAP-5=fWj0YAUimSwGLrZpikH4dHkWSsupyE+esbNg6rM-m1sUg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWj0YAUimSwGLrZpikH4dHkWSsupyE+esbNg6rM-m1sUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks.

On 9/4/2026 11:47 PM, Ian Rogers wrote:
> On Fri, Sep 4, 2026 at 7:17 AM Thorsten Blum <blum@kernel.org> wrote:
>> Add __counted_by_ptr() to x86_pmu::hybrid_pmu to improve access bounds
>> checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>>
>> Signed-off-by: Thorsten Blum <blum@kernel.org>
>> ---
>>  arch/x86/events/perf_event.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index 71ed5b2acea2..b66691a4fc31 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -1050,7 +1050,7 @@ struct x86_pmu {
>>          * unique capabilities.
>>          */
>>         int                             num_hybrid_pmus;
>> -       struct x86_hybrid_pmu           *hybrid_pmu;
>> +       struct x86_hybrid_pmu           *hybrid_pmu __counted_by_ptr(num_hybrid_pmus);
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
>>         enum intel_cpu_type (*get_hybrid_cpu_type)      (void);
>>  };
>>
