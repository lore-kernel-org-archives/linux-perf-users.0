From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] [perf] Add inverted call graph report support.
Date: Thu, 9 Jun 2011 12:33:00 -0700
Message-ID: <20110609193300.GA16858@dev1756.snc6.facebook.com>
References: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Liao <phyomh@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jun 09, 2011 at 02:44:19PM +0800, Sam Liao wrote:
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -247,9 +247,14 @@ int perf_session__resolve_callchain(struct
> perf_session *self,
>  	callchain_cursor_reset(&self->callchain_cursor);
> 
>  	for (i = 0; i < chain->nr; i++) {
> -		u64 ip = chain->ips[i];
> +		u64 ip;
>  		struct addr_location al;
> 
> +		if (callchain_param.order == ORDER_CALLEE)
> +			ip = chain->ips[i];
> +		else
> +			ip = chain->ips[chain->nr - i - 1];

This can dereference a bad pointer if chain->nr == 0.

 -Arun
