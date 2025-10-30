Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECC2E62C3;
	Thu, 30 Oct 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846796; cv=none; b=rlf047NbNYWPr9Wwi4dFyC6eX31MchsjgqO4YqG7itl29AmChnGyStTkNwz/EK/n2I/twQ3Vb8WQA8MTgn87cbDcDFXrId6zfWD9Vz+PqhODYnox1DOVP1kPQCyhBvfiRNM609yjs9fipAVxBe4Zcn1vzONhtoq1iHVcM2y5qpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846796; c=relaxed/simple;
	bh=t8qAVN/qu5SzPNliKjBCvzibVTyrOpkrmrlB11AXm+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OicuH0gMiGLkTOrIfdIfT/nypV9RMYED/+rLL0DhTBhpWH4yCqtoulqxGdI47P33EaMpjyAhhu2KRbPUE9jwDVVMCqH2M7iuZ0cyCYIvuKAfRqHvMD6DyQ0v8U3yfbMaxsGbPiyw3fF28VZTj0+yIYIhSQnTpRu+frZa5VC/xAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=linux.intel.com; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
X-CSE-ConnectionGUID: 6c0Y7wNjS7i0Lp4h5WoSdg==
X-CSE-MsgGUID: reEKMGmeSQem2E/rExLp5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64039820"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64039820"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:53:14 -0700
X-CSE-ConnectionGUID: ugDYjjWdTMqLKJ3l2Fo0OQ==
X-CSE-MsgGUID: Xpoya6Z9RDqgBbtxLn/b1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="191159861"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa005.jf.intel.com with ESMTP; 30 Oct 2025 10:53:14 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id BFBB0302B3B; Thu, 30 Oct 2025 10:53:13 -0700 (PDT)
From: Andi Kleen <andi@firstfloor.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Fangrui Song <maskray@sourceware.org>,
  linux-toolchains@vger.kernel.org,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
In-Reply-To: <20251030102626.GR3245006@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Thu, 30 Oct 2025 11:26:26 +0100")
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
	<20251030102626.GR3245006@noisy.programming.kicks-ass.net>
Date: Thu, 30 Oct 2025 10:53:13 -0700
Message-ID: <87zf982s52.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Zijlstra <peterz@infradead.org> writes:
>
> So the SFrame unwinder is fairly simple code, but what does an .eh_frame
> unwinder look like? Having read most of the links in your email, there
> seem to be references to DWARF byte code interpreters and stuff like
> that.

Here's Jan Beulich's Linux implementation. The x86 version was
removed, but it lives on for ARC:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arc/kernel/unwind.c

SH also has another one from Matt Flemming:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/sh/kernel/dwarf.c

IMNSHO the whole sframe effort is misguided because all the major ISAs do have
shadow stack hardware support now which is generally a better option. 
It would be better to invest effort in deploying that widely.

-Andi
