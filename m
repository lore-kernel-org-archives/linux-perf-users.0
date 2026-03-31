Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17540242B
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991240; cv=none; b=A/9f4by6YaK1eeXqesNE3nAwivOPgtgDCRGC0aIWwqnNnN2g+4PmSmwDzv8FF3dm05cyN9L8jGdhiQhk9BIqiGWxfXp1vzlAkxC7QtFpSb9AcVOJ79TD2wEHorz8XRzCd9BFGtqpRHKo5CmrY3WNPo3PUCinP5raBeIqIBhXTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991240; c=relaxed/simple;
	bh=srX1l39ZNqbpWe/rBuYTeFCJspgS6uYAA5Yoci/p+sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdiKhBr//483sJb9cjG7PxBLGxC8FC0Z9chkDwi9624P+wRLnJQfqMOQV5w+E/tvyONckgEstHULQ4Be0jsLfuzOzu+zZ7ngQ8KenibV3fxA4vzVTf7SoOtD18+kDq68dz0tA9ryOV2L/Tlj+epX9Mk1ifayd+/XPduPcgcBK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=EREuisHD; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="EREuisHD"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12713e56abdso248317c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1774991237; x=1775596037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEPEtODverNK1O8yO0IUrRWlf+6nHsXJel1SUIN5uN0=;
        b=EREuisHD+FMCzeoZRlBH52otFjJKOI/I4+v6a7tPtEHTvPLRfwVpJjgcdV4GCfltDY
         Ozc5mdKBRLHgymwGct7c8W8O56tw31Jn3UEQwyRRtallIcQKMSqXa9EiTjTIAuwkRweK
         Sq+5/1EWxMDqp8ZTDbriKOR7uFvQoPZ9AZJnsIvHQSWTd2hUx9I0MWtlClPDbXV7W1KZ
         k62DglyU2XThJ/oDjfvE3hb0uLmcTD8fgvAmRx3b74ovQT5tBtA0vt9NQCiGtMbblqkx
         rYncTol8/cM9wx91k00zoea3m6e8xTMVKMv0SqJpyufXVDVxHPyW6xE8r8BoRIwndVMv
         sZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991237; x=1775596037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEPEtODverNK1O8yO0IUrRWlf+6nHsXJel1SUIN5uN0=;
        b=C97nvKkz91GHNlmN9kz6ZvMuOMY00SAgNqSjOysT09fIOUZX9srJzKscYxIdgZ8mc8
         adxt8PJflIWOg29e1j42GAeo3471tMBr+O8gKlvmDnzbrd7fC+h+fsys48Wb8ILY/Gls
         9MqP2HScBGZIXxUS34Ws6QSULFujV6OzWfmMb3cjR/4OBM0IXpz3JYB0OE3h42Rya8sF
         ZNlxVinc1NxH/8aCu2PiyqTCBsoaSh0ao3qnBHX+SOSioFZx02ZWzU/+Bs3D7xLUo1b5
         xg9B+FJEnqUZUCm3bMjApNUuZ/G6Ngth6PMgJIdIT50cbVt5Vi8ntzxNbaPwKF7tzi2V
         jsBw==
X-Gm-Message-State: AOJu0YyMfqnLs+JmHFDptcv+ZT+ZYf9cdXfWa+qfX+FH0UI+OxF0wo18
	5mNCEE/Oqx2bUg2jpVI1n5CbyyZiwyL4ihsKyCNy0gUhUgRMeWbJi7Z65KmhigFadro=
X-Gm-Gg: ATEYQzyvTBHf07E0hjFPsIOcGv5dvX799ugKybgY8eRBMKC8rpKgw5WOQHrPVO2EPNV
	a1UoCelQ+LgSZefjiIucAe2jF4H/HFrW+gZPrSZRHsCl2VXdH5OTE2Rfkkbc21j3MlW77nrcQer
	G8Do1gMGiZwXOhuEiC7vPaknysjIu5XD4WBU95kyRJCgN3KGAcutMDF2KBXnldI7gevbJzWwVBO
	p/cFoe5mid4JxDsujHEINZVtM4qt1Y0ZDXMCVyAY8exlm87UHBIw23xzEvhW7k0GkPifIKmtRUC
	W4mHEDX64Rusgz9BQlb7yAEl4tjXEBSSB93OZSjLUpWw64bnVNk5v6+951n1H2u4A5h56jGNmB3
	5jl4lqKR/Uj22/OfVa2OshHTlho/2poKhVH02dqPtBJD4K8fun6RRbFYu7V52261UpHvkPUXtwm
	iDowlPwIHBifU21VL2nchtRwUCbA==
X-Received: by 2002:a05:7022:238d:b0:119:e569:f86d with SMTP id a92af1059eb24-12be6822c08mr476882c88.10.1774991236898;
        Tue, 31 Mar 2026 14:07:16 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:28be:dd98:ce3b:beaf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm16758092c88.7.2026.03.31.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:07:16 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:07:13 -0700
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
Message-ID: <acw3gWcNRgw_nWNv@mozart.vkv.me>
References: <cover.1774969692.git.calvin@wbinvd.org>
 <685061daed5b505ef604835b602e0202531f2315.1774969692.git.calvin@wbinvd.org>
 <acwC2R63DVoZVf-l@mozart.vkv.me>
 <acwOMB74ZwvuQyRC@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acwOMB74ZwvuQyRC@mozart.vkv.me>

