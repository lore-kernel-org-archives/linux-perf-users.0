From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Power consumption measurements for ARM
Date: Wed, 13 Aug 2014 13:41:11 +0900
Message-ID: <874mxhf1co.fsf@sejong.aot.lge.com>
References: <53E9CE5D.9040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo04.lge.com ([156.147.1.127]:56785 "EHLO
	lgeamrelo04.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaHMElN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 13 Aug 2014 00:41:13 -0400
In-Reply-To: <53E9CE5D.9040307@gmail.com> (taeung's message of "Tue, 12 Aug
	2014 17:20:45 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: taeung <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi taeung,

On Tue, 12 Aug 2014 17:20:45 +0900, taeung wrote:
> Hi, perf hackers
>
> I have other question.
> As I know, perf also supports RAPL(running average power limit )
> for power consumption measurements.
>
> And as I understand, the amount of power consumption is estimated
> by using hardware performance counters and I/O models (sure, in
> availableintel CPUs).
>
> And I've not found power consumption measurements for ARM (likeCortex-A9)
> except for using tools like ARM Energy Probes and Linux EAPTools.
>
> But as I know , The Cortex-A9 Core Platform has dynamic scaling
> ofvoltage and frequency.
> (Dynamic Voltage and Frequency Scaling (DVFS))
>
> Have you ever tried to measure power consumption on ARM using
> thingslike DVFS?

You may want to look at powertop - see https://01.org/powertop .

>
> and I also wonder how to use perf to measure power consumption on
> available intel CPU.

Please check https://lkml.org/lkml/2013/11/12/393 .

Thanksm,
Namhyung
