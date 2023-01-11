Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF252C46467
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Jan 2023 13:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjAKNhf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Jan 2023 08:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjAKNhM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Jan 2023 08:37:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F51271A3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jan 2023 05:34:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so36852703ejc.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jan 2023 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o45xHQnVgspU6XvnJ3AMZ15/AgQtkXf4T7ENucAlV6s=;
        b=RR5aWt2bWbCV9Wya8mJg7N3PwRrwbI2yhhjbj5jSC2RKC3VQAPxCwdtj/VZix0pWHH
         J/SapoFo0cx2m06267tGE0eXAMGvH9PzaYh3d0wG0hVnmxJT5O4pXewY1euaPoin91L3
         5gRnuGtIUMGhnMGRbQ8wtf0RgYdTVinv+3SnjKfchDApR6Fuc+utXuKB/hY89xy38Ilm
         uq7C2HhPgHEh0LguplJeeGRU+wqDEZt9vtXu1DS+B/ZXlfmRDvvMIw8O+EVIj+PNkSCj
         tCgxOPY6EshzHVaJx/wwVN7nJZcYXg4bH3zt56/OSJqMEUj+BN14FEBV+tgFWALzRu5Q
         afHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o45xHQnVgspU6XvnJ3AMZ15/AgQtkXf4T7ENucAlV6s=;
        b=Zd61zlcyXQ98SE3mBXZ4hWl2BRD4o7vTBI6DF/nqGB86y23KgTAebcQcsAKV0vmYwa
         rN/SJCSxeA9aqhbLvTyEpuXQWHEQCa9GjtlANLAlkN7p9adPUFdr3tucVOo67+tGO8n6
         1UugPfnf4su6x+1d3zNWf+W4x7kJ8BVRS6qd18S2MG1bXxPGYNX6mP5eJLgxH52f/Pya
         vTtw4PYlHqC6GLD8l077JoNgTDb9YYZZnYVcW0ZS43R+hCKcV1v9V33pSjaosZQ+US7Z
         +ToiXG91R0ASMmJTI3zPzK+f6K+Z0enHop/p+QT0euFsk8Wa1TaMPbzWDC7LWeAdf9cP
         lGLA==
X-Gm-Message-State: AFqh2kooKKz2LKp3QXZ8FWVFjwLrvBXueM8FUIkvXopubL2zViQs8dA3
        E00F8Jcuctr55tfxG5/fMiQ=
X-Google-Smtp-Source: AMrXdXtxoAK1uKck1HNQX/JjEs/7hBuHXtRpDJdlSHWJ85NNKK6X1fC8NtvvK2cbs6ETk4td8WaurA==
X-Received: by 2002:a17:907:900b:b0:84d:4e4e:2c7b with SMTP id ay11-20020a170907900b00b0084d4e4e2c7bmr7243870ejc.30.1673444073146;
        Wed, 11 Jan 2023 05:34:33 -0800 (PST)
Received: from ddolgov.remote.csb (dslb-178-012-041-046.178.012.pools.vodafone-ip.de. [178.12.41.46])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906304e00b0077077c62cadsm6197836ejd.31.2023.01.11.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:34:32 -0800 (PST)
Date:   Wed, 11 Jan 2023 14:34:31 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, mingo@redhat.com,
        jolsa@kernel.org, irogers@google.com
Subject: Re: [RFC PATCH v1] perf record: Correct address filters for
 duplicated symbols
Message-ID: <20230111133431.54nvuauogkndmhnt@ddolgov.remote.csb>
References: <20230106203751.403270-1-9erthalion6@gmail.com>
 <aad6782c-fb30-ba39-ba59-775c5f227d56@intel.com>
 <20230110104848.hty4upem76lkxj2y@ddolgov.remote.csb>
 <Y7625DUhEE+NUfWh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7625DUhEE+NUfWh@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> On Wed, Jan 11, 2023 at 10:17:24AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 10, 2023 at 11:48:48AM +0100, Dmitry Dolgov escreveu:
> > > On Mon, Jan 09, 2023 at 09:02:02AM +0200, Adrian Hunter wrote:
> > > On 6/01/23 22:37, Dmitrii Dolgov wrote:
> > > > It seems the logic to handle duplicated symbols is off. In case if the
> > > > symbol index is specified it will:
> > > >
> > > > * find a match
> > > > * continue searching
> > > > * check that start is not null and idx is set on the next loop
> > > > * exit with the error code 1
> > > >
> > > > My guess is the expectation was that at this point the second match is
> > > > found (because *start is not null), although the new symbol hasn't pass
> > > > dso_sym_match yet. Here is how it looks like:
> > >
> > > If *start && idx > 0 there is no need to match anymore.  The
> > > code is just getting *size.  Looks to me like it should be:
> > >
> > > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > > index 265d20cc126b..c2e323cd7d49 100644
> > > --- a/tools/perf/util/auxtrace.c
> > > +++ b/tools/perf/util/auxtrace.c
> > > @@ -2611,7 +2611,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
> > >  				*size = sym->start - *start;
> > >  			if (idx > 0) {
> > >  				if (*size)
> > > -					return 1;
> > > +					return 0;
> > >  			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
> > >  				print_duplicate_syms(dso, sym_name);
> > >  				return -EINVAL;
> >
> > Yes, if there was no intention to continue searching symbols, this would
> > work as well. Just in case I have verified this on my test, everything
> > is fine. Would you send a patch for that?
>
> So I'll take this as a:
>
> Tested-by: Dmitry Dolgov <9erthalion6@gmail.com>
>
> Ok?

Sure, forgot about this. Thanks!
