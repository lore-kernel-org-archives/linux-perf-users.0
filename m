Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08713CF952
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221513; cv=pass; b=uPADgLrpzC9TUnuVNKGspZnEZ+AsgLv+SeKtyCmvqJdvwttC5ZtiEluZuccW+8QZuWxn04tGRHbmqBqIt0PbB1GQvbVdDg7l3Tp7bthJ1Z2Hzx3tOrDw4rAItJ/Eyza4oCx04LBtol1l99fL8103UnHswZYVQn6B7VmVKmz0SfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221513; c=relaxed/simple;
	bh=cblw2L3Lly1bfOrTwtv9wwW6sp0Yy1Z8DPipd+koq/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhEZCH0lNrg215504AOWZQJjSp19BAQS+uImEPiQDhrqnSF9xv0Q0+8txfI4yafm73q8dROb/ItCYfuTwIhbXbQAkhOaijL243KGYMTNOgK3ypCe+2wAi6wpw1XLxNNoMBOJufaq1O8fqVlhkF88+AOJsM021BerlytxojdJEJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctTpozxs; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctTpozxs"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-532e9ad9a1eso92261cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 20:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790221510; cv=none;
        d=google.com; s=arc-20260327;
        b=P5GDZmsR/NhOX6lE3qWIs+vaaB30uOo11GedyQuHh+wWqAyhyqJgq2x9x0lZnN/kVS
         zy+a3cKo5g2aA+HVbnGJwvreUyC92oUUMjS6npZxBzoV7RJ9dQdMDFYGydtjFjIoDD4Y
         P2eVpNH3lPtGW0QwtdCvyHY466w8rNLMzaKNFShzSYnxCsL+AbfTYiwUjr/wKu3VbfyW
         IZmYP+4isXieJPjT3g+Ztx3MOD2TS96g1L/z+UfCbLrkEBw9armqr2b1LWbRNaOt/hCk
         9HgfhT39kUd44qFU4WkbyTZFaLk2E6bs/qisBh6/J1VCBxxS0IvzNzqs0ZMs0sz/NJw6
         XqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahhn9Ixub6HpvaUVFMs+V5RjUmob1chtIW49SrIC0gw=;
        fh=bw+5hmOh6hVO/bS1NMkZY0EE43TeHjllB/Dxp58MgaA=;
        b=dY/GHvQW9TuFPJ22D9P/BP2eoW93upB1sPueet+Bp1K9T6Ss1jBI+w4Pik9+Hw+qJ9
         cxGYQqBdciEcoyQIfr2cweBhOhWgUIqzD7Vm4CnxAqqi6LWC01q77HfWcOhKbNQy9uqf
         Br3+ig1lXnLCIonOynp8w8AP0BtHpuI7IObR56j4gMh+ioLdjOGOFn8xmxTE3+RD1SnN
         00E0wqby5LJWX4ZsOZF/pvLsFPbyh05rCEiw780ArSR2vzfYzq6m4RyFU3dpx+FV0a0B
         DmKbEpIqJpYWJjCkm5jU3rDlAT3KMFc5VtyhigAjNAm5Nn6DMKFnCA3LWBDc3LXP3Jse
         yGsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790221510; x=1790826310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ahhn9Ixub6HpvaUVFMs+V5RjUmob1chtIW49SrIC0gw=;
        b=ctTpozxspoeTqXB7D4zTLPd0SUE98TwNTj6avf2dx7vEdmf871cDyJ3nXkTyefluZE
         /mxy3FgZTEheXIwJndaaURRKei9Aw80hO7dbQ5QO6Dl3SwIisV4j6uqSfCuvSWPoiecz
         6resvBHfJB04nKqlaaA7dRSVUpkrhnPdXv5Zeh8GPpZa6Q6FP6iDGxjNLHXXflLH4sYi
         ljHSKD1xpYq+QvsP3fzwF2re+iS1gxj94A72uR6NOOhjFVnig+RK9d6at8jewCkODZ6w
         AtIC7zyOucWNw3z35X3qYoxkZCfZo5lfiQ1OmjAD0rsxeJDswumpjCkiOXtTDHiES8qn
         webQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221510; x=1790826310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahhn9Ixub6HpvaUVFMs+V5RjUmob1chtIW49SrIC0gw=;
        b=Vjp9MajNDeIZUrxZQNMgY3ORm+etpXIjKSzcYfhy/Sqp0LH+I9vet2QXEzQCKRP09F
         tnFFIvzwZoO9WnZtKsDA3VeCk9j0O6oQ/59y2q0+Yf3eMzdi5rjBWaOvPlLeDAYdAKq2
         vrHapKltSNbElcauVxaU4rJXfL93VWXTGpVeHrGY8t9wOg0mVw941TFpfAxRE2t6BEAB
         S8MaAsWEaNdZZi5gk63xg16UgW2C3wwy4MWFcX4S1HvT0X/L88AD7HLnJV8BGXhJgLWm
         v8O3ozgkAM1q0647n3NvdgTNvrxNX33whP1B3Lq6ZxRYH/Jki/1LVitC891FWEbErSoA
         SSTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxznAAMSGdkalS9v1wzgnui5EgvbgVu+ydsMBSD9KGrq7hLaIo0G2smnRP9683pGfj8jFdKb7FH6u7rMjka5+lz@vger.kernel.org
