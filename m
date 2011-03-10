From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Add inverted call graph report support to perf tool
Date: Thu, 10 Mar 2011 07:48:16 +0100
Message-ID: <20110310064816.GF9289@elte.hu>
References: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
 <20110307180619.GG1873@nowhere>
 <AANLkTi=rabeXE6m0wRo029jgqHLBaUGQcXYJriLewZeJ@mail.gmail.com>
 <20110310024355.GG2533@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:39171 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab1CJGs3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 01:48:29 -0500
Content-Disposition: inline
In-Reply-To: <20110310024355.GG2533@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Sam Liao <phyomh@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arjan van de Ven <arjan@infradead.org>


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

> But your idea of turning the callee into the caller would show us a very global 
> profiling. With reverse callchains it can be a very nice overview of the big 
> picture.

Very much agreed - i think that matches the sysprof display structure as well, 
right?

This could then be propagated not just into perf report but perf top --tui as well.

Thanks,

	Ingo
