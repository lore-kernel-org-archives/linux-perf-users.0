From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] Add inverted call graph report support to perf tool
Date: Fri, 11 Mar 2011 11:51:22 +0100
Message-ID: <20110311105118.GA1826@nowhere>
References: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
 <20110307180619.GG1873@nowhere>
 <AANLkTi=rabeXE6m0wRo029jgqHLBaUGQcXYJriLewZeJ@mail.gmail.com>
 <20110310024355.GG2533@nowhere>
 <20110310064816.GF9289@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55861 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab1CKK6H (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Mar 2011 05:58:07 -0500
Content-Disposition: inline
In-Reply-To: <20110310064816.GF9289@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Liao <phyomh@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arjan van de Ven <arjan@infradead.org>

On Thu, Mar 10, 2011 at 07:48:16AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <fweisbec@gmail.com> wrote:
> 
> > But your idea of turning the callee into the caller would show us a very global 
> > profiling. With reverse callchains it can be a very nice overview of the big 
> > picture.
> 
> Very much agreed - i think that matches the sysprof display structure as well, 
> right?

Yeah indeed, IIRC.
 
> This could then be propagated not just into perf report but perf top --tui as well.

Probably yeah. Are callchains already supported by perf top?
