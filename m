Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5BCC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 17:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357951AbiDLREG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350788AbiDLREG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 13:04:06 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BFC6005A
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 10:01:47 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id j9so8356076uap.13
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiWqe0uI7jc02BRjMt4NzojCC6YP4KThreT0NgYLTMo=;
        b=cYdlUqT/W/DTkVY6hae49EurkIEnMVXKpUYFzHC382Z8GDdpecPoNRWz68WbQBPcs1
         9+0SmQPMuLGkysgzLmRmGYgYcNFL3xRfInr+nYt4V4iikYhsoddgVpV7NXXZBViGDyiD
         2xVQ4u2MVgZLyrxyFcjtFbQZ26nNwNoyZW5NRRTs1m2IpprLoxfyUH/yPuI8GejnNmlm
         iRUIDVVTtoeDUSQvhydSXRnuimb0xPwcEbES+3xWjhZs87UNw86MkDsHwh030bTW3JjR
         maeTqN7bwMn4JvY4jIYlhS136fiHWThebuHXRXR53cbhuGxvCogoEzL0Vtn/qbgh7gUt
         bL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiWqe0uI7jc02BRjMt4NzojCC6YP4KThreT0NgYLTMo=;
        b=BUJ6p4cVrdjdk5MFRzExigbIAg6eAF8MiQq2EiYX3xpNkKVuv2iz7rFbvyMrrGzWXT
         R1t9yUEFOAg0ugR/DXpdRZk3cVeiLf0SW2Y6xhjhsdhHaHeUvb58LUmJ1gMhLUYClj+u
         IyzbsUdfwObFjc/O5+wx1qQA/QKDv1qQYtgQEdpzU/brJl8n9RGlT9VX6mOvFfFvtDNL
         lubyk7V6kH2B5Glgm+kv3bZC9odbxJYL9hAvxq5UgHoyDH1WPJaNnHh43Dm8DlEhmZnZ
         ktWvAsFngr/15rU8mHjoNKuucW2oblpOHUjAKXSOdtfg19rRtLXD5ffk8GYGUtn/7yv4
         ZgCg==
X-Gm-Message-State: AOAM532z1KxtgNz3KhzJYS8n4dvYqLeJXleNqAs1uJ7bfyo+Y4A0XRo0
        GSb1NFCIhmk8d2jwMz2aI9w5Uu5upuL8EfVphbMz+I8a9Hemtg==
X-Google-Smtp-Source: ABdhPJw+ogfiWBRs+LUp9uB4uoje7dimawETGqNMSQPxV81rRVJ1VMuAH9ziUdRgFFjDbjAMpC3XskPccyTlYFHIr8k=
X-Received: by 2002:a9f:2c4d:0:b0:352:73f9:d30 with SMTP id
 s13-20020a9f2c4d000000b0035273f90d30mr1764599uaj.65.1649782906309; Tue, 12
 Apr 2022 10:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPS78poKf3EF5y_AND3p7A_rc6SGbQtmBfQKnBzkqU+yq5TF6g@mail.gmail.com>
 <CAP-5=fXsLJ=mRq1wDn2f5Oc3x6K4=m3QFzBK9Z_5ZQzGm6aC-A@mail.gmail.com>
In-Reply-To: <CAP-5=fXsLJ=mRq1wDn2f5Oc3x6K4=m3QFzBK9Z_5ZQzGm6aC-A@mail.gmail.com>
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Tue, 12 Apr 2022 10:01:35 -0700
Message-ID: <CAPS78prB=GMQHf4D=G=NkEYcRGoOsc_opuRwv_F+CUA=15fCbQ@mail.gmail.com>
Subject: Re: [Question about project size]Perf data converter is large project
 or medium project?
To:     linux-perf-users@vger.kernel.org
Cc:     arnaldo.melo@gmail.com, mingo@redhat.com,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        peterz@infradead.org, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
Thanks for your reply. I have submitted the application.
Regards,
Tanusree

On Tue, Apr 12, 2022 at 9:39 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Apr 12, 2022 at 6:55 AM Tanusree Debnath <tanu235m@gmail.com> wrote:
> >
> > Hi,
> > I am applying for GSoC. I wanted to know if "Perf data converter" is a
> > large project or a medium project as I have to mention that in the
> > google application form. Please let me know.
>
> I think it can be both, it is deliberately open ended so that you can
> keep contributing support for more formats as time allows. Does the
> selection have time or other implications? If not I'd say either
> choice should be fine.
>
> Thanks,
> Ian
>
> > Thank you,
> > Tanusree Debnath
