From: Andi Kleen <andi@firstfloor.org>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Fri, 06 Jan 2017 10:49:35 -0800
Message-ID: <87zij4nhvk.fsf@firstfloor.org>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54107 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754447AbdAFStg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2017 13:49:36 -0500
In-Reply-To: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
        (Christian Convey's message of "Thu, 5 Jan 2017 22:49:13 -0500")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christian Convey <christian.convey@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Christian Convey <christian.convey@gmail.com> writes:
>
> Any suggestions for a good/better way to pull this off?

Use the right tool for the job.

On Intel, use a Broadwell or Skylake or Goldmont and use processor trace.

perf record -e intel_pt//u foo
perf script --itrace=cr

-Andi
