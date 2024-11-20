Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1814A0A3
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128394; cv=none; b=E6gbZd7XSR1NSshty95iJwDS7CC5hcgXmNJLH43LH3X6Snsi05QG4zwa/YWRgDHyUNi46rZ3eYqgli/W0MsaDmqaWep/39jLm2wDrpIdkv0WvnTPQppB3Sq5dDJ9JpN7G+oZEl7Ss0K4BhfZBVtDVpUyAo31YAh4v7XMlYxpWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128394; c=relaxed/simple;
	bh=bz7OpvOpy6atS7GrkuQ8mLzLRHkVDfHP67FoEXcJdv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lXH2kT1HEdRdNBvPucuIUfuv64K1GPmeqBkhXx2/0UzEhcfBePsPl0zGAxSLMb5yckdHnzZMQLNUVzclsgN43eB2F+gKVhJQcs42caAdCCAaZhSrYKCRtcfHdgwjPcSRkJwMUTyatDqQVyJhna+u5ie0u80hzu1w6sfdkeZrmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYHtIMoZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYHtIMoZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-211fd7cfc4eso168235ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732128392; x=1732733192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Os80MhRhGqXp5ke/1Vxt/rcMZ16KsE7OPEZ8dzr9R8=;
        b=DYHtIMoZN4xFoWpRvwXz7GJ85mr5Irs9xkyVitPxt7/taPMZLHSpRek3MbQuHrdFPw
         /LhdCDCdqUyS80xhA+cbPVe5BAkpyCJxBkyLiuTDHVcxQzXUK6b/i6c0Q8fhvmHJdFJR
         fRe9SRxskFzP8uBNceeT4IBjkpluqvh4E7cJUieOEqgaZKGuEwaHBOn6BruI4CvjzRtB
         3L/nQbTzrtMy798AJIVxQ46QO637PQuzLoI9jl0IzOUo/+KDXJEVBrUMNUzwUW32DW9w
         RQ732V5HzTkl1XB2x29ni92xC7hMWj0v6YrDXACJx578nNXZ47knYN8DIu43W1hUXPw7
         dzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128392; x=1732733192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Os80MhRhGqXp5ke/1Vxt/rcMZ16KsE7OPEZ8dzr9R8=;
        b=RcQqisF8ZRZaG295I/BdrWbLR+G1HS0uwD86b/BdsbjhVg51Nzsq8Esj6M5CtM7FCh
         aWzicrakVA9hFz35SpnbaLDzc0et2djpTvIp4Ay8JeCs2XaY+GcrsXndVylCJssDsIgS
         YteUM9kSoLP+174707WsCpHKKV6ydC3nm8fvK2SGWAVa5iBv69L1zVAYR7BSh+Tfs+I7
         6PRE9+ExSdVRQKcWeK1jSrldG2JrEXHDhCm/dl6exSHRa42gzxwAze10/c4i2/Xdr7Fx
         GUcSa4ewHrU7G+rXQnBXZgmTBqjBH3ihKMAibNtcbzShQRZVcpnExIRCRy+oj2GrXNzP
         C2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsrxrezh4XzDY/ynKvi5o6K3E0dcDOX6UP2vLazp85ydY5ByIYr0UgdIjXbs/+8eJtAzSLYrmk730tbw/LdzjG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32uD7Aq6JT7enEXugW2kPnJAhrQW4xxldrdJlEHeYny4CoRjX
	TlU1IoNlFibYm633LFENzh3l0dAhRM9ohS/BEfKXbx3pmcby7CGbwKFsPdeSnB6KcgVGi+N0Sb4
	bgA==
X-Google-Smtp-Source: AGHT+IFJzrweiSMHDQwuusG00tZ0L3OBUwopKy6Nr208yDx/fXeQeozBoXUMG6gBsgZPojGUxMGBmM72sP8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:788:b0:212:f64:de11 with SMTP id
 d9443c01a7336-2126a336564mr12995ad.2.1732128391948; Wed, 20 Nov 2024 10:46:31
 -0800 (PST)
Date: Wed, 20 Nov 2024 10:46:30 -0800
In-Reply-To: <20240801045907.4010984-41-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-41-mizhang@google.com>
Message-ID: <Zz4uhmuPcZl9vJVr@google.com>
Subject: Re: [RFC PATCH v3 40/58] KVM: x86/pmu: Grab x86 core PMU for
 passthrough PMU VM
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
> From: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> 
> When passthrough PMU is enabled by kvm and perf, KVM call
> perf_get_mediated_pmu() to exclusive own x86 core PMU at VM creation, KVM
> call perf_put_mediated_pmu() to return x86 core PMU to host perf at VM
> destroy.
> 
> When perf_get_mediated_pmu() fail, the host has system wide perf events
> without exclude_guest = 1 which must be disabled to enable VM with
> passthrough PMU.

I still much prefer my idea of making the mediated PMU opt-in.  I haven't seen
any argument against that approach.

https://lore.kernel.org/all/ZiFGRFb45oZrmqnJ@google.com
