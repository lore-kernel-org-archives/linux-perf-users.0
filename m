Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE8CC48BE5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 06:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6A16115A
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 06:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFUG4e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 02:56:34 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45677 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUG4e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 02:56:34 -0400
Received: by mail-wr1-f42.google.com with SMTP id j2so7733109wrs.12
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Jun 2021 23:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOqjWuiEmsaDgXUUs9/6P0dJlnpkcqi4+pWcP7ilHFk=;
        b=NPKXUwUrhlZIKSoUmkfjQ6Q4xfDP7eSSzazCp2uw7xT3wKP7iEiWtF4wuj4fXNBYBW
         tl59g+aJiJ90MCphMpDplMQCOAR9xcq9eXftJ1cklMs2q7AK+8e2yXLa0gMPULHaYEAP
         Ktps5tyWJhsdqnyLsgAbgp8dG9hTG7PmNLFMXXG80zaxsZm0dJx3zANVuTLwjhfRaYVM
         +orlpkSvOewumYW+RrcapntlvzfjuZaGbmodPsuHxRl7x36W4yE5DngcuOnEpbOjQe01
         I5kN/h8Ir4SqPIp5NqyNp5ESxVVrSvsgYsZjqsDtAXNjUDficd29sWSKjerZ2XNux58P
         SP5Q==
X-Gm-Message-State: AOAM532A0SH5JQfx/ukBfSthp4jCvkZ/awY8NB4Sr+md3qWVHhlaEwol
        CQZJZzRkUpftkBIZwRiXNNE=
X-Google-Smtp-Source: ABdhPJwXegQN9Dj31s+JjAAgnHw+EZh1sOCyRMeIBQ8kXwVxbCWNudsHP9IEwJ98cF4bkKaehd9m9Q==
X-Received: by 2002:adf:db41:: with SMTP id f1mr12156966wrj.394.1624258459342;
        Sun, 20 Jun 2021 23:54:19 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t16sm16682481wmi.2.2021.06.20.23.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 23:54:18 -0700 (PDT)
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: perf-top: heap-buffer-overflow in elf_sec__is_text reported from
 ASan
To:     Riccardo Mancini <rickyman7@gmail.com>, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        acme@kernel.org
References: <e883163b0c0295bfb8a56dcc82f6cae4cbbdc84a.camel@gmail.com>
Message-ID: <c0f82ef2-e87b-8ede-3525-429fcb9f645c@kernel.org>
Date:   Mon, 21 Jun 2021 08:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e883163b0c0295bfb8a56dcc82f6cae4cbbdc84a.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On 18. 06. 21, 11:17, Riccardo Mancini wrote:
> ASan reports a heap-buffer-overflow in elf_sec__is_text when using perf-top.
> The bug is introduced by commit 6833e0b: "perf symbols: Resolve symbols against
> debug file first" from Jiri Slaby.
...
> pwndbg> p syms_ss->name
> $4 = 0x607000018f90 "/usr/lib/debug/usr/lib64/libglib-2.0.so.0.6800.2-2.68.2-1.fc34.x86_64.debug"
> pwndbg> p runtime_ss->name
> $5 = 0x6070000190e0 "/root/.debug/.build-id/37/475e3b392fb3971c8ad0d9ac0a4d7e1b93c521/elf"

Out of curiosity, could you post output of 'readelf -S' on both of them?

> Furthermore, the branch in line symbol-elf.c:1241 (the one added in the referred
> patch) is not taken.
> 
> As you can see, sh_name is out-of-range (342 > 332).
> I can also provide a coredump, if it can be useful.
> 
> I have no idea of how the ELF stuff works, but I thought this may be caused by
> the fact that secstrs is built from runtime_ss, while shdr is built from syms_ss
> (since it is the change of the commit). I tried to test this theory with the
> following change:
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index a73345730ba9..8d2b692f11a2 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1146,7 +1146,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>   	if (symstrs == NULL)
>   		goto out_elf_end;
>   
> -	sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shstrndx);
> +	sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
>   	if (sec_strndx == NULL)
>   		goto out_elf_end;
>   
> @@ -1244,6 +1244,14 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>   		 * values for syms (invalid) and runtime (valid).
>   		 */
>   		if (shdr.sh_type == SHT_NOBITS) {
> +			sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shstrndx);
> +			if (sec_strndx == NULL)
> +				goto out_elf_end;
> +
> +			secstrs = elf_getdata(sec_strndx, NULL);
> +			if (secstrs == NULL)
> +				goto out_elf_end;
> +
>   			sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
>   			if (!sec)
>   				goto out_elf_end;
> 
> However, it still overflows, but oddly the branch is not taken before the
> overflow. Is there some kind of state that gets changed in the ELF structs?

Something like that should work. But you should reset sec_strndx also in 
the else branch, IMO. So what about this?

--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1081,7 +1081,7 @@ int dso__load_sym(struct dso *dso, struct map 
*map, struct symsrc *syms_ss,
         struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
         struct map *curr_map = map;
         struct dso *curr_dso = dso;
-       Elf_Data *symstrs, *secstrs;
+       Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
         uint32_t nr_syms;
         int err = -1;
         uint32_t idx;
@@ -1150,8 +1150,16 @@ int dso__load_sym(struct dso *dso, struct map 
*map, struct symsrc *syms_ss,
         if (sec_strndx == NULL)
                 goto out_elf_end;

-       secstrs = elf_getdata(sec_strndx, NULL);
-       if (secstrs == NULL)
+       secstrs_run = elf_getdata(sec_strndx, NULL);
+       if (secstrs_run == NULL)
+               goto out_elf_end;
+
+       sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
+       if (sec_strndx == NULL)
+               goto out_elf_end;
+
+       secstrs_sym = elf_getdata(sec_strndx, NULL);
+       if (secstrs_sym == NULL)
                 goto out_elf_end;

         nr_syms = shdr.sh_size / shdr.sh_entsize;
@@ -1237,6 +1245,8 @@ int dso__load_sym(struct dso *dso, struct map 
*map, struct symsrc *syms_ss,

                 gelf_getshdr(sec, &shdr);

+               secstrs = secstrs_sym;
+
                 /*
                  * We have to fallback to runtime when syms' section 
header has
                  * NOBITS set. NOBITS results in file offset 
(sh_offset) not
@@ -1249,6 +1259,7 @@ int dso__load_sym(struct dso *dso, struct map 
*map, struct symsrc *syms_ss,
                                 goto out_elf_end;

                         gelf_getshdr(sec, &shdr);
+                       secstrs = secstrs_run;
                 }

                 if (is_label && !elf_sec__filter(&shdr, secstrs))


thanks,
-- 
js

-- 
js
suse labs
