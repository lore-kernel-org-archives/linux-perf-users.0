From: Vivek Nair <vivekaxl@gmail.com>
Subject: Fwd: Perf Cgroup Support
Date: Wed, 15 Jan 2014 16:34:48 -0500
Message-ID: <CAOWdYyWjqnu4RT91bWN15+A0dff_fZmEKgteUDbnJa090DHouQ@mail.gmail.com>
References: <CAOWdYyWGPz90n5p_=ebKWLT+xU5TgmbWoyo75d072p60v9FZBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:44352 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbaAOVfK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jan 2014 16:35:10 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so1402347qac.22
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2014 13:35:09 -0800 (PST)
In-Reply-To: <CAOWdYyWGPz90n5p_=ebKWLT+xU5TgmbWoyo75d072p60v9FZBg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Dear All,

I am using perf to count events for cgroups. I am getting some wierd results.

For example, I am using the following toy program:
for(a=0;a<4000;a++)
{
count=0;
for(b=0;b<4000;b++)
for(c=0;c<4000;c++)
count++;
}

I measure the values of the performance counter while program
1. as a process - perf stat -p 'pid' sleep 1 and I run this every
second till the end of the program. So, at the end of the run, I get
time series of performance counter values
2. inside a Cgroup. - perf stat -G "cgroup-name" sleep 1 and I run
this every second till the end of the program.

But, I get really strange results. For example, the average values of
the number of branches in case of the process is 411.1236M/sec where
as the number of branches in case of the Cgroup it's 103.20M/sec.
Since, the number of branch instruction is expected to be constant,
this would mean that the run time of the program has to be around 4
times more than the normal running time. But, this is not the case.

How can I explain this?

Regards,
Vivek Nair
