Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B743033C0
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737708; cv=none; b=rROChJttx1hCpWZCcsJ4DhHTq3ATJQFZZ+6z5zR5zYyTYwpqDVwikQuMTWqyJGznq37i4YrrIukbm86DOOE+8fhLBKMx1wh0fwq/QyiRRHie90NgSVnhs0a61IYgeJgCRKEPvEWnD0JOJt/FfL0hCbxLTpbu4zVMixArc3ZPkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737708; c=relaxed/simple;
	bh=bGuaeNqr6VWaAmbiXSPDtO63UndDQutthS6wDXTX9W4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bgfLLMgcW7MwssnJ2i4U2ppvccXIUyiuxPmDl51lRnv/5xOtVU5Tfx4jmIzxi3yZDoEtoX/E8OJn9EaljxXRJQzifUOT61FhZv/SS59vEt7BIbPVnvc5xNubMiEDP2bYSIBSqrddFT6nVO31j/mzBEffvAZVR8Y34sKHzyJUy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOx2at7u; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOx2at7u"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598007eb74so26711016a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 11:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772737707; x=1773342507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd+7isUxcEtu9dXZzRy3nxo9ohGQnZS7iF8S+D9SDgk=;
        b=DOx2at7u/Kkz0XXpZrEGqaipCZC9ooahe8trHC8eyXSBytgRkGR2CQbXGETad8Im6f
         r4LilrBiRtkuJxGs0hWT89K/6jNsfHojxHb697UYuJbwyQizg3UblABFb4pThzeGrQ+/
         LLsHbfdkysIaG8WU165xPZA35jIggSmJnRkvlkWT1do1OKMS3BN8S4C77mOgCU6Co215
         z2Gdc6eb1j7i+7jINoT6BTzQ3CclVGwamXmkmV7XLz1+635rsqmmJJ+tEp/SXp4stkgk
         rKhDSPs22m+3KOkZIWmTLn/dKpZvx6qTW6WIK3scIhWRnQhGlx7/CurKUat6WRVJPoAp
         h9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772737707; x=1773342507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd+7isUxcEtu9dXZzRy3nxo9ohGQnZS7iF8S+D9SDgk=;
        b=UloHgfS0pGozzHAbbwmnqygGxLe90xmm7aPBklY5BckdCJv4QV9f6HnlK0Pi7x9nVU
         SoJMOzV+cWdkVW+Z9Gh+25GqbBGpeJQtJwcbc1/Qq46RF8/vr9gZuSzeU3yfc+LpIO8p
         KmgajzPrfHLeLcyLankIxbUfy/kPRaVvyVrAscGaeaZF0Twm6EbAHBd7/ar1Kfda4y0O
         Rm5fm/sohoz+y2ZV2f1TSVYqvQzCO1SNQmUTsOqtSnNAQ7tqvYsgU8sdRyf2S9EjWIYz
         bomF7BQZQP9ZHKGKsP2OO3+immA/xjUVyr/4NTyt2eXQi2NeAybYqpzUNOR0JYeVwBpy
         NjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiQnNtmzz/0CeNlieINaF5+sui8eqzxsDI7fFHDLidk5Ad6wJWUWLB3cC1VzY4mU4zBuaXWZk/YvSIzx69uDlG@vger.kernel.org
X-Gm-Message-State: AOJu0YyniXomzXw7uJwypXaz2QQLkvNRBvoLAAfqGWUGm/xL16xlsrXH
	wackQjfym6WkmdWtfUDfOhW95LcZ/OTy78UmIdgojyRzwgaPk9hMuYS6Up9Z8Uf9EGcik+C0aLC
	X7TBl/g==
X-Received: from pjwo15.prod.google.com ([2002:a17:90a:d24f:b0:359:946d:cd28])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cd:b0:354:c629:efaf
 with SMTP id 98e67ed59e1d1-359a6a83ecemr5537189a91.35.1772737706499; Thu, 05
 Mar 2026 11:08:26 -0800 (PST)
Date: Thu, 5 Mar 2026 11:08:24 -0800
In-Reply-To: <69a9d0645bc31_6423c1006@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com> <177272960351.1566277.2741684808536756847.b4-ty@google.com>
 <69a9d0645bc31_6423c1006@dwillia2-mobl4.notmuch>
Message-ID: <aanUqJWYMSXSwGRR@google.com>
Subject: Re: [PATCH v3 00/16] KVM: x86/tdx: Have TDX handle VMXON during bringup
From: Sean Christopherson <seanjc@google.com>
To: dan.j.williams@intel.com
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 05, 2026, dan.j.williams@intel.com wrote:
> Sean Christopherson wrote:
> > On Fri, 13 Feb 2026 17:26:46 -0800, Sean Christopherson wrote:
> > > Assuming I didn't break anything between v2 and v3, I think this is ready to
> > > rip.  Given the scope of the KVM changes, and that they extend outside of x86,
> > > my preference is to take this through the KVM tree.  But a stable topic branch
> > > in tip would work too, though I think we'd want it sooner than later so that
> > > it can be used as a base.
> > > 
> > > Chao, I deliberately omitted your Tested-by, as I shuffled things around enough
> > > while splitting up the main patch that I'm not 100% positive I didn't regress
> > > anything relative to v2.
> > > 
> > > [...]
> > 
> > Applied to kvm-x86 vmxon, with the minor fixups.  I'll make sure not to touch
> > the hashes at this point, but holler if anyone wants an "official" stable tag.
> 
> Thanks, Sean!
> 
> Please do make an official stable tag that I can use for coordinating
> the initial TDX Connect enabling series. While there is no strict
> dependency I do not want it to be the case that a bisect of TDX Connect
> bounces between a world where you need to load kvm_intel before the PCI
> layer can do link encryption operations and keep it loaded etc.

With a timestamp, in case fixups on top are needed:

kvm-x86-vmxon-2026.03.05
