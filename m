From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Mon, 9 Jan 2017 22:33:54 +0530
Message-ID: <20170109170354.GD13299@naverao1-tp.localdomain>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <3722511.TPbTubHR2j@milian-kdab2>
 <CAPfS4ZyBOz_E5k3DKf8qqMbrKacCpijBM4-aUsgeL5LJTnxNyw@mail.gmail.com>
 <20170108084403.39baa3d793af5fed3ed4aeac@kernel.org>
 <CAPfS4ZzKPTPrBJY+yhMBte_wyVgTnt-kuDUGF39BxV0NZs+TDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38985 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1762967AbdAIREL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 12:04:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v09H3tAB062152
        for <linux-perf-users@vger.kernel.org>; Mon, 9 Jan 2017 12:04:10 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27vcaq6sn9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2017 12:04:10 -0500
Received: from localhost
        by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Mon, 9 Jan 2017 22:34:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
        by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5DF55E005A
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2017 22:35:01 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
        by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v09H3xY939190710
        for <linux-perf-users@vger.kernel.org>; Mon, 9 Jan 2017 22:33:59 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
        by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v09H3vQQ019785
        for <linux-perf-users@vger.kernel.org>; Mon, 9 Jan 2017 22:33:59 +0530
Content-Disposition: inline
In-Reply-To: <CAPfS4ZzKPTPrBJY+yhMBte_wyVgTnt-kuDUGF39BxV0NZs+TDQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christian Convey <christian.convey@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

On 2017/01/09 10:19AM, Christian Convey wrote:
> Hi Masami,
> 
> On Sat, Jan 7, 2017 at 6:44 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > No, you can use $params for tracing all function parameters :)
> > So, please try "* $params" instead of "*".
> 
> Thanks for the tip!  I tried it out, and got some strange results: The
> correct set of function parameter names is present in
> "trace_unhandled" 's "event_fields_dict" dictionary.  However, the
> actual runtime values of those parameters is sometimes inaccurate.
> 
> I'm using a simple Fibonacci program with just two functions: "main"
> and "fibfunc".
> 
> Here are my steps:
> 
> gcc -g -fno-omit-frame-pointer -O0 fib.c -o fib
> 
> export PERF_EXEC_PATH=/home/cconvey/src/linux-4.8.0/tools/perf
> 
> sudo -E ${PERF_EXEC_PATH}/perf probe --exec=./fib --del='*'
> 
> sudo -E ${PERF_EXEC_PATH}/perf probe --exec=./fib --add='* $params'
> 
> sudo -E ${PERF_EXEC_PATH}/perf record -e 'probe_fib:*' -aR ./fib 3
> 
> # My script which currently just prints the parameters passed to
> 'trace_unhandled'.
> sudo -E ${PERF_EXEC_PATH}/perf script -s ./perf-script-2.py
> 
> 
> Here's an example of the output from my script:
> 
> > in trace_begin
> > event_name = "probe_fib__main"
> > event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209748661, 'argv': 94718640125824, 'common_cpu': 6, 'argc': 22053, '__probe_ip': 94718640125737}
> >
> > event_name = "probe_fib__fibfunc"
> > event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209756797, 'n': 0, 'common_cpu': 6, '__probe_ip': 94718640125664}
> >
> > event_name = "probe_fib__fibfunc"
> > event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209757849, 'n': 32764, 'common_cpu': 6, '__probe_ip': 94718640125664}
> >
> > event_name = "probe_fib__fibfunc"
> > event_fields_dict: {'common_callchain': [], 'common_pid': 18631, 'common_s': 98414, 'common_comm': 'fib', 'common_ns': 209758915, 'n': 2, 'common_cpu': 6, '__probe_ip': 94718640125664}
> >
> > in trace_end
> 
> Notice, for example, that the reported value for "argc" is 22053, rather than 2.
> 
> Any idea why that might be happening?

Try compiling your program with -O2, or use a newer perf:
https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?id=e47392bf9c0613a058cd20ee89d8ce9d957d4b24

- Naveen
