Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B271494CC;
	Wed, 11 Dec 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934285; cv=none; b=oHqnLUA9riWt5bOVCA/1JEBzJIKQjiyS92nS84XS6DrTFGMNzUG3Z2QQcgMP9JlMkl88JFzRBkvNMwTCBv9vry2DYKQOYT9Qcry5ZQi2BH9oBk+7xASqruJXLQ2uZcJ1RuEKHcLTriyCb5Ek/U8+MyaOIZRxDpe66avpnFZJ/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934285; c=relaxed/simple;
	bh=z4CgnemnsUEStDMuYMMTagDUhDj1+WKrtd9xOzbBDdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBDRQ+txpW7Xx9sh2GN7KtEL8VtvDv3Ju8HFsfknnkGcQ3rVAW0TRW6iTnqfxM3c3qGjmXMrgDTtXnge0gLCt885EqTrYFVx3/kevO6saLBLv9wZ1RP7TbAwPv3meOam7qTJVpS90JCPNLhzov0B9vGnOi+V0kTe/mCVVvCjmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBHhDZGt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBHhDZGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733934283; x=1765470283;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z4CgnemnsUEStDMuYMMTagDUhDj1+WKrtd9xOzbBDdI=;
  b=jBHhDZGtnDeNjH+77DwaknSAqXuQT4obstoK7m3il6b2JaGHPyA8EPNW
   nhO3VwdangNQ2qhdHcmfdYnPQX9zLx0JM/pfSfxXwVRK+7WQswqSXg+ti
   LG/k+wgHiEw63eB0blh4rfjy73guL/NH++NQmoxys4MW5W8107pWzzLsR
   qMh76lHQhssl8sDHR7gchrH+LGcfGi9vsDLq0EhdQ0rZJkAcw4Np7PKB1
   y1onhXAmDR9MA60bTNMyQhL9poVEoarKMa/Z1QbeXL9Dx+tqF1+lc9hmz
   8vaWakXy4aEFvaPbSEzdv35WzKPMjgWcLvh8fX0MAho4gAOakRExihz1a
   g==;
X-CSE-ConnectionGUID: 6TR/zA0HSBi2TUL7g3/egg==
X-CSE-MsgGUID: uA9KpfFwQvORWmw1lSMgAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="37156127"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="37156127"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:24:42 -0800
X-CSE-ConnectionGUID: ni/YP/OHQJiHQNXl2GVofg==
X-CSE-MsgGUID: AFE640wnRDOX7BWdQs6U2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="95721171"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:24:43 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3CF2A20B5703;
	Wed, 11 Dec 2024 08:24:40 -0800 (PST)
Message-ID: <2ae362c8-b8f4-453e-9c92-a25ad989ffe4@linux.intel.com>
Date: Wed, 11 Dec 2024 11:24:38 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/22] Intel vendor events and TMA 5.01 metrics
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
References: <20241209222800.296000-1-irogers@google.com>
 <CAP-5=fWr9R74-NbKbW96otG6KitQYaQng4D40Bv4z9ov9yvNJA@mail.gmail.com>
 <Z1iQhL4WXFL4Wf27@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z1iQhL4WXFL4Wf27@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-12-10 2:03 p.m., Arnaldo Carvalho de Melo wrote:
> On Mon, Dec 09, 2024 at 04:44:27PM -0800, Ian Rogers wrote:
>> On Mon, Dec 9, 2024 at 2:28 PM Ian Rogers <irogers@google.com> wrote:
>>>
>>> Update the Intel vendor events to the latest.
>>> Update the metrics to TMA 5.01.
>>> Add Arrowlake support.
>>> Add metrics for LNL and GNR.
>>> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
>>>
>>> The perf json was generated using the script:
>>> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
>>> with the generated json being in:
>>> https://github.com/intel/perfmon/tree/main/scripts/perf
>>>
>>> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
>>> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
>>> Weilin Wang <weilin.wang@intel.com> for helping get this patch series
>>> together.
>>
>> I should have also said, this series requires:
>> https://lore.kernel.org/all/20241113165558.628856-1-irogers@google.com/
> 
> Applying that one now to perf-tools-next,
> 
> Kan, can I have your Acked-by or Reviewed-by?
> 

Thanks Ian for the series!

Sure.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

