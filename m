Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DB301027;
	Mon,  8 Dec 2025 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765171026; cv=none; b=eY+s7LH2PRZzfTG3cOKYOEQLmaToDEMsy0h52R4xUTM90CCF7BPvp0Bul7jRA3MMOIFq98NeB80zKVWQ/oNPDLwJC5jkX/owPM6WMN6TfKv+8+qsmj6k1fAgOs6OJ0mB58vnVlzGr0GSgEvyY0Jp4YYHz3Mo9vNShnfJj6o67Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765171026; c=relaxed/simple;
	bh=BZIsbDGOFIus+jpCUAw6WchM6meY697FmknZE8eMhmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGjHeNRnYKtNvnnwgf9ILO393IY5KJ/FeY+9i+YEm4tt1OSEPmgTJOSGC9hP5xNUx/ed271MURP09wfjRBVIgu2+6x96wG7NhvgEIjNNqsfO3LVHsBLnM8YkqYwoeMnuq1H55pPPtxF2ylPeHxln8VlJvL/EonhNLqAOaNb/SMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exY8YItP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exY8YItP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765171022; x=1796707022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BZIsbDGOFIus+jpCUAw6WchM6meY697FmknZE8eMhmE=;
  b=exY8YItPvKYAQL5oyeN4E7+wBulZryP9BptyD8b4ahSY9TcUydysQX7Q
   +4DktcKlJtDHz2lhrVa6Vn+OT5N6Va34Osear54yln+J4/2miDWr9+a+i
   2FamNUCDhMjMENM3aPZZMzZMFtRgqOUU6AJ4gG6Hlh2bOB/QiBL/NZpW1
   QqIeLZlgGOFuDeonFlWsp7SwZX+pLukPnC1ioMpp60eaHAzLRsTShmENv
   9dU1OPNXD9A3/dbuqtmAdRGeeX+mpIjHHZ4Iy8vGwtMpZbQRzRv73Q4nw
   jpzAZcJrWf0Kh33dqAwhs3TRgqq7Wu18PxhcJOcigUD6A5kk5+kg5gGyt
   g==;
X-CSE-ConnectionGUID: 0ohBb6/qR+qYrBpC4QJdog==
X-CSE-MsgGUID: gffK5bKvQJ+Kwb3svd/BDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="77430694"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="77430694"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 21:17:01 -0800
X-CSE-ConnectionGUID: /RsT9KgfTCq02FYmc/EBwA==
X-CSE-MsgGUID: F0wKQYwtRteAFiahNyzZgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="233214943"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 21:16:57 -0800
Message-ID: <b269e539-3256-4ff0-b2ab-0cd558ac841f@linux.intel.com>
Date: Mon, 8 Dec 2025 13:16:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
 <20251118110309.GP3245006@noisy.programming.kicks-ass.net>
 <20251118110417.GI4068168@noisy.programming.kicks-ass.net>
 <baf8aceb-5caa-4c3b-80f0-43a4a1449a23@linux.intel.com>
 <20251118112406.GH4067720@noisy.programming.kicks-ass.net>
 <CAP-5=fWg9gNW5OZV=JD7dcpf-FBtKXLCR_0Caz8a=SxbvNQ-HQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWg9gNW5OZV=JD7dcpf-FBtKXLCR_0Caz8a=SxbvNQ-HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/6/2025 7:44 AM, Ian Rogers wrote:
> On Tue, Nov 18, 2025 at 3:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Tue, Nov 18, 2025 at 07:22:24PM +0800, Mi, Dapeng wrote:
>>> On 11/18/2025 7:04 PM, Peter Zijlstra wrote:
>>>> On Tue, Nov 18, 2025 at 12:03:09PM +0100, Peter Zijlstra wrote:
>>>>> Also, the few comments we do have already note that ->del() must do
>>>>> ->stop(EF_UPDATE).
> Hi Peter,
>
> I was trying to do a quick sanity check that other callers of stop
> were passing in EF_UPDATE. I wondered if the case of
> perf_event_throttle_group with leader sampling has an issue? The
> throttle should only happen on an event or group leader that is in
> sampling mode, but the group members could be non-sampling with leader
> sampling. Sorry for the noise if I'm wrong on this. Fwiw, the other
> uses either pass in EF_UPDATE or I think for  __perf_event_aux_pause
> and  __perf_event_overflow the problem isn't relevant.

Base on the logic, it looks we need to add the flag EF_UPDATE in
perf_event_throttle_group(), but need Peter's confirm. 


>
> Thanks,
> Ian
>
