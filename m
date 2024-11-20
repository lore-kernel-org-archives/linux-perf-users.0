Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CF155742
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128493; cv=none; b=e5m3NtR6bYM8M6EZYTjea7977xO65fWzpwo7wFWdn6+iBfdGaqf4PCJ4oKR3p9zI3/6xnLhFfrZa2NCBW7fy5hiwZ7cd/Ypehb+8x7rr+SZc+uiFkLdHhmKFKm9yvWbJJAVDA1PfRK5Q7MQuALaeSaSS+otOm1SF0Gckmfjdsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128493; c=relaxed/simple;
	bh=SptbHGtr8HQe1kBejn+wyMTkN3CjsxNTQWkZROmQDYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NiOSImpKX1UeKvCZ1kL8yxiuaPw3cg8qgPwTL6m+iKqQKClGnMzJQzWFFstiYsMJXGqtToRy6vEoyqlQ/hJxyEshzUbMDSn3iB/+4S7eyY72VPkzfmzUASSOXoR3oli96Z4BT0sGw9K26Ip8i+Ww8D4Poq0fJ31ZG8/tgyXCCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXAFhMOg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXAFhMOg"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8901dff1so92747347b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 10:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732128491; x=1732733291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3HR4g/sjzpAPcTclN1zbnC2rewykA7Pmn4Mi3H0FG4=;
        b=gXAFhMOg0blkWSWcwI1bM7VDXm03qOP7iChrf83B1rCf3m63OXhbZkYFae8SKpGqDi
         c0DILG74vmEM/9leJo7L6nA+ArVliwitEGbSHChI2uOdE3yvI63bZN2haiHOQ0BXAWye
         mI78bCwPLF/J+iUpmYh7Kk7rnFcTcmsakn5PyCG1zqF5WV6sTCeLXzejIrP4H3plxyU5
         kBae+x51sxX7PcwY8Qq2G2KxgeawKyXChP8F9SbJ1lkFHQfjBsnDOr4gHkL7cwJ1mouD
         QWPrg+ZBNYzX1YHkdo8oOthedAUVJh/k5wLSvaLw92neJT4YIYZC4MpJEA6bDpBqGPiz
         1wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128491; x=1732733291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3HR4g/sjzpAPcTclN1zbnC2rewykA7Pmn4Mi3H0FG4=;
        b=cX8ibRqWspGMGa46re/nJtH7iEg4aNjnHmE/+DtwQv3bYK/1uQ3wp2fLE8GbpIX+Fh
         3chzXTkn0H7/m6aAF74agxRVtwLWLJkfvOB4GHkfDxMT6TL7IMc45bzj4+dIilwOuLoM
         do6ligMgspeyG1SHiil2GueLqPp2pcYq/a9wCLK+Z4fe5/OFk1E+rVZegxuRJysb1bl5
         VL33xwp2Uz6PpdRN+ptdIFE78geM/qVl3sOCDOIZDHQPla9NWstmrt2h8Mf1QhUHBNbl
         d9mqKaQn9FgAovHJinxaiIO5cxBi6OKrAq03wKTpLvRcvzUsayb7DCzHGRIEJ3Rd8sUo
         dZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXFsV6uV35iDvTWxticueRndmGe3R+v+FQs9ivOm7iAksJWd0bwPu4kRVO8peo1Wki4ldZhX9HijKS9LPBOUcrc@vger.kernel.org
X-Gm-Message-State: AOJu0YxumRf0nlAvcXkvPA1GdVZpAuuRmSNVeMNXZsv7ixdK9K3FRyhB
	msdccoTQOfJ+gNsr115+1Nn2uWOz5hLMOoPYGtu+UvxUBz/64fAiKztmit8Kurmz1QPOUp1sgbn
	x4w==
X-Google-Smtp-Source: AGHT+IG1zJqbsPNNDJARQI6xoVNz95KgV4mE/AQmuyzu6CtgFyAtoag2o81vxx34sHHpDEQYWV+wCNJl0vE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b04:b0:e38:840d:3a9e with SMTP id
 3f1490d57ef6-e38cb60a27fmr24897276.7.1732128491003; Wed, 20 Nov 2024 10:48:11
 -0800 (PST)
Date: Wed, 20 Nov 2024 10:48:09 -0800
In-Reply-To: <d0d8a945-1623-448a-b08a-8877464a4531@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-44-mizhang@google.com>
 <d0d8a945-1623-448a-b08a-8877464a4531@intel.com>
Message-ID: <Zz4u6ThdAZ9M83wf@google.com>
Subject: Re: [RFC PATCH v3 43/58] KVM: x86/pmu: Introduce PMU operator for
 setting counter overflow
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	gce-passthrou-pmu-dev@google.com, Samantha Alt <samantha.alt@intel.com>, 
	Zhiyuan Lv <zhiyuan.lv@intel.com>, Yanfei Xu <yanfei.xu@intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 25, 2024, Zide Chen wrote:
> 
> 
> On 7/31/2024 9:58 PM, Mingwei Zhang wrote:
> > Introduce PMU operator for setting counter overflow. When emulating counter
> > increment, multiple counters could overflow at the same time, i.e., during
> > the execution of the same instruction. In passthrough PMU, having an PMU
> > operator provides convenience to update the PMU global status in one shot
> > with details hidden behind the vendor specific implementation.
> 
> Since neither Intel nor AMD does implement this API, this patch should
> be dropped.

For all of these small APIs, please introduce and use the API in the same patch.
That avoids goofs like this, where something is never used, and makes the patches
far easier to review.
