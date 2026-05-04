Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FC7263B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777859220; cv=none; b=Pg7dIqQOitx3+EBPEE9fFsFygxdIcHgHZUiby1jNaWafEqQW7dHMDGT/2KIuoKj4E1BB6qMVzO49HW1t5LrkoD/F9H7bvCfRKWmzBlVkpb2LXAgNpL03QvUHkytelEGsPq597qMkE/ak15fSomgIwH891lyK4BCgwtuB/XoNSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777859220; c=relaxed/simple;
	bh=LISybazuiphZ0cqm05s0nNTtnkzBdC2nqyKFogowcyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvSLOE0JMgzWCA/433wiILB5ZN1rNa2slK72jRNtMxQPxoOpwItr9izSGG2iWUNc+wH94KBXeYTK+dxrhIpADUmTgiEfiUMHnBPOGkdWJh6mZ/qxoByMsHYJuLpfl8N7XSVsKPMulYpddfPOxvy1P4kF3pFLP4BV09vP9z/dtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYPcucvu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYPcucvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B05CC2BCB4;
	Mon,  4 May 2026 01:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777859220;
	bh=LISybazuiphZ0cqm05s0nNTtnkzBdC2nqyKFogowcyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYPcucvusnuc5wQGdLTQTBCtz/zPPDAYs9L3s+CHsjn7nA1YcwOHCiAUQjOgAiKhJ
	 l9JWNGAuvTt24GtAITaCHwn/myE1iJ8aSTrhqTHzAHSgwpKUHrUCqnu+npxPkkMQro
	 +d74GEqqWekX8HX0JkJ+Cg2C4EerRXpl0fbU2wV52s8sCBPgJCCu0Ess9dMFf70E0Z
	 TwIZLUIVCcPKIuojOLWVxh/r6yWFl7Y/yP0lTpvY3CVapgHeM0o5bDJcikuV6R2nzG
	 E777Wa5G11D1NXJSElD3CLKZr022Ia8w2QOszCpa/Bj9YD8k+WHukTnGORy/Bfc6pt
	 aA0naU+aW7Q+A==
Date: Sun, 3 May 2026 18:46:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V4 2/2] tools/perf: Add kernel-doc comment to
 auxtrace_record__init() function
Message-ID: <aff6kjIr-KL3Onuw@z2>
References: <20260502143237.23456-1-atrajeev@linux.ibm.com>
 <20260502143237.23456-2-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502143237.23456-2-atrajeev@linux.ibm.com>

Hello,

On Sat, May 02, 2026 at 08:02:37PM +0530, Athira Rajeev wrote:
> Add documentation comment describing the parameters
> and return code for auxtrace_record__init() in util/auxtrace.c
> 
> Using "struct evlist *evlist __maybe_unused", gives below
> warning with "scripts/kernel-doc".
> 
>  # ./scripts/kernel-doc -none tools/perf/util/auxtrace.c
>  Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'
>  Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'
> 
> Updated  parameter as "struct evlist __maybe_unused *evlist"
> With the change, there is no erros/warnings with kernel-doc

Hmm.. this is not what we used to have.  I'm not sure if we want to
update them all.  Maybe better to leave it for now.

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changelog:
> v3 -> v4:
> Addressed review comment from Sashiko:
> Update return value expectation for fail as
> non zero return err code.
> 
> v2 -> v3:
> Addressed review comment from Sashiko:
> Update return value expectation for success and fail
> correctly.
> 
>  tools/perf/util/auxtrace.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a224687ffbc1..9e11cf4299b8 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -896,8 +896,23 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
>  	return 0;
>  }
>  
> +/**
> + * auxtrace_record__init - Initialize an AUX area tracing record.
> + * @evlist: The list of events to check for AUX area tracing event.
> + * @err: Pointer to an integer to store return code.
> + *
> + * This function looks through the @evlist to determine which AUX area
> + * tracing hardware is being used and initializes the auxtrace_record
> + * structure.
> + *
> + * Return:
> + * a) A pointer to the struct auxtrace_record on success.

I think you should mention that the this function should set *err to
zero on success.

Thanks,
Namhyung


> + * b) NULL with @err = 0 if no AUX area tracing event is found/supported
> + *    (not considered an error).
> + * c) NULL with non-zero @err on actual auxtrace_record__init failure.
> + */
>  struct auxtrace_record *__weak
> -auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
> +auxtrace_record__init(struct evlist __maybe_unused *evlist, int *err)
>  {
>  	*err = 0;
>  	return NULL;
> -- 
> 2.47.3
> 
