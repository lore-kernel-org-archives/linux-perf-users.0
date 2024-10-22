Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82A49652
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614654; cv=none; b=lZWipZqQLZoYkZv5vnCCpdy97TI3gxTyzP/uEIOAuPz+epIpzDjkDP/GzquIR8ZJtgM990DJpj11DSbKBUVHnGsh4zX1oGuPPNGgJQKfDq2DPEpEdCi0a1dXuqp0rTosRt0T+rKSC575EwNtI3uYvicyFYCt1VVc8+AB6vanQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614654; c=relaxed/simple;
	bh=QOPxs8wUWKMAIDl2V9pd953dr2fdLJZqCSgzDiAXVz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q5ZzSe0W83k52FXcDtLAomGjX9HmieNRtABJgAPjs5QZuu45CfEmYB1xfyLRcOAp1M/3gVXYyTPjCbgPHnY9Ddlcrxxkjw0jdTO6BpsgbOchIazOveyRI3TdvFn5AcwrKX/TRT8/yoHy8p7GE2uLNeMuHGchSgmZgGq6t3anADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqGLSzzr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqGLSzzr"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so9738765276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729614651; x=1730219451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kRp9X9Evgeqhd6nWrjVapRhaCIHseB9bHGDukDgzlg=;
        b=fqGLSzzriuboJZlYznc2xAYIPnlzhSZqNeiZRtE0IPWHc5a9Txq//hAEjkI7dTa/4/
         hcuG/Omms7ZVw6Bc3gcioQ5fQt6AxxNt5t3m68aDkSAZt3RLmnHlU71iFgtNTf1zDbLG
         Pt2X7GA2wALJsXSyDpmxhSzJZDYP5YizdwpJF1wAoOtseBT53WX2aCbVEDs/l/RlN6Kp
         Bw2bAM7sJ+butLU4k5orLMEkkRd5KK8SKxw7w37zDary+0tIL423qNRs5/4cBnJNjI9R
         UdaprmPlzdGBgHf6B5jNTlYfdvvgPKLGhvPUkufNwrw6lDQdrhojhb/15LBywTPcuiw3
         EbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614651; x=1730219451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kRp9X9Evgeqhd6nWrjVapRhaCIHseB9bHGDukDgzlg=;
        b=D5NK50Vs4L4vWx4JbaQ5hpfoKbHPHOA8rPiMUh85bxSoMJEmGuAnD/veioSGRZ+Njl
         +8BdxLc/d2k79cyfUypg7ZEbzMLsI5rTGxv/ja27o2m3LB4RZ8fyTRrJupYP85IpB9TM
         3VhYdQyLjkP2pZZybIXZIoICMRDY6jMfeOcKTuDQfYpec6SbbboUvuiwMU0iZ1Hu+3yu
         3iTGpaGzImLvG8Nh5vScQFWh5zpWlq8IMhU+RPt0qdZJQXoZOQXn3th5Oyadv37TKUMO
         suODmszEmYN3VANaptidbRjk28zkk+CpuPD6YA/HNScCfAqboo1f25/1QVTsCAkJPqKg
         B/3A==
X-Forwarded-Encrypted: i=1; AJvYcCVXZDw6PTpL4tBVcxnr0DYecIdB1wNcg9g10YSLKxbpkDQ5JvXOo2snAZaLyxDWDmhIqY8cXInymG2YF7Ok31Rr@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHD1f+WergJysuA3MDdb1m7BV+nAjZHKORFJOEdHx8m1wC+/s
	NNsaVSw3JhbJUcMadHiYjkW05QmynPberyP6gYRQxOwltpqOk4LfeHChpvo1XRlGB/Dtyged9/4
	r3w==
X-Google-Smtp-Source: AGHT+IFhidXoMwHV1i3xjXEppuei+o0CgKpCcKTpOo27zytz1Beo5NbI8wae2gvpTFRD+0KpTD3bdky90Rg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a5b:c10:0:b0:e20:2502:be14 with SMTP id
 3f1490d57ef6-e2bb168d0f5mr9106276.7.1729614650729; Tue, 22 Oct 2024 09:30:50
 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:30:49 -0700
In-Reply-To: <b29e8ba4-5893-4ca0-b2cc-55d95f2fc968@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014105124.24473-1-adrian.hunter@intel.com>
 <20241014105124.24473-4-adrian.hunter@intel.com> <Zw1iCMNSI4Lc0mSG@google.com>
 <b29e8ba4-5893-4ca0-b2cc-55d95f2fc968@intel.com>
Message-ID: <ZxfTOQzcXTBEiXMG@google.com>
Subject: Re: [PATCH V13 03/14] KVM: x86: Fix Intel PT Host/Guest mode when
 host tracing also
