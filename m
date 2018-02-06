From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: RE: Not finding symbol information
Date: Tue, 6 Feb 2018 13:09:49 +0000
Message-ID: <30C2D590D16A5C46ADFE65219103779892619FC2@AZ-US1EXMB02.global.avaya.com>
References: <30C2D590D16A5C46ADFE65219103779892609BF7@AZ-US1EXMB02.global.avaya.com>
        <1590706.6giPFGD14k@milian-kdab2>
        <20180202183829.8ca5ac81d7c48bfafc7b79d1@arm.com>
        <30C2D590D16A5C46ADFE6521910377989260A050@AZ-US1EXMB02.global.avaya.com>
 <20180205173541.ce7e8fdf3d4c9230a2a70c96@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co300216-co-outbound.net.avaya.com ([198.152.13.100]:36736 "EHLO
        co300216-co-outbound.net.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752982AbeBFNKH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Feb 2018 08:10:07 -0500
In-Reply-To: <20180205173541.ce7e8fdf3d4c9230a2a70c96@arm.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> > BTW, I found some odd behaviour around that too. 'perf report --symfs
> > PATH' is looking for the buildid cache in 'PATH/$HOME/.debug', not
> '$HOME/.debug'.
> > Not sure whether that's design intent or a bug.
> 
> Yeah, that doesn't sound right: the manpage just says "Look for files with
> symbols relative to this directory."

In latest perf/core, this is now changed to PATH/.debug, which makes more sense.

> OK, in that case can you try cherry-picking commit 9b200653518e "perf
> symbols: Take into account symfs setting when reading file build ID"?
> It looks highly relevant but I haven't been able to make sure yet.

That's the fix. Thank you very much for the tip

MV
