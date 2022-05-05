Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D8CC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 May 2022 16:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382290AbiEERB0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 May 2022 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382320AbiEERBM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 May 2022 13:01:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD27580CB
        for <linux-perf-users@vger.kernel.org>; Thu,  5 May 2022 09:57:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso2843550wmq.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 May 2022 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XidVeKBHGzZe8lAWUDNvVDYu2ZwSVWJPYZLEy8oD9Vg=;
        b=JLX22T9WkexuIYg9Lit5jQo37Y91y1waoE/Oo8Dpdld6GNEJvhj6XzCW3k8zrUzP0K
         FXYugdmnwvovmfL/MoU009SEnTQUqAY2IL5XniYmxROns1PZWwmXCs9bq8Wydq7SZ4Ks
         IFO/2oxH2DXISfpbAkbk6BCdNfQ7JFZTPuq9s2U7Vy+oj+QbfpJWxncEyw63ThY8Tae0
         HvVumtOVvBtcpR+NwlHPJMoVXPQRVaTVbkegxiewocdcTiTXtnCmyj+xI/EcpyX7wAWW
         QKJvMBX7q3MaxbijB9ixtNkPOp1BfNmtIe/nnZ+dJWLoEzQTtZdx+h2c0g/FNA691zzG
         XzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XidVeKBHGzZe8lAWUDNvVDYu2ZwSVWJPYZLEy8oD9Vg=;
        b=Lb6zYfpvlft/hqreOuN3vJjr70E/XGIQzs78w1g0Of0/vQciXRXIkjLJgTmKdeqRcd
         iSnMxnxHsvUXFeF5S2zfQr5lq8mkVtym7MWp0y0pdf5E9ND2pLBE0/al/GEzs3mHg+EM
         Vl3XccYNRCGwcjHZc4wB5hHfJEZM5Lv9YDoN9OqmNWg7t/2bByqJRJvnW+aFM3V4X4J+
         TZcGe+3cyDHUzkdU41pwnt4iL5rU2uS6p0kmdUFsJdtqm4DgRNys46Eb0zIRwwP++wrx
         gT05rr7ZjtJ3YooQ5wW/0dlBGN8KBgOC+2zwgxZxC/XfnvXd9WJwlEUfr/2rSsMMY73e
         tEVg==
X-Gm-Message-State: AOAM531Qevn+dBSHb4jtc/kU+MRTMSjKiRBKQORBwxFOWr/hj0B8ZLKn
        z1/ASGYlYnH9rW+wJAMMC7esCSHF1/bTrRyx5JhyRwzM6d5v2Q==
X-Google-Smtp-Source: ABdhPJwqbGxJt468QrTIOA2A7Q3hDRwNHnlW3+AyXAoyItVHUhW+gSBlCqma91tWjm/OogSxsdbp0cyVqdUqIbEb4F8=
X-Received: by 2002:a05:600c:27c6:b0:394:783:2077 with SMTP id
 l6-20020a05600c27c600b0039407832077mr5960410wmb.182.1651769848167; Thu, 05
 May 2022 09:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com>
 <CAPS78pqVdNLWD1bAm6ds7D==+sOaL4amLYZ4wiQgT79zC5xprg@mail.gmail.com>
In-Reply-To: <CAPS78pqVdNLWD1bAm6ds7D==+sOaL4amLYZ4wiQgT79zC5xprg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 09:57:14 -0700
Message-ID: <CAP-5=fX5Kmdp1LYnaq9y-8ysk=Steo07b-gtiWx=mmTXDbSJnA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A reminder to help indicate a preference on office hour times and
video conference tool. So far the preferences are:
 - day of week: Thursday
 - time: 1pm GMT, 10am GMT-3, 3pm GMT+2, 6am GMT-7, 6:30pm GMT+5:30, 9pm GMT+8
 - video conference tool: Google meet

Thanks,
Ian

On Mon, May 2, 2022 at 9:35 AM Tanusree Debnath <tanu235m@gmail.com> wrote:
>
> Hi,
> Thanks for the email. I have taken the survey and selected the times.
> Regards,
> Tanu
>
> On Sun, May 1, 2022 at 11:12 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Hi,
> >
> > We have multiple Google summer-of-code applicants this year, and we'd
> > like to have a forum where they can discuss their proposal, work,
> > problems, etc. with the wider developer community. As such we're
> > proposing to set up biweekly office hours. It could be that these
> > office hours provide useful for other discussions too. To work out the
> > best time and video conference tool for this I've created an anonymous
> > Google form:
> >
> > https://forms.gle/WCN19uMjp15bNRJV6
> >
> > Please help determine the best time and tool by entering what works
> > best for you.
> >
> > Thanks!
> > Ian
