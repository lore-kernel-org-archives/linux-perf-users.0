From: Maciek Borzecki <maciek.borzecki@gmail.com>
Subject: Re: [PATCH] perf: allow user to indicate path to objdump in command
 line
Date: Wed, 05 Sep 2012 07:22:44 +0200
Message-ID: <1346822564.18428.3.camel@localhost.localdomain>
References: <1346754750.16299.3.camel@localhost.localdomain>
	 <504626CB.60601@gmail.com> <1346811109.28652.1.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54350 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab2IEFWx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Sep 2012 01:22:53 -0400
In-Reply-To: <1346811109.28652.1.camel@concordia>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>, David Ahern <dsahern@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

On Wed, 2012-09-05 at 12:11 +1000, Michael Ellerman wrote:
> On Tue, 2012-09-04 at 10:05 -0600, David Ahern wrote:
> > On 9/4/12 4:32 AM, Maciek Borzecki wrote:
> > > When analyzing perf data from hosts of other architecture than one of the local
> > > host it's useful to call objdump that is part of a toolchain for that
> > > architecture. Instead of calling regular objdump, call one that user specified
> > > in command line.
> > 
> > Why not set the PATH to make the toolchain's version the one used by perf?
> 
> At least one reason is that cross toolchains are usually built such that
> the resulting binaries are called <target>-objdump, <target>-gcc etc.
Correct, PATH won't work. First I thought, why not hardcode objdump
based on CROSS. But then, I'd need to rebuild perf for each toolchain,
bad idea.
Passing objdump in command line seems like a good compromise to me,
especially as I haven't noticed any other binutils tools to be used by
perf same way as objdump is.

-- 
Maciek Borzecki <maciek.borzecki@gmail.com>
