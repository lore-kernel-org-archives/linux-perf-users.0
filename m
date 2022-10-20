Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7266C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Oct 2022 23:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJTXsR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJTXsQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 19:48:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6922BCA1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:48:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b4so2148350wrs.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAo+j/Kx/eYwkjkxQHVaiOLaYikKqvSkEAXHJj4lh6c=;
        b=NsYqMoxLwvopRdWRaz57CxiyjPCONM7AggCSYYVz3fNxuCFZ9Ml7/5d/1i1hvwFVP4
         UDlP4J+ZcbymbpRsDFklzyPYP3rdMRCQBRy288+JZMNtmKOt+cYfiWUNIfMxengcX3aX
         b+LiD3GxZnRtGmrVISPvNWghArkpCLT66eErLrd7f+Na7u0xJVMKRkbbWoU3Yautym0J
         bRbpFkngu+Z/5oDb3Fva1OPgxF0fTm4TuGw5yZEfk1uAGD1mm4yNKh6pwZZulrwS4mzy
         qeB+BsjenWrwnEdU5zqYRLQ8dO5v4SfCepiYZ7VCd355OQ4ryhkOjlMcMI82YQhcrYF4
         bORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAo+j/Kx/eYwkjkxQHVaiOLaYikKqvSkEAXHJj4lh6c=;
        b=bQc0jov9OZLKNddg9gYlgt8wSqr1vnRgLOqoYGFSft2vfZKhy5pSSUOVKZiylFP2so
         8ZLtG2xwZJo+7a1bQrYVYaII1dA57EhJ29p72koqoQ4NqG0E/ZjUe3/lsP1x0vdsQ7wo
         OIOKzTR2KwfW53+8PLtXqwGsjMLgtNQIWTM4+phcKzqXDLD5OVIGXkWL4V9DH04DEvZF
         NGI9iQrdB4QE8qKeJTlvSBm7ATEsOdHzHg3Exyakk5mxQHDizBZSc7IiFdsH2QnWZ8UM
         3+ONpsKn3G+Eh+S9azBPr36kyQDVdL2Ll3sVqfTwxotPAiRec8dlsi/GmCn35He9sxOY
         JHmg==
X-Gm-Message-State: ACrzQf0mMBEmsLJUqglki4qeYhhZ/ATjgSY2U8KzfPW+RZ30to+j5r+o
        S6pweNpAj/Z1l03sPywzH6rtXJ5JKI5CLDx5U86iNo0YxQCZpQ==
X-Google-Smtp-Source: AMsMyM47IZ0+emCPVKcSR45YOrL8IcCmIAd4EzDAz37FOOqEp2+gEQR1BkSi1POdVLl2xE9553s8EzpP0OJMS+jtDwA=
X-Received: by 2002:a5d:4c92:0:b0:236:4b97:6828 with SMTP id
 z18-20020a5d4c92000000b002364b976828mr2234355wrs.300.1666309693365; Thu, 20
 Oct 2022 16:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-3-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:48:01 -0700
Message-ID: <CAP-5=fVdoCUq9RrmPZhzA-4MaRMWGeFEzFk6R2uR=5xGugTXeg@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf test: Fix shellcheck issues in the record test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Basically there are 3 issues:
>
>  1. quote shell expansion
>  2. do not use egrep
>  3. use upper case letters for signal names
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 747c33a1ec45..464071462809 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -8,16 +8,16 @@ err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>
>  cleanup() {
> -  rm -f ${perfdata}
> -  rm -f ${perfdata}.old
> -  trap - exit term int
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
> +  trap - EXIT TERM INT
>  }
>
>  trap_cleanup() {
>    cleanup
>    exit 1
>  }
> -trap trap_cleanup exit term int
> +trap trap_cleanup EXIT TERM INT
>
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> @@ -30,13 +30,13 @@ test_per_thread() {
>      fi
>      return
>    fi
> -  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
> +  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
>    then
>      echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> -  if ! perf report -i ${perfdata} -q | egrep -q true
> +  if ! perf report -i "${perfdata}" -q | grep -q true
>    then
>      echo "Per-thread record [Failed missing output]"
>      err=1
> @@ -47,7 +47,7 @@ test_per_thread() {
>
>  test_register_capture() {
>    echo "Register capture test"
> -  if ! perf list | egrep -q 'br_inst_retired.near_call'
> +  if ! perf list | grep -q 'br_inst_retired.near_call'
>    then
>      echo "Register capture test [Skipped missing event]"
>      if [ $err -ne 1 ]
> @@ -56,7 +56,7 @@ test_register_capture() {
>      fi
>      return
>    fi
> -  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> +  if ! perf record --intr-regs=\? 2>&1 | grep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
>    then
>      echo "Register capture test [Skipped missing registers]"
>      return
> @@ -64,7 +64,7 @@ test_register_capture() {
>    if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
>      -c 1000 --per-thread true 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> -    | egrep -q "DI:"
> +    | grep -q "DI:"
>    then
>      echo "Register capture test [Failed missing output]"
>      err=1
> --
> 2.38.0.135.g90850a2211-goog
>
