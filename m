Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CA1DED44
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131420; cv=none; b=OEMOZBHOuPVtk9tWK6F4Ci9gWru24A0Sv3Mh4bJALMKG8RBU3HCa/yYgTJglWH7WFkDWodjnk1V2iT8N0Qg5F0jbR/CeTjcEQCy6DvZM6l1CRAnqTnfPOpd43K6jLsSsliVyN3WcSHoCBJ4H6kiZFDz3iEg0zbxEjMQd52BZaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131420; c=relaxed/simple;
	bh=f89FKjt89JAmV4RDpYFHzqYxDMJrlu5OTs5W7BR5H8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNQHw4eP4Xa1lzKhqTT2ElC+kLIqZvFuHOXOYsbKX4jn2Y3+oBWO5gDYhGRZI/3TTjgJvzcYc/QuYPxO9FvQgV/Fj/exXBHs4JZsiYPcBnORg2ifYgKZGk9D2T7yIGvxp8M1b0cqvhXYkTy6x5emTSp1K9DAM4EeY5TXhgpLtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZFrWGRx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZFrWGRx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131418; x=1761667418;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f89FKjt89JAmV4RDpYFHzqYxDMJrlu5OTs5W7BR5H8g=;
  b=jZFrWGRxvnJx5SzarmEX+BMc8FmGxukG6hKaGPgPy0TiCL5NZjFqIJ8/
   YX3bAssFFRR8oFvRGNJArW6sUSFJsVK2FXrVVdBoxZ7Q3mgLKBXEAeWKA
   BNSfydoHmupNHvX7k423GdeITclbM6ME4Q7mh7ha04lkurl8diB6bJqAA
   tnUQg51KZQCqCNOkO3uxmLjgBgcAxHkkczVyD0lRI1ZGTndcvl8ijJe4/
   3d5BpK4122SuxYdsMJHVpQLVlI+YTUux9CigAk5kS1LE1ekNEz59H/2g6
   GsmlP1yiSTTOXVaf4x0WlMwjSyhi6KA/C1j/7JNgD6cjZ4XqrJpGgnuzw
   A==;
X-CSE-ConnectionGUID: Byb+HPa2RnCVbO+iu/bK8A==
X-CSE-MsgGUID: 81cKvL+QRrWpousDieDaOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29165345"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29165345"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:03:37 -0700
X-CSE-ConnectionGUID: XR3gaTduS22q3O6w4Yhvmg==
X-CSE-MsgGUID: uzXtaPkYTLiO1VoTU9SOTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81555611"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:03:34 -0700
Message-ID: <5eec31c9-a24a-4fe0-a7a6-484eb7dbac7d@intel.com>
Date: Mon, 28 Oct 2024 18:03:24 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Yunseong Kim <yskelg@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
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
 <533a9e5e-b320-41d6-8d8a-223f69d719f5@intel.com>
 <3a6a3cab-6d4f-4136-97d9-3042279eb7a8@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3a6a3cab-6d4f-4136-97d9-3042279eb7a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/10/24 19:08, Yunseong Kim wrote:
> Hi Adrian,
> 
> On 10/24/24 2:58 오후, Adrian Hunter wrote:
>> I would prefer the source.  Does anyone have that?
> 
> Looking through the archives, I found a source version that predates
> September 30th.
> Link:
> https://web.archive.org/web/20240526075334/https://perf.wiki.kernel.org/index.php?title=Perf_tools_support_for_Intel%C2%AE_Processor_Trace&action=edit
> 
> The Markdown version is available here:
> https://github.com/perfwiki/main/blob/main/docs/perf-tools-support-for-intel-processor-trace.md
> 
> You can edit it directly:
> https://github.com/perfwiki/main/edit/main/docs/perf-tools-support-for-intel-processor-trace.md
> 
> Once finalized, it will be visible here:
> https://perfwiki.github.io/main/perf-tools-support-for-intel-processor-trace/
> 
>>>>> Intel PT Link:
>>>>> https://web.archive.org/web/20240930185823/https://
>>>>> perf.wiki.kernel.org/index.php/
>>>>> Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>>>>> Top-Down_Analysis Link:
>>>>> https://web.archive.org/web/20240930164757/https://
>>>>> perf.wiki.kernel.org/index.php/Top-Down_Analysis
>>>
>>>> The corresponding pages in the new site are:
>>>
>>>>  https://perfwiki.github.io/main/perf-tools-support-for-intel-
>>>> processor-trace/
>>>
>>>>  https://perfwiki.github.io/main/top-down-analysis/
>>> It is unfortunate that we can't have some sort of mapping from the old
>>> URLs to the new ones, I can imagine other sites having links that now
>>> will get broken 😕
>> Why do we need mappings?  Just use the same page names and have the
>> redirect keep the final part of the url.
> 
> If possible, I'll try to set up a redirection. Thank you for suggesting
> this good idea.
> 
>> By the way, the new "wiki" doesn't seem to render "page not found"
>> properly for non-existent pages:
>>
>> 	https://perfwiki.github.io/main/not-a-page
> 
> I'll work on fixing this as soon as possible. I see that it's showing a
> 404 page but the webpage style is broken.
> 
> On 10/24/24 3:07 오후, Adrian Hunter wrote:
>> On 23/10/24 21:17, Yunseong Kim wrote:
>>> Hi Adrian,
>>>
>>> Intel PT Link:
>>>
> https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>>>
>>> Top-Down_Analysis Link:
>>>
> https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
>>>>
>>>> Do we still have the old pages?  I would like to check that the Intel PT
>>>> page is not missing anything or munged.
>>>> I do not understand.  Is it a wiki anymore?  If so, what is
>>>> needed to edit a page?
>>>
>>> If you need to update the page directly, I can grant you permission to
>>> do so. This is similar to the previous login system based on Media Wiki.
>>
>> Yes please.
> 
> Are you using the GitHub account from that link?
> https://github.com/ahunter6
> 
> I've sent an writer access request so you can work directly on the
> documentation in the repository.

Thank you! You have been very helpful :-)

