From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Filter option should follow a tracer option
Date: Wed, 23 Aug 2017 09:06:07 +0300
Message-ID: <a214874a-a271-729e-d253-731e648a10e6@intel.com>
References: <2141818167.39420.1503049431846@office.mailbox.org>
 <20170822190011.GA31893@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:23442 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753259AbdHWGOq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2017 02:14:46 -0400
In-Reply-To: <20170822190011.GA31893@kernel.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jack Henschel <jackdev@mailbox.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org

On 22/08/17 22:00, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 18, 2017 at 11:43:51AM +0200, Jack Henschel escreveu:
>> Hi everyone,
>>
>> I'm experimenting with Intel PT and perf, but I am currently stuck at getting filters to work with `perf record`.
>>
>> I have the following command:
>>> perf record -e intel_pt// --filter 'filter main @ /bin/sleep' /bin/sleep 1
>> But it throws this error message:
>>> --filter option should follow a -e tracepoint or HW tracer option
>>
>> Maybe this is a trivial mistake, but I don't understand the error, because as far as I'm concerned the --filter options *is* following a -e HW tracer option.
>>
>> I'm using perf version 4.9.30 with kernel 4.9.30-2+deb9u3 on Debian 9 Stretch.

It looks like either your CPU does not support Intel PT at all, or it does not support address filtering.

What CPU is it?

Have you checked the value of /sys/bus/event_source/devices/intel_pt/nr_addr_filters ?
