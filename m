Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61D24EF89
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280119; cv=none; b=Fje/SSKU47ZE5mGIuf/9DqfggxqjfS24xdjB8nLX9zekGQheKxp2AREbqd3GLwdT56BsYyPzwiViZQs3lxrNXlVdULDwMoFgTsNolnd5gedHluc3LKbATClB7f9+FxxeLnwtqYKuOgy7zShP9hDhfVITsod97kor5mUVho61boM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280119; c=relaxed/simple;
	bh=A1cLMm/rRtTJu3o30/XbaiexFMSeVAOcT21ZnNpF9HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjAODbCItyZ3k9sQsZIk0useQKNmxIw1pEYu7xWrcrSj43kgPEcHNWkfpP+vgyO5KBKOK2yvy1tlNJC+NgK8NyVv/ba8CGLKKkCiToXvFI49Js/FHlXns3BsJP3ZNPXn+WaAaNhgiw64Cb76bOhr7hcaSZYkq5nZJTfufRy5fdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g30lr/yk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g30lr/yk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2237a32c03aso150115ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741280117; x=1741884917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGPTfeCWeF4i6ufv6n34mMSCAIJVic/m06/TER4ZKg8=;
        b=g30lr/yk+kFGN7QTlEoaexiugPC6zifUe1VezYP8jqaHdsyrlV0nyvat01pa9gb5bD
         9rfSpeTz+k9RYT2l1khDw5vitnpkhCIYkvYE0cxVGq9RvZZjMY7Te4IxfcPZUDxPqCEZ
         DJGHYIvXFrvObvZQi2l8w5QtFYeFIm5C8/IM1TvoHhGMPT5LvfpqffCA4YeDIa1x0LjV
         j+Kk+RqoxwPlWKSq+QNYOAgNHdutLEj6AkxKT4PVJNOMGh+JwkyEcvgBEUS/6VYzIZKl
         ygsIQYsU3hT1EB1xq46VRC30/rA1XLd7A+av4xq0qTIk2PauhWMfUgnLU6dRHSNbxKw/
         zWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280117; x=1741884917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGPTfeCWeF4i6ufv6n34mMSCAIJVic/m06/TER4ZKg8=;
        b=C6cRJEhXj3WUt7cvB3J2KyBITGkzRmi3A8xf/kzxVZ2DuHM+UMuLLDz9YJa79kXnLM
         pgNMX6cT+f0ZmsI/bg9KxnLpjZaGT3X2Ij4mOGiBszKL24XM7jQPeIrIR4C9kQ00dYMw
         PWFXxquocTxDe8YCfchvCwB1B8pdIjP3rhBx+w5/PuG3Rx9pN13BgJ8vNWx4hDJRYvv2
         PmAXmuNQLl08Nysa5mOZCtBZ1XagKZIqrGpddu/lV25QwQvyKx8f9390NA+poccK9kJQ
         PMGQ0/jxGun8C0NMEjayT8kFq7vEu65F6XTBAVo37ghCeo7d4FaUpv6UrfVM6BpTUdz7
         q3AA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ISUgMaehPefWBTSxK6P1jfVaV1/cX1JQiN5zTUAy8Uf5Gw/SsJVfh4hGOG/dXVAYiMP9O3EEO1Lm6D7vPCzL@vger.kernel.org
X-Gm-Message-State: AOJu0YygV5O7GjwNxLo8rkdNdd0ne4aazqUyBguzrHpM6G+s1kwENatF
	LYJNm+jq7Qp4675Jw3ZuLzf9G6zjiEeRkBJDC4uXz8DYQL0hlHvMCz9oP2oiJUlgrUc+LQZ4cJD
	KdjJnm8dY74ezPSZUo4YfsCY354+NMeX25xPq
X-Gm-Gg: ASbGncv+Jqz/EDRLgMBhPurgyk79GIJv38XOyplid8elBPwynC53c8kxD76VNMiJD2N
	wPy46o9sM+J/cAJWoeczUpObgJeEjPeySczBi9Ds5nAAUjTOR7OMpS8EO0vJwLeGwzqYzL+lLX0
	A5T4w4tbSl4jEBbBr3P5hCHW6Pc4yYE9d9hkVevNkLNMpLTDSTcDov+5o=
X-Google-Smtp-Source: AGHT+IG7VYKcPSJdNPDtzXRMrhi3PHqP9/H7o2SFOhAfQZu8ErWsr2svswtqD0x0WBKS4GgmTFEyB2NO3kZnl42VbYI=
X-Received: by 2002:a17:903:1670:b0:216:5e53:d055 with SMTP id
 d9443c01a7336-2240e496477mr2665035ad.9.1741280117182; Thu, 06 Mar 2025
 08:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306075147.195435-1-namhyung@kernel.org> <20250306075147.195435-2-namhyung@kernel.org>
