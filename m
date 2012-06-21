From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: measuring L3cache misses
Date: Thu, 21 Jun 2012 17:38:23 -0400
Message-ID: <alpine.DEB.2.00.1206211737030.10843@cl320.icl.utk.edu>
References: <loom.20120621T093151-851@post.gmane.org> <alpine.LRH.2.00.1206210822340.16450@ig.icl.utk.edu> <CAMmbtvK-78Xgvby-VOyVHEf7LbRD8=vw5b7ziOvpn2KUrZm+BQ@mail.gmail.com> <alpine.DEB.2.00.1206211239010.4839@cl320.icl.utk.edu>
 <CAMmbtvJ0iijBkF58+qJ_UBHDOQ4YNRW2Gc7xE=rvR1qXxfweBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="614521987-849347746-1340314703=:10843"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:40580
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760432Ab2FUVia (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Jun 2012 17:38:30 -0400
In-Reply-To: <CAMmbtvJ0iijBkF58+qJ_UBHDOQ4YNRW2Gc7xE=rvR1qXxfweBg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Can Hankendi <hankendi@gmail.com>
Cc: linux-perf-users@vger.kernel.org

--614521987-849347746-1340314703=:10843
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Jun 2012, Can Hankendi wrote:

> I'm not aware of that coding, can you explain more? However if check=A0=
Basic
> Performance Measurements for AMD Athlon ... - AMD Developer, f74e1 seem=
s to
> be the correct register. What do you think?

how exactly are you calling perf?  What command line are you using?

I'd reccommend you use libpfm4 to create your perf_event raw event values=
,=20
otherwise you are just measuring arbitrary values.  There's no error=20
checking in the perf raw event case.

Vince

--614521987-849347746-1340314703=:10843--
