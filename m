From: William Cohen <wcohen@redhat.com>
Subject: Re: "perf top" what does high CPU use in _schedule means?
Date: Thu, 15 Feb 2018 14:41:44 -0500
Message-ID: <67f13f80-9a40-3db5-207b-afdd9be3e6b0@redhat.com>
References: <CAOrc50R1iVsqXGBF+L_WnYrXsb82mY0JLDaMPhCsSjUX4=fJDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751512AbeBOTlp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Feb 2018 14:41:45 -0500
In-Reply-To: <CAOrc50R1iVsqXGBF+L_WnYrXsb82mY0JLDaMPhCsSjUX4=fJDg@mail.gmail.com>
Content-Language: en-MW
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hemant Jain <hemu.mits@gmail.com>, linux-perf-users@vger.kernel.org

On 02/15/2018 05:58 AM, Hemant Jain wrote:
> In one of my test env I am setting perf top is showing ~20% time CPU
> spent in _schedule function.
> What does means ?
> 
> In my setup I have 6 cores and lot of threads are running.
> CPU usage is also very less during this time.(~10%)
> My application has some data to process but is not doing any processing.
> 
> I am new to this mailing list. Hope I am using correct mailing list alias :).

Hi,

When "perf top" is running you might use the cursor keys to select the function you are interested in ("_schedule") and then select the following line:

Annotate _schedule

It should give more detail about where in _schedule code that time is being spent.  If you have debuginfo for the kernel installed, it will intermix the source code lines with the assembly code.  The compiler optimization will make this inexact meshing of the assembly language and the source code, but it can help.

-Will
