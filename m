Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDE156C70
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128180; cv=none; b=HHiTKGnNvML98OuP/SDGNs/pxdZjfRLILWiB4HwWAg1e1kAAxy3VLi41iSWRH9HyChrPIWHpcLB3RIlonyjQts3kiSBTaa0CaINe193VhcE/DuLzjFmbqsyhcJamyGl+oohRIc49XCdMqxw3YnAyP9bUHpTKFA2DGbaH1vTmVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128180; c=relaxed/simple;
	bh=FAG7Osn8XZtmnlVb+3K/AwNFN0PNCGVxYL/QhmR548c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IKQDhSI46QxoFbjmELopE1lR3mTM4XJySIlQJUJ5MPCCT6HmIVZvye9BzkHUlfpQXmGV1vpU7LhvyCG005zT3sybEU3toHCzy1cNkGFefs3lizLS9Fi13X92ZzkKEK7oM0xPhGdK1dry0WMPdKCQtXpBMsiXkXp0wVOOFbn/+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8PNpB1Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8PNpB1Z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20d15285c87so11095ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732128178; x=1732732978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oFKIZPyQ33M3QhxMDJu1vhmcBP8Nem+7EbpdGy4/cY=;
        b=p8PNpB1ZIX88MKlQtYHFcU3AeHjaCBNNjF83RPpI1sbKBGNdr+6q3jrlTkd2Dr2YG7
         VucLJBAJa0sLfsHK1opSi/kS7CW0PnLRWb6sduwIONKV1WfzRA/4LdFTd7tnX8bRLbWw
         7woadS9WNUIOrCd0aEBONFgZ2QEMrDp904XRXfFecz3AEogA2hyODydX73d/00oKVHjw
         NjzLUSMDATc+g+EKxcjZ81HjEchT7AFMRFAjtY8N8QIKlUN1diPM5Z1hsTVsk9T+C4R8
         t3CMcWe5vQEXyBfTfsdLxtxq/J4DbFQ2NqH0wO9cSniK3nXYCilbjvKxGEw+fpcXA722
         7W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128178; x=1732732978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oFKIZPyQ33M3QhxMDJu1vhmcBP8Nem+7EbpdGy4/cY=;
        b=juLTPzcrmIGee+AMorH2ZCU8/vj+Y2juq6l84m+L6efJBP+Iyu8zmbP5DNRknQjd9m
         iPKDvW4abvyxNNpXLHYKYDZL5D5oWAMDb1BszxVLW/b02Itqi0seaGrojV0IZDNKi10W
         gaXinZBPitB979xKOqnXV9P/IDFKwSBG+a1pnFuWCL0PbCsgUmRVX1ND+duMIWVAq1b0
         PjkKstGu3paEUqdNNInQxnc3GcSX40SToh2ka6d1VCId5p1H6Dga/WUJX2WmnKd+sqTB
         /XDzUFSwasyvExwW86xMeVIRD0p/MILPw+Lt1xzoCmfsnnZIXbllGiFQEjquF5oY4Twn
         e0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU0JV9F8BZs8QlXx4G3vL1D4G77gNX5RHuKA5zzqBSabu1mTGu1b8URb7vScvJWwkmltsOZa+5Fv5291O3ONbIu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1HJbxStcOdX5XDc1o3z8gCHnkTk8tQWclERfs9KYG0aAwHDj
	dEwf4Akd061j8Xh5So8b6ynZPk9qf1d4ZeaA3c4dKnq5HxI4fjZbkRSOdNLlZp53LMMhlupkvdi
	8MA==
X-Google-Smtp-Source: AGHT+IG//LxhiDF25kx95vY3LI5DvKRwadXHFwR8biNKmYDVJfG7r01Rwr82tJGTaq5OB4nI4z5SpF/eY2A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:c3d5:b0:20c:da66:3884 with SMTP id
 d9443c01a7336-2126a44d20dmr19555ad.9.1732128178593; Wed, 20 Nov 2024 10:42:58
 -0800 (PST)
Date: Wed, 20 Nov 2024 10:42:57 -0800
In-Reply-To: <20240801045907.4010984-39-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-39-mizhang@google.com>
Message-ID: <Zz4tsayQblkJUOtG@google.com>
Subject: Re: [RFC PATCH v3 38/58] KVM: x86/pmu: Exclude existing vLBR logic
 from the passthrough PMU
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiong Zhang <xiong.y.zhang@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> Excluding existing vLBR logic from the passthrough PMU because the it does
> not support LBR related MSRs. So to avoid any side effect, do not call
> vLBR related code in both vcpu_enter_guest() and pmi injection function.

This is unnecessary.  PMU_CAP_LBR_FMT will be cleared in kvm_caps.supported_perf_cap
when the mediated PMU is enabled, which will prevent relevant bits from being set
in the vCPU's PERF_CAPABILITIES, and that in turn will ensure the number of LBR
records is always zero.

If we wanted a sanity check, then it should go in intel_pmu_refresh().  But I don't
think that's justified.  E.g. legacy LBRs are incompatible with arch LBRs.  At some
point we have to rely on us not screwing up.

A selftest for this though, that's a different story, but we already have coverage
thanks to vmx_pmu_caps_test.c.  If we wanted to be paranoid, that test could be
extended to assert that LBRs are unsupported if the mediated PMU is enabled.
