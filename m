Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338719D8A3;
	Fri,  3 Oct 2025 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759466320; cv=none; b=CtArB2tAVfasJ5bdAxzZDXPG5tkagYWaeSoPrvHfUgDJ+xB9KTlYWB02QcaAQa7X0YvSytMHOPy7CFlvPK6NA40fepE02Pr+n96FvkRl/4xK7ioESNLvGFe/TeFVkjLVROPX2GYD0gN2kK1BbkH/QlHgxGrqLertoMNcSsfrsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759466320; c=relaxed/simple;
	bh=YB9h7a+lip4DzsrxCoL/ykcyG+kEAQwpy1Ru3e3Ygmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKh/xCeO6nf5HkZ9mav6dQD86K3NMEYu1GnruoQ9p1Fzx1Ynuv5vqubGEoyqnJlsgMItdC6GiisrmyyqsnxgAidB0CMRkxJ5F6Q4MCW3k1dAXgymCw+dSjc9gajfpiT+0Krq6qPM6cvREinoJJPJn9LtCJKezzQKDAwznQI9Lgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iohhr0FN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iohhr0FN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE7FC4CEF5;
	Fri,  3 Oct 2025 04:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759466319;
	bh=YB9h7a+lip4DzsrxCoL/ykcyG+kEAQwpy1Ru3e3Ygmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iohhr0FNpDA6UJbR8tYDVoAulsO2nTiiYzgcLOfB8R1NaWG5TdJ88JWI71O132ug6
	 VrXcNLzQ8mUzB+DLUJfx+1+e3T04fldqDHxEz5rSdAbGGwmQVVNRjKBFvuZgoFiM9Y
	 mz0hH7MboZhqzNrdcuZH7s2kv2suxW7jChANhY+9YbPwwyZcI9ZxoSgKMwZOvnNIMV
	 S0vuxEAnyV7zDO4dAaAyl3mYGSlWA2dpDlugyl01PN/N8FrmRMbW7lBGZa65dXm0wy
	 h3kidkjXNZnemjsLwMtTlXQKMZ97NSjLfJwgSI8oALRhrPiP9y6Lwty59FP6CqhqdC
	 fXsnsaxPJlmxw==
Date: Fri, 3 Oct 2025 13:38:33 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, jolsa@kernel.org,
	alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: Remove myself from perf_events subsystem
Message-ID: <aN9TSXHrf5B_3k5P@google.com>
References: <20250925162428.3516894-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925162428.3516894-1-kan.liang@linux.intel.com>

On Thu, Sep 25, 2025 at 09:24:28AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> I'm stepping down as the Reviewer of perf_events subsystem.
> It has been an honor and a pleasure to work with everyone to improve the
> perf_events subsystem. However, due to personal reasons, I have to leave
> Intel. I believe it would be difficult for me to continue in this role
> any further.

Sorry to hear that, too.  You've been amazing on various works in this
area.  You'll be missed.  Hope you have a great opportunity for the next
stage!

Thanks,
Namhyung

> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..2c788294cf84 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19759,7 +19759,6 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  R:	Jiri Olsa <jolsa@kernel.org>
>  R:	Ian Rogers <irogers@google.com>
>  R:	Adrian Hunter <adrian.hunter@intel.com>
> -R:	"Liang, Kan" <kan.liang@linux.intel.com>
>  L:	linux-perf-users@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
> -- 
> 2.38.1
> 
