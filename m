From: Guru Prasad <gurupras@buffalo.edu>
Subject: Re: How to monitor sampling over time with Perf
Date: Sun, 28 Apr 2013 08:47:51 -0400
Message-ID: <CAMefCkC9qkw+Gf11m4ODGq0hofL2qHLxB_KbnMfs--F9xuKB_w@mail.gmail.com>
References: <loom.20130428T132842-381@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:64284 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122Ab3D1Mrv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 28 Apr 2013 08:47:51 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so930161pdi.21
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Apr 2013 05:47:51 -0700 (PDT)
In-Reply-To: <loom.20130428T132842-381@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Donitta <sabra_gr@yahoo.fr>
Cc: linux-perf-users@vger.kernel.org

I don't think this functionality is available in perf..I could be wrong..
I think you would have to add a small piece of code in perf stat to
achieve this..
Follow the execution from cmd_stat until run_perf_stat(I think..)

I will try to answer your question better once I go back to my lab..I
don't have access to the kernel sources currently..



On Sun, Apr 28, 2013 at 8:01 AM, Donitta <sabra_gr@yahoo.fr> wrote:
> Hi,
> I would like to monitor perf results over time. For example, I would like to
> have all the occurrences of an event and their timestamp of occurrence.
> How can I have those infos? I read somewhere in the documentation that perf
> script command provides timestamps for each occurrence, but when I tried this
> command I didn't understand it's output, and there is no documentation.
> Could someone plead provide me examples on how to use perf utilities to answer
> my needs?
>
> Many thnaks
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
