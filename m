From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Wildly different output sizes between subsequent perf record runs.
Date: Mon, 06 Nov 2017 13:06:56 +0100
Message-ID: <5922369.x0IdO5xPIl@agathebauer>
References: <CABYXEkvrMhd9+P01k94AE97YHooDcs8Nxn4UfuvKfzzq88foVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:39284 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752617AbdKFMHA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Nov 2017 07:07:00 -0500
In-Reply-To: <CABYXEkvrMhd9+P01k94AE97YHooDcs8Nxn4UfuvKfzzq88foVA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Bram Stolk <b.stolk@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>

On Samstag, 4. November 2017 02:57:01 CET Bram Stolk wrote:
> If I do subsequent runs of 'perf record', both of which are identical,
> I sometimes get wildly different output sizes.
> 
> 
> https://gist.github.com/stolk/3666b2b4d4319764fdff4a2d4c619782
> 
> The binary did the same amount of work, and took the same amount of
> time to execute.
> This is with using perf from Ubuntu LTS.

I think this is the same bug that I have raised before. See https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1479712.html and below.

Can you try to run your command with a constant period (`-c 3000000` or 
similar), instead of using a dynamic period (i.e. `--freq`)? Does the issue go 
away then? If yes, then it's the same issue that I described earlier, which 
noone else from the perf team has acknowledged so far. I know multiple people 
who are affected by this though...

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
