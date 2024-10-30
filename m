Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27C1E9065
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293043; cv=none; b=VQyJyuB2gBXgpCZXON8WxTosGhVnuqsobPUaT2yN8H8ucBoczuz/a/cXWd+KnOQX419MOCK3Olr//Go7myP69Gy4NDh9bSvRM1/FlZEj3z2TxEyywpnypZt3WH4EJGsPooC04Yq0eNf4nvSowLtvnC7wwY/AoCnVCggS2MH9FRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293043; c=relaxed/simple;
	bh=zeB2oLDbaNyldY9RdvgRo10QtjrC6b97BJaO5OQ2CFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6w8qX13qWYCRlbqzd6+LIJ9W8wI9R67Q1cz5o/en0BlQbmqAofGVESHiP4nI6qfYcD7RwufK3mzayBfnlAvgjMKUu+my1key0FNFM8RcdhmMST6klbwg/HkH7KILzmSn4Hvso3gw+A33ijdq98adzacnsZ/nUbo9Qh20JGTjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcZbmtx0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcZbmtx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730293042; x=1761829042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zeB2oLDbaNyldY9RdvgRo10QtjrC6b97BJaO5OQ2CFg=;
  b=WcZbmtx0fvrveJF8s+uGRvz4vGjFKsLdpbtBTjwRQBF4IroQda5ToOB1
   of7eBGAuso6ReFsIGTBXdXuMgnTxEPQ3w6T1PPnaYYLX3fAswUdwpuj/4
   vnizcu+scQFv2JUaeEzy76pkUwTcT7CtaNgAjypioFcaLS9L7C2EqIrdy
   u7E5JbAXHEyXgR0sg7ytSHnlGkwxR4g8UIlWsPJKHTA4pWKPtUDPXKS0+
   K5ty11VmPovtiXqSEgIVr9YACJwnBYQxPaEdN7Eqqx/UmX7CrbBxPBWlS
   BfnKVbuvLGYy++Mr3S3pyjC7Kzzw801UxNXyr3LVbKZ0L5j59Fc8ZOcBG
   A==;
X-CSE-ConnectionGUID: miK07/VxQRWjH2h/WBd9XA==
X-CSE-MsgGUID: 7xwa0f8PRxW085hwy8AEug==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30140180"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30140180"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:57:22 -0700
X-CSE-ConnectionGUID: hwY0khyfSXm86aZxDHj7RA==
X-CSE-MsgGUID: BtED+aJCQN2yd0nVJ7AxBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83117677"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:57:21 -0700
Received: from [10.212.81.107] (plucero-mobl1.amr.corp.intel.com [10.212.81.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B622B20B5782;
	Wed, 30 Oct 2024 05:57:20 -0700 (PDT)
Message-ID: <70f80f3a-caa6-4c30-ada7-a10af12c79b8@linux.intel.com>
Date: Wed, 30 Oct 2024 08:57:19 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel SPR: perf-record doesn't support topdown events?
To: laksono <laksono@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
References: <CALwKgup1UhiKMHvEni_3gaWoC0BLu8kkT6R=7R=b-LkBx5_3ZA@mail.gmail.com>
 <ZyF3k__jUtRUAcWm@google.com>
 <CALwKgupNAgc_jEinqsYmH_n-u_JsSOrjmY9k-33VAVrVVL3M=w@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CALwKgupNAgc_jEinqsYmH_n-u_JsSOrjmY9k-33VAVrVVL3M=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-10-29 9:00 p.m., laksono wrote:
> Hi Namhyung
> 
> On Tue, Oct 29, 2024 at 7:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> I guess you need the leader sampling with 'S' modifier.
>>
>>   $ perf record -e '{slots,topdown-be-bound}:S' ...
>>
> Unfortunately, it doesn't work for me:

The issue should have been fixed by the below patch set.
https://lore.kernel.org/lkml/20240913084712.13861-1-dapeng1.mi@linux.intel.com/

You may have to use the latest perf-tools-next branch.

Thanks,
Kan
> 
> $ perf record -e '{slots,topdown-be-bound}:S'  ...
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (topdown-be-bound).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> Regards
> 
> Laksono
> 

