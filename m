Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C7363
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660756; cv=none; b=FmWBzfbZ75qY/Flp+8n7GqkiB7hhElxD6Z5KTxIJ7faejA3rkmX4AzbLVNu2S9LVT8/G1Zk9M1416L/tA0yIShMUBMIByCpG6f84SEMGmYm8QnCIxJquWPSezJ9MAEGsHMjz1Rah20bP/qT0wqd1+8F9MQElezybpNurSuMUl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660756; c=relaxed/simple;
	bh=pPgoFpHS09qFEfDbDB9fpNQ0X0z7bRkxAPU+5BHe090=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsIv4dYRpbxPrW3vamOA632zgaCV1BxD6rbLroG9sftQM4TfUiMw+J9oNnPA1ocF2OiyrqYjGyREEr0piktFAWgb7eExVbUGjsXO2cxmd5bJ0FPLWXeKPTiCGk0Ezggj3Kg+oMslpmjSIk/EW0xfvpPSQnZ+QUA7DwV2EQe3BLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290da27f597so2331825a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 16:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706660754; x=1707265554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFrRZRLSUyOF/04r3IOi+vxcEJLTM8xPX1QaYJdaYXA=;
        b=jdf4Dxc0yhusI8VJSZY84hdi4foKOcjl8sAs9l0xk3QD8i6zQ7A1Za8UC8ZJviZzFG
         9kwG7DLXHZi6nATfOassxXjOvnUaAUvfAM+N1kux95WZUEV5UauJDi7Nl1se0T6X01So
         +SISyoA9Spzdjx5IxpetZbeOrXPwuKkaI49YlKsxS2OLW5QY05VHFGIa7LILzQmReNWs
         0A1DgtPy7a95ubRSec2oDkh6FENsWqLmo5Iz4N3/xRCK0cY0BB8TKmGGn3gPlhfhI2zy
         ijp3RGM9b5FbKBF+bYqAoNb5yJZe6ypclp1Ei/fUHDzjqVxMnhVbwbM4F2BK5iUhD9Wx
         fcwQ==
X-Gm-Message-State: AOJu0YwIPv4jJU6oAVmmjnPph7jllN1uh/an0L5BZ5Obsn0wDBo3FfAP
	XIiayw+z7E/bOG/zSuCkWgclOWil+XXHoVBKioBAlLlxgQtq3BfL+IqnM2RaC0qymMzmkIYcdms
	mVmgPdCIJipOG8k6zbh03S7W6neo=
X-Google-Smtp-Source: AGHT+IEePkfW36AjEM/0YJRDKvsYSGxV3NPzWJW/vUttKN1RPzynb2KQAWFxvNgmUEqNQIJbSgiPmB3Kzq3QEXwyzyU=
X-Received: by 2002:a17:90a:ec0b:b0:295:cb59:508f with SMTP id
 l11-20020a17090aec0b00b00295cb59508fmr231683pjy.44.1706660754438; Tue, 30 Jan
 2024 16:25:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130185626.150679-1-ak@linux.intel.com>
In-Reply-To: <20240130185626.150679-1-ak@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 30 Jan 2024 16:25:43 -0800
Message-ID: <CAM9d7cidBn0sg0xHHL+Vv-NfvfQ4srrcuHMrbkYoT+Yinz_tpA@mail.gmail.com>
Subject: Re: [PATCH] perf Documentation: Add some more hints to tips.txt
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:56=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> Add some (hopefully useful) hints to tips.txt
> Also some minor corrections.
>
> Would probably good to make it a reviewer rule that if generally useful
> options are added the patch must add an example to tips.txt

Sounds good.

> ---
>  tools/perf/Documentation/tips.txt | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation=
/tips.txt
> index 825745a645c1..e85d2bd4f6b2 100644
> --- a/tools/perf/Documentation/tips.txt
> +++ b/tools/perf/Documentation/tips.txt
> @@ -2,6 +2,7 @@ For a higher level overview, try: perf report --sort comm=
,dso
>  Sample related events with: perf record -e '{cycles,instructions}:S'
>  Compare performance results with: perf diff [<old file> <new file>]
>  Boolean options have negative forms, e.g.: perf report --no-children
> +To not accumulate CPU time of children symbols add --no-children
>  Customize output of perf script with: perf script -F event,ip,sym
>  Generate a script for your data: perf script -g <lang>
>  Save output of perf stat using: perf stat record <target workload>
> @@ -12,32 +13,52 @@ List events using substring match: perf list <keyword=
>
>  To see list of saved events and attributes: perf evlist -v
>  Use --symfs <dir> if your symbol files are in non-standard locations
>  To see callchains in a more compact form: perf report -g folded
> +To see call chains by final symbol taking CPU time (bottom up) use perf =
report -G
>  Show individual samples with: perf script
>  Limit to show entries above 5% only: perf report --percent-limit 5
>  Profiling branch (mis)predictions with: perf record -b / perf report
> -To show assembler sample contexts use perf record -b / perf script -F +b=
rstackinsn --xed
> -Treat branches as callchains: perf report --branch-history
> -To count events in every 1000 msec: perf stat -I 1000
> -Print event counts in CSV format with: perf stat -x,
> +To show assembler sample context control flow use perf record -b / perf =
report --samples 10 and then browse context
> +To adjust path to source files to local file system use perf report --pr=
efix=3D... --prefix-strip=3D...
> +Treat branches as callchains: perf record -b ... ; perf report --branch-=
history
> +Show estimate cycles per function and IPC in annotate use perf record -b=
 ... ; perf report --total-cycles
