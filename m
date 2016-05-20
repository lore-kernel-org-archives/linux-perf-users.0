From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Getting PEBS to work
Date: Thu, 19 May 2016 17:09:13 -0700
Message-ID: <CAE40pdeh9p2KkttOqB=u0DJYjy=ikN1=1r2fvDm-=HhPRFsfWQ@mail.gmail.com>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
 <CAPAnC4PsdkN=9NQ6D_n2p6NX64yB0ASXhTqQRsGw5N3Jvr3d2A@mail.gmail.com>
 <CAE40pdft3O+5YmaX=KqvVnWo1Lne=VR41-zOdpYC4Q0P4i-Tfw@mail.gmail.com> <CAPAnC4PGktN_QYu9T6f5=p0cJ1wV59TWNcPYpskYDck=O=7faw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33638 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbcETAJo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 20:09:44 -0400
Received: by mail-io0-f179.google.com with SMTP id t40so35957956ioi.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2016 17:09:43 -0700 (PDT)
In-Reply-To: <CAPAnC4PGktN_QYu9T6f5=p0cJ1wV59TWNcPYpskYDck=O=7faw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: jim mauro <jim.mauro@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Thu, May 19, 2016 at 4:53 PM, jim mauro <jim.mauro@gmail.com> wrote:
> Hey Brendan -
>
> D'oh! No mate, I do not have PEBS working.
>
> # perf record -e r412e:pp -c 10000 -a -- sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
> event (r412e:pp).
>
> This is an Ivy Bridge system, 3.8.13 kernel. Not yet sure why it's not
> working, digging in now....
>
> As an aside, I'm looking at Table 18-27 PEBS Performance Events for Intel
> Microarchitecture Code Name Sandy Bridge in the
> Intel manual, and I do not see LLC misses as a supported PEBS event.

Ah, thanks, hm, wonder where I saw LLC miss as PEBS then.

Well, INST_RETIRED should be a safer test, as that's in table 18-27:

# perf record -e r01c0:p -c 100000000 -a -- sleep 1
Error:
'precise' request may not be supported. Try removing 'p' modifier.
sleep: Terminated

Brendan
