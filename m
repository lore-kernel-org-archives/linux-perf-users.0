From: taeung <treeze.taeung@gmail.com>
Subject: Power consumption measurements for ARM
Date: Tue, 12 Aug 2014 17:20:45 +0900
Message-ID: <53E9CE5D.9040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54049 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaHLIUu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Aug 2014 04:20:50 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so12740749pab.29
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Aug 2014 01:20:49 -0700 (PDT)
Received: from [192.168.1.215] ([106.245.241.10])
        by mx.google.com with ESMTPSA id co14sm10509672pac.43.2014.08.12.01.20.48
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 01:20:49 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, perf hackers

I have other question.
As I know, perf also supports RAPL(running average power limit )
for power consumption measurements.

And as I understand, the amount of power consumption is estimated
by using hardware performance counters and I/O models (sure, in 
availableintel CPUs).

And I've not found power consumption measurements for ARM (likeCortex-A9)
except for using tools like ARM Energy Probes and Linux EAPTools.

But as I know , The Cortex-A9 Core Platform has dynamic scaling 
ofvoltage and frequency.
(Dynamic Voltage and Frequency Scaling (DVFS))

Have you ever tried to measure power consumption on ARM using thingslike 
DVFS?

and I also wonder how to use perf to measure power consumption on 
available intel CPU.

- Taeung -
