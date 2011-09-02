From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2] perf tool: fix endianness handling of u32 data in
 samples
Date: Fri, 02 Sep 2011 14:08:24 -0600
Message-ID: <4E6137B8.1040402@gmail.com>
References: <1314979426-29356-1-git-send-email-dsahern@gmail.com> <20110902181818.GD17970@ghostprotocols.net> <4E612A9E.5000807@gmail.com> <20110902200147.GF17970@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38511 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1IBUI3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 2 Sep 2011 16:08:29 -0400
In-Reply-To: <20110902200147.GF17970@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, anton@samba.org



On 09/02/2011 02:01 PM, Arnaldo Carvalho de Melo wrote:
> Look again:
> 
> #define WARN_ONCE(condition, format...) ({                      \
>         static bool __warned;                                   \
>         int __ret_warn_once = !!(condition);                    \
>                                                                 \
>         if (unlikely(__ret_warn_once))                          \
>                 if (WARN(!__warned, format))                    \
>                         __warned = true;                        \
>         unlikely(__ret_warn_once);                              \
> }) 
> 
> 
> See that ({ }) construct? It evaluates to what is in its last statement,
> which is...
> 
> 	unlikely(__ret_warn_once);
> 
> Forget about the unlikely, __ret_warn_once is:
> 
> 	!!condition
> 
> I.e. it always evaluates to what is passed as condition, so in fact it
> could be seen as:
> 
>              if (swapped) {
>                      /* undo swap of u64, then swap on individual
>                      u32s */
>                      u.val64 = bswap_64(u.val64);
>                      u.val32[0] = bswap_32(u.val32[0]);
>                      u.val32[1] = bswap_32(u.val32[1]);
>              }
> 
> The rest is the boilerplate needed to warn the user the first time
> condition is true.
> 
> - Arnaldo

Ok, I get it now.

David
