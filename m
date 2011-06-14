From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] [perf] fix annotation loading when symbol sort order not
 used.
Date: Tue, 14 Jun 2011 15:03:04 -0700
Message-ID: <20110614220304.GA17101@dev1756.snc6.facebook.com>
References: <BANLkTinXzHiCTb6EWWGSJmzz5dS1P9p1sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail007.snc4.facebook.com ([66.220.144.139]:60388 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751905Ab1FNWDF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Jun 2011 18:03:05 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinXzHiCTb6EWWGSJmzz5dS1P9p1sg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sam Liao <phyomh@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 12, 2011 at 02:09:40AM +0800, Sam Liao wrote:
> When "symbol" is not in "-s" sort order options, the hist entry's
> ms.sym is not equal to sample's addr_location.sym where we should
> not load annotation. This fix check if symbol sort order used, if
> not, disable symbol annonation for report command in tui mode.

Thanks for taking care of this. Works well for me.

 -Arun
