Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75115B548
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577649; cv=none; b=Ru1MpTQTTLCzqYSgmGMEQuc/rembBcVqo8EImUEnKMFxZqX4yvOWXJqiXt6QMOQhyWvaalQTQLJ1S2+9HDjn/SvsrdWaEjSJW3tEZdyuBP0cywaYd6uH+jKaqudciLBNq/nxJljj1RHh1cA1NkZyDzcV5NB0qQlLifqoRSnp7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577649; c=relaxed/simple;
	bh=rfo6WrL05Uv1mdf8iMrqyGzwf84jluFXeVL71/SG0kk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bp4wuV4nQaPCTakAe8O/iawM2OV485rHKq8ydbZ+eyE/2v4HQwbTtw5ZnIRSpxKcVqd0uBqxM4uQmLhIl5ZFU1vAvkzKmifPx9in0fvfOp7yW5VSnhZO3rlWutn99elOSdZL2iKVgDVHirrujuhWGTuHMeitFOwSJjgGpKxshZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtM3w5Gj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtM3w5Gj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726577647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dnX7lr3VdC9yR+xwsmK6CdHAwGmIVr6hdRq0iSA7Ck=;
	b=EtM3w5GjMoFwolsUqPt6uHGYE7nNhztC+H7VdK3QKN1w+Uq3yKF6WCD9hecRM6ejsa2NMp
	Jmnd7bXAqrrm9/4gCCQSRyjIaKxE8HGvhr7sVkDhNwmOfs0co3hwT5NxFTCoNgMmsJLGnf
	Gn5zApMGYvmcgcHaGJG529lXZ5VjSi0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-HD4kCnbQOZW2aRgi5kDjCg-1; Tue, 17 Sep 2024 08:54:06 -0400
X-MC-Unique: HD4kCnbQOZW2aRgi5kDjCg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c58e9bf10bso62772106d6.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 05:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726577646; x=1727182446;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dnX7lr3VdC9yR+xwsmK6CdHAwGmIVr6hdRq0iSA7Ck=;
        b=RsiyWZ0LUi4oYjGqOzjsKpTysJgoYBtulEbT2HTeCFrDFCUWWLPTWy5J1AiF2r8t3O
         dNd3BL4XBsJCwIsMLmzaRIEdAFJ3Y81zhjivpUQBwgdy3rLHRqdD+3qWrQbCrKpk/7x0
         JUbbdCRfCw8R0xGn2Hy2zBvGde745qvaf7e6rX6+4rY7rNqJX6kVuwT4KfyESke8ya8l
         D95xtDrI0pV9JPAYP2raUFEmPE3dnkzuSbsO+sdmavqHSCAraWi/Vm+lc5I7JWhW09IW
         EO8IOABSabiVWIqlRwJb7ZlGbsKNaBjwh5AVVwmOBxM+1PjWodbsIaLrjDmLk9aGQj2w
         1t8A==
X-Gm-Message-State: AOJu0YwTVM2emkBHI/3Wed41WC0EQXeD8aN2CPBIcqHZsjmw+7NE5Iz/
	xbYNw4doS7qQfX1rFAOp9RoyEtUD0YFYlXX0iWc1OIhhz2oIN7Eh5mWiLndUb6iIiV70NuaaG2b
	ZSL9KD4jJRZ0psGvOI10H8zCvFmPlBtB7JUKitRbcV1F0reGmcDFKTEgljDTEf7rVR0s=
X-Received: by 2002:a05:6214:5785:b0:6c5:b709:55c6 with SMTP id 6a1803df08f44-6c5b709588fmr8986896d6.42.1726577645605;
        Tue, 17 Sep 2024 05:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT/di6DIGvX5DqX9Xk7jmdH4sQo8rJ65EsZoGuZ5qlz3MMRGDDfqPT7m2eVyd/FNJWYlgm0Q==
X-Received: by 2002:a05:6214:5785:b0:6c5:b709:55c6 with SMTP id 6a1803df08f44-6c5b709588fmr8986706d6.42.1726577645314;
        Tue, 17 Sep 2024 05:54:05 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c627cb2sm34197216d6.1.2024.09.17.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:54:05 -0700 (PDT)
Message-ID: <36f601823359ed6d694d42c6c79e11a0403b0da3.camel@redhat.com>
Subject: Re: Small question about reserved bits in
 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sandipan Das <sandipan.das@amd.com>, dongli.zhang@oracle.com
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Date: Tue, 17 Sep 2024 08:54:04 -0400
In-Reply-To: <04a91009-c160-4920-a5d0-81a8e1e7cf97@amd.com>
References: <5ddfb6576d751aa948069edc905626ca27e175ae.camel@redhat.com>
	 <2e3f168c-3b0f-4f18-9db3-0cb2be69bb5c@oracle.com>
	 <04a91009-c160-4920-a5d0-81a8e1e7cf97@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-09-17 at 11:22 +0530, Sandipan Das wrote:
