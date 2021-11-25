Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C8BC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Nov 2021 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhKYVoB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 16:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235878AbhKYVmA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Nov 2021 16:42:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C385060E98;
        Thu, 25 Nov 2021 21:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637876329;
        bh=auWWidTUNtArwtfT9R8nJx470uMai1FoJWv1Km49Rmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3funUInWs+y0XIpunPSjO+UvJgwSjjxrhVcSakEmLwtujzKR8xQToMg5wfIF9EL0
         jKmY7q7hqWejllkyJaIW9O3HOX3YqSPOgF3EKKnCSTo23/dRLvfqqVWJgg+0tLqot0
         1F7JEPXmneKck7zAaGpkWvlDDVQbW68q5aOuiMD/i7untLvayHHimXQ7iE1WiAdeMD
         fguTLDYJhkwdyk7JgFzaNLl6MeSHba8G+fn/ZkA/4LQMqvIFw4kt/hK0dhkY87LrMg
         /Vo10DgcBsDivuLQSjnWVjF8Jl97CFwribFQjmVeRT/LCXtqiHoEOFdBm4XuS3jLoZ
         x+edhq8ghII4g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88B3C40002; Thu, 25 Nov 2021 18:38:46 -0300 (-03)
Date:   Thu, 25 Nov 2021 18:38:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     irogers@google.com, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf_counter tools: Fix memory leaks of add_cmdname()
Message-ID: <YaACZsT6pupginXC@kernel.org>
References: <20211119084637.178890-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119084637.178890-1-sohaib.amhmd@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Nov 19, 2021 at 10:46:36AM +0200, Sohaib Mohamed escreveu:
> ASan reports some memory leaks when running:
> 
> $ perf xyz
> 
> This patch adds the missing clean_cmdnames()
> 
> Fixes: 078006012401 ("perf_counter tools: add in basic glue from Git")
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
>  tools/lib/subcmd/help.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index bf02d62a3b2b..4a433f4d19a1 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -187,6 +187,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
>  
>  		add_cmdname(cmds, de->d_name + prefix_len, entlen);
>  	}
> +	clean_cmdnames(cmds);

Have you tested this?

Look at this usage:

void load_command_list(const char *prefix,
                struct cmdnames *main_cmds,
                struct cmdnames *other_cmds)
{
        const char *env_path = getenv("PATH");
        char *exec_path = get_argv_exec_path();

        if (exec_path) {
                list_commands_in_dir(main_cmds, exec_path, prefix);
                qsort(main_cmds->names, main_cmds->cnt,
                      sizeof(*main_cmds->names), cmdname_compare);
                uniq(main_cmds);
        }


If you call clean_cmdnames() in list_commands_in_dir() that call to
qsort will be with main_cmds emptied, no?

- Arnaldo


>  	closedir(dir);
>  	free(buf);
>  }
> -- 
> 2.25.1

-- 

- Arnaldo
