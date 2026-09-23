Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192A531629
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173998; cv=none; b=QG1xHYDpeA750NiGfz9IJUCd0SnmZKeLDVZK+dC4dySOR1bCA3XomrvB3IOzupf87M9gvfRY0W0RsqjI32gT9gTiJz4yaEwjAvVm3asCe4SbZgm9xLvMij20SgNpWfBjB1k3XaJ8yW0M9Yi9mJDu2wrdozkUW1xeKMHEIdVH8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173998; c=relaxed/simple;
	bh=9SziFnm+aShDkRNqNWK4TN1HFS1h14/qWjFuIX4GFYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=liFfxrPaJpYEWDzzFle5O9vwBRjCNb5qbaRh4ACBlO78EsAArSQusPPQcZY46N6LPqEE5L54NUtmabo2dvmsHk+GpsDN3CRrsRcK1yqmsDD/PRrXTF9FTrihixVTceJ5pHvTROdI9Q5GW+42m0VE1Vj7GAlvRyX4faBSdqwiJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4djl8C3; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4djl8C3"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8679cfe5019so1170276b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173996; x=1790778796; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AX/aeWxWgB/GKGsHNXt+UF87Ro0pQpzXrq2csA576lg=;
        b=G4djl8C3qxRTsRmvPNo5MOrfBBswMKCGB6TDoGTiEKAlra62ktjDTE69fVMNHfDiRB
         6nwEsCtA47lYdmfdQC8e/d13TBE0tfs3znkzlWpxNNfwzchICxPfyhqaHKU87a9weD2J
         NRXNDMBr1teRUBUiubml1aNnXs93x+joWSp7oOxW7B0LqvvEAaYiklk2u7rWX7fgRy5U
         X9IWtepwDWlJe+kBfbHziUx4RFhKzQiSVXt2OVG57BQ9rXGa2EUTl5CnRiQWp82kEAyg
         o6FYT3jccLBqcl51Hb+ZvnlUj74dDlA1EgIRNsqpxwUzVIVXMfvuYFiPQ2cLWiu1/nBH
         n8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173996; x=1790778796;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AX/aeWxWgB/GKGsHNXt+UF87Ro0pQpzXrq2csA576lg=;
        b=Fl48Kx8zDBSoW3k2FLE2HSBCi5DFOga21YP2OdXouct07jVAG+Fk/mJUlfoY/lP7T/
         2isq1+nG8w3HBe+BCSydbomJciw99+JQ3R+GMnqdiX8rQk+E0QMruW08ub9hgpVtESAt
         j7nghLPHVQyMBx+faRbNO8Fahe/OCXvWV4cI8cUHh4eXC8bo2//JMpOfZ6noSB5udhC6
         SqYh304yjiguTAdb/b8mGv/R9GbUT+eEUO+Q57E1/AITEzn7cqIvIggC5w/1RdV85Bu+
         d5orreQrlUX4WtgbD/+jQsEsgkr/w7iUy/6INIfmYRPOs0GOTepgk09RTtih+/pEeD5s
         mHaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJ3sX//I7E1/uIdedMnwwPcrwhN/bBBbB0bMijU1hiP27sn8uiuneM71qdVG+6Loj5VqIkRvlS+24+OvKP06N4@vger.kernel.org
X-Gm-Message-State: AFuF++n+yVTs0ZiErF57yXyGRQILNujH0ajfTttqcW2OVw3AE2tp5W/c
	W/B2aBUxmfeW2bLX4k6PoS4TYm7YOn1xJIKmGEbPKmNeUe3m42cyyNIG8qMaXJcrX4Li/ONb+Op
	/esxrOg==
X-Received: from pfet15.prod.google.com ([2002:aa7:938f:0:b0:87b:94d4:77a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3319:b0:87c:e44e:5683
 with SMTP id d2e1a72fcca58-87d1a4b357amr2446190b3a.23.1790173995748; Wed, 23
 Sep 2026 07:33:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 07:33:15 -0700
In-Reply-To: <20260923085139.GV776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005110742.388919.1509641807739909065.stgit@devnote2> <20260923085139.GV776954@noisy.programming.kicks-ass.net>
Message-ID: <arPjK1-PVp_UqAsQ@google.com>
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register leak
 into guest OS on NMI
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 23, 2026, Peter Zijlstra wrote:
> On Tue, Sep 22, 2026 at 01:25:07PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > When KVM enters a guest OS, host hardware breakpoints are disabled
> > before running the guest. However, an NMI can occur while executing
> > in guest mode or during guest transition, where
> > arch_install_hw_breakpoint() can be invoked from NMI context.
> 
> How? AFAICT perf doesn't do that. arch_install_hw_breakpoint() is called
> through pmu::add() which is strictly IPI context.

I assume it's:

  kgdb_nmi_handler()
  |
  -> kgdb_nmicallin()
     |
     -> kgdb_cpu_enter()
        |
        -> arch_kgdb_ops.correct_hw_break()
           |
           -> kgdb_correct_hw_break()
              |
              -> arch_install_hw_breakpoint()
