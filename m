Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954556D1C4
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624013; cv=none; b=GOc1tABhXLF12nN7+08+42lC3OuwwAM7impuTXGWI4H6SIvp9PbWjOMMuiVUevcW53hfqGorZqwsGr4pBy8p2hlw6Y9HmP+zBYGJQKrTd0UC5CrWa+rKGT7WZxbkOElRa0SGx5HOfIzfSItSxAe/ctAZIMET6RToMUkcMqKSFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624013; c=relaxed/simple;
	bh=HWzFLMe5LqdfWpPwj92L8/QKMBVyoA0kyQxQjVj8YHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4tEDFN0fpakpGnE0/KMirPD/dhYdjUS395+D/h1WHlAK+ORwdYPSLKKRiP6u6ch3Xay/XtOTJ7JrJbwt50qdGByLJVlfqZ4wcTT+NzlJi46t/c3xMwABVuQeF9HY/rhVq0MRZoMCcSYjOAL2OMurns0dudJEaAGpvqTS5DKrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6VZr8df; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6VZr8df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706624011; x=1738160011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HWzFLMe5LqdfWpPwj92L8/QKMBVyoA0kyQxQjVj8YHE=;
  b=Q6VZr8dfIZdBBTl+nTKb16OjJ2OOJ4ebyc03giSqK+BR5R9OvjhgHq5z
   7XHmTvPOJrnpSua4JH92u5d39NyGVcMlyp9L+gVsi2VHzzxo+CJ6U+xQC
   ofC8bjyCKJMsgh/+hIka1NEWQRKCqmGGC0oKRrEiGiUDMpzDZOFumy2ja
   xi8jOrEUfGduE4sdSpGiz4NQMUlvpyTx0C056upTuByGruyGdXNKFhvyl
   IBr0MgA0I2hw4kjdIbBq/TTqLw55W++JmGJnrP0cwV7QxNCUVIoEkIsGy
   W/ViDh3Rl8Qb9pGxkzOv3GsGTmlYk+ycjjNCBcOL4SBMsnZb6TbwvGwNC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2225449"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2225449"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="788210908"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="788210908"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:13:30 -0800
Received: from [10.213.169.162] (kliang2-mobl1.ccr.corp.intel.com [10.213.169.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B304E580DA4;
	Tue, 30 Jan 2024 06:13:28 -0800 (PST)
Message-ID: <596f6329-1619-4fec-8fde-f97a3e3169b5@linux.intel.com>
Date: Tue, 30 Jan 2024 09:13:27 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel Sapphire Rapids uncore: umask too big
Content-Language: en-US
To: Michael Petlan <mpetlan@redhat.com>, irogers@google.com
Cc: vmolnaro@redhat.com, edward.baker@intel.com, perry.taylor@intel.com,
 samantha.alt@intel.com, weilin.wang@intel.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, linux-perf-users@vger.kernel.org
References: <alpine.LRH.2.20.2401300733310.11354@Diego>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <alpine.LRH.2.20.2401300733310.11354@Diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-30 3:11 a.m., Michael Petlan wrote:
> Hello Ian and others,
> 
> we have encountered some issues with uncore events on Sapphire Rapids. There are
> a couple types of problems. One of them is the following:
> 
>     # perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls 
>     event syntax error: '..0x35,umask=0x10c0008101/'
>                                       \___ Bad event or PMU
>     
>     Unable to find PMU or event on a PMU of 'uncore_cha_55'
>     
>     Initial error:
>     event syntax error: '..0x35,umask=0x10c0008101/'
>                                       \___ value too big for format, maximum is 4294967295
>     Run 'perf list' for a list of valid events
> 
> There is a 34bit umask that can handle it, namely umask_ext2, but it is not
> used for sapphire rapids:
> 
> uncore_snbep.c:5958:static struct attribute *spr_uncore_cha_formats_attr[] = {
> uncore_snbep.c-5959-    &format_attr_event.attr,
> uncore_snbep.c-5960-    &format_attr_umask_ext4.attr,
> uncore_snbep.c-5961-    &format_attr_tid_en2.attr,
> uncore_snbep.c-5962-    &format_attr_edge.attr,
> uncore_snbep.c-5963-    &format_attr_inv.attr,
> uncore_snbep.c-5964-    &format_attr_thresh8.attr,
> uncore_snbep.c-5965-    &format_attr_filter_tid5.attr,
> uncore_snbep.c-5966-    NULL,
> uncore_snbep.c-5967-};
> 
> (I see umask_ext4 there and means 32bit:
> uncore_snbep.c:479:DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
> )
> 
> What is wrong? The json files specifying umask=0x10c0008101 for the event,
> or the structure that should rather support umask_ext2 ?

The 8-15,32-55 is from the SPR uncore spec. But apparently, there is an
inconsistency between the event list and the spec. I will check
internally and send a fix.

> 
> There are a few more issues, I will update when analyzing them deeper.

Sure, please let me know when you find something.

Thanks,
Kan
> 
> Thanks.
> Michael
> 
> 
