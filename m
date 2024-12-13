Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209F1E5702;
	Fri, 13 Dec 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113226; cv=none; b=g3p9k/Z6Ch5pn0ExQvPoe0P0vy4B82NF+1BA2Qcn2MWWdmpTuQhug0ziZqitdeCm2OapOE+JjOmlAxouqwU3uiRjGqxvD6dxgZXg+g9DEgFK7i42jEGZnzNcBzwv124XjVwDLt1BL0duQ9Bkd++R2MjpHPiMtTiT/zcXIaHSQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113226; c=relaxed/simple;
	bh=y76mljT7nOJZX+9smI4E5kVDv3j7iyA7b79w8knGirA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPKouUsJEgUTRybCd9C7NrQvoAa/PWfLDLeJVNu/bK8U1jtGcpHUHD8Mv7eIBaW3BaPhEYLbEtXQS5RXqns0I5MfOpU1sABl5dhTGrBHYJ8hEbGDzN8KjoJSSXdiTLZN058k/zR/hEnsl6bzcLhZ2jrSo6LaFfnKVgkXRxrqR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+l/BTB0; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+l/BTB0"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef60e500d7so16059307b3.0;
        Fri, 13 Dec 2024 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734113223; x=1734718023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5xb26hD12aHWKTOlfWO8Uk9hIxk2tJj/0+ghr1aXpA=;
        b=M+l/BTB0AHDqJ/eHFnIKA5x+NLN8n34k81mT8yWtVYO69pZzlCOdfRsVLQa/6ZGnke
         YpH1liL33laZfoHNblzkKGAXzW/mFAJS4b9eA53Ha/GL2sMe4N7Camo9LD4Gv7+Uk2/h
         8N4crUk3ZfP1H358zwMR+ZUKStHGqIUhyLwOXZ7MdUQJPNgMBvieTFm3OOVg6NhQJS0d
         rU/36eNCV6VTGB0SvocImzTQeB2iWYyUEcRkkAlG4d1amRv2VsR8CJyPDbSFcarnRHoC
         fntGMLEN6i7oWyW7sv6kBehM8cjMQR8r33Q8HvpeiTKLExrUTO1g4mpRa4plEJxVjDmH
         GkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113223; x=1734718023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5xb26hD12aHWKTOlfWO8Uk9hIxk2tJj/0+ghr1aXpA=;
        b=HXjyIJ59aZd5qwnIkazFKthOe3TARVtNgqEei9keEAdq3JupVPCMWpiHml448zd1Ls
         WilyHjJ3GHdDcMpOPL+2B9Nv3hdEc7l3vKZDJl6pzHTxT4kTq7bYg7qcGKh5QR2FrW3W
         SQPZWFYfL2g/tMGIY+OGDctRyrOdgODl4dJFz2O56t1aXW3B1KKKew7TJfWP+pxxD7V4
         hfO4uYDlMB7On7F5RgBVXvVEp8kqolxVhTiG3ebYkIgqGoL5I2pwBS8oRQlsPoalgX6T
         FsFmt59QBUcNYYp316EYTOZER9zM1DHxrFooaW5BoruRFqExDbq/Uz+JgkK6AbrwMjiu
         jLsA==
X-Forwarded-Encrypted: i=1; AJvYcCVDYCEyV5pn2mmxKE6OME2w7uc7VkWLN35/u11Ev3WZStqdynRmJ7kslf29c/sXY7jmnNFyYrS24FVErHk=@vger.kernel.org, AJvYcCXI4wA1EWqq1lWK5V14bGSi3H0CjQuYmOtQvR31Kgp7mpeQ3bBx9W8LCCc3XYRyGMmnMfmc2A87APetpiaTaO/6lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrjva6PgSAuIpVG/wN8QOHxH1TWCRZC4Ih1/DHu7JEeIM3Gs7
	pfWQjxEX93ruKSKGfeH2oYw7Iy6L4LYyNBQ+WimDkNhhxo/fi7ZnuosDambHuoja/kUPcaEeuAz
	V9qie67KnnG9DqBOhp7qlArPxbcYEPwb8Weo=
X-Gm-Gg: ASbGncs0lFilKz+sQ5JJbh72/JpLfjRT/X5i85kDOKnRQL4zqNwNcfg3n8rxv4hi9gW
	SkbUAgq0B9BjeD+iM+2npGVKLM7nmi2DLLhHj
X-Google-Smtp-Source: AGHT+IEU/Pl66E2SGbCipCacLGs2IlPhoT5fb9enrA2EO5P5qYiujXvFk6Y8kq43fObhg6+YWse1ZKwyPwrBWiCX8CM=
X-Received: by 2002:a05:690c:60ca:b0:6ea:7afd:d901 with SMTP id
 00721157ae682-6f279b15cdfmr27422567b3.18.1734113223468; Fri, 13 Dec 2024
 10:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
In-Reply-To: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 13 Dec 2024 10:06:56 -0800
Message-ID: <CAH0uvoi6=JmtX2xit9y7+NR5O+1S5zbxWpmLpbzC9+9nrkudHQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Remove return value of trace__fprintf_tp_fields
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Benjamin,

On Thu, Dec 12, 2024 at 7:56=E2=80=AFPM Benjamin Peterson <benjamin@engflow=
.com> wrote:
>
> The return value of this function was meaningless and therefore ignored b=
y
> the caller. Remove it.
>
> Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> ---
> This is a small followup cleanup to my earlier commit 5fb8e56542a3 ("perf
> trace: avoid garbage when not printing a trace event's arguments").
> ---
>  tools/perf/builtin-trace.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..246be66fd59a4b9d76e4d3c42=
b68d0a444ca366a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3022,8 +3022,8 @@ static void bpf_output__fprintf(struct trace *trace=
,
>         ++trace->nr_events_printed;
>  }
>
> -static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel=
 *evsel, struct perf_sample *sample,
> -                                      struct thread *thread, void *augme=
nted_args, int augmented_args_size)
> +static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *=
evsel, struct perf_sample *sample,
> +                                    struct thread *thread, void *augment=
ed_args, int augmented_args_size)
>  {
>         char bf[2048];
>         size_t size =3D sizeof(bf);
> @@ -3088,7 +3088,7 @@ static size_t trace__fprintf_tp_fields(struct trace=
 *trace, struct evsel *evsel,
>                 printed +=3D syscall_arg_fmt__scnprintf_val(arg, bf + pri=
nted, size - printed, &syscall_arg, val);
>         }
>
> -       return printed + fprintf(trace->output, "%.*s", (int)printed, bf)=
;
> +       fprintf(trace->output, "%.*s", (int)printed, bf);
>  }
>
>  static int trace__event_handler(struct trace *trace, struct evsel *evsel=
,
>
> ---
> base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
> change-id: 20241212-void-fprintf_tp_fields-8aaae2f5525f
>
> Best regards,
> --
> Benjamin Peterson <benjamin@engflow.com>
>
>

Thank you for the follow-up patch, LGTM. Built and tested.

perf $ ./perf test "perf trace"
109: perf trace enum augmentation tests                              : Ok
110: perf trace exit race                                            : Ok

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
