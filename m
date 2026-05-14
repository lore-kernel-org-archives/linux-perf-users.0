Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E831E822;
	Thu, 14 May 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774206; cv=none; b=Fh7CGgsMDJdT/1rqx670GlaXkyXVw3cGhC+Skj0un5rBA4zlx1ZbRVHXUHxXRaUtzyWkp528zOIPeL6KXucmUqmTObcklF3o648Lyke6pUf3yGKIS0G4V/vCvYc5BtYyNu+3Nr2ES69JznymBtyzp6DhHwifowHGgyv1YHIq17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774206; c=relaxed/simple;
	bh=mwg+YdRcCDaq8aYC9g4Pg3TaRv5ksI2oXXRO/85GMJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRMBMNKZ6tYffc5XEnIvJVqnrNpMVqiFdirHR7fnPkRBoid5o0xbFSXygTpoXAS13BHVkFO+hHMJfd7GzJZCErqbFqqH9MgMj1nEHfHRTBKL2DXZGB3yOus2UAnWef9JWNw9olkBM7Zw8wdwDm2sOh3jW1caqes/J5hzcsqhCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juYsP7Ni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juYsP7Ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F683C2BCF5;
	Thu, 14 May 2026 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778774205;
	bh=mwg+YdRcCDaq8aYC9g4Pg3TaRv5ksI2oXXRO/85GMJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juYsP7NiDixT6RZH088fpxmBk1wY8iYS7UZokT6bHzG9MEB2+46EzPEL3HxGZVdVJ
	 dXkMJcphoCur3Ib37y6pElMiRG4iYKApAjGmHIYIMTeLIyZBihFKyJMSr6GmoH0IjQ
	 svYoNVEl2IvCoIAej+EYnMXoLJXiiF9aPKYEOIvg9zN6XZcJfC0IwBqiTrqbgOa4Xu
	 /VYXWHPybmuFZ+GTbNfrsA5+HoRdF2xzN/OwzOa46jh2Mz2mm1Mhfhb5B/LgJyhxid
	 FMLDReQyxP5OmqWfTWbNz2tk4SgVv4w/o6CSoeq/6TPEzk7H26TqcjL+WprqxqHxFn
	 lUNz4ogSJ4zuA==
Date: Thu, 14 May 2026 08:56:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, mmayer@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel
 headers
Message-ID: <agXwulXp_PqixUCg@google.com>
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513192347.4007895-1-florian.fainelli@broadcom.com>

Hello,

On Wed, May 13, 2026 at 12:23:46PM -0700, Florian Fainelli wrote:
> Toolchains with older kernel headers that do not include upstream commit
> c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface for
> setting/getting write life time hints") will now fail to build perf due
> to missing definitions for
> F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.

Can you share the error messages?

I think this code should use a copy of the header in
trace/beauty/include/uapi/linux/fcntl.h which has the definitions.

Thanks,
Namhyung

> 
> Provide a fallback definition for these when they are not already
> defined.
> 
> Fixes: 9c47f6674838 ("perf trace beauty fcntl: Basic 'arg' beautifier")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  tools/perf/trace/beauty/fcntl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
> index d075904dccce..e1b99b8f55eb 100644
> --- a/tools/perf/trace/beauty/fcntl.c
> +++ b/tools/perf/trace/beauty/fcntl.c
> @@ -9,6 +9,22 @@
>  #include <linux/kernel.h>
>  #include <linux/fcntl.h>
>  
> +#ifndef F_GET_RW_HINT
> +#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
> +#endif
> +
> +#ifndef F_SET_RW_HINT
> +#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
> +#endif
> +
> +#ifndef F_GET_FILE_RW_HINT
> +#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
> +#endif
> +
> +#ifndef F_SET_FILE_RW_HINT
> +#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
> +#endif
> +
>  static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t size, bool show_prefix)
>  {
>  	return val ? scnprintf(bf, size, "%s", "0") :
> -- 
> 2.34.1
> 
