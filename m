Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2148CD1
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpNyWzxX"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbc7746812so3760983b6e.2
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 04:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704891350; x=1705496150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6TzB+1S72/tbeouoEj+W3sOgNQQ58sp+mssNH666Es=;
        b=FpNyWzxXN1REYnq2mIumKIpjcrBTOgBt0JRij+7kBWtBo9i+LYCSM960zt7VC4C3bR
         vvVBaO2wsRonGSbHNUZMHd4eCgmiFZdxcS9vt1nv8CYiKR4V7t91vgt2uHxxe4Hfl/jx
         OkpAfcWgzirdiaUszKjbNM0PuEQER8wrGRvlvb0Jnx0Xv44h0xsW495e0yYv7ISZy4W0
         hpoi3kXoX8zbQ/UKecxhgG0Z151KzcHGJHBenuPCumekle0roi7agFDRDc3uk5Ujz4nS
         a0mEpbYDE0ILngc/EA9Ydy9F1vFu0j328xqAQ6HrlycVGzBLig3eO8aixZHP8obVGgRI
         W2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891350; x=1705496150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6TzB+1S72/tbeouoEj+W3sOgNQQ58sp+mssNH666Es=;
        b=sw/lKVSdI3YmkIkVU73KQNziBv+eELaLf7lhxjvALF3oFA2vfbS0nf4PHp89aziGCR
         OvFA0EXG9DYvU4PfN5nrYM/p1IXqWcl6uJw379kL4x4cSw7/sw50gehEPdHew+SdfRJj
         xP72iCcDt+eCofxaLPfBQCJO2dsS/e5Jt1GmnMntOPZv7vAFVwah8w9QbOA1hoDMkX8g
         tWFIzV0xoVyjscb1EscX9j//KjdZZ458WigVr61CXfbP7coR4qtOs/NcPEAFZbIKP+FJ
         EikG+zPpJqIFJSavYhtfREIH1DIGoZjXTv6eOOp9u9bgesB+az2NCexUDgBtfQ4U+f8Y
         6Y5g==
X-Gm-Message-State: AOJu0YxCtHgNo0lifc3k6OY3tgd0KTiDyJOWrpKPG8z/bFeZEe6J5Vm7
	Jl5HzU5iE1fGMjlUkR22pGXo8bsvJEVCLQ==
X-Google-Smtp-Source: AGHT+IEgtcj5HA/BznSC6a3oApaQxYzWJ2JZ5y0CrJqTQizybxpFHZlmbrOs2X7X9QrtSXq4r+wWVQ==
X-Received: by 2002:a05:6808:1a03:b0:3bc:3046:94b1 with SMTP id bk3-20020a0568081a0300b003bc304694b1mr1309823oib.99.1704891350471;
        Wed, 10 Jan 2024 04:55:50 -0800 (PST)
Received: from debian-dev (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id ff26-20020a056a002f5a00b006da73b90fe4sm3539241pfb.14.2024.01.10.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 04:55:49 -0800 (PST)
Date: Wed, 10 Jan 2024 20:55:44 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, james.clark@arm.com,
	coresight@lists.linaro.org, suzuki.poulose@arm.com,
	mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, al.grant@arm.com,
	mathieu.poirier@linaro.org, tor@ti.com, acme@redhat.com
Subject: Re: [PATCH v2 1/1] perf scripts python: arm-cs-trace-disasm.py: add
 option to print virtual address
Message-ID: <20240110125544.GG44@debian-dev>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20240110025617.66646-1-tianruidong@linux.alibaba.com>
 <20240110025617.66646-2-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110025617.66646-2-tianruidong@linux.alibaba.com>

Hi Ruidong,

On Wed, Jan 10, 2024 at 10:56:17AM +0800, Ruidong Tian wrote:
> arm-cs-trace-disasm just print offset for library dso now:
> 
>     0000000000002200 <memcpy>:
>         2200: d503201f      nop
>         2204: 8b020024      add     x4, x1, x2
>         2208: 8b020005      add     x5, x0, x2
> 
> Add a option `-a` to print virtual offset other than offset:
> 
>     # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d llvm-objdump -a
>     ...
>     ffffb4c23200 <memcpy>:
>         ffffb4c23200: d503201f      nop
>         ffffb4c23204: 8b020024      add     x4, x1, x2
>         ffffb4c23208: 8b020005      add     x5, x0, x2
>     ...
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

I only gave suggestion, it's no need to add my SoB and this might break
the SoB chain and rejected by maintainers.

So with removing my SoB, the patch is fine for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

I would like to suggest you to resend patch set v2 with all patches
- though patches 02 and 03 have no any change, but it would be easier
for maintainers to pick up the whole patches (especially this can save
time with b4 tool).

Thanks,
Leo

> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..78419498237e 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -36,7 +36,10 @@ option_list = [
>  		    help="Set path to objdump executable file"),
>  	make_option("-v", "--verbose", dest="verbose",
>  		    action="store_true", default=False,
> -		    help="Enable debugging log")
> +		    help="Enable debugging log"),
> +	make_option("-a", "--vaddr", dest="vaddr",
> +			action="store_true", default=False,
> +			help="Enable virtual address")
>  ]
>  
>  parser = OptionParser(option_list=option_list)
> @@ -108,6 +111,14 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
>  			m = disasm_re.search(line)
>  			if m is None:
>  				continue
> +
> +		# Replace offset with virtual address
> +		if (options.vaddr == True):
> +			offset = re.search(r"^\s*([0-9a-fA-F]+)", line).group()
> +			if offset:
> +				virt_addr = dso_start + int(offset, 16)
> +				line = line.replace(offset.lstrip(), "%x" % virt_addr)
> +
>  		print("\t" + line)
>  
>  def print_sample(sample):
> -- 
> 2.33.1
> 
