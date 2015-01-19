From: Jan Heylen <heyleke@gmail.com>
Subject: Re: perf: Kconfig based feature selection
Date: Mon, 19 Jan 2015 21:02:15 +0100
Message-ID: <CAGszK3gvpa+wd5-vCtHi1cuty-xtiQqnKz2c_BtZgqv1CtUk6w@mail.gmail.com>
References: <CAGszK3i4ZuvCp_jSkCV26dPAeAUbjJ1PV7b0WtgmAK5Dn+1VaQ@mail.gmail.com>
	<54BD28A6.2030206@gmail.com>
	<20150119160416.GA23726@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:58961 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbASUCQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Jan 2015 15:02:16 -0500
Received: by mail-wg0-f54.google.com with SMTP id b13so3477617wgh.13
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2015 12:02:15 -0800 (PST)
In-Reply-To: <20150119160416.GA23726@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org, Alexis Berlemont <alexis.berlemont@gmail.com>

On Mon, Jan 19, 2015 at 5:04 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> On Mon, Jan 19, 2015 at 08:54:14AM -0700, David Ahern wrote:
>> On 1/19/15 2:35 AM, Jan Heylen wrote:
>> >Hi,
>> >
>> >I was wondering what the status is for following item on the TODO list:
>> >
>> >Use Kconfig to allow selecting features and build minimal version of
>> >perf, e.g. one with just 'record' for use in embedded platforms.
>> >
>> >David Ahern prototyped this, dig those patches and update them
>> >
>> >
>> >I tried a search for Kconfig on this mailing list it's archives, but
>> >no good hit.
>> >
>> >I see in the github repos from David Ahern a link to commits from
>> >Alexis Berlemont that look interesting, is there a plan to upstream
>> >this?
>> >https://github.com/aberlemont/linux/tree/perf/kbuild
>>
>> Latest incarnation: https://lkml.org/lkml/2015/1/15/310
>>
>
> and very latest one ine here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/build
>
> v3 is coming shortly ;-)
>
> jirka

Nice work.

What is the status on the first part of the TODO list?

> >Use Kconfig to allow selecting features and build minimal version of
> >perf, e.g. one with just 'record' for use in embedded platforms.

I don't find this back in this patch series, although it looks like a
good base to make this possible?

About the perf-feature choosing though Kconfig alike infrastructure as
in Alexis tree. Is there a plan to pick up that work too or isn't that
the intention?

Jan
