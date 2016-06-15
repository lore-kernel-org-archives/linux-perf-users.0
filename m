From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: cross compiling perf
Date: Wed, 15 Jun 2016 10:47:06 -0500
Message-ID: <20160615154706.CC0A43F246@usa-sjc-imap-foss1.foss.arm.com>
References: <16135005.c00Xa53Rc9@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38501 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932698AbcFOPrH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jun 2016 11:47:07 -0400
In-Reply-To: <16135005.c00Xa53Rc9@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, 15 Jun 2016 16:24:52 +0200
Milian Wolff <milian.wolff@kdab.com> wrote:

> I'm trying to compile a more modern version of the user-space perf tools for 
> an arm64 embedded target. So far, no cigar.
...
> config/Makefile:272: *** No gnu/libc-version.h found, please install glibc-
> dev[el].  Stop

fwiw, I've had marginally greater success in the past by perfoming an
arm64-cross 'make defconfig; make -C tools/perf clean perf' before
switching to building fully-featured perfs natively.

Kim
