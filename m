Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3273E3C4D;
	Thu, 24 Sep 2026 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288639; cv=none; b=lUCqgM6p24nYJKyLqzBf85DXGPaIk2yLoVs+Lgpurwm9831wa1y5uxZiAzEryM5C/RfYL5KwmRvffpfTXUEMc06IZRR3lFjTC4Un0j0HrOTmmGOfUDTBHWsmqspQkKtW4Tci18so+IuFn3+k2u8dzkrLBiopZ5Zwdir5UjArPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288639; c=relaxed/simple;
	bh=GvXJcrx5hEkH522u9IqRx1VeyoDbbrISSaRKA1saxlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUw6gLPEgIE6+3HVkQ9JjUVDt93iu4frpMafU6T4hCmRKyKY0/lgrGQ3liCr23+NcmIJi4Ut0PPDZn/pUSbGhBdCeirVulEHy2SvPA40bDdof9NZRrEDE3PQ3jcxR+kfjFVvW0Hjin3FMCuD4/dLwxNMsBXLld+yMmI1SnSlnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcuIf8tI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcuIf8tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E74A1F000FF;
	Thu, 24 Sep 2026 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790288638;
	bh=7qJWCS5Hq9un6OGBq9ROfEsRpqya9OZTfQ/7XPK3XXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YcuIf8tIoU7Vsd3QHBLc7+M5r+ITmg5uX5N0WaC7q4NHbLUfGejNR1yAejZnIdToG
	 9dP0jeChAV75MMRHOVpwO+Gi/Q2Hlk1k4zEOWvJB79Y1AlsV7fJdNIGw9McYsjyZXG
	 6HpQ4e59HFq2UxnYXuA1Gjc+H1zMY+ITB42Ivob0cvOfCPROChY23RfvqZjiG4o29a
	 EMvMBKg+XdBR/b1P8Ls+ajOKjwpQsnccVmcx1EtBsvw/WpNz5nKNqVONB0XCjnJoJO
	 fkBAGnZO/gTuwLeghob17txLlmyQ1ubTFziVSwII75fXt15WI5ZKKIpnV4UxXxhNU1
	 X0aegOyVlXcsg==
Date: Thu, 24 Sep 2026 15:23:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Christian Melendez <chrismelnu@gmail.com>
Cc: acme@kernel.org, irogers@google.com, jolsa@kernel.org,
	peterz@infradead.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf stat: document task-clock/cpu-clock in TIMINGS
Message-ID: <arWi_dY4y15J2rqh@google.com>
References: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
 <20260923135140.386033-1-chrismelnu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923135140.386033-1-chrismelnu@gmail.com>

Hello,

On Wed, Sep 23, 2026 at 03:51:40PM +0200, Christian Melendez wrote:
> task-clock/cpu-clock appear in perf stat's own example output but
> were never explained in perf-stat.txt, unlike time elapsed/user/sys.
> This came up unanswered on the list in 2013 and 2015 without docs
> ever being added.
> 
> Link: https://patch.msgid.link/CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com
> Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index f334aabdc809..c0d6c344f9eb 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -621,6 +621,16 @@ user/system lands:
>  
>  Those times are the very same as displayed by the 'time' tool.
>  
> +We also display a clock-based timing metric that depends on the
> +target being monitored:
> +
> +        83723.452481      task-clock:u (msec)       #    1.004 CPUs utilized

I'm afraid task-clock and any other software events don't support
privilege filters or modifiers.  So task-clock:u would be same as
task-clock, but it can give a wrong idea that it only measured time
in userspace.

Maybe the kernel can reject ones with modifiers but then it would have
a compatibility issue. :(

So I think it's better to remove the ":u" modifier in the example
output.  Probably we need to change the perf not to add it to the
software events.

Thanks,
Namhyung

> +
> +For a single task, task-clock reports a clock count specific to that
> +task. When the target is a CPU or the whole system (-a or -C),
> +cpu-clock is reported instead. cpu-clock is a high-resolution per-CPU
> +timer. See perf_event_open(2) for more details.
> +
>  CSV FORMAT
>  ----------
>  
> @@ -671,4 +681,4 @@ that can be used for parsing.
>  
>  SEE ALSO
>  --------
> -linkperf:perf-top[1], linkperf:perf-list[1]
> +linkperf:perf-top[1], linkperf:perf-list[1], perf_event_open(2)
> -- 
> 2.34.1
> 
