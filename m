Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8177AC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Mar 2022 20:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351035AbiC3UlB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiC3UlA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Mar 2022 16:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40CC33E81
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Mar 2022 13:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A376E61657
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Mar 2022 20:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C26C340F0;
        Wed, 30 Mar 2022 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648672750;
        bh=GvgkAN/1qdPffZAsGGSJTxabrlSqHHk57irtvh0NmoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJMY0yKQyY/LDccY9bsTxfGJ6hrGCn4pCBZM1dulu4Mm0IVFQNhSeX1CM5i2K2gSd
         4dgJeZEwMfTfb/JphhDWafjnqb1CxnYjVdmwODaihpcCC0MR3959n3Dr3dB1MAqbgO
         RL7MT/uWVRSwdd7VYrQbr1vBPSvPANxjEK6FagON3EmiWQxxO4wAqV3HPIAMVd1KAR
         QhRv+OwdC5u1LybMmHMkh7hYHvLCZsG48ILKOBAN55XPe0/w+kjvixdT+eaJKuopFb
         SI335YHwRimobceKSP9z9dAElM/Woh20N+QXm9YNDCAFXJoedQ//xVZxCbd3IfgHbg
         kFcRYZ32Pcc2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BE8F40407; Wed, 30 Mar 2022 17:39:07 -0300 (-03)
Date:   Wed, 30 Mar 2022 17:39:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tanu M <tanu235m@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH] perf tools/perf/python/tracepoint.py: Converted to
 Python3
Message-ID: <YkS/6xjPDa/JevcQ@kernel.org>
References: <CAPS78prawYzRZnyhWjgOnGw4EwoswNwztvfZFdCOPOydFzVwzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPS78prawYzRZnyhWjgOnGw4EwoswNwztvfZFdCOPOydFzVwzQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Mar 27, 2022 at 11:08:46PM -0700, Tanu M escreveu:
> Hi,
> I have converted the tracepoint.py file to python3 as many of the
> files in tools/perf are already written in python3.
> 
> Signed-off-by: Tanusree Debnath <tanu235m@gmail.com>

Got this:

⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/python/tracepoint.py
patch: **** malformed patch at line 119: prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (

⬢[acme@toolbox perf]$

I'll apply it by hand, please check your e-mail client.

- Arnaldo
 
> ---
>  tools/perf/python/tracepoint.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
> index 461848c7f..6a63e6c41 100755
> --- a/tools/perf/python/tracepoint.py
> +++ b/tools/perf/python/tracepoint.py
> @@ -34,7 +34,7 @@ def main():
>              if not isinstance(event, perf.sample_event):
>                  continue
> 
> -            print "time %u prev_comm=%s prev_pid=%d prev_prio=%d
> prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
> +            print ("time %u prev_comm=%s prev_pid=%d prev_prio=%d
> prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
>                     event.sample_time,
>                     event.prev_comm,
>                     event.prev_pid,
> @@ -42,7 +42,7 @@ def main():
>                     event.prev_state,
>                     event.next_comm,
>                     event.next_pid,
> -                   event.next_prio)
> +                   event.next_prio))
> 
>  if __name__ == '__main__':
>      main()
> -- 
> 2.25.1

-- 

- Arnaldo
