Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875403E479
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717042813; cv=none; b=arxQzjOzu4rYRWUOsYTXDgCjGS3DF6iCNFcVdVA2Bze9xC86HWhyY5YB4RnXAEXDSn7/4pAgXiB2iEflYdcJZMvcay0B9LHwhb/Bk11OtTfL8uf3Ww1zQBnWs9mi3FypKgZBP6V/Kkgkczxs+X224cDve9Y+T67vBbisp0eQ1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717042813; c=relaxed/simple;
	bh=ScqQnDhIZzazEaKjt9igUl5O8hNKM9pHSKP3vMPQWRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+2JlsRK1guHwtW6UyzQgAzRVCS8IyVD0rXluWD56jTXzzXkmJta4kdFGp8ST8S8Tk9RxvoVlNPnCTCbDDMpr3YIGm9ul3isOMY+IXRgvjgcv+Ef9EXPg5IdP3EeqhhZpUHIbF+aBIYDKfzT9IiGtIfxwwZRvbUBS+ugzEufXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/bI36lK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/bI36lK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d04so4631665ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 21:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717042812; x=1717647612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4WJSvfiaNoa/0OJgyCquaiLAw0pNXvsnSprBpQ0sIk=;
        b=g/bI36lKjBZRM5Pzk5xwDfbeKdd8a+OHQmQLwDNZceoYzQadTeAF0pKd4KCRrxcNi8
         WQZjUtOimOUiya9xIY56qbrsckjfJ3LtnYKyT4l3yptZo7OSlujTvXOO8gXMdkc2rTLG
         jtK0EFL3qip9t0pRJNscAAWAznSWQx8/X/fePYZqNiMwdgGlIZKdr6Qo7G9314XAdrx+
         BwD0xeu+btX2uhnWJ5maO5hGglyVVTa4bX9UHOtkiOtxBRXwYogU1k0we0gi5qODN5+y
         a/nPb4HIKeRWtVD+sY0XmDKiuRNZiI0pr6yCK6WaV2lHJQun9nOlgmsqzhsbx4H584KQ
         h5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717042812; x=1717647612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4WJSvfiaNoa/0OJgyCquaiLAw0pNXvsnSprBpQ0sIk=;
        b=r2vVY7sfWbLl/X2QbupjumLnJVpqLmSO/YO2lr2sJJYnNGE3p8OO1FvwD/1TMRKeQS
         XrHGP1gPzaAjG7TqME4AmFnlUkRHzWEnCsqzk3SCJwI8pHHf++uT4v29EFbVfY51oRJq
         J/D8t77CXWKrpcZNbhq6c/DuNSiJeQ3Z5PWX23xTOpVsJLY+F4WH+FL1DHr2Sz4FX107
         ax2uykbwF4WGD0Nd86eVlAaddtGAhOuxt/u1cPCQ0ET+bNYgSmM9twM20qQo9hsG/JsE
         ycwmWpmNxZNaauACKqjhMNY/Nv0tBvxsEWfkv55wMQ/vPj8qwnHowgcVeZh2Pc0wvnqc
         XzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkLnT2OTReHoPsU2XhY6k6wu+YKowoRzOGoGBIt6vnhVfTlk/XIUhu4AW0kIp2Rw2LPU4WiWFaes/P+a9iMWVFJZ4+JHzaJPPGMMipWpBzqQ==
X-Gm-Message-State: AOJu0Yy8xX/OX1QodHrYQcC9mFM3Bzpu7Oi1oyYVX+Rw5d1aBHyyiuJ7
	HKc2XZkle249X1ECIFVOaEH/vzB9O6lwD9Q6kpdzii2jPeyj16IEuPMIF6urZw==
X-Google-Smtp-Source: AGHT+IHcHdJN5a1tCHgmcM6XidNqutFz/wGDogXr9yfTIAKOQU98fE+WRy4+w4q6LGuowy6wzly2wA==
X-Received: by 2002:a17:902:ce90:b0:1f4:64d6:919d with SMTP id d9443c01a7336-1f619b2d1e4mr10272365ad.66.1717042811349;
        Wed, 29 May 2024 21:20:11 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7b7d3csm107899505ad.93.2024.05.29.21.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 21:20:10 -0700 (PDT)
Date: Thu, 30 May 2024 04:20:07 +0000
From: Mingwei Zhang <mizhang@google.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: "Chen, Zide" <zide.chen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xiong Zhang <xiong.y.zhang@intel.com>,
	Kan Liang <kan.liang@intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Manali Shukla <manali.shukla@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	gce-passthrou-pmu-dev@google.com,
	Samantha Alt <samantha.alt@intel.com>,
	Zhiyuan Lv <zhiyuan.lv@intel.com>, Yanfei Xu <yanfei.xu@intel.com>,
	maobibo <maobibo@loongson.cn>, Like Xu <like.xu.linux@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 42/54] KVM: x86/pmu: Implement emulated counter
 increment for passthrough PMU
Message-ID: <Zlf-d8p2yzNFOr0-@google.com>
References: <20240506053020.3911940-1-mizhang@google.com>
 <20240506053020.3911940-43-mizhang@google.com>
 <8da387e4-0c44-4402-8103-fc232600cb02@intel.com>
 <7c17fd63-d3b1-4438-b6d8-11417321c56e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c17fd63-d3b1-4438-b6d8-11417321c56e@linux.intel.com>

On Thu, May 09, 2024, Mi, Dapeng wrote:
> 
> On 5/9/2024 2:28 AM, Chen, Zide wrote:
> >
> > On 5/5/2024 10:30 PM, Mingwei Zhang wrote:
> >> @@ -896,6 +924,12 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
> >>  		return;
> >>  
> >>  	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
> >> +		if (is_passthrough)
> >> +			is_pmc_allowed = pmc_speculative_in_use(pmc) &&
> >> +					 check_pmu_event_filter(pmc);
> >> +		else
> >> +			is_pmc_allowed = pmc_event_is_allowed(pmc);
> >> +
> > Why don't need to check pmc_is_globally_enabled() in PMU passthrough
> > case? Sorry if I missed something.
> 
> Not sure if it's because the historical reason. Since pmu->global_ctrl
> would be updated in each vm-exit right now, we may not need to skip
> pmc_is_globally_enabled() anymore. Need Mingwei to confirm.
> 
yeah, this is a historical reason and how it becomes a bug. I will fix
that in next version.
