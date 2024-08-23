Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69C259C;
	Fri, 23 Aug 2024 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387835; cv=none; b=Hyrgh9uHAthv/pJqPcE1qtIQFdlN2NGXr517UOtZBEX4w+KSUbMnHwxXHpafrEKsY5ggmYRpuUjn15mmBG9IJTgIgFpcmrB0ot7DleQCc/jGLWGEW7sAnFtrobLCcar/pPQNtCM1ihQ97PbNz/Z3IKK00cv2qDe4Yzpi38HFj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387835; c=relaxed/simple;
	bh=LX4zMpTohls5FfLBcVX6NcIiTrVN4Nc4Jle7RZMH650=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTWIy4u/KB4QbuP6Q2u/WAu8Mr1mF1VD3oYpq87bj6+OxwmFwmxTXvRUp2oIEKlnrAbwgb0etg5FSGPuAuSJGfUo8RRWcp47hv7JFaC3eRncOHuCl3KB2GCD5vYeNrJ7Y6y/5IF92xmxktB4QJpMB39iB0l/VMpD34pnv1ByV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPmJteFG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPmJteFG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-691c85525ebso14426847b3.0;
        Thu, 22 Aug 2024 21:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724387833; x=1724992633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KytQ34okvvdFsqpCueFca9Y0YBrkrKwSQvd/YS5Rs5o=;
        b=FPmJteFGuW244pAXbDZL52F/w43S6NWbzafb4ViJg7fFI0YX0WjhIi9HCaD8kydvJp
         93fI/E+/ZlOXaMnubz4/U17wPel7uDtaNZXr0PhzJ6Mem5z8HWpGinZHEc7FO35X7U7z
         pae3M03rMHxex1p26gC32vG0fBpoRWTbOBVQAO71MtGAT6B6VTwHgkJJMdmNWOhu74yJ
         Mmp7dltv9xRCU3QW15t30FRKBKrdQtPB4Fbq/FqKcZXMO9sN5kwSO3SbYLQf/s6HC14N
         YWfGLvwv1cbzbApUQGlx1bEQ6o0d4wYrXWo/60Scx0Uhkh45zzRvviMInT6szu5B14Zu
         S4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724387833; x=1724992633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KytQ34okvvdFsqpCueFca9Y0YBrkrKwSQvd/YS5Rs5o=;
        b=Eqkef6uPdxj8T6Qwpl6+21XDR+mQcdb4KNeql4nqdDgkefu9MvP8s2oKdTJBSKfyZa
         7vT1H5dWa9edTrLwT5FRqup0xMtDGm61daHVu2GBrytaQvLfFVgN56sNpJt+Ujj0tNUD
         Iz7KHB2+C/Hq8jePsH+gHzbBG080Gs0V43/o9PXqkw6zfl5fsghSi+m2eqASDBUkfm3y
         +Q7645LTWW/i131QhHrgBwXcLPrybGWp1avcmcmLVh97MFvRISdj8TnZlLkIvrQLncQf
         SB8VIJl92TFKW+1d70kHl7C9MYAP7RTYpEyQWXfKGy0JCHlv0hXOIiZopxGnOumlZNof
         u1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVdMRYwU6Zh6KsZFnVDCSz8XyEKUYXzSd3a8pX4LZbNsmPUAZtTIRl0z4ks76Mr1XWhrv9DbAdc9i/ljc=@vger.kernel.org, AJvYcCXeRa/Hru/MZ7u11xBoOEmh9z2Icc1CqTAM60/polOviLbSIRPXyQPIj/r90hoVs0XjptwDsBuNEap1Hie1xeR/9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRZKl8aUDM95X3B+ENB0B/x7EKnPn3lpZ+sz1uYqxrL1mZKcE
	xUfyAzsCFEmmkZM/ptHLP9zitmVv9NgAgYOKDmg0BGWAtpnWeKwQkG3PjOP1TyoyBCyr+dByoY7
	rdGY41OP32LhDGDKVM9UHnstnKkKbVqScHyU=
