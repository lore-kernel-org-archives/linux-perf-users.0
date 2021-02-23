Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC22C433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Feb 2021 19:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEBB64D8F
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Feb 2021 19:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhBWTuw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhBWTuk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Feb 2021 14:50:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F24E64E61;
        Tue, 23 Feb 2021 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614109799;
        bh=Y9yiADDLxCdr+AWE6GCO9O3RAgyjDWFSFO78+Y9y0/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0wcjRWMS7WC2xDgddO1pJx7eZFk5O9XBG/q9dsqJ1+BYX0BirOegu9/AGoU2w3uL
         t+Z26hj4IxYmzpcIHzgIMO1mLQSY2QchS/ZoecPuDklTTJ652FEZV1MubJjtwwn3eY
         387SY16/inBy2kXxXE7hNMZUQt2lJzExL9ihxfhKMgPqAqX6LwAStV4L2M7aHx6uzk
         Gw9QGFQZt49R0iz9DHISoAjfq9CWB96c0BjKZbymJ+QEbRl+gpJTX+nLfiDBv7fQIK
         41eHnNXOrBRksJZxvEsOMHidqkyP1TD5Inj/bXyqxjexNRyAxR4Rowbkz3a1mmNY0s
         hQmwr9jcHaEkQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0408840CD9; Tue, 23 Feb 2021 16:49:56 -0300 (-03)
Date:   Tue, 23 Feb 2021 16:49:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: add --demangle and --demangle-kernel
Message-ID: <YDVcZJscuKIgShsm@kernel.org>
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Feb 22, 2021 at 09:29:22AM +0100, Martin Liška escreveu:
> Perf annotate supports --symbol but it's impossible to filter
> a C++ symbol. With --no-demangle one can filter easily by
> mangled function name.
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/Documentation/perf-annotate.txt | 7 +++++++
>  tools/perf/builtin-annotate.c              | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index 1b5042f134a8..80c1be5d566c 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -124,6 +124,13 @@ OPTIONS
>  --group::
>  	Show event group information together
> +--demangle::
> +	Demangle symbol names to human readable form. It's enabled by default,
> +	disable with --no-demangle.
> +
> +--demangle-kernel::
> +	Demangle kernel symbol names to human readable form (for C++ kernels).
> +
>  --percent-type::
>  	Set annotation percent type from following choices:
>  	  global-period, local-period, global-hits, local-hits
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index a23ba6bb99b6..ef70a17b9b5b 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -538,6 +538,10 @@ int cmd_annotate(int argc, const char **argv)
>  		    "Strip first N entries of source file path name in programs (with --prefix)"),
>  	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
>  		   "objdump binary to use for disassembly and annotations"),
> +	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
> +		    "Disable symbol demangling"),

Nope, this _enables_ demangling, i.e.:

	perf annotate --demangle

Asks for symbol demangling, while:

	perf annotate --no-demangle

As you correctly wrote in your commit message and on the
--demangle-kernel case, enables demangling.

Please consider making this configurable (if not already) via
~/.perfconfig, 'perf config', sure in a followup patch.

Thanks,

- Arnaldo

> +	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> +		    "Enable kernel symbol demangling"),
>  	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
>  		    "Show event group information together"),
>  	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
> -- 
> 2.30.1
> 

-- 

- Arnaldo