In-Reply-To: <20250306075147.195435-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Mar 2025 08:55:05 -0800
X-Gm-Features: AQ5f1Jro2absOUzAa1tYd-i-Ic6Yvfz43s385OY1qtm3Om5lPsqwFwr2Uif_sQY
Message-ID: <CAP-5=fW=Gs2ATy8DhcZFjGP5tcEemoZp9q=voFV8HRisY9ki7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Fix memory leaks in the hierarchy mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Ian told me that there are many memory leaks in the hierarchy mode.  I
> can easily reproduce it with the follwing command.
>
>   $ make DEBUG=3D1 EXTRA_CFLAGS=3D-fsanitize=3Dleak
>
>   $ perf record --latency -g -- ./perf test -w thloop
>
>   $ perf report -H --stdio
>   ...
>   Indirect leak of 168 byte(s) in 21 object(s) allocated from:
>       #0 0x7f3414c16c65 in malloc ../../../../src/libsanitizer/lsan/lsan_=
interceptors.cpp:75
>       #1 0x55ed3602346e in map__get util/map.h:189
>       #2 0x55ed36024cc4 in hist_entry__init util/hist.c:476
>       #3 0x55ed36025208 in hist_entry__new util/hist.c:588
>       #4 0x55ed36027c05 in hierarchy_insert_entry util/hist.c:1587
>       #5 0x55ed36027e2e in hists__hierarchy_insert_entry util/hist.c:1638
>       #6 0x55ed36027fa4 in hists__collapse_insert_entry util/hist.c:1685
>       #7 0x55ed360283e8 in hists__collapse_resort util/hist.c:1776
>       #8 0x55ed35de0323 in report__collapse_hists /home/namhyung/project/=
linux/tools/perf/builtin-report.c:735
>       #9 0x55ed35de15b4 in __cmd_report /home/namhyung/project/linux/tool=
s/perf/builtin-report.c:1119
>       #10 0x55ed35de43dc in cmd_report /home/namhyung/project/linux/tools=
/perf/builtin-report.c:1867
>       #11 0x55ed35e66767 in run_builtin /home/namhyung/project/linux/tool=
s/perf/perf.c:351
>       #12 0x55ed35e66a0e in handle_internal_command /home/namhyung/projec=
t/linux/tools/perf/perf.c:404
>       #13 0x55ed35e66b67 in run_argv /home/namhyung/project/linux/tools/p=
erf/perf.c:448
>       #14 0x55ed35e66eb0 in main /home/namhyung/project/linux/tools/perf/=
perf.c:556
>       #15 0x7f340ac33d67 in __libc_start_call_main ../sysdeps/nptl/libc_s=
tart_call_main.h:58
>   ...
>
>   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
>   93
>
> I found that hist_entry__delete() missed to release child entries in the
> hierarchy tree (hroot_{in,out}).  It needs to iterate the child entries
> and call hist_entry__delete() recursively.
>
> After this change:
>
>   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
>   0
>
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/hist.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index fbf131aeae7ffe9b..bbc6a299b5106c3b 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1385,6 +1385,15 @@ void hist_entry__delete(struct hist_entry *he)
>  {
>         struct hist_entry_ops *ops =3D he->ops;
>
> +       while (!RB_EMPTY_ROOT(&he->hroot_out.rb_root)) {
> +               struct rb_node *node =3D rb_first(&he->hroot_out.rb_root)=
;
> +               struct hist_entry *child =3D rb_entry(node, struct hist_e=
ntry, rb_node);
> +
> +               rb_erase_init(node, &he->hroot_out.rb_root);
> +
> +               hist_entry__delete(child);
> +       }

Thanks for the fix! A nit, iterating the rbtree of N nodes and calling
erase on the first entry, an O(log N) operation, means this is a O(N *
log N). rbtree.h has rbtree_postorder_for_each_entry_safe:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/include/linux/rbtree.h?h=3Dperf-tools-next#n81
```
 * rbtree_postorder_for_each_entry_safe - iterate in post-order over rb_roo=
t of
 * given type allowing the backing memory of @pos to be invalidated
```
which is O(N). I think this code would be better something like:
```
struct hist_entry *pos, *tmp;
rbtree_postorder_for_each_entry_safe(pos, tmp, he->hroot_out.rb_root, rb_no=
de)
        hist_entry__delete(pos);
```

Thanks!
Ian

> +
>         thread__zput(he->thread);
>         map_symbol__exit(&he->ms);
>
> --
> 2.48.1.711.g2feabab25a-goog
>
