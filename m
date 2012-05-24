From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf 2.6.32-220.el6.x86_64 problem when recording 2 counters
Date: Thu, 24 May 2012 10:27:53 -0600
Message-ID: <4FBE6189.4040400@gmail.com>
References: <14480_1337789222_4FBD0B26_14480_3035_2_932AC94CE5A51243A6F091BAFB3EE3E0028AB9506D@THSONEA01CMS01P.one.grp> <1337819595.29765.9.camel@concordia> <25548_1337843693_4FBDDFED_25548_4972_1_932AC94CE5A51243A6F091BAFB3EE3E0028AB956D2@THSONEA01CMS01P.one.grp> <4FBE4C49.7060703@gmail.com> <15071_1337876344_4FBE5F78_15071_4976_1_932AC94CE5A51243A6F091BAFB3EE3E0028B23FD2E@THSONEA01CMS01P.one.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44514 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933360Ab2EXQ15 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 May 2012 12:27:57 -0400
Received: by dady13 with SMTP id y13so11528697dad.19
        for <linux-perf-users@vger.kernel.org>; Thu, 24 May 2012 09:27:57 -0700 (PDT)
In-Reply-To: <15071_1337876344_4FBE5F78_15071_4976_1_932AC94CE5A51243A6F091BAFB3EE3E0028B23FD2E@THSONEA01CMS01P.one.grp>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: HUMMEL Michel <michel.hummel@thalesgroup.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 5/24/12 10:19 AM, HUMMEL Michel wrote:
> Thanks for your help,
>
> I tried with a perf_3.2 binary but it gives me the same bad results.
> I Tried to read the old record, and also to generate a new one with the 3.2 binary.
>
> I am not sure to understand your suggestion with perf script and the -R option, can you give me more details please (sorry for my poor english).


RHEL6 and 2.6.32 is fairly old from perf's perspective. I have not 
looked at RHEL6 source to see how much of the upstream code was 
backported. However, the perf.data file *should* be compatible with 
upstream perf code.

So, in an attempt to better understand why you are not getting expected 
results:

1. Add -R to your record command:
perf record -R -e cycles,instructions \
    -o perf.data.cycles.instructions2 ./test_perfo2

2. Use the 3.2 version of the perf binary to analyze the file

perf_3.2 script -i perf.data.cycles.instructions2 > samples

Look at the samples file -- it will contain each sample and the event 
that triggered it (cycles or instructions). Does looking at each sample 
give some idea as to why the report does not make sense?

David
