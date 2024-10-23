Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5D1B652C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704876; cv=none; b=Y7iq1G+PWAJvuB7TmDiApmI6Fg2aDzMdeR2pwmApgMREu7f0H8oALPG27gYYW51Fx/tSANOIpCPAxKNzNtkTzh00E9b+1Y4qVeJ4lH753p0pvSlHDYcgpFMje07dk28pu8N5k4LraskBlqQRSrMzzvL0BlJY9xptebJ+21RxPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704876; c=relaxed/simple;
	bh=BSvnNNJiiKMK4xHZDKdZueOHNRC7No8YnLMZ8hCnJUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHFHyerKUCHplh+dkptR7YsPuohurwvgp3AUIoY4OTJkepL263psyRFUxHTdmKUBhiUwo2F8nfFQIaWYOU0yz5EoURIiRqGLwuYstTDQEn2nesfCCq5hkoow38yGnU+G8Xl6OL1KXV1Rz9dKFH7X+HbHMIM80zR0giPPQHyemsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENw9G+4j; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENw9G+4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729704874; x=1761240874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BSvnNNJiiKMK4xHZDKdZueOHNRC7No8YnLMZ8hCnJUM=;
  b=ENw9G+4jjn18ENIxYyJUvg98Z0OQI/KC8EmvU+F+LDT8o57BqcBfG8l6
   3iHS3M5GW4ZBo2YT9Xy4rLtsvI/f2mqdAkvhKIsncixxe2JZTz69bIjOg
   PEjbfVH9WAaroIhjdH1JcAU+838vFCR/JrykWSSf9cmg4fIN7n+Vyw0Cn
   QcDEsZTphOImG6vlS3M1MEDem/LNyz9gBk6MNz6NkcgX8oCkIW7hl4sh4
   7A8Itoyv235t7ghAVKyt3mJBAk1L3k7YPTQdC2+pmkeS81L3d3o6VJw24
   CIRBMOq7ZKpQ2p3zA1dc8R3fGKEsKzbhyvgVlY9Nx97FscKjJ4gbo3tQO
   w==;
X-CSE-ConnectionGUID: XYGiy5ntTd+bayTZZTykIA==
X-CSE-MsgGUID: ZZuLBY98Swq5AszoYyLViQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29089094"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29089094"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 10:34:32 -0700
X-CSE-ConnectionGUID: YqNvyFytSDCUdjvDcYOmgw==
X-CSE-MsgGUID: XPLpDVZBQoSSQgaqqngm1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80227371"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 10:34:29 -0700
Message-ID: <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
Date: Wed, 23 Oct 2024 20:34:19 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Yunseong Kim <yskelg@gmail.com>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 linux-perf-users@vger.kernel.org, Howard Chu <howardchu95@gmail.com>,
 MichelleJin <shjy180909@gmail.com>, Austin Kim <austindh.kim@gmail.com>,
 arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/10/24 07:49, Yunseong Kim wrote:
> I would like to express my sincere gratitude to everyone for their help in the
> official renewal of the perf wiki.
> 
> Additionally, the reason I chose to use Markdown is that I wanted to actively
> utilize its media features. For example, I wanted to embed videos,
> presentation slide or display Mermaid diagrams directly on the page.
> I thought these features would be welcomed by users who are new to perf tools.
> 
> On 10/19/24 8:47 오전, Ian Rogers wrote:
>> On Tue, Oct 15, 2024 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
>>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
>>>>>> Yunseong created:
>>>>>> https://perfwiki.github.io/main/
>>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
>>>>>> to https://perfwiki.github.io/main/
>>>>
>>>> To speed things along, and since the old perf wiki was near-unusable anyway,
>>>> I went ahead and set the redirects from perf.wiki.kernel.org to
>>>> perfwiki.github.io.

Links to old pages end up at the main page.  For example:

https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
https://perf.wiki.kernel.org/index.php/Top-Down_Analysis

Any way to get them to redirect to the correct page?

>>>>
>>>> Please feel free to follow up if we need to revisit this, but things look good
>>>> to me with this change.

Do we still have the old pages?  I would like to check that the Intel PT
page is not missing anything or munged.

>>>
>>> Thanks for your work, it looks good to me too.
> 
> I have been continuously improving the content of the documentation, so please
> feel free to share any good ideas you may have. :)
> 
>> Thanks Konstantin and Yunseong, I think it looks good!
>> I think the pages need some improving, there are empty pages and
>> things that look abandoned, such as the white paper linked from the
>> side bar:
>> https://perfwiki.github.io/main/white-paper/
>> I pushed a few improvements to the glossary and useful links. It
>> should be as easy as creating a pull request for others to contribute,
>> so I look forward to this.
> 
> Thank you so much Ian, I added per-page editing features to make it more convenient
> for people to edit the documentation and submit pull requests.
> Link: https://github.com/perfwiki/main/commit/4289b6a6e5c2e53d69a7605d01d0773366a33c52

I do not understand.  Is it a wiki anymore?  If so, what is
needed to edit a page?

Also how can page updates be submitted programmatically?
I had a script auto-updating the latest man pages, using
MediaWiki API, which I will have to redo :-(