> +To count events every 1000 msec: perf stat -I 1000
> +Print event counts in machine readable CSV format with: perf stat -x\;
>  If you have debuginfo enabled, try: perf report -s sym,srcline
>  For memory address profiling, try: perf mem record / perf mem report
>  For tracepoint events, try: perf report -s trace_fields
>  To record callchains for each sample: perf record -g
> +If call chains don't work try perf record --call-graph dwarf or --call-g=
raph lbr
>  To record every process run by a user: perf record -u <user>
> +To show inline functions in call traces add --inline to perf report
> +To not record events from perf itself add --exclude-perf
>  Skip collecting build-id when recording: perf record -B
>  To change sampling frequency to 100 Hz: perf record -F 100
> +To show information about system the samples were collected on use perf =
report --header
> +To only collect call graph on one event use perf record -e cpu/cpu-cycle=
s,callgraph=3D1/,branches ; perf report --show-ref-call-graph
> +To set sampling period of individual events use perf record -e cpu/cpu-c=
ycles,period=3D100001/,cpu/branches,period=3D10001/ ...
> +To group events which need to be collected together for accuracy use {}:=
 perf record -e {cycles,branches}' ...
> +To compute metrics for samples use perf record -e '{cycles,instructions}=
' ... ; perf script -F +metric
>  See assembly instructions with percentage: perf annotate <symbol>
>  If you prefer Intel style assembly, try: perf annotate -M intel
> +When collecting LBR backtraces use --stitch-lbr to handle more than 32 d=
eep entries: perf record --call-graph lbr ; perf report --stitch-lbr
>  For hierarchical output, try: perf report --hierarchy
>  Order by the overhead of source file name and line number: perf report -=
s srcline
>  System-wide collection from all CPUs: perf record -a
>  Show current config key-value pairs: perf config --list
> +To collect Processor Trace with samples use perf record -e '{intel_pt//,=
cycles}' ; perf script --call-trace or --insn-trace --xed -F +ipc (remove -=
-xed if no xed)
> +To trace calls using Processor Trace use perf record -e intel_pt// ... ;=
 perf script --call-trace. Then use perf script --time A-B --insn-trace to =
look at region of interest.
> +To measure approximate function latency with Processor Trace use perf re=
cord -e intel_pt// ... ; perf script --call-ret-trace
> +To trace only single function with Processor Trace use perf record --fil=
ter 'filter func @ program' -e intel_pt//u ./program ; perf script --insn-t=
race
>  Show user configuration overrides: perf config --user --list
>  To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid=
-cache --add `which node`
> -To report cacheline events from previous recording: perf c2c report
> +To analyze cache line scalability issues use perf c2c record ... ; perf =
c2c report
>  To browse sample contexts use perf report --sample 10 and select in cont=
ext menu
>  To separate samples by time use perf report --sort time,overhead,sym
> +To filter subset of samples with report or script add --time X-Y or --cp=
u A,B,C or --socket-filter ...
>  To set sample time separation other than 100ms with --sort time use --ti=
me-quantum
>  Add -I to perf record to sample register values, which will be visible i=
n perf report sample context.
>  To show IPC for sampling periods use perf record -e '{cycles,instruction=
s}:S' and then browse context
>  To show context switches in perf report sample context add --switch-even=
ts to perf record.
> +To show time in nanoseconds in record/report add --ns
> +To compare hot regions in two workloads use perf record -b -o file ... ;=
 perf diff --streams file1 file2

s/streams/stream/

> +To compare scalability of two workload samples use perf cmp -c ratio fil=
e1 file2

s/cmp/diff/

Thanks,
Namhyung



> --
> 2.43.0
>
>
