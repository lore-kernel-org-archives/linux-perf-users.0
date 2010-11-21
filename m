From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf symbols: reuse of name in dso__load when starting
 second pass
Date: Sun, 21 Nov 2010 20:03:37 -0200
Message-ID: <20101121220337.GB4056@ghostprotocols.net>
References: <1290351830-4398-1-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65225 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab0KUWDm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 21 Nov 2010 17:03:42 -0500
Received: by gxk23 with SMTP id 23so3708970gxk.19
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Nov 2010 14:03:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290351830-4398-1-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org

Em Sun, Nov 21, 2010 at 08:03:50AM -0700, David Ahern escreveu:
> continue statement in default case applies when a second pass is
> wanted as well. As it stands the code drops down to the open
> re-using the value in name from the previous origin attempt.
> 
> Signed-off-by: David Ahern <daahern@cisco.com>
> ---
>  tools/perf/util/symbol.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index d30136e..861be8b 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1488,8 +1488,8 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
>  			if (want_symtab) {
>  				want_symtab = 0;
>  				self->origin = DSO__ORIG_BUILD_ID_CACHE;
> -			} else
> -				continue;
> +			}
> +			continue;
>  		}

But we want to restart at DSO__ORIG_BUILD_ID_CACHE, right? If you do
your change we keep a existing mistake and will instead restart at
DSO__ORIG_BUILD_ID_CACHE + 1, please take a look to validate my
understanding that we need to set self->origin to
DSO__ORIG_BUILD_ID_CACHE - 1.

- Arnaldo
