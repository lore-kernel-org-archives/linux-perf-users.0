Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1516CD21;
	Mon,  1 Jul 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853873; cv=none; b=A/y6Wo8+UDYJxwNeO1uI0GNEmLyhtEZu7fbv13rhIYiF2eYOPf2uogMe5AhO6kmx0fkVw46hSsl7EIXdj9vxjLeuHoap7ykeq+sBsFVxq2k/yqhehfyMWjatUpbYiU7Kr7Uq6y7VXGtkN3drC/s5KshKaLNifu1o1Z3/+PLZ/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853873; c=relaxed/simple;
	bh=/n8yXSU+8Zd0IVWtstzU65ZNdM1aKVu4Wfm3xjGnkGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3Wj00ZVtgHNBkFo8rAtxFiH02n+74w1LiQTr2USTVpXSDVxv93e7p7C7PJlYn51blC0kmpeuzYrZMUKvt5MfgwwAgXTh2KMuHx1bRT5QgCsH9IGGMFyqpsgygX9g88ZcpcIe/ooV6ntsxR/+UYV1CpSoiCMot24VN5aEAEdKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8N4nDHK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8N4nDHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719853873; x=1751389873;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/n8yXSU+8Zd0IVWtstzU65ZNdM1aKVu4Wfm3xjGnkGw=;
  b=h8N4nDHKSvIvHrWiTO+GXohWu+mjssrHBeUgLLl96uZXOqOB6POpjyV2
   u+VcGctfw5vGTovqZITqTbdFJkxWpK+6vgqptI4/j6d82vTWjYwi/AXBH
   y91ydGgMLjSc7yifDVV2AT2S5/td/n9qiz31AIOJWq34y4Cvo0KE9aQPu
   7M3npuNLRWyNx3xTp8oHACRkICX+EeKSnjm4TK9B0ubhQqPXpY+7J3ttb
   rVkSjrQ6By/+oVZp8eVg3iCvsC+lYS2Wc/4NhXmDnU3UIx5rnvm679uQW
   ptwbSM2Gt8t/zQ/OQHL3rL6zyU3+TwaGdhyYS3ZfoHRfj98TQ5Ahpml3N
   A==;
X-CSE-ConnectionGUID: ccy9PmpjQZyO9aRJGUDD7w==
X-CSE-MsgGUID: pnVRX8s5STqxENJK3oEWTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16821015"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="16821015"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:11:08 -0700
X-CSE-ConnectionGUID: zNo7PBA9QwyMt2yYyUiXAQ==
X-CSE-MsgGUID: QaFraCjcTsejU2VP8gGe4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="46328443"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:11:08 -0700
Date: Mon, 1 Jul 2024 10:16:19 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Xin Li <xin@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, Sean Christopherson <seanjc@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Xin Li
 <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Tony Luck
 <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
 kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 02/11] x86/irq: Define NMI source vectors
Message-ID: <20240701101619.63c65106@jacob-builder>
In-Reply-To: <a1d3b2dd-e4d0-4733-85a0-7d9f83c396a7@zytor.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-3-jacob.jun.pan@linux.intel.com>
	<a1d3b2dd-e4d0-4733-85a0-7d9f83c396a7@zytor.com>
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


On Sat, 29 Jun 2024 11:32:10 -0700, Xin Li <xin@zytor.com> wrote:

> On 6/28/2024 1:18 PM, Jacob Pan wrote:
> > When NMI-source reporting is supported, each logical processor maintains
> > a 16-bit NMI-source bitmap. It is up to the system software to assign
> > NMI sources for their matching vector (bit position) in the bitmap.
> > 
> > Notice that NMI source vector is in a different namespace than the IDT
> > vectors. Though they share the same programming interface/field in the
> > NMI originator.
> > 
> > This initial allocation of the NMI sources are limited to local NMIs in
> > that there is no external device NMI usage yet.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   arch/x86/include/asm/irq_vectors.h | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/irq_vectors.h
> > b/arch/x86/include/asm/irq_vectors.h index 13aea8fc3d45..e4cd33bc4fef
> > 100644 --- a/arch/x86/include/asm/irq_vectors.h
> > +++ b/arch/x86/include/asm/irq_vectors.h
> > @@ -105,6 +105,34 @@
> >   
> >   #define NR_VECTORS			 256
> >   
> > +/*
> > + * The NMI senders specify the NMI source vector as an 8bit integer in
> > their  
> 
> s/The NMI senders/NMI senders/
will do

> > + * vector field with NMI delivery mode. A local APIC receiving an NMI
> > will
> > + * set the corresponding bit in a 16bit bitmask, which is accumulated
> > until
> > + * the NMI is delivered.
> > + * When a sender didn't specify an NMI source vector the source vector
> > will
> > + * be 0, which will result in bit 0 of the bitmask being set. For out
> > of
> > + * bounds vectors >= 16 bit 0 will also be set.
> > + * When bit 0 is set, system software must invoke all registered NMI
> > handlers
> > + * as if NMI source feature is not enabled.  
> 
> Add empty lines in the above paragraph.
sounds good.

> > + *
> > + * Vector 2 is reserved for matching IDT NMI vector where it may be
> > hardcoded
> > + * by some external devices.
> > + *
> > + * The NMI source vectors are sorted by descending priority with the
> > exceptions
> > + * of 0 and 2.
> > + */
> > +#define NMI_SOURCE_VEC_UNKNOWN		0
> > +#define NMI_SOURCE_VEC_IPI_REBOOT	1	/* Crash reboot */
> > +#define NMI_SOURCE_VEC_IDT_NMI		2	/* Match IDT
> > NMI vector 2 */ +#define NMI_SOURCE_VEC_IPI_SMP_STOP	3	/*
> > Panic stop CPU */ +#define NMI_SOURCE_VEC_IPI_BT
> > 4	/* CPU backtrace */ +#define NMI_SOURCE_VEC_PMI
> > 5	/* PerfMon counters */ +#define NMI_SOURCE_VEC_IPI_KGDB
> > 	6	/* KGDB */ +#define NMI_SOURCE_VEC_IPI_MCE
> > 	7	/* MCE injection */ +#define
> > NMI_SOURCE_VEC_IPI_TEST		8	/* For remote and local
> > IPIs */ +#define NR_NMI_SOURCE_VECTORS		9  
> 
> Fix alignment.
Do you see alignment problem after the patch is applied? Alignment looks
good with vi, emacs, etc. passed checkpatch --strict.

> > +
> >   #ifdef CONFIG_X86_LOCAL_APIC
> >   #define FIRST_SYSTEM_VECTOR
> > POSTED_MSI_NOTIFICATION_VECTOR #else  
> 


Thanks,

Jacob
