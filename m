Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57335143724
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717045963; cv=none; b=fcS5vT2xuAcJmKxvXf6XipX/BJfj/VFve2DMgZqLjAWAYJD8Ryd7omOigZskqmy5WvYY/Qc89htmN8w3I16Fx2OQD4Dtr0I02J9iMN62BlVOxbRIGd7SE5jLDuHvewBzqiOT2elMHJ7nslaTU0IoDMEOathZcllF6w0l9l/pHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717045963; c=relaxed/simple;
	bh=VL7H8fQqd8nIHUwam6QTyMO5mDtMq5T7rwyxfbnRY40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk25OU9Dlsj5fdXBrtQZyTELfOKuZJbfW2PKyXeXSrs20gejbkSg2+qT4nXwcrLvHqdYJ4rh/aIP51DUCZhXuLEQfQ7SZpCFrr9THfa9N9Qr+GcyX45LcHvQCbXEo6/B13NmHFgqSZr4BnM/Kf/xzAdJA9Nvo020mb/iHo2jtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCpAjKSn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCpAjKSn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b594deeso3700145ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717045961; x=1717650761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsuBDYq9BDHnrjQ91CodaxuYJofbd1MSvq6lCNBpu6Q=;
        b=GCpAjKSnYVJwdce3TEjzXFLxGr83pO4CosKsaJtDqflEV74y4MHvrj29GqzUGD9SvE
         hkPS90100jJ5j1bF/irLBYznABFbwNozWyOf95LjJm8pHvXKp/F5+uZA/xeRqoPrpkUL
         t+uduyxGiIhPOdgt7N6DZnH4NPnYzRof+kGtsede8kiv1uxW4bq6JZX1/reowJ45YJpC
         dxOKyitGeryHF+KLPsgScfpm0gw7MBtHahLjumN9bGSilmPjIXenRQi3a1lS3JeJuy7Y
         TSjYnh1vf1vRwNG+5mPBRomV9H7SjV1hwQZKwKtdouE3JxLjzDDKVCF5c8d2nhK2162m
         sduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717045961; x=1717650761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsuBDYq9BDHnrjQ91CodaxuYJofbd1MSvq6lCNBpu6Q=;
        b=w8WCsWPvxCwlKNGYGRieL0XtKsRLrnSByaaKb7dLgvUR4QUgZzcrM3HYBO/Ono3PfO
         Va80W6AAQGRDY1ht4yKWdPoitEn59El8/FH1J7mDcRoCURQl9sxZUDyWYaBKkowh1L7a
         khhh8PGufbAjnJqhSyCdTl3xCj1jaN/GTP+VtSlcWGGRZVIA8g2TtqWtV8zYaaIq4LWc
         jBwGNAR5YRXf3yHJJ/RdttDu/wjqloDEq/hjPwctcN8FymSIq3Po42Xr5jcaxPopN/9f
         oX9OAtwA09t+JzQKndDoOUbwb5mdbvw6rPphq9xCENkd2CeNFohfAEjQpwGfk95GQG5T
         5p+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzH8II4y1Ci9hM9gvl6GAclqKdFNa/uSVGQyCkOc77kE4zs3nJ81Zf3qkLMtuf1Fvjrm72hbTWhAbE4sYLjEtXgoTlomdh9uJGzu/yEgicSw==
X-Gm-Message-State: AOJu0YxHF7B1jO2EyrZlyu53v8h7DtzIkBtS4mVvVbm+zCi7wk3eeRZc
	D+hvSHIDbCfco/UnJzue2IQh2aD9HRxkOHKMOqOGBOLnFrI1H/krfORGOY0J0g==
X-Google-Smtp-Source: AGHT+IE8SaVeF/ixvsvfsb7cY1TEvKFZg63GHo6DzI1+1r7OKM5WXqYQ1YDSRkePpYz9kTBkgwKlBA==
X-Received: by 2002:a17:902:e5d0:b0:1f4:92d4:d126 with SMTP id d9443c01a7336-1f61962124fmr12878015ad.28.1717045961292;
        Wed, 29 May 2024 22:12:41 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75e79fsm108939435ad.40.2024.05.29.22.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:12:40 -0700 (PDT)
Date: Thu, 30 May 2024 05:12:36 +0000
From: Mingwei Zhang <mizhang@google.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xiong Zhang <xiong.y.zhang@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
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
Subject: Re: [PATCH v2 12/54] perf: x86: Add x86 function to switch PMI
 handler
Message-ID: <ZlgKxGmJWr8tUHsv@google.com>
References: <20240506053020.3911940-1-mizhang@google.com>
 <20240506053020.3911940-13-mizhang@google.com>
 <f49ebe98-c190-4767-bb0d-471776484fc8@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49ebe98-c190-4767-bb0d-471776484fc8@intel.com>

On Tue, May 07, 2024, Chen, Zide wrote:
> 
> 
> On 5/5/2024 10:29 PM, Mingwei Zhang wrote:
> > From: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> > 
> > Add x86 specific function to switch PMI handler since passthrough PMU and host
> > PMU use different interrupt vectors.
> > 
> > x86_perf_guest_enter() switch PMU vector from NMI to KVM_GUEST_PMI_VECTOR,
> > and guest LVTPC_MASK value should be reflected onto HW to indicate whether
> > guest has cleared LVTPC_MASK or not, so guest lvt_pc is passed as parameter.
> > 
> > x86_perf_guest_exit() switch PMU vector from KVM_GUEST_PMI_VECTOR to NMI.
> > 
> > Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  arch/x86/events/core.c            | 17 +++++++++++++++++
> >  arch/x86/include/asm/perf_event.h |  3 +++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 09050641ce5d..8167f2230d3a 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -701,6 +701,23 @@ struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
> >  
> > +void x86_perf_guest_enter(u32 guest_lvtpc)
> > +{
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_GUEST_PMI_VECTOR |
> > +			       (guest_lvtpc & APIC_LVT_MASKED));
> 
> If CONFIG_KVM is not defined, KVM_GUEST_PMI_VECTOR is not available and
> it causes compiling error.

That is a good discovery, thanks. hmm, we could put the whole function
under IS_ENABLED(CONFIG_KVM) to avoid that.

Thanks.
-Mingwei
