Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD2194AD5;
	Fri,  9 Aug 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209699; cv=none; b=OGz5YxLW6IBxFUuoG9xdPw/fkveTubvih/LbJV8dTEWAsps9oZ/FGj1z9JWj+Uf+vJl9SFFJwFL1SdglBcz1e+xEG9JP9vpCMZoaF++ZvXTIt81fs5nytcvkBxzke/0zbgR4kalE7wifileR7Q7juT4sBUNV3DIvedSsCZj7tLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209699; c=relaxed/simple;
	bh=VdKHspRy4P9U0vRoTHUMubqchKKtE4YAg3TuJv0q3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4fGdiSaeDva96BWibAlLOtg52GNy3PF0Jwo/k7GgP1QB9utqz1/E7U/MAU/M2bYCqE7xSO0+k0S++o05COobRMGeADQgqDIhMRyFqfA4b8c0xmtYScR/QD3E+v22GGw0C/eIEP4KpFQzibhspJW9MvhQgAan5W8e0hUbwVGB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exLPRD2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exLPRD2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C424DC32782;
	Fri,  9 Aug 2024 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723209699;
	bh=VdKHspRy4P9U0vRoTHUMubqchKKtE4YAg3TuJv0q3x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exLPRD2WhkYbp6UanBo8MG3Pnln7mde3KPMILuxqZfuPdJU7oH352d+zczzOZhzip
	 hB/6cPW+glDN54JKvZGDi16d5Uefj9SQm5nYlYAaYzMzWHSa33t+R9a8eIuyHcrU94
	 d7e4D4zAYtlwHNIUUGFEC5qvN5S/NjVN3RySgTg7dH27JEXRb2jU10WbVoWJiqAXYj
	 ao3KRgG+aJ+9I9LWZk4ye5t8OGJfDmkSsteex608fUwa/iL1pxAFUGNjOOgOTp1S5d
	 NNSHqQIhQ2QIcc2WkJCGr62FGVBleBihujz2ZhMEiOGdPgjQkpUR3jByptesU2Ro3/
	 rcUxA+7i/viMg==
Date: Fri, 9 Aug 2024 10:21:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf trace: Collect augmented data using BPF
Message-ID: <ZrYX4CFLNcI7xfLs@x1>
References: <20240731194939.4760-1-howardchu95@gmail.com>
 <20240731194939.4760-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731194939.4760-3-howardchu95@gmail.com>

On Thu, Aug 01, 2024 at 03:49:38AM +0800, Howard Chu wrote:
> Add task filtering in BPF to avoid collecting useless data.

The above feature should have been on a separate patch, if it is needed
at all, see below.
 
>  SEC("tp/raw_syscalls/sys_enter")
>  int sys_enter(struct syscall_enter_args *args)
>  {
> @@ -389,6 +501,9 @@ int sys_enter(struct syscall_enter_args *args)
>  	if (pid_filter__has(&pids_filtered, getpid()))
>  		return 0;
>  
> +	if (filter_pid && not_in_filter(getpid()))
> +		return 0;
> +

Why do we have two wais of filtering pids? pids_filtered and that
volatile, etc?

- Arnaldo
