Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B178BC05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjATRcu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjATRcr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 12:32:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4676FD07
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 09:32:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x24-20020a17090ab01800b00229f43b506fso4685643pjq.5
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 09:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzZUJul5MFooCmTKNeGi62hfP4UpWHkt4+Ru2KtJQLY=;
        b=aM5VYrG8H6wfMgb95CrnoI5K5qT7KmlmewMqPewyGYYwVwaWZUZBrXNmSp1twxgt4C
         dxmczf3JkD+VgZRymajOXqM4E58gW5vtSO3r2Lhi9B6N3DoJXgSN3WaMVKd/U23cuMSt
         +q6U2/OQSwMeuD2CP2VMWPvwlxOiK678b4/BffGvuiGSTsegWNYepfBamTFtI9De16X5
         mRXAHThO0veBT7YjDu4Pt82yh4qeqeknhJN8w6dddBRj8mrRo68P70xci0CDzD8prZdD
         Gfsy++xqIPyZGtdj94Yuv66GCVzXvMXsS+GfUH7qFKikgVQ/UExX9e/Pp5Ad/5/GaEWg
         iccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzZUJul5MFooCmTKNeGi62hfP4UpWHkt4+Ru2KtJQLY=;
        b=PLxj7g+0bf+zU1tfThQz1UoPvoZBnVkMDsg9G0MC1zVoFw/ebNHKWRiRSo9xviRfcB
         oYvn1vNLGLVLoXWQlYpMQR/UwbI/t/eux7dRSlFdzrtk/09IkAddP30ezqoRs/4bZPf+
         kNJq2Oo7kyRHsrqMWqVHPDX91V2l59bxNE4gvEwA028n78yVyH3bTxPzduSjk+2EuyDE
         Q48ZVCgFB5X5/wbAt5qvdteENeoR0mf/G7EJLGjpGx0fX2tl3khzrYg2oXM5x6nZEEj7
         cvMM9ItZLNabGrC2+SIpwD4siFsIuJDNsUA8oiSGWQIo6z5atc3bLACFwdgRKyEg1OV5
         W3bA==
X-Gm-Message-State: AFqh2krUXm87o4lMjs5Wdd4ihUpE2aINbhLNdxsbWfC6bQXnFhajiOTN
        pbOfhgqbOD2t4VR+2OrqwxlEHQ==
X-Google-Smtp-Source: AMrXdXs2ofj8TfyAiMiN1pQk1GK+kciLgaHCBrMx504KETYVQR92DTLijuncdiR8KnKxceGB8ubXwA==
X-Received: by 2002:a05:6a20:54a8:b0:b9:14e:184b with SMTP id i40-20020a056a2054a800b000b9014e184bmr336338pzk.3.1674235946362;
        Fri, 20 Jan 2023 09:32:26 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b0019460ac7c6asm3871334plk.283.2023.01.20.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:32:25 -0800 (PST)
Date:   Fri, 20 Jan 2023 17:32:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host
 PMUs)
Message-ID: <Y8rQJf3ki8a1aRjW@google.com>
References: <20230120004051.2043777-1-seanjc@google.com>
 <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 20, 2023, Liang, Kan wrote:
> 
> On 2023-01-19 7:40 p.m., Sean Christopherson wrote:
> > Disable KVM support for virtualizing PMUs on hosts with hybrid PMUs until
> > KVM gains a sane way to enumeration the hybrid vPMU to userspace and/or
> > gains a mechanism to let userspace opt-in to the dangers of exposing a
> > hybrid vPMU to KVM guests.
> > 
> > Virtualizing a hybrid PMU, or at least part of a hybrid PMU, is possible,
> > but it requires userspace to pin vCPUs to pCPUs to prevent migrating a
> > vCPU between a big core and a little core, requires the VMM to accurately
> > enumerate the topology to the guest (if exposing a hybrid CPU to the
> > guest), and also requires the VMM to accurately enumerate the vPMU
> > capabilities to the guest.
> 
> Current kernel only return the common counters to KVM, which is
> available on both e-core and p-core. In theory, there should be no
> problem with the migration between cores. You don't have to pin vCPU.
> The only problem is that you probably can only use the architecture events.

And how exactly is KVM supposed to tell the guest that it can only use
architectural events?  I see CPUID bits that enumerate which architectural events
are supported, but I'm not seeing anything that says _only_ architectural events
are supported.

> There is nothing wrong for the information provided by the kernel. I
> think it should be a KVM issue (my guess is the CPUID enumeration.) we
> should fix rather than simply disable the PMU for entire hybrid machines.

I'm not arguing this isn't KVM's problem, and I'm all for proper enabling in KVM,
but I'm not seeing any patches being posted.  In the meantime, we've got bug reports
coming in about KVM guests having PMU problems on hybrid hosts, and a pile of
evidence that strongly suggests this isn't going to be fixed by a one-line patch.

Again, I'm not against enabling vPMU on hybrid CPUs, but AFAICT the enabling is
non-trivial and may require new uAPI to provide the necessary information to
userspace.  As a short term fix, and something that can be backported to stable
trees, I don't see a better alternative than disabling vPMU support.
