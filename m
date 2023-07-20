Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF8EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGTNuE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGTNuD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 09:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF326B3;
        Thu, 20 Jul 2023 06:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D54761ADA;
        Thu, 20 Jul 2023 13:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84835C433C8;
        Thu, 20 Jul 2023 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689860999;
        bh=nEFwg6fbISW6I5JdM4+Aiiv7SRb3ZillJUpOlDVgGy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmWGzH+vbToIUE5yzzMCmBnwZe2Q/PRiqmc6oxcALqYG1XxrP3UebqY6d92GChnjH
         mW08ScEd1/wI74wDdsb4TcKBmb4Uebu1dpL9nZmVDlYFrEjUDit2BSoRdg4dg4qJ76
         uzUcYfzlApacO48te1v54vig8b1gsZtRlYHVvNMZyaiSv7ERy3lQ95JZ+S1/Sv7tNV
         ckG7f4XAzcj5jkW6vcWDVCOl30xb3MzM4rUhtJC1syQCiDZE3K24j1NOVtnFKbtv4P
         xEn2/HzhLaPd38cmZMzxc03uawgefGI6jyLoiUhpmHx3wwEfp7gO3qnRbMwJEqhHB9
         OpxfxRvfxca2Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D155240516; Thu, 20 Jul 2023 10:49:56 -0300 (-03)
Date:   Thu, 20 Jul 2023 10:49:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/6] perf thread: Allow tools to register a thread->priv
 destructor
Message-ID: <ZLk7hOvDsliOboEH@kernel.org>
References: <20230719202951.534582-1-acme@kernel.org>
 <20230719202951.534582-3-acme@kernel.org>
 <CAP-5=fV3Er=Ek8=iE=bSGbEBmM56_PJffMWot1g_5Bh8B5hO7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV3Er=Ek8=iE=bSGbEBmM56_PJffMWot1g_5Bh8B5hO7A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 19, 2023 at 03:31:41PM -0700, Ian Rogers escreveu:
> On Wed, Jul 19, 2023 at 1:30 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > So that when thread__delete() runs it can be called and free stuff tools
> > stashed into thread->priv, like 'perf trace' does and will use this
> > new facility to plug some leaks.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/thread.c | 11 +++++++++++
> >  tools/perf/util/thread.h |  2 ++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > index 0b166404c5c365cf..35dd4e716e411da9 100644
> > --- a/tools/perf/util/thread.c
> > +++ b/tools/perf/util/thread.c
> > @@ -80,6 +80,13 @@ struct thread *thread__new(pid_t pid, pid_t tid)
> >         return NULL;
> >  }
> >
> > +static void (*thread__priv_destructor)(void *priv);
> > +
> > +void thread__set_priv_destructor(void (*destructor)(void *priv))
> > +{
> 
> Perhaps:
> assert(thread__priv_destructor == NULL);

I'll add that.
 
> To make it clear that there should never be >1 currently.
> 
> > +       thread__priv_destructor = destructor;
> > +}
> > +
> >  void thread__delete(struct thread *thread)
> >  {
> >         struct namespaces *namespaces, *tmp_namespaces;
> > @@ -112,6 +119,10 @@ void thread__delete(struct thread *thread)
> >         exit_rwsem(thread__namespaces_lock(thread));
> >         exit_rwsem(thread__comm_lock(thread));
> >         thread__free_stitch_list(thread);
> > +
> > +       if (thread__priv_destructor)
> > +               thread__priv_destructor(thread__priv(thread));
> > +
> >         RC_CHK_FREE(thread);
> >  }
> >
> > diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> > index 9068a21ce0fa1b0f..e79225a0ea46b789 100644
> > --- a/tools/perf/util/thread.h
> > +++ b/tools/perf/util/thread.h
> > @@ -71,6 +71,8 @@ struct thread *thread__new(pid_t pid, pid_t tid);
> >  int thread__init_maps(struct thread *thread, struct machine *machine);
> >  void thread__delete(struct thread *thread);
> >
> > +void thread__set_priv_destructor(void (*destructor)(void *priv));
> > +
> >  struct thread *thread__get(struct thread *thread);
> >  void thread__put(struct thread *thread);
> >
> > --
> > 2.41.0
> >

-- 

- Arnaldo
