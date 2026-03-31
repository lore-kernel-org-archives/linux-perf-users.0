Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EC43CEDB
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980661; cv=none; b=Jd5nyzUj0ivLOuUb9IQdUoJmToesUDkO4RHESkAUv1t29lkBTwckT+hnO8XJFXCNukx15HGEgO55MH3wwXhCbp3ns4xJemI843+FVwQdz+HDlAmYBbxrFnV/hBgSOG56nAc/YOyk80E1NIPQ919NjbMnrtXFj/rrPpTcm7uTdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980661; c=relaxed/simple;
	bh=EwPuWU0xZA73peF5qoUgJuri+8cLwRR7kQwVKdYbfm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=truKX39YZEFC7clfCO/psPbMUAy5Ifu8E2W2hhFiRnHPoh7e52Bst7+Tz9wBq54JBNTzQkttIJH7GJGUE3BBgQZOOs3dGVHXP5/7llE07HZq6oZ6BKeex4/jLp8JLv7sEjG4pRVtaChqyrMNprztHmDxrpyrUrQmfCmrG3elc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=LYTQCoBq; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="LYTQCoBq"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so11666148eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1774980660; x=1775585460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkIAMUPZY84q092krccwnnsiBEiT1ZKWhmADyhwjHC8=;
        b=LYTQCoBqabEEv4XfrkICSHQ9sF+nV+1TRAIRqmAcSgDsnQ3T3cdnF6Y+FQnik1pkNl
         0O6LJqmL0QXJeq0A9TU+eoIvo9FTV768mMiNtrA5g3g6EgUc8ynSwGHi8kIJzhZPu41E
         EKHF+8W+vDBSZnKvSpxDD3HfARaXS9CoJgMzkB6qT4iA/UaAipFpb36dy9moCTtsuSJ8
         svUJ7Tf6xwUcR72C/heKXzx3f4usGxtmjZ6k3xByoFNmEcQyfqx9oJj97hcDREDlZgZA
         Rf+pZcGSicpRz0Kuo1vBO4QdS1RmEW0+s5GxMfuEdzSSETFJc5GFhSBFdku1Xw/zLkqc
         mvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980660; x=1775585460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkIAMUPZY84q092krccwnnsiBEiT1ZKWhmADyhwjHC8=;
        b=J/fXYQtVCPDrBOivsm12zu2E8mTdAWElo06145rmI6rM6A3A3NvUKSoaUnqAEdJasq
         fEYSUj1F5d0TpjdJ4MF3DDRZ8w3560sZU3VM/zPWjCRklcLeSReje1ik5SpVdkuly1uj
         BsBQ0pHrW+R5MFxkQmN2TX+41yZZL6KNarRT97uA1aGOkgPMXsVdNbvzw8HrU8TgSt9M
         Nj5Z8NyRJ29Wn7w1tUVLSFmYLAE+GUX/G9qBn81g+8FdT/NXyLWCXNFAe/DYmfKTJ0Qi
         A1ukdl8pmxv+PO/6n7kzl2aQHnH6KBOgCXmPdX2JoD/qUCYR4T3nPDNz0NIZ+LfnJB0Q
         lyow==
X-Gm-Message-State: AOJu0YxNPeUOGB7q5LwITRobbGndwgFXxoeXQKRdoTy2uz9oUhRmoxQd
	CCXc7J5XIWL+fgo6PCa1ZimEmzw7EAcnXp2vzYPP1o2CCZXqvHyCi9BVxC57LTUw0Vc=
X-Gm-Gg: ATEYQzz5gMvQJmdFRshSqY0uftrYyLR1dYlnVCe+1VqtqJJICJl7WpKqOdqzVaLiuiq
	n11pgIBcMZvqUQNsPJRHlZLezZeQ+fNqGix9W/+hJndZ34Pr7rkl+mXzT3y3hZOHLjtXxsDtZ+Z
	YWexALvon0yD78loOmpaYzWwrFdPo29G8BYPMnzjHHj68qObrJRW5hys0J0MH+vKnsUjVZmTfp5
	bnu6uowZLZA1zu5kFaYywrvSaYDVnNTqaU22nfJihCv1BjZ4M65OXixiRMEnFhYL5b6MuTSPoZh
	poT77YZyMKmvJonozYH31AyjyOQOQzLF3zLgtlW3yxEcvACsQRoDzaMPEPc+j/D/W2ZPpSoKHbj
	mqEuJX43fpMgT/JtKnyDEGLNhJMZ5cNqP+FBUA8NJP6dAZQb2lC8N9mwAZYiy43DPgr3Nf2oPbn
	6wLt/SzUDw8i4rjHaLOJdsPkuP8w==
X-Received: by 2002:a05:7301:1015:b0:2c5:50fe:c782 with SMTP id 5a478bee46e88-2c930c76e65mr161749eec.3.1774980659667;
        Tue, 31 Mar 2026 11:10:59 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:d70b:ce67:6f19:d9e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2c57sm11289860eec.16.2026.03.31.11.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:10:59 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:10:56 -0700
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
Message-ID: <acwOMB74ZwvuQyRC@mozart.vkv.me>
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
> 
> Bah, Sashiko caught something obvious I missed:
> 
> https://sashiko.dev/#/patchset/cover.1774969692.git.calvin%40wbinvd.org
> 
> >> When the outer handler completes, its sample_len_ns (total execution
> >> time) will be strictly greater than delta (time since the inner
> >> handler finished).  This guarantees delta < sample_len_ns, causing the
> >> subtraction to underflow to a massive positive value.
> >>
> >> The condition > NSEC_PER_SEC will then evaluate to true, and the outer
> >> handler will erroneously skip the perf throttling logic. Should this
> >> check be rewritten to avoid subtraction, perhaps by using if (delta >
> >> sample_len_ns + NSEC_PER_SEC)?
> 
> The solution it proposed makes sense to me.

I replied too quickly: I think Sashiko is actually wrong.

It is assuming that sample_len_ns includes the latency of
perf_sample_event_took(), but it does not.

Nesting in the middle of the RMW of the percpu value strictly makes
last_throttle_clock appear to have happened *sooner* to the outer NMI,
so I think that case works.

Thanks, apologies again for all the noise here,
Calvin

> >  	__report_avg = avg_len;
> >  	__report_allowed = max_len;
> >  
> > -- 
> > 2.47.3
> > 
