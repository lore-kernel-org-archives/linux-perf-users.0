From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Port the period data column to centos6.7 for perf script
Date: Thu, 14 Sep 2017 21:21:54 -0700
Message-ID: <20170915042154.GJ24844@tassilo.jf.intel.com>
References: <CAHCio2j0TO0dQtr1Dk+v0=k_1pzwzqhZCJBkUTHCKqFgNGdoBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:43675 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbdIOEV4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2017 00:21:56 -0400
Content-Disposition: inline
In-Reply-To: <CAHCio2j0TO0dQtr1Dk+v0=k_1pzwzqhZCJBkUTHCKqFgNGdoBg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>, namhyung@kernel.org, Wind Yu <yuzhoujian@didichuxing.com>, Milian Wolff <milian.wolff@kdab.com>, sj38.park@gmail.com, tardyp@gmail.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

On Fri, Sep 15, 2017 at 10:24:15AM +0800, 禹舟键 wrote:
>    Hi, all.
>    I want to draw off-cpu flamegraph using perf script on centos6.7(kernel
>    version, 2.6.32-573), and I found perf script lacks the period data column
>    on that version. IÂ  found two related patches, and modifed
>    builin-script.c in reference to those patches.
>    perf script:Add period data column authorJiri Olsa 2014-08-25 16:45:42
>    +0200 commit535aeaae7de821ba5d43ee2a204ee667ca95aae4
>    perf script: Add period as a default output column
>    commite8564b710c6df2c3aeb56c507c22f4bcfa4c0b2d)
> 

I would just compile the newer perf binary for Centos6 and use that. It should
work with older kernels too. That's much easier than backporting, and you get
many more features.

-Andi