On Tuesday 03/31 at 11:10 -0700, Calvin Owens wrote:
> On Tuesday 03/31 at 10:22 -0700, Calvin Owens wrote:
> > On Tuesday 03/31 at 08:25 -0700, Calvin Owens wrote:
> > > @@ -663,6 +666,17 @@ void perf_sample_event_took(u64 sample_len_ns)
> > >  	if (avg_len <= max_len)
> > >  		return;
> > >  
> > > +	/*
> > > +	 * Very infrequent events like the perf counter hard watchdog
> > > +	 * can trigger spurious throttling: skip throttling if the prior
> > > +	 * NMI got here more than one second before this NMI began.
> > > +	 */
> > > +	now = local_clock();
> > > +	delta = now - __this_cpu_read(last_throttle_clock);
> > > +	__this_cpu_write(last_throttle_clock, now);
> > > +	if (delta - sample_len_ns > NSEC_PER_SEC)
> > > +		return;
> > 
> > Bah, Sashiko caught something obvious I missed:
> > 
> > https://sashiko.dev/#/patchset/cover.1774969692.git.calvin%40wbinvd.org
> > 
> > >> When the outer handler completes, its sample_len_ns (total execution
> > >> time) will be strictly greater than delta (time since the inner
> > >> handler finished).  This guarantees delta < sample_len_ns, causing the
> > >> subtraction to underflow to a massive positive value.
> > >>
> > >> The condition > NSEC_PER_SEC will then evaluate to true, and the outer
> > >> handler will erroneously skip the perf throttling logic. Should this
> > >> check be rewritten to avoid subtraction, perhaps by using if (delta >
> > >> sample_len_ns + NSEC_PER_SEC)?
> > 
> > The solution it proposed makes sense to me.
> 
> I replied too quickly: I think Sashiko is actually wrong.

Last time, I swear to god. I worked this out, it is indeed correct.

The relevant RMW is:

	now = local_clock()
	delta = now = last_throttle_clock;
	last_throttle_clock = now

Assume last_throttle_clock starts at zero.

Normal case:

	NMI >>> sample_len_ns=1000ns
		now = 1010
		delta = 1010
		last_throttle_clock = 1010
		(1010 - 0 >_NSEC_PER_SEC) == false

Nesting case 1:

	NMI >>> sample_len_ns=1000ns
		now = 1010
		NMI >>> sample_len_ns=1000ns
			now = 2020
			delta = 2020;
			last_throttle_clock = 2020
			(2020 - 0 > NSEC_PER_SEC) == false
			// does not skip throttle
		delta = *underflow*
		last_throttle_clock = 1010
		(1010 - *underflow* > NSEC_PER_SEC) == true
		// skips throttle

Nesting case 2:

	NMI >>> sample_len_ns=1000ns
		now = 1010
		delta = 1010
		NMI >>> sample_len_ns=1000ns
			now = 2020
			delta = 2020
			last_throttle_clock = 2020
			(2020 - 0 > NSEC_PER_SEC) == false
			// does not skip throttle
		last_throttle_clock = 1010
		(1010 - 1000 > NSEC_PER_SEC) == true
		// skips throttle

I think the below deals with it. But I will wait to hear back before
sending a V2.

Thanks,
Calvin

---
 kernel/events/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89b40e439717..c51d61fbb03b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -623,6 +623,7 @@ core_initcall(init_events_core_sysctls);
  */
 #define NR_ACCUMULATED_SAMPLES 128
 static DEFINE_PER_CPU(u64, running_sample_length);
+static DEFINE_PER_CPU(u64, last_throttle_clock);
 
 static u64 __report_avg;
 static u64 __report_allowed;
@@ -643,6 +644,8 @@ void perf_sample_event_took(u64 sample_len_ns)
 	u64 max_len = READ_ONCE(perf_sample_allowed_ns);
 	u64 running_len;
 	u64 avg_len;
+	u64 last;
+	u64 now;
 	u32 max;
 
 	if (max_len == 0)
@@ -663,6 +666,18 @@ void perf_sample_event_took(u64 sample_len_ns)
 	if (avg_len <= max_len)
 		return;
 
+	/*
+	 * Very infrequent events like the perf counter hard watchdog
+	 * can trigger spurious throttling: skip throttling if the prior
+	 * NMI got here more than one second before this NMI began. But
+	 * if NMIs are nesting, never skip throttling.
+	 */
+	now = local_clock();
+	last = __this_cpu_read(last_throttle_clock);
+	if (this_cpu_try_cmpxchg(last_throttle_clock, last, now) &&
+	    now - last > NSEC_PER_SEC)
+		return;
+
 	__report_avg = avg_len;
 	__report_allowed = max_len;
 
-- 
2.47.3

