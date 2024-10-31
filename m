Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11C18453F;
	Thu, 31 Oct 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366018; cv=none; b=YsZOOSAkp9LQJ/NjQRPS8u9bzbTUokOVOUbtBqBUDx3st+dkE/YS29X7l2tkSMmTelHZ4RBkq8CWYZvDbZQ8+j+Xy+OlTwNYXro4XjXxIjanV+M0LRCSYHvWO2s7iq9ju+1AN4wthTTgfWeN4MqerZkIKTz6+mighk4WZbuCfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366018; c=relaxed/simple;
	bh=RleJ9bkyyK1txBNGu05KPSL7U4P4vwzC+UqQeQmLP4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YzSs5zaSC4A7P8/EmmjESrjUfEbWhAa1zJ9mc/aJ+PgQYnGdhjmcv48qNk3BHfQksI+B5ALYP+o23sNzySVHTMdFZiUvC0UxzHzqsSONQTKqz7/i9hkNEc5+NKNYS+vNPRn7bxdbKcgR/tiY50A/v4IZcO2Kzj0N8z0qPmF2Hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAziTByn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAziTByn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730366017; x=1761902017;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=RleJ9bkyyK1txBNGu05KPSL7U4P4vwzC+UqQeQmLP4g=;
  b=hAziTByn/Fe8jZa48ZXmnvDvBsG4njJMcdFZO1wDeIDoD1L6B3PLlno/
   w7U9xCYZhaDsK0O15W4ktT3gMt2A5kp6gmY2fzpkV2VtQdNy0q+TPGlpu
   TswBE8xxnoBDw5GHJiEITkqGwWMyJr9b4MKI7hhFdB8NdaA6YCRt0zvHa
   4JkixDDgPux6UVYHeu9IQ1i4t4wEciovEgpdtBoyc3tWA/iRLBQTgJuW7
   x/syDJ/2pws1mdR0vuRH8TWP/8oS2BTmilOXxQ6e/nVn2O+lBBpwkWbDA
   WxmIdzc8kPsTXeubCkKx1+RljQfJaDbhO4UlpeT+O4v4ZgivPGjOJ/BOk
   Q==;
X-CSE-ConnectionGUID: mcxROTtcQ++Bz+KU/oajLw==
X-CSE-MsgGUID: UUAwdn60QN2UGvezt4dEeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30310885"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30310885"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:13:36 -0700
X-CSE-ConnectionGUID: tEBJj+bWSLOpZdD9L9pVAw==
X-CSE-MsgGUID: IZe097ktT1ao7GHvKSRp7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82485756"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:13:28 -0700
Message-ID: <fde6078a-8f74-4858-acc9-950ca9bbcfcc@intel.com>
Date: Thu, 31 Oct 2024 11:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/21] perf intel-pt: Remove stale build comment
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova
 <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-13-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241031014252.753588-13-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/24 03:42, Ian Rogers wrote:
> Commit 00a263902ac3 ("perf intel-pt: Use shared x86 insn decoder")
> removed the use of diff, so remove stale busybox comment.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/intel-pt-decoder/Build | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
> index f99d150059b9..5b8f0149167d 100644
> --- a/tools/perf/util/intel-pt-decoder/Build
> +++ b/tools/perf/util/intel-pt-decoder/Build
> @@ -7,8 +7,6 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
>  	$(call rule_mkdir)
>  	@$(call echo-cmd,gen)$(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@ || rm -f $@
>  
> -# Busybox's diff doesn't have -I, avoid warning in the case
> -
>  ifeq ($(SRCARCH),x86)
>    perf-util-y += inat.o insn.o
>  else

