Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3C40853
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831161; cv=none; b=uJfWyIVLUkGaSXzXkyy3E10oqdGZj6KeAPhSlz1N79VtwKrPwHs9o5Sb0hTWyiOH+95S5CHfIrQXJ0yCzhHvQDan8lFXBFxk3xGIkXmEA3LxvjQODUjws+2J+RDbbtquUmOXP6OybLz7wXCxOxiBiSeaNUFRJ4d0Ls+SjbQwVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831161; c=relaxed/simple;
	bh=oIhKGaO/Awc12nkmiRhvghUcufTgR5/mQRmmnUGEXqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyT3KJodRFFMzdEHO4KIqe+uwQbKSh4PABsUpNHP9CFgZFLAJlasCQ4TT+pQiSjqFWeWAExLb7rNajVUB0qKn0QLzmDUZLolzXy36WZEKtikjTwXMusoWP0S4zxWsAsF+RY9yNzf3o7FphzS6pkDmDVOmjt8ujzEDyb9NM7SPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCdxEbRz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCdxEbRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710831159; x=1742367159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oIhKGaO/Awc12nkmiRhvghUcufTgR5/mQRmmnUGEXqI=;
  b=eCdxEbRzQKUdzBcgekesVwbJpXfEilby/zB15UJRIHvaNqCAPdufFQnU
   Ahq0museWAGEV25ZF4U2vbMtHNOyb0GmAkUfNBgLnj/vicW0Z/MNsQ7IA
   Wfj4RpYMr6iIfqf9lLYYlejKkr0i32cVteShDcVo/cSwSt1Yy6lG2oVPi
   F06pGp4MF8873tHnTEK8Mrd8mdENpNcxURZpMzHInrORNTIt5v1PHnu3f
   4A9ZxKXatyL9TSrw2aS3isUIOvnwoamZdlkCyySGrnw7CjDBMg3LuaUNH
   rBHb7ECehAXG7w8EMCCdbju449AO4KwDekKUnvbBOZdf1cA6AAIQdTCUM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5545741"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5545741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18339747"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.47.203])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:52:37 -0700
Message-ID: <fcdb6a82-30bf-4da5-a898-bba3c0bbc592@intel.com>
Date: Tue, 19 Mar 2024 08:52:33 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf, script, capstone: Add support for -F
 +brstackdisasm
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, changbin.du@huawei.com
References: <20240308170611.719794-1-ak@linux.intel.com>
 <20240308170611.719794-2-ak@linux.intel.com>
 <bd71b8f5-bf56-4af5-bd55-deb12cc01415@intel.com> <Zfi6vkODkhWQpHJJ@tassilo>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zfi6vkODkhWQpHJJ@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/24 00:06, Andi Kleen wrote:
>> Better to factor out a function that does not depend on "sample"
>> e.g. see fprintf_insn_asm() below.
> 
> this doesn't work because it completely ignores the need of the
> cs_dump_insn caller for the path that i actually need for my feature,
> which requires to return a string.  I didn't apply it.

I would probably change the call sites because they already have a
file descriptor, but output to memory is doable:


const char *cs_dump_insn(struct perf_insn *x, uint64_t ip, u8 *inbuf, int inlen, int *lenp)
{
	FILE *fp = fmemopen(x->out, sizeof(x->out), "w+");
	const char *ret = NULL;
	ssize_t printed;

	if (!fp)
		return NULL;

	printed = fprintf_insn_asm(x->machine, x->thread, x->cpumode, x->is64bit,
				   (uint8_t *)inbuf, inlen, ip, lenp, fp);
	if (printed < 0 || fflush(fp))
		goto out_close;

	ret = x->out;
out_close:
	fclose(fp);
	return ret;
}


