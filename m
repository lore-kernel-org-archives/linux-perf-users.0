Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B1C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Oct 2022 23:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJTXwa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTXw3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 19:52:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB37229E5F
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:52:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e18so1132686wmq.3
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pnqK2ps8JvrXXGDBlqjstYuKdyyRp4pZ+7d+0HhxAN4=;
        b=Ahy164ud4d1v9vY9Vlg+VAfQoLSlsObqKosgYRZ8mCdCLvjJFgr7YEMlZc/9hPHYSW
         15xvz0CtAPHUzXW8QqrdPBESCvHWvawMqGHQbrib47vxILev5+xwcOdDUaEaLBOZf1Nd
         xADuPX8PV0Nc3QzFjKewxo4zUNyDgC0pOh9X7xisAzN6uhN+8DFeh8yDQS7QaOMWL12h
         PTHiw1Lv14KB1vrV71xUpVbZp0hgz2rnM7jR+IHaaqx7fPlNY+uU42yR5+swJgrB14Nu
         7GKFopOteR8YSpHmLnngZmx7gGj0FX5fB96thjl4rxXrD45nqxLOeDdrw0kFaQqQgl+Z
         ejnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnqK2ps8JvrXXGDBlqjstYuKdyyRp4pZ+7d+0HhxAN4=;
        b=wfywf5Y2Z+rvKzVSMouaP9cuf2Wi27tSDX1jZRUWnuyMV/bnkc+Zr9BghzzFS+x8cm
         6T7Eatnivxhx1cFf3ndr8aNjIAPj/Ul7bJ2YPemjbvSYCiJjwRcyYEOa1Rz+lxnI7Oax
         nEXFI+2oDSlfQ6Z4FQGfzt5xjL0vM372O2940XiS36tNWZl+CB5mGJzHaB1XbkUVz7qi
         HOTsl/AiJ1vxrpODq1w5GCpqTAfGp6jc2qPKDv2ANZZBk15Txh3IQv791p2DZ1iGiVq9
         jTHPvP80B3fo0TQxYcUq1vNDGZhZr31UqXsbVfSUNW6Akln6p2591Z125qWijqlZtYpI
         ZL3Q==
X-Gm-Message-State: ACrzQf3HQNPmKF1nIF4lgKIfWmLevn/KYobVKO3xUzmKXIW7ceaXjXLi
        OOorVDuusThnrJ9dTrCxhlqYlcxZY29qy7qcVdsKmQ==
X-Google-Smtp-Source: AMsMyM42egusWMMznBTbFDhyA8QnDSVqVIZ5NPEet60tGYlD8F92gO9XSNST4V3Zks3DwsB3+Lm8gR49RrLTmM0sVoI=
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id
 u12-20020a05600c19cc00b003c6fbb9caabmr12672576wmq.182.1666309946032; Thu, 20
 Oct 2022 16:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-4-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:52:14 -0700
Message-ID: <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
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
> If the system has cc it could build a test program with two threads
> and then use it for more detailed testing.  Also it accepts an option
> to run a thread forever to ensure multi-thread runs.
>
> If cc is not found, it falls back to use the default value 'true'.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

I wonder if these utilities should just be built into perf to avoid
the cc dependency. Perhaps we can have a hidden option built into perf
test.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 64 ++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 464071462809..952981481239 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -6,10 +6,17 @@ set -e
>
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> +testsym="test_loop"
>
>  cleanup() {
>    rm -f "${perfdata}"
>    rm -f "${perfdata}".old
> +
> +  if [ "${testprog}" != "true" ]; then
> +    rm -f "${testprog}"
> +  fi
> +
>    trap - EXIT TERM INT
>  }
>
> @@ -19,9 +26,56 @@ trap_cleanup() {
>  }
>  trap trap_cleanup EXIT TERM INT
>
> +build_test_program() {
> +  if ! [ -x "$(command -v cc)" ]; then
> +    # No CC found. Fall back to 'true'
> +    testprog=true
> +    testsym=true
> +    return
> +  fi
> +
> +  echo "Build a test program"
> +  cat <<EOF | cc -o ${testprog} -xc - -pthread
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <pthread.h>
> +
> +void test_loop(void) {
> +  volatile int count = 1000000;
> +
> +  while (count--)
> +    continue;
> +}
> +
> +void *thfunc(void *arg) {
> +  int forever = *(int *)arg;
> +
> +  do {
> +    test_loop();
> +  } while (forever);
> +
> +  return NULL;
> +}
> +
> +int main(int argc, char *argv[]) {
> +  pthread_t th;
> +  int forever = 0;
> +
> +  if (argc > 1)
> +    forever = atoi(argv[1]);
> +
> +  pthread_create(&th, NULL, thfunc, &forever);
> +  test_loop();
> +  pthread_join(th, NULL);
> +
> +  return 0;
> +}
> +EOF
> +}
> +
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  if ! perf record -o /dev/null --quiet true 2> /dev/null
> +  if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Skipped event not supported]"
>      if [ $err -ne 1 ]
> @@ -30,13 +84,13 @@ test_per_thread() {
>      fi
>      return
>    fi
> -  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
> +  if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> -  if ! perf report -i "${perfdata}" -q | grep -q true
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
>    then
>      echo "Per-thread record [Failed missing output]"
>      err=1
> @@ -62,7 +116,7 @@ test_register_capture() {
>      return
>    fi
>    if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
> -    -c 1000 --per-thread true 2> /dev/null \
> +    -c 1000 --per-thread ${testprog} 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
>      | grep -q "DI:"
>    then
> @@ -73,6 +127,8 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>
> +build_test_program
> +
>  test_per_thread
>  test_register_capture
>
> --
> 2.38.0.135.g90850a2211-goog
>
