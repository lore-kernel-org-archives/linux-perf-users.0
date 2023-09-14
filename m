Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A9EEDE99C
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 09:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbjINJhH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjINJhD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 05:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC351FC9
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694684171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nNYvHIG7IGNCIXd11P0Y/QmqfZ5yhvF9JG5R/wmnoKU=;
        b=SlwgmRgvkPlVFq2P8nZQmldJMhM3ODtyiJ9syhbTpDciv3e3/z+D0jYqSP2K1jstLrToiz
        YV8APd4fY+GENQXOr2Ds2Deuw1hxLdT1WMM6931/9AKjP3h25PeIMUOyKe0eISd0QnMCeL
        FNofLdJonvo6CYskeIpbe0S1mdMObbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-DnC1pLfJPey3AdO-L1jsbw-1; Thu, 14 Sep 2023 05:36:08 -0400
X-MC-Unique: DnC1pLfJPey3AdO-L1jsbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9498102F231;
        Thu, 14 Sep 2023 09:36:07 +0000 (UTC)
Received: from Diego (unknown [10.39.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3488540C6EC0;
        Thu, 14 Sep 2023 09:36:05 +0000 (UTC)
Date:   Thu, 14 Sep 2023 11:36:03 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Ian Rogers <irogers@google.com>
cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        ravi.bangoria@amd.com, peterz@infradead.org, namhyung@kernel.org,
        sandipan.das@amd.com
Subject: Re: [PATCH] perf/x86/amd/core: Rename branch-brs event to not break
 the parser
In-Reply-To: <CAP-5=fU5aofaXOtR=5JU2BocrjZVDRkm9uSqe_fyjOeoQRmQYQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2309141135360.3810@Diego>
References: <20230912133318.18103-1-mpetlan@redhat.com> <CAP-5=fU5aofaXOtR=5JU2BocrjZVDRkm9uSqe_fyjOeoQRmQYQ@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463784192-1452184166-1694684167=:3810"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463784192-1452184166-1694684167=:3810
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 Sep 2023, Ian Rogers wrote:
> On Tue, Sep 12, 2023 at 6:35 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > The problem is described in detail in 146edff3d7ed ("perf test: Parse
> > events workaround for dash/minus"). In short, although perf-list offers
> > "branch-brs" event to be used, when used with "-e" switch, the parser
> > does not accept it and needs to be enclosed to "cpu//", such as:
> >
> > ```
> >   $ perf stat -e branch-brs true
> >   event syntax error: 'branch-brs'
> >                              \___ parser error
> >
> >   $ perf stat -e cpu/branch-brs/ true
> >
> >    Performance counter stats for 'true':
> >
> >               46,179      cpu/branch-brs/
> > ```
> >
> > This is confusing for the users.
> >
> > Rename the event using underscore instead of dash to avoid the problem.
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> I rewrote the event parsing and this was fixed in 70c90e4a6b2f ("perf
> parse-events: Avoid scanning PMUs before parsing"):
> https://lore.kernel.org/r/20230502223851.2234828-19-irogers@google.com
> which was included in the perf tool in Linux 6.5.
> 
> Thanks,
> Ian

OK, great to know, thanks!
Michael

> 
> > ---
> >  arch/x86/events/amd/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > index abadd5f23425..f4c5d4100035 100644
> > --- a/arch/x86/events/amd/core.c
> > +++ b/arch/x86/events/amd/core.c
> > @@ -1286,21 +1286,21 @@ amd_branches_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> >  }
> >
> >  static struct attribute_group group_caps_amd_branches = {
> >         .name  = "caps",
> >         .attrs = amd_pmu_branches_attrs,
> >         .is_visible = amd_branches_is_visible,
> >  };
> >
> >  #ifdef CONFIG_PERF_EVENTS_AMD_BRS
> >
> > -EVENT_ATTR_STR(branch-brs, amd_branch_brs,
> > +EVENT_ATTR_STR(branch_brs, amd_branch_brs,
> >                "event=" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
> >
> >  static struct attribute *amd_brs_events_attrs[] = {
> >         EVENT_PTR(amd_branch_brs),
> >         NULL,
> >  };
> >
> >  static umode_t
> >  amd_brs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> >  {
> > --
> > 2.18.4
> >
> 
> 
---1463784192-1452184166-1694684167=:3810--

