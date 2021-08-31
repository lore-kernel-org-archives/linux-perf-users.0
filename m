Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC50C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383AC6109D
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhHaSTr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhHaSTr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 14:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50A1561051;
        Tue, 31 Aug 2021 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630433931;
        bh=upH5fn3/2RfHwb3owpyOsuOtoolBxyBXlb0f0vLL52k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAj3u/ABIj3WJE2+o0o6GUTUxQE18yvI7yfgJZZjGsm9ixInR0BZX0ysTvJVPer7T
         yysPf6V6F3LdqjizlxCWDrrlxgeovl20wD+yGKtPZgvirM97ne6OBR+FUwte6TuMKz
         +Mkmvu1cEUTgypPXaRPiI1nfPKTK1RDplVpcGDsBZ+PPwjwZwmTGW6RhE1NApCnsD4
         L7WT6aP7T1hobZh/cImetR19Ha7TxShWR73DGMC3sn7zOlk9dvcos3k7J42x2U/KrY
         pAUNqB1dLHkeHcDCeQXhEZhL5z9MV+lk9r/dEATyHA15GYo5cQaGPZKQkaSWIOO3DY
         VHKKiKN6oSeyg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1EE1A4007E; Tue, 31 Aug 2021 15:18:48 -0300 (-03)
Date:   Tue, 31 Aug 2021 15:18:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/3] perf tools: Refactor LLVM test warning for missing
 binary
Message-ID: <YS5yiJPuCH+9CLV3@kernel.org>
References: <20210831145501.2135754-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831145501.2135754-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 31, 2021 at 03:54:59PM +0100, James Clark escreveu:
> The same warning is duplicated in two places so refactor it into a
> single function "search_program_and_warn". This will be used a third
> time in a later commit.

Thanks, applied the three patches.

- Arnaldo

 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/llvm-utils.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index cbd9b268f168..cec9c16efb17 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -38,6 +38,8 @@ struct llvm_param llvm_param = {
>  	.user_set_param = false,
>  };
>  
> +static void version_notice(void);
> +
>  int perf_llvm_config(const char *var, const char *value)
>  {
>  	if (!strstarts(var, "llvm."))
> @@ -108,6 +110,21 @@ search_program(const char *def, const char *name,
>  	return ret;
>  }
>  
> +static int search_program_and_warn(const char *def, const char *name,
> +				   char *output)
> +{
> +	int ret = search_program(def, name, output);
> +
> +	if (ret) {
> +		pr_err("ERROR:\tunable to find %s.\n"
> +		       "Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
> +		       "     \tand '%s-path' option in [llvm] section of ~/.perfconfig.\n",
> +		       name, name);
> +		version_notice();
> +	}
> +	return ret;
> +}
> +
>  #define READ_SIZE	4096
>  static int
>  read_from_pipe(const char *cmd, void **p_buf, size_t *p_read_sz)
> @@ -458,16 +475,10 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
>  	if (!template)
>  		template = CLANG_BPF_CMD_DEFAULT_TEMPLATE;
>  
> -	err = search_program(llvm_param.clang_path,
> +	err = search_program_and_warn(llvm_param.clang_path,
>  			     "clang", clang_path);
> -	if (err) {
> -		pr_err(
> -"ERROR:\tunable to find clang.\n"
> -"Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
> -"     \tand 'clang-path' option in [llvm] section of ~/.perfconfig.\n");
> -		version_notice();
> +	if (err)
>  		return -ENOENT;
> -	}
>  
>  	/*
>  	 * This is an optional work. Even it fail we can continue our
> @@ -495,14 +506,9 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
>  	force_set_env("WORKING_DIR", kbuild_dir ? : ".");
>  
>  	if (opts) {
> -		err = search_program(llvm_param.llc_path, "llc", llc_path);
> -		if (err) {
> -			pr_err("ERROR:\tunable to find llc.\n"
> -			       "Hint:\tTry to install latest clang/llvm to support BPF. Check your $PATH\n"
> -			       "     \tand 'llc-path' option in [llvm] section of ~/.perfconfig.\n");
> -			version_notice();
> +		err = search_program_and_warn(llvm_param.llc_path, "llc", llc_path);
> +		if (err)
>  			goto errout;
> -		}
>  
>  		err = -ENOMEM;
>  		if (asprintf(&pipe_template, "%s -emit-llvm | %s -march=bpf %s -filetype=obj -o -",
> -- 
> 2.28.0

-- 

- Arnaldo
