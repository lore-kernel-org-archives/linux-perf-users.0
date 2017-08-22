From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Filter option should follow a tracer option
Date: Tue, 22 Aug 2017 16:00:11 -0300
Message-ID: <20170822190011.GA31893@kernel.org>
References: <2141818167.39420.1503049431846@office.mailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbdHVTAQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2017 15:00:16 -0400
Content-Disposition: inline
In-Reply-To: <2141818167.39420.1503049431846@office.mailbox.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Jack Henschel <jackdev@mailbox.org>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Aug 18, 2017 at 11:43:51AM +0200, Jack Henschel escreveu:
> Hi everyone,
> 
> I'm experimenting with Intel PT and perf, but I am currently stuck at getting filters to work with `perf record`.
> 
> I have the following command:
> > perf record -e intel_pt// --filter 'filter main @ /bin/sleep' /bin/sleep 1
> But it throws this error message:
> > --filter option should follow a -e tracepoint or HW tracer option
> 
> Maybe this is a trivial mistake, but I don't understand the error, because as far as I'm concerned the --filter options *is* following a -e HW tracer option.
> 
> I'm using perf version 4.9.30 with kernel 4.9.30-2+deb9u3 on Debian 9 Stretch.

Adrian,

	Are you subscribed to linux-perf-users?

- Arnaldo
