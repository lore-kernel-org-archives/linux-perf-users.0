From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH v2] perf tool: fix endianness handling of u32 data in
 samples
Date: Fri, 2 Sep 2011 15:18:19 -0300
Message-ID: <20110902181818.GD17970@ghostprotocols.net>
References: <1314979426-29356-1-git-send-email-dsahern@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65351 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab1IBSS1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 2 Sep 2011 14:18:27 -0400
Content-Disposition: inline
In-Reply-To: <1314979426-29356-1-git-send-email-dsahern@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, anton@samba.org

Em Fri, Sep 02, 2011 at 10:03:46AM -0600, David Ahern escreveu:
>  	if (type & PERF_SAMPLE_RAW) {
> -		u32 *p = (u32 *)array;
> +		u.val64 = *array;
> +		if (swapped) {
> +			static bool show_warn = true;
> +
> +			/* undo swap of u64, then swap on individual u32s */
> +			u.val64 = bswap_64(u.val64);
> +			u.val32[0] = bswap_32(u.val32[0]);
> +			u.val32[1] = bswap_32(u.val32[1]);
> +
> +			if (show_warn) {
> +				pr_warning("Endianness of raw data not corrected!\n");
> +				show_warn = false;
> +			}
> +		}

Can you use WARN_ONCE? Would become:
	
		if (WARN_ONCE(swapped, "Endianness of raw data not corrected!\n")) {
			/* undo swap of u64, then swap on individual u32s */
			u.val64 = bswap_64(u.val64);
			u.val32[0] = bswap_32(u.val32[0]);
			u.val32[1] = bswap_32(u.val32[1]);
		}

We have that and its the usual idiom in the kernel proper :-)

See tools/perf/util/include/asm/bug.h and net/can/af_can.c can_rcv for
an example.

Thanks,

- Arnaldo
