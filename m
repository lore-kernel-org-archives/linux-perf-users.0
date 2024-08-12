Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2F18E02E;
	Mon, 12 Aug 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489446; cv=none; b=PrBJLlKiSb2cS0vD+a7Bacv53/TUkqFB96W2aKd5IqiF83tWSqzgCr5hmDWnHFbIKJjcyrR7YNdsIN7NiMPN1EI+6KZRKyaq1Jb3YYb8sJirf8rfiGZamL0mqXEQ//TGy1ovs2S9SAUrcsylA9UNoexB0+xPAW2jWfFOkEDopqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489446; c=relaxed/simple;
	bh=P4kzq2nJdwbceeIcm6PDqHrbtu0pNEAaDv1hyaG4UXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjqDt4FHq5iowHrEJ4uTmvqjsxFBiuj7PTCergogF+/oRUiKC1Tc5nbVBSgju3w1DEhIxCz1oysDDElqI1ydtHyCBBIO6h4Entr4KFRWhQQtudPNM2GRfzUrrMHcZynydsX9jLglRBww/iFhha1h2QO7WGJLUV8nnjV/M4DnZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a16Yifiw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a16Yifiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A38C32782;
	Mon, 12 Aug 2024 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723489445;
	bh=P4kzq2nJdwbceeIcm6PDqHrbtu0pNEAaDv1hyaG4UXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a16YifiwWy5pkN70TOWiSeECbOKlCzs0VE9cfFgLHjFhajl8ZYSkghjjRVdMBHaxK
	 k8LhuFYWbjQQXzPax7gVV1Nz8wnQt3nU6d11sWtooLpSOghOQxZ4z4eQ+8bYwGxp0c
	 lGR7GhopvVQsqw3uqO/75qD8atMLpP8uOGMBzBIBAM50svoKehvMIdkWY5fCQqZ0yr
	 jjBraDy/IMczJigWwzPKp1UFNAykO2wLQ6yJAAWGQL1nyF4YO0XdUjQpQBx0a1JBPA
	 9nCIxC90Snj5Z32jbI41562VM3a5NNvxe+8ZeAs5xWMRb5UBHIvEabkAueFQCUNUKE
	 /NRiK2oDciE1g==
Date: Mon, 12 Aug 2024 12:04:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf sched timehist: Remove BUG_ON in
 timehist_sched_change_event()
Message-ID: <Zrpco5rOa9n7S5RN@google.com>
References: <20240812132606.3126490-1-yangjihong@bytedance.com>
 <20240812132606.3126490-2-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812132606.3126490-2-yangjihong@bytedance.com>

On Mon, Aug 12, 2024 at 09:26:06PM +0800, Yang Jihong wrote:
> The BUG_ON(thread__tid(thread) != 0) in timehist_sched_change_event()
> is redundant, remove it.
> No functional change.
> 
> Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-sched.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 177634df1ba5..309dcfb3796d 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2700,8 +2700,6 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  			struct idle_thread_runtime *itr = (void *)tr;
>  			struct thread_runtime *last_tr;
>  
> -			BUG_ON(thread__tid(thread) != 0);
> -
>  			if (itr->last_thread == NULL)
>  				goto out;
>  
> -- 
> 2.25.1
> 
