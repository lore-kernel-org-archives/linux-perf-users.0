From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 12:09:22 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu>
References: <5450A049.3040803@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:33018 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933751AbaJ2QCc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 12:02:32 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so2663307qcy.14
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 09:02:31 -0700 (PDT)
In-Reply-To: <5450A049.3040803@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 29 Oct 2014, Manuel Selva wrote:

> I am trying to setup load latency sampling on a Sandy Bridge processor (Cpu
> familly 6, model 42, model name  Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz)
> running a 3.13 linux kernel.
> 
> After deep investigations made of reading of the Intel SDM, examples provided
> by the pfm library and the source code of perf, I am still not able to get
> sample. I think for now that my problem is related to the precise_ip parameter
> of the  perf_event_attr structure.
> 
> Any time I change this value from 0 to 1 or from 0 to 2 (2 is the value to
> enable PEBS isn't it ?) the perf_event_open system call failed with a "Not
> supported operation" error. Running perf mem record on this Sandy Bridge
> platform also result in the same error.

Which event are you trying to use?

On my Ivybrige machine using 3.14 I am able to get latency values with
	pe.config=0x1cd;        
        pe.config1=3;           
        pe.precise_ip=2;

Vince
