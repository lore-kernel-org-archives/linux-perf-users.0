Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1C14198F
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888425; cv=none; b=nkfyASIutWQLrU4NkW3kmszph5aMbzB48JFWilCEO/VtuVSfTrqYq9ZiWaQcBE7/NveTm34Ug1OxMBmyhZmywp+EulpNBm9mNestkvShVgNphXTf49PJrbs/Z3/bhomZNlBkAS1nnpIA3xDefv93OqqFn5iSHDwbyrXkWHsrZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888425; c=relaxed/simple;
	bh=I/5cEXnXfXecm8Vpm494QcOnK381qggbTUU9ew5P+7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKyyYDhu5A5y9MBNTzzxUbNLvqZ52gw3wpDqfCZ7g1lQtTLDgEdW/F6J7ickyyW57adTMe9aRDFZpBXUMi+EhYpGbARDlz/Ec23ePJhNVOgAUCJ5B9YmHvgcgWHMDh+2i+K7z24LIGEbO5a7BJfCJoAV+KVIxuvvtlEXfmGblM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwAqxYJS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwAqxYJS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93b982761so217775ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Feb 2024 07:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706888423; x=1707493223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4ALzc52MUp0xsJuOuNKwtNjRqGPUBBZ7w0ggAt/c6A=;
        b=YwAqxYJSB/4LLspUrzXogWBoq3y5U4iJPuQJmY8XBa98Sj/HUc3fmOsfZCCn7zmmTa
         Fv8FtlPoaJ50M/v90apWw7APuCoPfee5b8JCLF+bJWmzlYyL9HSuyjRTXR/9zvxPBvvW
         TMMAuvGcRaIG8MwKkqApFJceR9R2xoVIQvuToAqYdOe77D0yOh1eYto34SgwjyjNflAG
         Of6bhdH5wL7yetFCLb/eBWscm1ocSQJVsBM0zRl7nbH08HjdnmoMCJBznEmHqiZ1BjJm
         K0Uokh0fRCFsbfVsPUFN+C6t8ya0eAxJ21SlbVAr3KTQue9G/yq+p5tXJEWGWZB7h4BO
         SPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888423; x=1707493223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4ALzc52MUp0xsJuOuNKwtNjRqGPUBBZ7w0ggAt/c6A=;
        b=PKjxb3iOVG5ap4MuWgsZnbVxiVApp/Yd0akPHWgrCJ4gDRFHlw1T5lUaJMSnquHlx2
         0rNqvr6AGzLGbsD8lRrbUZn5fbY0R4VYVOtW1ZLJJ9Y98jvLBoIqr24EeoHa9MJu2i67
         WJ6strnEQbCEK5lER1eH16yN4FpNp15HsagpAu3QwDWfpT5p//5EHIqpm5s2PpMwcoda
         ONomg/t9RUbM0AaCVcXXtaVZQvA9TwM6qOWO80BUAEq4/dskyC06FY9djsuI+g3DlpZs
         uTaTbuYUhdADBcCEyVUoywCRw66wymtjbCCVUXtLj34v+3bo4Fn3ylYArR5XK9fsH+kg
         fWMw==
X-Gm-Message-State: AOJu0YzebMxHviqG3x3VdvHgoQpVSl4MDVm2MKLbpaKYH1ZtHI8rM98I
	ZdOMdZZHNwULiwY7HW2e/v5fSocm4pFY1B8r+h0edX6c29jC0XrSeYeNDi8aYsAtdxioJ/3ujIz
	PLmaqvyOc1ufN1hfBNC06/x2c59k/3o6MvePl
X-Google-Smtp-Source: AGHT+IEjryog0R7Dnr+EJN2Y967Il12ITFkFDEmagWwY75a5uUW/AtcoQWfEnHsuiDM2W2Sivu27ieKqIoO/bkc2718=
X-Received: by 2002:a17:902:fa43:b0:1d9:760d:31c1 with SMTP id
 lb3-20020a170902fa4300b001d9760d31c1mr18591plb.23.1706888423356; Fri, 02 Feb
 2024 07:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbz89KK5wHfZ82jv@x1>
In-Reply-To: <Zbz89KK5wHfZ82jv@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 07:40:12 -0800
Message-ID: <CAP-5=fVcbhm2yrAHM=O+7DwtK75FV7NWdG97VbSRrOiUWe9WgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf: Clean up the generated/copied vmlinux.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@arm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> When building perf with BPF skels we either copy the minimalistic
> tools/perf/util/bpf_skel/vmlinux/vmlinux.h or use bpftool to generate a
> vmlinux from BTF, storing the result in $(SKEL_OUT)/vmlinux.h.
>
> We need to remove that when doing a 'make -C tools/perf clean', fix it.
>
> Fixes: b7a2d774c9c5a9a3 ("perf build: Add ability to build with a generat=
ed vmlinux.h")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Yang Jihong <yangjihong1@huawei.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 27e7c478880fdecd..51ac396ed9f641af 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1157,7 +1157,7 @@ bpf-skel:
>  endif # CONFIG_PERF_BPF_SKEL
>
>  bpf-skel-clean:
> -       $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETON=
S)
> +       $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETON=
S) $(SKEL_OUT)/vmlinux.h
>
>  clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-=
clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bp=
f-skel-clean tests-coresight-targets-clean
>         $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-=
archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> --
> 2.43.0
>
