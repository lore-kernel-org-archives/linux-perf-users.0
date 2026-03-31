Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195B30F7FA
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978996; cv=none; b=cceLWuITyP8Ef+JL5RFrq1Czkyrej/eqe9o5gFmB4aCusuRXpPRHIjYblH2Y4EMfJm0Jg8Ov/L0EM1fXwpTVjzs9h1UocaEAmObbHJhy/DTMunJu/luhmEl/4OJoO8ewiERFBLlMC31trjqMahtS+gsLutbuMOv8QsMsFV1TJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978996; c=relaxed/simple;
	bh=BA4fJi/uGZRbO+swLKTc/k6zNKY4yPRp0Vie0GkIi0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8snMFtcsSY/zEr+XdQ3+MZfu3n3lF4F+3JOMt9lNd3G3noSY7AAZr5+DbUW/+hyLBxIAJbSaqPN3y6b3OUz6XPJjubaOZzZqTaTWsh5lDH/8WOnXqidEexioINiq2i2laaj9gV0KYsSWyRyJgdFK1vYz8FA3XU3KD90xCeIdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ckJcFOdT; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ckJcFOdT"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271257ae53so6038624c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1774978992; x=1775583792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j9GhmvN1+aw1MZJsniSTJSaG6YjGwrtw4O+Ld1Fnto=;
        b=ckJcFOdThSn4KYTWDUgpjV2+4/bCuTnzBnlRkBEgqvQ9wXYAnkbf8MX9AG+EM76woM
         lTplETBQahLuTqMIm6rO3Im3vKdBvS47qsFV2sIeM/5ZtpeS8abRS8yRMWKZ78TXWH1c
         rZqwkydNEBHIc6lbrdFntAkFi8OweWsjIh7CwlpD0V8mbRsmjDV0o2XtI/9iPDtJAowt
         L6/3O2S0xDT3y9Mi+rXd9nykE7YbYYm0/TDaMSpcYBDrjPrJpSbLtDEy0alwr8lEdRYM
         4JArIo5tBYOhQVsMLgYhTfsaQxITeucS9YXEXlCJbovplaV+MXa7I5PUuXwMIiRZEJH6
         PmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978992; x=1775583792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j9GhmvN1+aw1MZJsniSTJSaG6YjGwrtw4O+Ld1Fnto=;
        b=DliWz/GI2FbcR3vX3i2y6e41HJopHVyIQtXQp+I5yllkQ+TqDLskr8S5rss1an9npP
         TFXiuyEt6UU+Arwr4ctSX7003CEfUSgFhZOjfxMY78ekKBhHcknpfQ+/HI4IBbEuuJIR
         ZME6IXHDVESPAqR3ABVus7FljAMDaGYgKMiDDmnbAmhwG67myYE2fGpJ5b3GRQIlbhgg
         LAPvFFmOc1WmXvGWRPIOEI6m8GnY0M3mJZchmHZBaFAVXCxFZ04OwhB8Pu3kO2hlOl83
         4PHZE3TADNY91mXbWVeZVYLK9Ui5TFDUmVR7G+zcvktFAcdTHTjTI2Hh6RCoshINgmhv
         SOLQ==
X-Gm-Message-State: AOJu0YxcKEUUXrqNayKkyHUdg7rskPlHeo6QzVOsfMcxUmzGKHVO04Br
	awZo8s4lUOFxxKxby/3UXBqLLRTl+7RyY1qGKe1Dd9MSy8Sa6iA+hWwDZLki6g2jXs0=
X-Gm-Gg: ATEYQzzBVKhx7xfTrqHRttEuY+8Q0KWVKdLhnJ/veg0pA34nA/iXI4mEQzOj4NgRdzQ
	LJLpsqbkOizcq1yDnXkHVpTIclKJE02WU1PfEHzk3rK7RP528nlk5ZLu9MmCAdwj4Q+c4d9qPmv
	tkON5iIVeiknyIsxDZhfhoLbA98xG9dMzKmOmdOiTRQbgjp3i2sf5hrZOW+vzxQ5tgqSutxiFEn
	+eIckw19j7pd1pkFJGhAQIj9znjHL0Z+Vb1GIcy+jWFzQ9pvnc/kNP1r29FvPjWDUWU5y7LYFrX
	HW5/rBUUiETH+T1LclRVFr7gSM+fWjzSGzpqkTusCoql4dUAEBrvrniOXam9PMLls5Jh2LX27RJ
	nqDIP+QHgB7hCxLFr4ZveDch0FHr1XfS+1gO2ffkw79jYqdkMzt8p1H47b3/qdkeRTyRlrzzZAZ
	+ODj20/+/DhfL2kvSqwPX64dCcWQ==
X-Received: by 2002:a05:7022:6987:b0:128:ca83:5aa1 with SMTP id a92af1059eb24-12be649ca84mr230940c88.16.1774978992473;
        Tue, 31 Mar 2026 10:43:12 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:36de:b209:4884:3260])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f904sm15641070c88.9.2026.03.31.10.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:43:11 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:43:09 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] perf: Don't throttle based on NMI watchdog events
Message-ID: <acwHrbpnLxM_G9Vg@mozart.vkv.me>
References: <cover.1774969692.git.calvin@wbinvd.org>
 <685061daed5b505ef604835b602e0202531f2315.1774969692.git.calvin@wbinvd.org>
 <acwC2R63DVoZVf-l@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acwC2R63DVoZVf-l@mozart.vkv.me>

On Tuesday 03/31 at 10:22 -0700, Calvin Owens wrote:
> On Tuesday 03/31 at 08:25 -0700, Calvin Owens wrote:
> > @@ -663,6 +666,17 @@ void perf_sample_event_took(u64 sample_len_ns)
> >  	if (avg_len <= max_len)
> >  		return;
> >  
> > +	/*
> > +	 * Very infrequent events like the perf counter hard watchdog
> > +	 * can trigger spurious throttling: skip throttling if the prior
> > +	 * NMI got here more than one second before this NMI began.
> > +	 */
> > +	now = local_clock();
> > +	delta = now - __this_cpu_read(last_throttle_clock);
> > +	__this_cpu_write(last_throttle_clock, now);
> > +	if (delta - sample_len_ns > NSEC_PER_SEC)
> > +		return;

Apologies for replying twice in a row...

Sashiko made a second useful observation:

>> There appears to be no upper bound on sample_len_ns itself. If an
>> event takes 5 seconds to run but is configured to fire only once every
>> 7 seconds, the idle time will be 2 seconds.
>>
>> Because 2 seconds is > NSEC_PER_SEC, the throttling logic is skipped
>> entirely. This defeats the sysctl_perf_cpu_time_max_percent safeguard
>> and allows an event to monopolize the CPU in NMI/IRQ context for
>> seconds at a time without ever being throttled.

I'm skeptical that would ever actually happen, but I think I can address
that by adding:

	&& sample_len_ns < NSEC_PER_SEC

...to the skip throttle condition?

In fairness to the LLM skeptics, the feedback Sashiko gave on patch 1/2
is absolute nonsense.

Thanks,
Calvin