X-Gm-Message-State: AFuF++moGCTcTU1b7grUZAgmwQ+lAVJKOTWgIxIs/zwhHeDqtchbOl+2
	HfDrTUgXrYOeCAm7wvN9u9nh7SnZddLgZMKAWXst7ZhiSjosPN7asIsHnDCAhOmDhBhanUYj95P
	7gG4Uk1oZul9RRIVWw/vvyfbT6g7KgsKNHxTUBhwz
X-Gm-Gg: AYBFou1/lc/5ydCw4nE31eW63EoPUjv/3lzU/YMImTH8PcoYg/2ZNgj5n27V9WLS5F7
	0Pkpz2ymHxwb8nXeHGAtCsaxpEGKY9dhSwvIjwt5CsTazUEWrWHazJn5XCy9zqoRFUpnww2zQ06
	oT+vOsmO+gKK7C9Zao2e5Pj4fcqXKK786ohTJXTGe0wijaYbZ88+O10AtYjUCBrLWWDg1LJHyxE
	VBVh700pRjrOF0s1kiUVUJYSAwQo9HWdFRPpwNN/RyM4y5ZLTwv8t8T84bP59W/2Gr2d8qcmpkk
	HstU2jre2BVlxveODMge+ZWbyFnrUOOMzr0ivoaodWZe5jbGoLfT2LA=
X-Received: by 2002:ac8:5907:0:b0:532:ad75:e432 with SMTP id
 d75a77b69052e-532fea67702mr2347951cf.8.1790221509874; Wed, 23 Sep 2026
 20:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923215255.3329181-1-namhyung@kernel.org> <20260923215255.3329181-3-namhyung@kernel.org>
In-Reply-To: <20260923215255.3329181-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 20:44:57 -0700
X-Gm-Features: AclHuK9-SW3SsPxggKRW-bBT7Xws5jnPdZXD9H9xBhIitaeMKg6WFdky4YeB22w
Message-ID: <CAP-5=fWX_LY-0de0=LPc2wPpvu7L70LL1zh0aocxGLopbWMqfQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf test: Fix record tests on hybrid machines
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Currently the leader sampling test looks for "cycles:" string to match
> the event and retrieve the value before the event name.  But it won't
> work on hybrid systems as the event name is different like below.
>
>   $ perf script | grep -m 10 brstack
>       perf 3322152 1873980.978431:     625379 cpu_atom/cycles/:      5582=
00cc40cf brstack_bench+0x31 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978431:     625379 cpu_atom/cycles/:      5582=
00cc40cf brstack_bench+0x31 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978598:     612177 cpu_atom/cycles/:      5582=
00cc4082 brstack_foo+0x17 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978598:     612177 cpu_atom/cycles/:      5582=
00cc4082 brstack_foo+0x17 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978762:     591859 cpu_atom/cycles/:      5582=
00cc403d brstack_bar+0x0 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978762:     591859 cpu_atom/cycles/:      5582=
00cc403d brstack_bar+0x0 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978948:     628505 cpu_atom/cycles/:      5582=
00cc403e brstack_bar+0x1 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978948:     628505 cpu_atom/cycles/:      5582=
00cc403e brstack_bar+0x1 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.979146:     669816 cpu_atom/cycles/:      5582=
00cc40e5 brstack_bench+0x47 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.979146:     669816 cpu_atom/cycles/:      5582=
00cc40e5 brstack_bench+0x47 (/home/namhyung/project/linux/tools/perf/perf)
>
> But we can control the output format of perf script using -F option.  So
> we knows where the period is in the output.  To filter by symbol name,
> "ip" and "sym" fields are required as well.
>
>   $ perf script -F period,ip,sym | grep -m 10 brstack
>       625379      558200cc40cf brstack_bench
>       625379      558200cc40cf brstack_bench
>       612177      558200cc4082 brstack_foo
>       612177      558200cc4082 brstack_foo
>       591859      558200cc403d brstack_bar
>       591859      558200cc403d brstack_bar
>       628505      558200cc403e brstack_bar
>       628505      558200cc403e brstack_bar
>       669816      558200cc40e5 brstack_bench
>       669816      558200cc40e5 brstack_bench
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 04df35b30b0c15fd..fa8d17e389a0116d 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -537,7 +537,7 @@ test_leader_sampling() {
>      err=3D1
>      return
>    fi
> -  perf script -i "${perfdata}" | grep brstack > $script_output
> +  perf script -i "${perfdata}" -F period,ip,sym | grep brstack > $script=
_output
>    # Check if the two instruction counts are equal in each record.
>    # However, the throttling code doesn't consider event grouping. During=
 throttling, only the
>    # leader is stopped, causing the slave's counts significantly higher. =
To temporarily solve this,
> @@ -549,7 +549,7 @@ test_leader_sampling() {
>    tolerance_rate=3D0.8
>    while IFS=3D read -r line
>    do
> -    cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"cyc=
les:") print $(i-1)}')
> +    cycles=3D$(echo $line | awk '{ print $1 }')
>      if [ $(($index%2)) -ne 0 ]
>      then
>        if (( $(bc <<< "scale=3D4; r =3D ${cycles} / ${prev_cycles}; r >=
=3D 0.99 && r <=3D 1.01") ))
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
