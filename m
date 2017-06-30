From: David Ahern <dsahern@gmail.com>
Subject: Re: perf and containers
Date: Fri, 30 Jun 2017 08:55:13 -0600
Message-ID: <52ed4a27-498d-3f13-e9cc-236174c038c1@gmail.com>
References: <CAE40pdcP42zaBP_nZa1rdG7D6gDA-X2+Y6FbMfkzfkgFTnz3qA@mail.gmail.com>
 <20170630021654.GE12064@kernel.org>
 <01937385-b6d9-d7d4-0d41-3869b1b7bb48@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34507 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdF3Oz0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2017 10:55:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so15641464pge.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2017 07:55:26 -0700 (PDT)
In-Reply-To: <01937385-b6d9-d7d4-0d41-3869b1b7bb48@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 6/30/17 1:00 AM, Thomas-Mich Richter wrote:
> On 06/30/2017 04:16 AM, Arnaldo Carvalho de Melo wrote:
> 
> [...SNIP..]
> 
> I ran into a very similar issue when I tried the latest kernel 4.12 perf name space support.
> I was able to find the new PERF_RECORD_NAMESPACE entries in the perf.data file 
> but do not know how to interpret the ino-numbers shown in those entries.
> Right now the wrong symbols will be displayed...
> 
> How to interpret the inode numbers the perf NAMESPACE event emits?

The device and inode number can be used as an identifier (e.g., combine
into a u64) for the namespace when processing events.
