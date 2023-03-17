Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC17C7618B
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 11:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCQLIu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Mar 2023 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCQLIt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Mar 2023 07:08:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A24528E8A
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 04:08:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so4830254pjz.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679051324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wzedcWyNu+UR4qq4Y48m6hZh3wdB5okVKhGkRX9RKHg=;
        b=H4dGbMk3CZGITkwQXGIBhIU0aFIqNK6yTf3cJLNWCE1Y6WP/TAky8hjDNPdXzgwPbS
         qAdeHS/nRptrSfOs01qOMytzyI2B5wC4NHVUeZEUL0ZULbXp8QNq9P/GcsuojGdfnPLF
         p6Pg8TQ8kJVUpTUIfIBha0g4X/UQ8W9vzmoi/O0wu13mRvIAEnYPnI18COR+28PdBoi/
         mV443ZckGrDUM+io2ELdMvHl9Hh5fjVaAtbKwDDGKHotTwypZIy+O6fU59TrUSlVSbok
         9ZlGVCo6zo+pb8DWr0eTFNL2rUNeL/mssFSHjducVPyVJMiL823sKtifXOgIJGUskPRl
         s2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679051324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzedcWyNu+UR4qq4Y48m6hZh3wdB5okVKhGkRX9RKHg=;
        b=DuCXeTV5gAwikSOCj/YV6usdtjMkmqqiujL4my4nQA09FmMyZ6SQKyibL8A1t648WX
         DMNdDYx6VZin2IvlUvEIy+cdh5IlXMsutLGudLe2LMNZvcJQ4Rc8rWvcBYaT7M+Bodn5
         6vhjEOxzu8+81Vefruu5Ls60z+6LUH5msrO2JLRtdJ73jG86oDPVZVqZDnKEzNfjir5E
         Sc595357mDzw/mglPdE6t2M9tSW3znPVBso6NvX14RVxpqpZaHCt2ig30ZP2EjwitWpu
         zVaxy6qnEni56ub6yOOwlTrXVgv3dtWu8mbOeRiAZZOXlAF4PAD3dlhvXNo/wORHWF6q
         BnzQ==
X-Gm-Message-State: AO0yUKVq+lsfPN/vRmV5FQBKO4fzX30bfPEagVb2zCLCRfL5TP0w3NF/
        7jWLbwk2MRtgPo2bzfoVMSk=
X-Google-Smtp-Source: AK7set/xtwALEH6WjGesxu7jPxQIwih44BpnFU7pHe4crvNdjf1F0KC49xQe9yzI1hM/LziI6WRHGQ==
X-Received: by 2002:a17:902:c40c:b0:19e:e172:2a40 with SMTP id k12-20020a170902c40c00b0019ee1722a40mr8603469plk.65.1679051323863;
        Fri, 17 Mar 2023 04:08:43 -0700 (PDT)
Received: from yoga ([2400:1f00:13:9b5e:6556:7e3f:618e:d8d8])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902848c00b00198f256a192sm1304195plo.171.2023.03.17.04.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:08:40 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Fri, 17 Mar 2023 16:38:32 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org, irogers+gsoc22@google.com,
        anupnewsmail@gmail.com
Subject: Re: [RFC] Open Source Contribution | GSoC Perf
Message-ID: <ZBRKMMqn0bM/Kr2v@yoga>
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
> Thanks,
> Ian
> 
> > With regards,
> > Anup Sharma
Hello all, I have added a tutorial on Flame Graph and Firefox profiler at:
https://perf.wiki.kernel.org/index.php/Tutorial
Section 3.3 and 3.4.
Can someone please review and provide feedback regarding the same?

Also, I was a bit confused about where to add these tutorials, I have added them to section 3. 
