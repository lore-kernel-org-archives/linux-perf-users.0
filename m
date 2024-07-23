Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442713D8A6;
	Tue, 23 Jul 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761593; cv=none; b=Atsruf6JNKC7qTQQcUATcCwE8oO8+j3Ho1pLY83Kl6MGp5SM/PkItACbuRXqhwmPOYZR1kx7zSqijK8RvQ9+50w+1yMyN5B4iAITuokCWRGJMOqpg1LQTLby4MPmMidRsUpdC2npTV4wTOAAWaiRChtpNilVZKN3Nm3aPazZFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761593; c=relaxed/simple;
	bh=xiYMNWn8JlLWS3DfL01faTKN/kkK4A4D49NBKXMEX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZviS6NUrk6zW5f0N+NqKhZiSl4QeSU1Q01tjJBJebcvsZPpEklKtaz9xzZLphDWXV9NAbctSPGIb/fxeBg9i0BKamNJkBlFdieLVt/tPTFLO5iYiTrDX1w07DXQzouV2w72PNM1A63YV/JDlFjEvYOlTqfkEOVg66X2bguff8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWsaQANQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWsaQANQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5272C4AF0A;
	Tue, 23 Jul 2024 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721761593;
	bh=xiYMNWn8JlLWS3DfL01faTKN/kkK4A4D49NBKXMEX0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWsaQANQXqgd9H/SEld413kB6v4lV5qlVuVVbYdLU8Mu4l82vIR6V9gkE8eX2RwYt
	 eysRQw27UKGfmZECgtpQHn3d0kHXRwBD30A1di8iMPwjch0J4o8Ie2Ulqp3G8umPcI
	 ZjygMxDx85X0IawV4aMjWd/EpvMMHrLH3BjUErXs4LsKXd5B+WzKo4FV7Edlx7F9Tb
	 li/rxFgdxBjCs9Z9yU1UcOAVstFRbBei6RXXQdg12eDLZiCZivQfjWEyLkYZSMgLSV
	 N/ItHiqka+KMHivM2nciZfChoizjSgxPsczHQhsDW3S08z9OBH7zFrMpQn04rt4iqb
	 IbrMzqvz76FCw==
Date: Tue, 23 Jul 2024 16:06:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
	namhyung@kernel.org, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V8 03/15] tools/perf: Update TYPE_STATE_MAX_REGS to
 include max of regs in powerpc
Message-ID: <Zp__NN2SrLvqn423@x1>
References: <20240718084358.72242-1-atrajeev@linux.vnet.ibm.com>
 <20240718084358.72242-4-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718084358.72242-4-atrajeev@linux.vnet.ibm.com>

On Thu, Jul 18, 2024 at 02:13:46PM +0530, Athira Rajeev wrote:
> TYPE_STATE_MAX_REGS is arch-dependent. Currently this is defined
> to be 16. While checking if reg is valid using has_reg_type,
> max value is checked using TYPE_STATE_MAX_REGS value. Define
> this conditionally for powerpc.

So what would happen if I get a perf.data file on a powerpc system and
then try to do data-type profiling on a x86 system?

I'm processing this now, but please consider fixing this up in some
other fashion, I think we have support for collecting registers in a way
that perf.data has all that is needed for us to print them in a cross
arch way, no?

I see there is the FIXME there, ok.

- Arnaldo
 
> Reviewed-and-tested-by: Kajol Jain <kjain@linux.ibm.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/annotate-data.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 6fe8ee8b8410..992b7ce4bd11 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -189,7 +189,11 @@ struct type_state_stack {
>  };
>  
>  /* FIXME: This should be arch-dependent */
> +#ifdef __powerpc__
> +#define TYPE_STATE_MAX_REGS  32
> +#else
>  #define TYPE_STATE_MAX_REGS  16
> +#endif
>  
>  /*
>   * State table to maintain type info in each register and stack location.
> -- 
> 2.43.0
