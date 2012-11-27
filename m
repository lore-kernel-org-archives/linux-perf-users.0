From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: perf stat -e cycles -p <pid> sleep 10
Date: Tue, 27 Nov 2012 15:47:16 +0900
Message-ID: <50B461F4.10003@core.kaist.ac.kr>
References: <loom.20121126T234917-97@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:53912 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab2K0Grv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Nov 2012 01:47:51 -0500
In-Reply-To: <loom.20121126T234917-97@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chris Freehill <cfreehill@gmail.com>
Cc: linux-perf-users@vger.kernel.org

What kind of distributions you've tested?

In my case(ubuntu 11.04), it works correctly.

I suspect your machine's PMU status, wrong installation, or missing per=
f=20
kernel module.




2012-11-27 =EC=98=A4=EC=A0=84 7:50, Chris Freehill =EC=93=B4 =EA=B8=80:
> Hi,
>
> Apologies if the answer to this is someplace I have not looked. I've =
searched
> this list and other sites/FAQ's.
>
> I've noticed that command listed in the subject line always yields
>
> <not counted> cycles
>
> unless the target process is suspended. I have noticed this with a fe=
w different
> distributions. Is the fact that the target process has to be suspende=
d at least
> once a known design limitation or would it be considered a bug?
>
> Thank you for your help.
>
> Chris
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
