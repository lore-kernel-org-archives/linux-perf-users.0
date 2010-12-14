From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH v3] perf tools: Add symfs option for off-box analysis
 using specified tree
Date: Tue, 14 Dec 2010 10:24:28 -0200
Message-ID: <20101214122428.GA13425@ghostprotocols.net>
References: <1291926427-28846-1-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57284 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab0LNMYe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Dec 2010 07:24:34 -0500
Content-Disposition: inline
In-Reply-To: <1291926427-28846-1-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Thu, Dec 09, 2010 at 01:27:07PM -0700, David Ahern escreveu:
> The symfs argument allows analysis of perf.data file using a locally
> accessible filesystem tree with debug symbols - e.g., tree created
> during image builds, sshfs mount, loop mounted KVM disk images,
> USB keys, initrds, etc. Anything with an OS tree can be analyzed from
> anywhere without the need to populate a local data store with
> build-ids.
> 
> Signed-off-by: David Ahern <daahern@cisco.com>
> 
> v2 --> v3: handle symfs="/"

> @@ -2312,6 +2332,13 @@ int symbol__init(void)
>  		       symbol_conf.sym_list_str, "symbol") < 0)
>  		goto out_free_comm_list;
>  
> +	/* a path to symbols of "/" is identical to "" 
> +	 * reset here for simplicity.
> +	 */
> +	if ((symbol_conf.symfs[0] == '/') &&
> +	    (symbol_conf.symfs[1] == '\0'))
> +		symbol_conf.symfs = "";
> +
>  	symbol_conf.initialized = true;
>  	return 0;
>  

Call me a nitpicker:

[acme@felicio ~]$ cat realpath.c 
#include <limits.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	char *resolved = realpath(argv[1], NULL);

	puts(resolved);
}
[acme@felicio ~]$ make realpath
cc     realpath.c   -o realpath
[acme@felicio ~]$ ./realpath //
/
[acme@felicio ~]$ ./realpath ////////////////
/
[acme@felicio ~]$ ./realpath /./././
/
[acme@felicio ~]$ ./realpath /..//.
/
[acme@felicio ~]$

I'll fix this up and merge, thanks!

- Arnaldo
