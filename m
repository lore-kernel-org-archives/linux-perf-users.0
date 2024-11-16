Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E019149F;
	Sat, 16 Nov 2024 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731787769; cv=none; b=UOU+fi0kjd/e+mWBl2X9YS+bhi3e22GUtvIAdKsG9d6WTJ0iFirNauNiTE8bQpXBqEQ0GqoJTxgqaDOMZx8oNdSlGu6DgknsYXyweSQOobWsXeo6bUG5nhq/flqoeBvKmTQZ5gQaKdgnbdNO7ogR+SRDnnqotnv76m62FQkBocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731787769; c=relaxed/simple;
	bh=EnDPT6WuZjZWhkGYK7MIA5R6RS0kXLMm3spyK1Tdy8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw6tS3ZGR/pl77te2oUufKwhFLSF103dtBwO1a74LlEFBE/u2ulxlsOLapoOxtA3V9RHduOJwDsXvEGzQmPqsFcIlvJS99pcFkUGXQocJL92d9Ip2czrF44pSWzakVYF85+iPA9Kn7bgB+riw3NhJTBoPviwF9WVRVx7ksJhzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppsnoeYn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppsnoeYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3CAC4CEC3;
	Sat, 16 Nov 2024 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731787768;
	bh=EnDPT6WuZjZWhkGYK7MIA5R6RS0kXLMm3spyK1Tdy8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppsnoeYnJaqRSFLLz8hQh7W0reMFDtPaEg7UkKtA13SXUiFileV2X/5/yCdyRSEV/
	 t+impEGDfOOK1V7LFv+Krxhbldc0kjDtM3rKrUGmIgxinS2kpBnNYEMsA+K77Ejrgc
	 KdCcnnHn5Q3N/TzRUtq6PadaXWJc6p9HlIUtSaojyUnFMm11qxHrznYlx9hxE2z/Kp
	 2PecLtuyEDJ6pOuAchtN0C3aztdy6txEkPKhoG+rMRK4bztlF1lldGgFMrf1QLLpOu
	 TVYPdkLyHT4RKD9GKpbR8TvBTzSY/ISCA1G3f5w7HY2o32dt1C7i38U+F3ja4i1T8s
	 1V3f5tphwbeuw==
Date: Sat, 16 Nov 2024 17:09:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Remove kernel version deadcode
Message-ID: <Zzj79IHk9ylwvfiJ@x1>
References: <20241116155850.113129-1-linux@treblig.org>
 <CAP-5=fXqig=qHAa26d5-8pHPCtS0ZyCNs4FJGr4c4BSjFe+-eg@mail.gmail.com>
 <ZzjxxCnicVIwAF5N@x1>
 <Zzj3y2BN_GcnRKbK@gallifrey>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzj3y2BN_GcnRKbK@gallifrey>

On Sat, Nov 16, 2024 at 07:51:39PM +0000, Dr. David Alan Gilbert wrote:
> * Arnaldo Carvalho de Melo (acme@kernel.org) wrote:
> > Thanks, applied to perf-tools-next,
 
> Thanks!
> Have you got:
>   [PATCH] perf: Remove unused del_perf_probe_events
>   https://lore.kernel.org/all/20241022002940.302946-1-linux@treblig.org/
 
> from a few weeks back in there?   I don't think I've had an email
> response to that one.

Done now and pushed out, thanks for cleaning up the perf tools codebase!

- Arnaldo
