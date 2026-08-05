Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E103DDDB0
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957568; cv=pass; b=L2blQD1JWdRQlYEDQKp/X2EoVvXwhcxavdaMg6VqklFNHWdTm7NT00dFOkKXRMX8Bscuz6J8owrFEy1Is0SjW7GU/KuIltjzS7vmYcC/BvmrbN2L01dV62wUB4k7x3pRBqzWA43IQ4xaKfVAbUdbKet2RqYWVUTcz4k37qhNtSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957568; c=relaxed/simple;
	bh=/B1xZSAAO5D7YAtStCOCKFuHN1+/9Tb8xfJ/6HWhDwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6LQEdqf5WeXbmBnNfKaCaaeVPqis7MOj/ztkdH/NJHWJyuIpoBR/2gC3xhPiH/q5wJrPkdVHfBhU8edf8jxlUJa5exd5G2/sdHxFvSYRZKbv1TDZTCTP3I7z++tpEIBtQKMLgDUXKMJzLzo0z+iIlM62uHbAcrlEKHqFXp0O60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGsctjGA; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGsctjGA"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10e86e52so47761cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957565; cv=none;
        d=google.com; s=arc-20260327;
        b=YPO8BGIYJ/m+BZ0u75DMvQjA7m30QSFkD19m9VV1y4v4w9JBoRGlfvf2VIscdx/zGa
         AL6236deyF7XjBz/j8yGylxdV0Yov0Y7PWCkz7eCM3a2PeAjyzgGM2Nr6/R+32k657A2
         oZMLEbtGmx0qM6g1y3tTn3COy0s8DVdlMCcc//maWrGTU2zMLq8jFI62lsfbKer6ZuEh
         5nodsG5t2YHDtJKP1UekhdXz2xonrpAexfK5i7Yyl9NdyACzJrjg/k7rRnQYzJ1r47eu
         P+UobUnoeCrbuRpT9F1VrU2IVOKct2DEW0KHhFXtGz//oIniHBUlDTyOkgJ5oSMfbyF4
         Ektg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I5eZ4pgZC3QRtGp70v91fmZC9aeE/wS/SnLY60OWaik=;
        fh=FJh0wTNy4NrTZtGZdDZ8sGx4OMGl5zsJ5CuN4KnPphg=;
        b=LqdD6qt/b7M6+ZJIDbszoPAB4UbbVS8nCL08HgqzH29k0AUV7tsZVcBdBejQeY5wfw
         26AAs3nBemJSaRaNyUoSMv2zcOLaCLP0AbqCXxoOAiN4ibjsKsqIj9VRgI5r18+LM52A
         p4fZKnHMXyZO34L4fAQUz6QPqlQqyzIzUDMgPL1JN/tkm7eWWWmDVWBFhcAOnY/x8D8E
         h9XbaavIOmVTNM0vMb0en6BBqkks6Zgis4vqlmJnQ+Xg5Vbxn+DBEWQR9bJKiBpnIfx2
         xcd+ddTPYvefhenpT5Bnup/yp9GuIK4oz2glaKNo6chWPPWd01AAk20A1yDN8Iw3+cFr
         t+8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957565; x=1786562365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I5eZ4pgZC3QRtGp70v91fmZC9aeE/wS/SnLY60OWaik=;
        b=YGsctjGAwrcA/idXHeMfLuDMNQLL1GFwpbXvX/u5UEdMs1jq7R5i/H9iTwdAIjB0WG
         K8XQkj5j4ceCCINarGTmpnahOf6mbalMwxb1RqZmyznOv/+BUaNfmko9FYmKvMIw1ADl
         evJHovKXu0CofCFqwymyquG3vUXcMO8kLv6whCGQA7Fdpoj/+752CbsECAcrE46MmWH0
         sAcVc5Z+F0emXVcwKqZvsZ6z1dfVKhoqOeLgxrbBFOKr4gmGeUKGV/WM7qvksn17xZyK
         /mLR+bEjo1UEi4qjqwjyR7cFzbMfRZr9StBtH/mg5dcXFcQYHWSSND8fb2QYLiy1/Hv2
         4/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957565; x=1786562365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5eZ4pgZC3QRtGp70v91fmZC9aeE/wS/SnLY60OWaik=;
        b=iW/ymH8mpzC0252zbCcgdY6PF8s/eH2cWVDnDKJcjyYyqIO4H93qCNXpUYv9UMgZfE
         n0jeSk0RyjotWDLRq/HwdcQFm70Cnj2d4RXmLaSPHYfLpyrIREPCqtQ/xXfFe58yetMh
         stBGLGbwHaKSRUk20AB0NODN1zjQzLm35L5a09cD1trWpX4hbdTyD37vNXUpNSXCQeT5
         CyOO1CjRJiMLr8ttBkYmK50Sir0JztZnaSz6gKf8vR3hA39aMXeoja7JMBp6D3lfMU1S
         NPwwsMBBSQor1Hc/QfvISUk+59mAvDtR6CvWo0CIch3NwVbLRxESZKD2i6fPzvWr2mky
         lFQA==
