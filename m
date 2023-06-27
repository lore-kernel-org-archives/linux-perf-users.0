Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCBEB64DD
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 03:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjF0Dia (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 23:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjF0Dhp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 23:37:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8D74EE1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 20:31:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5774068f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 20:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687836697; x=1690428697;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GbO+jlh/+SHI/tcTuT/GmsMZMmHOv628giw+Fale9I=;
        b=lt548kuA2FVP1IeyUVcVhJeuGW7XELKZtjZgyAjoQyHAfg3ZsJMACuUyP/8R0tOAv2
         CtFgWlyaIyegpQv0616hNffKXuCk4lNpLmlH7IEbUj1jZx3iy9KlcRSCbc1Zu9jWKdvF
         ardr3J/KujJJjfK8M3DGp3TpJA2V+JUqHv4iKvscpko98v/tssEwHb2zJ9E3Bvl1+vd2
         YCBH8uuzkY//2j/zVqqYxyXQ2Vkq3UQxPn8Gtr0K1aw20c1n/TMr6fj9DqkLnGZn1OXA
         YUwOfPCTWfYiR/ke2rjNq867mcE+m/lnsQHyZBQWG90jmypsh/pFOMcSmzB3f5ZHr+iM
         aJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836697; x=1690428697;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GbO+jlh/+SHI/tcTuT/GmsMZMmHOv628giw+Fale9I=;
        b=RQUmc1MD2KbRjKtAdqbELF2fA+plWT310uOi96sPEuYh+K8Oh+h22GQo8yMGXgYJHy
         4A9XsnzEuOmwJGSGhiTqF79amN8zO1SnaU6dUYTtIq0JTI3I8PH6QTETMG/WpkkkGq6+
         AvNPD/4IYW2YRVD5KipcBzRaMFpm9QuHCP+WJX+UDlbQROlb/KquUq4CwgWHDDlr77Eq
         aPCk2S1XKLyld9QwHgObI1vokStm67AAiJM0EY3lsK7VqJUJyblT+DOux9f6vRynX0Dt
         mHb5FH2wDMt7wfH0RXRHSSpYbjvMKfe2GseUtV0iPgm+FH7FfegsJfFqt6qbeuM4l55t
         N6KA==
X-Gm-Message-State: AC+VfDxILfQh2abowghCs4f2eoaOhLODde4Vn+38xMxK7I2yhBfl4/Nu
        mKNQsIZzxXGU4/OAiDHDBCyfsA==
X-Google-Smtp-Source: ACHHUZ4DG/F1MkxDITFfZ6tV/0y1Ks9e+W7zekR6iDGnLjp/6Kd9oN2II721QlOREWqFQ3r/v/cHxA==
X-Received: by 2002:a05:6000:545:b0:313:ef93:9257 with SMTP id b5-20020a056000054500b00313ef939257mr6305157wrf.32.1687836697578;
        Mon, 26 Jun 2023 20:31:37 -0700 (PDT)
Received: from [127.0.0.1] ([185.232.21.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000104100b003140039f318sm227717wrx.69.2023.06.26.20.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 20:31:37 -0700 (PDT)
Date:   Tue, 27 Jun 2023 05:31:35 +0200 (GMT+02:00)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dhowells@redhat.com, acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        davem@davemloft.net, irogers@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, netdev@vger.kernel.org, peterz@infradead.org,
        sfr@canb.auug.org.au
Message-ID: <f99109bb-34aa-44d7-9a38-a6df0d6b2ff9@tessares.net>
In-Reply-To: <20230626144934.4904c2ad@kernel.org>
References: <2947430.1687765706@warthog.procyon.org.uk> <20230626090239.899672-1-matthieu.baerts@tessares.net> <20230626142734.0fa4fa68@kernel.org> <CAM9d7che_3z=NgT9OkrNmAQigY3Bo8nv16TVH6fgx8pn76xUbg@mail.gmail.com> <20230626144934.4904c2ad@kernel.org>
Subject: Re: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <f99109bb-34aa-44d7-9a38-a6df0d6b2ff9@tessares.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jakub, Namhyung,

@Namhyung: thank you for the explanations about the header files in the oth=
er thread!


26 Jun 2023 23:49:36 Jakub Kicinski <kuba@kernel.org>:
> On Mon, 26 Jun 2023 14:41:56 -0700 Namhyung Kim wrote:
>
>> But in general you don't need to change the copy of the tools
>> headers together.=C2=A0 It also needs to support old & new kernels
>> so different care should be taken.=C2=A0 Please separate tooling
>> changes and let us handle them.
>
> Ack, I'm not sure what makes this a special case, from Stephen's
> original report:
>
> https://lore.kernel.org/all/20230626112847.2ef3d422@canb.auug.org.au/
> > it sounded like perf won't build without the fix.

The copy of the header file is confusing :)

If I understood properly, here, we need the modification in msg_flags.c fro=
m Perf code because this file has been recently modified by David's series =
in net-next to support a new flag (not present in the system header files y=
et). Without this patch, Perf doesn't build.

Now regarding the "internal" copy of header files: we don't need to modify =
it because it is just used by Perf maintainers to monitor the modifications=
 in the original file. If I'm not mistaken, it might even be better to reve=
rt the line that has been removed in David's original series in net-next in=
 this header file. But now that Namhyung is aware of that modification, I g=
uess the revert is probably not needed. But in short, it is then better not=
 to modify this header file in the networking tree :-)

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
