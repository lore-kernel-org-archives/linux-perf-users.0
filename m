Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3C38B
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552623; cv=none; b=Na4ltwK0KNUVNmbtG5xbafrASCI2gxfsLmQ2zrAWpeEetVd90GvnKPmCO4EI5xReL8ahHVqOIBW8zEAqWQG/bsCdZMZNsBCDTI7r1m1xxHB5+y3jc3FwZLsVjY9ezKM6wK4izL1o9gF2oR3+4n3WTm6qG5NpROUepAb6HHQcOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552623; c=relaxed/simple;
	bh=sWWwbfGZnMtusIB0fCiGSV1DGRh/FWKARAGxmZUfHqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4Ak1OVDeWoYUOsrCL1HP4Aebqo1EL4s+gvuH/Mw/A+X4JnsxP7jkyqe6KwY6IPfRV8qhZIyNnc2ZCzrEGbL0Y3ucUQla86Ot2+hY9fih6YLsrBXQ+mdamGWTLqKR862qog28u/Cl57OXiNIQewazV0FPoEMvr6HNSbr5j37nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnyjMCtj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnyjMCtj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-242d1e9c6b4so71425ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755552622; x=1756157422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlGqJIlxYa8JPzVYG9ATkkS2RNUZQWMskrpzXY/rMK4=;
        b=TnyjMCtjrDv8JQRYEQNIvCYKhr8S/K9N1+vqxaVFnPspNqztow8vsGFObbV3Wt8g8/
         w1lqmCk20AVnpwJrqyaanhsjxHflruAFgFPBNPP7wzSIc4h1l0FlP/zk9DsvWdzkF96V
         z8uisKK1aJNV+8pnDgu80YSBCtDZcLEg/faKKV9JZ7eEfwCGOPoOu/W9LfPAF7UILxEl
         Oa6pvMCI2VnGsqr4IvSE/kzfmAJZdinw6uFyj4XdWKLxhrmjaOPoKmtaUrnK9UWhW3RL
         S1Suwg1ii89rW1M27tmlRKyv/xA9inU2RJ0as//oM9oqnAVLbNy630hHIH1cxg1+6G4R
         ty3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552622; x=1756157422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlGqJIlxYa8JPzVYG9ATkkS2RNUZQWMskrpzXY/rMK4=;
        b=vvbysMsWL+KH4f4brnCDMpCqEwEDXPxBmpMUMKz9vGgGCo2Z8Z/hphAEm8DcLDMWwi
         hfWAp6hhn+3X9373l9bTe7W4O3tsVrN/caMa3V6oTqkREugbQnkWKynUCq5yVHSsYgWK
         zqcXNbmgfl6z9wbYFRpBV07jZ0meSuMPLzUZ40gzs9GTTUJezz0hlbV0tpl9rDCUnXzu
         qnVlEcocwpm3eGVAbcaEX+zFL0XBqQqg8k/Y+7sEnOuwDXEfKmASakYmZgTvtJMRYYHg
         +4CfOLV7FS6zvnvmOB+K24ZeISUHoEyFKQIY4tRgG8Ee+/Wv2/Ugxdq+C3l+oaGTt3Xu
         rrgw==
X-Forwarded-Encrypted: i=1; AJvYcCVD6RJfeCZlPvayOKBm5xSvLedUDvZTQ8CTS+IHRXXYZNmlETuGYSsgJAkl1+VglmmERoU00uj04j0jWISayCkA@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEWyqKDTQPv+WpMuKVm1u5H+qO/qqUTDCxK5giGHvb8z3gUV1
	Ri97raru7reBAHwayvzcgZQwthfDSDLlrn6FZXnCut1BIyclxfn6aFpPP8AjEBseuwoTBQnNOyR
	OuL0IQaVXGcHNFsxbUIqTNXHQD0Axm4HaTgai/WqB
X-Gm-Gg: ASbGncuED0Zi/oLMsE/8bSWTiibIM7yuQszjxcUpVZe0rcEdlueRvLlaPR6y4gCuzIx
	kC+Sw0wABuf3FxIxNgeAwfkwZnPOk6+SGAWuKYt3Jxs03IR4pj3VJ1p3Y1Mwq7nlAikfaHfShZx
	2bseB4JqXLxCNXRKJoBsQdjqyjAblUZdcTntAmZhA7Izwk6aiQfv6REu8Db9Hs+HYXeHUZdO9Ts
	SFG/ZxUZiQVPrwHhrGYCgd5fEVco6iXUye/KXI1znE=
X-Google-Smtp-Source: AGHT+IGpzjIX9dwiWXKMpvHQqGAMp7qHKE+kta0wJX1OObH6fa6pfTymKeTi3YH0pWOEbCdRHlIQ08sZYsqQ3QpK7nM=
X-Received: by 2002:a17:902:f549:b0:240:589e:c8c9 with SMTP id
 d9443c01a7336-245e00cd8c4mr568575ad.10.1755552621445; Mon, 18 Aug 2025
 14:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813033432.8943-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20250813033432.8943-1-zhaoguohan@kylinos.cn>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 14:30:10 -0700
X-Gm-Features: Ac12FXwNR5TecROABcdaMEakc_vF-IACGcE4lnxADtYA0Z1Lq05sdXbeGcof7dI
Message-ID: <CAP-5=fXkzoJJvn6h-dbTGvxkO3DEtGUfauTSZOAGPjcQMrFUpg@mail.gmail.com>
Subject: Re: [PATCH v2] perf drm_pmu: fix fd_dir leaks in for_each_drm_fdinfo_in_dir()
To: zhaoguohan@kylinos.cn
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:35=E2=80=AFPM <zhaoguohan@kylinos.cn> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> Fix file descriptor leak when callback function returns error. The
> function was directly returning without closing fdinfo_dir_fd and
> fd_dir when cb() returned non-zero value.
>
> Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM inf=
ormation")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> V1 -> V2: Added the Fixes tag in commit message
> ---
>  tools/perf/util/drm_pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
> index 988890f37ba7..424a76d1a953 100644
> --- a/tools/perf/util/drm_pmu.c
> +++ b/tools/perf/util/drm_pmu.c
> @@ -458,8 +458,10 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void=
 *args, int fdinfo_dir_fd, c
>                 }
>                 ret =3D cb(args, fdinfo_dir_fd, fd_entry->d_name);
>                 if (ret)
> -                       return ret;
> +                       goto cleanup;
>         }
> +
> +cleanup:
>         if (fdinfo_dir_fd !=3D -1)
>                 close(fdinfo_dir_fd);
>         closedir(fd_dir);
> --
> 2.43.0
>
