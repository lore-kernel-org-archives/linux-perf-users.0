Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DEC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Oct 2022 09:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJEJP6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJEJP4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 05:15:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D8696FA
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0I8erM1kSIH6VqBN/wIm31vJOIf9F1ig9lQfTRlwbNU=; b=SUM6rjC7VXQQCN068cJYbHJXoC
        PzRoKgFWu5VWXVlct3ASM0ZHHr5FZmnq8B1I6TtrZ+Hu3+ZQqc8jLu0xOOwJAAPifpks8sv4Pz6Aq
        JkhifwkP1ZrkPvKc6wHDvwcs5fvaL2/GA12/gmyov0PEw4NX3/1pNqTz4eCvfiuYskIq4TYkHQSMq
        K5MWDy3mcThehlmuf6/4F2UJW6bJiz4gdeORlwEVk5zbuN05d1ZWuytcV1BwJoySCe/0d4twttNd5
        yQtCdmk/c83qadoT0wRx+EF5kxvOt5QxPo5uzWli3R7+gRLlXbUD9+B3tZlI2C16qIeRf6TM6Rvmb
        lQZyE5jA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34592)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1og0Uq-0000Nf-RQ; Wed, 05 Oct 2022 10:15:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1og0Uh-0005FW-JQ; Wed, 05 Oct 2022 10:15:11 +0100
Date:   Wed, 5 Oct 2022 10:15:11 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     Ivan Babrou <ivan@cloudflare.com>
Subject: Fwd: Re: [External] : Removal of 128MB limit for BPF JIT programs
 broke perf symbolication on aarch64
Message-ID: <Yz1LHzS7iHJlg4ay@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

----- Forwarded message from Ivan Babrou <ivan@cloudflare.com> -----
Date: Tue, 4 Oct 2022 16:50:01 -0700
From: Ivan Babrou <ivan@cloudflare.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Subject: Re: [External] : Removal of 128MB limit for BPF JIT programs broke
	perf symbolication on aarch64

Hi Russell,

Thanks for looking closely into this. Could you send this as a bug
report to the perf mailing list? Since it seems to be a bug in perf, I
hope people there will be able to figure out how to address this
properly.

Many thanks!

