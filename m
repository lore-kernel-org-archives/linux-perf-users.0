Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF5C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 10:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbhKZKTS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 05:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhKZKRS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 05:17:18 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE832C061A18;
        Fri, 26 Nov 2021 02:02:39 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id r15so17547301uao.3;
        Fri, 26 Nov 2021 02:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=j4ytlG5pvDnusgKvXJWq8t0KtDNGMzWoJMrzxJhoLtE=;
        b=k8enL30dxp63sLpC48tMA3x8lvrDWYT6J5Yt6KBCyIsHqIwZkSHzVdLYtl8u+Rdm42
         dFSnd/s3CfxIWyvuDyF5+1D2jTbh/G3q6mvxUy6dP0CpZcO+1PvKYXhbgMEXitZ8Bxk+
         CnCc9qUcBQ4/tSpkX0BR5iyQUDF+2kedpv/SpB9oZROmiuQSD5bHgI/kybJoaHDRqlE+
         sdli1kj84DCUQmLGIjzwHAfNxsGRUaOQN1tKMe0v2nWRqb4hcfc4QVqNwLvLLi4yN6Th
         3M9a7EShODviry+6KkS9ftU/IFm+4BlKj79WVhfpxGNnDDBjtNWI3V2b1qznBdTSuzyg
         VdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=j4ytlG5pvDnusgKvXJWq8t0KtDNGMzWoJMrzxJhoLtE=;
        b=DkGtun1t1iJ0CXVk30zImsBnf2iAQr32IXzh9SFtFzEn8G+sh+kW6ZgRjrJyQAcK1N
         NqqLFnKkWWWVU5oNc6uP4R+pULpK3YXQp7Fe33wP5Bqmv+dHaMIj6zYrcQn5dcsaTrm6
         24TvTCvIxt7t7Nf8DhpTq7PK8Mgf3B+uqeabGw6qiNqK8SU7RGmvvmqr/gv/IzgUpIZW
         DrfqDsKknZrbPOZRxXq5sThM+ROKo7XXXzZhwi1Lxe3a5ULgD1HxSvsU4BrxHmytsmsq
         FY9QH2zKHARJdPZedbB4756WqnzAx/zgJGJROLd/YqxoZtVrB0O5fJdibvWzMY95+9M3
         ddkA==
X-Gm-Message-State: AOAM532PianCIsMUAzIWaT3dEgJIuxoIGoR7JRmZ4Sf/m12KDTU/tzxw
        V5aXopN66uXaO+kFfJb47IrBfHJf3s8=
X-Google-Smtp-Source: ABdhPJyBDnjBHHBXqgcu2/nqBsWPTWTqnaFAX+ebJj508f4Xjpq08j4nSnUdULDTsXK26cxXY1oQVQ==
X-Received: by 2002:a9f:21d7:: with SMTP id 81mr32190839uac.39.1637920958769;
        Fri, 26 Nov 2021 02:02:38 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n27sm3643966uab.5.2021.11.26.02.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:02:38 -0800 (PST)
Date:   Fri, 26 Nov 2021 07:01:16 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BFYI=5D=5BPATCH_1/1=5D_tools_h?= =?US-ASCII?Q?eaders_UAPI=3A_Sync_s390_syscal?= =?US-ASCII?Q?l_table_file_changed_by_new_?= =?US-ASCII?Q?futex=5Fwaitv_syscall_Reply-To=3A?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YaCug8LEHYmZ9G6E@osiris>
References: <YZ/2qRW/TScYTP1U@kernel.org> <YaCug8LEHYmZ9G6E@osiris>
Message-ID: <E1590C4C-2941-4922-A388-30780C9E01FA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On November 26, 2021 6:53:07 AM GMT-03:00, Heiko Carstens <hca@linux=2Eibm=
=2Ecom> wrote:
>Hi Arnaldo,
>
>> To pick the changes in this cset:
>>=20
>>   6c122360cf2f4c5a ("s390: wire up sys_futex_waitv system call")
>>=20
>> That add support for this new syscall in tools such as 'perf trace'=2E
>=2E=2E=2E
>> This addresses this perf build warnings:
>>=20
>>   Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/sy=
scall=2Etbl' differs from latest version at 'arch/s390/kernel/syscalls/sysc=
all=2Etbl'
>>   diff -u tools/perf/arch/s390/entry/syscalls/syscall=2Etbl arch/s390/k=
ernel/syscalls/syscall=2Etbl
>>=20
>> Cc: Heiko Carstens <hca@linux=2Eibm=2Ecom>
>> Cc: Vasily Gorbik <gor@linux=2Eibm=2Ecom>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> ---
>>  tools/perf/arch/s390/entry/syscalls/syscall=2Etbl | 1 +
>>  1 file changed, 1 insertion(+)
>
>I can happily pick this up for the s390 tree, but I'm not sure if that
>is want you want?

Just FYI and to give the opportunity to people to chime in in case somethi=
ng is wrong somehow=2E

Also to advertise the feature=2E

I'm pushing this upstream myself,

Thanks,

- Arnaldo
