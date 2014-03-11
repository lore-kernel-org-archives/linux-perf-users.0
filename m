From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Subject: Re: Event not supported
Date: Tue, 11 Mar 2014 13:53:27 -0300
Message-ID: <CAOanW0OwDhqQnZ1B3QCm5HFFom26TSxHBQbToU3cBSxT3tZf3Q@mail.gmail.com>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
 <5303A4CF.3060200@gmail.com> <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com>
 <5303B986.2070801@gmail.com> <CAOanW0OiK8QTgLxajx=pEaW4XWD94hnNUOf=-e=Y1ch2LA9j3A@mail.gmail.com>
 <alpine.DEB.2.10.1402190754540.21724@vincent-weaver-1.um.maine.edu>
 <CAOanW0OzQnpt+cr6m8VFYj1CGPQoyecEQidt_5wZzxG4CAj_Gw@mail.gmail.com>
 <alpine.DEB.2.10.1402261634260.1178@vincent-weaver-1.um.maine.edu> <CAOanW0NSAPa1opj-e=qQx=XNbTE-PERqUzyXtytCyNpyLMOECg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:53524 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaCKQyI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 11 Mar 2014 12:54:08 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so11723390igb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2014 09:54:08 -0700 (PDT)
In-Reply-To: <CAOanW0NSAPa1opj-e=qQx=XNbTE-PERqUzyXtytCyNpyLMOECg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

On Fri, Feb 28, 2014 at 6:35 AM, Martin Ichilevici de Oliveira
<martin.i.oliveira@gmail.com> wrote:
> On Wed, Feb 26, 2014 at 6:38 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
>> On Wed, 26 Feb 2014, Martin Ichilevici de Oliveira wrote:
>>
>>
>> Linux 3.9 and Linux 3.10 have very different amd15h northbridge support.
>> If you're looking for long-term usability of your project/tool/research
>> you probably want to jump straight to 3.10 so you don't have to make
>> everything work on 3.9 and then change it all again when you move to newer
>> kernels.
>>
>> Vince
>
> I installed Linux 3.10 but it's still not clear to me how to profile
> amd15h northbridge events, as I keep getting unsupported event
> messages. Also, I tried using papi_component_avail and it says that
> perf_events_uncore is disabled (no uncore PMUs or or events found).

Do I need to compile my kernel (3.10) with explicit support? I don't
understand why papi_component_avail keeps saying that
perf_events_uncore is disabled.
