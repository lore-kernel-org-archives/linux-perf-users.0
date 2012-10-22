From: David Ahern <dsahern@gmail.com>
Subject: Re: perf top -z not working?
Date: Mon, 22 Oct 2012 09:01:00 -0600
Message-ID: <50855FAC.5020403@gmail.com>
References: <507EA40D.60206@cs.utoronto.ca> <507EB776.9030304@core.kaist.ac.kr> <20121022014618.GA7924@ghostprotocols.net> <50853311.3040707@cs.utoronto.ca> <50854633.30206@gmail.com> <508553D1.8040603@cs.utoronto.ca> <20121022144552.GB8775@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55329 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2JVPBH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Oct 2012 11:01:07 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1990924pad.19
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Oct 2012 08:01:06 -0700 (PDT)
In-Reply-To: <20121022144552.GB8775@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Ryan Johnson <ryan.johnson@cs.utoronto.ca>
Cc: Chulmin Kim <cmkim@core.kaist.ac.kr>, linux-perf-users@vger.kernel.org

On 10/22/12 8:45 AM, Arnaldo Carvalho de Melo wrote:

To add to Arnaldo's instructions, here's how to get a copy of his tree:

mkdir perf.git
cd perf.git

git init
git add remote acme git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
git remote update

git checkout remotes/acme/perf/core
mkdir /tmp/pbuild
make -C tools/perf  O=/tmp/pbuild
/tmp/pbuild/perf top -z

To try out a different version:
git checkout v3.0
make -C tools/perf

or v3.2, v3.4, etc.

Building perf is fairly quick and you do not have to install them -- 
just run the built binary.

>
> To build just the tools, on a /usr/src/linux or wherever you have the
> newer kernel sources:
>
>   make -C tools/perf install
>
> Then make sure you use what is in your ~/bin/ before the standard path:
>
>   export PATH=~/bin:$PATH
>   hash -r
>
> Then try perf top -z again.
>
> - Arnaldo
>
