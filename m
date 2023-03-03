Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C12C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Mar 2023 00:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCCA3s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 19:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCCA3s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 19:29:48 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D979513510
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 16:29:46 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id v10so354868iox.8
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 16:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677803386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5Z40mK9vCNue5Qyy2p/nm6VwoD+rvgO83vEPJAAFTQ=;
        b=c9DRFRgi931JE6fyu8y7WNzIIk6+0pe0UHmgqr3QnvxGiqZk3Uz+ofxKWepnS/k5r5
         FGqCTmUwtEnRj2XaphIgrdW58lK+FUBwhcwBM0gjSXEKL9mgtTKBqhaymlKeXKMdROK8
         Zcz8CxGYuzwr3JhdN70BHHNSTsJMJ3xODdL6cNcc2h0FEwVsfYW7gI+NmdQ7+fANhQ1B
         d+/ppNdqTaAvasTmN/8SLxvAJ5Urj94pqNKL32iuo7S0R/rTHuIpyghS5Lr8sZY6pNZu
         jRSbDW4GstMbNFRBwfMZNF5J8jNRbKqx4RC6Q5udIMUQGBmlwkdeMErlknFn6xwHQjpP
         i0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5Z40mK9vCNue5Qyy2p/nm6VwoD+rvgO83vEPJAAFTQ=;
        b=SHdqOSErWSNpYTqVx6NFr6bwFfhZZpZdjzrkc1EMPTX3sJAXoT3+FkpbhlhWmNX7IG
         /fGIE6Exm1ZrHlYLBYjaOEiOaRsK/BZpKOY3aBmsPVivTXVOJ6NGmbxrCfEQr8zFOk6X
         rgExswGSz09o/tvZmDpZk9m3Ozs1adn4bPW20fl/vaNTUVmdwSIjJqsTOyrEQtpdRUyA
         m65OrFqBgomS9waeI/Xoo5pizXldBKpqFsB1w02Mh1bxagn5cn5IgBktguGdQuysAMp3
         0V6MJoycI+Ay41LHnMcTnBQN4VgxYoLleZVnToSDW9B4jGqGwCRh9WCx1+wzBy+l8U60
         rFIQ==
X-Gm-Message-State: AO0yUKV5IIlIzOo2vqQQNWmj+8Afdt4FqlijCnu3fAq63TqOiBMs+iXn
        ELHMhm+T0lTUEZ/UkJubaspQffvmAN9BWyEHOfPNzQ==
X-Google-Smtp-Source: AK7set9GNv7qhDf+21FqRW4p+Y+Gkk5XVmDTTSqi7wOVJxO0ci/ie0JQ/IT6dUS6EpGSNFnM5g4a69UL8sQXcm8RTx0=
X-Received: by 2002:a05:6602:14a:b0:745:b287:c281 with SMTP id
 v10-20020a056602014a00b00745b287c281mr5658389iot.2.1677803385998; Thu, 02 Mar
 2023 16:29:45 -0800 (PST)
MIME-Version: 1.0
References: <CANRdyn9kXT623Pbu9hc+c4YrDu_h06a2Ch9fJpt=O0S7yKXDEg@mail.gmail.com>
 <CAP-5=fU30f1j5o7c05ohaygpgV4=Hx7yS7f8i3vZ1j1Gk=HgcA@mail.gmail.com> <CANRdyn9H7kzBXUxpvTJ_93G5Tc=51vCRs9ucHbSyVRO_rQf5vA@mail.gmail.com>
In-Reply-To: <CANRdyn9H7kzBXUxpvTJ_93G5Tc=51vCRs9ucHbSyVRO_rQf5vA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 16:29:33 -0800
Message-ID: <CAP-5=fUr18kZVDDymDB6kJWa7Ptf9XkDMKxorZx2O2UjPusn1w@mail.gmail.com>
Subject: Re: GSoC: perf Linux Profiling Scalability and speed
To:     Lukas Molleman <lukas.molleman@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 1, 2023 at 5:31=E2=80=AFAM Lukas Molleman <lukas.molleman@gmail=
.com> wrote:
>
> Op di 21 feb 2023 om 17:56 schreef Ian Rogers <irogers@google.com>:
>>
>> +Arnaldo Carvalho de Melo
>>
>> On Mon, Feb 20, 2023 at 5:15=E2=80=AFAM Lukas Molleman <lukas.molleman@g=
mail.com> wrote:
>> >
>> > Hi,
>> >
>> >
>> > My name is Lukas Molleman and I'm pursuing a degree in computer scienc=
e engineering.
>> >
>> > I believe I'm a very good fit for this project. I'm passionate about w=
riting clean code and optimization. I've got a good amount of experience co=
ntributing to mathematical and concurrent models at startups and big tech.
>> >
>> > I'd love to have a chat with you to talk more in depth about this proj=
ect.
>>
>> Hi Lukas! Thank you for your interest! Perhaps we can schedule a quick
>> chat, what time zone are you in? Namhyung and I are on PST (GMT-6) and
>> Arnaldo is GMT-3 iirc. I don't think we all need to be there to talk,
>> but maybe we can answer your questions by email.
>>
>> Good habit for the perf tool, and Linux in general, is to try to avoid
>> personal emails and share with the mailing lists. You can get a good
>> amount of information from the linux-perf-users mailing list [1] which
>> tends to cover users and developers.
>>
>> In making an application it is very important to us that:
>> 1) you have a detailed time plan. This lets us know what your strategy
>> for doing work is, how you will work around other commitments, school,
>> etc.
>> 2) you've done something to touch base with the community on
>> linux-perf-users. Some ideas here are to look at improving the wiki
>> [2] or look into if there are test issues on your machine by building
>> then running the 'perf test' command. This isn't the main project,
>> what we're aiming to do is avoid contributors who show an interest but
>> then never get running. By showing you can contribute in a small way
>> ahead of selecting projects then we have some confidence things will
>> go well during the program.
>>
>> Hopefully this is helpful and let me know if email for the chat is okay.=
 Thanks,
