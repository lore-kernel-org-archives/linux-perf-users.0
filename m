Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0B1BC5C;
	Thu, 13 Mar 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860349; cv=none; b=bamPG384YnVILgCefVhpCFIV/XrYSWOP3Zt4UXR1/u3WeBt3huppXsTRSKut02nN4UR+ZGSolcveiqtR9XZ//pFIJHpBMSxizw7NaEZEO0wh6b7mTDxobvZrVG59uHsD6ylJySNlhBB8GhExZ1bDnul9VP1kOWaYfWAf+gcr8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860349; c=relaxed/simple;
	bh=4x+Bc5eH3aMzK7kRf+XXm/9sp8zGr2Jj0tTdonGqpsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdTi2Ijj47XhF75qS9zCdU0ryPqDLPOle1lhHO3cmC0Hg+uoDF2bfqJ4x++rtJXAAYZJBnmn/TByrQPuygAjtjtbSbqNSpghkglcpYXbRfifuFyK9cMmTeKGwP/Af4xwNWBjEIgUq//gmGXW3Q61Lbio/YBJgLyspQb95HkAhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiRaSW3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiRaSW3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B25FC4CEDD;
	Thu, 13 Mar 2025 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741860348;
	bh=4x+Bc5eH3aMzK7kRf+XXm/9sp8zGr2Jj0tTdonGqpsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiRaSW3yDU7w3CgOxPbLvFG2SLDHznF2/XNbmwRod/CnrqdLizkkSJjLX4AgKpy/b
	 T+8VVIHxzIhVXF78rgyw8pgH7PsQ1k4Em/2O57gfLY44fVe7kmlynlI0PFLsmRd1jC
	 bCL57skCWbtDHVk1B5zTH0wKBRSrFKeJKC0xAmzwwZXHmUOlzI2GmYzGwijV2U5jJK
	 2sQN8qA10Ee7wZFj1bUVvXHH8+gUecFbQAZeTqNndPU8WzhfnDZjLN4MuT/sdXwwrw
	 hGnMznsPqcWBt5ooiu+dka8tTbFevQ7+NmExKpV+Tqidu9lOx6O738EtkbmRNu34hB
	 Y5iz1elZnPY3g==
Date: Thu, 13 Mar 2025 11:05:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for
 poll
Message-ID: <Z9Kt57aAC7XET7Na@gmail.com>
References: <20250313051047.2436098-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313051047.2436098-1-chen.dylane@linux.dev>


* Tao Chen <chen.dylane@linux.dev> wrote:

> The poll man page says POLLRDNORM is equivalent to POLLIN,
> so add EPOLLRDNORM here.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/events/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 59a52b1a1..5130b119d 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -19,7 +19,7 @@
>  
>  static void perf_output_wakeup(struct perf_output_handle *handle)
>  {
> -	atomic_set(&handle->rb->poll, EPOLLIN);
> +	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);

So what does EPOLLRDNORM mean to begin with? There doesn't seem to be 
separate/specific handling of it anywhere in the kernel that I can 
see...

Thanks,

	Ingo