> On 9/17/2024 2:11 AM, dongli.zhang@oracle.com wrote:
> > On 9/16/24 11:54 AM, Maxim Levitsky wrote:
> > > Hi!
> > > 
> > > We recently saw a failure in one of the aws VM instances that causes the following error during the guest boot:
> > > 
> > >  0.480051] unchecked MSR access error: WRMSR to 0xc0000302 (tried to write 0x040000000000001f) at rIP: 0xffffffff96c093e2 (amd_pmu_cpu_reset.constprop.0+0x42/0x80)
> > > 
> > > 
> > > I investigated the issue and I see that the hypervisor does expose PerfmonV2, but not the LBRv2 support:
> > > 
> > > #  cpuid -1 -l 0x80000022 
> > > CPU:
> > >    Extended Performance Monitoring and Debugging (0x80000022):
> > >       AMD performance monitoring V2         = true
> > >       AMD LBR V2                            = false
> > >       AMD LBR stack & PMC freezing          = false
> > >       number of core perf ctrs              = 0x5 (5)
> > >       number of LBR stack entries           = 0x0 (0)
> > >       number of avail Northbridge perf ctrs = 0x0 (0)
> > >       number of available UMC PMCs          = 0x0 (0)
> > >       active UMCs bitmask                   = 0x0
> > > 
> 
> That's expected. LBRv2 is currently not available to KVM guests. However, PerfMonV2 should be the
> only feature bit required to indicate the availability of MSRs 0xc0000300..0xc0000303
> 
> > > I also verified that I can write 0x1f to 0xc0000302 but not 0x040000000000001f:
> > > 
> > > # wrmsr 0xc0000302 0x1f
> > > # wrmsr 0xc0000302 0x040000000000001f
> > > wrmsr: CPU 0 cannot set MSR 0xc0000302 to 0x040000000000001f
> > > #
> > > 
> > > The AMD's APM is not clear on what should happen if unsupported bits are attempted to be cleared
> > > using this MSR.
> > > 
> > > Also I noticed that amd_pmu_v2_handle_irq writes 0xffffffffffffffff to this msr.
> > > It has the following code:
> > > 
> > > 
> > > 	WARN_ON(status > 0);
> > > 
> > > 	/* Clear overflow and freeze bits */
> > > 	amd_pmu_ack_global_status(~status);
> > > 
> > > 
> > > This implies that it is OK to set all bits in this MSR.
> > > 
> 
> It is, but writes to the reserved bits are ignored.
> 
> > To share my data point on QEMU+KVM: I am not able to reproduce with the most
> > recent QEMU (not AWS) + below patch.
> > 
> > [PATCH v2 2/4] i386/cpu: Add PerfMonV2 feature bit
> > https://lore.kernel.org/all/69905b486218f8287b9703d1a9001175d04c2f02.1723068946.git.babu.moger@amd.com/
> > 
> > Both my VM and KVM are 6.10.
> > 
> > vm# cpuid -1 -l 0x80000022
> > CPU:
> >    Extended Performance Monitoring and Debugging (0x80000022):
> >       AMD performance monitoring V2         = true
> >       AMD LBR V2                            = false
> >       AMD LBR stack & PMC freezing          = false
> >       number of core perf ctrs              = 0x6 (6)
> >       number of LBR stack entries           = 0x0 (0)
> >       number of avail Northbridge perf ctrs = 0x0 (0)
> >       number of available UMC PMCs          = 0x0 (0)
> >       active UMCs bitmask                   = 0x0
> > 
> > 
> > Both writes are passed.
> > 
> > vm# wrmsr 0xc0000302 0x1f
> > vm# wrmsr 0xc0000302 0x040000000000001f
> > 
> > Here is bcc output. Both writes are good.
> > 
> > kvm# /usr/share/bcc/tools/trace -t -C 'kvm_pmu_set_msr "%x", retval'
> > ... ...
> > 4.748614 19  43545   43550   CPU 0/KVM       kvm_pmu_set_msr  0
> > 10.97396 19  43545   43550   CPU 0/KVM       kvm_pmu_set_msr  0
> > 
> 
> Thanks for testing. I cannot replicate this either with an upstream kernel.


Hi,

I also tested on bare metal Zen4 system just now, and I also see that MSR 0xc0000302 can be set
to any value.

So this is a hypervisor bug, I'll report it to AWS.

Best regards,
	Maxim Levitsky

> 
> - Sandipan
> 


