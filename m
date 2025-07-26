Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5015E8B
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492667; cv=none; b=IFzsNHubMdtcrwOE6EfqTI0GDGrVKTYX8WEZm9NezbMPcyUuIThQV0nMASRs6HcVOUpqpeHG9o7rc0yvW8S2ImD9g6jJO6t+VRv/E7NMowFYYlaZtQN0ow0g9T0gmslvcRMOYambN8UCXb16XtHrgKmKphW5a2fI3/3n/luYCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492667; c=relaxed/simple;
	bh=rBuXP11cTTAHJUew+WFT5v30X/Kyh5kYLAanwOrwuHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBt2cYghQiIzw3PQxysOMBhHIKuLTsLKSEe+ZmpjoF1+eu1J6PLk3YX7zFc+LU4Zy3Bwe6kjYuWOQVEBIPW3RnamXBYVhqaLxgzYFvTghGtcV6HMNSh3ECkFmmEzFWeMmLKVda1PYdu5AhxlktP4E2rjLJsgJU6lU96ZS+iNvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGzzmP4z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGzzmP4z"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2357c61cda7so41785ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753492665; x=1754097465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CzE9BhxSNhTzmTStidUkVVAUXhRg6U5w11hY/7VMWA=;
        b=ZGzzmP4z+ozzOD6iZlJhDd9XTPcVj9mfIxs13Y3LuoiBX7ZNwlTPJKuV7Gt0jcuakK
         NQ9/WpWwNLtFJeX/zjzX3+wt8h+F2DWIF2QZN3HS3mxHoYSWraGW5JyMu5Z7n5jdnowS
         RVlwYB/QDwUMhKoeY49+pFxe3qSc5n2+KxXOZz/tADLLynu/d1VEN45nWePqUbDDrmWw
         9ZEliS5aS2AoR/S8EWUBmWpqrfOxm2N77d4YgfOBnBXmbDX3Q8B8rHxUlo4NqKdt2O47
         PcmkO++cm7exZMqDXvBaLBAHrcTtk7Io3WpSIcaz/IMT7xaspLR8gT+B+Y7kk06UWBxI
         Cw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753492665; x=1754097465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CzE9BhxSNhTzmTStidUkVVAUXhRg6U5w11hY/7VMWA=;
        b=FyXE2CMF9Phm4ljUPReN2N30KIgLkT8Q+zhVGBN8V2Ft824Am5cm5YZnMQrReTSelP
         67cw+08YIkooWoBkQoQHewoYoaT53GUDCWpCUv4i7+lTW6cwWpP6i+1PK0wijKgLVWfo
         MhKHz5PWA9b3HE2TFAURrTqs1cYuwTERkcynAWxfsFE8K2jDxk540Hria0j7cPTx7/xl
         ABC0rBA0d58yVdF3HUuEIUesCzMHTrwCp8EiplqHPCEg6ufnEdcE0a+hFqVjueuf+sp6
         7Xexe4amqWFTtf/0hqUbe7aOQkravd6WbGyJWMQ23n6oAHmjycpkvr8h/B6GHzDrVxBi
         GHmw==
X-Forwarded-Encrypted: i=1; AJvYcCVS8S1vDSjJvyk0z7j+miQIF6lf07lq0fgdBur0egJoU9I5zU5JyMCZFm2PBzx+Wx2L91k8fR1ULPFAvz3FTb2m@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGPMLf5sODo1mRdQRDNFUaX9owulnMeTFVVZTPXum/92NWM44
	Ud1OBaq+6KjH/XVATw0XCkvF6otvFLwmJw2CGQZmuSiKsIfaT7QS3/zp4SlzNb7sDUVyd4fJ9o0
	vJOoDj1PK4DZlzZ74Bk0d+y4OT3sLkglF0Qcb6+jg
X-Gm-Gg: ASbGncsOXxGJswWZfIwfw3ACFUx9MoCCc7VUjGCgvx3MAY6i6iRaYQKcCDG48HFgfSR
	zcrm/O1AbWWmFZQm/wss9/Fl9sHCarFF6YpurJ9bPcgUIYvk00LuLONeZ3Fphxyh12qP2oyWy+9
	KfTzcHvM7PRUrrhw3MfloCbDHeLMKXdqs0s3O/kfswxgGjhhIV23lB97htxi9fWIr6CPaLa79op
	DGx8VTR
X-Google-Smtp-Source: AGHT+IGlsvsTsUZQ2soytq96SMI1FjDFWMD3awMjXBXgJZ1qaV2XSIzI6poM9NTHhx1kuOS1iZEJCQ4x8irgTIVL9hE=
X-Received: by 2002:a17:903:2443:b0:22e:4509:cb86 with SMTP id
 d9443c01a7336-23fc5985aa4mr558365ad.19.1753492664646; Fri, 25 Jul 2025
 18:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com> <20250725202809.1230085-4-zecheng@google.com>
In-Reply-To: <20250725202809.1230085-4-zecheng@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 18:17:33 -0700
X-Gm-Features: Ac12FXyB6Dqt3xAkPNOvfvYZcxPt6h8cYTX5xTZF2VEnqGxHIqMsMCp8hmgsGbk
Message-ID: <CAP-5=fWbKj6fjxTccpszgMoVCc17e+2ZmixU5B3W0WU5wo_zDg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] perf dwarf-aux: Better type matching for stack variables
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:28=E2=80=AFPM Zecheng Li <zecheng@google.com> wro=
te:
>
> Utilizes the previous is_breg_access_indirect function to determine if
> the stack location stores the variable itself or the struct it points
> to.
>
> If the DWARF expression shows DW_OP_stack_value without DW_OP_deref, it
> indicates the variable value is the reg + offset itself, and the stack
> location it points to is the dereferenced type.
>
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 814c96ea509f..4039dbd2b8c0 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1635,6 +1635,14 @@ static int __die_collect_vars_cb(Dwarf_Die *die_me=
m, void *arg)
>         if (die_get_real_type(die_mem, &type_die) =3D=3D NULL)
>                 return DIE_FIND_CB_SIBLING;
>
> +       if ((ops->atom =3D=3D DW_OP_fbreg || ops->atom =3D=3D DW_OP_breg7=
) &&

A comment saying the significance of DW_OP_fbreg and DW_OP_breg7 would
be useful, for example, why not DW_OP_breg6? Isn't breg7 going to be
x86 specific?

Thanks,
Ian


> +           dwarf_tag(&type_die) =3D=3D DW_TAG_pointer_type &&
> +           is_breg_access_indirect(ops, nops)) {
> +               /* Get the target type of the pointer */
> +               if (die_get_real_type(&type_die, &type_die) =3D=3D NULL)
> +                       return DIE_FIND_CB_SIBLING;
> +       }
> +
>         vt =3D malloc(sizeof(*vt));
>         if (vt =3D=3D NULL)
>                 return DIE_FIND_CB_END;
> --
> 2.50.1.470.g6ba607880d-goog
>
