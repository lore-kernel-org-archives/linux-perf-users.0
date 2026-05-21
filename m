Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE725B086
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372284; cv=none; b=J31vVFSmBQe++Axx2fY6ZiLI2XESnGJcnSs8zNaAK74oubdGwZXVzzSlMGgbXlDDhhi4viD4NOLA5ANCwRMWIXTqIDBSjYOX26xejWQYg1JV/m7NskK5poCtqWeOSIRBwRCcVrWFc6kO6RHyhUT0gZ5DsYDs9AuF94vefUYXqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372284; c=relaxed/simple;
	bh=NnstC5Hke9f+n/cl42WhEXFSYAsNvzvaQit4caagZaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VvV7IaknsNw4Vq2W3gKLT0/O+7BM+2aby157gveDic5D/k7jV9yRxw9YPDsr+osmB10frUYzLn0mbc4G5fBhUjx/lPvhbg1rOJFgFfmBOYe9Kgc6KWGg29Q4RhI3djw8zGuXzhTtrzDUSHhUsZebK+rD6nE1jFarnNryDQoT6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EemmA8cN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EemmA8cN"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8354503d9acso8020476b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779372282; x=1779977082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUtO7rz9VBhPIeAyEinR1g2aBGB2g8CuUCtOdEHoYPA=;
        b=EemmA8cNBpso7yPCHBanQLxIKLzSXtXcnkLIpurNMW+QtCh7cUZLCfV2f+VbG7Mbxr
         TVcRLNWy4H5618YiNoybkmu4K/03uyRngtF7nQujBTZ3m437p5TJrVlrYRNtXPdBbVnq
         GveyZKG7/SPYgL2gGvrXvLWMsNu75Ts6Hz+kkFdEnUTxTq8xQXW+v0ft51E0OqdXNJk7
         flnRaQaUDEFpIWApjySu7EHuR4Zd+wjw+REnOv9Mfpfi/bJXX8+OPcJaEP30na6RzXTZ
         hhrMT+bnjOVbnqXyK0TK23jXzngW6GAWaA3lepPPM5R9NsL1r2WU95p+mocyMYVdL7rF
         EPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372282; x=1779977082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUtO7rz9VBhPIeAyEinR1g2aBGB2g8CuUCtOdEHoYPA=;
        b=T6KirnHV9G7CGTU6TKIqPdZrTLHcZPxzB3xRlJ1mf2HkriZYSXOiUfiE806rCxNVYB
         dsAwaPUWmVuUyCv+NQYqA5dHkHlxHnZuD1fI77udKfQT6kWJgu29xmQp+nkjuJLYs3yP
         SQfXih0kzWYXf5kcHUBUgg4XuUqt9/yYXMhsCYc/s0ofjLRmM2g99rWlvnTdghh8FYAe
         gwsFQOOZ2/4Z85ROQCnk00YCBVKpykgXLQ+eoofBFZr23PZjHp31bpBAs1TTjjAEHQCt
         OJyiBV3jKNf35OqYQzjsKBjn3UD4EzB8TfkQHjLAH9nEKvfxeA2YC1yFsZujBz9BcdNH
         E5DA==
X-Forwarded-Encrypted: i=1; AFNElJ8sJRsyhS1C7St4JFP2ijKpDICLDn1J3aK2sKElNX3BtaZBbLpkHnG+Vdkk1JpVC+wDyXpYxg65E8X9dSMCTYfU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84i8P6QNXRAMutYteRp64NoFwQ4cXAkHQ1XQahxaZkqMDgEFo
	exlCszr6Lcn+F+Z7+rH3VBzNPXv/+ft9GfeQ9EwbeZG3tkfdYqQXXHC+2xt4IlSQyRlktrpF4VG
	OZdTbug==
X-Received: from pfblg6.prod.google.com ([2002:a05:6a00:7086:b0:839:7c0f:3e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21ca:b0:83e:e05d:ebb
 with SMTP id d2e1a72fcca58-8414adf7bf5mr3255925b3a.25.1779372282132; Thu, 21
 May 2026 07:04:42 -0700 (PDT)
Date: Thu, 21 May 2026 07:04:41 -0700
In-Reply-To: <a75397bd-6122-4fa8-8197-334b2fbbb5af@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-2-seanjc@google.com> <20260508234018.F06AEC2BCB0@smtp.kernel.org>
 <ccea937f-8ad5-4a6e-b6a4-917f2ee02579@linux.intel.com> <agZiTeGgRO4PJ9mI@google.com>
 <02461927-589b-4179-9f93-2f9e10172879@linux.intel.com> <a75397bd-6122-4fa8-8197-334b2fbbb5af@linux.intel.com>
Message-ID: <ag8Q-UM5dcVtBijd@google.com>
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: sashiko@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Dapeng Mi wrote:
> On 5/15/2026 9:49 AM, Mi, Dapeng wrote:
> > On 5/15/2026 8:01 AM, Sean Christopherson wrote:
> >>> Anyway, we could optimize the code further like below and thoroughly filter
> >>> away these extra bits. (only building, not test on real HW)
> >> Hmm, I think I'd rather figure out what it would take to drop the FIXME entirely.
> >> And if we need to keep the check, I'm a-ok risking false positives until we have
> >> a better understanding of why the check exists.
> > Kan Liang should be the best man who knows the history, but he has left
> > Intel. I would check this with other guys internally and look at if they
> > know the reason.
> 
> Just checked the commit history, It looks the reason of disabling guest
> PEBS here is to avoid breaking the host !exclude_guest PEBS event sampling.
> Host may create !exclude_guest event to profile both root and non-root
> mode, but it's conflicted with guest PEBS sampling in non-root mode. So
> guest PEBS sampling has to be disabled if there are active host PEBS
> events. Thanks.

But that doesn't make any sense, because the host can't use PEBS to sample non-root
mode due to the DS area being virtually addressed.  It's entirely possible that
was pure oversight, given that commit 58f6217e5d01 ("perf/x86/intel: KVM: Mask
PEBS_ENABLE loaded for guest with vCPU's value.") was necessary.

But I'm still not convinced: if that _really_ was the motivation, then I would
hope that scenario was at least smoke tested, and any testing whatsoever would
have crashed the guest.

Though given how buggy this code has been, I suppose it's plausible there was
simply testing.
