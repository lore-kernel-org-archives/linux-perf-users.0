Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A7146585
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850153; cv=none; b=EZYClwOJ4CFxUkoN7D9RcpPEpJzaSxPHY4AvJXmmr+rkrbVTph8J5SwSqtUG6hYrbrGK9loTsQWus+JmSDLUM2/UJ9006YhBi0YEvO0mlb5zELEY/dfMVUMbg7azIxvXmhrBTYGCw1iit3tMqpEjzmbZFYUDtRU3ggosOpNHsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850153; c=relaxed/simple;
	bh=+O7bISEqVBf0751J7i6gKnbU6B3BplTUtsXYsCjQPmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMBW+UjpFNjqrMHKS7hCYwqctn8UrH1bpEOEb3KH2DQ4gjfUW1kF5/YDgwwKPo3RUn2auVgiP2/kL2q8LJ+NW1blvVFefwhELimQ7ur7qBKau46f6FUKXE6MBZZ9u+3uLHUekWaB4Yn0Lgtml9prs0A9WG/1q/5v0QmoY1hRtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kg2cGdUM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kg2cGdUM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so269235ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759850151; x=1760454951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlo69vXBzGlsQ45ur0452IkiksgpMlh1RM1fVkx9em4=;
        b=kg2cGdUMwBhUfTlf2kaeE3uOJ+85rJYDlj5cvEsR+Y1E/gfHQIxNeLgXMI7VgOmDsu
         j65a7itZ8uP2f6Q3MV2qqCKUvdSTzmpL/n7W4/XWB6YCtvkhezqQ/5ateDwxbt+GdMMy
         cemiNUV/SgNEW89IYmXLa57o4Bj/UWilthjArvYtw5Mo+S/dqXdYZ0xdw6BUNhaIZf6W
         vD8ELixYsool7fU4tkUAdzrgS4EaIyJO45Vlp7wWhUnKtVFhlFJCICb10hSxmX77XQd1
         1Wh4k/wMbByUu4w4nLKBPSfLiEpaTTX0KDcUUT/vSrpyyXfubmSjjRHCtyFFP/EDm2Qn
         NdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850151; x=1760454951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlo69vXBzGlsQ45ur0452IkiksgpMlh1RM1fVkx9em4=;
        b=pIZDFNZgreWIZxeo3N00SnIsSLVYsl+xGVUPnoRELI/VHaw8wtv7JCVZkjPQkaOOxV
         Q9e0PhyKwmedIOguDhk9RiUOlRBeQj355KCtebNt1YZB7Qpm1S0bWGJ3tDhBLrTdo+4t
         JNs9Kgt/+ANPNgRKuQtjas/Vr+LehtEtD8g2QKDPnOVKVANcvOP7s+06cOCG707eNfoB
         SuZAh9WGwyKe/+iWPLNeRfz+BRPVXz0nX/Hl7AjhCr1BuD1etTXBIYU+wA06pPBb3M+M
         4tLqitggimWaZm9r9vIzeb8cdnbg3pkGOAWSsEHkG5HXQkP4/cxuWBMyAHmgaThSiyGy
         Lskg==
X-Gm-Message-State: AOJu0YxT7HeNrd4TEQIoaTnhMXer/BBBWYo8+K3rlAFFWrYIJzC75Y9v
	hyZvDRXFE+v1Lkxjd060ohOk9cLGrFgcyFYo20sDoJxz8th2pesN3a5D9JZL77n+HbANVGO57A9
	ImCTlWcCKI80bEhTqKONwFIzw+npPqJL7e7bfMqbM
X-Gm-Gg: ASbGnct81sGQlitFCrsM/ku2aaNKXt5QmRgmqSg6MBqV2a+GiarcVdAAdk3wulFf7Td
	SB627Wro/KSHlw016aHff3JnU4TRFvwaq1Hih8fK/DnvOKBsxcs4Bd2lMcZwnWFRdcrBE4roxwQ
	X5vM/Z4QR/t8NBULKH0qzBMspGsJheVCWFAycVwESZmOIlnjyYYic/epilcopsczek1W3kHJm1C
	MLUtPUYyXWOhoLyomVnqrw2yoXeV18zglK2VmQMzMvk85aZfkIFXEJD1Vnonn9v7Jdw
X-Google-Smtp-Source: AGHT+IE/uOsOwUEeVYBrEonRjm9VvP1sGfvE+IsM5xAckvBMjr3635ZuUJOoKu8Y5u7PksTQSo+oq5sUdsj90Tf0J04=
X-Received: by 2002:a17:903:1a0e:b0:26a:f9c7:f335 with SMTP id
 d9443c01a7336-28ecb749b04mr4252835ad.9.1759850150956; Tue, 07 Oct 2025
 08:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007140909.307940-1-james.clark@linaro.org>
In-Reply-To: <20251007140909.307940-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Oct 2025 08:15:39 -0700
X-Gm-Features: AS18NWA_qSIjsZuAGkUFa-15Xd7pUMgLS5uE0fl0nS_c6et3z0hY7d_YvFzx-mQ
Message-ID: <CAP-5=fUfDtO5oVoxsCeYEuiE_kEYCOjU7tJjVS68nQ3cxo_Uqg@mail.gmail.com>
Subject: Re: [PATCH] perf tests: use strdup() in "Object code reading"
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, acme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:09=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Use strdup() instead of fixed PATH_MAX buffer for storing paths to not
> waste memory.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Applies on top of: https://lore.kernel.org/linux-perf-users/CAP-5=3DfV1N-=
j+f4GBFnDWsmoMZcz_k0U=3Dnu1A7NZz-g4gzCH4KA@mail.gmail.com/T/#t
>
>  tools/perf/tests/code-reading.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-read=
ing.c
> index 4c9fbf6965c4..88408eea9e41 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -43,7 +43,7 @@
>  struct tested_section {
>         struct rb_node rb_node;
>         u64 addr;
> -       char path[PATH_MAX];
> +       char *path;
>  };
>
>  static bool tested_code_insert_or_exists(const char *path, u64 addr,
> @@ -79,7 +79,7 @@ static bool tested_code_insert_or_exists(const char *pa=
th, u64 addr,
>                 return true;
>
>         data->addr =3D addr;
> -       strlcpy(data->path, path, sizeof(data->path));
> +       data->path =3D strdup(path);

nit: should really check the memory allocation succeeded
```
if (!data->path) {
   free(data);
   return true;
}
```

Otherwise:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>         rb_link_node(&data->rb_node, parent, node);
>         rb_insert_color(&data->rb_node, tested_sections);
>         return false;
> @@ -94,6 +94,7 @@ static void tested_sections__free(struct rb_root *root)
>                                                      rb_node);
>
>                 rb_erase(node, root);
> +               free(ts->path);
>                 free(ts);
>         }
>  }
> --
> 2.34.1
>
