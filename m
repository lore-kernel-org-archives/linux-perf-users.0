Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBA57C93;
	Mon, 10 Feb 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174877; cv=none; b=LRh0tJsGucUw75AdyaMt4twr50kXTozlM2IXmHAIJzPC0sR2MmnH8erNXrHckFZEcxORNkrSt5Mpr+MjULsq5zKSpLp2zwh3yhcnC3o8yP9JaKFDuFpjFEXEVB3EvdcuzpT0/O97466czMWMg7zETn4gEaREacyI3Pij87m71pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174877; c=relaxed/simple;
	bh=2LRJVRKLYQz5EMJwU5FJQIXfGkiJH1b6znzeZD9uI8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSRcVTxuJh8lxuK9PcqEfRJTFO2eKAl7efNXYbfygJG0zzVw41CiFY2WgGdQFU0qlWmHKm+Wy/tOGN2inYoT8/oMo37pCmyTPPvsxh/7XsPni+AzJc8Y7qaf/RW9pdeH37YDD4Iqz7Qi9nV+iQ728S9OuYd7dMpbMyNL1oSKLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLpivudh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLpivudh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f5268cf50so36163015ad.1;
        Mon, 10 Feb 2025 00:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739174875; x=1739779675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTmm0PHUXfi39PwAXSrGI9Ypgz+NFnq7yOVej0ZtiOo=;
        b=aLpivudh92aW4NCCCqsGblzFQlULOvDpKLTkOetu0IsUauHg92JrRdHbirTRON0aCs
         hoBBaiPSjPpwz6QBLTlHqMcj3zLwfxT6nJF0ESIqRgwxfzHHJCvuzgqZMu10Nl4T8g54
         FxFx/ziQySmBDhSCPngV2k4N6bPi3YMe+HJRRP/7ibbSoRg8dfeIHyq1xAGYRxu6wXaZ
         UIoA10osUmsoDPtSh/o+FLSstzKD7D37TEX+5Py3ePOY2E9GypJFaTkPCKDXKIRNXAA5
         X0bJIVk/OGGkBQeCZElb+x5pRJbskom6NzP4r8pqn67YpEoC5IFzQUL7hm/+1mvw+II5
         2VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739174875; x=1739779675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTmm0PHUXfi39PwAXSrGI9Ypgz+NFnq7yOVej0ZtiOo=;
        b=ZRreaZz5O75K8C84mNqEW0Zgbd54hN0+DP+ZJTX0I1OQrjXOJTwGC0d0W8RSAGo5Hn
         mg+Xu4i/jxhPnhN1V0NFdgH2PgY7J6slUKlB1owtNHQmkgs5PXQDTUzUj7q77Dj6PnvR
         jEO7SrE7ZEiIWdVp79Jzlm87pqStSOR4k9auOfxnNqc/S9Qm4Bw7MpUEH/UujQRk7J/H
         V0kwgJ6tdQSlyZQ7wghxSfbgFkVla8fQRgieoBHvwRHSpzCBvp5d2c99AIaO3tNOVCLd
         9P6S/nLkpCGxmAP1tOuxwRaAi6eQIrkb6Ug/aKTz7pH9YU5ljRXzEc9yunvY9wqul8NM
         yENw==
X-Forwarded-Encrypted: i=1; AJvYcCUqzoF1//yZcl9HvPQWIb9O90dN+q2LVkjxeBgjpB74lQNnWR26a0iGPJEzkCEyRWQwPk8KNFnaInzWPNBqW4hBRg==@vger.kernel.org, AJvYcCXT6NXytwoEA+b1kOoguJWr4kP0HD6wRw1bnKO2n4KUX12g+puTPb2og/ndxlVXiBN73HQDJpVATVTyVps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhC1Uek9YMDyTzjIgLF5g5AWedz8YpuT0lIpwukmpEZ7vC74Vf
	LVg4Ozhq+18NFFX3YygGtftk75KQH6Qd3weaK69N89AePsaF7R+n
X-Gm-Gg: ASbGnctSBDyIWMFqTSmU1R6YOds3xu7KbYzB8q3HTjMZ4dglxwJLHbWk+UkowR/Rrjd
	wV4QVh7/XqkjIZUJvZBCf9PdZSheQaJjBKVzFFUf1+EHSi4qn2gqGjBh+TbeAg3hjH6JDYW4ERr
	PpCePNWVO+WrPDIiQv1txvX+Vf9COkVDn6RP1FQBbsVAyixDTeuoGdyfMJm/pEPpLwc9oZiGvSe
	t0+4uyYbS8GJLNGg4EEeTXHD1hgHrntbI1k0ydsUafz9twvW/E4g0WlsrhHs8USDBZ+Tga+IbiU
	g4gq7zCHH0T4Sdw0TTqteLGfHeNCJtXm
X-Google-Smtp-Source: AGHT+IFI+RjVRpgCMuA67GC17LqKlBuAAncpG2inIA+67se5Feg5ic9vNECUOImGzCZct/EKaAFWfw==
X-Received: by 2002:a17:903:2449:b0:21f:71b1:70d8 with SMTP id d9443c01a7336-21f71b17573mr124532065ad.51.1739174874938;
        Mon, 10 Feb 2025 00:07:54 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:83e6:5a50:60c5:d373])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad55c04ea47sm104706a12.4.2025.02.10.00.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 00:07:54 -0800 (PST)
Date: Mon, 10 Feb 2025 16:07:48 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	shuah@kernel.org
Subject: Re: [RFC PATCH] perf/core: Prevent dereferencing NULL pointer
Message-ID: <Z6mz1A804NXZpFm-@vaxr-BM6660-BM6360>
References: <20250205190608.93508-1-richard120310@gmail.com>
 <20250206080520.GG7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206080520.GG7145@noisy.programming.kicks-ass.net>

On Thu, Feb 06, 2025 at 09:05:20AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 03:06:08AM +0800, I Hsin Cheng wrote:
> > According to coverity scan check, there's possible cases where
> > "ring_buffer_get()" returns a NULL in "perf_mmap_close".
> 
> That makes no sense. Having a mmap should pin the buffer.
> 
> > Use a "BUG_ON()" to check for NULL pointer existence, panic if it does
> > exist, otherwise it's safe to dereference "rb" and access its members.
> 
> How the hell is a BUG_ON() any better than a NULL deref?
> 

Hi Peter,

Thanks for the review ! I get it so I think this issue reported by
coverity scan should be marked as false positive or disgard.

> That makes no sense. Having a mmap should pin the buffer.

I see, so if I understand correctly, the "event" in perf_mmap_close()
is guaranteed to have available buffer and the buffer's refcount is 
zero, so returning a NULL will never happen right?

Regards,
I Hsin
