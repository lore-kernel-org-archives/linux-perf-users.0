Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377B5BAF0;
	Thu, 24 Apr 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511623; cv=none; b=ldx72u8cw/iHUcSzkeqq1vNml2qAVX9CWfIxtSO7xygfcrrxyuJbqSeuBmDUvji6Pyg740DoRG7KZW2EEKIB/PGn9t37NIJY6C5RNWJaOTJ08E99TAw51wZcyxdsB6+lbqjHa504tFPqzbeK6tw2ZoIbhDngrjT76VmJF1ubl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511623; c=relaxed/simple;
	bh=6ljqckhANoBqw3YchiUNPsDCe7CdD/3KO0hDL4Rve1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in8wsDj0uq0euq/m6+vJNMLlSqdElxtlcnCuFAxuHk+nI4AQ/DZykxQuhi1E1IAflHnZnk7Dpg4y2JNn7OaglHIsOMfNYSHlydkEAZ7DAZcvpvqKrSf+k4eBxuuClawl/cKCevNvWUFicmFOLE2nQ03PyfM0yDmUoRUEmv6HRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSobpsIx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSobpsIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECCCC4CEE3;
	Thu, 24 Apr 2025 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511623;
	bh=6ljqckhANoBqw3YchiUNPsDCe7CdD/3KO0hDL4Rve1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSobpsIxRHPCbYVAvP9UEgh8ge5jddMoUCQ0yOa137tXWJaKce0wErqAAzMGICdy6
	 vAWlYVdw5+jUZAbI3fFFSy+ZGqv3YE4y9KqMGL4yZKO9kmnUC7rRt7HpmcJiabdW6U
	 AVkKuuNNtX1IiIAwhb+5tqtuV0R8yCfzzkZ0m0CVTap39G3B7V8KnVp1etohxI1qKs
	 YOoLBo+KMEsL4imPfJGXwTALJGBUGjcEWK6XGg28jfX3urBpYO3+EoGkG0cRcLcp0O
	 M1e3ihpfQ9nVEL7ztFtGCw/BcuIGUrd/aMHY+xQJf2jCbHD/dAMVZFzoxpIQ8aDx3X
	 6dAocR38TFrNw==
Date: Thu, 24 Apr 2025 18:20:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Fix open counting event error
Message-ID: <aApkwfEUCJcc9PXn@gmail.com>
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423064724.3716211-1-luogengkun@huaweicloud.com>


* Luo Gengkun <luogengkun@huaweicloud.com> wrote:

> Perf doesn't work at perf stat for hardware events:
> 
>  $perf stat -- sleep 1
>  Performance counter stats for 'sleep 1':
>              16.44 msec task-clock                       #    0.016 CPUs utilized
>                  2      context-switches                 #  121.691 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 54      page-faults                      #    3.286 K/sec
>    <not supported>	cycles
>    <not supported>	instructions
>    <not supported>	branches
>    <not supported>	branch-misses
> 
> The reason is that the check in x86_pmu_hw_config for sampling event is
> unexpectedly applied to the counting event.
> 
> Fixes: 88ec7eedbbd2 ("perf/x86: Fix low freqency setting issue")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>  arch/x86/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 6866cc5acb0b..3a4f031d2f44 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -629,7 +629,7 @@ int x86_pmu_hw_config(struct perf_event *event)
>  	if (event->attr.type == event->pmu->type)
>  		event->hw.config |= x86_pmu_get_event_config(event);
>  
> -	if (!event->attr.freq && x86_pmu.limit_period) {
> +	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {

Hm, so how come it works here, on an affected x86 system:

$ perf stat -- sleep 1

 Performance counter stats for 'sleep 1':

              0.64 msec task-clock:u                     #    0.001 CPUs utilized             
                 0      context-switches:u               #    0.000 /sec                      
                 0      cpu-migrations:u                 #    0.000 /sec                      
                73      page-faults:u                    #  114.063 K/sec                     
           325,849      instructions:u                   #    0.56  insn per cycle            
                                                  #    0.88  stalled cycles per insn   
           580,323      cycles:u                         #    0.907 GHz                       
           286,348      stalled-cycles-frontend:u        #   49.34% frontend cycles idle      
            72,623      branches:u                       #  113.474 M/sec                     
             4,713      branch-misses:u                  #    6.49% of all branches           


?

Thanks,

	Ingo
