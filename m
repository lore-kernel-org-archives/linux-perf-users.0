Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D38FC77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 15:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbjEJPoz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjEJPoz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 11:44:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F110D1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 08:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4F7063402
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 15:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEE9C433D2;
        Wed, 10 May 2023 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683733493;
        bh=HcZeZ78z5odnNw5jZBEpuqjcDKWvyVqLDMYSQj2jKyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHLbaY33Zm2yhAtfkq5Mkspgo++66nCR7Yajg82jbyJPdXxunxHVJOKRh7m9QaP+p
         cwIabxb+gKsDC4b5uNjWTAcn9G3WsfKNC0mYMyoSVmji5EDJ3YGmxXsYmN2wILWXTi
         VVtIfz6eSbnfoNfR/xMxdqFYGelme52+kLgFUWMvejm6LnGIlI5sa73JvrgOhXEqpa
         MLejcuN5gNVsGgRXEdqyJ+ld+coqF0v9Nah9BnVF+wFnm4uEQJi8dMxDaI+9CICR+m
         7L0rrQB9LAbMa2E7S1Va/aReJlJqkOTHlnYdKGXsv1Wnwn10e3Vmt/yOiez7CLOLch
         Jk0Df+CJ/pdHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08131403B5; Wed, 10 May 2023 12:44:49 -0300 (-03)
Date:   Wed, 10 May 2023 12:44:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 07/17] tools headers UAPI: Sync the linux/perf_event.h
 with the kernel headers
Message-ID: <ZFu78esjBo+hNVhh@kernel.org>
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <20ca606cfaea0631c06060fe04270bb08a6a067f.1683712945.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20ca606cfaea0631c06060fe04270bb08a6a067f.1683712945.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 10, 2023 at 06:22:52PM +0800, Yanteng Si escreveu:
> Picking the changes from:
> 
>   commit 09519ec3b19e4144 ("perf: Add perf_event_attr::config3")
>   commit cb6c18b5a41622c7 ("perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to
>    PERF_MEM_LVLNUM_CXL")
> 
> Silencing these perf build warnings::
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h'
>    differs from latest version at 'include/uapi/linux/perf_event.h'
>   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux
>    /perf_event.h

Dropping this one as well:

  CC      /tmp/build/perf-tools/util/unwind-libunwind-local.o
  CC      /tmp/build/perf-tools/util/unwind-libunwind.o
  CC      /tmp/build/perf-tools/util/data-convert-bt.o
util/mem-events.c:298:10: error: ‘PERF_MEM_LVLNUM_UNC’ undeclared here (not in a function); did you mean ‘PERF_MEM_LVLNUM_NA’?
  298 |         [PERF_MEM_LVLNUM_UNC] = "Uncached",
      |          ^~~~~~~~~~~~~~~~~~~
      |          PERF_MEM_LVLNUM_NA
util/mem-events.c:298:10: error: array index in initializer not of integer type
util/mem-events.c:298:10: note: (near initialization for ‘mem_lvlnum’)
make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:98: /tmp/build/perf-tools/util/mem-events.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools/util/cs-etm-decoder/perf-in.o

 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/include/uapi/linux/perf_event.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 39c6a250dd1b..37675437b768 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1339,8 +1339,7 @@ union perf_mem_data_src {
>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
> -/* 5-0x7 available */
> -#define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
> +/* 5-0x8 available */
>  #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
>  #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
>  #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
> -- 
> 2.31.4
> 

-- 

- Arnaldo
