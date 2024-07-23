Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4313B599
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747383; cv=none; b=khJIRV5TndJ6J+opOny6pE6VRt8jwk8IHrD22FpJ8BjibnHraIvw0qO1BddE/cUH3IgFG/CbUZS/JgzGMcvh+kgIJTNrbwdPyaNiLnCQCZr/X8Y6BIoNz/sq7Tobs9741zUypK9tBk5ROaqW1YTRPmeNAPqbX8f5h0pab/sokqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747383; c=relaxed/simple;
	bh=5G031YT9XT7YFHSEVlrz3bOBO8dw7jLrIIxZwVn0yig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar8ZrZPdRmZGF7uMIqaHT+F/ANXitd+o56zvsbJ4WaDDMBaxn3hyz3aljf7IAXnUgcz1u4fW+FgZoYUihiteSipkc7MZSEqmHeZwkdoXBFi/1m/m+kDITOJGO/NqfmAVKLIHkuVveYYVeStX/k2mgHyo7JelrQ/BX56d8a849Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rg9uC+d9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rg9uC+d9"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a03ada9660so10099a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721747381; x=1722352181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OHtmeHUkZa9VAmNWyZWAYgFfFLiZeJu3qEKndF9+/HI=;
        b=rg9uC+d9MWr8Liv++wCPYW+rM9wyI8Nx/7/3Bt7FpCa1jGvmR3Ldsa5j6iAOKzStZL
         AUdirQWbVcoGV5RPOIijsFzoSDHeAGZBwh/fVqR0qAczxeURKgOzl1O+0pKnPuxLLRj4
         +ueVN3QlIuo80PLoEvYtUMmDhmb4vVBGBydIojhkIZucdDNbCPWDFpi3Eb8cLt4cr0hu
         cSJNCg2MVs/9yi+BOJ2hF0J23MvQkwCbLt4oCV9y76v6J8E/eUYJrJ3mPB86QCWYMFR6
         pGnzf3ep/Abqw5+Eh/O5CuQfh8haiQJmUENANoSM3UJ/j6cxXnmOztaNL6xuSw5PSQ5W
         5peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747381; x=1722352181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHtmeHUkZa9VAmNWyZWAYgFfFLiZeJu3qEKndF9+/HI=;
        b=IHs10Mm+6ZJjixJPgJim2ulE7fK6tU7SREasxhcXo9HamIJTb02lwVZsLvuuafPqMn
         2ljUtHQZ9czIHQhMRjW40Ya7Wq8leCwqS32h2/WUmX3WTzptCq6rYjQle+boyPJGJEYs
         LC9cAJ4WmeUn7xIOvAwDy3bWHnN1edeDUBYLdcRl+bjojf3kDPDSq/6/mpX8XhKF0JLQ
         BGq+e88dZ4M/s7gfvSMN0YudCDhC8lT8jjl3jfa9K2iXEPvs6yOEErQzIvKnDZpLn3MG
         V25ILOoW66AHra6UN2UIjAhV8MeBeoBwL2t+S1SksDU+8QjQJD3ZPHk0IDLn5hqrxvg4
         xHVg==
X-Forwarded-Encrypted: i=1; AJvYcCWuTVJ18sPTP0nZ5l6hplvj+arazluSnu6GRXxbrSSD3lOJQR4TKqnLjtqh/DCiw5R/AcJ2nWz0182oAhX0kQ8aEIM85jtLiq4kkYIp3v7bcQ==
X-Gm-Message-State: AOJu0YxdOshBxeXoFxYug7E9aQiLfkTxT0lJSZWf54lydV9Es54LCbi5
	jxhSvK0fEv2hmUgTflqcpkb5po71oPhzbQMSqUBF8WT95bBE5VWCGSRGDFnyPCm5sUg7IyVYFF0
	DfQlLBHVrdfMNxJntkpPIi/7i/RiKHAIq3RXIbg==
X-Google-Smtp-Source: AGHT+IHh4f5ljYPfeqEzD+jOmwYWcdYXnMSSP6kzzoIGBrszeKVncWzDok/la26tdtDvUhOhPZhyGhGQ33wdS+mt58k=
X-Received: by 2002:a17:90b:812:b0:2c9:7e9d:8424 with SMTP id
 98e67ed59e1d1-2cd274f029cmr6446161a91.30.1721747380680; Tue, 23 Jul 2024
 08:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722152756.59453-1-james.clark@linaro.org> <20240722152756.59453-2-james.clark@linaro.org>
In-Reply-To: <20240722152756.59453-2-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 23 Jul 2024 16:09:29 +0100
Message-ID: <CAJ9a7VhLx0Zi0e-1qzcGCUWArkeD7vDkv0ewueDE_pYbmm5PVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf cs-etm: Output 0 instead of 0xdeadbeef when
 exception packets are flushed
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com, 
	leo.yan@arm.com, suzuki.poulose@arm.com, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 16:28, James Clark <james.clark@linaro.org> wrote:
>
> Normally exception packets don't directly output a branch sample, but
> if they're the last record in a buffer then they will. Because they
> don't have addresses set we'll see the placeholder value
> CS_ETM_INVAL_ADDR (0xdeadbeef) in the output.
>
> Since commit 6035b6804bdf ("perf cs-etm: Support dummy address value for
> CS_ETM_TRACE_ON packet") we've used 0 as an externally visible "not set"
> address value. For consistency reasons and to not make exceptions look
> like an error, change them to use 0 too.
>
> This is particularly visible when doing userspace only tracing because
> trace is disabled when jumping to the kernel, causing the flush and then
> forcing the last exception packet to be emitted as a branch. With kernel
> trace included, there is no flush so exception packets don't generate
> samples until the next range packet and they'll pick up the correct
> address.
>
> Before:
>
>   $ perf record -e cs_etm//u -- stress -i 1 -t 1
>   $ perf script -F comm,ip,addr,flags
>
>   stress   syscall                    ffffb7eedbc0 => deadbeefdeadbeef
>   stress   syscall                    ffffb7f14a14 => deadbeefdeadbeef
>   stress   syscall                    ffffb7eedbc0 => deadbeefdeadbeef
>
> After:
>
>   stress   syscall                    ffffb7eedbc0 =>                0
>   stress   syscall                    ffffb7f14a14 =>                0
>   stress   syscall                    ffffb7eedbc0 =>                0
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5e9fbcfad7d4..d3e9c64d17d4 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1267,8 +1267,12 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>  {
> -       /* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> -       if (packet->sample_type == CS_ETM_DISCONTINUITY)
> +       /*
> +        * Return 0 for packets that have no addresses so that CS_ETM_INVAL_ADDR doesn't
> +        * appear in samples.
> +        */
> +       if (packet->sample_type == CS_ETM_DISCONTINUITY ||
> +           packet->sample_type == CS_ETM_EXCEPTION)
>                 return 0;
>
>         return packet->start_addr;
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
