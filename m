Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DF2EFD99;
	Wed, 21 Jan 2026 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982555; cv=none; b=qZXk15Qb+zPA/EelkXmLQuPfhCut31J5k8yo9DhtYuCBouz45YAaaQe8C59KlWTsXVV3cX+nx5Bi90bzTIqlnrngsegXHvTEVu57DKbZ+dUmx3tmL2KnT7DpG3Kb/fjpOo+6xN9993fonC4oJ2nyibjtmku4jaLQomtHFLqGXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982555; c=relaxed/simple;
	bh=c8WqBeT5EpvqfZ2AE8s9hf10KGmr3DUKSbrNwWhdnVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jK92IbBoDxgncWXH2eNdj+gkdHwxqx6Nco48DWkI4VrFa5M5eT6q7nc7aIT861dbZbNybsaysuckKU75STYCDdkZCyvf7THgCRYmDv6K8basqMMjGXc4imASVywSC9YcReaZendvBcXJgigO5oPLdcPRn9rsMTQrckOLb9reYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDrJg8ey; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDrJg8ey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768982552; x=1800518552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c8WqBeT5EpvqfZ2AE8s9hf10KGmr3DUKSbrNwWhdnVA=;
  b=hDrJg8ey5ENCu2OHFcUwZwkQFIVAz/9WOs+HiqYV4wlI4Sx3PcGEPBuv
   26/yfkgJvWuNyPlKpslIOGIMphFGveAcKE1As48uVEpR7cycuHn1SGXeh
   5uV+8hbOs+2DEGr2vBuZ8gexsmcddMvo3nu792mwPmKh9W09c+zIF4zT7
   Jv5BBghWHgf/wuiBEldvIC7OSXzqEU2B/G0+ik0PFAzdCWcAn3Q1xcvTY
   wCqUzjC+bazxzDljBSe+2mnqJp+xwpsEKR+Uwn98GdUaKHTINzM+d8abF
   kdp4Q3EtHZ3wdmoS3NgpW0j+SQJBzfVdmwX+71lCli7UxUsdpkX3gopU4
   w==;
X-CSE-ConnectionGUID: dgq5P/bZRfyQ8qv+f8BX4Q==
X-CSE-MsgGUID: uvMlEqx+RXGJOhqlqKCieg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69402946"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69402946"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:02:28 -0800
X-CSE-ConnectionGUID: G9xn5QVbRu+M4P/9XTksNw==
X-CSE-MsgGUID: MN0evEtGQx6uopfV2PaV7g==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:02:25 -0800
Message-ID: <12dbc1f5-022d-4653-8ac7-01c503a860dd@linux.intel.com>
Date: Wed, 21 Jan 2026 16:02:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/13] perf pmu: Relax uncore wildcard matching to
 allow numeric suffix
To: Ian Rogers <irogers@google.com>, Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-12-zide.chen@intel.com>
 <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/21/2026 3:18 PM, Ian Rogers wrote:
> On Wed, Dec 31, 2025 at 2:49 PM Zide Chen <zide.chen@intel.com> wrote:
>> Diamond Rapids introduces two types of PCIe related uncore PMUs:
>> "uncore_pcie4_*" and "uncore_pcie6_*".
>>
>> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can match
>> and collect events from both PMU types, slightly relax the wildcard
>> matching logic in perf_pmu__match_wildcard().
>>
>> This change allows a wildcard such as "pcie" to match PMU names that
>> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
>>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Can we not merge this. I'd missed a perf tool patch as it was hiding
> in a bunch of kernel uncore updates. At the very least if wildcard
> conventions are updated then the corresponding documentation needs
> updating:
> Documentation/ABI/testing/sysfs-bus-event_source-devices

Ian, thanks for the information. We didn't notice there is such
documentation to describe the name. :(

Besides the documentation, are there other comments? We can update it
together. Thanks.


>
> Thanks,
> Ian
>
>> ---
>>  tools/perf/util/pmu.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 956ea273c2c7..01a21b6aa031 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
>>  {
>>         const char *p, *suffix;
>>         bool has_hex = false;
>> +       bool has_underscore = false;
>>         size_t tok_len = strlen(tok);
>>
>>         /* Check start of pmu_name for equality. */
>> @@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
>>         if (*p == 0)
>>                 return true;
>>
>> -       if (*p == '_') {
>> -               ++p;
>> -               ++suffix;
>> -       }
>> -
>> -       /* Ensure we end in a number */
>> +       /* Ensure we end in a number or a mix of number and "_". */
>>         while (1) {
>> +               if (!has_underscore && (*p == '_')) {
>> +                       has_underscore = true;
>> +                       ++p;
>> +                       ++suffix;
>> +               }
>> +
>>                 if (!isxdigit(*p))
>>                         return false;
>>                 if (!has_hex)
>> --
>> 2.52.0
>>
