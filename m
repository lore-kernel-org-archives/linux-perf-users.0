Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D151EB5CF;
	Tue, 18 Feb 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904367; cv=none; b=Ywbd3b376sDcA2AA5HD0ASQpyFuY4UNNXQx6YnNn8qqk+W8eDqXD3ygFWBjE/ogbbuLWvp20rUaARomFfk8hBl3eSD1hVYygKyP3hXwIvGH+F5nrKMseT1VlWtg8dvIpva65r9E2ADGvsQydz5r54pzDoEHz3dNgZLpcg+l/dwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904367; c=relaxed/simple;
	bh=T1cnmcGTPhrweOE0+cTTV094VaS2Q0FwumZMJXVQSGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMX4aBJZs/8Uz2soQAg+WHAgvWnYMjKhUG6XYVALP3W/6nB/ixlaAR/TRKI1THedaYA14EI/nnkjVWcNmKKAeBr1+oZBXFMN7jIk+wsOslfJckryFQbVEEaRQPleWsxiUXQ4y9k0MwSNJYoRT8qhdyCDlOv8I0ZGLWsLBGZiJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3qVxknY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3qVxknY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89D3C4CEE2;
	Tue, 18 Feb 2025 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739904367;
	bh=T1cnmcGTPhrweOE0+cTTV094VaS2Q0FwumZMJXVQSGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3qVxknYs4hN528M5Hhh8bnCK3kbaoEGCGXryQnsKFiaOwey0rT/Mpb/a7KFM1Lz0
	 /jxjwkB8YwC2LpmV7LW9xnuxi3bVOBR+VyYIaMS8RLIxwLQPCUhyq6f3l9oV3tOGj5
	 zA6OLvjPE4RRxXrPRwUeM39KHvXzHgWS5LYR5uKsrERBM5uqsxfbDZvX1E4FBcQG/A
	 Ckp0x86vLPqIZZdfQWFV0VNWAkq46LuSlhfaBVcGc6UxTjLszRg4NBIfZyS0HEFt/Y
	 c+PDK7KWA/JxP7RYGYHwrud3mfXqEQ0nlzwOkXF5D9XppH9JSvhFHAUTrSF7VME3N2
	 M91eybJlbMapw==
Date: Tue, 18 Feb 2025 10:46:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, acme@kernel.org, ak@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/9] perf report: Switch filtered from u8 to u16
Message-ID: <Z7TVbfUtD2LhYcj4@google.com>
References: <cover.1739437531.git.dvyukov@google.com>
 <32b4ce1731126c88a2d9e191dc87e39ae4651cb7.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32b4ce1731126c88a2d9e191dc87e39ae4651cb7.1739437531.git.dvyukov@google.com>

On Thu, Feb 13, 2025 at 10:08:16AM +0100, Dmitry Vyukov wrote:
> We already have all u8 bits taken, adding one more filter leads to unpleasant
> failure mode, where code compiles w/o warnings, but the last filters silently
> don't work. Add a typedef and switch to u16.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/util/addr_location.h | 3 ++-
>  tools/perf/util/hist.c          | 2 +-
>  tools/perf/util/hist.h          | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
> index 36aaa45445f24..f83d74e370b2f 100644
> --- a/tools/perf/util/addr_location.h
> +++ b/tools/perf/util/addr_location.h
> @@ -3,6 +3,7 @@
>  #define __PERF_ADDR_LOCATION 1
>  
>  #include <linux/types.h>
> +#include "hist.h"
>  
>  struct thread;
>  struct maps;
> @@ -17,7 +18,7 @@ struct addr_location {
>  	const char    *srcline;
>  	u64	      addr;
>  	char	      level;
> -	u8	      filtered;
> +	filter_mask_t filtered;
>  	u8	      cpumode;
>  	s32	      cpu;
>  	s32	      socket;

This change introduced a build failure on Fedora 40 with libcapstone
like below.

  In file included from /usr/include/capstone/capstone.h:325,                     
                   from util/disasm.c:1333:                                       
  /usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong kind of tag
     94 | typedef enum bpf_insn {                                                 
        |              ^~~~~~~~      
  make[4]: *** [/linux/tools/build/Makefile.build:86: /build/util/disasm.o] Error 1
  make[4]: *** Waiting for unfinished jobs....
  make[3]: *** [/linux/tools/build/Makefile.build:138: util] Error 2              
  make[2]: *** [Makefile.perf:822: /build/perf-util-in.o] Error 2                 
  make[2]: *** Waiting for unfinished jobs....                                    
  make[1]: *** [Makefile.perf:321: sub-make] Error 2                              
  make: *** [Makefile:76: all] Error 2     

I think we need the below change.  I'll fold it.

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 663e9a55d8ed3e46..64b5510252169239 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -3,7 +3,6 @@
 #define __PERF_ADDR_LOCATION 1
 
 #include <linux/types.h>
-#include "hist.h"
 
 struct thread;
 struct maps;
@@ -18,8 +17,8 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	filter_mask_t filtered;
 	u8	      cpumode;
+	u16	      filtered;
 	s32	      cpu;
 	s32	      socket;
 	/* Same as machine.parallelism but within [1, nr_cpus]. */
