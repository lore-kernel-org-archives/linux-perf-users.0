From: David Ahern <dsahern@gmail.com>
Subject: Re: perf: Kconfig based feature selection
Date: Mon, 19 Jan 2015 08:54:14 -0700
Message-ID: <54BD28A6.2030206@gmail.com>
References: <CAGszK3i4ZuvCp_jSkCV26dPAeAUbjJ1PV7b0WtgmAK5Dn+1VaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58740 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbASPyQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Jan 2015 10:54:16 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so8940912pab.11
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2015 07:54:16 -0800 (PST)
In-Reply-To: <CAGszK3i4ZuvCp_jSkCV26dPAeAUbjJ1PV7b0WtgmAK5Dn+1VaQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jan Heylen <heyleke@gmail.com>, linux-perf-users@vger.kernel.org
Cc: alexis.berlemont@gmail.com, Jiri Olsa <jolsa@redhat.com>

On 1/19/15 2:35 AM, Jan Heylen wrote:
> Hi,
>
> I was wondering what the status is for following item on the TODO list:
>
> Use Kconfig to allow selecting features and build minimal version of
> perf, e.g. one with just 'record' for use in embedded platforms.
>
> David Ahern prototyped this, dig those patches and update them
>
>
> I tried a search for Kconfig on this mailing list it's archives, but
> no good hit.
>
> I see in the github repos from David Ahern a link to commits from
> Alexis Berlemont that look interesting, is there a plan to upstream
> this?
> https://github.com/aberlemont/linux/tree/perf/kbuild

Latest incarnation: https://lkml.org/lkml/2015/1/15/310

David

>
> One thing that I don't see is, in libperf, nothing seem to be stripped
> out if you e.g. only select 'record'. Is this correct? But this
> observation is only based on looking at the github repo kbuild files,
> I'll have to clone Alexis his repo to have a closer look.
