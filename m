Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44AB19995D;
	Wed,  9 Oct 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487642; cv=none; b=Anu+dnTZfup8HgGKWP5IZ302J0lXCqUtZEikEOv7vNJPSJ8r87UNhR1VDkW6SYDTl+X5ju0KSi2fBNmPX3MNC0ts2JuLpeVrRr64R6AsXqrjyzrZKUEIUKp81BmSCLa46V6e3dJDQ3bD8Z8uLBxps4+cODZJsweD4YEOY/08eMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487642; c=relaxed/simple;
	bh=8CTz5U7/VECzPYtbnlt8j1fISZM1Hcvu91JGyBIjdWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMys4qtpiVfHBd1rJcA25axRGhXkKaLmrKvpzu7MYGU/NZ3iMwxypgrmWOHReyPjeOl5K6S0+yyo1BpC5U2DBvc7s+qQHigRBYXKtvhs3VV3sF14wTGEmnEj7Y66pIGqe6p7GyqhHvnWIPW2yLtbx3CVf6uyLevY0d14fURKWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUkrJGmY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUkrJGmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487641; x=1760023641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8CTz5U7/VECzPYtbnlt8j1fISZM1Hcvu91JGyBIjdWI=;
  b=EUkrJGmYYEuFHyA7iZquXFftqxSHNa9TcYvw6QAfKoH/X4zI00M44/3e
   ZRu89oIhESJljeHrR9+H6tXLfEfPXiQnhyGQzdqhrRyULwDX9xrjkO30e
   IwOKCMnggEFPIGsPCZc0/zbKGIVIWTaD9Yn2PEv6PhuMoJWH9eBZeIMJG
   Sa1cth5gGDfrrQGA2msMkWilhWu2B2j2myJ1+KkVJi0X7oZADfy/z8JSu
   QcdQ8l81/WgMJMAL81mrL5gcVlyW36oCqiymtGSskYaugcNtk+1OAnSbZ
   WDLFi/3I3FGJkLttRISJyztp4+vycwjOIk/xyuet7EBlMa2fRzdD2I3HT
   Q==;
