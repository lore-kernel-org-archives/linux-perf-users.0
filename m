Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B51CEAD1;
	Thu, 10 Oct 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577154; cv=none; b=lTuiDVsc5pMj0Zr2gVVmTkUSX8g6tDKuSVx5R0ZOtnlXPjIeZclUhZr0bHPfkVwOJlS+Fg3DDIc/aHtkMjnghgSO3Emlf+epCmlOopBP2tKvtZjby7QlKnKi9u4dIa4hKzveAd5vINC2vrjTyBZ6n3FTzaLkg7PhI2X45xCmQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577154; c=relaxed/simple;
	bh=INOkDDFlgJ6TC0aQKZL0IPFP1XX9/IB7FfK5TqUkrgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2OCLPKiRVtQu/2rzCJcy80u7VWV+tIjMoonjicbwuhaq3OfwiKCtjd27SvstinjRIystMejJxQW/NB5XW1OFfUP5ld0xVIva6iThPkHfvolXjprprSgkz9RnYJnehjqS03yaZTy2Gy1yL0Ols4zkvTEgCi0A/N0/mOfaVr+Rok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ3MIr5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ3MIr5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD65C4CECF;
	Thu, 10 Oct 2024 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577154;
	bh=INOkDDFlgJ6TC0aQKZL0IPFP1XX9/IB7FfK5TqUkrgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZ3MIr5Ggg8MsJMyUOVhqIPIjkeJrIqPCBmVUrnnUHC7bq9WznUcREmCAlgDl0Zp7
	 XrmBhbVzbC+8aQGMs4yPfYh7y3pKsPSBkAP1fzmdOJF3AGBMiMuDglRqtFzfLm2UJ8
	 e9VxMQDFX9eHjx5Shn0J7mxfPeC30mryjl6rLpMBMilqVo6t+tociG87gzFQiAdn48
	 X1ut+DDcDH5HiW0sCV3SNF3z0RpqQybuHLxkMI02+flIsxA+vN2rQs8ZUNubjZ9qyE
	 MEofC+YfS3T5wYis28Ylyr5aZVSf2GxUKvC7mEM09W74pIRsX4hUlHF/Yt6XgbMHrQ
	 sc7sNwfDwxXSg==
Date: Thu, 10 Oct 2024 09:19:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <Zwf-gHW-cEGB3iyw@google.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
 <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1>
 <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <271cde84-26f5-4e51-8cf4-2aa45a220025@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <271cde84-26f5-4e51-8cf4-2aa45a220025@kernel.org>

On Thu, Oct 10, 2024 at 10:11:47AM +0200, Jiri Slaby wrote:
> On 09. 10. 24, 7:57, Namhyung Kim wrote:
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> > index 7c15dec6900d8aaa..b7465a879d8bf416 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
> >   #include <asm/syscalls.c>
> >   const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
> >   static const char *const *syscalltbl_native = syscalltbl_loongarch;
> > +#else
> > +const int syscalltbl_native_max_id = 1;
> > +static const char *const syscalltbl_native[] = {
> > +       [0] = "unknown",
> > +};
> 
> Hi,
> 
> provided the error was:
> undefined reference to `syscalltbl__id_at_idx'
> 
> this cannot help on its own, obviously.
 
Oops, I was looking at a different one for some reason.

Thanks,
Namhyung

