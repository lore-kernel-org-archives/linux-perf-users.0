Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81941BD014;
	Thu,  2 Jan 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844526; cv=none; b=J4/pQNzs34EzCnGABHihEw9Eof1c6Nwc2L+UUcFJ46aShCKVYahUbgeb3GjfAJm1PzaUxwLknePaGFi5C1mZLx2si/oM41rtP4PYMxy/KoGs3uJM6AgH/UrF7m4ldrBKJErZ9hZycVAVeHUBdSAtD56miIPBQoLOCkgzD6/Y+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844526; c=relaxed/simple;
	bh=0DFyyqJ0oUeTcUxy0ur5WUlGs/nmwzIJshSBXB1Igs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=es6pmpVNL7kuzq74RfS5JFMs/P+s+QR4nqKKj4YhC7eg8WE8U0TW/Ysn71PIl91Bc8fXd0s/Em5szXcHEn0p/wQkNKUjLsKuq2MD4mndK3Eq2TMlhqJgBM1ZiLQokLPA0eO92So0Tb8kBNFBRddN8oRPNPmod3U2Uz+xketocwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuSqahwr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuSqahwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735844524; x=1767380524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0DFyyqJ0oUeTcUxy0ur5WUlGs/nmwzIJshSBXB1Igs0=;
  b=fuSqahwrVrb9v8RL7Y0bDD8/pc8Jvtfb7vew/6OLPVQWMH4QI5gsSCMm
   WWP9ykFC3tdvtKFVphbDN4ffwo11ec70ttDOa0YRnxvZ986CfIM0mXWLK
   nngPJU3vy06oBIWmWdqYMlVFd8ImUe99JuflmXw8HTFkPaI5PmjhzawwR
   w9x5YkblXerZPB5eVtho+z9AjE7bDnA8itVhiVEkeSADbvsK25MmHEZwJ
   /spyDn7EDbTkjyXUu/jhBobuZZRBrtiOsNKVdfFaSh+NQ1ZbK4Vz20FU6
   cR3xE2T+TKJ7PsRAF5e45HEDbPTzWgLOFny2WH6X2NHL1aJCSylWXkmKB
   A==;
X-CSE-ConnectionGUID: KN/4KlXDT7K1yD8o5Ro2BA==
X-CSE-MsgGUID: wWwufM5/QbOSfmdCijMNlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="46765445"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="46765445"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 11:02:02 -0800
X-CSE-ConnectionGUID: 4IVE0nKBQk2JqhdFxrNhiA==
X-CSE-MsgGUID: F7MIDnpoQbC5Vrurh1K0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106619996"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 11:02:03 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id AD7B220B5714;
	Thu,  2 Jan 2025 11:02:01 -0800 (PST)
Message-ID: <7e5376f1-ee87-458b-b55e-759125d251a2@linux.intel.com>
Date: Thu, 2 Jan 2025 14:02:00 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the lack of ch_mask format for
 SPR
To: Jing Zhang <renyu.zj@linux.alibaba.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1735542672-113067-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <1735542672-113067-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-30 2:11 a.m., Jing Zhang wrote:
> perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL event
> because of lack of ch_mask format in drivers, and perf test "104: perf
> all PMU test (exclusive)" failed.
> 
> $perf stat -e perf stat -e UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
> sleep 1
> 
> Initial error:
> event syntax error: 'UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL'
>                                 \___ unknown term 'ch_mask' for pmu 'uncore_cha_0'
> 
> 104: perf all PMU test (exclusive)                                   : FAILED!
> 
> Add ch_mask format for SPR to fix it.
> 

I don't think there is a ch_mask. It should be extended umask.
The issue of the CHA extended umask should has been fixed by
https://lore.kernel.org/lkml/172052531679.2215.16140288595428337453.tip-bot2@tip-bot2/

Thanks,
Kan
> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ca98744..e537623 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -5967,6 +5967,7 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
>  	&format_attr_inv.attr,
>  	&format_attr_thresh8.attr,
>  	&format_attr_filter_tid5.attr,
> +	&format_attr_ch_mask.attr,
>  	NULL,
>  };
>  static const struct attribute_group spr_uncore_chabox_format_group = {