X-CSE-ConnectionGUID: JL9L0mZKQgKi5n//vIoEyQ==
X-CSE-MsgGUID: rJQLJvg7QFCHHPUSj+zuGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39157222"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="39157222"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:27:20 -0700
X-CSE-ConnectionGUID: 19tQyeMvTYWj9gFAtLE0Tg==
X-CSE-MsgGUID: t5dq7ntfToqNG7PqPiSmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="80272195"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:27:19 -0700
Received: from [10.212.60.176] (kliang2-mobl1.ccr.corp.intel.com [10.212.60.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0ED7220B5782;
	Wed,  9 Oct 2024 08:27:17 -0700 (PDT)
Message-ID: <ba80cbe4-877a-4b5f-a5d6-de16fc1d2d4d@linux.intel.com>
Date: Wed, 9 Oct 2024 11:27:16 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf callchain: Remove unused callchain_branch_counts
To: Namhyung Kim <namhyung@kernel.org>, linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
References: <20241006012204.373803-1-linux@treblig.org>
 <ZwYVCTsf8p3v22HQ@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZwYVCTsf8p3v22HQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-10-09 1:30 a.m., Namhyung Kim wrote:
> On Sun, Oct 06, 2024 at 02:22:04AM +0100, linux@treblig.org wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>
>> callchain_branch_counts() was added in 2016 by commit
>> 3dd029ef9401 ("perf report: Calculate and return the branch flag counting")
>> but unused.

It seems the original patchset was not well organized. This function is
actually used by the last patch of the series.
https://lore.kernel.org/lkml/1477876794-30749-7-git-send-email-yao.jin@linux.intel.com/

But for some reason, the last patch was not merged. I think Andi gave
the Acked-by for the whole series. It might be just accidentally missed.

I think the missed feature is still useful.
We will redo the test and re-post it.

Thanks,
Kan

>>
>> Remove it and it's helpers.
> 
> Kan, are you ok with this?
> 
> Thanks,
> Namhyung
> 
>>
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>> ---
>>  tools/perf/util/callchain.c | 71 -------------------------------------
>>  tools/perf/util/callchain.h |  4 ---
>>  2 files changed, 75 deletions(-)
>>
>> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
>> index 0c7564747a14..11435b72afbe 100644
>> --- a/tools/perf/util/callchain.c
>> +++ b/tools/perf/util/callchain.c
>> @@ -1266,77 +1266,6 @@ int callchain_node__fprintf_value(struct callchain_node *node,
>>  	return 0;
>>  }
>>  
>> -static void callchain_counts_value(struct callchain_node *node,
>> -				   u64 *branch_count, u64 *predicted_count,
>> -				   u64 *abort_count, u64 *cycles_count)
>> -{
>> -	struct callchain_list *clist;
>> -
>> -	list_for_each_entry(clist, &node->val, list) {
>> -		if (branch_count)
>> -			*branch_count += clist->branch_count;
>> -
>> -		if (predicted_count)
>> -			*predicted_count += clist->predicted_count;
>> -
>> -		if (abort_count)
>> -			*abort_count += clist->abort_count;
>> -
>> -		if (cycles_count)
>> -			*cycles_count += clist->cycles_count;
>> -	}
>> -}
>> -
>> -static int callchain_node_branch_counts_cumul(struct callchain_node *node,
>> -					      u64 *branch_count,
>> -					      u64 *predicted_count,
>> -					      u64 *abort_count,
>> -					      u64 *cycles_count)
>> -{
>> -	struct callchain_node *child;
>> -	struct rb_node *n;
>> -
>> -	n = rb_first(&node->rb_root_in);
>> -	while (n) {
>> -		child = rb_entry(n, struct callchain_node, rb_node_in);
>> -		n = rb_next(n);
>> -
>> -		callchain_node_branch_counts_cumul(child, branch_count,
>> -						   predicted_count,
>> -						   abort_count,
>> -						   cycles_count);
>> -
>> -		callchain_counts_value(child, branch_count,
>> -				       predicted_count, abort_count,
>> -				       cycles_count);
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -int callchain_branch_counts(struct callchain_root *root,
>> -			    u64 *branch_count, u64 *predicted_count,
>> -			    u64 *abort_count, u64 *cycles_count)
>> -{
>> -	if (branch_count)
>> -		*branch_count = 0;
>> -
>> -	if (predicted_count)
>> -		*predicted_count = 0;
>> -
>> -	if (abort_count)
>> -		*abort_count = 0;
>> -
>> -	if (cycles_count)
>> -		*cycles_count = 0;
>> -
>> -	return callchain_node_branch_counts_cumul(&root->node,
>> -						  branch_count,
>> -						  predicted_count,
>> -						  abort_count,
>> -						  cycles_count);
>> -}
>> -
>>  static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int bfsize)
>>  {
>>  	return scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
>> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
>> index 86ed9e4d04f9..d7741fa9e9de 100644
>> --- a/tools/perf/util/callchain.h
>> +++ b/tools/perf/util/callchain.h
>> @@ -298,10 +298,6 @@ void free_callchain(struct callchain_root *root);
>>  void decay_callchain(struct callchain_root *root);
>>  int callchain_node__make_parent_list(struct callchain_node *node);
>>  
>> -int callchain_branch_counts(struct callchain_root *root,
>> -			    u64 *branch_count, u64 *predicted_count,
>> -			    u64 *abort_count, u64 *cycles_count);
>> -
>>  void callchain_param_setup(u64 sample_type, const char *arch);
>>  
>>  bool callchain_cnode_matched(struct callchain_node *base_cnode,
>> -- 
>> 2.46.2
>>
> 
