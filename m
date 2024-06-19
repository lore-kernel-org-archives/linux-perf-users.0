Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258E8175E;
	Wed, 19 Jun 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791247; cv=none; b=CHWqC7dLjHrGtB6rlqIx7t7PU0B1ty4PbK+STXkbLmG9YdJ2x1GJpdUgYp4DQqR2gKyeOkuOzovIwZrC5nkwAGGrrH+h2BBXI9lJsPJ8TJtIoQbMzPiFUVUzJZBEeFfMy1hpKdZlGpIEe7GX/qh2bQwZHnR4VeQLgbb1mHs5TQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791247; c=relaxed/simple;
	bh=eayWKS6Wu7Bqf8vNh/QlnwnY/rDj8Fs1l2UlPp8StoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r84Nt1fdAKPXw8/CB9vEBJWpSc2mP8xUoL5EUDLeWXZtEEZrLhhLJBt7lEnwBUBBQtFRYOBOqfQCTFiElCc9w++rMP0+8KA3nw/5fF3Aa9B8qdabRX/pZlhZaN/MHi+IE6DBuvkHzmzwTOlWnnBDh2Uc/d65Rga87intDiPC4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcihEThj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcihEThj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718791246; x=1750327246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eayWKS6Wu7Bqf8vNh/QlnwnY/rDj8Fs1l2UlPp8StoI=;
  b=TcihEThjv4rH4R0OOdBrrZW+V4YUoLT6jlMmYwqS7fHGJbJVpqNarJqT
   5fwosxa5HqyYIw9YyyKaCBGWFxfo4Wd6ccwcaX1XR1rJc586cSPCLgjN5
   Sfi6pthmk5qMPbIjF5mh3sk25TOGeQBcTNKZ/OaGMWca+ot65bxi5KDJf
   yff/i0atcNMV+dQtQ9Y71fa7xEjU1dpcU+coktbqFagoQf5KUmtak4EZG
   cQG2l3/DsP1YJaAS/t82CTFyF7/VWyp5R/QCtJrsMylG8B/L6K9l/YL8X
   2E1/HGR0l5Pt0SkBJcRq82ysiRue7VXTufzWldZe0hMXhym+c4+U2VJRT
   g==;
X-CSE-ConnectionGUID: qSjihEZMQNeYs1RXfNxrBw==
X-CSE-MsgGUID: niW3AjgcT/ykYgZc+eGY2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15849381"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15849381"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 03:00:45 -0700
X-CSE-ConnectionGUID: wc5mkL1JRqyiNrZZRxpFrw==
X-CSE-MsgGUID: IL9k4KU/R9iAllvTymSjlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="72608683"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 03:00:40 -0700
Message-ID: <6ab8c7fd-c718-49ff-bbbb-9241293127f7@intel.com>
Date: Wed, 19 Jun 2024 13:00:34 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/pt: Update topa_entry base len to support
 52-bit physical addresses
To: Dave Hansen <dave.hansen@intel.com>,
 Marco Cavenati <cavenati.marco@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
 irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
References: <20240618110617.22626-1-cavenati.marco@gmail.com>
 <efc3a224-27b3-4259-a9a3-0296ccbf3e8d@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <efc3a224-27b3-4259-a9a3-0296ccbf3e8d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/24 20:59, Dave Hansen wrote:
> On 6/18/24 04:06, Marco Cavenati wrote:
>> Increase topa_entry base to 40 bits to accommodate page addresses in
>> systems with 52-bit physical addresses.
>> The Base Physical Address field (base) has a length of MAXPHYADDR - 12 as
>> stated in Intel's SDM chapter 33.2.7.2.
>> The maximum MAXPHYADDR is 52 as stated in SDM 4.1.4.
>> Therefore, the maximum base bit length is 40.
> 
> This makes it sound like it's _adding_ support for larger physical
> addresses.  It really was a bug from day one.  MAXPHYADDR has been
> defined to be "at most 52" for a long, long time.  I think it was well
> before 5-level paging came on the scene and actual MAXPHYADDR=52 systems
> came along.
> 
> It probably needs to say something more along the lines of:
> 
> 	topa_entry->base needs to store a pfn.  It obviously needs to be
> 	large enough to store the largest possible x86 pfn which is
> 	MAXPHYADDR-PAGE_SIZE (52-12).  So it is 4 bits too small.
> 
> This isn't the only bug in the area:
> 
>> static void *pt_buffer_region(struct pt_buffer *buf)
>> {
>>         return phys_to_virt(TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
>> }
> 
> At this point, ->base is still a 40-bit (or 36-bit before this patch)
> type.  If it has anything in the high 12 bits, a <<TOPA_SHIFT will just
> lose those bits.

Yes

> 
> But maybe I'm reading it wrong.  If I'm right, this malfunctions at pfns
> over 36-12=24 bits, or 64GB of RAM.  Is it possible nobody has ever
> allocated a 'struct pt_buffer' over 64GB?  Or is this somehow tolerant
> of reading garbage?

Yes, it will go wrong with any physical address above 64GB - 1.
i.e. the machine just needs more than 64GB of memory.

However that code is used only in one place which is conditional on
!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) which is true
only for Broadwell.  Also "snapshot" (and sampling) modes are
unaffected.

Testing on a Broadwell with 400GB of memory confirmed the issue.

