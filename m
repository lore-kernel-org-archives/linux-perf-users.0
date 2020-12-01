Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB527C64E7B
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 19:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627A221741
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 19:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy6NbrWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgLATm5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgLATm5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Dec 2020 14:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606851690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlTwbjYswKeaozhcE+mbhp0Z+RQzWpESZvAy+1CE9rY=;
        b=Yy6NbrWyy/lm3f3wzeankvUMPFmwGzwihCR1jqjbRPuvhKHF/POXzOcKU5YylS7Qhbo/03
        51uJ57o7NC7tSlXOPUrZXwZeIT88ohpQa+/PDcBDk+1Mzu8PKdTgilpQgX4wE3+sC4aqKq
        MmP8yUGskBUCSINoU7sn28PcLnPID+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-21kWaGWNN0un4BYm392Ahw-1; Tue, 01 Dec 2020 14:41:27 -0500
X-MC-Unique: 21kWaGWNN0un4BYm392Ahw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5C471823E41;
        Tue,  1 Dec 2020 19:41:25 +0000 (UTC)
Received: from krava (unknown [10.40.193.1])
        by smtp.corp.redhat.com (Postfix) with SMTP id F08F85D9CA;
        Tue,  1 Dec 2020 19:41:17 +0000 (UTC)
Date:   Tue, 1 Dec 2020 20:41:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jan Kratochvil <jan.kratochvil@redhat.com>
Cc:     "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        John Levon <levon@movementarian.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: libdw dwarf unwind issue
Message-ID: <20201201194116.GC3169083@krava>
References: <20201103221709.GL3597846@krava>
 <20201122222751.GA1362915@host1.jankratochvil.net>
 <20201123221247.GC2003988@krava>
 <20201128040740.GA446287@host1.jankratochvil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128040740.GA446287@host1.jankratochvil.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Nov 28, 2020 at 05:07:40AM +0100, Jan Kratochvil wrote:
> On Mon, 23 Nov 2020 23:12:47 +0100, Jiri Olsa wrote:
> > it fixes the issue for me, but it breaks the dwarf test:
> > 
> > 72: DWARF unwind                                                    : FAILED!
> > [jolsa@krava perf]$ sudo ./perf test dwarf -v
> > 72: DWARF unwind                                                    :
> > --- start ---
> > test child forked, pid 2084484
> > unwind: failed with 'No such file or directory'
> > got wrong number of stack entries 0 != 8
> > test child finished with -1
> > ---- end ----
> > DWARF unwind: FAILED!
> 
> The previous patch required ~/.debug/ build-id symlink, fixed.
> 
> I hope dso->symsrc_filename is always already set if a separate debug info is
> present.

it should be the one with .symtab section

the fix is working for me, would you mind send full patch?
or just provide me with changelog and I can do it for you

thanks,
jirka

> 
> 
> Jan

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index 7a3dbc259cec..400e4832b50e 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -20,10 +20,25 @@
>  
>  static char *debuginfo_path;
>  
> +static int __find_debuginfo(Dwfl_Module *mod __maybe_unused, void **userdata,
> +			    const char *modname __maybe_unused, Dwarf_Addr base __maybe_unused,
> +			    const char *file_name __maybe_unused,
> +			    const char *debuglink_file __maybe_unused,
> +			    GElf_Word debuglink_crc __maybe_unused, char **debuginfo_file_name)
> +{
> +	const struct dso *dso = *userdata;
> +
> +	assert(dso);
> +	if (dso->symsrc_filename)
> +		*debuginfo_file_name = strdup(dso->symsrc_filename);
> +	return -1;
> +}
> +
>  static const Dwfl_Callbacks offline_callbacks = {
> -	.find_debuginfo		= dwfl_standard_find_debuginfo,
> +	.find_debuginfo		= __find_debuginfo,
>  	.debuginfo_path		= &debuginfo_path,
>  	.section_address	= dwfl_offline_section_address,
> +	// .find_elf is not set as we use dwfl_report_elf() instead.
>  };
>  
>  static int __report_module(struct addr_location *al, u64 ip,
> @@ -46,16 +61,24 @@ static int __report_module(struct addr_location *al, u64 ip,
>  	mod = dwfl_addrmodule(ui->dwfl, ip);
>  	if (mod) {
>  		Dwarf_Addr s;
> +		void **userdatap;
>  
> -		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
> +		dwfl_module_info(mod, &userdatap, &s, NULL, NULL, NULL, NULL, NULL);
> +		*userdatap = dso;
>  		if (s != al->map->start - al->map->pgoff)
>  			mod = 0;
>  	}
>  
>  	if (!mod)
> -		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
> -				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name), -1, al->map->start - al->map->pgoff,
> -				      false);
> +		mod = dwfl_report_elf(ui->dwfl, dso->short_name, dso->long_name, -1,
> +				      al->map->start - al->map->pgoff, false);
> +	if (!mod) {
> +		char filename[PATH_MAX];
> +
> +		if (dso__build_id_filename(dso, filename, sizeof(filename), false))
> +			mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
> +					      al->map->start - al->map->pgoff, false);
> +	}
>  
>  	return mod && dwfl_addrmodule(ui->dwfl, ip) == mod ? 0 : -1;
>  }