On Thu, Aug 18, 2022 at 4:33 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Aug 17, 2022 at 05:46:03PM +0100, Russell King (Oracle) wrote:
> > So yes, I can reproduce the problem given exactly the right kernel
> > options, but I still don't see how it is caused by the commit you
> > claim it is. I think it's indicative of a deeper problem, one where
> > the kernel image is being placed in the vmalloc region, and /proc/kcore
> > then ends up with conflicting LOAD segments in its PHDR.
>
> It looks to be a bug in the perf tool:
>
> --- broken2     2022-08-18 12:11:29.219489345 +0100
> +++ working2    2022-08-18 12:11:06.716047129 +0100
> ...
> -replacement_map: ffffffc008000000-fffffffdf0000000 0000004008003000
> +replacement_map: ffffffd793200000-ffffffd794f20000 0000005793203000
>  New map:
>  Start            End              pgoff              start-pgoff
>  ffffff8000000000-ffffff807be00000 0000000000003000 = ffffff7fffffd000
>  ffffffa000000000-ffffffa700000000 0000002000003000 = ffffff7fffffd000
>  ffffffc000000000-ffffffc008000000 0000004000003000 = ffffff7fffffd000
> -ffffffc008000000-fffffffdf0000000 0000004008003000 = ffffff7fffffd000
> +ffffffc008000000-ffffffc0085a5890 0000004008003000 = ffffff7fffffd000
>  ffffffc0085a5890-ffffffc0085a5a60 0000000000000000 = ffffffc0085a5890
> +ffffffc0085a5a60-ffffffc0085b5b90 00000040085a8a60 = ffffff7fffffd000
>  ffffffc0085b5b90-ffffffc0085b5bf0 0000000000000000 = ffffffc0085b5b90
> +ffffffc0085b5bf0-ffffffc0085c58b0 00000040085b8bf0 = ffffff7fffffd000
>  ffffffc0085c58b0-ffffffc0085c5910 0000000000000000 = ffffffc0085c58b0
> +ffffffc0085c5910-ffffffc0086e5c64 00000040085c8910 = ffffff7fffffd000
>  ffffffc0086e5c64-ffffffc0086e5e30 0000000000000000 = ffffffc0086e5c64
> +ffffffc0086e5e30-ffffffc0086f5284 00000040086e8e30 = ffffff7fffffd000
>  ffffffc0086f5284-ffffffc0086f52e4 0000000000000000 = ffffffc0086f5284
> +ffffffc0086f52e4-ffffffc0087051c8 00000040086f82e4 = ffffff7fffffd000
>  ffffffc0087051c8-ffffffc008705228 0000000000000000 = ffffffc0087051c8
> +ffffffc008705228-ffffffc0093fdcbc 0000004008708228 = ffffff7fffffd000
>  ffffffc0093fdcbc-ffffffc0093fdd1c 0000000000000000 = ffffffc0093fdcbc
> +ffffffc0093fdd1c-ffffffc00940dc70 0000004009400d1c = ffffff7fffffd000
>  ffffffc00940dc70-ffffffc00940dcd0 0000000000000000 = ffffffc00940dc70
> +ffffffc00940dcd0-ffffffc0094257a0 0000004009410cd0 = ffffff7fffffd000
>  ffffffc0094257a0-ffffffc009425800 0000000000000000 = ffffffc0094257a0
> +ffffffc009425800-ffffffc00942f420 0000004009428800 = ffffff7fffffd000
>  ffffffc00942f420-ffffffc00942f480 0000000000000000 = ffffffc00942f420
> +ffffffc00942f480-ffffffc009435ae0 0000004009432480 = ffffff7fffffd000
>  ffffffc009435ae0-ffffffc009435d64 0000000000000000 = ffffffc009435ae0
> +ffffffc009435d64-ffffffd793200000 0000004009438d64 = ffffff7fffffd000
> +ffffffd793200000-ffffffd794f20000 0000005793203000 = ffffff7fffffd000
>
> The above is a red/black tree, which is ordered by start/end addresses.
> Overlaps are not allowed, yet we can see in the broken case that we end
> up with an overlap as this entry:
>
> -ffffffc008000000-fffffffdf0000000 0000004008003000 = ffffff7fffffd000
>
> overlaps all the following entries. This happens because the wrong entry
> is picked up from the sections in /proc/kcore, and is selected by:
>
>         /* Find the kernel map using the '_stext' symbol */
>         if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
>                 list_for_each_entry(new_map, &md.maps, node) {
> //                      if (new_map->start == 0xffffffc008000000)
> //                              continue;
>                         if (stext >= new_map->start && stext < new_map->end) {
>                                 replacement_map = new_map;
>                                 break;
>                         }
>                 }
>         }
>
> The commented out code is my hack that makes perf work, by forcing it
> to use the proper entry in /proc/kcore for the kernel.
>
> The side effect of this is that in thread__find_map(), maps__find() is
> unable to find the right map entry to use, so al->map is NULL.
> Consequently, the address can't be translated to a symbol. We can see
> this in my debug output:
>
> rmk: ffffffd793e882e4: 0x7fc81bfd96 01 lvl k maps 0x55a3149bd0 map (nil)
>
> ffffffd793e882e4 is the address being looked up. The maps being used
> were:
>
> 0x55a3bcd1f0: ffffff8000000000-ffffff807be00000 0000000000003000
> 0x55a3bcd4f0: ffffffa000000000-ffffffa700000000 0000002000003000
> 0x55a3bcd070: ffffffc000000000-ffffffc008000000 0000004000003000
> 0x55a3150000: ffffffc008000000-fffffffdf0000000 0000004008003000
> 0x55a31507c0: ffffffc0085a5890-ffffffc0085a5a60 0000000000000000
> 0x55a3150fb0: ffffffc0085b5b90-ffffffc0085b5bf0 0000000000000000
> 0x55a3151370: ffffffc0085c58b0-ffffffc0085c5910 0000000000000000
> 0x55a3151730: ffffffc0086e5c64-ffffffc0086e5e30 0000000000000000
> 0x55a3151af0: ffffffc0086f5284-ffffffc0086f52e4 0000000000000000
> 0x55a3151eb0: ffffffc0087051c8-ffffffc008705228 0000000000000000
> 0x55a3152630: ffffffc0093fdcbc-ffffffc0093fdd1c 0000000000000000
> 0x55a31529f0: ffffffc00940dc70-ffffffc00940dcd0 0000000000000000
> 0x55a3152db0: ffffffc0094257a0-ffffffc009425800 0000000000000000
> 0x55a3153170: ffffffc00942f420-ffffffc00942f480 0000000000000000
> 0x55a3152270: ffffffc009435ae0-ffffffc009435d64 0000000000000000
>
> We can see this address would fall into the 0x55a3150000 map entry,
> but we can see "map (nil)" meaning it wasn't found.
>
> I've no idea what the right fix for this is.
>
> To be honest, I'm not sure I have a full enough understanding of the
> perf tool to really grasp what it's trying to do here, so I don't
> think I can progress this to a solution.
>
> I also think that the commit you refer to as causing this is just
> exposing a bug that's been there for quite some time, and it is
> unfortunate that changing the kernel layout slightly has provoked
> it in the perf tool. I'm not sure if this is a perf tool bug or
> a kernel bug (maybe the kernel shouldn't be exposing overlapping
> LOAD sections in /proc/kcore).
>
> Adding Will in case he has any ideas.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!


----- End forwarded message -----

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