X-Google-Smtp-Source: AGHT+IHthD/MFOGpVlUNXg3rqTpjj+zj2vQIwL/ZKNmJkqsvBB1/4RwRJRgt5vUAKir0L8/F87K1KKzo4QfG+UHS9ks=
X-Received: by 2002:a05:690c:ece:b0:646:25c7:178e with SMTP id
 00721157ae682-6c6247f16b8mr10872457b3.5.1724387833023; Thu, 22 Aug 2024
 21:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-5-howardchu95@gmail.com> <Zse4LR6gtIO8-Fch@x1>
In-Reply-To: <Zse4LR6gtIO8-Fch@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 23 Aug 2024 12:37:01 +0800
Message-ID: <CAH0uvohkLdA5OHWTWqit-6ttd254Sg1vJQBejK+1yzxO7=miJQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] perf trace: Add some string arguments' name in syscall_arg_fmt__init_array()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 6:14=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 15, 2024 at 09:36:20AM +0800, Howard Chu wrote:
> > Add them so that we can augment more strings (which is a file path)
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index e7e8c89d9538..84c7398312d8 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1918,7 +1918,13 @@ syscall_arg_fmt__init_array(struct syscall_arg_f=
mt *arg, struct tep_format_field
> >
> >               if (strcmp(field->type, "const char *") =3D=3D 0 &&
> >                   ((len >=3D 4 && strcmp(field->name + len - 4, "name")=
 =3D=3D 0) ||
> > -                  strstr(field->name, "path") !=3D NULL))
> > +                  strstr(field->name, "path") ||
> > +                  strstr(field->name, "file") ||
> > +                  strstr(field->name, "root") ||
> > +                  strstr(field->name, "key") ||
> > +                  strstr(field->name, "special") ||
> > +                  strstr(field->name, "type") ||
> > +                  strstr(field->name, "description")))
> >                       arg->scnprintf =3D SCA_FILENAME;
> >               else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(=
field->name, "addr"))
> >                       arg->scnprintf =3D SCA_PTR;
>
> Humm?
>
> root@number:~# for field_name in file root key special type description ;=
 do grep "field:.* $field_name\>" /sys/kernel/tracing/events/syscalls/sys_e=
nter_*/format ; done
>
> /sys/kernel/tracing/events/syscalls/sys_enter_msgget/format:    field:key=
_t key;        offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_semget/format:    field:key=
_t key;        offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_shmget/format:    field:key=
_t key;        offset:16;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_quotactl/format:  field:con=
st char * special;     offset:24;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_kcmp/format:      field:int=
 type; offset:32;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_mount/format:     field:cha=
r * type;      offset:32;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_socket/format:    field:int=
 type; offset:24;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_socketpair/format:        f=
ield:int type; offset:24;      size:8; signed:0;
> /sys/kernel/tracing/events/syscalls/sys_enter_syslog/format:    field:int=
 type; offset:16;      size:8; signed:0;
> root@number:~#
>
> Skipping this one. Please ellaborate, what am I missing?

Hello, just some minor changes on your command, if I do:
```
perf $ for field_name in file root key special type description ; do
grep "field:.*char \* .*$field_name\>"
/sys/kernel/tracing/events/syscalls/sys_enter_*/format ; done
/sys/kernel/tracing/events/syscalls/sys_enter_swapoff/format:
field:const char * specialfile;   offset:16;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_swapon/format:
field:const char * specialfile;   offset:16;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_pivot_root/format:
field:const char * new_root;     offset:16;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_fsconfig/format:
field:const char * _key;  offset:32;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_quotactl/format:
field:const char * special;       offset:24;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_add_key/format:
field:const char * _type; offset:16;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_mount/format:
field:char * type;        offset:32;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_request_key/format:field:cons=
t
char * _type;        offset:16;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_add_key/format:
field:const char * _description;  offset:24;      size:8; signed:0;
/sys/kernel/tracing/events/syscalls/sys_enter_request_key/format:field:cons=
t
char * _description; offset:24;      size:8; signed:0;
```

They pop up.

Because it's strstr(), not strcmp(). Do you think we should use
"strstr(field->name, "description") ||" or "strstr(field->name,
"_description") ||"? Please let me know.

Thanks,
Howard

>
> - Arnaldo
