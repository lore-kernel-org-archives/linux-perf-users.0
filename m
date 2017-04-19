From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf_event sampling a multithreaded process - ioctl with PERF_EVENT_IOC_SET_OUTPUT fails
Date: Wed, 19 Apr 2017 08:46:23 -0700
Message-ID: <877f2go0xc.fsf@firstfloor.org>
References: <d7635c6e-1d12-52d7-6b9f-b7c08d3a451f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:24257 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937651AbdDSPq0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2017 11:46:26 -0400
In-Reply-To: <d7635c6e-1d12-52d7-6b9f-b7c08d3a451f@gmail.com> (Daniel John
        FitzGerald's message of "Wed, 19 Apr 2017 11:15:20 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Daniel John FitzGerald <daniel.j.fitzgerald@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Daniel John FitzGerald <daniel.j.fitzgerald@gmail.com> writes:
>
> The problem that I am running into is that whenever I attempt to call
> ioctl() with PERF_EVENT_IOC_SET_OUTPUT, I get a -1 response with
> errno==EINVAL.

There are lots of restrictions to PERF_EVENT_IOC_SET_OUTPUT.

Likely you're violating that it has to be on the same CPU or same task.

-Andi
