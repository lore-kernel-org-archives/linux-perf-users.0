Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A4AC05027
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Feb 2023 07:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBIHYK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Feb 2023 02:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjBIHXv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Feb 2023 02:23:51 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1F4ED35
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Feb 2023 23:23:27 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s20so758930pfe.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Feb 2023 23:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tddsbJmipDadgZuL4C+TKbP9J2syeyMjmHZxy6JDTt4=;
        b=QTvuFq/7v+CdkDisGU23a4Mg4sCbIx93MNu51rqdsSFelRH+bzFtnIoxiDz5XLtECD
         mVOdxoI+TDOdkZ+OftJL3dm7+U+HdYpulqUrb2jLjjKCqVg0ACdWdD2HO+m/yRYZ3tuw
         wkdhJGyPozWn+PtKhMrcQXV0lfoFGh+g0xgtz67cOirBzeCAtoScHKwH/q5zla5Efj+F
         bOGjzkshWM0wd9jjds9Jgo9wbbEimVjRaN2G/fPBSRVYTKbJ7QTToZAfK2O0wuDdv6lJ
         yO49Rn6wsAx0XAY45aXkgHk7bVpHRoWTWItBRJR4rEGqsJGkEgeumTF3u+UwIkz1j6EL
         2c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tddsbJmipDadgZuL4C+TKbP9J2syeyMjmHZxy6JDTt4=;
        b=aAs6FtmpqQJSfN3/NfmJF0gMReKIjxXgHFr0B2SaGuHYNWeNd6nsIENaXG3k+YrmbI
         p7ahuhGlcCWYXARsifPzmDu9nT/NRaz5FhADIAt2I40m33P0QQedbM+1pFo9xfX7Pnbt
         qnsO7kXSSsyqcw5lBy47OZab8mQaS8ROFHhCvogZj50rt79Kc08Mphc0Ae1NVlpUXkUh
         qq0eXHTd6yyI6XMKeWoLm9Z0fKNEdgxch/mvOZ4yvV4d5ho/1FCimVSWpyqy6bmhM/hc
         jiBRNwq8uS9QRIUblMLgSFxvYXFJtBl/02U6VvdByuMF8A3neo5niMvJc09XkqQQBYB6
         IuDg==
X-Gm-Message-State: AO0yUKU5BZJ/dQNlNPUAFv86mI0QdbldmZsLB7OW8eErBSOVI+wb5fe9
        lITlCMQ1dzH9ZUW/+w0mkhIIb4SKuoypz+tCBFTDaQ==
X-Google-Smtp-Source: AK7set8147oifuJImE5p0zRAylkYykGYufjK3B5xwMaz7PIg/QVSQ6RfLCFlhgyJPReztt3sdy3IK2VJ1VcQgxbPxyU=
X-Received: by 2002:a63:8f0c:0:b0:4fb:3232:8f70 with SMTP id
 n12-20020a638f0c000000b004fb32328f70mr1164056pgd.9.1675927404760; Wed, 08 Feb
 2023 23:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <20230201135737.800527-3-jolsa@kernel.org>
In-Reply-To: <20230201135737.800527-3-jolsa@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 8 Feb 2023 23:23:13 -0800
Message-ID: <CA+khW7iGj=Y3NVxc9Y-MnwmPxCz5jHDmSfW-S6KS9Hko=jgJOg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] bpf: Use file object build id in stackmap
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 1, 2023 at 5:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Use build id from file object in stackmap if it's available.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Can we insert the lookup from vma->vm_file in build_id_parse() rather
than its callers?

>  kernel/bpf/stackmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index aecea7451b61..944cb260a42c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -156,7 +156,15 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>                         goto build_id_valid;
>                 }
>                 vma = find_vma(current->mm, ips[i]);
> +#ifdef CONFIG_FILE_BUILD_ID
> +               if (vma && vma->vm_file && vma->vm_file->f_bid) {
> +                       memcpy(id_offs[i].build_id,
> +                              vma->vm_file->f_bid->data,
> +                              vma->vm_file->f_bid->sz);
> +               } else {
> +#else
>                 if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
> +#endif
>                         /* per entry fall back to ips */
>                         id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>                         id_offs[i].ip = ips[i];
> --
> 2.39.1
>
