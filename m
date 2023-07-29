Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7466EEB64DD
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Jul 2023 00:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjG2Alk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjG2Al0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 20:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD3749DD;
        Fri, 28 Jul 2023 17:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D31462223;
        Sat, 29 Jul 2023 00:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF58C433C7;
        Sat, 29 Jul 2023 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690591099;
        bh=6JXSUjfSrAVc9Yojm4Q1bx0HnxoRA4QH67N8+PlgllQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J+hheeEAXGjkYYCCmxnoaweRRs8KOEdXzU5nxvMwhrkGOAxqilIb/7sD2bEFVyJNO
         grItDGNQO6mJYxviWKFCklz1n78PrW2GtTYuYVkYxMdylw8yMsKEejW9VMfQWNQaOF
         gUt3Wlnago3a9Fl1tEwG2lQngXlD4J51YX0/tRn0u3NWctJFZ0ENyRtNZHu0u4rGUJ
         tIvYn1FeDhnhib0491ZHKCtibe0SYqICeJvU9LC/kOwLSmxEa0H5Imyt07CcnPSgV2
         jGDYgpEWkH2iGDLlhaji5PjAKxSTZIKh/tFiXrEWILVH++wECunjT9aMyurxQboCG4
         C6kBQy04B29GQ==
Date:   Sat, 29 Jul 2023 09:38:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Georg =?UTF-8?B?TcO8bGxlcg==?= <georgmueller@gmx.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: skip test_uprobe_from_different_cu if there
 is no gcc
Message-Id: <20230729093814.d48a7b4fb51fdd74ad50ba42@kernel.org>
In-Reply-To: <20230728151812.454806-2-georgmueller@gmx.net>
References: <20230728151812.454806-2-georgmueller@gmx.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 28 Jul 2023 17:18:12 +0200
Georg Müller <georgmueller@gmx.net> wrote:

> Without gcc, the test will fail.
> 
> On cleanup, ignore probe removal errors. Otherwise, in case of an error
> adding the probe, the temporary directory is not removed.

Interesting, so clang will not generate DWARF or perf probe is not able to
handle clang generated DWARF?

Anyway, this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Fixes: 56cbeacf1435 ("perf probe: Add test for regression introduced by switch to die_get_decl_file()")
> Signed-off-by: Georg Müller <georgmueller@gmx.net>
> Link: https://lore.kernel.org/r/CAP-5=fUP6UuLgRty3t2=fQsQi3k4hDMz415vWdp1x88QMvZ8ug@mail.gmail.com/
> ---
>  tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> index 00d2e0e2e0c2..319f36ebb9a4 100755
> --- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> @@ -4,6 +4,12 @@
> 
>  set -e
> 
> +# skip if there's no gcc
> +if ! [ -x "$(command -v gcc)" ]; then
> +        echo "failed: no gcc compiler"
> +        exit 2
> +fi
> +
>  temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
> 
>  cleanup()
> @@ -11,7 +17,7 @@ cleanup()
>  	trap - EXIT TERM INT
>  	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
>  		echo "--- Cleaning up ---"
> -		perf probe -x ${temp_dir}/testfile -d foo
> +		perf probe -x ${temp_dir}/testfile -d foo || true
>  		rm -f "${temp_dir}/"*
>  		rmdir "${temp_dir}"
>  	fi
> --
> 2.41.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
