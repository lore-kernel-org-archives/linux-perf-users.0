From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [RFC] --dump-sym-trace
Date: Fri, 28 Jan 2011 13:18:03 -0800
Message-ID: <AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>
	<4D3F871B.3060906@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50103 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab1A1VSE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Jan 2011 16:18:04 -0500
Received: by iwn9 with SMTP id 9so3511334iwn.19
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jan 2011 13:18:03 -0800 (PST)
In-Reply-To: <4D3F871B.3060906@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, Jan 25, 2011 at 6:29 PM, David Ahern <daahern@cisco.com> wrote:
> From a brief glance seems similar to the timehist patch I proposed. See:
> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html

The output could be a bit more compact (eg: print some info once per
stack trace rather than once per frame). Also, it doesn't seem to
print the DSO name when symbol lookup fails?

Otherwise looks great. I'll drop the other patch.

 -Arun
