From: Christian Convey <christian.convey@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Fri, 6 Jan 2017 15:05:05 -0500
Message-ID: <CAPfS4ZyBOz_E5k3DKf8qqMbrKacCpijBM4-aUsgeL5LJTnxNyw@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <3722511.TPbTubHR2j@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34421 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937946AbdAFUFG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2017 15:05:06 -0500
Received: by mail-qt0-f179.google.com with SMTP id l7so39324332qtd.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jan 2017 12:05:06 -0800 (PST)
In-Reply-To: <3722511.TPbTubHR2j@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, Jan 6, 2017 at 5:16 AM, Milian Wolff <milian.wolff@kdab.com> wrote:
...
> There is a catch-all handler:
>
> *trace_unhandled*, if defined, is called after for any event that
>  doesn't have a handler explicitly defined for it.  The standard set
>  of common arguments are passed into it:
>
> ----
> def trace_unhandled(event_name, context, common_cpu, common_secs,
>         common_nsecs, common_pid, common_comm):
>     pass
> ----
>
> Maybe you can use that one instead? I'd still be interested to know whether
> you can get all required information. If not, extending the API is doable.

Hi Milian,

Thanks for the idea - I tried it out.  My Python script was a bit ugly
/ hackish, but it did allow me to trace basic call/return information.

With your approach, it was also easy to trace the return-value of each
function call: I modified my return-probe definition to be "*:%return
$retval".  After that, the "trace_unhandled" function can access the
return value via "event_fields_dict['arg1']".

There are two more improvements I'd like to make, but they're less important:

(1) For each function being traced, I'd like to report the values of
all of its parameters.  (SystemTap makes this easy.)  Unfortunately,
`perf probe`'s probe-argument syntax seems to require that I know the
name of every function-parameter I want to probe.  So I may end up
having to write a script that parses either (a) the target program's
DWARF info, or (b) the output of `perf probe --vars`.

(2) I want the tracing to be robust even if the target program
dynamically links to `.so` files that I didn't anticipate when
creating the probes.  I haven't found any documentation regarding how
gracefully perf, SystemTap, etc. handle that situation.  I'm not sure
how I'd solve this problem.  Perhaps hooking `dlopen` is an option.

- Christian
