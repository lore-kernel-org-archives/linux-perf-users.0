From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Sample memory references with at least a given latency?
Date: Wed, 04 Feb 2015 15:20:40 +0100
Message-ID: <54D22AB8.4060607@bsc.es>
References: <54D21524.8010305@bsc.es> <CALbiyZyJhUNfMNOYwJ26P-Lq+3E_xM8SpZ9CG+WR70-n_k9x8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:59570 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156AbbBDOVf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 Feb 2015 09:21:35 -0500
In-Reply-To: <CALbiyZyJhUNfMNOYwJ26P-Lq+3E_xM8SpZ9CG+WR70-n_k9x8A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


Hello Manuel,

   I'm running Linux 3.11 but I don't see a way to setup the latency 
threshold there. My option flags include:

        -t, --type=
        -D, --dump-raw-samples=
        -x, --field-separator
        -C, --cpu-list

   so I guess that this option is not implemented in perf (at least on 
3.11). So I need to capture all the samples and then discard those that 
surpass that threshold.

   Going back into your example, is it possible to capture / show the 
timestamp for the captured samples? I've seen the Intel documentation, 
and there aren't timestamps in PEBS entries so that may require 
additional work. IIRC, someone of the list told me that perf allocates a 
1-entry PEBS buffer so every time PEBS fills it, perf somehow gets an 
interrupt indicating that it has to flush it. This way, perf can 
attribute a timestamp to that sample also.

Thank you very much!


On 04/02/15 15:00, Manuel Selva wrote:
> Hi Harald,
>
> Yes you can with the "perf mem" tool. It has been introduced in kernel
> 3.10 (correct me if I am wrong, not very sure about that). It's built on
> top of perf mem record and perf mem report but hide for you the
> complxity of choosing the memory events . See "man perf mem" for th details.
>
> ----------
> Manuel
>
>
>
> 2015-02-04 13:48 GMT+01:00 Harald Servat <harald.servat@bsc.es
> <mailto:harald.servat@bsc.es>>:
>
>     Hello list,
>
>        is there any way to configure perf to sample memory references
>     through PEBS and enable the Load Latency Performance Monitoring
>     Facility (section 18.7.1.2 from the Intel 64 and IA-32 Architectures
>     Software Developer's Manual).
>
>     Thank you very much in advance.
>
>     WARNING / LEGAL TEXT: This message is intended only for the use of the
>     individual or entity to which it is addressed and may contain
>     information which is privileged, confidential, proprietary, or exempt
>     from disclosure under applicable law. If you are not the intended
>     recipient or the person responsible for delivering the message to the
>     intended recipient, you are strictly prohibited from disclosing,
>     distributing, copying, or in any way using this message. If you have
>     received this communication in error, please notify the sender and
>     destroy and delete any copies you may have received.
>
>     http://www.bsc.es/disclaimer
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-perf-users" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/__majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
>
>


WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
