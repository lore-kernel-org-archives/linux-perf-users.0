Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5628F4;
	Mon,  1 Jul 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848086; cv=none; b=jDnjx5FpHxHOI8gajn/llJTrOF4+riEuA252mxM2551ONlC4NyENTGAdXZgwvXaNYklAG482tqAL4bRYy8nvRSMkSVwYv6ctJ/fUj+ofnLHS0kTL+NyX+6FXQfoRSXIePzkWo8s8G5/OcPwn7S7uW34i/0wrc8xyjk2QhKZORAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848086; c=relaxed/simple;
	bh=iq8bWnF6w36ZZ3oKBLDL7Q66Va//VDQRpFTyD5AraCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnT1wDuNTktSuScjWDngLrPqb/FpAPbOeEt5NqWlIQX7s+tfdE9hE0I8XydPEoJz1pmmUSGNV3IUvEYadUcOo57ZmMHUBJHwkKP7AdPf4c0vWV+DNpuucfDl2aOfGfHrf8fHmRkqp1qAEDS3gftdAsvDSAVk4VH35YBgB9EhJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eW64tHs7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eW64tHs7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719848084; x=1751384084;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iq8bWnF6w36ZZ3oKBLDL7Q66Va//VDQRpFTyD5AraCo=;
  b=eW64tHs7rEe1TdVUZRaLDRCc/bXFVf9LuGFNkqez9CQUAkMxeDxDPJnX
   +usxlRBqxJTjjaGdDATFHPPvpHryFFtSsolsJSOM1HSWmrfhQWOQqk7YA
   jbgJSJjMZ8mZVymG6Q96YJm4kBvL4CLSfzy9QCSUVQilOmeS/xf/z7lpF
   7Focolt2bhn+g21hp0sucOQ/32fUwK9BzYx2+vxB0JjydFT5rIP0kvsaW
   Efp5Hw3yKYAB1vt0h7Fo9f50APFzWOvoHMMgvJGexDNQOrei58gt8bcJH
   SBfh2Y4cguOLQojl5ZHAZCgBGPTm+kZ5jm7/OqQbITSynzovECJQGpBxX
   A==;
X-CSE-ConnectionGUID: o5KnzWbJRoaa5bdlmehGXw==
X-CSE-MsgGUID: v5om0M9TRwGLtAK5OvzHEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34527578"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34527578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:34:43 -0700
X-CSE-ConnectionGUID: YfCSuWqcRQ+x9qFnKqd/Gw==
X-CSE-MsgGUID: Y6xwroDyRqScS3SLIcaBvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="50446989"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:34:44 -0700
Date: Mon, 1 Jul 2024 08:39:56 -0700
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
 Sohil" <sohil.mehta@intel.com>, Zeng Guang <guang.zeng@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 06/11] KVM: VMX: Expand FRED kvm entry with event
 data
Message-ID: <20240701083956.4460bb06@jacob-builder>
In-Reply-To: <d385c639-d2b1-4068-b386-98c456265926@zytor.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-7-jacob.jun.pan@linux.intel.com>
	<d385c639-d2b1-4068-b386-98c456265926@zytor.com>
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


On Fri, 28 Jun 2024 21:01:28 -0700, Xin Li <xin@zytor.com> wrote:

> On 6/28/2024 1:18 PM, Jacob Pan wrote:
> > From: Zeng Guang <guang.zeng@intel.com>
> > 
> > For VM exits caused by events (NMI, #DB, and #PF) delivered by FRED, the
> > event data is saved in the exit-qualification field. (FRED spec.
> > 10.6.2)  
> 
> I don't like mentioning #DB/#PF here, they belong to the guest that was 
> running, and KVM handles them.
It is part of the spec.

> While NMIs belong to host, and the host NMI handler needs event data
> saved in VMCS in NMI induced VM exits.
> 
> Or you paint a full picture.
I will add your explanation that #DB/#PF belong to the guest so readers can
get a full picture of both usage and spec.
> 
> > Expand FRED KVM entry interface to include the event data obtained from
> > the exit qualification.
> > 
> > Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 


Thanks,

Jacob
