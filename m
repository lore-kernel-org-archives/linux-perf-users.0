From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Can perf compare two perf.data files?
Date: Mon, 4 Nov 2013 16:34:17 +0100
Message-ID: <20131104153417.GD2805@krava.brq.redhat.com>
References: <10173985.aGnRNdx3u3@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab3KDPed (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Nov 2013 10:34:33 -0500
Content-Disposition: inline
In-Reply-To: <10173985.aGnRNdx3u3@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org

On Mon, Nov 04, 2013 at 04:17:58PM +0100, Milian Wolff wrote:
> Hello there!
> 
> Is there some command for perf which I haven't found so far, that enables me 
> to compare two perf.data files?

hi,
try 'perf diff'

jirka
