Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F317BD3
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750066; cv=none; b=D5AqFMkl15XCM8ddrLeyLFjowOyuVf5S8JevrfWchKyXclgpQqg6OJvSqWovrYtFz+wPAER7DmFisF1dTjsy37TtoidoZelkqXuqqG+j/tPpTtPP5kVsZxCm5J/AxeX6XA2UUU0JRerUnDGZkd6Fk4zllDl8TLV6HbAftZHCm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750066; c=relaxed/simple;
	bh=QiG8lJs0YLfu8oY7CBN6pN62khzffhNk8Em+KNgaeas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBjjzhulB+UAzqQIkmClZkxWvzcGSwbXV8eJWiSU//7h697lLMp65vPruTqaAWFSh1gkMCE/Y9aryYkNtkQodbBwFz4fp+3JABfbvQBp0zqHOm/GoiB8XxAGgBmJmGenLv8hRNuxNBdwnApuFziiB9UDIKFgavXn6Mnuc9+1kd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWoO+BJl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWoO+BJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729750064; x=1761286064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QiG8lJs0YLfu8oY7CBN6pN62khzffhNk8Em+KNgaeas=;
  b=FWoO+BJl5lJpdaCdb1b5nHDLgCE7aoOOp7G/1+mzsjn2cneubhd4G7Yo
   9TIE+SyR2ON1pXILxcZR41dT1GFD3Hkcz6L/Igscq0docKm9bDVGk6xBZ
   FrvOeBbAmCOFvUrKdmg7ms+z+EIWkUG6feaY57T63fSMyELsHxFGkkvde
   Vzy+LHMJ/HHVvuwqVBTpCMFWEjaCt0KW2nMGT+OdQNm25kopx5IxhV3yq
   g5xmgoXt8OkNhu8Ur2gecznS93XDFOLIEtof02VW7iqGfGNofAIC/KniR
   zAN61HNrPwIf6iCnwLMUUfwH1lf7Q1mLAp7P2xgc1dax7V6DBY+EjT2KV
   w==;
X-CSE-ConnectionGUID: CizTnBZtQ32909C2Vfx2xg==
X-CSE-MsgGUID: jelQ4UCWSaOpnVB7aUdizg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="54768886"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="54768886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 23:07:43 -0700
X-CSE-ConnectionGUID: 3F2NVf/XQkuTXMo4cfa1MA==
X-CSE-MsgGUID: bsrHfAL3SjyGu1nWqTESLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="103811641"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 23:07:41 -0700
Message-ID: <d2955194-9c1f-4e3b-9f73-bc0d7343d32c@intel.com>
Date: Thu, 24 Oct 2024 09:07:37 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Yunseong Kim <yskelg@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
 arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>,
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
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/24 21:17, Yunseong Kim wrote:
> Hi Adrian,
> 
> On 10/24/24 2:34 오전, Adrian Hunter wrote:
>> On 20/10/24 07:49, Yunseong Kim wrote:
>>> I would like to express my sincere gratitude to everyone for their help in the
>>> official renewal of the perf wiki.
>>>
>>> Additionally, the reason I chose to use Markdown is that I wanted to actively
>>> utilize its media features. For example, I wanted to embed videos,
>>> presentation slide or display Mermaid diagrams directly on the page.
>>> I thought these features would be welcomed by users who are new to perf tools.
>>>
>>> On 10/19/24 8:47 오전, Ian Rogers wrote:
>>>> On Tue, Oct 15, 2024 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
>>>>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
>>>>>>>> Yunseong created:
>>>>>>>> https://perfwiki.github.io/main/
>>>>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
>>>>>>>> to https://perfwiki.github.io/main/
>>>>>>
>>>>>> To speed things along, and since the old perf wiki was near-unusable anyway,
>>>>>> I went ahead and set the redirects from perf.wiki.kernel.org to
>>>>>> perfwiki.github.io.
>>
>> Links to old pages end up at the main page.  For example:
>>
>> https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>> https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
>>
>> Any way to get them to redirect to the correct page?
> 
> We can use web.archive.org as of September 30th of last month.
> 
> Intel PT Link:
> https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
> 
> Top-Down_Analysis Link:
> https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
> 
> 
>>>>>> Please feel free to follow up if we need to revisit this, but things look good
>>>>>> to me with this change.
>>
>> Do we still have the old pages?  I would like to check that the Intel PT
>> page is not missing anything or munged.
>>
>>>>>
>>>>> Thanks for your work, it looks good to me too.
>>>
>>> I have been continuously improving the content of the documentation, so please
>>> feel free to share any good ideas you may have. :)
>>>
>>>> Thanks Konstantin and Yunseong, I think it looks good!
>>>> I think the pages need some improving, there are empty pages and
>>>> things that look abandoned, such as the white paper linked from the
>>>> side bar:
>>>> https://perfwiki.github.io/main/white-paper/
>>>> I pushed a few improvements to the glossary and useful links. It
>>>> should be as easy as creating a pull request for others to contribute,
>>>> so I look forward to this.
>>>
>>> Thank you so much Ian, I added per-page editing features to make it more convenient
>>> for people to edit the documentation and submit pull requests.
>>> Link: https://github.com/perfwiki/main/commit/4289b6a6e5c2e53d69a7605d01d0773366a33c52
>>
>> I do not understand.  Is it a wiki anymore?  If so, what is
>> needed to edit a page?
> 
> If you need to update the page directly, I can grant you permission to
> do so. This is similar to the previous login system based on Media Wiki.

Yes please.

> 
> The issue with the old wiki was that logging in was broken(sadly) for
> several months.

I updated the latest manual pages last month.

It is disappointing you did not contact people still updating the
old wiki.

> 
>> Also how can page updates be submitted programmatically?
> 
> You can submit a Pull Request or if you have the necessary permissions,
> you can directly update the document to add changes to the main branch.
> 
>> I had a script auto-updating the latest man pages, using
>> MediaWiki API, which I will have to redo :-(
> 
> Could you let me know what script auto-updating you were performing with
> the URL of the API or the specific functionality? If there is anything
> else you need, please feel free to let me know. I will do my best to
> assist you.
> 
> Best regards,
> Yunseong Kim

