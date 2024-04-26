Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3918EA5
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160804; cv=none; b=Y8Bca6Ckvs6h1/rBAw69d79A/7NUuEX4no171C5Oq9yvOaq17UHc69p/4fS+nhrMQ1iY4V7bJFR2XAHiQf/Ghs94uSWJPoACbTtV51x7m5ZCavEeXk9iBrAfZhx5sxi552DG0zIRkQIzx/w6oQD7vJeBZQpQjxonSvRhvv1FWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160804; c=relaxed/simple;
	bh=9I8HrINcXcCO7t7LJcar7hS2Q+p9H5CASNC/aDQUKMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GAgFtOSDWS2n4fpsnhsY4RRtaSOeyaZc9bHWKRx5oLsOgm1QnuQ/lEUj+S7mGb1dBEvP9DhEzNUBP3r1qLEthk3zhEILi0YEKbkdvIVA12cfKGy+WXULvlWTTY88+7JKdfYCbbHNBYB2EnfFQkMjhxO3CF8zEAKhE8KqcyyUiZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXycdzs5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXycdzs5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e63ff880f5so29601465ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714160803; x=1714765603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UncIq/RGO14yVQciI7tDs0Z5rk8USO8ElIwfA/pf054=;
        b=mXycdzs52JZgKvK+1qRtbnRqM2p66EpEVGfbbWFerUXl6+llSsBx8UEtkeKELu7T+l
         xOBtnZTWM7ZDfA64snsnwOW87xaU0QqtNCm1A+tqfzN0IMiLTe9nA3cCxFiXRqIGqwIN
         2nq2A+e6nopbko8k9IrwsJk0iFxD64+upTdxa7hFmFzHLZDrwkYGxRUfnGBDs06ysHUZ
         aueUfpwATJU2tm4CkgZMF3viFj/VWPw+80r45iuDtVYRfbJs6XiqtukXyTtj7R/rz9ef
         638PdFyORnBlU70EK3rrggpXVNDSW0UuyCq+hQuXrwf+50790zPS99UBKzSzLwMgSfFP
         FiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160803; x=1714765603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UncIq/RGO14yVQciI7tDs0Z5rk8USO8ElIwfA/pf054=;
        b=q6+OcteY8rfW9cLddcAj+4gVg4CCNvMAq+F6XVRZbBI7PBBhtB3j/4oVq3apJadyOz
         XkphdLYJqPw8aV1EIPoY9N3QUTGgyrl2ggvruZFJi1yJS6zQsb0BEC9lw90J61PC0TXO
         OK8w0PNeHn6sIFKIjaR81bCYWSn5bJYTj/dFM2NeZglAejfrTMf8Zg83ewj9SpMGKk5L
         3D7udaNgB90VC0hP/7IKnrF0+zJm8a9FSUbbIwWS4MCkMPhLJm/Vzm6GedBYYl4HOvBi
         KV9ownIt7DHPYpWE0l3Tv6pTXt1Cvbxr7qgi3+LTadn2gIMYMr+44Avj5YGV5L4zpKMa
         OYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgIXwz9K7qVF7nPMbkkI7vtA+tBbF9/ixkTnRrWbCxeqruFwMrKS95oQ3ZOOE0QarPBWypHEqBBvyBOabjbHLJtjhnvrIifAjwhMwpLkqb9A==
X-Gm-Message-State: AOJu0YwJjbWlmVKj509lWhswQfcS5jvhGe/0MvcKNUk+1YhXMcri7AAW
	t3EP8XZ94QR1D5UE8k/FKtfOxkxr31nnfa0o4SV+feuQx0GfdODu6AJa+/9N4WFxScbS6U74P2i
	QVQ==
X-Google-Smtp-Source: AGHT+IGaUfhZhK/DdQDcWa43ivFUYwQoU9AvuYZ1w4SqevbuUQY8dRRZ0emewUCx336TqglcAcxA8N5Zh30=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d488:b0:1e3:ff3a:7a07 with SMTP id
 c8-20020a170902d48800b001e3ff3a7a07mr294264plg.6.1714160802676; Fri, 26 Apr
 2024 12:46:42 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:46:41 -0700
In-Reply-To: <5f5bcbc0-e2ef-4232-a56a-fda93c6a569e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAL715WKh8VBJ-O50oqSnCqKPQo4Bor_aMnRZeS_TzJP3ja8-YQ@mail.gmail.com>
 <6af2da05-cb47-46f7-b129-08463bc9469b@linux.intel.com> <CAL715W+zeqKenPLP2Fm9u_BkGRKAk-mncsOxrg=EKs74qK5f1Q@mail.gmail.com>
 <42acf1fc-1603-4ac5-8a09-edae2d85963d@linux.intel.com> <ZirPGnSDUzD-iWwc@google.com>
 <77913327-2115-42b5-850a-04ef0581faa7@linux.intel.com> <CAL715WJCHJD_wcJ+r4TyWfvmk9uNT_kPy7Pt=CHkB-Sf0D4Rqw@mail.gmail.com>
 <ff4a4229-04ac-4cbf-8aea-c84ccfa96e0b@linux.intel.com> <CAL715WJKL5__8RU0xxUf0HifNVQBDRODE54O2bwOx45w67TQTQ@mail.gmail.com>
 <5f5bcbc0-e2ef-4232-a56a-fda93c6a569e@linux.intel.com>
Message-ID: <ZiwEoZDIg8l7-uid@google.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
From: Sean Christopherson <seanjc@google.com>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	maobibo <maobibo@loongson.cn>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 26, 2024, Kan Liang wrote:
> > Optimization 4
> > allows the host side to immediately profiling this part instead of
> > waiting for vcpu to reach to PMU context switch locations. Doing so
> > will generate more accurate results.
> 
> If so, I think the 4 is a must to have. Otherwise, it wouldn't honer the
> definition of the exclude_guest. Without 4, it brings some random blind
> spots, right?

+1, I view it as a hard requirement.  It's not an optimization, it's about
accuracy and functional correctness.

What _is_ an optimization is keeping guest state loaded while KVM is in its
run loop, i.e. initial mediated/passthrough PMU support could land upstream with
unconditional switches at entry/exit.  The performance of KVM would likely be
unacceptable for any production use cases, but that would give us motivation to
finish the job, and it doesn't result in random, hard to diagnose issues for
userspace.
 
> > Do we want to preempt that? I think it depends. For regular cloud
> > usage, we don't. But for any other usages where we want to prioritize
> > KVM/VMM profiling over guest vPMU, it is useful.
> > 
> > My current opinion is that optimization 4 is something nice to have.
> > But we should allow people to turn it off just like we could choose to
> > disable preempt kernel.
> 
> The exclude_guest means everything but the guest. I don't see a reason
> why people want to turn it off and get some random blind spots.
