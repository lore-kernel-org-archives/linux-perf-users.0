Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9339185C62
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536676; cv=none; b=u9058+qFphJIeNTa1VVHY8aiAErLOd8Vg8t08rcrxkrmv1hiDw/1mVou/sIU0/0P3RS9zNSwHn8YzWx8RKU2d0ljhnOOxjtOQU4En5fa6HEx0ObYsnqSigTSq6xXQUUWPtpTx3QwfqEXnEJF1oxlzdz0etJ6aeqnaI1j/Bf7bKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536676; c=relaxed/simple;
	bh=UGmvmYZQO1s/rOOEhPlSw35L4z315gaH5cVBwdtDIyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bPXmyB4SJlcruQyoFP24i0wPFIa3wBZMd5WHw7IHuUj8IUWskSO//3OxMrLKC7YxSZuKXFwiUeuN7kuhX+xhnlXyySjHbd7Se62bXsSQX6yK9//Fe56+il2sIRZW1JnTSnqtNXgb6FYjMcyN34lIW1dvwyqxFd9zIQu0EMWpWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJKgGRpX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJKgGRpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713536674; x=1745072674;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UGmvmYZQO1s/rOOEhPlSw35L4z315gaH5cVBwdtDIyE=;
  b=UJKgGRpXrfuZiQQfmuGGJl4kpbw+fdevA3NaR9pYEi3bWcCxohxC92i+
   71g4k20UkZrWP6LOw/XueoiIxvfIQBF2qkGvGVtb8MJTuUC8lPsd1TyBp
   SUfSE89e4HyQGU3/fn5+dsbz8EaUI7XgoIg2Lsqp4aeEZGyo7Nrv6C0qU
   cZTHPMjSWO1mMkL8Bv4pQFRsgMQymH6iU0/CGSPnoqcHi1F6Tihxi2bX3
   BB606V4b0Vcbk5GXc0x0H6NwVLp2bxig/6QLz3T62BkF3iu6Z4ekg0ocl
   UAImua+u1Vfljn3ElEklDPhmKCc2R7LtlrzXnPoxuW+HclnAZLsadDaBD
   g==;
X-CSE-ConnectionGUID: YeMZVk6rRry5TlwQ4seVJg==
X-CSE-MsgGUID: gJ6DGgAoQCO5kjJHHPSFJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9005253"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9005253"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:24:34 -0700
X-CSE-ConnectionGUID: DKlvi/xvSYadJlRfjX0y8Q==
X-CSE-MsgGUID: 7mBz50RHQNup1qmEbee4iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23788516"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa006.jf.intel.com with ESMTP; 19 Apr 2024 07:24:34 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 93E99301773; Fri, 19 Apr 2024 07:24:33 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org 
Subject: Re: [PATCH v2 05/13] x86/irq: Reserve a per CPU IDT vector for
 posted MSIs
In-Reply-To: <87jzkuxaqv.ffs@tglx> (Thomas Gleixner's message of "Fri, 19 Apr
	2024 06:00:24 +0200")
References: <87jzkuxaqv.ffs@tglx>
Date: Fri, 19 Apr 2024 07:24:33 -0700
Message-ID: <875xwdbfby.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

Dropping CC of a bazillion people and adding Arnaldo who owns perf trace
which has the vector decoding code.

> On Mon, Apr 15 2024 at 13:43, Jacob Pan wrote:
>> On Mon, 15 Apr 2024 11:53:58 -0700, Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>>> On Thu, 11 Apr 2024 18:51:14 +0200, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> > If we really care then we do it proper for _all_ of them. Something like
>>> > the uncompiled below. There is certainly a smarter way to do the build
>>> > thing, but my kbuild foo is rusty.  
>>> I too had the concern of the wasting system vectors, but did not know how
>>> to fix it. But now your code below works well. Tested without KVM in
>>> .config to show the gaps:
>>> 
>>> In VECTOR IRQ domain.
>>> 
>>> BEFORE:
>>> System: 46: 0-31,50,235-236,244,246-255
>>> 
>>> AFTER:
>>> System: 46: 0-31,50,241-242,245-255
>>> 
>>> The only gap is MANAGED_IRQ_SHUTDOWN_VECTOR(243), which is expected on a
>>> running system.
>>> 
>>> Verified in irqvectors.s: .ascii "->MANAGED_IRQ_SHUTDOWN_VECTOR $243
>>> 
>>> POSTED MSI/first system vector moved up from 235 to 241 for this case.
>>> 
>>> Will try to let tools/arch/x86/include/asm/irq_vectors.h also use it
>>> instead of manually copy over each time. Any suggestions greatly
>>> appreciated.
>>>
>> On a second thought, if we make system IRQ vector determined at compile
>> time based on different CONFIG options, will it break userspace tools such
>> as perf? More importantly the rule of not breaking userspace.
>
> tools/arch/x86/include/asm/irq_vectors.h is only used to generate the
> list of system vectors for pretty output. And your change already broke
> that.
>
> The obvious solution to that is to expose that list in sysfs for
> consumption by perf.
>
> But we don't have to do any of that right away. It's an orthogonal
> issue. Just waste the extra system vector to start with and then we can
> add the compile time dependend change on top if we really care about
> gaining back the vectors.
>
> Thanks,
>
>         tglx
