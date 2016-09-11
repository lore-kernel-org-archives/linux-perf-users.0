From: Andi Kleen <andi@firstfloor.org>
Subject: Re: reading PMU counts with perf leader sampling and perf script
Date: Sat, 10 Sep 2016 20:21:51 -0700
Message-ID: <87sht7p1dc.fsf@tassilo.jf.intel.com>
References: <etPan.57d2cbe0.548515bd.6188@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18852 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbcIKDVx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 10 Sep 2016 23:21:53 -0400
In-Reply-To: <etPan.57d2cbe0.548515bd.6188@cern.ch> (Omar Awile's message of
        "Fri, 9 Sep 2016 14:48:53 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Omar Awile <omar.awile@cern.ch>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Omar Awile <omar.awile@cern.ch> writes:
>
> The next step would be for me to use perf script and a little python
> script to get the event counts but I can’t seem to find a way to do
> this. Can someone point me in the right direction?

The easiest is to just run perf script without arguments and parse the output.

-Andi
