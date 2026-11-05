Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857383;
	b=Hll0CDpapZghgo/bobTPdNu3CDa+ClQwrn53k28A4yyPtN7LXLA4IvLuPYgnTq3CO/ei
	 8wDeAI8o7bzMIQGUHyIb2kfkZk/Vu/XoauDcHUzaHE16uUodItS0z8DBxtwNTRNkTSy24
	 XwbTkCVQreJ/RP5zymrS+9IE/CuCpntE66QzbRc+2p3ycWtvidMXkdX0wvXW064b72FKw
	 Na+aIuYs9NJoKKiwFRz1E+XYI/oquBZ4VFBT7zwv/YZ033rb+t6iusOFGjSiQnwqfL6O+
	 ud+li/tSVfkpz/uA6Vg33MwM5Ei6yKQyeAQ2VF+K3BW6iP+ZnlMNW056uiLv9eYws1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857383;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=P+oaCVoLwHJql9Mms6GBNjOvUoQxuDSwfa0Ij1vSsec=;
	b=S+U3OfuaBLLgDAqJwLUIJme5oZ2DojeAMMOsLmLT8feClixA63pwOsKchcytiKNof7oI
	 xLrz5Rbh61A7kW5IpwLwxm45Ii4Xtz52+rZkmo/5jT2OcZjLdcvTaFFFlGVwbZodV9qvJ
	 ZlPUvhsv/1T2lXJeLtXnlRq8vsR10uu5yR+oT17Aib7ylX42l+jcmYhimm9pq4Z3sY/Nf
	 MUMe6ivh82LzGmdxWl7WgJfdtcbJChibiSqbfROalTXcdJpTJAgEXOzvvfaayVYB+GcXK
	 6uxmf3pOPZS7/ZOO5PQ8QrarAiyLWbzyqY39JNPRncA5KSuLybeNQmwhN0lJdeLTQ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Q/G3jz64";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A60606A31B;
	Thu,  5 Nov 2026 05:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q/G3jz64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793857384; x=1825393384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4rPYTCBg8LGMA/ZSoac2gxpO4hjqjcqf+/BBdUzBiZc=;
  b=Q/G3jz64z8sdlP8DxjVg8SqCVCklemRzJjQaVxl0rhdSjEyyPCfllDZP
   eGZhmxacEQ+dzB2opkPz4vgKgnf1JLobj4KNO3KaYqThTP3Q78DVccvAR
   YnHvUBdj4G0bmR7beu/OBosoy2SFurS5tLUOuwwcQR/LMaOhgLq64/hZP
   Ln7ebSyKKPTzONn5ErlipQqeMs6iVXRXWu0li8DKr1js1wPRjLMsm3B6e
   Ox1LLWFuKpOC7ewMxF7fvSq9N10RD48dsNjUeA/4WxDxlAjnsy/TeSTSJ
   lUDBok7XeDt2U+egn/yMsZ3dXW/lNCgv7DOxAXq9Tlw+iaTQEhXxYiXvR
   w==;
X-CSE-ConnectionGUID: r+ME07wnTimfiFRCOXqjQA==
X-CSE-MsgGUID: /2Glj3dBQQm4xp0/kF8scg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2668014"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2668014"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 21:43:03 -0800
X-CSE-ConnectionGUID: es2nfcVLQ4yt3XSi/+j0gw==
X-CSE-MsgGUID: KdcY7OM3TOOi6gnBLaSxtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7041409"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 21:42:59 -0800
Message-ID: <7b27e9e5-280a-4a79-9419-496a583133a5@linux.intel.com>
Date: Thu, 5 Nov 2026 13:42:57 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf jevents: Don't encode MSRs with no value
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Edward Baker <edward.baker@intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>,
 Perry Taylor <perry.taylor@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel test robot <yi1.lai@intel.com>
References: <20261105044841.102295-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261105044841.102295-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 11/5/2026 12:48 PM, Ian Rogers wrote:
> Fixes the events mem_trans_retired.load_latency (EMR) and
> mem_inst_retired.latency_above_threshold_0 (NHM, WSM) that were having
> their ldlat= value encoded as python's None.
>
> Fixes: ffc606ada3d7 ("perf jevents: Add python converter script")
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202611050801.67bb4af4-lkp@intel.com
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 080e04b51b8c..e083f7495e67 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -396,7 +396,7 @@ class JsonEvent:
>          event += f',{value}{canonicalize_value(jd[key])}'
>      if filter:
>        event += f',{filter}'
> -    if msr:
> +    if msr and msrval:
>        event += f',{msr}{msrval}'
>      if self.desc and extra_desc:
>        self.desc += extra_desc
