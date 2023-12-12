Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgsCkjFV"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BDED3
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 07:39:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbc68661060so3382818276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 07:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702395570; x=1703000370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p54hpe335w06rR0ZHj0lKwXGwdjAp5UI+KSbZqm/9GM=;
        b=jgsCkjFVqbsbHCnXGh9IbrKmspOTx+9FeN06ZTRWhWczMQdewb7PtS0juKhjjLDn2Y
         0NzpSepbjmWKC6dTm+YuReARncZDhtPjImCDmS26zrNCkBg2PsToOMcE7HPb8H1qHsJh
         +HKvdcI10BQpy5/ohlm1R9ShoePrRJvR0QgM2fVSNbx7f9G8HRvEoeDudhQEDydgUB7i
         rtp91LDhKvgf0ZZIKsj26l5esHIydD5snGxepSp6mjMX66VvvU4RaTuYRVVfhZPaYWj+
         IpSutVlbqUf+/Xxxkd8WHQAndFARaPc9Uj4o1hXOTjntlzTREVLzX6WSzUwdjiWgoIeM
         Ih/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702395570; x=1703000370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p54hpe335w06rR0ZHj0lKwXGwdjAp5UI+KSbZqm/9GM=;
        b=HTC+/Uiq4l4F1f12n9xlZ0bvboJSFU8ChHjIvLqgOO0NvaxbRXvEgF1+Yz3IkZh+yF
         CPty8JLRsGnRBvwQ7xtE1v7Yn70x05kRszVn3Sux71VWu6Vw1r+6DJjrUfP+Ynp9w9c1
         PV2kAK7YQxu5MWkRvMDUza3F2/GPLI8849aUemyV0zDSPt068BbjMu1Ha5/a4vlEw5x8
         UGVDF/WKFJOkmmETn+yC9MIlTZnScjP4tvrxAxo5UyfTM3mOFZbDurK8YAjpElu9u5wW
         YDc+exh6SzbFUaS6TN1ul3pWQZvtW3d8PdpUSvNyjwepahj/XYfMdOK9WT89B56DkAzy
         dyYg==
X-Gm-Message-State: AOJu0YwIv0FcicFtS5jYRfEa0ABD56W9+sWhIOy2nLnyl5rIv4dR12Cn
	Hk4A7orhxFY0XXpzcsPXk07XqBanclc=
X-Google-Smtp-Source: AGHT+IFKi0uRKRa7W+9Uw7FzkHJJ2V/r3TZFyxuh8FHz/g4bsH12mqF/muLdnvbE4DOmcwVLfCIoEGZHJ34=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:783:0:b0:db5:4766:e363 with SMTP id
 b3-20020a5b0783000000b00db54766e363mr45369ybq.6.1702395570470; Tue, 12 Dec
 2023 07:39:30 -0800 (PST)
Date: Tue, 12 Dec 2023 07:39:29 -0800
In-Reply-To: <SYBPR01MB687083237B0E5C03B63EDAB99D88A@SYBPR01MB6870.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <SYBPR01MB687069BFC9744585B4EEF8C49D88A@SYBPR01MB6870.ausprd01.prod.outlook.com>
 <SYBPR01MB687083237B0E5C03B63EDAB99D88A@SYBPR01MB6870.ausprd01.prod.outlook.com>
Message-ID: <ZXh-sRZQWvJYn0uJ@google.com>
Subject: Re: [PATCH v3 4/5] perf kvm: Support sampling guest callchains
From: Sean Christopherson <seanjc@google.com>
To: Tianyi Liu <i.pear@outlook.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com, 
	mlevitsk@redhat.com, maz@kernel.org, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Dec 10, 2023, Tianyi Liu wrote:
> This patch provides support for sampling guests' callchains.
> 
> The signature of `get_perf_callchain` has been modified to explicitly
> specify whether it needs to sample the host or guest callchain. Based on
> the context, `get_perf_callchain` will distribute each sampling request
> to one of `perf_callchain_user`, `perf_callchain_kernel`,
> or `perf_callchain_guest`.
> 
> The reason for separately implementing `perf_callchain_user` and
> `perf_callchain_kernel` is that the kernel may utilize special unwinders
> like `ORC`. However, for the guest, we only support stackframe-based
> unwinding, so the implementation is generic and only needs to be
> separately implemented for 32-bit and 64-bit.
> 
> Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> ---
>  arch/x86/events/core.c     | 63 ++++++++++++++++++++++++++++++++------
>  include/linux/perf_event.h |  3 +-
>  kernel/bpf/stackmap.c      |  8 ++---
>  kernel/events/callchain.c  | 27 +++++++++++++++-
>  kernel/events/core.c       |  7 ++++-
>  5 files changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 40ad1425ffa2..4ff412225217 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2758,11 +2758,6 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  	struct unwind_state state;
>  	unsigned long addr;
>  
> -	if (perf_guest_state()) {
> -		/* TODO: We don't support guest os callchain now */
> -		return;
> -	}
> -
>  	if (perf_callchain_store(entry, regs->ip))
>  		return;
>  
> @@ -2778,6 +2773,59 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  	}
>  }
>  
> +static inline void
> +perf_callchain_guest32(struct perf_callchain_entry_ctx *entry,
> +		       const struct perf_kvm_guest_unwind_info *unwind_info)
> +{
> +	unsigned long ss_base, cs_base;
> +	struct stack_frame_ia32 frame;
> +	const struct stack_frame_ia32 *fp;
> +
> +	cs_base = unwind_info->segment_cs_base;
> +	ss_base = unwind_info->segment_ss_base;
> +
> +	fp = (void *)(ss_base + unwind_info->frame_pointer);
> +	while (fp && entry->nr < entry->max_stack) {
> +		if (!perf_guest_read_virt((unsigned long)&fp->next_frame,

This is extremely confusing and potentially dangerous.  ss_base and
unwind_info->frame_pointer are *guest* SS:RBP, i.e. this is referencing a guest
virtual address.  It works, but it _looks_ like the code is fully dereferencing
a guest virtual address in the hose kernel.  And I can only imagine what type of
speculative accesses this generates.

*If* we want to support guest callchains, I think it would make more sense to
have a single hook for KVM/virtualization to fill perf_callchain_entry_ctx.  Then
there's no need for "struct perf_kvm_guest_unwind_info", perf doesn't need a hook
to read guest memory, and KVM can decide/control what to do with respect to
mitigating speculatiion issues. 

> +					  &frame.next_frame, sizeof(frame.next_frame)))
> +			break;
> +		if (!perf_guest_read_virt((unsigned long)&fp->return_address,
> +					  &frame.return_address, sizeof(frame.return_address)))
> +			break;
> +		perf_callchain_store(entry, cs_base + frame.return_address);
> +		fp = (void *)(ss_base + frame.next_frame);
> +	}
> +}
