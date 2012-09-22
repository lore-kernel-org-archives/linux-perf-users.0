From: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Subject: Re: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Sat, 22 Sep 2012 09:58:15 +0200
Message-ID: <CAHFo2uq2pKx1FKSv5=mE7WhaqixJ2vzCSBxPeaz3DKE90vz0OQ@mail.gmail.com>
References: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com>
	<CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com>
	<CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com>
	<5046268F.4050504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43088 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab2IVH6Q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 22 Sep 2012 03:58:16 -0400
Received: by weyx8 with SMTP id x8so2372679wey.19
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Sep 2012 00:58:15 -0700 (PDT)
In-Reply-To: <5046268F.4050504@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>

>> Anybody? We'd love to use a proven, standard workaround
>> for this issue, preferably without forcing our users to upgrade
>> the kernel or wait for any future release. Do we even diagnose
>> the problem correctly?
[snip lots of useful responses]

Thank you very much for your tips, they helped a lot.

Now our main problem is relating the perf timestamps
to a public clock API (like posix_gettime, etc.) in order
to chronologically merge the perf log with our external event logs.
We've so far determined experimentally that even the
clock_gettime(CLOCK_MONOTONIC, ...) values are not identical
to the perf timestamps at the same places, though they are quite close.
Are we missing anything? Is the "--timestamp" option of perf-record
related in any way? Any other tips?

We're working around right now by syncing with a timestamp
of a known event, but that leaves us vulnerable to a time drift.
If there's no way currently to generate externally meaningful
timestamps, could we file a feature request for the sake of the future?

Thanks a lot,
Mikolaj
