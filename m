Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3331C01;
	Sun,  8 Sep 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827452; cv=none; b=UdUWPvuUFjlg/xUNrkVk6jIZ1GoatoRgl9BrWlr/WyFhXbCYS0x/e9p420sWbWWyuIkj2PCmdYRw3z9vwq8PwlerBkigPsHxSh3UvrpKcERyTNdveRqG84jI+xTNf77hEJ9gdvyNlRptzfuD8+76XQ5pR3xrjAE1Mcs9tHcrqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827452; c=relaxed/simple;
	bh=qQFmnoNk7VNN8/ZS193YeNoFNiaW3ZCntUmMI6q2f7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl453rE1BBxSpraU1XGRouhPA42AiXFrJty76EiaGfwqe9QIIC0fZ9wvyRxUlLwklBmFmWgRZ+DpHZEVBZGp+fwJSzzcu+FHU5ZagZagw2o8cBHMyFcuXl53XiIgwWRUebsjjWyX9oEfRNFmFSxn7+WLonN4C2ZNm4swVJarikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfR6AEmm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfR6AEmm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725827451; x=1757363451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qQFmnoNk7VNN8/ZS193YeNoFNiaW3ZCntUmMI6q2f7s=;
  b=FfR6AEmmeaOg8+v4KgB6FbyufiiGyn2pdwaAtZa7VjVRhmyBC8Y9RbiB
   4lQK/6ypaFuMeNlT4mBKl3flAjzKi4uqSo3WmEX9bXJnSK58SfpzuFfEl
   VICaEMn8jkMA7pyVUc7iWikRPcM+aCkjgQSaf82VJ9jAbIXbbL9Axu+iy
   cdavyiNMT/MskjVdVeCmpCWLI2xSsS3w7xIA2LzKb+24iUTskXEZ92kp2
   DhYV1XxHxaosRYbMJzpk/YMVrORmvNClLFaPzx6fw2Co9+2g/TYiBZ4fJ
   9n76SeJ84HrRivPiBEP1ONZAy8lMQuADALwdwH2qADdS7zK8TxzHf8wiV
   Q==;
X-CSE-ConnectionGUID: VMc38jzUSxWY+eXbhnrrdQ==
X-CSE-MsgGUID: GvXUpKcHTQyEtRdjsWXowg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24653474"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="24653474"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 13:30:50 -0700
X-CSE-ConnectionGUID: 8fmgPsSpTkWsV7YB0Khurw==
X-CSE-MsgGUID: dsstNfYsRpCzwcfx05B6vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="71424440"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 13:30:48 -0700
Received: from [10.212.20.3] (kliang2-mobl1.ccr.corp.intel.com [10.212.20.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E8B9220B5782;
	Sun,  8 Sep 2024 13:30:45 -0700 (PDT)
Message-ID: <eafb8f49-2396-4652-a74e-882b4066790e@linux.intel.com>
Date: Sun, 8 Sep 2024 16:30:44 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf mem: Fix missed p-core mem events on ADL and RPL
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905170737.4070743-1-kan.liang@linux.intel.com>
 <20240905170737.4070743-2-kan.liang@linux.intel.com> <ZtoHgMqNhnDdvAIi@x1>
 <1a339858-74a3-414a-9fc1-bef47c513728@linux.intel.com> <ZtsO-v3pUVezKBgE@x1>
 <8644996b-33d6-4eee-890c-f23a3c830b77@linux.intel.com> <ZttgvduaKsVn1r4p@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZttgvduaKsVn1r4p@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-06 4:06 p.m., Arnaldo Carvalho de Melo wrote:
> On Fri, Sep 06, 2024 at 12:08:52PM -0400, Liang, Kan wrote:
>> On 2024-09-06 10:17 a.m., Arnaldo Carvalho de Melo wrote:
>>> On Thu, Sep 05, 2024 at 03:47:03PM -0400, Liang, Kan wrote:
>>>> On 2024-09-05 3:33 p.m., Arnaldo Carvalho de Melo wrote:
>>>>> But can we reconstruct the events relationship (group, :S, etc) from
>>>>> what we have in the perf.data header?
> 
>>>> Do you mean show the group relation in the perf evlist?
> 
>>>> $perf mem record sleep 1
>>>> [ perf record: Woken up 1 times to write data ]
>>>> [ perf record: Captured and wrote 0.027 MB perf.data (10 samples) ]
> 
>>>> $perf evlist -g
>>>> cpu_atom/mem-loads,ldlat=30/P
>>>> cpu_atom/mem-stores/P
>>>> {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
>>>> cpu_core/mem-stores/P
>>>> dummy:u
> 
>>>> The -g option already did it, although the group modifier looks lost.
> 
>>> Right, I can reproduce that, but I wonder if we shouldn't make this '-g'
>>> option the default?
> 
>> I think the evlist means a list of events. Only outputting the events
>> makes sense to me.
>> With -g, the extra relationship information is provided.
> 
> At first 'perf evlist' showing just the events present in the perf.data
> file seems enough, and maybe it should continue like that.
> 
> It is just that this relationship is so critical that not showing it by
> default looks suboptimal :-\
> 
> Perhaps we should add some warning at the end mentioning the special
> relationships present and suggest using '-g' to see it?
> 

Agree, and we already did a similar hint for tracepoint events.

Here is the patch to add a hint for '-g'.
https://lore.kernel.org/lkml/20240908202847.176280-1-kan.liang@linux.intel.com/

Thanks,
Kan
