Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712D770FD;
	Tue,  6 Aug 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967113; cv=none; b=c69XMXQsB3SBIryVODANyOVaV4ynjnyHB0ezYNyIC4Rvu0cOGXZ5meDW8+nAiZRSMa+P4V35vw5bJma2wdqpZx7twCEW+FfvUCnhUB8sMW8VoJipN7AcuBJW7IoZ38UWywIwDGV2b7vLtN4ABiXfCFFCZm3sFTuf94ESXj0teQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967113; c=relaxed/simple;
	bh=/KIR/gZKpDzorl3qERaU8QNHl3C8rqIrcVVnAyuL8V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmRfr7tQEoTXbnXmXq1yuaoUETjocGCAsTVEtwj4SLQs5IRCIgvc8bm4O+1Nf7uZzJ6+3Zt77NWR5/StkDKTulU7+os2C2TskG+pt1PcOtqWfWKWPdGx+EtBo5HDYoe1IZqHl5xTiuLUIbfhpSyBro8S4jsHW6shps+AAjBnhY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso805497a91.3;
        Tue, 06 Aug 2024 10:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967111; x=1723571911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY5hbZeMbwhXSfDbd/rGzVmx+p5Ai/BI0gEowB/sd04=;
        b=WTvZYJ0OSWyMp6Kf+eUQO6aIoPgW/tcLv3x7GMR9TLDO4lHSegcrDcGRj32PDBw3ho
         2UUZZVub73SwbiGmRXvxkg8msBz6vOWSLPVEi+YuZv2Apa+kMVyMigMiz7IFi7M8R+J4
         ncqj3Zc0isQMxl3DPHQda6jueQML2aFoEkTuMutpkIPg7X4sWIuzw83NqzFZLGc8+z+f
         5/QH5RCZbGzPh4G3G5erUjZOjvDgJC8i8wSnxGRGkZ5jxqb0muarFF0F0vwDSUUG/3Vh
         WdkgS8zeyrSzPCYl19Np7C0gRfbbQyoUAM33/8absvtmx/b3HhHnkLjzWEx4NUoXVXQC
         tF7A==
X-Forwarded-Encrypted: i=1; AJvYcCVRE7J7fqLnaPo3+KIGXZb1qUAtAnU2WnC73T7sJ2UnMb5dJaTOmLvK05kQ4cwLMElBDLrYImynIDeGSxpdLeh9Zf8GkQEEAkj6IwQSXb6b2qGvw60ocMvXlNkNk4OmrsVexhyy7PQQZnlkaV9KJQ==
X-Gm-Message-State: AOJu0YxD/1yGRivJvdP1w3qIVRRa2+bchLC4hUiNrbX5oq7WvYKWxEeh
	vuoaSVm83/60jyRwYKdIn0Zi7tq/qw37OSzRr2EXJG6BVIJgpxuoEq3DmIvB8853wl7DEOF0p60
	YDpP0BCdoLdTSk5+LSmTslD/sbGc=
X-Google-Smtp-Source: AGHT+IForZwiPRH0kD/aF8JllfkH6X0668xxvxtoLs8E6LzeI7w5bwBziec4MPX1Z0sC0ipbvgKMl5AbMCOW9CA4y9E=
X-Received: by 2002:a17:90b:4f91:b0:2c3:40b6:293b with SMTP id
 98e67ed59e1d1-2cff95511a9mr19791633a91.39.1722967110895; Tue, 06 Aug 2024
 10:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
In-Reply-To: <20240806114801.1652417-1-yangjihong@bytedance.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Aug 2024 10:58:19 -0700
Message-ID: <CAM9d7chhR+jsi6HZ8_xv1BwEuwOKo_87jy_jekmYjZHA+b96Ug@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf: build: Minor fixes for build failures
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add Leo to Cc.

On Tue, Aug 6, 2024 at 4:48=E2=80=AFAM Yang Jihong <yangjihong@bytedance.co=
m> wrote:
>
> This patchset contains minor fixes for build failures when statically com=
piling in Ubuntu 20.04.
>
> Changes since v1:
>  - patch3: Remove UTF-8 characters from build failure logs
>
> Yang Jihong (3):
>   perf: build: Fix static compilation error when libdw is not installed
>   perf: build: Fix build feature-dwarf_getlocations fail for old libdw
>   perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
>     undefined
>
>  tools/build/feature/Makefile | 4 ++--
>  tools/perf/Makefile.config   | 2 +-
>  tools/perf/util/dwarf-aux.h  | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> --
> 2.25.1
>
