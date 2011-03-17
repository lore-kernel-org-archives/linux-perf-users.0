From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [perfmon2] How does take use of EventName and UnitMask?
Date: Thu, 17 Mar 2011 08:43:21 -0700
Message-ID: <AANLkTinjmVwtWpAnGPyehn0kT6U3KQWKPU0iz=Fb45aA@mail.gmail.com>
References: <tencent_5D9EFCFD67548CB92638B8BA@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33822 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1CQPnY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Mar 2011 11:43:24 -0400
Received: by iyb26 with SMTP id 26so2944085iyb.19
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Mar 2011 08:43:23 -0700 (PDT)
In-Reply-To: <tencent_5D9EFCFD67548CB92638B8BA@qq.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Easley <ugiwgh@gmail.com>
Cc: perfmon2-devel <perfmon2-devel@lists.sourceforge.net>, chenwj <chenwj@iis.sinica.edu.tw>, Lin Ming <ming.m.lin@intel.com>, linux-perf-users@vger.kernel.org

[ + Lin Ming, linux-perf-users ]

On Thu, Mar 17, 2011 at 5:35 AM, Easley <ugiwgh@gmail.com> wrote:

> EventNum and UmaskValue is control bits, but I can't find which address of msr to wirte.

Try Ming Lin's kernel patch here:

http://thread.gmane.org/gmane.linux.kernel/1071064

and my patch to link the perf tool with libpfm4:

http://article.gmane.org/gmane.comp.linux.perfmon2.devel/2912

Stephane has disabled the uncore event support in libpfm4 (since the
patch is still not upstream yet). But by uncommenting 2-3 lines of
code, you should be able to get uncore events working.

 -Arun
