From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: hotspot v1.0.0 available - a GUI for Linux perf
Date: Fri, 7 Jul 2017 11:30:39 -0300
Message-ID: <20170707143039.GQ27350@kernel.org>
References: <1802261.K6oANf3Kar@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750904AbdGGOao (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Jul 2017 10:30:44 -0400
Content-Disposition: inline
In-Reply-To: <1802261.K6oANf3Kar@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Thu, Jul 06, 2017 at 01:42:56PM +0200, Milian Wolff escreveu:
> PS: If you dislike GUIs and want to see me instead improve `perf report` 
> itself, don't worry! I've done that in the past and will continue doing so in 
> the future ;-)

Cool, I'll look at features in your project and those that could be
'perf report' as low hanging fruits and I'll try to cherry pick :-)

Also things that can make it easier for hotstpot to use perf's code
base, things like the error messages for system configuration, etc, we
can try to make the output friendlier for use by a GUI, etc.

- Arnaldo
