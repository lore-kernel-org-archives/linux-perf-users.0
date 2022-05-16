Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ED6C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 15:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbiEPPXe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245344AbiEPPXU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 11:23:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494CB3C71C
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 08:22:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l18so29338462ejc.7
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:organization:content-transfer-encoding;
        bh=Ts+xJH/6jf84GuycsmstJjVOLugPldawmI9Jw2Zr1u4=;
        b=p5Ycdl/4crN4HZW91CypHFw9WOWbWhF7i+6DAvsUT2FWkt0AfE5IAQaVyftOSffkNm
         OgD/BLcrxuLbIqUJk/OgYlpE4DdjRb5KSC2u58uWnH9LxP1gKODKfFxICsXh6EVNDoJc
         uOAInzVDx5GgKY4yy9fqdThq2fjm9czNpywokftHwPTGfnWQN++sLsWrGQN46nqtS1Ro
         n7U9Mg5bOIHS5XR9Q0wiNZLj/Z/YjCosO/uQk/6cCEdlLFYafBw4Dtmy4rleOdLExjf7
         BQBswMBYtaDGQ+SUkic4OvBMGvXBB9VJ0/B6t14bmRsLBY44YcQLnhe+XYSRE4TGIjQd
         UIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:organization
         :content-transfer-encoding;
        bh=Ts+xJH/6jf84GuycsmstJjVOLugPldawmI9Jw2Zr1u4=;
        b=IGXoIyRMjiY073iMrBGWjF3hkLWc2dTOOTHF7jQ+pUmfpze34tQxBDWnndczVO0sv6
         WSmWcvQbNWz5KA79tWmEtBidKzBmi/E4z2BE50PqkP+muBVtmPr018seUxJtE4juIo1W
         kwmyusRLmB++aDQJGbQDS7tZhK6JsPfh6MCSVp9BcFXvtDkAxKCRd3z/Z+boaaW1YiBM
         DSrNKqDSExzRnP/YcRpifqoyyRaWqrv5Spmrnu9i5umB4PYgwq2Q7mufCmH5HT1Yv2sq
         N0oJmbk6MtICd8+lPSEJ5Vws+oIIpr0fKfBKZc4KcktbRGmNGm5W/f3w9z+VtaJvpM5Q
         ooyQ==
X-Gm-Message-State: AOAM533X/a0EZ7pr8y30iY2SH7d1FL8aMpfePUtcGS481iWYPntwFW2T
        zmEMByCiZdjiUXPR0pKECUKHuEIGOlt8Nazo
X-Google-Smtp-Source: ABdhPJyrkwC0z6T09pDfR0LrEX9JHhZ9yfci2ijku6hPpW8r7EJ5EPHUtAfYm6Mf9U0Cb/0W8N9XLQ==
X-Received: by 2002:a17:907:6088:b0:6f4:bc5b:ab3c with SMTP id ht8-20020a170907608800b006f4bc5bab3cmr15690944ejc.236.1652714558390;
        Mon, 16 May 2022 08:22:38 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906778700b006f3ef214ddfsm20607ejm.69.2022.05.16.08.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:22:37 -0700 (PDT)
Message-ID: <f0add43b-3de5-20c5-22c4-70aff4af959f@scylladb.com>
Date:   Mon, 16 May 2022 18:22:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     linux-perf-users@vger.kernel.org
From:   Avi Kivity <avi@scylladb.com>
Subject: Infinite recursion in `perf record`
Organization: ScyllaDB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In bpf-event.c we have:


struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
{
        struct btf *btf;
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        int err = btf__get_from_id(id, &btf);
#pragma GCC diagnostic pop

        return err ? ERR_PTR(err) : btf;
}

and in btf.c we have:


int btf__get_from_id(__u32 id, struct btf **btf)
{
         struct btf *res;
         int err;

         *btf = NULL;
         res = btf__load_from_kernel_by_id(id);
         err = libbpf_get_error(res);

         if (err)
                 return libbpf_err(err);

         *btf = res;
         return 0;
}

Obviously, if the first weak symbol isn't overridden we get into an 
infinite recursion, which is what I see immediately on running perf record:


(gdb) bt
#0  0x00007f3d94c26d76 in btf__get_from_id (id=282, 
btf=btf@entry=0x7ffc1dab4010) at btf.c:1410
#1  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#2  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4060) at btf.c:1411
#3  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#4  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab40b0) at btf.c:1411
#5  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#6  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4100) at btf.c:1411
#7  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#8  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4150) at btf.c:1411
#9  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#10 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab41a0) at btf.c:1411
#11 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#12 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab41f0) at btf.c:1411
#13 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#14 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4240) at btf.c:1411
#15 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#16 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4290) at btf.c:1411
#17 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#18 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab42e0) at btf.c:1411
#19 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#20 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4330) at btf.c:1411
#21 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#22 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4380) at btf.c:1411
#23 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#24 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab43d0) at btf.c:1411
#25 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#26 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4420) at btf.c:1411
#27 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#28 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4470) at btf.c:1411
#29 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#30 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab44c0) at btf.c:1411
#31 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#32 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4510) at btf.c:1411
#33 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#34 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4560) at btf.c:1411
#35 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#36 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab45b0) at btf.c:1411
#37 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#38 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4600) at btf.c:1411
#39 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#40 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4650) at btf.c:1411
#41 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#42 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab46a0) at btf.c:1411
#43 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#44 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab46f0) at btf.c:1411
#45 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#46 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4740) at btf.c:1411
#47 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#48 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4790) at btf.c:1411
#49 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#50 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab47e0) at btf.c:1411
#51 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#52 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4830) at btf.c:1411
#53 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#54 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4880) at btf.c:1411
#55 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#56 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab48d0) at btf.c:1411
#57 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#58 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4920) at btf.c:1411
#59 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#60 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4970) at btf.c:1411
#61 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#62 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab49c0) at btf.c:1411
#63 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#64 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4a10) at btf.c:1411
#65 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#66 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4a60) at btf.c:1411
#67 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#68 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4ab0) at btf.c:1411
#69 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#70 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4b00) at btf.c:1411
#71 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#72 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4b50) at btf.c:1411
#73 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#74 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4ba0) at btf.c:1411
#75 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#76 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4bf0) at btf.c:1411
#77 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
#78 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>, 
btf=btf@entry=0x7ffc1dab4c40) at btf.c:1411
#79 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized 
out>) at util/bpf-event.c:30
--Type <RET> for more, q to quit, c to continue without paging--


(rest of infinite stack trace omitted)


I guess I should load some library or other, but I have no idea which, 
and in any case this is quite a fragile interface.


perf-5.17.6-300.fc36.x86_64


