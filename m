Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E817C6FD1D
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 10:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCQK5y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Mar 2023 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCQK5t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Mar 2023 06:57:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6AE91AE
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 03:57:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id iw3so4895001plb.6
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679050662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rFPd3VuqvE+nV0qASh7ejPCqIICCfENYOm20TTJbVg=;
        b=ecaLmzBaDA9Ic3qvSF+8dzA73mQcRPO25KEey0qlXzC/l5d6Yq5G8UXdRncHxFLm9Y
         Ezc3C07QvIGQ0eoIO1C5m0EMwXOGrbno927Q1P/itIr0OsZXtB0DmbP1gce3aexzADjS
         LELTF8X540luGaMa1cYI+epJGB/2SuYp21caqCVD2Sid0PxXeAMmXA93fbCQ5lixTRXj
         lQs3YeSi4I/gO8J1SI8bYSxP0DVdNV+yge/vNa/PbTV5GKNPvQ79Wup4bRuxNR9a17yI
         eiHINfhIEB9gLaCq/auqFoQE9LrdKKXW3PTfUU58m2HR5jgMfRHulNLpRj25+i5A4P1u
         EvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679050662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rFPd3VuqvE+nV0qASh7ejPCqIICCfENYOm20TTJbVg=;
        b=AjdIbNMFGSkp2e6G8X3+IdPanmHX8JTfA3tgvvYj0uuen1ZG4+a5qoQ+Ax4e3xpnwB
         FqlS70bs8qiZ/7irjOmgwCM+A8LO+IK2kPDHDb2W3Gv+XfRa9OAK4zQV5gI6QxmCRhD+
         Uj4j3tzIjfYlQo66NGcYHjSrBUYHirN6QStME1MUasAxi4g45GYjKfmjNDTlF/2EQuWR
         H6mvkAssXnRGe7FkR9m1LX/kQ16Ynu0b7Cq3yBoqkRpOwEY6SOzQHb5Dbjla2oNqNWA+
         SgVi9W/A+hE+6bEPcyLakbyHH2nejyUMW3JHl+PwgIsP7VqLV01LdVfUB9QITX9zQo3H
         5wkQ==
X-Gm-Message-State: AO0yUKWcHDPlqA8JnQRdlgqhnPQbXcrIU1/fdyiMd45ckQ1Xtl5pxjja
        NO8q0LJEGD/SZdBsLyebLZ0=
X-Google-Smtp-Source: AK7set+KglzLGhbiUFdbU/13wmWLFaKLGbXxLd3VxtoQIKmp8vapVVhR8yePFnUtk4XVr2PxexlyjA==
X-Received: by 2002:a17:90b:1808:b0:23e:2b3c:d4a7 with SMTP id lw8-20020a17090b180800b0023e2b3cd4a7mr7671233pjb.35.1679050662401;
        Fri, 17 Mar 2023 03:57:42 -0700 (PDT)
Received: from yoga ([2400:1f00:13:9b5e:6556:7e3f:618e:d8d8])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090ae01500b0023f3fc5d162sm1958834pjy.25.2023.03.17.03.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:57:42 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Fri, 17 Mar 2023 16:27:36 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org, irogers+gsoc22@google.com,
        anupnewsmail@gmail.com
Subject: Re: [RFC] Open Source Contribution | GSoC Perf
Message-ID: <ZBRHoIuv2g6RTdAx@yoga>
References: <ZAZVazubl60xYaO8@yoga>
 <CAP-5=fVT3vh8j8FVAdr2Zp2bTpCxdLGW4Gkndb6-mmNdRcW7ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVT3vh8j8FVAdr2Zp2bTpCxdLGW4Gkndb6-mmNdRcW7ug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 07, 2023 at 10:57:23AM -0800, Ian Rogers wrote:
> On Mon, Mar 6, 2023 at 1:04 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > Hello, Perf!
> > I'm interested in joining the perf community and learning more about how to start contributing because of my desire to learn more about the Linux kernel and performance.
> > I've only recently started using Perf Tool, but I'm really enjoying seeing the metrics and outcomes. I want to resolve a few inconsistencies I found on a wiki page while learning, so if you have any suggestions, please let me know.
> > 1. LINK BROKEN under Tutorial-> Linux Sourcecode: /tools/perf (hyperlink: ) correct (
> > 2. LINK BROKEN under Hardware Reference -> Performance Counters for Linux: hyperlink for PCL core kernel data structures, PCL core kernel internals, perf tool internals are not available. Can anyone help me to know why this contents are not available on wiki?
> > 3. ALLIGNMENT : Under Glossary -> BPF counter, Off-CPU, Multiplexing is not alliged properly.
> > 4. INFO MISSING: Under Glossary -> offcore is TODO.
> >
> > I've also invested some time going though Brendan Gregg conference talk and wiki page,  I'd be delighted to contribute to any of the open tasks!
> > Thank you all for your time.
> 
> Thanks Anup!
> 
> Updating the wiki is great! I was looking at your changes, I'd
> encourage linux-perf-users to checkout updates at:
> https://perf.wiki.kernel.org/index.php/Special:RecentChanges
> 
> I wanted to give some feedback on just one of the changes:
> https://perf.wiki.kernel.org/index.php?title=Tutorial&curid=22&diff=3921&oldid=3520
> The maintainer's source tree is at:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/
> which gets integrated into the main Linus tree at:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> I think it would be better to use these rather than which given the
> version number in the URL looks quite out-of-date compared to Linux
> 6.2:
> http://lxr.linux.no/linux+v2.6.39/tools/perf/
>
Done. 
> Thanks,
> Ian
> 
> > With regards,
> > Anup Sharma
