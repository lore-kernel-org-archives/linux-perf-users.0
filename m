From: Christopher Covington <cov@codeaurora.org>
Subject: Re: perf branch
Date: Mon, 14 Apr 2014 08:53:16 -0400
Message-ID: <534BDA3C.7080603@codeaurora.org>
References: <CAH+i1GK4QdEzoa05PUN-Zx8Gzr2-w0RY631a9MzvTvyMAs1fGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:34473 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbaDNMxS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Apr 2014 08:53:18 -0400
In-Reply-To: <CAH+i1GK4QdEzoa05PUN-Zx8Gzr2-w0RY631a9MzvTvyMAs1fGg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Noah Luther <nluther@vt.edu>
Cc: linux-perf-users@vger.kernel.org

Hi Noah,

On 04/13/2014 11:55 PM, Noah Luther wrote:
> Hello,
> 
> I am trying to use perf to trace branches as described by the 'perf
> branch' subcommand. Is there support through perf_event_open to access
> the buffer storing branch traces? I saw Akihiro Nagai's presentation
> on 'perf branch', but haven't yet figured out how to enable BTS and
> access the buffer based on the documentation on this page:
> 
> http://web.eece.maine.edu/~vweaver/projects/perf_events/perf_event_open.html
> 
> If there are any resources that might be of use to me, I would
> appreciate any assistance.

In the past I've found the test suite to be a useful reference. Here's a test
that looks like it might serve as a jumping-off point.

https://github.com/deater/perf_event_tests/blob/master/tests/record_sample/sample_branch_stack.c

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
