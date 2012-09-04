From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] perf: allow user to indicate path to objdump in command
 line
Date: Tue, 04 Sep 2012 10:05:31 -0600
Message-ID: <504626CB.60601@gmail.com>
References: <1346754750.16299.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34254 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2IDQGK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Sep 2012 12:06:10 -0400
In-Reply-To: <1346754750.16299.3.camel@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Maciek Borzecki <maciek.borzecki@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

On 9/4/12 4:32 AM, Maciek Borzecki wrote:
> When analyzing perf data from hosts of other architecture than one of the local
> host it's useful to call objdump that is part of a toolchain for that
> architecture. Instead of calling regular objdump, call one that user specified
> in command line.

Why not set the PATH to make the toolchain's version the one used by perf?

David
