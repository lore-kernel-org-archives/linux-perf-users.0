From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf report: Allow user to specify path to kallsyms file
Date: Wed, 8 Dec 2010 18:35:57 -0200
Message-ID: <20101208203557.GC10353@ghostprotocols.net>
References: <1291775986-16475-1-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42109 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab0LHUgH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 8 Dec 2010 15:36:07 -0500
Content-Disposition: inline
In-Reply-To: <1291775986-16475-1-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Tue, Dec 07, 2010 at 07:39:46PM -0700, David Ahern escreveu:
> This is useful for analyzing a perf data file on a different system
> than the one data was collected on and still include symbols from
> loaded kernel modules in the output.

Applied and also added the relevant entry to
tools/perf/Documentation/perf-report.txt, please do that next time you
add some new command line option.

- Arnaldo
