From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf tool: fix endianness handling of u32 data in samples
Date: Fri, 2 Sep 2011 17:02:55 -0300
Message-ID: <20110902200255.GG17970@ghostprotocols.net>
References: <1314992511-1235-1-git-send-email-dsahern@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314992511-1235-1-git-send-email-dsahern@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, anton@samba.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Sep 02, 2011 at 01:41:51PM -0600, David Ahern escreveu:
> @@ -423,18 +449,25 @@ int perf_event__parse_sample(const union perf_event *event, u64 type,
>  	}
>  
>  	if (type & PERF_SAMPLE_RAW) {
> -		u32 *p = (u32 *)array;
> +		u.val64 = *array;
> +		if (swapped) {
> +			/* undo swap of u64, then swap on individual u32s */
> +			u.val64 = bswap_64(u.val64);
> +			u.val32[0] = bswap_32(u.val32[0]);
> +			u.val32[1] = bswap_32(u.val32[1]);
> +
> +			WARN_ONCE(swapped, "Endianness of raw data not corrected!\n");
> +		}

That works too, but then we'll be always testing swapped two times :-)

- Arnaldo
