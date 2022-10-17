Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A2C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Oct 2022 18:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiJQSYT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJQSYS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Oct 2022 14:24:18 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF274CFF
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 11:24:14 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso6279034oto.9
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v6DiDy4ix9P/W+fn3JWxS25Z5RWuyOGB2yuXhhgoOSg=;
        b=f53N0+uudGGj6Q4xJAdnHctnwtMrq0bJZgTxnDlLQBerLK6GdiL6Dt34Q8XB64KU3p
         kQLAwHqmTqCoGRW6rX3yw2xt4ly+zr9KEKAQXY08DPrwTxbFo5AVj20fKpFhRQs5sp+e
         gJW0u/01ZbCuXZu6QS6QklYdh/dVSRuEJcSEr9P8wZxDiEGj5VP0Gns24mrkMjha9ZbN
         fxxFyXq3cgFEIyxt+n0FVO5yaM9DAqMtDAblCykYT7ecCPlVkuifzjYmaIh0ZJ71lloA
         GOpWQGdP5khZA6dElhOCZodGRMZOe65pssPrGfuvfsH3SsqnmSAu+XaNmnEysLSF5V/M
         fsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6DiDy4ix9P/W+fn3JWxS25Z5RWuyOGB2yuXhhgoOSg=;
        b=QU5OaiL0U5+jIHKNbYmskqkLudoEBNjr3qxULII0vVBdPTjPbvLPgwwrR0WXWQxdzO
         a3P2CSCKJUlTDt+jmRr5WH8Bhy+ML9N+9CCPrTv33ClIK4n3iSFQCl2CrE4Fk4ChwyAU
         ce/uzY2aQHKMYiQ+Adi4OVKCVFe4VFsXJbMvaLQqCmlqc7x3j6AQwxJBfNG601dGpeMh
         gIUgScZT34GAdARZj1qrt8KthJJK/E0/bHDTTConkuEOT2XY59EOocBBbvIj09VtHNBb
         tYpzgFAl0zbLAHTWyulhyz7JpINXQHbt5v8/3W9WcEMPKQYd3OfDWqrlfqWiqEOz5gW1
         5qUQ==
X-Gm-Message-State: ACrzQf3FOo647aIZSzk+lf+IOEOjPDygU1aAz0t/gTNQa8ky6ECHXUFS
        RjPyjs5GBSstrM65rslIZr8Q+qje3xY=
X-Google-Smtp-Source: AMsMyM638bPwazcLBdjgPtfsu8bK4Wvcpu+hylaj0qucgCq3LTzRFdb/reC4LzEPi6XI3mH14TWdKA==
X-Received: by 2002:a9d:6405:0:b0:661:481:783b with SMTP id h5-20020a9d6405000000b006610481783bmr5671772otl.273.1666031053964;
        Mon, 17 Oct 2022 11:24:13 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.238.93])
        by smtp.gmail.com with ESMTPSA id g7-20020a9d6c47000000b00661a1d92aacsm5010627otq.33.2022.10.17.11.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 11:24:13 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:24:08 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Jesus Maldonado <jesus.maldonado@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     linux-perf-users@vger.kernel.org
Subject: Re: [External] : Re: A couple of perf questions
User-Agent: K-9 Mail for Android
In-Reply-To: <588f3f31-3410-6371-4e7b-2141607f3af4@oracle.com>
References: <a6b39321-3918-3191-cc70-4cfa3a756331@oracle.com> <Y0l9CzqROpJYQSER@kernel.org> <588f3f31-3410-6371-4e7b-2141607f3af4@oracle.com>
Message-ID: <1292A666-B6A1-4243-A8DA-457C54D798F4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On October 17, 2022 2:18:55 PM GMT-03:00, Jesus Maldonado <jesus=2Emaldona=
do@oracle=2Ecom> wrote:
>Hi Arnaldo,
>
>Thanks for getting back=2E
>
>+ linux-perf-users@vger=2Ekernel=2Eorg (as suggested)
>
>For the first part, about perf record=2E My intention is to record both c=
ommand and some list of pids=2E
>e=2Eg=2E
>/perf record -p <1234,5678> myExecutable/
>
>So, the final result should include pids 1234, 5678, *and* whatever is th=
e pid for myExecutable once run=2E But what happens is that it can only inc=
lude 1234 abd 5678=2E
>
>Is there an alias or option that can be used so --pid considers as well <=
command>'s pid=2E


That's not available right now but should be doable=2E

>
>2)
>
>> You mean for AMD or Like some feature available on AMD systems, which
>> one?
>I meant on AMD CPUs=2E Something that is similar to Intel PT for AMD CPUs=
=2E

Take a look at this recent patch:

https://lwn=2Enet/Articles/904482/

- Arnaldo=20
>
>Thanks
>
>Jesus
>On 10/14/22 8:15 AM, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Oct 12, 2022 at 11:25:48AM -0700, Jesus Maldonado escreveu:
>>> Hi Arnaldo,
>>>=20
>>> Saw your awesome PR for perf tools changes in 6=2E1=2E and thought you=
 are the
>>> right person to ask these 2 questions=2E
>> Please next time CClinux-perf-users@vger=2Ekernel=2Eorg, you may end up
>> getting a better and/or faster response there :-)
>>  =20
>>> 1) Does perf record allow for recording of a new process + system proc=
esses?
>>> e=2Eg=2E A benchmark tool that runs for a few seconds but interacts wi=
th some
>>> other processes in the system=2E
>>> Ideally something like "filter by process(cmd) name" + new process spe=
cified
>>> in command line=2E
>>> I can think of some workarounds, but wanted to validate=2E
>> perf record can record many things, and some of those things have
>> different filter mechanisms, for instance, you can use --filter right
>> after a tracepoint event to add a filter to that specific event, etc=2E
>>=20
>> Intel PT also has ways for setting up filters=2E
>>=20
>> See 'perf record --help' with the perf man pages installed, look for
>> --filter=2E
>>=20
>> One other way would be to have multiple perf record sessions and then
>> combine the results, but that would require some more work, perhaps a
>> brute force with what is available would be to do a perf script on the
>> multiple perf=2Edata files then concatenate them together and then do a
>> sort by the timestamp=2E
>>=20
>> May be ok for some specific workloads and events, but not for others=2E
>>  =20
>>> 2) Do you know of something that allows for high resolution branch tra=
cing
>>> (say call, return) other than Intel PTs? Like for AMD?
>> You mean for AMD or Like some feature available on AMD systems, which
>> one?
>>=20
>> - Arnaldo