>> Ian
>>
>> [1] https://lore.kernel.org/linux-perf-users/
>> [2] https://perf.wiki.kernel.org/index.php/Main_Page
>>
>> >
>> > Kind regards,
>> >
>> > Lukas Molleman
>> >
>
> Hi Ian,
>
>
> Sorry for the late reply. My timezone is GMT+1. Talking over mail is ok.
>
> I had some ideas to add to the documentation but I'm not sure how to prop=
ose changes to the documentation. Does this happen on the website or inside=
 the repo? I requested an account a week ago but haven't gotten an update.

Hi Lukas,

This was a request for the perf wiki? Arnaldo could you see what's happenin=
g?

> I've also found several errors when running perf test. Do I research the =
issue and give info on why it is failing (Could it be normal?) or do I writ=
e a patch to try to fix it?

Perhaps if you share what the errors are then we can talk about how to
fix them. There are also tests that currently say skip but don't give
a reason, it'd be nice to improve this.

> I've made some plan of what I'm going to do but for it to be very detaile=
d I need to know what is exactly expected (How we want to do things, what w=
e want to achieve, what performance improvement we want etc.) from me and w=
here we are now.
>
> Now - start date: Research
>
> Get a deeper understanding by reading the book "Parallel and high perform=
ance computing".
> Understand necessary modules, libraries and tools.
> Understand the code that I need to know to succeed.
>
> Week 1: Design
>
> Based on my research, I'll make a more detailed plan.
> Consider the different parallel processing models such as task-based para=
llelism, data parallelism or message passing.
> Determine which parallelism model will best suit the identified areas of =
the perf tool. (Not sure if I'll decide this or if someone else will make t=
he decisions for me?)
>
> Week 2-6: Refactor and Code
>
> Code. (Not exactly sure. I need more details on where we are now and what=
 we want to achieve and how we want to do it.)

So the perf tool is written in somewhat low-level C code, in fact we
try to adopt the Linux kernel's conventions so that code between the
tool and the kernel can easily be shared. Frameworks for different
kinds of parallelism would need to be added. In the past Riccardo
Mancini looked at adding workqueues;
https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.camel=
@gmail.com/
We'd like to merge this work but it needs rebasing on to the current
perf development tree. One problem encountered by Riccardo was issues
with reference counts. To this end I wrote a reference count checker:
https://lore.kernel.org/lkml/20220211103415.2737789-1-irogers@google.com/
Which has a number of fixes now merged into the tree but not the
actual checking framework itself. A first task may be to work on the
reference count checker and then to bring in Riccardo's work. I
started a rebase on the checker and I should work to send it out again
soon.

Once we have a parallelism framework there are different parts of the
perf tool that would benefit. Being able to open, enable, disable,
close events in parallel would be good for most parts of the tool. A
lot of time in 'perf report' is spent in time ordering samples and
things like the symbols. There is already some support in perf record
for synthesizing events (to create the initial machine state) on
multiple threads, but this should migrate to using workqueues.

I hope this helps. Thanks,
Ian

> Week 7-8: Documentation
>
> Document the changes made to the perf tool to support multi-core processi=
ng.
> Provide examples and usage instructions for users who want to take advant=
age of the new functionality.
>
> Week 9-10: Performance Tuning
>
> Fine-tune the parallelized parts of the perf tool to optimize performance=
.
> Use profiling tools to identify areas that can be further optimized.
> Test different systems (e.g. server with a large amount of cores).
>
> Week 11-12: Compatibility Testing
>
> Test the perf tool with different hardware configurations and operating s=
ystems to ensure compatibility.
> Make any necessary changes to ensure that the tool works seamlessly acros=
s different environments.
>
> Week 13-15: Extra
>
> For when things take longer than expected.
>
>
>
> Kind regards,
>
> Lukas Molleman
>
