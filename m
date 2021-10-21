Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B609CC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 12:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E147610C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 12:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhJUM42 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhJUM42 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 08:56:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 071F4610C8;
        Thu, 21 Oct 2021 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634820852;
        bh=n1TJy9YHDHpgreV6MAgx+0+F4X2zqZrLqlawHW8TgAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2QEdov8a3r3UiGWuZHdTzcNKdPOyiPAf2GX4zz2M8YY4uLtQjVfR8JrVD67eL+he
         PKKABatOLD3Z6DIYwShoGZrFIUiHp+rxNv/wVzSXRU3m53WIrvutwbysNtiwNrVjPG
         M7uR4xogPXUQWYRyqqCBrq621fgDF0/SHbp8X72FNsanHHiEW3MIrPLFPVDKRNlea3
         RAIsJDG8KrBBjvR4n70D2XxDoylT0rXBEtR9K/zU7nQYlatap1R0K1UjA9ehJEuKhP
         Bdh9AT6213cN5hWgnNFlGlLP+JyMGKBWgCYCbiohqHxBelpJm6w+KKKDAJZCiebCfo
         fxgUKZhE3CeUQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53B03410A1; Thu, 21 Oct 2021 09:54:07 -0300 (-03)
Date:   Thu, 21 Oct 2021 09:54:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, denik@chromium.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix /proc/kcore access on 32 bit systems
Message-ID: <YXFi7zN9Gsq76Mp6@kernel.org>
References: <20211021112700.112499-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021112700.112499-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 21, 2021 at 12:27:00PM +0100, James Clark escreveu:
> Because _LARGEFILE64_SOURCE is set in perf, file offset sizes can be
> 64 bits. If a workflow needs to open /proc/kcore on a 32 bit system
> (for example to decode Arm ETM kernel trace) then the size value will be
> wrapped to 32 bits in the function file_size() at this line:
> 
>   dso->data.file_size = st.st_size;
> 
> Setting the file_size member to be u64 fixes the issue and allows
> /proc/kcore to be opened.

Thanks, applied.

- Arnaldo

 
> Reported-by: Denis Nikitin <denik@chromium.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/dso.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 83723ba11dc8..011da3924fc1 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -193,7 +193,7 @@ struct dso {
>  		int		 fd;
>  		int		 status;
>  		u32		 status_seen;
> -		size_t		 file_size;
> +		u64		 file_size;
>  		struct list_head open_entry;
>  		u64		 debug_frame_offset;
>  		u64		 eh_frame_hdr_offset;
> -- 
> 2.28.0

-- 

- Arnaldo
