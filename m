Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6D7E59A;
	Tue, 22 Oct 2024 04:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570851; cv=none; b=SfiQ7CnhC/zsEgdlIaYg8q6Y2GQHbDPDPEuO5Tbbuia61MEkA+V+H+bes+Jr4sS0Kc/pwhlWi89IF9ccCkwloodZQR7cmcp+UWfbR8PO4UOMw9dhRrIatdarFB4yqKbbKDxGysBzxS3TNsa1HjexfFgxalk1ZYJiySikmzl1Fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570851; c=relaxed/simple;
	bh=6C7TbcwcsBrVCH+0oRHx5wFXFuHSQJi+2YEjUCraXho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub+LoJQlQ548W0vo2iCxfOdSWUtgV8Y6pwYv2Pgw1TMFihTOd4QkR9kPd7RovjGM09dfUSjmCfpEgz4qwYbmXAXhFRkaCBl2b6Bui/8upRwgH9HRDUOb0w7UjHLflLToyBbDHe+PSmGSKGHYUQT/Wt4dn0gs3DSoLxV/Ou2VOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUZ7GBbf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUZ7GBbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA72C4CEC3;
	Tue, 22 Oct 2024 04:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729570851;
	bh=6C7TbcwcsBrVCH+0oRHx5wFXFuHSQJi+2YEjUCraXho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUZ7GBbfaYeQtbC+zsCrcHpi1JK4lYDuBS1+OCWAChhsBnVxcs/Rj+Ex95gQWH48X
	 e4ZgTLn7Ks6X3N+e/UCh5itrpofVU3GrPqdzOPoLngFwcCtlwhYl+Y33ZTmBWWLQ4d
	 f2Ld4hYbCv7UiT1B375g/+Z31PNuYDg8DjjWv8L4e5IqxXYGtOyBxbl/5Fp3IwHtzx
	 AbnzK08cfmYZq8Vj6Lo2TEW4prDn9qAC0+IEZY6/uWhdbtswi8WDmVEoKP1tJ5TACW
	 cfg3BRWb2Jv2etsIX5+i/UX6FZ6r4OxppN1DT9q0NxftYWoEAHjIxM5NNFc8eG5IEX
	 IobOAO71Mbtrg==
Date: Mon, 21 Oct 2024 21:20:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, acme@kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] Remove unnecessary header includes from
 {tools/}lib/list_sort.c
Message-ID: <ZxcoISlNVmGAq_5i@google.com>
References: <20241012042828.471614-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241012042828.471614-1-visitorckw@gmail.com>

On Sat, Oct 12, 2024 at 12:28:25PM +0800, Kuan-Wei Chiu wrote:
> Remove outdated and unnecessary header includes from lib/list_sort.c
> and tools/lib/list_sort.c. Additionally, update the hunk exceptions
> checked by check_headers.sh to reflect these changes.
> 
> Regards,
> Kuan-Wei
> 
> Kuan-Wei Chiu (3):
>   lib/list_sort: Remove unnecessary header includes
>   tools/lib/list_sort: Remove unnecessary header includes
>   perf tools: Update expected diff for lib/list_sort.c

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  lib/list_sort.c                                      |  3 ---
>  tools/lib/list_sort.c                                |  2 --
>  tools/perf/check-header_ignore_hunks/lib/list_sort.c | 11 ++---------
>  3 files changed, 2 insertions(+), 14 deletions(-)
> 
> -- 
> 2.34.1
> 
