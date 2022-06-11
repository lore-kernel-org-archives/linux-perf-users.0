Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB8C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Jun 2022 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiFKS2x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Jun 2022 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiFKS2w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Jun 2022 14:28:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D786021E11;
        Sat, 11 Jun 2022 11:28:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so3740337ejj.10;
        Sat, 11 Jun 2022 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8vjC1NOqcfKHs6cCVju07ovb9Bmfhfc9kJzZpuTlAs=;
        b=kndKVMrTTrr+Og3lph4E8s24LCWngPqyvj2HfhGX/JglD2YaVdAsKbCnoF/KZh5O4M
         MSvcD+PBv+hnBUANwCwlJ+zCITn7W8DuN7zWV25kgE1rdJSCrMhBK/idJZIjH+A5pXQu
         GXOxRm6LrLSlIvIh9QgwRf/aE1lM+ql/5H5ltRDt7oK7TCK/fRqp7LT0PXyp0gvQbaam
         uT83nLpv0wZfsNBzoS9tY+MPb6y4O+qYGiJHbRwGfNAwZjRhmr8/7Ozy0L8KmwPNXldS
         cn6M3H1UQlSxLoXe9QzE7HUHu5fdKNogUEonij1ok5UI7KOzxrD/WdrAFfLrChLY7xq1
         NlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8vjC1NOqcfKHs6cCVju07ovb9Bmfhfc9kJzZpuTlAs=;
        b=ucTPu0Irf+TZa4vtCHuYgi1QGDT4NH9p8fdTAsti5F9m380izHpKy/Yd9psqsCe6aK
         5Y82dYvwt4j60WwDYtICFoDZ+vuOo3yfC6N0JwiNRgLtijGLZOcrEy0q73Rc26IRNT2c
         R6wNVbP5bJ3bnPvxOdGExP28+lltq+JlYQJXpy6SJcoBqJHDJkYm8Y6CWtHO5rCENvUG
         lz1L3/9zGXOE9KIS7oQgP0QpSgnua+Wz/41yeQyvoftpPzFT/Xsck/+UQwCGVGHYPvoI
         Rigle8xeajNMZWZ/4KBJFrkqRF5wEUZwGrJSFgvMa9mVv56AOo7lnqZwZQw56Pn1fX3z
         tFSg==
X-Gm-Message-State: AOAM533EqmTf3vc533VdM40RVMP5XtLqM1YQURNRkjIlfTmMn3eXZSWf
        HF0ECZK+3SCMh8qhIrn0ASA/H6tsinujETbZ9Po=
X-Google-Smtp-Source: ABdhPJyXzlDhAZ+FKjclWprkT+e8NVYLHB0jOQPZ+A2Pu0ikmI7H37YxLZ2dsZIAXCCLQCoF7Z1ZWtshACaNpDjHEB0=
X-Received: by 2002:a17:906:14d5:b0:711:c55a:998 with SMTP id
 y21-20020a17090614d500b00711c55a0998mr31961646ejc.708.1654972128256; Sat, 11
 Jun 2022 11:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220609192936.23985-1-9erthalion6@gmail.com> <20220609193028.zhxpxscawnd3sep6@erthalion.local>
In-Reply-To: <20220609193028.zhxpxscawnd3sep6@erthalion.local>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 11 Jun 2022 11:28:36 -0700
Message-ID: <CAADnVQLLq+=gc1r+5pxrf3=VL29yZG=_9z6Th-rzcpC+xxsoyA@mail.gmail.com>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe
To:     Dmitry Dolgov <9erthalion6@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 9, 2022 at 1:14 PM Dmitry Dolgov <9erthalion6@gmail.com> wrote:
>
> > On Thu, Jun 09, 2022 at 09:29:36PM +0200, Dmitrii Dolgov wrote:
> >
> > Enable specifying maxactive for fd based kretprobe. This will be useful
> > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> >
> > The original patch [2] seems to be fallen through the cracks and wasn't
> > applied. I've merely rebased the work done by Song Liu and verififed it
> > still works.
> >
> > [1]: https://github.com/iovisor/bpftrace/issues/835
> > [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
>
> I've recently stumbled upon this seemingly lost topic, and wanted to raise it
> again. Please let me know if there is a more appropriate way to do so.

With kretprobe using rethook the maxactive limit is no longer used.
So we probably don't need this patch.

Masami, wdyt?