From: Sean Christopherson <seanjc@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com, 
	kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 22, 2024, Adrian Hunter wrote:
> On 14/10/24 21:25, Sean Christopherson wrote:
> >> Fixes: 2ef444f1600b ("KVM: x86: Add Intel PT context switch for each vcpu")
> >> Cc: stable@vger.kernel.org
> > 
> > This is way, way too big for stable@.  Given that host/guest mode is disabled by
> > default and that no one has complained about this, I think it's safe to say that
> > unless we can provide a minimal patch, fixing this in LTS kernels isn't a priority.
> > 
> > Alternatively, I'm tempted to simply drop support for host/guest mode.  It clearly
> > hasn't been well tested, and given the lack of bug reports, likely doesn't have
> > many, if any, users.  And I'm guessing the overhead needed to context switch all
> > the RTIT MSRs makes tracing in the guest relatively useless.
> 
> As a control flow trace, it is not affected by context switch overhead.

Out of curiosity, how much is Intel PT used purely for control flow tracing, i.e.
without caring _at all_ about perceived execution time?

> Intel PT timestamps are also not affected by that.

Timestamps are affected because the guest will see inexplicable jumps in time.
Those gaps are unavoidable to some degree, but context switching on every entry
and exit is 

> This patch reduces the MSR switching.

To be clear, I'm not objecting to any of the ideas in this patch, I'm "objecting"
to trying to put band-aids on KVM's existing implementation, which is clearly
buggy and, like far too many PMU-ish features in KVM, was probably developed
without any thought as to how it would affect use cases beyond the host admin
and the VM owner being a single person.  And I'm also objecting, vehemently, to
sending anything of this magnitude and complexity to LTS kernels.

> > /me fiddles around
> > 
> > LOL, yeah, this needs to be burned with fire.  It's wildly broken.  So for stable@,
> 
> It doesn't seem wildly broken.  Just the VMM passing invalid CPUID
> and KVM not validating it.

Heh, I agree with "just", but unfortunately "just ... not validating" a large
swath of userspace inputs is pretty widly broken.  More importantly, it's not
easy to fix.  E.g. KVM could require the inputs to exactly match hardware, but
that creates an ABI that I'm not entirely sure is desirable in the long term.

> > I'll post a patch to hide the module param if CONFIG_BROKEN=n (and will omit
> > stable@ for the previous patch).
> > 
> > Going forward, if someone actually cares about virtualizing PT enough to want to
> > fix KVM's mess, then they can put in the effort to fix all the bugs, write all
> > the tests, and in general clean up the implementation to meet KVM's current
> > standards.  E.g. KVM usage of intel_pt_validate_cap() instead of KVM's guest CPUID
> > and capabilities infrastructure needs to go.
> 
> The problem below seems to be caused by not validating against the *host*
> CPUID.  KVM's CPUID information seems to be invalid.

Yes.

> > My vote is to queue the current code for removal, and revisit support after the
> > mediated PMU has landed.  Because I don't see any point in supporting Intel PT
> > without a mediated PMU, as host/guest mode really only makes sense if the entire
> > PMU is being handed over to the guest.
> 
> Why?

To simplify the implementation, and because I don't see how virtualizing Intel PT
without also enabling the mediated PMU makes any sense.

Conceptually, KVM's PT implementation is very, very similar to the mediated PMU.
They both effectively give the guest control of hardware when the vCPU starts
running, and take back control when the vCPU stops running.

If KVM allows Intel PT without the mediated PMU, then KVM and perf have to support
two separate implementations for the same model.  If virtualizing Intel PT is
allowed if and only if the mediated PMU is enabled, then .handle_intel_pt_intr()
goes away.  And on the flip side, it becomes super obvious that host usage of
Intel PT needs to be mutually exclusive with the mediated PMU.

> Intel PT PMU is programmed separately from the x86 PMU.

Except for the minor detail that Intel PT generates PMIs, and that PEBS can log
to PT buffers.  Oh, and giving the guest control of the PMU means host usage of
Intel PT will break the host *and* guest.  The host won't get PMIs, while the
guest will see spurious PMIs.

So I don't see any reason to try to separate the two.

> > [ 1458.686107] ------------[ cut here ]------------
> > [ 1458.690766] Invalid MSR 588, please adapt vmx_possible_passthrough_msrs[]
> 
> VMM is trying to set a non-existent MSR.  Looks like it has
> decided there are more PT address filter MSRs that are architecturally
> possible.
> 
> I had no idea QEMU was so broken.  

It's not QEMU that's broken, it's KVM that's broken.  

> I always just use -cpu host.

Yes, and that's exactly the problem.  The only people that have ever touched this
likely only ever use `-cpu host`, and so KVM's flaws have gone unnoticed.

> What were you setting?

I tweaked your selftest to feed KVM garbage.
