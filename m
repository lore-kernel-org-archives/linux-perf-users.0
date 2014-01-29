From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Does perf record support event multiplexing?
Date: Wed, 29 Jan 2014 15:49:55 +0900
Message-ID: <878utz5lkc.fsf@sejong.aot.lge.com>
References: <CAOJauOAJbbjP6kR_op4bzncDajjOZvN0YWf9+scYjpHrJeLTOg@mail.gmail.com>
	<874n4v1es6.fsf@tassilo.jf.intel.com>
	<CAOJauODyEsYJs3+BGeqiOgTYbiE4UU8ZUjP9DZ2Hmes-JSun=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo01.lge.com ([156.147.1.125]:54818 "EHLO
	LGEAMRELO01.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaA2Gt5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jan 2014 01:49:57 -0500
In-Reply-To: <CAOJauODyEsYJs3+BGeqiOgTYbiE4UU8ZUjP9DZ2Hmes-JSun=w@mail.gmail.com>
	(AmirReza Ghods's message of "Mon, 27 Jan 2014 16:14:21 -0500")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: AmirReza Ghods <ar.ghods@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Hi AmirReza,

On Mon, 27 Jan 2014 16:14:21 -0500, AmirReza Ghods wrote:
> Thank you for your response, but that doesn't really answer my
> question. I wanted to know why scaling of the event counts is
> implemented in "perf stat" but NOT implemented in "perf record".

I think the reason is "perf record" lacks enabled/running time
information in the samples.

>
> As for caring about the exact sample count of perf report, I don't think
> the relative usefulness of the values is a good reason to leave users
> with some verifiably false results, and expect them to figure out why
> they got them. I know some users, including myself, will be confused to
> measure event counts differing (sometimes 300% in my experience) from
> what they might expect.

You might want to use "perf stat --no-scale" then. ;-)

Thanks,
Namhyung
