Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C91DE4E5
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255057; cv=none; b=dI1gLTOyx0RSUaIQNhqhK6viqqlqIfhBFaqZIahH0DmOyUCB1bTEKaMOqpZTth7Nd2TZyxEKeRLH4O/i/YfFg+A4edg4o59Vq+rT177mvmPjHJ7oMs+kF+xgpeO+HMEoh41MwVwLTVW3RWTBssnaKhVq3fMXoM0U7H6s1Xq6VuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255057; c=relaxed/simple;
	bh=QGh1i4h15zwlk2taL2uiC7CWkt/02ZbZvdMzCMIMD34=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bFq9dL1fnZm1SI/Z1zBz9RfHxFz/qao2c0xt9w+Y0sDJ0BPYY0SYvmILkKlEcATmoJFQXePtfNI1uh3+8dYMSiXNievhMsStS93F7FEPhulslSYwie2U8BjZ78EihtzBMcAaRunQRV3VzQBcdpZVj6sot/ThtJ362df9Tqg8tZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=R7X1D8yE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="R7X1D8yE"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a44b0ed780so99661961cf.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1750255054; x=1750859854; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F87LNXi6Dt50NZ4Y2jNbajk2JH8YdJkfMPqkmOfc8Q4=;
        b=R7X1D8yE1rX52ki2ztvbBtWFO4Ks4LN3K6AtedVjl+nKR5OZoLXCZnvEPfNP+PPX9Y
         L5ViLk5oaLwFX3ZQ2ytj74cuAgGHKQXrtEJl+JNFsrt0cObr7KqYcKgPPMAYLge19GJa
         7/QYR2XjOH2vRBuMHUCbnirqVRwKbyLXCKA7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255054; x=1750859854;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F87LNXi6Dt50NZ4Y2jNbajk2JH8YdJkfMPqkmOfc8Q4=;
        b=saCrvJcLq6FiX+gNasMQ0SnyRiWOMX4w1JGatfqdc8R+7aUWyuPZCkBL4hHZP4G/J/
         uv2zLqmrfap6XD8vqXOv9zJ6SJJcZdwVdABRMDk2+XURH7xHNQaJP8ZEvk0LdXwkzcYL
         Wlqyz5BPdrB+Gdq8Z8k6K5YNjpSNzukHtY/lokc44fpba9/klHvtZX3PkuVh8HwxINW6
         PjdlC/jkkgABfhr9w69yD+CdwzDLU1A+6AryU2Msj6TKEkF0QV9Ef3Nc7ZRJBKo4Ikzm
         ezJn3cSaD/qYoZB2WZ04mEpVrCzIWUf6fsb+SWwiqQUMnky0pGeK3kvsfHlbL+0wjzOH
         fzTA==
X-Forwarded-Encrypted: i=1; AJvYcCU82Kx62jkhg6/H51Gwr0/4LjqTTvH1qVrF3owq8+Bj1DS9mFiVQW2JIbRFWjMP1gWQfKml5bFNXYRdD5eQL1e1@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMEUFRAqFva656pF4rLblmldLCxwVXRjHsRdl3YbSQ1RK2uzb
	EnYFkiYHah200sys3JooWSlVTF2viqu9+3fgu4PW1kmYTGHZjOq76jFO19NLQEyPX5253/+YdhX
	USTU=
X-Gm-Gg: ASbGncv/EOqMFhwyS+BUSm4h5UVf/mVcs1bxu3sDFMytRG3LV4waMvGAwDMTYjKMVx1
	y/yVaF5Shk5dYk7isRyZoF4z231Ga6ZgRQbQa/z7WjtUrf0cGuvcNPonShYnz7DYstvp/4YhKMx
	D1sEqqHCv0AIZIysU0ZYGhFVWiMY7k8k4aDDjSSLFluPq9FB1g5DlckzLBoKncWn+m67nwSjKS6
	wHU2EbxDH5mx3aTn2tPS0Epo8+cHEX9GWlBfAxZGYbgiiNP+jULgk36wAWtIXC3zuegMIiOZsQs
	vfbRW9tlflnQJQhNFNiOGvLpLfSmEosRxstJVhc4lMYkLkBAR0x8wEqSyK7rRFOnAkGikLcGBz9
	i5Nj08g==
X-Google-Smtp-Source: AGHT+IG9M+osh9AK7OslD/YcYztP1XDHnI2UfG2lQvM+zCZFfFLfIL73aoDY1mU5Ai8BGPzUAK42rw==
X-Received: by 2002:a05:622a:2d5:b0:4a2:719b:122e with SMTP id d75a77b69052e-4a73c53b18dmr283449821cf.18.1750255053755;
        Wed, 18 Jun 2025 06:57:33 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a3103a5sm71656251cf.30.2025.06.18.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 06:57:33 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 18 Jun 2025 09:57:32 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>
cc: Ian Rogers <irogers@google.com>, x86@kernel.org, 
    Vince Weaver <vincent.weaver@maine.edu>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on
 hybrid
In-Reply-To: <20250618084522.GE1613376@noisy.programming.kicks-ass.net>
Message-ID: <95b7b6aa-4019-d13a-8809-df21e449536b@maine.edu>
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu> <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com> <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com> <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
 <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com> <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com> <20250617181738.GD1613376@noisy.programming.kicks-ass.net> <CAP-5=fUbEuwHKOAJhvgHbbfg_f=KcED=9a94ra++cPbNLJP5BQ@mail.gmail.com>
 <20250618084522.GE1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Jun 2025, Peter Zijlstra wrote:

> On Tue, Jun 17, 2025 at 01:36:40PM -0700, Ian Rogers wrote:
> 
> > Thanks Peter, out of curiosity, how does the RDPMC fail? If an event
> > were rescheduled (even with RSEQ assuming the CPU the thread is
> > running on doesn't change) could the RDPMC with the incorrect index
> > also fail?
> 
> So the problem with RDPMC is that it will #GP when used with an invalid
> index.
> 
> Normally, when counting using fixed or general purpose events, this is
> not a problem, because every CPU in the machine has those. So while the
> index might not be the event you were after, the instruction doesn't
> trap, we observe the sequence changed and retry the loop. No harm done.
> 
> But for the top-down thingies, the P-cores will have a RDPMC idx that
> the E-cores do not support. Using this index on an E-core will #GP.
> 
> So the following situation:
> 
> 	CPU-P				CPU-E
> 
> 	do {
> 	  seq = pc->lock;
> 	  barrier();
> 
> 	  index = pc->index;
> 	  count = pc->count;
> 	  if (index) {
> 	    width = pm->pmc_width;
> 	
> 			<migrate task to CPU-E>
> 
> 					    rdpmc(index - 1); <-- #GP
> 					  }
> 
> 					  barrier();
> 					} while (pc->lock != seq);
> 
> Where the task is migrated from a P to an E core after reading the
> index but before doing RDPMC, turns fatal.
> 
> When we use RSEQ, the migration will abort the sequence and the RDPMC
> will not be executed.
> 
> 
> Aand... while writing this I wondered why we don't simply fix up the
> fault in kernel space. Something like so...

hah, we went through a lot of trouble in PAPI to implement the rseq 
solution because we were told it wasn't possible to fix this in the 
kernel.  I knew that couldn't really be true.

One thing to note about the sample mmap RDPMC code above, it doesn't work 
with topdown counters because you need to read all 64-bits with rdpmc and the 
default code sign-extends from 47 bits corrupting the top bits.  Though 
maybe it's been fixed since then to set pmc->width properly if it's a 
topdown event.

Vince
