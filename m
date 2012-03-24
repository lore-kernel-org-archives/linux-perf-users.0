From: yipeng <yipeng@gmail.com>
Subject: Re: perf stat: Doubt about stall cycle support
Date: Sat, 24 Mar 2012 09:55:31 +0800
Message-ID: <CAB_n8zKuWw+EecLTtUyOgesanjas3V0YWes6PgWGogTDzrPqmg@mail.gmail.com>
References: <loom.20120321T054053-857@post.gmane.org>
	<4F69E9C4.8060108@gmail.com>
	<CAB_n8zK5b0jWA=retCX12DGmrb19gMd2UxJGWkn6HD9nFrdiAQ@mail.gmail.com>
	<4F6A00BC.8070705@gmail.com>
	<loom.20120322T013621-317@post.gmane.org>
	<alpine.DEB.2.00.1203212112430.16205@cl320.eecs.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64132 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751623Ab2CXBzc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Mar 2012 21:55:32 -0400
Received: by lahj13 with SMTP id j13so2918450lah.19
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Mar 2012 18:55:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203212112430.16205@cl320.eecs.utk.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Thu, Mar 22, 2012 at 9:17 AM, Vince Weaver <vweaver1@eecs.utk.edu> w=
rote:
>
> What kind of stalls are you looking to measure?
>
> The core2 supports many kind of stall events. =A0Check out Intel Vol3=
b
> documentation, or the libpfm4 showevtinfo utility for a list of them =
all.
>
> perf only directly supports a small subset of "generalized" events, a=
nd
> only then if a kernel developer bothers to hook up the proper events =
in
> the kernel sources.
>
> If you do find a likely event you want to use, you can make perf use =
it as
> a "raw" event.

Vince, resource stalls is close to what I was looking for.

libpfim4 and raw events set me on the right direction, thanks!

Yipeng
