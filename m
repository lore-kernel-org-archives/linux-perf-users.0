From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf test: Adding an entry for the perftool-testsuite
Date: Mon, 7 Dec 2015 13:58:29 +0100
Message-ID: <20151207125829.GA26191@krava.brq.redhat.com>
References: <1449249064.24573.184.camel@redhat.com>
 <20151206155317.GB11852@krava.brq.redhat.com>
 <1449488755.24573.190.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53966 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbbLGM6c (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 07:58:32 -0500
Content-Disposition: inline
In-Reply-To: <1449488755.24573.190.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Dec 07, 2015 at 12:45:55PM +0100, Michael Petlan wrote:
> On Sun, 2015-12-06 at 16:53 +0100, Jiri Olsa wrote:
> > I can't get this applied on latest acme's perf/core
> > 
> 
> 
> Hi, I send patches that apply to latest Linus' tree:
> 
> https://github.com/torvalds/linux.git
> 
> Should I use some different tree? Arnaldo's? What is the URL
> of the proper tree I should send patches against?

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
perf/core branch

jirka
