From: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Subject: Re: Why the need to do a perf_event_open syscall for each cpu on the system?
Date: Sun, 15 Mar 2015 07:15:29 +0200
Message-ID: <CAL2Y34DEW+HvF6tsFH5qg-RxkAmstEcK=qYhkcRV6D8DCFG3kg@mail.gmail.com>
References: <55033138.5010500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36214 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbCOFPa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 15 Mar 2015 01:15:30 -0400
Received: by iegc3 with SMTP id c3so151269585ieg.3
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Mar 2015 22:15:29 -0700 (PDT)
In-Reply-To: <55033138.5010500@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users@vger.kernel.org

Hi,

Not an expert, but my understanding is that it's just technical
difficulty. Performance metrics are being saved in per-cpu buffer.
Having pid==-1 and cpu==-1 means that something would aggregate all
buffers in multiple CPUs to a single buffer. That code must exist,
either in userspace or in the kernel.

The kernel preferred that this code would be in userspace.

On Fri, Mar 13, 2015 at 8:49 PM, William Cohen <wcohen@redhat.com> wrote:
> Hi All,
>
> I have a design question about the linux kernel perf support. A number of /proc statistics aggregate data across all the cpus in the system.  Why the does perf require the user-space application to enumerate all the processors and do a perf_event_open syscall for each of the processors?  Why not have a perf_event_open with pid=-1 and cpu=-1 mean system-wide event and aggregate it in the kernel when the value is read?  The line below from design.txt specifically say it is invalid.
>
> (Note: the combination of 'pid == -1' and 'cpu == -1' is not valid.)
>
> -Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
