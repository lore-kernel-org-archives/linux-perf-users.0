Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48971BFE05
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806634; cv=none; b=DzQXqoBFPICa4vOS1+lDPnSE13kf4XxmA/DByUcyK1h7yMeKQ2kojl5VYVrykttLSqla7mtSxuXwxdiQnaWxD869Il27WS17w3Uh0C85geNeBIvk1b9nUmYzMauAbZjMhfP+CQ0XmzjmKGU6uTKRy09vqvELQeEmUXxrjwnLr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806634; c=relaxed/simple;
	bh=nyWosVO4gXhoNan9ZDnAorgdajMFfqV7pgwt7RBeMIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+VA9iGk35grZbi8JptG+UM8vq9wZ+R8Ekc8wSACzZPwnJtWH5u6ctYyQWFt2YPWGwMsqj2gXFa0CznpGXGMfSfpaLUcACokfrRubWVpuVtfk5Alju2ryMgCkBGUBDgLSWjG39EDhb62NPTLJMEI7gG0/BOZLeZaDfVhJ0mzz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cApdJnv4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cApdJnv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0D7C4CED6;
	Mon, 13 Jan 2025 22:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736806634;
	bh=nyWosVO4gXhoNan9ZDnAorgdajMFfqV7pgwt7RBeMIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cApdJnv4KbxaGWcejg6A2RbyrozepKqmlndvXBi2hkv0PwCbDyuRefMCVC6AogllV
	 VOcVN4YfrAWCFkzgPg6hMg8iACkZVi05w3DrKIWxkEwjtyufI2g1QbdSHU5hLrvp1K
	 t4JDUPfbyrWaCCRAYhVSpsndbMdIMezIXlgdTsKkGDKy/JaL8aPa3HvTPx4ajSF7It
	 QqJ2PRDrdAyQDTcJJsS6xUB5RT4vTiqih4CfeKzsZdD7axjFa+7YhiK6bSMkIQUHfC
	 ga/avwv08EA7UVMkt1KjZc7WGO1E2ymB9ozc8a0NizLZA2pFMrAdivrTD7+lEObYC3
	 S1aPf7+G7CWXA==
Date: Mon, 13 Jan 2025 14:17:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.ibm.com
Subject: Re: [PATCH V2] tools/perf/builtin-lock: Fix return code for
 functions in __cmd_contention
Message-ID: <Z4WQ6IO1euKOMIHN@google.com>
References: <20250110093730.93610-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110093730.93610-1-atrajeev@linux.vnet.ibm.com>

On Fri, Jan 10, 2025 at 03:07:30PM +0530, Athira Rajeev wrote:
> perf lock contention returns zero exit value even if the lock contention
> BPF setup failed.
> 
>   # ./perf lock con -b true
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
>   libbpf: failed to find valid kernel BTF
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
>   libbpf: failed to find valid kernel BTF
>   libbpf: Error loading vmlinux BTF: -ESRCH
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>   # echo $?
>    0
> 
> Fix this by saving the return code for lock_contention_prepare
> so that command exits with proper return code. Similarly set the
> return code properly for two other functions in builtin-lock, namely
> setup_output_field() and select_key().
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Changelog:
>  v1 -> v2
>  Fixed return code in functions: setup_output_field()
>  and select_key() as pointed out by Namhyung.
> 
>  tools/perf/builtin-lock.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 208c482daa56..94a2bc15a2fa 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2049,7 +2049,8 @@ static int __cmd_contention(int argc, const char **argv)
>  				goto out_delete;
>  		}
>  
> -		if (lock_contention_prepare(&con) < 0) {
> +		err = lock_contention_prepare(&con);
> +		if (err < 0) {
>  			pr_err("lock contention BPF setup failed\n");
>  			goto out_delete;
>  		}
> @@ -2070,10 +2071,14 @@ static int __cmd_contention(int argc, const char **argv)
>  		}
>  	}
>  
> -	if (setup_output_field(true, output_fields))
> +	err = setup_output_field(true, output_fields);
> +	if (err) {
> +		pr_err("Failed to setup output field\n");
>  		goto out_delete;
> +	}
>  
> -	if (select_key(true))
> +	err = select_key(true);
> +	if (err)
>  		goto out_delete;
>  
>  	if (symbol_conf.field_sep) {
> -- 
> 2.43.5
> 
