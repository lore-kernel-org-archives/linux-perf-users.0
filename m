Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFD1A2C04;
	Wed, 16 Sep 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518929; cv=none; b=pltDrGXG+8+qMimN1QohJH4hjqErMEKfNWeDsZnck4Q3WeyR9O6Nj9xkD4Lxv5hmKid4p7flpB1wNxYAg12WythCBt2TMqiiJB5V9x0DsNX4QNqRyViYWUmKbC/yskHUKt6OeCOACxilboyvlERQMzBg/Vd87XAs6jCZoQqSirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518929; c=relaxed/simple;
	bh=hLPf9vFhuPfUgNe2fpZUHC1SPJxWZUSAb4+x/eO8jfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikCoVntDN2rgaNUiuhAFhQBdM+kMuYYKxwVvKyHfRrAlkEDBz2gCvw0l6DNB5ne7rtHmQRtovvyaJXPa5Io65ZMNFqz3/cgtyQUQyV458vvQGi9UJf24bo6dORQYd8Lvm8ZxDIm1a8JqC6hL1sjGHYxP65v+UAjwmdle5HmiN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leoz2Qw/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leoz2Qw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789518927; x=1821054927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hLPf9vFhuPfUgNe2fpZUHC1SPJxWZUSAb4+x/eO8jfU=;
  b=leoz2Qw/1KQfgAgL07HKRaWwJGwF6eLHm2znX/eNVHNJF2k/KUg+3IgD
   4Gn0Mn+DKLnIel0gNF/pnluaDmCm19dYWrJiMJMq4mYcv9ZHfXxxVemOp
   sEZSwKCLawOOHxSyemBK2AlB8V+8iPMczfIELmX2KTWb5sAEAc6yxtjmO
   jwZeAtKwHCXBQC7EaeKb5766zFgoM/RiWLBNqFM/60lObN1/f7I+TDm2n
   G0Uw56hpvskVeVR7QWHCOenjGwAVgNe7Y++KV5og5/WxFzLhnsyhuKwtJ
   V7rnKT0NZB4GvhADhQDiwYwGM7ebH/2klLLnpo1AvCW1FAs8D4Jqrv/AF
   w==;
X-CSE-ConnectionGUID: ou2wmyf4T5+7rd7QDDCrRg==
X-CSE-MsgGUID: 4l1lztA2T4+rd7auG97Sqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100556191"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100556191"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:35:26 -0700
X-CSE-ConnectionGUID: OhZ01ZP7ROa5x9FCNUeGag==
X-CSE-MsgGUID: Z1JFs6irT/ay83ST5uYWfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296675567"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:35:23 -0700
Message-ID: <4d1bd9c1-5b91-44c7-94c3-a93600b98fe7@linux.intel.com>
Date: Wed, 16 Sep 2026 08:35:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] _x86: intel: pt: fix potential null dereferences
To: Ian Rogers <irogers@google.com>, Shi Hao <i.shihao.999@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, hpa@zytor.com,
 Smatch static checker <smatch@kernel.org>
References: <20251022184230.124113-1-i.shihao.999@gmail.com>
 <CAP-5=fU8NcQKS=aMVDg8KoRbdeqwkrp=r_WncUkCf3PWYWcYDw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fU8NcQKS=aMVDg8KoRbdeqwkrp=r_WncUkCf3PWYWcYDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/16/2026 6:00 AM, Ian Rogers wrote:
> On Wed, Oct 22, 2025 at 11:45 AM Shi Hao <i.shihao.999@gmail.com> wrote:
>> Add checks to prevent potential null dereferences of buf->stop_te
>> and buf->intr_te in pt_buffer_reset_markers function.
>>
>> Smatch reported possible null dereferences of buf->stop_te and
>> buf->intr_te in the pt_buffer_reset_markers() and when i checked
>> both pointers were checked for null dereferences in earlier lines
>> however,after calling pt_topa_entry_for_page() where its return
>> value is NULL in certain conditions there were no checks for further
>> buf->stop_te and buf->intr_te uses which could potentially be null
>> dereferenced.
>>
>> To avoid null dereference add checks after each pt_topa_entry_for_page()
>> call to safely handle null returns and also add checks where there was
>> direct dereference of the pointers.
>>
>> Reported-by: Smatch static checker <smatch@kernel.org>
>> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> The addition of null checks to make smatch happy lgtm. Dapeng, could
> you take a look?

Base on the code logic, yeah, it's necessary to add these NULL checks,
although I doubt if pt_topa_entry_for_page() could return NULL in reality.
It indicates something is wrong if pt_topa_entry_for_page() returns NULL.

BTW, the prefix of short log is not correct, it should be
"perf/x86/intel/pt" which follows current naming convention. Thanks. 


>
> Thanks,
> Ian
>
>> ---
>>  arch/x86/events/intel/pt.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
>> index e8cf29d2b10c..2b7d5d118b48 100644
>> --- a/arch/x86/events/intel/pt.c
>> +++ b/arch/x86/events/intel/pt.c
>> @@ -1148,7 +1148,8 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
>>         if (idx != buf->stop_pos) {
>>                 buf->stop_pos = idx;
>>                 buf->stop_te = pt_topa_entry_for_page(buf, idx);
>> -               buf->stop_te = pt_topa_prev_entry(buf, buf->stop_te);
>> +               if (buf->stop_te)
>> +                       buf->stop_te = pt_topa_prev_entry(buf, buf->stop_te);
>>         }
>>
>>         wakeup = handle->wakeup >> PAGE_SHIFT;
>> @@ -1162,12 +1163,16 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
>>         if (idx != buf->intr_pos) {
>>                 buf->intr_pos = idx;
>>                 buf->intr_te = pt_topa_entry_for_page(buf, idx);
>> -               buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
>> +               if (buf->intr_te)
>> +                       buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
>>         }
>>
>> -       buf->stop_te->stop = 1;
>> -       buf->stop_te->intr = 1;
>> -       buf->intr_te->intr = 1;
>> +       if (buf->stop_te) {
>> +               buf->stop_te->stop = 1;
>> +               buf->stop_te->intr = 1;
>> +       }
>> +       if (buf->intr_te)
>> +               buf->intr_te->intr = 1;
>>
>>         return 0;
>>  }
>> --
>> 2.51.0
>>
>>
