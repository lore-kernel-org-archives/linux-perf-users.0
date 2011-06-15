From: Sam Liao <phyomh@gmail.com>
Subject: Re: [PATCH] [perf] Add inverted call graph report support.
Date: Wed, 15 Jun 2011 14:01:31 +0800
Message-ID: <BANLkTikcxA53t1ummUG3-3TagFhj==qYjw@mail.gmail.com>
References: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
	<20110609193300.GA16858@dev1756.snc6.facebook.com>
	<20110614221517.GA20319@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55613 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1FOGBc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jun 2011 02:01:32 -0400
In-Reply-To: <20110614221517.GA20319@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Wed, Jun 15, 2011 at 6:15 AM, Arun Sharma <asharma@fb.com> wrote:
> Sam,
>
> $ perf report -g graph,0.5,caller --sort pid
>
> is a bit hard to type. Perhaps add a simpler command line option
> that has the same effect?
>
> =A0-Arun
>
>

How about perf report -g [caller/callee,][graph,0.1] -s pid

or remove the order of the options for "-g"

-Sam
