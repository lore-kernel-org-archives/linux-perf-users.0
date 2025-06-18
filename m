Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1527FB32
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236332; cv=none; b=rVfvLYJ16d4P+7qtZtJ/k+eoWGp9k8xKCki1J9vx4up+yjcwk+tQsnELOwgRIJyAsi2crv0fniYyXSP1c9H1ZwaV5LkQ9mZZIQivFKqAKNtPkzWuKzSb7Pf2W6iTsCBktiUYx+XQK8x9sbLZMEJ1mPYfWvXZXLhtgXQzi7T6IkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236332; c=relaxed/simple;
	bh=6gBUu+thKwCxF9fVl2HVzQ2ngD0fx/5qMovArOio40c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Viu7vawcs4BibPEJ0vhRlh+w53xC3qUq/T7WdrOZKXNt+UmKQqgC8TC16GInHH61t3UUcdHM04y6rm2JC5qlBRnOV9e5qyVYjBDvQt/k/7lw5+7psTLEyrvPCqwPu+IM8q9eNiPfzgwWehdxSGKuLXgLKL5iY5CwE4O27kfQS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UtqtVr3k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UtqtVr3k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C3k0MhTTmB0WJ3WK12m8BOgjmxnHs1BjI/B5ix3uKwE=; b=UtqtVr3kBCmOePdE3ee6aQvk4x
	CJ7Xj7Yb6bTy2nhnOMdI1HqTFi0Q1yLWRcNUEs14ag3EYoddVaI1rs9TAadGoeIufYubEsuB31mUm
	emXYcVCx7GnR6Fij7gswEAN5zkVRVLeCKTSR7liFXsIIitjmkHTbdhiPBYF9hLrOLiGth/41gD3R3
	F9Y1vQtWiEYKnFyfHTpXh8h2DxaxYCGOADI/FHKS0SjO8Meramq2w9VjC1ZLEZrjGhPeacybo9Zqy
	td0liI9tfFS0AjI8V+yXHMxt6WXrv00G4GT9WPqyspDbTfSgw8+TJvNFMZ7ykoJHKtqjOkEP9Imtk
	F3tiDS2w==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRoQ9-00000003zo5-2jYT;
	Wed, 18 Jun 2025 08:45:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91DE0307D9B; Wed, 18 Jun 2025 10:45:22 +0200 (CEST)
Date: Wed, 18 Jun 2025 10:45:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>, x86@kernel.org
Cc: Vince Weaver <vincent.weaver@maine.edu>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
Message-ID: <20250618084522.GE1613376@noisy.programming.kicks-ass.net>
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
 <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
 <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
 <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
 <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
 <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com>
 <20250617181738.GD1613376@noisy.programming.kicks-ass.net>
 <CAP-5=fUbEuwHKOAJhvgHbbfg_f=KcED=9a94ra++cPbNLJP5BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUbEuwHKOAJhvgHbbfg_f=KcED=9a94ra++cPbNLJP5BQ@mail.gmail.com>

On Tue, Jun 17, 2025 at 01:36:40PM -0700, Ian Rogers wrote:

> Thanks Peter, out of curiosity, how does the RDPMC fail? If an event
> were rescheduled (even with RSEQ assuming the CPU the thread is
> running on doesn't change) could the RDPMC with the incorrect index
> also fail?

So the problem with RDPMC is that it will #GP when used with an invalid
index.

Normally, when counting using fixed or general purpose events, this is
not a problem, because every CPU in the machine has those. So while the
index might not be the event you were after, the instruction doesn't
trap, we observe the sequence changed and retry the loop. No harm done.

But for the top-down thingies, the P-cores will have a RDPMC idx that
the E-cores do not support. Using this index on an E-core will #GP.

So the following situation:

	CPU-P				CPU-E

	do {
	  seq = pc->lock;
	  barrier();

	  index = pc->index;
	  count = pc->count;
	  if (index) {
	    width = pm->pmc_width;
	
			<migrate task to CPU-E>

					    rdpmc(index - 1); <-- #GP
					  }

					  barrier();
					} while (pc->lock != seq);

Where the task is migrated from a P to an E core after reading the
index but before doing RDPMC, turns fatal.

When we use RSEQ, the migration will abort the sequence and the RDPMC
will not be executed.


Aand... while writing this I wondered why we don't simply fix up the
fault in kernel space. Something like so...

---
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f88b8a78e50..90391526acf7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -677,6 +677,43 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
+static bool fixup_rdpmc_exception(struct pt_regs *regs)
+{
+	struct mm_struct *mm = current->mm;
+	u8 buf[MAX_INSN_SIZE];
+	struct insn insn;
+	int len;
+
+	len = insn_fetch_from_user(regs, buf);
+	if (len <= 0)
+		return false;
+
+	if (!insn_decode_from_regs(&insn, regs, buf, len))
+		return false;
+
+	/* RDPMC */
+	if (insn.opcode.bytes[0] != 0x0f || insn.opcode.bytes[1] != 0x33)
+		return false;
+
+	if (!atomic_read(&mm->context.perf_rdpmc_allowed))
+		return false;
+
+	/*
+	 * So userspace RDPMC is allowed and took #GP.
+	 *
+	 * This means they got the index wrong. But per the ABI described in
+	 * struct perf_event_mmap_page; this means they'll also fail the
+	 * sequence lock and will retry the operation after re-reading the
+	 * index.
+	 *
+	 * Fake out the RDPMC by returning all zeros and continue.
+	 */
+	regs->ax = 0;
+	regs->dx = 0;
+	regs->ip += insn.length;
+	return true;
+}
+
 static bool fixup_iopl_exception(struct pt_regs *regs)
 {
 	struct thread_struct *t = &current->thread;
@@ -812,6 +849,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	}
 
 	if (user_mode(regs)) {
+		if (fixup_rdpmc_exception(regs))
+			goto exit;
+
 		if (fixup_iopl_exception(regs))
 			goto exit;
 
