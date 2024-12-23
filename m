Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD518A6B5;
	Mon, 23 Dec 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734944682; cv=none; b=TFY+74F45NMqWjdls9mImq+W9yi36MlBhFRWvkFHsiW9Wkh/FFgcRxbG5xipFgtV6YCMFCWpByZ9LyCNTkY5iLJMVgaLuvbXfagXEQnvksmLfuAgJ+BEiEavoQXhCHD3WC3bNmRM0MRVRQo4Vitn7g/LwHCr/MnwXB6og3sHBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734944682; c=relaxed/simple;
	bh=qDbsIV88b/IbUTi8Tebj4V3sLqa8RIcuToSG7703uus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GypUOqjUyGjVWI0td5rKz4zfIVaiiB1BaxC6ILqFSs8rNSL4BoXnNJkNn0C4ypuyaPbrjKz6wtSzZIFgbxBJWzYvgk++zU6YmFaZnEqphvcFafzV/ST5m+dbGvZtkRNMu/LBM4H50T75Ye1zhSB6vlhum6x+X2iq6MpsqST5seE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F94eL4UX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F94eL4UX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734944680; x=1766480680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qDbsIV88b/IbUTi8Tebj4V3sLqa8RIcuToSG7703uus=;
  b=F94eL4UXYa4l2U5qjLMx5xBQGMF3hyUYmmaK9hs2XGcP8QOxgW04rXqp
   I8e+QNc5LFeX0ETz5jSWn3HJDLqc2R4ZkdY42Hnlxx1kn5GEyu8wWEffJ
   38pFckieM//7cWTsHX+6RAsdxSjm4MrchDOaxlGe8Uiva4TBCETQoMmdy
   0DNtbMttQSGcY5ymYj/jSrRI4gpPYG4niaPhGuqEGc4R0vwix3yzRkoY1
   Fs24ihddPSHKisRhK6kh5TfpPuNsZVAS2MJhLcaPAPiU40J98EHNV2UPc
   r5sy943F6FlmY+gG40C6cpFI5OZKIKrZ6p87DrzLVOnIMES/3MHG+tPLp
   Q==;
X-CSE-ConnectionGUID: S6wbN0GUS4WiviscWGSB4A==
X-CSE-MsgGUID: yQtA3vttR8qXyQ3SeK/BHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="46097651"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="46097651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 01:04:40 -0800
X-CSE-ConnectionGUID: /ky/PTxrSh283ciuKWu1jw==
X-CSE-MsgGUID: fj79NWw/TwOVifKAiyWCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103768650"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 01:04:36 -0800
Message-ID: <8a89ba95-22cb-4e69-a776-3c927e80f5df@linux.intel.com>
Date: Mon, 23 Dec 2024 17:04:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Make leader sampling test work without branch
 event
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Veronika Molnarova <vmolnaro@redhat.com>, linux-kernel@vger.kernel.org
References: <20241115161600.228994-1-james.clark@linaro.org>
 <CAP-5=fUq1JLCVLQerQbK+itNg2RZaP9zCo9RUTgKoGqTQi3yYQ@mail.gmail.com>
 <ZzjyVgnEUOYknN1k@x1>
 <CAP-5=fUDnBii8T2hH3o+J=DXMe7xxHXP7Kno5fz4OjBestObwg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUDnBii8T2hH3o+J=DXMe7xxHXP7Kno5fz4OjBestObwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/21/2024 3:08 PM, Ian Rogers wrote:
> On Sat, Nov 16, 2024 at 11:28 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>> On Fri, Nov 15, 2024 at 10:54:43AM -0800, Ian Rogers wrote:
>>> On Fri, Nov 15, 2024 at 8:16 AM James Clark <james.clark@linaro.org> wrote:
>>>> Arm a57 only has speculative branch events so this test fails there. The
>>>> test doesn't depend on branch instructions so change it to instructions
>>>> which is pretty much guaranteed to be everywhere. The
>>>> test_branch_counter() test above already tests for the existence of the
>>>> branches event and skips if its not present.
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Thanks, applied to perf-tools-next,
> Rebasing on perf-tools-next I see this failing on my Intel Tigerlake
> laptop. An example script output for:
> ```
>  perf record -o "${perfdata}" -e "{instructions,instructions}:Su"
> ```
> is:
> ```
>             perf  352917 49604.160314:          3 instructions:
> 7f155caca323 [unknown]
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.160314:          3 instructions:
> 7f155caca323 [unknown]
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.160317:         18 instructions:
> 7f155cacaf3d _dl_start+0x3d
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.160317:         18 instructions:
> 7f155cacaf3d _dl_start+0x3d
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.160319:          3 instructions:
> 7f155cacaf44 _dl_start+0x44
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.160319:          3 instructions:
> 7f155cacaf44 _dl_start+0x44
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.161099:        120 instructions:
> ffffffff8ce00080 [unknown] ([unknown])
>             perf  352917 49604.161099:     181013 instructions:
> ffffffff8ce00080 [unknown] ([unknown])
>             perf  352917 49604.161115:       8811 instructions:
> 7f155cad22d0 strcmp+0x8b0
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.161115:       8811 instructions:
> 7f155cad22d0 strcmp+0x8b0
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.161130:      10483 instructions:
> 7f155caba508 _dl_new_object+0x198
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.161130:      10483 instructions:
> 7f155caba508 _dl_new_object+0x198
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.165156:     177355 instructions:
> 7f155cab90a4 _dl_lookup_symbol_x+0x44
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>             perf  352917 49604.165156:   13313598 instructions:
> 7f155cab90a4 _dl_lookup_symbol_x+0x44
> (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> ...
> ```
>
> Dapeng/Kan, any thoughts why the counts don't match for instructions
> but did for branches?


That looks strange,  what's your kernel version and perf-tool version? I
just tried the latest perf-tools-next branch, but I don't see this issue.



>
> Thanks,
> Ian
