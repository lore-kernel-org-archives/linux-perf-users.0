From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: perf_event: rdpmc self-monitoring overhead issue
Date: Mon, 2 Sep 2013 09:15:48 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1309020914030.26568@vincent-weaver-1.um.maine.edu>
References: <alpine.DEB.2.10.1308301334410.19094@vincent-weaver-1.um.maine.edu> <CAMsRxfLSnNi_vESxYHM5w0tQrOtOPsEy3ythoViRMBbEi+XHGw@mail.gmail.com> <87ob8cdji8.fsf@tassilo.jf.intel.com> <CAMsRxfLf4mSVEMnDr1AqD-=qrhBoeVWK6H0Jhb5kcHK7=OajmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:34216 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758461Ab3IBNJJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 2 Sep 2013 09:09:09 -0400
Received: by mail-yh0-f46.google.com with SMTP id l109so1117609yhq.19
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Sep 2013 06:09:09 -0700 (PDT)
In-Reply-To: <CAMsRxfLf4mSVEMnDr1AqD-=qrhBoeVWK6H0Jhb5kcHK7=OajmQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: eranian@gmail.com
Cc: Andi Kleen <andi@firstfloor.org>, Vince Weaver <vincent.weaver@maine.edu>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

On Mon, 2 Sep 2013, Stephane Eranian wrote:

> On Mon, Sep 2, 2013 at 4:50 AM, Andi Kleen <andi@firstfloor.org> wrote:
> > Stephane Eranian <eranian@googlemail.com> writes:
> >
> >> I don't see a flag in mmap() to fault it in immediately.
> >
> > MAP_PRESENT
> >
> I could not find this constant defined anywhere in the kernel source tree
> nor in /usr/include. Are you sure of the name?

I assume he means MAP_POPULATE

which does improve things, from ~3000 cycles to ~219 cycles but that's 
still more overhead than the ~130 or so you get by manually touching the 
page first.

Vince
