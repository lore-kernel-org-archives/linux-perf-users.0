Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08BDC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Nov 2022 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKUQxM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Nov 2022 11:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiKUQxL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Nov 2022 11:53:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5BBEAF8
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Nov 2022 08:53:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b12so6965347wrn.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Nov 2022 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XSlNOu09gIpBtxVxT1c0KO71t0ZODsn5RpuG42ogge0=;
        b=VV8stsDo3VwgsUMQnraoyVo9OOAsRND2fxh0w9uHN1L/wPyuv/CepMh29qp51Ehvha
         dtvGluiQB3PthvZo49RjMNlpp92sd8qlsyLmPzisovKprxPCqZWpTf9bCF+f5IvJxT8N
         TlUK8Vckw3RZUjsaSV5ph2BMOqnlXn9vhpFMPeOk7nY4EdKa/dRFYQLOHMHwBJazHWjT
         ujA6SvMSG117DhdwBK6662ygykOVYGDTwqLunrUojEBRHq5zqM8EnlUZqQ6ptAxlYMjP
         S6aMgYvPoMRUd/vhbjU67K9x3X0GM333X+mZbhKEdANNK6OgXjumRUQUbCagAZ/kHeck
         pC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSlNOu09gIpBtxVxT1c0KO71t0ZODsn5RpuG42ogge0=;
        b=ECvymTWqxuUYVK4wosr1z2N3Tgkpni+HAIBhXCl0J82fECvo35UTb5JWwI8SRNkHxg
         1Cm3hhvLuyN0trvg6MZ9Ui7z3dlZvNgvuTxV89/eZB5oO1xyZZhYDpZCSA40KwvZ1ZFX
         q5tuwEszxgSVVIFyslnV3Z5Ri/aEWdt49kpLJgp/cTxKo5s5D65Eo63TjTeMSVeltkTh
         MZjqFfal/c3fpYFlkJEkcLSinW7CZ4BKlYF+af+rDNz8sFKaFTu8Egm/Je6q62tKhr8Y
         eb/EJeV9cGPkMUoC9qTXwdRWona3cRZwCFeqV4pZUKIeKkujRCwwC4RwC27RtCF9prJu
         0EgA==
X-Gm-Message-State: ANoB5pmIjnthHpq6pHyQD6zNDyakGeRUs8vzvbLdFV9edIAV54zlYds0
        l9xugF8VWY8n9cLU5KC19uBTa8WPApj1UPP0K6IqOA==
X-Google-Smtp-Source: AA0mqf6kBBHgfvWnm61GjWbsASI39pORKm7i63/vxUjC62I7A3XYA92tLsjDF3xLQpzNkbn6NH0bkgd/kb9LoMj7olk=
X-Received: by 2002:a5d:6747:0:b0:22e:34ee:c67d with SMTP id
 l7-20020a5d6747000000b0022e34eec67dmr1093186wrw.300.1669049587112; Mon, 21
 Nov 2022 08:53:07 -0800 (PST)
MIME-Version: 1.0
References: <1668762999-9297-1-git-send-email-yangtiezhu@loongson.cn>
 <CAP-5=fXR58DQFkUW81KUs_f9cLTX=L28H1hkxXVzX3dUdRLBjw@mail.gmail.com> <ab41b1fe-4a59-2a6b-ee9f-785c98c48df5@loongson.cn>
In-Reply-To: <ab41b1fe-4a59-2a6b-ee9f-785c98c48df5@loongson.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Nov 2022 08:52:47 -0800
Message-ID: <CAP-5=fWtFktYKch+4Sv4zSHoW8SO96yEsyQgDKApyR20UjXhSA@mail.gmail.com>
Subject: Re: [PATCH] tools: perf: Use "grep -E" instead of "egrep"
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Nov 20, 2022 at 6:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 11/20/2022 02:17 AM, Ian Rogers wrote:
> > On Fri, Nov 18, 2022 at 1:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >>
> >> The latest version of grep claims the egrep is now obsolete so the build
> >> now contains warnings that look like:
> >>         egrep: warning: egrep is obsolescent; using grep -E
> >> fix this up by moving the related file to use "grep -E" instead.
> >>
> >>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/perf`
> >>
> >> Here are the steps to install the latest grep:
> >>
> >>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
> >>   tar xf grep-3.8.tar.gz
> >>   cd grep-3.8 && ./configure && make
> >>   sudo make install
> >>   export PATH=/usr/local/bin:$PATH
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >
> > Hi Tiezhu,
> >
> > installing a newer grep tool in order to build/test perf is somewhat
> > burdensome, as such I don't think we should merge this change. Looking
> > at my Debian derived distro. I have grep 3.7, so I'd need to do this.
> > I imagine the majority of people are using a grep earlier than 3.8. I
> > agree there is a problem perhaps we can:
> >  - rewrite to just need grep and not egrep;
> >  - rewrite in a stable language with regex support, perhaps python;
> >  - have a grep/egrep wrapper that selects based on version number.
> >
>
> Hi Ian,
>
> I found this issue on Linux From Scratch system which uses grep 3.8 [0],
> we can see the following NEWS in grep-3.8 release announcement [1]:
>
> "The egrep and fgrep commands, which have been deprecated since
>   release 2.5.3 (2007), now warn that they are obsolescent and should
>   be replaced by grep -E and grep -F."
>
> Additionally, the next grep rpm/deb version is 3.8 on Fedora [2]
> and Debian [3], so use "grep -E" instead of "egrep" so we won't see
> the warning for various versions of grep.
>
> [0] https://linuxfromscratch.org/~thomas/multilib/chapter06/grep.html
> [1] https://savannah.gnu.org/forum/forum.php?forum_id=10227
> [2] https://packages.fedoraproject.org/pkgs/grep/grep/fedora-rawhide.html
> [3] https://packages.debian.org/sid/grep
>
> Thanks,
> Tiezhu

Thanks Tiezhu,

My grep is 3.7 and has -E support. In the changelog I see:

```
2021-08-14  Jim Meyering  <meyering@fb.com>

       version 3.7
       * NEWS: Record release date.
```

So I'm guessing 3.8 is newer than is necessary for this change, but
demonstrates the warning issue your change addresses. Arnaldo's build
compatibility scripts should be able to spot further issues.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