X-Forwarded-Encrypted: i=1; AHgh+RoVZYLoKBaHJA/MLnGxBRWzeCX9ei14kgRK5sWfCOuPFfRTGz+ZnU0R74FHIMndx7oTsuUUYLULzW5ETkySgfBa@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxDKgRD48CGK2cOsJ9bhN00ysmW1gSgXlUZxZ77wW25bfozD0
	SZRQM9A3n9EsEro3Mkma4wWhEcrU9PllrNyCfPJKe08NFoOXrHXPtaRbNEccngm+Kap/Cv3EWAu
	7VBHS+1KT+2sm6Fj2Mz92DL9bh/BqSjkmk06MeqRj
X-Gm-Gg: AR+sD13q51RijlUvEop/bNN4qyk+btQZvFW0wNvaAbGCCQyfvEjpSZAqYMcA/YYhQYO
	ZewxziZIsCJPxTdfvgkqnggt4s7mfRz3oF/3gqiF5aI09Qqi8+eX3IIAQeXu6GA5AN4IWM9AJx4
	cgbye77uvTGO+BTVfQBmy0VQMXshKBXEZVtWCd8puYju63QCCQti5ZttQlyZXls7hvPubgJNjTt
	KLlP7jMXELv772FLCxYHTLBREcC9MqkQsDEYxA2YBvdToj4YofexWI6VLVrG+6Wq2EyJpTtwqtR
	A4ksABLXjJMExiQhhmhRVfBmvMq1L/IDpk3NZdppqJv9R5QrJiHdzbYk
X-Received: by 2002:a05:622a:314:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52cfc06c2e2mr3382721cf.1.1785957564878; Wed, 05 Aug 2026
 12:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-11-acme@kernel.org>
In-Reply-To: <20260805133013.235016-11-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:19:13 -0700
X-Gm-Features: AUfX_mweQ8yIutEySoz3oOC8I6kSq7GChHRed7HGmfWS8uh6zopuqOi6UQsiJAQ
Message-ID: <CAP-5=fUZU6um4s4z38DVuschE1_BFaGqp09kCC_Kj=ibM-bGfg@mail.gmail.com>
Subject: Re: [PATCH 10/12] perf jitdump: Validate debug entries on native
 (non-swap) path
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The bounds-checking and nr_entry clamping added for the byte-swap path
> only runs when jd->needs_bswap is true.  On native-endian files, nr_entry
> passes through unvalidated to jit_repipe_debug_info(), which stores it
> as jd->nr_debug_entries.  Downstream, jit_process_debug_info() in
> genelf_debug.c iterates nr_debug_entries times via debug_entry_next(),
> which calls strlen() on each entry's name field =E2=80=94 a crafted nr_en=
try
> causes OOB reads and writes.
>
> Add bounds-checked iteration in jit_repipe_debug_info() that validates
> each debug_entry fits in the payload and its name is NUL-terminated
> before calling debug_entry_next().  Clamp nr_debug_entries to the count
> of valid entries.
>
> Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 02840dbf8a1fc16c..87612ef3e232598e 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -694,8 +694,10 @@ static int jit_repipe_code_move(struct jit_buf_desc =
*jd, union jr_entry *jr)
>
>  static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry=
 *jr)
>  {
> -       void *data;
> -       size_t sz;
> +       struct debug_entry *ent;
> +       void *data, *end;
> +       size_t sz, valid;
> +       uint64_t i;
>
>         if (!(jd && jr))
>                 return -1;
> @@ -715,10 +717,25 @@ static int jit_repipe_debug_info(struct jit_buf_des=
c *jd, union jr_entry *jr)
>         jd->debug_data       =3D data;
>
>         /*
> -        * we must use nr_entry instead of size here because
> -        * we cannot distinguish actual entry from padding otherwise
> +        * Clamp nr_debug_entries to entries that actually fit in the
> +        * payload.  The byte-swap path already does this for cross-endia=
n
> +        * files; validate on the native path too, since downstream
> +        * jit_process_debug_info() iterates via debug_entry_next() which
> +        * calls strlen() on each entry's name field.
>          */
> -       jd->nr_debug_entries =3D jr->info.nr_entry;
> +       end =3D data + sz;
> +       ent =3D data;
> +       valid =3D 0;
> +       for (i =3D 0; i < jr->info.nr_entry; i++) {
> +               if ((void *)ent + sizeof(*ent) > end)
> +                       break;
> +               /* name must be NUL-terminated within the payload */
> +               if (!memchr(ent->name, '\0', (char *)end - ent->name))
> +                       break;
> +               ent =3D debug_entry_next(ent);
> +               valid++;
> +       }
> +       jd->nr_debug_entries =3D valid;
>
>         return 0;
>  }
> --
> 2.55.0
>
