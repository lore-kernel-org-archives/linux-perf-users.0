Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4F4C0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Jul 2023 13:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjG0NIB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Jul 2023 09:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjG0NIA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Jul 2023 09:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111EF9C
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 06:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97D5461E76
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 13:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62DDC433C8;
        Thu, 27 Jul 2023 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690463278;
        bh=9iLLIbFPMTlW58RwqjCUc4ue3BAmQrDJQcrR/wu0GTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svSWZsWNbZkKggY+2JjZGXH2y4AZPji6vfFZs+X8P/UxCy1BHxuGkL/gUsb7FesY7
         +2qPRf4HJAlmD5T15Dul2NzFWKq/AV7NnhI/r2rXPMFlyIl4Meff0Ol/GgkRuN1lw3
         KpNM4phmXdPIINr/Y7JcWKkWmVLJzbk784FVKIgqKGVJg7nwQlwyQGmk7vCRoe/0Si
         YMv6Jha/sTV8Hk5VXuar4vxhLigY8mgTa/oDiD20fmj9MsQu1sOcaVNZd7EKgGegjy
         60GTFQZo3OLv27xjzYO63mJnBPfQCeez4C6VD4B0qmpFbYcGh8nNHVC8UZKexyzCTz
         TGJ4Aw+w3hQcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27EB340516; Thu, 27 Jul 2023 10:07:55 -0300 (-03)
Date:   Thu, 27 Jul 2023 10:07:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH -next] perf doc: Fix typo in perf.data-file-format.txt
Message-ID: <ZMJsK3eWvDcCRAqQ@kernel.org>
References: <20230727105001.261420-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727105001.261420-1-xiujianfeng@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 27, 2023 at 10:50:01AM +0000, Xiu Jianfeng escreveu:
> The 'it' should be 'is' here, fix it.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  tools/perf/Documentation/perf.data-file-format.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 635ba043fd7d..010a4edcd384 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -43,7 +43,7 @@ struct perf_file_section {
>  
>  Flags section:
>  
> -For each of the optional features a perf_file_section it placed after the data
> +For each of the optional features a perf_file_section is placed after the data
>  section if the feature bit is set in the perf_header flags bitset. The
>  respective perf_file_section points to the data of the additional header and
>  defines its size.
> -- 
> 2.34.1
