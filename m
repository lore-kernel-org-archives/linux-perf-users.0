From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Event not supported
Date: Tue, 18 Feb 2014 19:22:07 +0100
Message-ID: <5303A4CF.3060200@gmail.com>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:46360 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaBRSWU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Feb 2014 13:22:20 -0500
Received: by mail-wg0-f54.google.com with SMTP id l18so3520035wgh.21
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2014 10:22:19 -0800 (PST)
In-Reply-To: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>, linux-perf-users@vger.kernel.org

Hi,

What is your CPU ?

Regarding the perf version, on my Ubuntu 13.04 running linux 3.11.0-15 I 
successfully installed the associated perf version using:

sudo apt-get install linux-tools-3.11.0-15-generic


Manu

On 02/18/2014 05:51 PM, Martin Ichilevici de Oliveira wrote:
> Hello,
>
> I'm still learning perf, so I apologize in advance if my questions are
> too simple and not suited here. I did, however, searched the web and
> tried to find a solution by myself before posting to this mailing
> list.
>
>  From my manufacturer's manual, I chose an event I'm interested in
> monitoring. They also list unit masks, as below:
>
> UnitMask    Description
> 7                  From Local node to Node 7
> 6                  From Local node to Node 6
> 5                  From Local node to Node 5
> 4                  From Local node to Node 4
> 3                  From Local node to Node 3
> 2                  From Local node to Node 2
> 1                  From Local node to Node 1
> 0                  From Local node to Node 0
>
> The event is "CPU to DRAM Requests to Target Node" (NUMA machine) and
> it's number is 0x1E0. As I understood, I should precede the event with
> the unit mask. So, for example, if I'm interested in unit mask 2, I
> should type:
>
> perf stat -e r21e0 /bin/ls
>
> However, this results in a <not supported> message. This happened for
> all events that have a unit mask that I tried. Other events worked
> fine.
>
> I'm not sure whether I'm giving the right command or this is a problem
> with perf/kernel version. As it turned out, I'm running Ubuntu with
> kernel 3.11.10-03111002, but the latest available perf version from
> the repositories is 3.8.0-35, which is the one I'm using.
>
> Any help is appreciated.
>
> Thank you,
> Martin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
