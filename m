From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Tue, 12 Dec 2017 17:24:43 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1712121723290.9416@Diego>
References: <alpine.LRH.2.20.1712081845230.9416@Diego> <20171211154312.GC2221@redhat.com> <20171211170750.GE3958@kernel.org> <alpine.LRH.2.20.1712120133380.9416@Diego> <20171212145707.GL3958@kernel.org> <20171212151948.GN3958@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbdLLQYr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Dec 2017 11:24:47 -0500
In-Reply-To: <20171212151948.GN3958@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

Hey Arnaldo, this one did not remove the s390x hack and also, won't work
on arm. Please use the one I just have sent, few seconds ago...

On Tue, 12 Dec 2017, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 12, 2017 at 11:57:07AM -0300, Arnaldo Carvalho de Melo escreveu:
> > So the patch below does the trick for me, can you please check if does
> > for you?
> 
> So I've put this with a long explanation at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=ba15be2acc9e35dc9f034fef3aa292406b518b04
> 
> - Arnaldo
> 
