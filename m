Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEA84FC4
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177613; cv=none; b=DAC1AO/W+wQu593faoZbrXwjQ01hKvGKSJ0EEeDBo3nQ/JA8HUs7pQXq87W1eVRMFWWfSs2jEqMA0FkylnFwVsUqStX8K//SW0I1iqa+hyDq8Iu/LgrdS3/xwfgo7plyL2/cEC5e+NGhEwseiQkiRLPBQHaDdqVUX1vevoGXdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177613; c=relaxed/simple;
	bh=61OD/9IaLuFsHEDBKcuzpgK0PsgjJcl8bgAHw8uresI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hdllm5qxrVPqogQIlGQ+XZ8ukHNeuNYGjCM1jC1C5UsXLPP6yZo32sCPh6DCO7MDPX2aFedLXdkKexxt6hWBVx/OO6Zdq/k9wfQLn7PWPqKJ+QDBBVwgPmpEgYd/bfa4tqrxH0RnicIJLT3RYSIAYq28sUSik/X3HJ1emI5D830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsrDGka3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsrDGka3"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de8b6847956so1201146276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715177610; x=1715782410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVDjHWc5/R6c0TdAMm7J4vZvfOmudqJs3mpnamvf2qo=;
        b=SsrDGka31YgzjFzv6hzhhf4HXHcQ1rNac7vLZqo8F1Ijz26HEajfRGgYm8ovNEWkfT
         9c6EIDXJjvStjsb0+YYMDseQ9R08nq6R9AhcwvmzR56XMQVQdB4/mgGvZJiYQWOmvzfq
         e0hFyG96KSgSd71DFIxj8c5YDvbZVg6kGafHPW3WaeepjazUo/ELJH1HQd9MhqZWUoN/
         vPbjzuHJx+kKxYrupmfMX0RZlL3teIm3blZ2tgeRh0kg1MJEhRbxn2TDZUYnPJLyQX3R
         CQ0cNh5wWoP+/kv7k8HXAhNz23RbdJJ/4RHomj5ebfBetYU+WBnzczJRWhQAJBUQeOPB
         H++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715177610; x=1715782410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVDjHWc5/R6c0TdAMm7J4vZvfOmudqJs3mpnamvf2qo=;
        b=NMF5XboW02JKaS7ZC/1tngnlsBTh966bOBpD4jBdljQBVWXBGf93jTHy/t3qeHD0GS
         gXPMIpVEvH7wpqY3Z1AgwV9qgV8XYlCJj0T/Y8UlQBEypYFbFUQnuYyogqKG5Tn52wxl
         L1yWXHcC2p4VA7krAuLX/1diZMcK/aqLsiHt9Ec4aoQ7Fyme57DBbe+PBNxnogf+KBVE
         V7sXha96+9Fkj6wE647JZxodyxVUzpScW/0DYbh1S4OEvIp+6NVE3p6b6DOtbVLH6VMQ
         eF1JJrk5FJS8haRk4sV1On+mXXyQT0z+YDWjUL8H2Y4TfObGSsJ19KLkazii8ynv33iS
         eV6w==
X-Forwarded-Encrypted: i=1; AJvYcCUsm/HP/adCgysiAbqG/R6oY/uCwxpyOvU/ZChqEkdQRmPc0tbJAP8DZ7VVVLVh1PjA/xMDAR46EUSBGqEqn2QGDZDJSNQPYJNhl3e8bc57XA==
X-Gm-Message-State: AOJu0YxYOWUWjgjZYYvjiEjX5JSvHMtuoUSazepDYZ1jxJHggmURVvCq
	oJa0gGQaEibsdYQgH79yoRlS/83UvzNAeD8JXu1ac5KHh5XzDV9LjPT4TMq7cf8JliO4LnvH5nj
	VIQ==
X-Google-Smtp-Source: AGHT+IENeF3rnph7fc8JeZe16l04XQs7NClzQF5EuFP6FS2QG565s/9c2Vu2Uv2xY57ikBOmWZf7+kjvljw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:702:b0:dbe:d0a9:2be3 with SMTP id
 3f1490d57ef6-debb95f21ecmr991296276.3.1715177610501; Wed, 08 May 2024
 07:13:30 -0700 (PDT)
Date: Wed, 8 May 2024 07:13:28 -0700
In-Reply-To: <fbb8306c-775b-4f00-a2a6-a0b17c8f038e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com> <20240506053020.3911940-18-mizhang@google.com>
 <3eb01add-3776-46a8-87f7-54144692d7d7@linux.intel.com> <CAL715WL80ZOtAo2mT95_zW9Xhv-qOqnPjLGPMp1bJKZ1dOxhTg@mail.gmail.com>
 <fbb8306c-775b-4f00-a2a6-a0b17c8f038e@linux.intel.com>
Message-ID: <ZjuIiDwbrWL7OD86@google.com>
Subject: Re: [PATCH v2 17/54] KVM: x86/pmu: Always set global enable bits in
 passthrough mode
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 08, 2024, Dapeng Mi wrote:
> 
> On 5/8/2024 12:36 PM, Mingwei Zhang wrote:
> > if (pmu->passthrough && pmu->nr_arch_gp_counters)
> >
> > Since mediated passthrough PMU requires PerfMon v4 in Intel (PerfMon
> > v2 in AMD), once it is enabled (pmu->passthrough = true), then global
> > ctrl _must_ exist phyiscally. Regardless of whether we expose it to
> > the guest VM, at reset time, we need to ensure enabling bits for GP
> > counters are set (behind the screen). This is critical for AMD, since
> > most of the guests are usually in (AMD) PerfMon v1 in which global
> > ctrl MSR is inaccessible, but does exist and is operating in HW.
> >
> > Yes, if we eliminate that requirement (pmu->passthrough -> Perfmon v4
> > Intel / Perfmon v2 AMD), then this code will have to change. However,
> Yeah, that's what I'm worrying about. We ever discussed to support mediated
> vPMU on HW below perfmon v4. When someone implements this, he may not
> notice this place needs to be changed as well, this introduces a potential
> bug and we should avoid this.

Just add a WARN on the PMU version.  I haven't thought much about whether or not
KVM should support mediated PMU for earlier hardware, but having a sanity check
on the assumptions of this code is reasonable even if we don't _plan_ on supporting
earlier hardware.
