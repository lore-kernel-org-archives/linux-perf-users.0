Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B152CCB5;
	Fri, 16 Oct 2026 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109655; cv=none; b=ilt5nnmwHjVQeJUm5BiZ/ge3s9krUHrGiV8gUP27iaUyhUpVOqm3PhTFf+vbiaVYP4NeUOKU1Lx/0sKHv72lZkJjeayMxNyBxrD6nGqZYhHcYKJqrPiLK2U5U6IQTXykLJEJ/s2Ukh81RzNf0NyL7FBYCkeQqwDfEZ+VTakPeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109655; c=relaxed/simple;
	bh=U9Orm4nOHuyJymi4NI9f7YSIcR+1QTrHP8U/nZRzaw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DClZ34Y4FG1PLPbKC+wKTpMh7MO+IaP4GeI7Hd2JEPWCcjexF2721hn4gtdzptR5P8g2rdbDhkCyhQt7ctkbsRqujEjFe0sE9qTm+5hH2Ak6mw/fnCD9tE+4R2UTOWDf2YHxZoFi0l7DykMMIP9/4CdbXN1XcDdWFZDMi2c1+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9+CnYCj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9+CnYCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792109653; x=1823645653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U9Orm4nOHuyJymi4NI9f7YSIcR+1QTrHP8U/nZRzaw4=;
  b=U9+CnYCjb+8+O9QnppL3bDK5vc8l1WSPFoJ/m7Xw/NsVQ0bNbUiJ6SyG
   7RUDJ0sG30G9YPHkZxEpV7hwRe5+lMdOOXXb2wQMmyw1oAalxW3MWl+2d
   mFcZ4J9V9ycBnnGbquCA64eIySKY/8gSG8TNNlie88MqLw2Gy0DeLRVbt
   YT1esx0OdAZSwTYAhp32EXYXoQc3y6p+oLF4kPlM3QI5diWsb8en3vhfL
   sHrflGhRWdK1P3j0sJiEEECJ2MUU1mGIO/AxiUq6m/YoKjHDKA7LyLcrm
   FI1GEpWaB4YKQDHPMtTn+UYFa83dzLvcp7La68NoRvPe2xK6HHViaHq0P
   A==;
X-CSE-ConnectionGUID: 2xJ86AB0R1atHwHeUqKpqw==
X-CSE-MsgGUID: FkBBMR7rTMmjSAUMXl/lxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="790278"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="790278"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 17:14:12 -0700
X-CSE-ConnectionGUID: dwoc/oV7RjuCbSYGJPTTQA==
X-CSE-MsgGUID: siMVLyqlS8acEDzzKq3Mow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1751809"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 17:14:07 -0700
Message-ID: <21f5386f-52c1-4687-a35c-54fb3783c12e@linux.intel.com>
Date: Fri, 16 Oct 2026 08:14:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf/x86/amd/lbr: Limit branch snapshots to valid
 entries
To: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <cover.1792064123.git.sandipan.das@amd.com>
 <21b52422864cea9f768ddee6be48102954cef984.1792064123.git.sandipan.das@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <21b52422864cea9f768ddee6be48102954cef984.1792064123.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 10/15/2026 7:46 PM, Sandipan Das wrote:
> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/amd/core.c | 2 +-
>  arch/x86/events/amd/lbr.c  | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce566..bf631f60757c 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>  	cpuc = this_cpu_ptr(&cpu_hw_events);
>  
>  	amd_pmu_lbr_read();
> -	cnt = min(cnt, x86_pmu.lbr_nr);
> +	cnt = min(cnt, cpuc->lbr_stack.nr);
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>  
>  	amd_pmu_v2_enable_all(0);
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index 1e1b2f08cb51..a00d3850c4a8 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
>  	struct branch_entry entry;
>  	int out = 0, idx, i;
>  
> -	if (!cpuc->lbr_users)
> +	if (!cpuc->lbr_users) {
> +		cpuc->lbr_stack.nr = 0;
>  		return;
> +	}
>  
>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>  		entry.from.full	= amd_pmu_lbr_get_from(i);
