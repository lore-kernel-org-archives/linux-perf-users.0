Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEB19D8BA
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817541; cv=none; b=Cv0C7Sa9+DzgMk0Q9JIpM3+9Mje+mN/FsFd0N8mr8xwoso/BoG1HsPTDf96YOjXKVoXr/VlUMrRanZi169uwstJm5VkWwEIjVT1StlBg88WnNMyss8x+VOboxuWdtaKgb/Aaw6iKWtuPIsJrteVbrlVtr0wjFOiqzMkFxvMOU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817541; c=relaxed/simple;
	bh=VYbyF+HrdvVkrnYQc6ZeYy2CpWFPLnio/X4LukFYzkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cFvnCKglu75gtD9/Ce/J0IlURYJWX3asNs5aeewxTfnlOvZSpuV8W9Y5XJPcASB8/3BU25okKCa2RxvHE8SC8XlP/DLIyYzvBxOI6PTJBtGDaHeMvCK4rJXdjvnTVekDqhY1jLZQ2/ILTJNqdr5XmSbkm5Wo34CZsBzBj1akjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmxBUOIY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmxBUOIY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc6db23c74so18692945ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723817539; x=1724422339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVUNWcnODzvW6XJwZ456FKRnFRY00JOKX48IktR25GI=;
        b=PmxBUOIY2NgA4dj64oNnzBUd8+AXVafPiF7fNwEM7u6aBEJkliYR6q0eupBusXHVba
         vZXPjiNYqq06Ss73/gPQMLES0kJkMx0oz4zwOOg63Tct/UFUtQQhCRAh8q+AfnQZZpuz
         HRk+GHZvxy3zxbINxH6gFFWBZQwz4Sm5qDkENiZIPAPN9HDrG+7Tu4uhALLHvYboLyMq
         AHWLzeQYl7Jg839xvWV+wFFPahhxuVGZf7ZtdyzTiqo4NRQmc1AEj5dVDEvGYmIcGP1G
         wX9+uTT/ixlLLKF2W6FLB+08D671GhnXrV1RtBhej2ptD5s+cTy4WIOqVGCrEArsNWTk
         4p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817539; x=1724422339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVUNWcnODzvW6XJwZ456FKRnFRY00JOKX48IktR25GI=;
        b=Ur1hv0g5PH2dvtyAQ8NkTN/GIHItKzvauAFuq9hwhZ9Rl8a3/qTIe4A1e/rgRRyk7F
         8hhG1wyr1xWXew88w0xTDQu6Ef9WMC/lkdYpeJuo+uJl4K6uc9ij9fkJfRkdCsca50sS
         IiRfCjpBTcwzpi3KQkGwP+j1YhmvVj4G+MfmCsTbDR9FCdKuvsOe1D0DPbL4geH7UfLD
         Lxg6cUYI5LYbWDU7TxQQxviNVHX/9xeWkZVbIlb95P9Ce+HP75bSC8ed/VWB0LEUrnLZ
         +Embr2DddbMXK3zE9sUM9mrdj9k9/1OZFKnhOyVSfqFLnwE7k9Ezu4FZKPNHupTLscR0
         R16Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYNLcZJ+TDnofvxNGoXKvh05S78c6cl5AjHddWL8RG2Zm2P7GsmlH1UAFlm50wRkgmF0+n8+TYzLEZ3XVn2g65uPZSX82XfvA1bG3dC9IxFA==
X-Gm-Message-State: AOJu0YxeaO6sOwBFgG8rRPeHjCeIJfyja1yeLdZgUBSF78RomLbw3Jox
	9GC2x0nwOGZa+yf3bVHHF5xa0MJOT8Lm90by4rhdyG26VzV2SCDAfZZxjA/xyu8RWpPLK33Fwem
	5Tw==
X-Google-Smtp-Source: AGHT+IEos5VlUKVOnDmduYMZV8tHrIqQZABYxJlweDXmJYF7fazHvJwYey2AyH4pkayOILvlUEx0MNTjeNI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e750:b0:200:ac2c:677f with SMTP id
 d9443c01a7336-20203f1cda4mr1405185ad.7.1723817539299; Fri, 16 Aug 2024
 07:12:19 -0700 (PDT)
Date: Fri, 16 Aug 2024 07:12:17 -0700
In-Reply-To: <20240709143906.1040477-7-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com> <20240709143906.1040477-7-jacob.jun.pan@linux.intel.com>
Message-ID: <Zr9eQdiIa-RiHGTk@google.com>
Subject: Re: [PATCH v4 06/11] KVM: VMX: Expand FRED kvm entry with event data
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org, 
	kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Jacob Pan wrote:
> From: Zeng Guang <guang.zeng@intel.com>
> 
> According to FRED specification 10.6.2, VM exits triggered by events such as
> NMI, #DB, and #PF will have their event data stored in the exit-qualification
> field.
> 
> However, #DB and #PF are owned by the running guest, which is managed by KVM.

This is wrong.  #DB and #PF _may_ be guest #DBs/#PFs.  When host userspace is
debugging, #DBs may be the host's.  And when KVM is using shadow paging, or the
VM is running with a MAXPHYADDR smaller than the host's, #PF may be the host's
responsiblity.

> NMIs belong to the host, and the host NMI handler requires the event data
> stored in the VMCS for NMI-induced VM exits.
> 
> This patch enhances the FRED KVM entry interface to include the event data
  ^^^^^^^^^^
Documentation/process/maintainer-tip.rst

> derived from the exit qualification.

It's not "derived" from the exit qualification, it's stored there in the exact
format that's used by FRED.
