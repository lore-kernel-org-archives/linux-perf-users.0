Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D647A6A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877428; cv=none; b=VSc68CJgFyUM5ZGKjUlxwxlg9ArzhDZ3GdtGnQmCGE0eeX+5TfN9mm0FZmxgHFOFaLkOEEoj/1MNfYtA2Z3PKkySS8sUlQPJi8pQDzc/SrdMu20a80vtzENdni+C/Ux0LEKdH7JNAZoaEO3riipbkSyPHxarFeari6d2UKIU7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877428; c=relaxed/simple;
	bh=BpVlVa98Ld8N5k9yDGC7wHjA38fX++HWC68Q50KplEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dLZ+4DIvfIODL4qWl7lFyfdZuM5DG/xx3h1W5hLpWTbIgO29MGfHAzNxXJrxUybaUwpGMt/VTWqmzs7pyiMMXjB6oXAWbD7/AK3cvAYVR+x/H+Q+CFIfG3IdGafs7leHXEFKEbCy1yg/YYuWrlHlGRCjoO/W2pygGK/Iwzjov4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWZcZKLB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWZcZKLB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e2b743d8e3so3449745ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877427; x=1713482227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaEKPQTfggD2ocO67Q/mDYf6kXhBuyVqa9iBD72w+wg=;
        b=aWZcZKLBn1y7sJMp2f7AVhsDaHqe2pAuwnpUz5r+6NnTbjbgIHxYS69qzAWbC9NnVR
         aGSVHYPL7GJsy2r0edzuB35fazSSSKkL/xU7n4eTfSJ7p4vb94xzOKJkKeFe/2iLq3Fq
         P3dhqhLNh7cJVPcKfwCX+PmD7UoogEgF1sr1/bo1k0oYfJbdMSxdsXdsnZ84EIBmdVj4
         XUbgzPfEhpdXrH2pG89w4v5WS1HRVvA1nmDFHYYtUhvSHTq7soWeSRsAPOXxZBbUXMHa
         GN9FOwSvBPFqZMRXvYDnG20QhEc2Sl+EVD5lSWVrENqxFbQNkmm9h9g3FnhJhrYnB1gr
         x4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877427; x=1713482227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaEKPQTfggD2ocO67Q/mDYf6kXhBuyVqa9iBD72w+wg=;
        b=bA4wW8BYkHo2SVdiefIlUk5t9XnI7bkOiUDltFHZ1zhWUseVmyd7VEjqkfZVvwLLbi
         4qj8n4siRz3HVuIrutexZr20GJlUTeHMlT2mUSnM2BXsTV8pYfqsKPYISHtrZmME88N9
         XjVPApG/8V7yv7ptkKhVj5iSJR3hHJ7DSzoGRzRNBqQ5uySw5OH3t2sye236o/oYVn4f
         4bPLH7QWYbUDIrmkXdxWgjDeVkdxH5sR0UZgvL8wo5CzWyJQPQ3gtNUT+C89mfKg8R2L
         pQNmehNwh4qUzOJkJC+Hx+dHpdg7vFH9hmn3lG1b7Hj8gBGSwAKtjBPRDq6R1CY7hzcN
         JOxw==
X-Forwarded-Encrypted: i=1; AJvYcCWN8ad98nQ/Nd8+dj9KZyXsybAyfoiCrdYEVnlYq970+5OMgEVPkFdAXbjWWfKJdc9HvRM697hrd+zOvCWkpND95Om7zOyCHFAIun/utey4lw==
X-Gm-Message-State: AOJu0YyWQPzYRnt2G2orU0s3LwMyh6cWAKbuYD6fXJJvt2HgMsjQTT8I
	uiE9nlQURjXYkYy4UBk0p8qTyMPSMQC7NVG21MvAF5vSSsai8QkPtgtPwF3Z56Kh5Cbys7zZkjC
	qKQ==
X-Google-Smtp-Source: AGHT+IFkh8UwGORNfKAIhGU1TPD5433RiqkcctsyOHy6puas+6uDcvtX8qjhjvOj/SL+DVl0b2HUd131kpU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2444:b0:1e3:cf18:7336 with SMTP id
 l4-20020a170903244400b001e3cf187336mr3032pls.2.1712877426911; Thu, 11 Apr
 2024 16:17:06 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:17:05 -0700
In-Reply-To: <ZhhucuZcaCKVPb5R@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-40-xiong.y.zhang@linux.intel.com> <ZhhucuZcaCKVPb5R@google.com>
Message-ID: <Zhhvcd1R_uz_xbRU@google.com>
Subject: Re: [RFC PATCH 39/41] KVM: x86/pmu: Implement emulated counter
 increment for passthrough PMU
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 11, 2024, Sean Christopherson wrote:
> > +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> > +	int bit;
> > +
> > +	for_each_set_bit(bit, pmu->incremented_pmc_idx, X86_PMC_IDX_MAX) {
> 
> I don't love the "incremented_pmc_idx" name.  It's specifically for emulated
> events, that should ideally be clear in the name.
> 
> And does the tracking the emulated counters actually buy anything?  Iterating
> over all PMCs and checking emulated_counter doesn't seem like it'd be measurably
> slow, especially not when this path is likely writing multiple MSRs.
> 
> Wait, why use that and not reprogram_pmi?

If the name is a sticking point, just rename it to something generic, e.g.
dirty_pmcs or something.
