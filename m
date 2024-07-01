Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206053AC;
	Mon,  1 Jul 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848498; cv=none; b=Frs2gIWx7AJmbxp40MW7cSlbFRWPVPHJYpP3mgTdwToyrmfrVoAwXAFGEH9bLEsCKN7ILZulbGTlHhzXMV2Jy8LUYBHMUg1cKPqvZGGO4OLzXh2UwlMYvO3UhgJvSwZcIF5hbN5u0HhgcXWCmgjHXHjY+a/MV0Y3zusAOwemY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848498; c=relaxed/simple;
	bh=y4/4hoQ8Bg4wG8GNer7UrOuI1EBVEk3lTJGhZjRtEc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCiEKrtk3l1prJWCWOBcWU8NgE3PPzlwnihEiznhL1+4EwTQUtYlHZXwE41D/b+PhJ6tbyxK1lmpj53knojJzVIuVsMr9X7okbScNuUJf6gBE1rBeqAVdsln/iYJ4ZDrQfZ5+hLEXeVGFPnu8H+1cXjvKqQ6HRj14QY3IZ57oAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5f3GDVt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5f3GDVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719848497; x=1751384497;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y4/4hoQ8Bg4wG8GNer7UrOuI1EBVEk3lTJGhZjRtEc0=;
  b=m5f3GDVtHXFXHKNxRx+Y3aRefH9drdkH3/aDmyj9cmezfmtZI2MNUDxW
   HqDNHuby/bZKpW/NTH9uk+AlIMqj5JcnygHp6EggGFjNzdQViq50ywmJE
   1QQRFUb+QaazdCuLtO/CJgyBkTc2+ib2j5IrY08YsJH7FLiwDjt2AlYV/
   6KOBkcfNprEIbMEI0xo9RroOldS2KuehBqMO97GsE/gFh2YI1t2LNS+4d
   +iaXlqFUDHfcS6jpWX34c+1lUYkEwBMLFR3GaylXovXWtLC3FoYDtIrn8
   trk5+9Z0IZ4D9orMLnk5sRR1SNPA7Rc6A6GHhMTttF3pFoU4+xrroDXiy
   w==;
X-CSE-ConnectionGUID: N4x7vwyPR2ukdeByb9rrLQ==
X-CSE-MsgGUID: 6JcSTg1MTSW8mgB4zPZPNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17111794"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17111794"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:41:35 -0700
X-CSE-ConnectionGUID: 6N8iEaWWQmSrO2R39EsDmg==
X-CSE-MsgGUID: 0LZZkzlpS2y5FOD3Bdbs9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45460970"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:41:34 -0700
Date: Mon, 1 Jul 2024 08:46:46 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Zeng Guang <guang.zeng@intel.com>
Cc: X86 Kernel <x86@kernel.org>, Sean Christopherson <seanjc@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Xin Li
 <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Tony Luck
 <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
 kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 07/11] KVM: VMX: Handle NMI Source report in VM exit
Message-ID: <20240701084646.268bfc86@jacob-builder>
In-Reply-To: <eeaf0647-e165-4736-97d0-a2856875c59d@intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-8-jacob.jun.pan@linux.intel.com>
	<eeaf0647-e165-4736-97d0-a2856875c59d@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Sun, 30 Jun 2024 21:04:18 +0800, Zeng Guang <guang.zeng@intel.com> wrote:

> On 6/29/2024 4:18 AM, Jacob Pan wrote:
> > From: Zeng Guang <guang.zeng@intel.com>
> >
> > If the "NMI exiting" VM-execution control is 1, the value of the 16-bit
> > NMI source vector is saved in the exit-qualification field in the VMCS
> > when VM exits occur on CPUs that support NMI source.
> >
> > KVM that is aware of NMI-source reporting will push the bitmask of NMI
> > source vectors as the exceptoin event data field on the stack for then
> > entry of FRED exception. Subsequently, the host NMI exception handler
> > is invoked which will process NMI source information in the event data.
> > This operation is independent of vCPU FRED enabling status.
> >
> > Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   arch/x86/entry/entry_64_fred.S |  2 +-
> >   arch/x86/kvm/vmx/vmx.c         | 11 ++++++++---
> >   2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64_fred.S
> > b/arch/x86/entry/entry_64_fred.S index a02bc6f3d2e6..0d934a3fcaf8 100644
> > --- a/arch/x86/entry/entry_64_fred.S
> > +++ b/arch/x86/entry/entry_64_fred.S
> > @@ -92,7 +92,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> >   	 * +--------+-----------------+
> >   	 */
> >   	push $0				/* Reserved, must be 0
> > */
> > -	push $0				/* Event data, 0 for
> > IRQ/NMI */
> > +	push %rsi			/* Event data for IRQ/NMI */
> >   	push %rdi			/* fred_ss handed in by the
> > caller */ push %rbp
> >   	pushf  
> Move this part to previous patch as it changes the common FRED api and 
> prepares for nmi handling in case of nmi
> source enabled in this patch.
You are right, will do.
>  [...]  


Thanks,

Jacob
