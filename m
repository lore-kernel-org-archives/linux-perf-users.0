From: "Jen-Cheng(Tommy) Huang" <tommy24@gatech.edu>
Subject: Re: Problems with perf
Date: Tue, 19 Aug 2014 10:50:14 -0400
Message-ID: <CABooUW2dxtDJoLBgpkc+ZhdyS5RZ8CsOe4rB9TwBDrUtrthorA@mail.gmail.com>
References: <CABooUW2QDE_zRMyNzSEvWMEy+c-yrMvm+rSoASsx7ctBTijvFg@mail.gmail.com>
	<loom.20140818T205057-420@post.gmane.org>
	<loom.20140818T221806-241@post.gmane.org>
	<20140819080852.GA12435@krava.brq.redhat.com>
	<87tx58mxs5.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:37236 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbaHSOuP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Aug 2014 10:50:15 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so2540835qgd.19
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2014 07:50:14 -0700 (PDT)
In-Reply-To: <87tx58mxs5.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org

Thank you guys.
So far the "-a" full system mode seems working.
Thanks for the workaround.
I will update you guys for any issues.
Thanks.


On Tue, Aug 19, 2014 at 9:09 AM, Andi Kleen <andi@firstfloor.org> wrote:
> Jiri Olsa <jolsa@redhat.com> writes:
>> hi,
>> we switch off event inheritance for multiple events in group
>> with leader sampling. That's probably why you see less samples
>> and only one thread.
>
> If that's the problem then a short term workaround would
> be using -a
>
> -Andi
