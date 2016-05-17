From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: how to get "--children" overhead with perf?
Date: Tue, 17 May 2016 16:05:33 -0300
Message-ID: <20160517190533.GE28790@kernel.org>
References: <loom.20160517T193444-154@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59038 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbcEQTFi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 May 2016 15:05:38 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 059DD2021B
	for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2016 19:05:37 +0000 (UTC)
Received: from jouet.infradead.org (unknown [187.65.121.17])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4472F20218
	for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2016 19:05:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20160517T193444-154@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vasmi Abidi <vabidi@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, May 17, 2016 at 05:38:48PM +0000, Vasmi Abidi escreveu:
>    Which version of perf gives the overhead of the children in the caller view?
>     On my ubuntu14.04.1 machine, I don't see any options for this.
> 
>  root@prmh:~# perf --version
> perf version 3.13.11.4
> root@:~# perf report --children
>   Error: unknown option `children'

[acme@jouet linux]$ git log --oneline 793aaaabb79803a0154fc6a98c472a29bb6d5cc9 -1
793aaaabb798 perf report: Add --children option

[acme@jouet linux]$ git tag --contains 793aaaabb798 | grep ^v3 | head
v3.16
v3.16-rc1
v3.16-rc2
v3.16-rc3
v3.16-rc4
v3.16-rc5
v3.16-rc6
v3.16-rc7
v3.17
v3.17-rc1
[acme@jouet linux]$ 

But I'd recommend you grab the very latest sources, using git, then
build just the tools, as in:

  cd linux
  make -C tools/perf install-bin

then use it from ~/bin/perf

It should work with your ubuntu14.04.1 system.

I regularly build it (as in multiple times a day) in these ubuntu Docker
containers:

[root@jouet atomic]# docker images | grep -- -ubuntu
perf-build-alldeps-ubuntu-14.04     latest  c36091c85ed1 3 weeks ago 632.9 MB
perf-build-alldeps-ubuntu-16.04     latest  72f6f5434e6d 3 weeks ago 669.3 MB
perf-build-alldeps-ubuntu-12.04     latest  f55b8c3182bf 6 weeks ago 508.7 MB
perf-build-minimal-ubuntu-x-arm     latest  a9450fa330a4 7 weeks ago 380.5 MB
perf-build-minimal-ubuntu-x-arm64   latest  c236781b734e 7 weeks ago 357.2 MB
perf-build-minimal-ubuntu-x-ppc64   latest  02adec2f8e15 7 weeks ago 384.3 MB
perf-build-minimal-ubuntu-x-ppc64el latest  5b4e2e62a3f3 7 weeks ago 372.3 MB
[root@jouet atomic]#

- Arnaldo
