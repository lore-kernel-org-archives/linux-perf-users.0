Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296BC271450
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345904; cv=none; b=sXoN8k3bseQQP8KZminNeZsCO2UWfLNKuAaJZNzNAO1cK60EfG84Kw6RBCoHiFNX8FU4fknntLfCUuaxP+9KsaroIUuyNtqY/KAxZf54ORU32/AhwO9rWp8B1K+jupS7j1VNBoJ2N/J3ZjHQfZOEVP7uXJqIe+NKtVFvRoe3ZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345904; c=relaxed/simple;
	bh=SGREBuuKhZojW/qxb3YvvKLZ4Emj2RxLhOOQtbx0/ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNdwW4FkgmPM6LoBXwERsjPi8OUJkUuvqAtKsJAfhWC39WIVctMYkW6qpc/Tj8S7+Ug2lziYgquF3SwTnawiltu6bcJiapkRawVuW0EjJRaIKbayVcsR8GzqM9bPzPfGF7No3RqMD/AQRD4wC0gEDoXWGnQlXB92bPr90rCY+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLFrbygh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLFrbygh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a79164b686so58001575ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 08:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771345902; x=1771950702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VZfOz+HSVZa7yIGW57B4e3fv7GIVEIIOWdcsv8P8bE=;
        b=FLFrbyghd5p5Pu7OhJZNo3LLDlG1GvUzlaLBp4sH3GSwMFB9Ae8O9fDImkqDQb/b81
         WjR3lVm6BbC/XdJNcQlcbqOzet8Rf21+tK9Pp/+bjIHz3cQUXmSaB6/KCINfLwBSGrJy
         gTpy0eYR1Us/6mEznPt1jaX9/969KRNIcEKFhoD6jq4HQ3SglrIwaAqkFHFQFT2nVPhu
         Zq+TPZSEmddM5VuoHu2YhU+Cz9nQ7ILCDedc1zbaZ7LLq/wnaAc3NW0pg/eT5ZEMhTyZ
         e/UFHk8C2Xv9/ORvnuKaEdQQRyxaywbwxdWFp1tRI1VFigxTD7cPsgQCBwhn833BbTeb
         H1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771345902; x=1771950702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VZfOz+HSVZa7yIGW57B4e3fv7GIVEIIOWdcsv8P8bE=;
        b=Ug5o9S6VQpOX+Opv+htS8mQI3tj5OOjYxuZ9EbkjhhVFMAl1gSccgkmVyXyHsRfNTF
         H5hWmbcAPp9B51qk4MuL20pxDuThY04EN7kCu81iwOsyWMHiPHKrrynr8Rfj+sVDNXif
         /kNQ1hA0/TG+QyS09a+tNE8Ot5I+Q2/EF63K424h21RRxoUwhvgN5Lf5VgDXatsOmY6N
         +itdb9rdKQ+fmzeZEZd3vk8N5Wrk2ZzKxlv9pB5giJMPdK+tbsMvFwHIPvcj9WjiHKR0
         JKoBfdpagV7sde+hpInPDWLJIqHLJLm2yJK79nVfDNucLHvQiZmhNJ/MaUsTWUxq1bb3
         c26w==
X-Forwarded-Encrypted: i=1; AJvYcCXFLuuqst2LFx8ITbYnnFntEUYxNovwFY4xBrezWfHsgRvEFrQ6qwM1rz3QcuD3q5C3B5A5xYld955uFESf/Fgz@vger.kernel.org
X-Gm-Message-State: AOJu0YzoX47zk9Mn2RbVMflukqnGzF17a2BZnxZ2LDyUgbK+UFJ1n4kt
	7HowHWfiXw42N1AkeZmB/bSbqzFkyX7Av3PXLTc8rgcNQiJCn+Mmlc+OjE5NFyhC3v1bn0ytf2m
	AdmRKrw==
X-Received: from plbmi8.prod.google.com ([2002:a17:902:fcc8:b0:29f:1bbb:de14])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3843:b0:2aa:d671:e613
 with SMTP id d9443c01a7336-2ab50586724mr116397175ad.38.1771345902214; Tue, 17
 Feb 2026 08:31:42 -0800 (PST)
Date: Tue, 17 Feb 2026 08:31:40 -0800
In-Reply-To: <699383e5939ed_2f4a1006f@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com> <20260214012702.2368778-6-seanjc@google.com>
 <699383e5939ed_2f4a1006f@dwillia2-mobl4.notmuch>
Message-ID: <aZSX7OU58Gj0fQSy@google.com>
Subject: Re: [PATCH v3 05/16] x86/virt: Force-clear X86_FEATURE_VMX if
 configuring root VMCS fails
From: Sean Christopherson <seanjc@google.com>
To: dan.j.williams@intel.com
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 16, 2026, dan.j.williams@intel.com wrote:
> Sean Christopherson wrote:
> > If allocating and configuring a root VMCS fails, clear X86_FEATURE_VMX in
> > all CPUs so that KVM doesn't need to manually check root_vmcs.  As added
> > bonuses, clearing VMX will reflect that VMX is unusable in /proc/cpuinfo,
> > and will avoid a futile auto-probe of kvm-intel.ko.
> > 
> > WARN if allocating a root VMCS page fails, e.g. to help users figure out
> > why VMX is broken in the unlikely scenario something goes sideways during
> > boot (and because the allocation should succeed unless there's a kernel
> > bug).  Tweak KVM's error message to suggest checking kernel logs if VMX is
> > unsupported (in addition to checking BIOS).
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> [..]
> > diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
> > index 56972f594d90..40495872fdfb 100644
> > --- a/arch/x86/virt/hw.c
> > +++ b/arch/x86/virt/hw.c
> [..]
> > @@ -56,7 +56,7 @@ static __init int x86_vmx_init(void)
> >  		struct vmcs *vmcs;
> >  
> >  		page = __alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
> > -		if (!page) {
> > +		if (WARN_ON_ONCE(!page)) {
> 
> Is the warn_alloc() deep in this path not sufficient? Either way, this
> patch looks good to me.

Not sure, I don't have much experience with warn_alloc() in practice.  Reading
the code, my initial reaction is that I don't want to rely on warn_alloc() since
it's ratelimited.  Multiple allocation failures during boot seems unlikely, but
at the same time, the cost of the WARN_ON_ONCE() here is really just the handful
of bytes for the bug_table entry.
