Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A590446B7
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192268; cv=none; b=RJctKTqpoCO3fOPZd2LmM60eAxuR6RKlOl4lmDoSM1LvU3PN/JgVZu5MiWUFlhbGk9cDD9YUZZwETvYb9TbObGN5/qvdNEnemei7z7uDQna0KXptom2ZlY4szyvEc8nLhEXDZ34zayZb3r93NnESklAaIt6/B+afDu+e4uztu/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192268; c=relaxed/simple;
	bh=+T3ycTcCDy0tnmizdSWC17kHTjNCUBtamiI67/60Ayo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrNaSIfTSu4gbVJJr6NoCK/eF0W8uR1L3OPFT6Wwt/zb4nqOZ3FTl9SM6CAMYGIStWGKCjPwxTOfJvRREA3Erj3E9/7K45BL05oGIHE/f8ovCQMnmQhwg+rvZDB0WncbFgelVzw3Yox6f8w63Nr3P1lB/jao54XbwXBNwszOGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtA58i0J; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtA58i0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709192266; x=1740728266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+T3ycTcCDy0tnmizdSWC17kHTjNCUBtamiI67/60Ayo=;
  b=HtA58i0Jycu2T3eSnqzALgg83r0dTSgCaquKd0ImE/JbWnALs04mXYdH
   WV/exaleUqfRey22iOUHa6Q66XuDY4oRGJjDNcKrAIkt2FqYmX7XydGtf
   yr7ZUWjxq1adgsctnyagGaIO8GN8Vym/T13+YBUrkHAYBMfUyQMovuoq1
   3BCF3W+af3/IRl4ICUrvLp+E93KkJZPk1hli7tfnbaK6RmYSKacgSasYm
   mdFJlQq7V5BzqPHJGVIB8rnk8ysi7+qCM9O951FC62zW4HRZfrfzM09TQ
   SFXspVatrK7ZXsgglw02B3alNWMqaoL5t5Uw0mY5sKfEsHLnHc0l2JHD1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="15082949"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="15082949"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12300524"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.103])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:37:41 -0800
Message-ID: <06855b29-4908-402c-a166-4983576d60e7@intel.com>
Date: Thu, 29 Feb 2024 09:37:33 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf, script: Minimize "not reaching sample" for
 brstackinsn
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
References: <20240227183910.55824-1-ak@linux.intel.com>
 <ceb7d039-5088-45e7-b7ea-8f2056f5f7dc@intel.com> <Zd_Cw6QeuGx-Dblm@tassilo>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zd_Cw6QeuGx-Dblm@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/24 01:33, Andi Kleen wrote:
>>> There are two common cases where the message is bogus:
>>> - The LBR only logs taken branches, but the branch might be a
>>> conditional branch that is not taken (that is the most common
>>> case actually)
>>
>> How do you know it is not a taken branch that missed the LBR update?
> 
> I don't, but the not taken case is totally valid (and also common)
> so it doesn't make sense to have a mere sanity check make a common
> case unusable.
> 
>>
>>> - The LBR sampling uses a filter ignoring some branches,
>>> but the perf script check checks for all branches.
>>
>> Not understanding this case.  Do you mean you expect not to reach
>> the sample, so there is no point printing the message?
> 
> If the LBR is e.g. filtered on far branches it makes no sense to 
> check for non far branches. There are lot of filtering cases here which
> would be very complicated to handle for a mere sanity check,
> so the best way is to not do the bogus sanity check.

This comment could be updated

	 * between final branch and sample. When this happens just
	 * continue walking after the last TO until we hit a branch.

It's not clear why "attr->branch_sample_type == 0" is there.

