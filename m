Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CEDC10F1B
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Dec 2022 03:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiLSDp0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 18 Dec 2022 22:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiLSDpZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 18 Dec 2022 22:45:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC26AE5F
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Dec 2022 19:45:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fy4so7828041pjb.0
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Dec 2022 19:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufkpDtqwrwaASbEeUOXsA7V1EpiSQ5Rn4rC/a+dn8wY=;
        b=kREEY0cPLyCDghlpTDJ8V2o21sNnI1qpq49TZewEDl/Dy9Ne8Ooj9q26jiMTKqFAIb
         jBm2PZTjWpl34gp/877YXeDvIXjtCJWXKIaECssweFHZ5k1h5DDv9U5eGtl44jBz4hzu
         7KXJLAe/wVbUrVRtPcZe9ZC0NbeMdZEI9d7zvYAUZvVTZrSb3NRCvih54mACbYLptfDn
         74DCdpslCI0Cwo5zyeylqRxVGM87agTMsIotS/ZrP7kwNkSWGrXauryCBHRi+LstpufE
         2J3jR7tMjbU114xqDI/y7p4jqBSd9YSHLVng8uf5gUhJFr28NryNS12H9ZXh3iKVfOB7
         3MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufkpDtqwrwaASbEeUOXsA7V1EpiSQ5Rn4rC/a+dn8wY=;
        b=JQY6NNdmBa7Djsj/AGuHLN8SOxNaIwCG+rsl9o1weRHWWF95+f8fNhGdxsc5s9LcrE
         d3yYbItdDYHA2XLyBBjevudAukjf9Fn68paUVbJNK7kTTb0+Ov17wxVTJ7AuC2j9HhM+
         cKlMNA3RR/A/84flcAcjotyDv0QAANAPkJhR+OotPwFJPLaozk5IUACuA6vmjzZ36Nby
         bFXcDta7UwYJn5xqd6ObaST19S3Dajxb0/edZzPFRVijYwVKkaChLWSGmIVy5m5PIAKp
         RlxuhRA6siOSe0gNPGoXDPd7qetbb88Y+sQL0WsERPyLJOaCzMrzS8T9+YUmHl1vHduF
         8ObQ==
X-Gm-Message-State: ANoB5pnTDnGAyVbKMJjh1IxZxtsMBV4r7JlWdyEXJMy/oc1gmMCATTtP
        nFUrhPyzXBQp07IiROUMErjAXg==
X-Google-Smtp-Source: AA0mqf7PKPQzRVWRGzVuTYxLiD4/XBylyvC0Ia68WHidlagaoY58bNmKTs8hhuLKkg2UsWRYpxtzQw==
X-Received: by 2002:a17:90a:4f49:b0:219:b04d:a1 with SMTP id w9-20020a17090a4f4900b00219b04d00a1mr41521474pjl.41.1671421523739;
        Sun, 18 Dec 2022 19:45:23 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id 21-20020a631955000000b004772abe41f6sm5194521pgz.83.2022.12.18.19.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 19:45:23 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:45:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF"
 section
Message-ID: <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217223509.88254-2-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Changbin,

On Sun, Dec 18, 2022 at 06:35:08AM +0800, Changbin Du wrote:
> Show the real problem instead of just saying "No such file or directory".
> 
> Now will print below info:
> libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux

Recently I encountered the same issue, it could be caused by:
either missing to install tool pahole or missing to enable kernel
configuration CONFIG_DEBUG_INFO_BTF.

Could we give explict info for reasoning failure?  Like:

"libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux,
please install pahole and enable CONFIG_DEBUG_INFO_BTF=y for kernel building".

> Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory

This log is confusing when we can find vmlinux file but without BTF
section.  Consider to use a separate patch to detect vmlinux not
found case and print out "No such file or directory"?

Thanks,
Leo

> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 71e165b09ed5..dd2badf1a54e 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>  	err = 0;
>  
>  	if (!btf_data) {
> +		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
>  		err = -ENOENT;
>  		goto done;
>  	}
> -- 
> 2.37.2
> 
