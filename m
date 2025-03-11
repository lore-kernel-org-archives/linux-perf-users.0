Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84801190674;
	Tue, 11 Mar 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680892; cv=none; b=JISrviHhg0KFTa2FfBXjtFGgSHNZXGDn4XaLuBYrpSnSAdFsgKJtXDXx4CJh0fgiSiyBcDAQRCXo/ZR3i+/Pvuj1EFsS+xbwQ9SJnVK8NbDKoEYmXaO/b7iTP+VD3Y6A6jnoEasZ1FsKiZWIi90JkPjpFD9sswxufRslgRH4Yh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680892; c=relaxed/simple;
	bh=fnvdHzd7V7r7rqyLT2xRsX4MdQDqZhJcwTJpt44q0zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auur1Fo9MTjqCskXxqQPrOzxwDNKZv12ycIoPcT/EP6+dMQb2xhC1FguM/EFZXb6NsA6SnOItXkQ1Kj5EHUfDxAe34YjBgk+1DwXCI07enquEZmWNmRo5+MbIc5Xq6YqA/iqwXhuiUUqMoAJCANIJDr17LqZm4sLqKWQdbvvbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC808152B;
	Tue, 11 Mar 2025 01:14:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA973F694;
	Tue, 11 Mar 2025 01:14:47 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:14:43 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Martin Liska <martin.liska@hey.com>
Subject: Re: [PATCH] perf script: Update brstack syntax documentation
Message-ID: <20250311081443.GI9682@e132581.arm.com>
References: <20250225061736.1698175-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225061736.1698175-1-yujie.liu@intel.com>

Hi Yujie,

Sorry I missed this patch.

On Tue, Feb 25, 2025 at 02:17:36PM +0800, Yujie Liu wrote:
> 
> The following commits appended new fields to the end of the branch info
> list, such as branch type and branch speculation info.
> 
> commit 1f48989cdc7d ("perf script: Output branch sample type")
> commit 6ade6c646035 ("perf script: Show branch speculation info")
> 
> Update brstack syntax documentation to be consistent with the latest
> branch info list. Improve the descriptions to help users interpret the
> fields accurately.
> 
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index b72866ef270b..8bd105084280 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -239,13 +239,15 @@ OPTIONS
>         i.e., -F "" is not allowed.
> 
>         The brstack output includes branch related information with raw addresses using the
> -       /v/v/v/v/cycles syntax in the following order:
> -       FROM: branch source instruction
> -       TO  : branch target instruction
> -        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> -       X/- : X=branch inside a transactional region, -=not in transaction region or not supported
> -       A/- : A=TSX abort entry, -=not aborted region or not supported
> -       cycles
> +       FROM/TO/PRED/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
> +       FROM  : branch source instruction
> +       TO    : branch target instruction
> +       PRED  : M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported

Can we use a more generic naming (e.g., EVENT) for this field?

My patches have added a 'N' flag in this field, which stands for
"Not taken branch".  Later we might extend this field for support new
event types.

Thanks,
Leo

> +       INTX  : X=branch inside a transactional region, -=not in transaction region or not supported
> +       ABORT : A=TSX abort entry, -=not aborted region or not supported
> +       CYCLES: the number of cycles that have elapsed since the last branch was recorded
> +       TYPE  : branch type
> +       SPEC  : branch speculation info
> 
>         The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
> 
> --
> 2.34.1
> 
> 
