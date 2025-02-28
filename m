Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54025C6F1;
	Fri, 28 Feb 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734810; cv=none; b=iLt2ek2G0p2Tn81u5sLOIljnM9cjR/aJKwJQ9aJPI7xsDOgCu5ZCN3lP0E2V0D0qHdhBQonbh1XSAZvT/uKEjIheb/IP4GqHQE5PF9wLlgBxVej2+jdCt52eaPziWaKG0P/vhA4m3W/5s4o0EV+hfStdR8x2Ho+WsWRCmqPHiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734810; c=relaxed/simple;
	bh=kmNRUDi63hoq1y/R979Fz7vtxyOlpOhEMURK3Cge2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE8t6A0q8EF+1bAiySEVzrZPvWjfoS3fuFy6uGgTumKonHb6Fln1QF43YdULGHA1EAb5LoCDKvZ3hAFsOlp3fvnUC4Wh3Oi+FLyT1o6eEFZofdHscy4UTuBKCu0FWMgc1vuC8M8mYi2I6ASlJrj530+flcGi5CrRrpxfxJvB7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaKK/NBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaKK/NBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031A7C4CED6;
	Fri, 28 Feb 2025 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740734810;
	bh=kmNRUDi63hoq1y/R979Fz7vtxyOlpOhEMURK3Cge2yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaKK/NBwdo88Afyx9Hd5lt5ZhktyVBK5rK3FiEDNihfSDT+E1exaPmE3kv3vEKSob
	 R5hRdWaIoq9DqeXWdGe7Qn51baP+M4E2DuN0n5VHSmOvRbguoOii7GDmY8Pzf/AWfj
	 XNrHjGMMx8+a+7r6m53ikg3z/WuwaNoq6xkXI1nZnoJfMXjdScIBaYcPZ3EMIqtDKH
	 KbiTochLI+h3TkWYwXxtH2b77ww8NuAbXeE1yDpi+FUsh5x5LjT6sBY/6s8EdhZ5iN
	 YVobQev5BF5Bcr4SsqVmvQV7CDAJ+zLxKtukW4R6UVtEVjijiz2ywUuvkkOQUMA2nt
	 Ez5RFXH2btGVA==
Date: Fri, 28 Feb 2025 10:26:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
	brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: Re: [PATCH v6 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
Message-ID: <Z8GBS81JWP7dl5s2@gmail.com>
References: <20250228082338.73859-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228082338.73859-1-xin@zytor.com>


* Xin Li (Intel) <xin@zytor.com> wrote:

> The x86 build process first generates required and disabled feature
> masks based on current build config, and then uses these generated
> masks to compile the source code.  When a CPU feature is not enabled
> in a build config, e.g., when CONFIG_X86_FRED=n, its feature disable
> flag, i.e., DISABLE_FRED, needs to be properly defined and added to
> a specific disabled CPU features mask in <asm/disabled-features.h>,
> as the following patch does:
> https://lore.kernel.org/all/20231205105030.8698-8-xin3.li@intel.com/.
> As a result, the FRED feature bit is surely cleared in the generated
> kernel binary when CONFIG_X86_FRED=n.
> 
> Recently there is another case to repeat the same exercise for the
> AMD SEV-SNP CPU feature:
> https://lore.kernel.org/all/20240126041126.1927228-2-michael.roth@amd.com/.
> https://lore.kernel.org/all/20240126041126.1927228-23-michael.roth@amd.com/.
> 
> It was one thing when there were four of CPU feature masks, but with
> over 20 it is going to cause mistakes, e.g.,
> https://lore.kernel.org/lkml/aaed79d5-d683-d1bc-7ba1-b33c8d6db618@suse.com/.
> 
> We want to eliminate the stupidly repeated exercise to manually assign
> features to CPU feature words through introducing an AWK script to
> automatically generate a header with required and disabled CPU feature
> masks based on current build config, and this patch set does that.
> 
> Link to v5:
> https://lore.kernel.org/lkml/20250106070727.3211006-1-xin@zytor.com/
> 
> 
> H. Peter Anvin (Intel) (3):
>   x86/cpufeatures: Rename X86_CMPXCHG64 to X86_CX8
>   x86/cpufeatures: Add {required,disabled} feature configs
>   x86/cpufeatures: Generate a feature mask header based on build config
> 
> Xin Li (Intel) (2):
>   x86/cpufeatures: Remove {disabled,required}-features.h
>   x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET

>  24 files changed, 320 insertions(+), 634 deletions(-)

Very nice!

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
