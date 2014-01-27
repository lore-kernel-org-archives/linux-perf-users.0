From: AmirReza Ghods <ar.ghods@gmail.com>
Subject: Re: Does perf record support event multiplexing?
Date: Mon, 27 Jan 2014 16:14:21 -0500
Message-ID: <CAOJauODyEsYJs3+BGeqiOgTYbiE4UU8ZUjP9DZ2Hmes-JSun=w@mail.gmail.com>
References: <CAOJauOAJbbjP6kR_op4bzncDajjOZvN0YWf9+scYjpHrJeLTOg@mail.gmail.com>
	<874n4v1es6.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:40165 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbaA0VOV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 27 Jan 2014 16:14:21 -0500
Received: by mail-ig0-f179.google.com with SMTP id c10so10211075igq.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2014 13:14:21 -0800 (PST)
In-Reply-To: <874n4v1es6.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Thank you for your response, but that doesn't really answer my
question. I wanted to know why scaling of the event counts is
implemented in "perf stat" but NOT implemented in "perf record".

As for caring about the exact sample count of perf report, I don't think
the relative usefulness of the values is a good reason to leave users
with some verifiably false results, and expect them to figure out why
they got them. I know some users, including myself, will be confused to
measure event counts differing (sometimes 300% in my experience) from
what they might expect.

Thanks,
Amir
On Wed, Jan 22, 2014 at 11:51 PM, Andi Kleen <andi@firstfloor.org> wrote:
> AmirReza Ghods <ar.ghods@gmail.com> writes:
>
>> I noticed that "perf record" does not calculate the true value for the
>> number of event's counts in the case of having more events than
>> hardware counters.
>> But in pef stat it does and there is a time interpolation algorithm
>> for estimating and correcting the true value.
>> Also I saw a patch for Perf's source code that implimented time
>> interpolation for Perf in record mode but it did not include in the
>> next official realses of Perf. I just want to know that is there any
>> technical difficulty for implimenting this feature in "perf record" or
>> not?
>
> Why would you care about the exact sample count for perf report?
>
> The only thing that counts in such a histogram is the percent
> relationships, which would stay the same if the numbers
> were scaled up.
>
> -Andi
> --
> ak@linux.intel.com -- Speaking for myself only



-- 
Amir Reza Ghods
MASc Candidate, Department of Electrical and Computer Engineering
University of Waterloo
200 University Avenue West
Waterloo, Ontario, Canada, N2L 3G1
