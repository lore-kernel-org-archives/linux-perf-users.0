From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] perf: allow user to indicate path to objdump in command
 line
Date: Wed, 05 Sep 2012 12:11:49 +1000
Message-ID: <1346811109.28652.1.camel@concordia>
References: <1346754750.16299.3.camel@localhost.localdomain>
	 <504626CB.60601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:49329 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434Ab2IECLs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Sep 2012 22:11:48 -0400
In-Reply-To: <504626CB.60601@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Maciek Borzecki <maciek.borzecki@gmail.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

On Tue, 2012-09-04 at 10:05 -0600, David Ahern wrote:
> On 9/4/12 4:32 AM, Maciek Borzecki wrote:
> > When analyzing perf data from hosts of other architecture than one of the local
> > host it's useful to call objdump that is part of a toolchain for that
> > architecture. Instead of calling regular objdump, call one that user specified
> > in command line.
> 
> Why not set the PATH to make the toolchain's version the one used by perf?

At least one reason is that cross toolchains are usually built such that
the resulting binaries are called <target>-objdump, <target>-gcc etc.

cheers
