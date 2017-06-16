From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf report: report module before querying
 isactivation in dwfl unwind
Date: Fri, 16 Jun 2017 13:06:52 -0300
Message-ID: <20170616160652.GC3645@kernel.org>
References: <20170602143753.16907-1-milian.wolff@kdab.com>
 <20170602143753.16907-2-milian.wolff@kdab.com>
 <20170602152508.GC7901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdFPQHB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2017 12:07:01 -0400
Content-Disposition: inline
In-Reply-To: <20170602152508.GC7901@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Jan Kratochvil <jan.kratochvil@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>

Em Fri, Jun 02, 2017 at 12:25:08PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jun 02, 2017 at 04:37:53PM +0200, Milian Wolff escreveu:
> > The PC returned by dwfl_frame_pc may map into a not-yet-reported
> > module. We have to report it before we continue unwinding. But when
> > we query for the isactivation flag in dwfl_frame_pc, libdw will
> > actually do one more unwinding step internally which can then break
> > and lead to missed frames or broken stacks.
> > 
> > With libunwind we get e.g.:
> 
> Jiri, can you review this one?

ping
 
> Thanks,
> 
> - Arnaldo
>  
> > ~~~~~
> > heaptrack_gui  2228 135073.400474:     613969 cycles:
> > 	          108c8e [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1093bc [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          109e7b QLocale::QLocale (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1470ff [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          147f67 QSystemLocale::query (/usr/lib/libQt5Core.so.5.8.0)
> > 	          109fbf QLocalePrivate::updateSystemPrivate (/usr/lib/libQt5Core.so.5.8.0)
> > 	          10aa27 QLocale::QLocale (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1e02c3 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          2113bb [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          211505 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1b5df0 QFileInfo::exists (/usr/lib/libQt5Core.so.5.8.0)
> > 	           92eb2 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	           93423 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	           93d2a QLibraryInfo::location (/usr/lib/libQt5Core.so.5.8.0)
> > 	          2170af [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          297c53 QCoreApplicationPrivate::init (/usr/lib/libQt5Core.so.5.8.0)
> > 	           f7cde QGuiApplicationPrivate::init (/usr/lib/libQt5Gui.so.5.8.0)
> > 	          1589e8 QApplicationPrivate::init (/usr/lib/libQt5Widgets.so.5.8.0)
> > 	           78622 main (/home/milian/projects/compiled/other/bin/heaptrack_gui)
> > 	           20439 __libc_start_main (/usr/lib/libc-2.25.so)
> > 	           78299 _start (/home/milian/projects/compiled/other/bin/heaptrack_gui)
> > 
> > heaptrack_gui  2228 135073.401156:     569521 cycles:
> > 	          131633 QString::endsWith (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1a0701 QDir::cleanPath (/usr/lib/libQt5Core.so.5.8.0)
> > 	          21b82d [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1b3727 QFileInfo::canonicalFilePath (/usr/lib/libQt5Core.so.5.8.0)
> > 	          2780c7 QFactoryLoader::update (/usr/lib/libQt5Core.so.5.8.0)
> > 	          279525 QFactoryLoader::QFactoryLoader (/usr/lib/libQt5Core.so.5.8.0)
> > 	           e5bd0 QPlatformIntegrationFactory::create (/usr/lib/libQt5Gui.so.5.8.0)
> > 	           f5a1c QGuiApplicationPrivate::createPlatformIntegration (/usr/lib/libQt5Gui.so.5.8.0)
> > 	           f650c QGuiApplicationPrivate::createEventDispatcher (/usr/lib/libQt5Gui.so.5.8.0)
> > 	          298524 QCoreApplicationPrivate::init (/usr/lib/libQt5Core.so.5.8.0)
> > 	           f7cde QGuiApplicationPrivate::init (/usr/lib/libQt5Gui.so.5.8.0)
> > 	          1589e8 QApplicationPrivate::init (/usr/lib/libQt5Widgets.so.5.8.0)
> > 	           78622 main (/home/milian/projects/compiled/other/bin/heaptrack_gui)
> > 	           20439 __libc_start_main (/usr/lib/libc-2.25.so)
> > 	           78299 _start (/home/milian/projects/compiled/other/bin/heaptrack_gui)
> > ~~~~~
> > 
> > Note the two frames 1589e8 and 78622 in the first sample. These are
> > missing when unwinding with libdw. The second sample's breakage is
> > more obvious:
> > 
> > ~~~~~
> > heaptrack_gui  2228 135073.400474:     613969 cycles:
> > 	          108c8e [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1093bc [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          109e7b QLocale::QLocale (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1470ff [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          147f67 QSystemLocale::query (/usr/lib/libQt5Core.so.5.8.0)
> > 	          109fbf QLocalePrivate::updateSystemPrivate (/usr/lib/libQt5Core.so.5.8.0)
> > 	          10aa27 QLocale::QLocale (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1e02c3 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          2113bb [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          211505 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1b5df0 QFileInfo::exists (/usr/lib/libQt5Core.so.5.8.0)
> > 	           92eb2 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	           93423 [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	           93d2a QLibraryInfo::location (/usr/lib/libQt5Core.so.5.8.0)
> > 	          2170af [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          297c53 QCoreApplicationPrivate::init (/usr/lib/libQt5Core.so.5.8.0)
> > 	           f7cde QGuiApplicationPrivate::init (/usr/lib/libQt5Gui.so.5.8.0)
> > 	           20439 __libc_start_main (/usr/lib/libc-2.25.so)
> > 	           78299 _start (/home/milian/projects/compiled/other/bin/heaptrack_gui)
> > 
> > heaptrack_gui  2228 135073.401156:     569521 cycles:
> > 	          131633 QString::endsWith (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1a0701 QDir::cleanPath (/usr/lib/libQt5Core.so.5.8.0)
> > 	          21b82d [unknown] (/usr/lib/libQt5Core.so.5.8.0)
> > 	          1b3727 QFileInfo::canonicalFilePath (/usr/lib/libQt5Core.so.5.8.0)
> > 	          2780c7 QFactoryLoader::update (/usr/lib/libQt5Core.so.5.8.0)
> > 	          279525 QFactoryLoader::QFactoryLoader (/usr/lib/libQt5Core.so.5.8.0)
> > 	           e5bd0 QPlatformIntegrationFactory::create (/usr/lib/libQt5Gui.so.5.8.0)
> > 	          723dbf [unknown] ([unknown])
> > ~~~~~
> > 
> > This patch fixes this issue and the libdw unwinder mimicks the
> > libunwind behavior more closely.
> > 
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > ---
> >  tools/perf/util/unwind-libdw.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> > index da45c4be5fb3..7755a5e0fe5e 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -178,6 +178,14 @@ frame_callback(Dwfl_Frame *state, void *arg)
> >  	Dwarf_Addr pc;
> >  	bool isactivation;
> >  
> > +	if (!dwfl_frame_pc(state, &pc, NULL)) {
> > +		pr_err("%s", dwfl_errmsg(-1));
> > +		return DWARF_CB_ABORT;
> > +	}
> > +
> > +	// report the module before we query for isactivation
> > +	report_module(pc, ui);
> > +
> >  	if (!dwfl_frame_pc(state, &pc, &isactivation)) {
> >  		pr_err("%s", dwfl_errmsg(-1));
> >  		return DWARF_CB_ABORT;
> > -- 
> > 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
