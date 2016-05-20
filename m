From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Getting PEBS to work
Date: Thu, 19 May 2016 20:47:00 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1605192045590.18235@macbook-air>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com> <CAPAnC4NObR7Fe-fZr9z5tdD0cyyVhd6WojN-aWst2Z2rtxQ6SQ@mail.gmail.com> <CAE40pdehnoK4yO-050=0cfbw8viegNmiXKUZYxw8nMXgi6TGzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:32887 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbcETArI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 20:47:08 -0400
Received: by mail-io0-f178.google.com with SMTP id t40so36723311ioi.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2016 17:47:08 -0700 (PDT)
In-Reply-To: <CAE40pdehnoK4yO-050=0cfbw8viegNmiXKUZYxw8nMXgi6TGzg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: jim mauro <jim.mauro@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Thu, 19 May 2016, Brendan Gregg wrote:

> On Thu, May 19, 2016 at 5:09 PM, jim mauro <jim.mauro@gmail.com> wrote:
>
> Nor did r01c0. But pretty interesting you got PEBS output, and on
> Linux 3.8. So maybe my 3.13 isn't the problem...

does your dmesg say anything?  If I recall there are sandybridge machines 
with PEBS disabled due to errata.  Usually you need to update your 
CPU firmware to get it working.

Vince
