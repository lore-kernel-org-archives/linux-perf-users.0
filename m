Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F187641E
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729749527; cv=none; b=s8998kCCxe9Fj2BMi/RnrF4vMl/FDyK59hWkPDYOHhvEcFbCg067orcssl2Y7p7Wt05MbPjZO7vey0nLTkNIzV45kP+nSWf8scPSjC3Ujy4JgsFo37nvekS9u/rSs+/c9Dh9U/rULD9EUifmB9LvhGXpjGAG1DIQr5hY1cXiqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729749527; c=relaxed/simple;
	bh=RW9wc6yAUcLojMi4eaEK6hdnKqGecyiWcQVxGUZKE9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb5UhzovTtE50qqWzlBvj9biUw9CH02mA7wGGcwS1ep1E5R03zSM9o7MqRZANedPX2eEmBe4k/pKHeF1d28ooiJYflghiV/wQo/Mp8t59SMrBscvwGzh2zZiITXfnn4Gdcg9ezzS+wS4HOvSpWAvi/A1thDX2aqRTQZIlrv7uQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCBFa01k; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCBFa01k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729749525; x=1761285525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RW9wc6yAUcLojMi4eaEK6hdnKqGecyiWcQVxGUZKE9g=;
  b=hCBFa01kCAJC4MbezUOQEPUWgGROE9Bw8I5BmsT+hPBg9XKRseON5MMn
   syHvIfGhQmZokoNYN/u/1sOds5K/A2q4kLceNVbSwadn5WW77V8UeDuPe
   ugKFMJPdBD1lw1fDKFWaJcr9MgS+HGmUaa8h73dW2BxzyGX1P293wGBvp
   5iVK5FW/9kBIAs81GPzTBjgdqbW8GHHWcGra1fU/pkYPaehIBwc4BE5qE
   uwboT1JaoDJ0p8EVJ+JF8e4/iiTg5Fb+J8BcB5Z6ZGxi9+ZpVb8mmS7e/
   3CxPuU+Zv3CU1DdrERMfKlfZ4HVQJgW+EradJ3e9jJduxRBL7l7J8JZ39
   A==;
X-CSE-ConnectionGUID: 8kW8VlYmTty4+oDI/YvyTA==
X-CSE-MsgGUID: 1X9sujsmRYK8v1HsgW3OJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="54768252"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="54768252"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 22:58:44 -0700
X-CSE-ConnectionGUID: XESGFCJLTb29PT8nQc9uqw==
X-CSE-MsgGUID: 1J/rqPSQTaGXi9lIsYPnPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="85610700"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 22:58:41 -0700
Message-ID: <533a9e5e-b320-41d6-8d8a-223f69d719f5@intel.com>
Date: Thu, 24 Oct 2024 08:58:36 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org,
 Ian Rogers <irogers@google.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
 <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
 <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
 <ZxlwoN57PF_5YX0F@google.com> <Zxl5sduEDnoxEmd2@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zxl5sduEDnoxEmd2@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/10/24 01:33, Arnaldo Carvalho de Melo wrote:
> On Wed, Oct 23, 2024 at 02:54:40PM -0700, Namhyung Kim wrote:
>> On Thu, Oct 24, 2024 at 03:17:38AM +0900, Yunseong Kim wrote:
>>> On 10/24/24 2:34 오전, Adrian Hunter wrote:
>>>> On 20/10/24 07:49, Yunseong Kim wrote:
>>>>> I would like to express my sincere gratitude to everyone for their help in the
>>>>> official renewal of the perf wiki.
> 
>>>>> Additionally, the reason I chose to use Markdown is that I wanted to actively
>>>>> utilize its media features. For example, I wanted to embed videos,
>>>>> presentation slide or display Mermaid diagrams directly on the page.
>>>>> I thought these features would be welcomed by users who are new to perf tools.
> 
>>>>> On 10/19/24 8:47 오전, Ian Rogers wrote:
>>>>>> On Tue, Oct 15, 2024 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>>>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
>>>>>>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
>>>>>>>>>> Yunseong created:
>>>>>>>>>> https://perfwiki.github.io/main/
>>>>>>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
>>>>>>>>>> to https://perfwiki.github.io/main/
> 
>>>>>>>> To speed things along, and since the old perf wiki was near-unusable anyway,
>>>>>>>> I went ahead and set the redirects from perf.wiki.kernel.org to
>>>>>>>> perfwiki.github.io.
> 
>>>> Links to old pages end up at the main page.  For example:
> 
>>>> https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>>>> https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
>  
>>>> Any way to get them to redirect to the correct page?
> 
>>> We can use web.archive.org as of September 30th of last month.

I would prefer the source.  Does anyone have that?

> 
>>> Intel PT Link:
>>> https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
> 
>>> Top-Down_Analysis Link:
>>> https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
>  
>> The corresponding pages in the new site are:
>  
>>  https://perfwiki.github.io/main/perf-tools-support-for-intel-processor-trace/
>  
>>  https://perfwiki.github.io/main/top-down-analysis/
> 
> It is unfortunate that we can't have some sort of mapping from the old
> URLs to the new ones, I can imagine other sites having links that now
> will get broken :-\

Why do we need mappings?  Just use the same page names and have the
redirect keep the final part of the url.

By the way, the new "wiki" doesn't seem to render "page not found"
properly for non-existent pages:

	https://perfwiki.github.io/main/not-a-page

