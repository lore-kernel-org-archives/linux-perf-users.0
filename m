Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD4C5519F
	for <linux-perf-users@archiver.kernel.org>; Sun, 22 Nov 2020 22:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDCE2075A
	for <linux-perf-users@archiver.kernel.org>; Sun, 22 Nov 2020 22:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOtWMh4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgKVW2R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgKVW2R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 22 Nov 2020 17:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606084095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vGgjQ98rEnNwFIz4NkTbIxq+X+REezZw6sjfEXZykY=;
        b=fOtWMh4VSIRjU/d2C3phMxBjxsZ1fFgeIG4F6BiJMNCAmDiIn/rPRjTuGzF187h2SM+TYH
        3Kp14wJtYGgPkVtzlSIDDMpaLDheN8ov0xFeWGYSS/sKqvRlwAIYdLHBj1kE0FSF6kiZbK
        IZEQKn8cQ0/yOlacdIHPLSfM2E641mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-vT74-xYoNHW2arx7eUulRQ-1; Sun, 22 Nov 2020 17:28:01 -0500
X-MC-Unique: vT74-xYoNHW2arx7eUulRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65381005D75;
        Sun, 22 Nov 2020 22:27:59 +0000 (UTC)
Received: from host1.jankratochvil.net (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 919545C1C4;
        Sun, 22 Nov 2020 22:27:54 +0000 (UTC)
Date:   Sun, 22 Nov 2020 23:27:51 +0100
From:   Jan Kratochvil <jan.kratochvil@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        John Levon <levon@movementarian.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: libdw dwarf unwind issue
Message-ID: <20201122222751.GA1362915@host1.jankratochvil.net>
References: <20201103221709.GL3597846@krava>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20201103221709.GL3597846@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, 03 Nov 2020 23:17:09 +0100, Jiri Olsa wrote:
> When you compiled perf with libunwind, you get:
> 
>   $ make VF=1
>   $ perf report -i perf.data --stdio
> 
>   # Children      Self  Trace output
>   # ........  ........  ..............
>   #
>      100.00%   100.00%  (5640789cdf50)
>               |
>               |--98.85%--0x7fc8eca0f554
>               |          main
>               |          main_loop_wait
>               |          qemu_poll_ns
>               |
>                --1.15%--0x7fc8ecdc2ea4
>                          iothread_run
>                          aio_poll
>                          qemu_poll_ns
> 
> 
> When you compile perf with libdw, you get:
> 
>   $ make VF=1 NO_LIBUNWIND=1
>   $ perf report -i perf.data --stdio
> 
>   # Children      Self  Trace output
>   # ........  ........  ..............
>   #
>      100.00%   100.00%  (5640789cdf50)
>               |
>               |--98.85%--0x45260879
>               |          qemu_poll_ns
>               |
>                --1.15%--qemu_poll_ns

I get after the attached fix:

# Children      Self  Trace output  
# ........  ........  ..............
#
   100.00%   100.00%  (5640789cdf50)
            |          
            |--98.85%--main
            |          main_loop_wait
            |          qemu_poll_ns
            |          
             --1.15%--iothread_run
                       aio_poll
                       qemu_poll_ns


> any idea why libdw is doing that? ;-)

Because libdw was reporting separate debuginfo file as the main file:

(lldb) p thread->process->dwfl->modulelist->main.name
(char *) $1 = 0x0000000000b52490 "/home/jkratoch/.debug/.build-id/fc/d0111443729957fa8ef9511ff5dc3e9a5ccf9d/debug"
(lldb) p thread->process->dwfl->modulelist->debug.name
(char *) $2 = 0x0000000000000000

The correct way is to report the main ELF file as the main file:

(lldb) p thread->process->dwfl->modulelist->main.name
(char *) $1 = 0x0000000000b52490 "/home/jkratoch/.debug/.build-id/fc/d0111443729957fa8ef9511ff5dc3e9a5ccf9d/elf"
(lldb) p thread->process->dwfl->modulelist->debug.name
(char *) $2 = 0x0000000000000000

In some cases it may later fill-in even the ->debug.name with "/debug" filename.


Jan Kratochvil

--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="libdw-unwind.patch"

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 7a3dbc259cec..5d66cafccde5 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -20,10 +20,28 @@
 
 static char *debuginfo_path;
 
+static int __find_debuginfo(Dwfl_Module *mod __maybe_unused, void **userdata,
+			    const char *modname __maybe_unused, Dwarf_Addr base __maybe_unused,
+			    const char *file_name __maybe_unused,
+			    const char *debuglink_file __maybe_unused,
+			    GElf_Word debuglink_crc __maybe_unused, char **debuginfo_file_name)
+{
+	const struct dso *dso = *userdata;
+	char filename[PATH_MAX];
+
+	assert(dso);
+
+	// We could also use dso->symsrc_filename but it may not be set yet.
+	if (dso__build_id_filename(dso, filename, sizeof(filename), true))
+		*debuginfo_file_name = strdup(filename);
+	return -1;
+}
+
 static const Dwfl_Callbacks offline_callbacks = {
-	.find_debuginfo		= dwfl_standard_find_debuginfo,
+	.find_debuginfo		= __find_debuginfo,
 	.debuginfo_path		= &debuginfo_path,
 	.section_address	= dwfl_offline_section_address,
+	// .find_elf is not set as we use dwfl_report_elf() instead.
 };
 
 static int __report_module(struct addr_location *al, u64 ip,
@@ -46,16 +64,21 @@ static int __report_module(struct addr_location *al, u64 ip,
 	mod = dwfl_addrmodule(ui->dwfl, ip);
 	if (mod) {
 		Dwarf_Addr s;
+		void **userdatap;
 
-		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
+		dwfl_module_info(mod, &userdatap, &s, NULL, NULL, NULL, NULL, NULL);
+		*userdatap = dso;
 		if (s != al->map->start - al->map->pgoff)
 			mod = 0;
 	}
 
-	if (!mod)
-		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
-				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name), -1, al->map->start - al->map->pgoff,
-				      false);
+	if (!mod) {
+		char filename[PATH_MAX];
+
+		if (dso__build_id_filename(dso, filename, sizeof(filename), false))
+			mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
+					      al->map->start - al->map->pgoff, false);
+	}
 
 	return mod && dwfl_addrmodule(ui->dwfl, ip) == mod ? 0 : -1;
 }

--NDin8bjvE/0mNLFQ--

