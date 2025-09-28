Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061729BDAE;
	Sun, 28 Sep 2025 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041915; cv=none; b=ShYDTmszjCjQrIs8zixldx9wlC+8bR0uH1LkxY+xv/Ni14yWoQKhUinagAeFlHCGSk5OB0Nukm2mvdjR8B/fBio6zaqIj/L258JzzQ8Zr8/hG9GbP3cmPMPjrzJ3xM2j5G0f3TuDm1ZoYshk53YTiIIJktrgK/kWQrypYOVZ6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041915; c=relaxed/simple;
	bh=FZBL59QMC7CrqsUN51/P7EJkVl3tUlh9DAnS07GcBRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skHR8EOn6qw0LkBnUNwkQk1ZfOhXOpe2TeQZ6Fy+MFGSQS3KhGpiIKTHrVRdJeU/yhYImo9nEbtE7eYt22UHCl6zOdzz/FpeIl+VFVrBRN4qOBkJPuWcZUSVrQ73DkfmC7UOjJUYxBaRpsUfJ0Rqo2VCOMLgxnLGjdOGagvjvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxKC92HP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxKC92HP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759041914; x=1790577914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FZBL59QMC7CrqsUN51/P7EJkVl3tUlh9DAnS07GcBRY=;
  b=JxKC92HP0dsQ4tdPH647ChDvg7VMbqSgWONrSp3UXBLOEAW/3H3nrhIV
   i59HEFy620XOSFAPYyKj2MuQ+M/RagOKUV9jz2jZK9/nz6drX3Qc00q5l
   +Ng0h84HF+UVHQ3yIjvR+PsOSJezBIfOFSssKDxyOfU2ds1tSAJTfYtiu
   sF+BcAjr/U37CfFGHtuhqMGYtQ3X75wh9VL7kDTuQ0CAaGOmsFgtyoXpJ
   D3soF0UtpUtpmY4gCFGuaTtjDopWBB7nxpSqCA348gsoPHP8JwQ7lpYVL
   bIYvUJxL24nGjjg7D3jA8rIucCqqAUPAadbpukfCY3r5S6Vu2ODKN0Cod
   w==;
X-CSE-ConnectionGUID: RAPef6VORN2U4TsGgX+0Bw==
X-CSE-MsgGUID: nEYeyXtXQ3GI22MPbxD34g==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="71930026"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="71930026"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 23:45:14 -0700
X-CSE-ConnectionGUID: gthHeES5Q6qKvTmEjmGXNg==
X-CSE-MsgGUID: BxkI3KnsS9WvXR/EhO2zAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="201635551"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 23:45:09 -0700
Message-ID: <38eec5be-817a-4701-bd01-e747217bc44e@linux.intel.com>
Date: Sun, 28 Sep 2025 14:45:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: use kcalloc() instead of
 multiplication
To: Joey Pabalinas <joeypabalinas@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
References: <455fb1db8ab0811d2336e0ec198c728a0c703be9.1757744812.git.joeypabalinas@gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <455fb1db8ab0811d2336e0ec198c728a0c703be9.1757744812.git.joeypabalinas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/13/2025 2:35 PM, Joey Pabalinas wrote:
> Dynamic size calculations should not be performed in allocator
> function arguments due to overflow risk.
>
> Use kcalloc() instead of multiplication in the first argument
> of kzalloc().
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> ---
>  arch/x86/events/amd/uncore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index e8b6af199c738eb00b..d08e3054461f2ca07a 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -1036,11 +1036,11 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>  		group_num_pmus[gid] = hweight32(info.split.aux_data);
>  		group_num_pmcs[gid] = info.split.num_pmcs;
>  		uncore->num_pmus += group_num_pmus[gid];
>  	}
>  
> -	uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
> +	uncore->pmus = kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
>  			       GFP_KERNEL);
>  	if (!uncore->pmus) {
>  		uncore->num_pmus = 0;
>  		goto done;
>  	}

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


